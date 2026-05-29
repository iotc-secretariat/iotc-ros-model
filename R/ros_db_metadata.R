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
ROS_ALL_SCHEMAS <- c("ros_meta", "ros_common", "ros_ps", "ros_ll", "ros_pl", "ros_gn")

#'The constants holding the name of schemas used by LL domain.
#'@export
ROS_LL_SCHEMAS <- c("ros_meta", "ros_common", "ros_ll")

#'The constants holding the name of schemas used by PS domain.
#'@export
ROS_PS_SCHEMAS <- c("ros_meta", "ros_common", "ros_ps")

#'The constants holding the name of schemas used by PL domain.
#'@export
ROS_PL_SCHEMAS <- c("ros_meta", "ros_common", "ros_pl")

#'The constants holding the name of schemas used by GN domain.
#'@export
ROS_GN_SCHEMAS <- c("ros_meta", "ros_common", "ros_gn")

#' Default time-stamp used to suffix any generated files
#' @export
DEFAULT_TIME_STAMP <- "2026-05-29"

#'The path of db models
DB_METADATA_DIRECTORY <- file.path("./models", IOTC_ROS)

#'The path of db reports
DB_REPORT_DIRECTORY <- file.path("./reports", IOTC_ROS)

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
  files <- load_db_metadata(domain, root_directory)
  db_metadata$new(domain,
                  version,
                  withr::with_locale(c(LC_TIME = "C"), format(Sys.time(), '%d %B %Y %H:%M %Z')),
                  files$schemas_comment,
                  files$tables_comment,
                  files$tables_columns,
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
    for (db_table in schema$all_tables()) {
      content <- append(content, sprintf("
```{r}
db_table <- db_schema$table('%s')
```
```{r child='ros_metatadata-table.Rmd'}
```", db_table$table()))
    }
    if (!schema$schema() %like% "ros_common|ros_meta") {
      content <- append(content, "
```{r child='ros_metatadata-schema-dependencies.Rmd'}
```")
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
  generate_db_metadata_report(domain = domain,
                              version = version,
                              timestamp = timestamp,
                              root_directory = root_directory,
                              export_directory = export_directory,
                              db_metadata_supplier = ros_db_metadata_create,
                              db_metadata_report_template_supplier = ros_db_metadata_report_template_supplier,
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
# ll_deps <- ll_model$db_reverse_dependencies()
# ll_tree <- ll_model$db_reverse_dependencies_tree()
# ll_unused_tables <- ll_model$remove_unused_tables()

# ros_db_metadata_generate_report(domain = "LL", timestamp = DEFAULT_TIME_STAMP)
