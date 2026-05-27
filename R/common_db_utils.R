library(data.table)
library(stringr)
library(R6)
library(jsonlite)
library(DBI)
library(RPostgres)

#' Connects to an instance of \code{Ros} on a given server machine
#'
#' @param config_file location of the json config file
#' @param client_encoding The character set used by the client (defaults to \code{UTF-8})
#' @return An Sql connection to \code{Ros} database
#' @export
connect_to_ros <- function(config_file = file.path("./ros-db.json"), client_encoding = "UTF-8") {
  config <- fromJSON(config_file)

  DBI::dbConnect(drv = RPostgres::Postgres(),
                 host = config$host,
                 dbname = config$dbname,
                 port = config$ort,
                 user = config$user,
                 password = config$password,
                 client_encoding = client_encoding)
}

#' Performs and SQL query through a provided JDBC connection and return its results as a \code{data.table}
#'
#' @param connection An JDBC connection to a RDBMS server
#' @param query The query to perform
#' @param params optional parameters paseed to the query
#' @return The results of executing \code{query} through \code{connection} as a data table
#' @examples
#' query(connection = DB_IOTC_ROS(), query = "SELECT * FROM V_LEGACY_NC")
#' @export
query <- function(connection, query, params = NULL) {
  data.table(dbGetQuery(connection, query, params))
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

#' Write a csv file (using always the same configuration)
#'
#' @param content (as a \code{data.table} to write
#' @param output_file location of file to write
#' @export
write_file <- function(content, output_file) {
  fwrite(content, file = output_file, sep = ",", sep2 = c("", "\"", ""), quote = "auto", encoding = "UTF-8")
}

split_table_location <- function(value) {
  unlist(strsplit(value, "\\."))
}

split_column_location <- function(value) {
  unlist(strsplit(value, "→"))
}

get_schemas_comment <- function(schema_names, connection_provider) {
  use_connection(connection_provider, function(connection) {
    sql <- "
SELECT
    n.nspname AS schema,
    d.description AS comment
FROM pg_namespace n
LEFT JOIN pg_description d
       ON d.objoid = n.oid
      AND d.classoid = 'pg_namespace'::regclass
      AND d.objsubid = 0
WHERE n.nspname NOT IN ('pg_catalog', 'information_schema') AND n.nspname IN ($1)
ORDER BY n.nspname
"
    query(connection, sql, params = list(schema_names))
  })
}

get_tables_comment <- function(schema_names, connection_provider) {
  use_connection(connection_provider, function(connection) {
    sql <- "
SELECT
    t.table_schema AS schema,
     t.table_name AS table,
    obj_description(c.oid, 'pg_class') AS comment
FROM information_schema.tables t
JOIN pg_class c ON c.relname = t.table_name
JOIN pg_namespace n ON n.oid = c.relnamespace AND n.nspname = t.table_schema
WHERE t.table_schema IN ($1)
  AND t.table_type = 'BASE TABLE'
ORDER BY t.table_name"
    query(connection, sql, params = list(schema_names))
  })
}

get_tables_columns <- function(schema_names, connection_provider) {
  use_connection(connection_provider, function(connection) {
    sql <- "
SELECT
    cols.table_schema AS schema,
    cols.table_name AS table,
    cols.column_name AS column,
    format_type(a.atttypid, a.atttypmod) AS type,
    CASE
        WHEN (NOT cols.is_nullable::boolean) THEN 'YES'
        ELSE 'NO'
    END AS mandatory,
        pgd.description AS comment,
--    fk.constraint_name,
    CASE
        WHEN fk.target_schema IS NULL THEN NULL
        ELSE concat(fk.target_schema, '.', fk.target_table, '→', fk.target_column)
    END AS foreign_key
--    fk.target_schema,
--    fk.target_table,
--    fk.target_column
FROM information_schema.columns cols

JOIN pg_namespace ns
    ON ns.nspname = cols.table_schema

JOIN pg_class tbl
    ON tbl.relname = cols.table_name
   AND tbl.relnamespace = ns.oid

JOIN pg_attribute a
    ON a.attrelid = tbl.oid
   AND a.attname = cols.column_name

LEFT JOIN pg_description pgd
    ON pgd.objoid = tbl.oid
   AND pgd.objsubid = a.attnum
LEFT JOIN (
    SELECT
        con.conname AS constraint_name,
        src_ns.nspname AS source_schema,
        src_tbl.relname AS source_table,
        src_col.attname AS source_column,
        target_ns.nspname AS target_schema,
        target_tbl.relname AS target_table,
        target_col.attname AS target_column

    FROM pg_constraint con
    JOIN pg_class src_tbl
        ON src_tbl.oid = con.conrelid
    JOIN pg_namespace src_ns
        ON src_ns.oid = src_tbl.relnamespace
    JOIN pg_class target_tbl
        ON target_tbl.oid = con.confrelid
    JOIN pg_namespace target_ns
        ON target_ns.oid = target_tbl.relnamespace
    JOIN unnest(con.conkey) WITH ORDINALITY AS src_colnum(attnum, ord)
        ON TRUE
    JOIN unnest(con.confkey) WITH ORDINALITY AS target_colnum(attnum, ord)
        ON src_colnum.ord = target_colnum.ord
    JOIN pg_attribute src_col
        ON src_col.attrelid = src_tbl.oid
       AND src_col.attnum = src_colnum.attnum
    JOIN pg_attribute target_col
        ON target_col.attrelid = target_tbl.oid
       AND target_col.attnum = target_colnum.attnum
    WHERE con.contype = 'f'
) fk
    ON fk.source_schema = cols.table_schema
   AND fk.source_table = cols.table_name
   AND fk.source_column = cols.column_name
WHERE cols.table_schema IN ($1)
--  AND cols.table_name = $2
  AND a.attnum > 0
  AND tbl.relkind = 'r'
  AND NOT a.attisdropped
ORDER BY cols.table_schema, cols.table_name, cols.ordinal_position"
    query(connection, sql, params = list(schema_names))
  })
}

extract_db_metadata <- function(schemas, connection_provider) {
  list(schemas_comment = get_schemas_comment(schemas, connection_provider),
       tables_comment = get_tables_comment(schemas, connection_provider),
       tables_columns = get_tables_columns(schemas, connection_provider))
}

generate_db_metadata <- function(domain, db_metadata, root_directory) {
  output_directory <- file.path(root_directory, domain)
  if (!dir.exists(output_directory)) {
    dir.create(output_directory, recursive = TRUE)
  }
  lapply(names(db_metadata), function(x) { write_file(db_metadata[[x]], file.path(output_directory, sprintf("%s.csv", x))) })
  invisible()
}

#' Load db metata files for the given domain.
#'
#' @param domain gear domain (could be LL, PS, GN, PL)
#' @param root_directory root directory of files to load
#' @return loaded files
#' @export
load_db_metadata <- function(domain, root_directory) {
  output_directory <- file.path(root_directory, domain)
  list(schemas_comment = fread(file.path(output_directory, "schemas_comment.csv")),
       tables_comment = fread(file.path(output_directory, "tables_comment.csv")),
       tables_columns = fread(file.path(output_directory, "tables_columns.csv")))
}

load_db_metadata_object <- function(domain,
                                    version,
                                    root_directory,
                                    db_metadata_supplier) {
  db_metadata_supplier(domain, version, root_directory)
}

#' Generate SQL queries to update comments on database, at schema, table and column level.
#'
#' @param domain gear domain (could be LL, PS, GN, PL)
#' @param root_directory root directory of files to load
#' @param connection_supplier function to get the connection
#' @param apply flag to apply generated sql queries on database (defaults to \code{TRUE})
#' @return generated sql queries
#' @export
apply_comments_on_db <- function(domain, root_directory, connection_provider, apply = TRUE) {
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


build_dependency_tree <- function(deps, entry_point) {

  result <- data.table(
    level = integer(),
    parent = character(),
    table = character(),
    path = character()
  )

  visited <- character()

  recurse <- function(current, parent = NA_character_, level = 0, path = current) {

    result <<- rbind(
      result,
      data.table(
        level = level,
        parent = parent,
        table = current,
        path = path
      )
    )

    # Avoid infinite loops
    if (current %in% visited) {
      return(NULL)
    }

    visited <<- c(visited, current)

    children <- deps[
      origin == current,
      target
    ]

    for (child in children) {

      recurse(
        current = child,
        parent = current,
        level = level + 1,
        path = paste(path, child, sep = " -> ")
      )

    }

  }

  recurse(entry_point)

  result
}

build_reverse_dependency_tree <- function(deps, entry_point, standalone_tables) {

  result <- data.table(
    level = integer(),
    parent = character(),
    table = character(),
    path = character()
  )

  visited <- character()

  recurse <- function(current,
                      parent = NA_character_,
                      level = 0,
                      path = current) {

    result <<- rbind(
      result,
      data.table(
        level = level,
        parent = parent,
        table = current,
        path = path
      )
    )

    # Prevent cycles
    if (current %in% visited) {
      return(NULL)
    }
    # Never add a standalone table (could be used by more than one data table)
    if (current %in% standalone_tables) {
      return(NULL)
    }

    visited <<- c(visited, current)

    # Find tables depending on current
    children <- deps[
      target == current &
        !origin %in% visited &
        !str_ilike(path, paste0("% ", origin, "%")),
      origin
    ]

    for (child in children) {
      recurse(
        current = child,
        parent = current,
        level = level + 1,
        path = paste(path, child, sep = " ← ")
      )
    }

    # Find tables depended by current
    children <- deps[
      origin == current &
        !target %in% visited &
        !str_ilike(target, paste0("% ", origin, "%")),
      target
    ]

    for (child in children) {
      recurse(
        current = child,
        parent = current,
        level = level + 1,
        path = paste(path, child, sep = " → ")
      )
    }
  }

  recurse(entry_point)
  unique(result)
}

table_location <- R6Class(
  "TableLocation",
  public = list(
    initialize = function(gav) {
      stopifnot(!is.na(gav), is.character(gav), nchar(gav) > 0, gav %like% ".+\\..+")
      split2 <- split_table_location(gav)
      private$.schema <- split2[[1]]
      private$.table <- split2[[2]]
    },
    table = function() {
      private$.table
    },
    schema = function() {
      private$.schema
    },
    table_equals = function(table) {
      table == private$table
    },
    schema_equals = function(schema) {
      schema == private$.schema
    },
    gav = function() {
      sprintf("%s.%s", self$schema(), self$table())
    },
    print = function() {
      cat(self$gav())
    }
  ),
  private = list(
    # schema
    .schema = NULL,
    # table name
    .table = NULL
  )
)

column_location <- R6Class(
  "ColumnLocation",
  public = list(
    initialize = function(gav) {
      stopifnot(!is.na(gav), is.character(gav), nchar(gav) > 0, gav %like% ".+\\..+→.+")
      split <- split_column_location(gav)
      private$.table <- table_location$new(split[[1]])
      private$.column <- split[[2]]
    },
    table = function() {
      private$.table
    },
    column = function() {
      private$.column
    },
    table_equals = function(table) {
      table == private$table$table_equals(table)
    },
    schema_equals = function(schema) {
      schema == private$.table$schema_equals(schema)
    },
    gav = function() {
      sprintf("%s→%s", self$table()$gav(), self$column())
    },
    print = function() {
      cat(self$gav())
    }
  ),
  private = list(
    # schema + table name
    .table = NULL,
    # column name
    .column = NULL
  )
)


db_metadata_table <- R6Class(
  "DbMetadataTable",
  public = list(
    initialize = function(schema, table, comment, columns) {
      stopifnot(!is.na(schema), is.character(schema), nchar(schema) > 0)
      stopifnot(!is.na(table), is.character(table), nchar(table) > 0)
      private$.schema <- schema
      private$.table <- table
      private$.table_location <- table_location$new(sprintf("%s.%s", schema, table))
      private$.comment <- ifelse(str_length(comment) == 0, NA, comment)
      private$.columns <- columns
    },
    table_comment = function() {
      private$.comment
    },
    schema = function() {
      private$.schema
    },
    table = function() {
      private$.table
    },
    table_location = function() {
      private$.table_location
    },
    columns = function() {
      private$.columns
    }
  ),
  private = list(
    # schema
    .schema = NULL,
    # table
    .table = NULL,
    # table location object
    .table_location = NULL,
    # comment
    .comment = NULL,
    # columns
    .columns = NULL
  )
)

db_metadata_schema <- R6Class(
  "DbMetadataSchema",
  public = list(
    initialize = function(schema, comment, tables) {
      stopifnot(!is.na(schema), is.character(schema), nchar(schema) > 0)
      private$.schema <- schema
      private$.comment <- ifelse(str_length(comment) == 0, NA, comment)
      private$.tables <- tables
    },
    schema = function() {
      private$.schema
    },
    schema_comment = function() {
      private$.comment
    },
    table_names = function() {
      names(private$.tables)
    },
    tables = function(schema) {
      Filter(function(x) { x$schema() == schema }, private$.tables)
    },
    all_tables = function() {
      private$.tables
    },
    table = function(table) {
      unlist(Filter(function(x) { x$table() == table }, private$.tables))[[1]]
    },
    to_table_comments = function() {
      rbindlist(lapply(self$all_tables(), function(x) { data.table(schema = x$schema(), table = x$table(), comment = ifelse(is.null(x$table_comment()), NA, x$table_comment())) }))
    },
    columns = function() {
      rbindlist(lapply(self$all_tables(), function(x) { x$columns() }))
    }
  ),
  private = list(
    # schema
    .schema = NULL,
    # comment
    .comment = NULL,
    # tables
    .tables = NULL
  )
)

db_metadata <- R6Class(
  "DbMetadata",
  public = list(
    initialize = function(domain, version, last_update, schemas_comment, tables_comment, tables_columns, is_column_code_list_function, is_column_data_function, standalone_tables) {
      stopifnot(!is.na(domain), is.character(domain), nchar(domain) > 0)
      private$.domain <- domain
      private$.version <- version
      private$.last_update <- last_update
      private$.is_column_code_list_function <- is_column_code_list_function
      private$.is_column_data_function <- is_column_data_function
      private$.standalone_tables <- standalone_tables
      schema_names <- schemas_comment$schema
      private$.schemas <- lapply(schema_names, function(schema_name) {
        comment <- schemas_comment[schema == schema_name]$comment
        table_comment <- tables_comment[schema == schema_name]
        table_names <- table_comment$table
        columns <- tables_columns[schema == schema_name]
        columns <- lapply(table_names, function(table_name) {
          db_metadata_table$new(schema_name, table_name, table_comment[table == table_name]$comment, columns[table == table_name])
        })
        names(columns) <- table_names
        db_metadata_schema$new(schema_name, comment, columns)
      })
      names(private$.schemas) <- schema_names
    },
    domain = function() {
      private$.domain
    },
    version = function() {
      private$.version
    },
    last_update = function() {
      private$.last_update
    },
    is_column_code_list_function = function() {
      private$.is_column_code_list_function
    },
    is_column_data_function = function() {
      private$.is_column_data_function
    },
    standalone_tables = function() {
      private$.standalone_tables
    },
    all_schemas = function() {
      private$.schemas
    },
    schema = function(schema_name) {
      Filter(function(x) { x$schema() == schema_name }, private$.schemas)[[1]]
    },
    schema_names = function() {
      names(private$.schemas)
    },
    to_schema_comments = function() {
      schemas <- self$all_schemas()
      data <- lapply(schemas, function(x) { ifelse(is.null(x$schema_comment()), NA, x$schema_comment()) })
      data <- data.table(names(data), data)
      names(data) <- c("schema", "comment")
      data
    },
    to_table_comments = function() {
      rbindlist(lapply(self$all_schemas(), function(x) { x$to_table_comments() }))
    },
    columns = function() {
      rbindlist(lapply(self$all_schemas(), function(x) { x$columns() }))
    },
    data_dependencies_tables = function() {
      data_dependencies <- self$columns()[self$is_column_data_function()(foreign_key)]
      unique(data_dependencies[, `:=`(origin = paste0(schema, ".", table), target = unlist(lapply(foreign_key, function(x) { column_location$new(x)$table()$gav() })))][, .(origin, target)], by = c("origin", "target"))
    }
  ),
  private = list(
    # domain
    .domain = NULL,
    # version
    .version = NULL,
    # last_update
    .last_update = NULL,
    # schemas
    .schemas = NULL,
    # funtion to test if a table column is a foreign key pointing to a code list
    .is_column_code_list_function = NULL,
    # function to test if a table column is a foreign key pointing to a data table
    .is_column_data_function = NULL,
    # standalone tables
    .standalone_tables = NULL
  )
)
