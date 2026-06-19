library(data.table)
library(stringr)
library(DBI)
library(RPostgres)

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
DEFAULT_TIME_STAMP <- "2026-06-18"

#'The path of db models
DB_METADATA_DIRECTORY <- file.path("./models", IOTC_ROS)

#'The path of db reports
DB_REPORT_DIRECTORY <- file.path("./doc", IOTC_ROS)

ROS_CODE_LIST_URLS <- fread("./models/ros_code_list_urls.csv")

#' Connects to an instance of \code{Ros} on a given server machine
#'
#' @param config_file location of the json config file
#' @return An Sql connection to \code{Ros} database
#' @export
connect_to_ros <- function(config_file = file.path("./ros-db.json")) {
  config <- fromJSON(config_file)
  DBI::dbConnect(drv = RPostgres::Postgres(),
                 host = config$host,
                 dbname = config$dbname,
                 port = config$port,
                 user = config$user,
                 password = config$password,
                 client_encoding = config$client_encoding)
}

is_column_code_list_function <- function(foreign_key) { str_length(foreign_key) > 0 & foreign_key %like% "refs_.+" }

is_column_registry_function <- function(foreign_key) { str_length(foreign_key) > 0 & foreign_key %like% "ros_meta.+" }

is_column_data_function <- function(foreign_key) { str_length(foreign_key) > 0 & !foreign_key %like% "refs_.+|ros_meta.+" }

ros_db_metadata_create <- function(domain, version = IOTC_ROS, root_directory = DB_METADATA_DIRECTORY) {
  files <- load_db_metadata(root_directory)
  schema_names <- ROS_SCHEMAS[[domain]]
  db_metadata$new(domain,
                  version,
                  withr::with_locale(c(LC_TIME = "C"), format(Sys.time(), '%d %B %Y %H:%M %Z')),
                  files$schemas_description[schema %in% schema_names],
                  files$tables_description[schema %in% schema_names],
                  files$tables_columns[schema %in% schema_names],
                  files$tables_primary_keys[schema %in% schema_names],
                  function(x) { is_column_registry_function(x) | is_column_data_function(x)},
                  list(
                    "ros_meta.observer",
                    "ros_meta.observer_accreditation",
                    "ros_meta.observer_identifier_mapping",
                    "ros_meta.contact",
                    "ros_meta.focal_point",
                    "ros_meta.vessel",
                    "ros_meta.vessel_licensed_target_species"
                  ),
                  "ros_common.observation_dataset.id",
                  function(schema, deps) {
                    if (schema %like% "ros_common|ros_meta") { return(NULL) }
                    deps[origin %like% sprintf("ros_common.+|%s.+", schema)]
                  })
}

link_to_type <- function(schema_and_table) {
  if (is_column_code_list_function(schema_and_table)) {
    return("Code list")
  }
  if (is_column_registry_function(schema_and_table)) {
    return("Ros registry")
  }
  if (is_column_data_function(schema_and_table)) {
    return("Ros data")
  }
  NA_character_
}

link_to_url <- function(schema, table, schema_and_table) {
  if (is_column_code_list_function(schema_and_table)) {
    return(sprintf("<a target='_iotc_code_lists' href='%s'>%s</a>", ROS_CODE_LIST_URLS[codelist == schema_and_table]$codelist_url, schema_and_table))
  }
  if (is_column_registry_function(schema_and_table) | is_column_data_function(schema_and_table)) {
    return(sprintf("<a href='#table_%s.%s'>%s</a>", schema, table, schema_and_table))
  }
  NA_character_
}

ros_db_metadata_report_template_supplier <- function(db_metadata, export_directory = "./RMDs") {
  schema_sections <- lapply(db_metadata$all_schemas(), function(schema) {
    schema_name <- schema$schema()
    schema_id <- sanitize_id(schema_name)
    table_sections <- lapply(schema$all_tables(), function(table) {
      table_name <- table$table()
      render_template("templates/table.Rmd.tpl", list(
        table_name = table_name,
        table_anchor = paste0("{#table_", schema_id, ".", sanitize_id(table_name), "}")
      ))
    })
    extra_content <- ifelse(!schema$schema() %like% "ros_common|ros_meta", render_template("templates/schema-dependencies.Rmd.tpl", list()), "")
    render_template("templates/schema.Rmd.tpl", list(
      schema_name = schema_name,
      schema_anchor = paste0("{#schema_", schema_id, "}"),
      table_sections = paste(table_sections, collapse = "\n\n"),
      extra_content = extra_content
    ))
  })
  on_all <- db_metadata$domain() == "ALL"
  file_location <- file.path(export_directory, sprintf("ros_metatadata-%s.Rmd", db_metadata$domain()))
  report <- render_template("./templates/report.Rmd.tpl", list(
    title = sprintf("IOTC ROS Database (version: %s `r timestamp`)%s", db_metadata$version(), ifelse(on_all, "", sprintf(" - Domain %s", db_metadata$domain()))),
    sub_title = sprintf("Last updated: %s", db_metadata$last_update()),
    abstract_content = paste0("This document describes the ***ROS*** database tables", ifelse(on_all, ".", sprintf("used by the domain ***%s***.", db_metadata$domain()))),
    schema_sections = paste(schema_sections, collapse = "\n\n")
  ))
  writeLines(report, file_location)
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
                              link_to_type = link_to_type,
                              link_to_url = link_to_url,
                              report_prefix = "ROS_database",
                              remove_unused_tables = domain != "ALL")
}
