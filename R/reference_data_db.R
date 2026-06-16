library(data.table)
library(stringr)

#'The constants holding the name of the latest IOTC_ReferenceData database
#'@export
IOTC_REFERENCE_DATA <- "IOTC_ReferenceData_2025_07_23"

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


