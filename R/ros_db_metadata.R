library(data.table)
library(stringr)
library(DT)

#'The constants holding the name of the latest IOTC_Ros database
#'@export
IOTC_ROS <- "IOTC_Ros_3_3_0_2026_04_16"

#'The constants holding the name of schemas used by LL domain.
#'@export
LL_SCHEMAS <- c("ros_meta", "ros_common", "ros_ll")

#'The constants holding the name of schemas used by PS domain.
#'@export
PS_SCHEMAS <- c("ros_meta", "ros_common", "ros_ps")

#'The path of db models
DB_METADATA_DIRECTORY <- file.path("./models", IOTC_ROS)

#' Default time-stamp used to suffix any generated files
#' @export
DEFAULT_TIME_STAMP <- "-2026-05-22"

#' Load db metata files for the given domain.
#'
#' @param domain gear domain (could be LL, PS, GN, PL)
#' @param root_directory root directory of files to load (defaults to \code{\link{DB_METADATA_DIRECTORY}})
#' @return loaded files
#' @export
load_db_metadata <- function(domain, root_directory = DB_METADATA_DIRECTORY) {
  output_directory <- file.path(root_directory, domain)
  list(schemas_comment = fread(file.path(output_directory, "schemas_comment.csv")),
       tables_comment = fread(file.path(output_directory, "tables_comment.csv")),
       tables_columns = fread(file.path(output_directory, "tables_columns.csv")))
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
  files <- load_db_metadata(domain, root_directory)
  use_connection(connection_provider, function(connection) {
    # apply on schemas
    queries <- data.table(files$schemas_comment)[!is.na(comment) & str_length(comment) > 0, sql := sprintf("COMMENT ON SCHEMA %s IS %s;", schema, dbQuoteString(connection, comment))][!is.na(sql)]$sql
    # apply on tables
    queries <- append(queries, data.table(files$tables_comment)[!is.na(comment) & str_length(comment) > 0, sql := sprintf("COMMENT ON TABLE %s.%s IS %s;", schema, table, dbQuoteString(connection, comment))][!is.na(sql)]$sql)
    # apply on columns
    queries <- append(queries, data.table(files$tables_columns)[!is.na(comment) & str_length(comment) > 0, sql := sprintf("COMMENT ON COLUMN %s.%s.%s IS %s;", schema, table, column, dbQuoteString(connection, comment))][!is.na(sql)]$sql)
    if (apply) {
      # Run all queries
      dbWithTransaction(connection, { lapply(queries, function(x) { dbExecute(connection, x) }) })
    }
    queries
  })
}

out_dt <- function(data) {
  datatable(data,
            autoHideNavigation = TRUE,
            rownames = FALSE,
            lazyRender = TRUE,
            fillContainer = FALSE,
            options = list(dom = "t", ordering = FALSE))
}


generate_db_metadata_template <- function(db_metadata, export_directory, template = "./RMDs/ros_metatadata.Rmd") {
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
    # content <- append(content, "")
    for (table in schema$all_tables()) {
      content <- append(content, sprintf("
```{r}
db_table <- db_schema$table('%s')
```
```{r child='ros_metatadata-table.Rmd'}
```
", table$table()))
    }
  }
  writeLines(content, file_location)
  file_location
}

generate_db_metadata_report <- function(domain,
                                        version = IOTC_ROS,
                                        root_directory = DB_METADATA_DIRECTORY,
                                        export_directory = DB_METADATA_DIRECTORY,
                                        timestamp = format_timestamp(Sys.time())) {
  files <- load_db_metadata(domain, root_directory)
  db_metadata <- db_metadata$new(domain, version, withr::with_locale(c(LC_TIME = "C"), format(Sys.time(), '%d %B %Y %H:%M %Z')), files$schemas_comment, files$tables_comment, files$tables_columns)
  template <- generate_db_metadata_template(db_metadata, "./RMDs")
  options(DT.options = list(pageLength = -1))
  file_location <- file.path(export_directory, sprintf("ROS_database_%s%s.html", db_metadata$domain(), timestamp))
  render(template,
         output_format = "html_document",
         output_file = basename(file_location),
         output_dir = dirname(file_location))
}

