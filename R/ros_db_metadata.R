library(htmltools)
library(rmarkdown)
library(data.table)
library(stringr)
library(DT)
library(visNetwork)

#'The constants holding the name of the latest IOTC_Ros database
#'@export
IOTC_ROS <- "IOTC_Ros_3_3_0_2026_05_28"

#'The constants holding the name of all schemas of the Ros database
#'@export
ROS_SCHEMAS <- list(
  ALL = c("ros_meta", "ros_common", "ros_ps", "ros_ll", "ros_pl", "ros_gn"),
  LL = c("ros_meta", "ros_common", "ros_ll"),
  PS = c("ros_meta", "ros_common", "ros_ps"),
  PL = c("ros_meta", "ros_common", "ros_pl"),
  GN = c("ros_meta", "ros_common", "ros_gn")
)

#' Default time-stamp used to suffix any generated files
#' @export
DEFAULT_TIME_STAMP <- "2026-05-29"

#'The path of db models
DB_METADATA_DIRECTORY <- file.path("./models", IOTC_ROS)

#'The path of db reports
DB_REPORT_DIRECTORY <- file.path("./doc", IOTC_ROS)

ROS_CODE_LIST_URLS <- fread("./models/ros_code_list_urls.csv")

#' Connects to an instance of \code{Ros} on a given server machine
#'
#' @param config_file location of the json config file
#' @param client_encoding The character set used by the client (defaults to \code{UTF-8})
#' @return An Sql connection to \code{Ros} database
#' @export
connect_to_ros <- function(config_file = file.path("./ros-db.json"), dbname = IOTC_ROS, client_encoding = "UTF-8") {
  config <- fromJSON(config_file)
  DBI::dbConnect(drv = RPostgres::Postgres(),
                 host = config$host,
                 dbname = dbname,
                 port = config$ort,
                 user = config$user,
                 password = config$password,
                 client_encoding = client_encoding)
}

