library(DBI)
library(RPostgres)
library(data.table)
library(stringr)

#'The constants holding the name of the latest IOTC_Ros database
#'@export
IOTC_ROS <- "IOTC_Ros_3_3_0_2026_04_16"

#'The path of db models
DB_METADATA_DIRECTORY <- file.path("./models", IOTC_ROS)

#' Connects to an instance of \code{Ros} on a given server machine
#'
#' @param host The server name / IP address (defaults to \code{\link{SERVER_DEFAULT, "localhost}})
#' @param dbname The database name (defaults to \code{Sys.getenv("IOTC_ROS_DB_SERVER", IOTC_ROS)})
#' @param user The username (defaults to the standard one for this specific DB)
#' @param password The password (defaults to the standard one for this specific DB)
#' @param client_encoding The character set used by the client (defaults to \code{UTF-8})
#' @return An Sql connection to \code{Ros} database
#' @export
connect_to_ros <- function(host = Sys.getenv("IOTC_ROS_DB_HOST", "localhost"),
                           port = Sys.getenv("IOTC_ROS_DB_PORT", 5432),
                           dbname = Sys.getenv("IOTC_ROS_DB_NAME", IOTC_ROS),
                           user = Sys.getenv("IOTC_ROS_DB_USER"),
                           password = Sys.getenv("IOTC_ROS_DB_PWD"),
                           client_encoding = "UTF-8") {
  DBI::dbConnect(drv = RPostgres::Postgres(),
                 host = host,
                 dbname = dbname,
                 port = port,
                 user = user,
                 password = password,
                 client_encoding = client_encoding)
}

#' Execute the given code \code{\link{code_to_execute}} which must be a function
#' with one parameter (the connection provided by this function).
#'
#' The connection is released after the code is executed.
#'
#' @param connection_supplier function to get the connection (defaults to \code{\link{connect_to_ros}})
#' @param code_to_execute the code to execute
#' @return the \code{\link{code_to_execute}} result
#' @export
use_connection <- function(connection_supplier = connect_to_ros, code_to_execute) {
  connection <- NULL
  tryCatch({
    connection <- do.call(connection_supplier, args = list())
    code_to_execute(connection)
  }, finally = {
    if (!is.null(connection)) {
      RPostgres::dbDisconnect(connection)
    }
  })
}

#' Generate SQL queries to update comments on database, at schema, table and column level.
#'
#' @param domain gear domain (could be LL, PS, GN, PL)
#' @param root_directory root directory of files to load (defaults to \code{\link{DB_METADATA_DIRECTORY}})
#' @param connection_supplier function to get the connection (defaults to \code{\link{connect_to_ros}})
#' @param apply flag to apply generated sql queries on database (defaults to \code{TRUE})
#' @return generated sql queries
#' @export
apply_comments_on_db <- function(domain, root_directory = DB_METADATA_DIRECTORY, connection_provider = connect_to_ros, apply = TRUE) {
  output_directory <- file.path(root_directory, domain)
  schemas_comment <- fread(file.path(output_directory, "schemas_comment.csv"))
  tables_comment <- fread(file.path(output_directory, "tables_comment.csv"))
  tables_columns <- fread(file.path(output_directory, "tables_column.csv"))
  use_connection(connection_provider, function(connection) {
    # apply on schemas
    queries <- data.table(schemas_comment)[!is.na(comment) & str_length(comment) > 0, sql := sprintf("COMMENT ON SCHEMA %s IS %s;", schema, dbQuoteString(connection, comment))][!is.na(sql)]$sql
    # apply on tables
    queries <- append(queries, data.table(tables_comment)[!is.na(comment) & str_length(comment) > 0, sql := sprintf("COMMENT ON TABLE %s.%s IS %s;", schema, table, dbQuoteString(connection, comment))][!is.na(sql)]$sql)
    # apply on columns
    queries <- append(queries, data.table(tables_columns)[!is.na(comment) & str_length(comment) > 0, sql := sprintf("COMMENT ON COLUMN %s.%s.%s IS %s;", schema, table, column, dbQuoteString(connection, comment))][!is.na(sql)]$sql)
    if (apply) {
      # Run all queries
      dbWithTransaction(connection, { lapply(queries, function(x) { dbExecute(connection, x) }) })
    }
    queries
  })
}


