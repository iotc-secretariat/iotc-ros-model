library(data.table)
library(stringr)
library(DBI)
library(RPostgres)

#'The constants holding the name of the latest IOTC_ReferenceData database
#'@export
IOTC_REFERENCE_DATA <- "IOTC_ReferenceData_2026_06_18"

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
connect_to_reference_data <- function(config_file = file.path("./IOTC_ReferenceData-db.json")) {
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
                  function(foreign_key) { FALSE },
                  list(),
                  "ros_common.observation_dataset.id",
                  function(schema, deps) {
                    NULL
                  })
}

link_to_type <- function(schema_and_table) {
  "Code list"
}

link_to_url <- function(schema, table, schema_and_table) {
  sprintf("<a href='#table_%s.%s'>%s</a>", schema, table, schema_and_table)
}

reference_data_db_metadata_report_template_supplier <- function(db_metadata, export_directory = "./RMDs") {
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
    render_template("templates/schema.Rmd.tpl", list(
      schema_name = schema_name,
      schema_anchor = paste0("{#schema_", schema_id, "}"),
      table_sections = paste(table_sections, collapse = "\n\n")
    ))
  })
  file_location <- file.path(export_directory, sprintf("reference_data_metatadata-%s.Rmd", db_metadata$domain()))
  report <- render_template("./templates/report.Rmd.tpl", list(
    title = sprintf("IOTC Reference data Database (version: %s `r timestamp`)", db_metadata$version()),
    sub_title = sprintf("Last updated: %s", db_metadata$last_update()),
    abstract_content = "This document describes the ***IOTC ReferenceData*** database tables.",
    schema_sections = paste(schema_sections, collapse = "\n\n")
  ))
  writeLines(report, file_location)
  file_location
}

reference_data_db_metadata_generate_report_template <- function(version = IOTC_REFERENCE_DATA,
                                                                root_directory = IOTC_REFERENCE_DATA_DB_METADATA_DIRECTORY) {
  print(paste0("Generate report for: ", version, " from: ", root_directory))
  generate_db_metadata_report_template(domain = "ALL",
                                       version = version,
                                       root_directory = root_directory,
                                       db_metadata_supplier = reference_data_db_metadata_create,
                                       db_metadata_report_template_supplier = reference_data_db_metadata_report_template_supplier_ng,
                                       remove_unused_tables = FALSE)
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
                              link_to_type = link_to_type,
                              link_to_url = link_to_url,
                              report_prefix = "IOTC_Reference_data_database",
                              remove_unused_tables = FALSE)
}

