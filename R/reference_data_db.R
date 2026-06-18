library(data.table)
library(stringr)

#'The constants holding the name of the latest IOTC_ReferenceData database
#'@export
IOTC_REFERENCE_DATA <- "IOTC_ReferenceData_2025_07_23"

#' Default time-stamp used to suffix any generated files
#' @export
DEFAULT_TIME_STAMP <- "2026-06-18"

#'The constants holding the name of all schemas of the IOTC_ReferenceData database
#'@export
IOTC_REFERENCE_DATA_SCHEMAS <- c("refs_admin",
                                 "refs_biology",
                                 "refs_data",
                                 "refs_fishery",
                                 "refs_fishery_config",
                                 "refs_gis",
                                 "refs_legacy",
                                 "refs_mappings",
                                 "refs_meta",
                                 "refs_socio_economics")

#'The path of db models
IOTC_REFERENCE_DATA_DB_METADATA_DIRECTORY <- file.path("./models", IOTC_REFERENCE_DATA)

#'The path of db reports
IOTC_REFERENCE_DATA_DB_REPORT_DIRECTORY <- file.path("./doc", IOTC_REFERENCE_DATA)

#' Connects to an instance of \code{IOTC_ReferenceData} on a given server machine
#'
#' @param config_file location of the json config file
#' @return An Sql connection to \code{IOTC_ReferenceData} database
#' @export
connect_to_reference_data <- function(config_file = file.path("./IOTC_ReferenceData-prod-db.json")) {
  config <- fromJSON(config_file)
  DBI::dbConnect(drv = RPostgres::Postgres(),
                 host = config$host,
                 dbname = config$dbname,
                 port = config$port,
                 user = config$user,
                 password = config$password,
                 client_encoding = config$client_encoding)
}

reference_data_db_metadata_create <- function(domain = "ALL",
                                              version = IOTC_REFERENCE_DATA,
                                              root_directory = IOTC_REFERENCE_DATA_DB_METADATA_DIRECTORY,
                                              schema_names = IOTC_REFERENCE_DATA_SCHEMAS) {
  files <- load_db_metadata(root_directory)
  db_metadata$new("ALL",
                  version,
                  withr::with_locale(c(LC_TIME = "C"), format(Sys.time(), '%d %B %Y %H:%M %Z')),
                  files$schemas_description[schema %in% schema_names],
                  files$tables_description[schema %in% schema_names],
                  files$tables_columns[schema %in% schema_names],
                  function(foreign_key) { str_length(foreign_key) > 0 },
                  function(foreign_key) { FALSE },
                  function(foreign_key) { FALSE },
                  list(),
                  "ros_common.observation_dataset.id",
                  function(schema, deps) {
                    NULL
                  })
}

dependencies_table <- function(db_table,
                               is_column_code_list_function,
                               is_column_registry_function,
                               is_column_data_function) {
  result <- data.table(db_table$columns())[is_column_code_list_function(foreign_key) |
                                             is_column_registry_function(foreign_key) |
                                             is_column_data_function(foreign_key)]
  result[, `:=`(schema = NULL,
                table = NULL,
                type = NULL,
                description = NULL,
                foreign_key = NULL,
                dependency_type = sapply(foreign_key, function(x) {
                  if (is.na(x)) {
                    return(NA_character_)
                  }
                  if (is_column_code_list_function(x)) {
                    return("Code list")
                  }
                  NA_character_
                }),
                dependency_table_raw = sapply(foreign_key, function(x) {
                  if (is_column_code_list_function(x) |
                    is_column_registry_function(x) |
                    is_column_data_function(x)) {
                    return(column_location$new(x)$table_gav())
                  }
                  NA_character_
                }),
                dependency_table = sapply(foreign_key, function(x) {
                  table <- column_location$new(x)
                  return(sprintf("<a href='#table_%s_%s'>%s</a>", table$schema(), table$table(), table$table_gav()))
                }),
                dependency_column = sapply(foreign_key, function(x) { column_location$new(x)$column() }))]
}