ros_db_metadata_create <- function(domain,
                                   version = IOTC_ROS,
                                   root_directory = DB_METADATA_DIRECTORY) {
  files <- load_db_metadata(root_directory)
  schema_names <- ROS_SCHEMAS[[domain]]
  db_metadata$new(domain,
                  version,
                  withr::with_locale(c(LC_TIME = "C"), format(Sys.time(), '%d %B %Y %H:%M %Z')),
                  files$schemas_comment[schema %in% schema_names],
                  files$tables_comment[schema %in% schema_names],
                  files$tables_columns[schema %in% schema_names],
                  function(foreign_key) { str_length(foreign_key) > 0 & foreign_key %like% "refs_.+" },
                  function(foreign_key) { str_length(foreign_key) > 0 & foreign_key %like% "ros_meta.+" },
                  function(foreign_key) { str_length(foreign_key) > 0 & !foreign_key %like% "refs_.+|ros_meta.+" },
                  list(
                    "ros_meta.observer",
                    "ros_meta.observer_accreditation",
                    "ros_meta.observer_identifier_mapping",
                    "ros_meta.contact",
                    "ros_meta.focal_point",
                    "ros_meta.vessel",
                    "ros_meta.vessel_licensed_target_species"
                  ),
                  "ros_common.observer_data.id",
                  function(schema, deps) {
                    if (schema %like% "ros_common|ros_meta") { return(NULL) }
                    deps[origin %like% sprintf("ros_common.+|%s.+", schema)]
                    # deps
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
                comment = NULL,
                foreign_key = NULL,
                dependency_type = sapply(foreign_key, function(x) {
                  if (is.na(x)) {
                    return(NA_character_)
                  }
                  if (is_column_code_list_function(x)) {
                    return("Code list")
                  }
                  if (is_column_registry_function(x)) {
                    return("Ros registry")
                  }
                  if (is_column_data_function(x)) {
                    return("Ros data")
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
                  if (is_column_code_list_function(x)) {
                    return(sprintf("<a target='_iotc_code_lists' href='%s'>%s</a>", ROS_CODE_LIST_URLS[codelist==table$table_gav()]$codelist_url , table$table_gav()))
                  }
                  if (is_column_registry_function(x) | is_column_data_function(x)) {
                    return(sprintf("<a href='#%s.%s'>%s</a>", table$schema(), table$table(), table$table_gav()))
                  }
                  NA_character_
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
                                                              if (is_column_code_list_function(y)) {
                                                                return(sprintf("<a target='_iotc_code_lists' href='%s'>%s</a>", ROS_CODE_LIST_URLS[codelist==y]$codelist_url , table$table_gav()))
                                                              }
                                                              if (is_column_registry_function(y) | is_column_data_function(y)) {
                                                                gav <- table_location$new(y)
                                                                return(sprintf("<a href='#%s.%s'>%s</a>", gav$schema(), gav$table(), y))
                                                              }
                                                              NA_character_
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

ros_db_metadata_report_template_supplier <- function(db_metadata, export_directory = "./RMDs", template = "./RMDs/ros_metatadata.Rmd") {
  file_location <- file.path(export_directory, sprintf("ros_metatadata-%s.Rmd", db_metadata$domain()))
  if (file.exists(file_location)) {
    file.remove(file_location)
  }
  content <- readLines(template)
  for (schema in db_metadata$all_schemas()) {
    content <- append(content, sprintf("
```{r}
db_schema <- db_metadata$schema('%s')
```

```{r child='ros_metatadata-schema.Rmd'}
```
", schema$schema()))
    if (!schema$schema() %like% "ros_common|ros_meta") {
      content <- append(content, "
```{r child='ros_metatadata-schema-dependencies.Rmd'}
```")
    }
    for (db_table in schema$all_tables()) {
      content <- append(content, sprintf("
```{r}
db_table <- db_schema$table('%s')
```
```{r child='ros_metatadata-table.Rmd'}
```", db_table$table()))
    }
  }
  writeLines(content, file_location)
  file_location
}

ros_db_metadata_generate_report <- function(domain,
                                            version = IOTC_ROS,
                                            timestamp = DEFAULT_TIME_STAMP,
                                            root_directory = DB_METADATA_DIRECTORY,
                                            export_directory = DB_REPORT_DIRECTORY) {
  print(paste0("Generate report for: ", domain))
  generate_db_metadata_report(domain = domain,
                              version = version,
                              timestamp = timestamp,
                              root_directory = root_directory,
                              export_directory = export_directory,
                              db_metadata_supplier = ros_db_metadata_create,
                              db_metadata_report_template_supplier = ros_db_metadata_report_template_supplier,
                              build_tables_dependencies_supplier = build_tables_dependencies,
                              build_tables_usages_supplier = build_tables_usages,
                              report_prefix = "ROS_database",
                              remove_unused_tables = domain != "ALL")
}

# all_model <- ros_db_metadata_create(domain = "ALL", version = IOTC_ROS, root_directory = DB_METADATA_DIRECTORY)
# all_model$generate_dependencies()
# all_deps <- all_model$db_reverse_dependencies()
# all_tree <- all_model$db_reverse_dependencies_tree()
# all_used_tables <- all_model$remove_unused_tables()
#
#
# ll_model <- ros_db_metadata_create(domain = "LL", version = IOTC_ROS, root_directory = DB_METADATA_DIRECTORY)
# ll_model$generate_dependencies()
# ll_unused_tables <- ll_model$remove_unused_tables()
# ll_deps <- ll_model$db_reverse_dependencies()
# ll_tree <- ll_model$db_reverse_dependencies_tree()
#
# ll_tables_dependencies <- build_tables_dependencies(ll_model, "yo.html")
# ll_tables_usages <- build_tables_usages(ll_model, ll_tables_dependencies, "yo.html")

# ll_graph_data <- create_grah_data(ll_tree$ros_ll, "ros_common.observer_data")
# ll_graph_data$columns <- lapply(ll_model$all_tables(ll_table_names), function(x) {x$columns()})
# ros_db_metadata_generate_report(domain = "LL", timestamp = DEFAULT_TIME_STAMP)