usages_table <- function(db_table,
                         db_tables_dependencies,
                         is_column_code_list_function,
                         is_column_registry_function,
                         is_column_data_function) {
  table_gav <- db_table$table_gav()
  result <- rbindlist(lapply(names(db_tables_dependencies), function(x) {
    t <- db_tables_dependencies[[x]]
    data.table(t[dependency_table_raw == table_gav])[, `:=`(dependency_column = NULL,
                                                            dependency_type = NULL,
                                                            dependency_table_raw = NULL,
                                                            dependency_table = NULL,
                                                            column = dependency_column,
                                                            usage_type = dependency_type,
                                                            usage_table_raw = x,
                                                            usage_table = sapply(x, function(y) {
                                                              gav <- table_location$new(y)
                                                              return(sprintf("<a href='#table_%s_%s'>%s</a>", gav$schema(), gav$table(), y))
                                                            }),
                                                            usage_column = column)]
  }))
}

build_tables_dependencies <- function(db_metadata) {
  is_column_code_list_function <- db_metadata$is_column_code_list_function()
  is_column_registry_function <- db_metadata$is_column_registry_function()
  is_column_data_function <- db_metadata$is_column_data_function()
  lapply(db_metadata$all_tables(), function(x) { dependencies_table(x, is_column_code_list_function, is_column_registry_function, is_column_data_function) })
}

build_tables_usages <- function(db_metadata, db_tables_dependencies) {
  is_column_code_list_function <- db_metadata$is_column_code_list_function()
  is_column_registry_function <- db_metadata$is_column_registry_function()
  is_column_data_function <- db_metadata$is_column_data_function()
  lapply(db_metadata$all_tables(), function(x) { usages_table(x, db_tables_dependencies, is_column_code_list_function, is_column_registry_function, is_column_data_function) })
}

reference_data_db_metadata_report_template_supplier <- function(db_metadata, export_directory = "./RMDs", template = "./RMDs/reference_data_metatadata.Rmd") {
  file_location <- file.path(export_directory, sprintf("reference_data_metatadata-%s.Rmd", db_metadata$domain()))
  if (file.exists(file_location)) {
    file.remove(file_location)
  }
  content <- readLines(template)
  for (schema in db_metadata$all_schemas()) {
    content <- append(content, sprintf("
```{r}
db_schema <- db_metadata$schema('%s')
```

```{r child='reference_data_metatadata-schema.Rmd'}
```
", schema$schema()))
    for (db_table in schema$all_tables()) {
      content <- append(content, sprintf("
```{r}
db_table <- db_schema$table('%s')
```
```{r child='reference_data_metatadata-table.Rmd'}
```", db_table$table()))
    }
  }
  writeLines(content, file_location)
  file_location
}

reference_data_db_metadata_generate_report <- function(version = IOTC_REFERENCE_DATA,
                                                       timestamp = DEFAULT_TIME_STAMP,
                                                       root_directory = IOTC_REFERENCE_DATA_DB_METADATA_DIRECTORY,
                                                       export_directory = IOTC_REFERENCE_DATA_DB_REPORT_DIRECTORY) {
  print(paste0("Generate report for: ", version, " from: ", root_directory))
  generate_db_metadata_report(domain = "ALL",
                              version = version,
                              timestamp = timestamp,
                              root_directory = root_directory,
                              export_directory = export_directory,
                              db_metadata_supplier = reference_data_db_metadata_create,
                              db_metadata_report_template_supplier = reference_data_db_metadata_report_template_supplier,
                              build_tables_dependencies_supplier = build_tables_dependencies,
                              build_tables_usages_supplier = build_tables_usages,
                              report_prefix = "IOTC_Reference_data_database",
                              remove_unused_tables = FALSE)
}

