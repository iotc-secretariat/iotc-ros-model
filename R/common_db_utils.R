library(data.table)
library(stringr)
library(R6)
library(jsonlite)
library(DBI)
library(RPostgres)

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
#' @param connection_supplier function to get the connection
#' @param code_to_execute the code to execute
#' @return the \code{\link{code_to_execute}} result
#' @export
use_connection <- function(connection_supplier, code_to_execute) {
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

split_location <- function(value) {
  unlist(strsplit(value, "\\."))
}

get_schemas_description <- function(schema_names, connection_provider) {
  use_connection(connection_provider, function(connection) {
    sql <- "
SELECT
    n.nspname AS schema,
    d.description AS description
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

get_tables_description <- function(schema_names, connection_provider) {
  use_connection(connection_provider, function(connection) {
    sql <- "
SELECT
    t.table_schema AS schema,
     t.table_name AS table,
    obj_description(c.oid, 'pg_class') AS description
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
    pgd.description AS description,
    CASE
        WHEN fk.target_schema IS NULL THEN NULL
        ELSE concat(fk.target_schema, '.', fk.target_table, '.', fk.target_column)
    END AS foreign_key
FROM information_schema.columns cols
JOIN pg_namespace ns ON ns.nspname = cols.table_schema
JOIN pg_class tbl ON tbl.relname = cols.table_name AND tbl.relnamespace = ns.oid
JOIN pg_attribute a ON a.attrelid = tbl.oid AND a.attname = cols.column_name
LEFT JOIN pg_description pgd ON pgd.objoid = tbl.oid AND pgd.objsubid = a.attnum
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
    JOIN pg_class src_tbl ON src_tbl.oid = con.conrelid
    JOIN pg_namespace src_ns ON src_ns.oid = src_tbl.relnamespace
    JOIN pg_class target_tbl ON target_tbl.oid = con.confrelid
    JOIN pg_namespace target_ns ON target_ns.oid = target_tbl.relnamespace
    JOIN unnest(con.conkey) WITH ORDINALITY AS src_colnum(attnum, ord) ON TRUE
    JOIN unnest(con.confkey) WITH ORDINALITY AS target_colnum(attnum, ord) ON src_colnum.ord = target_colnum.ord
    JOIN pg_attribute src_col ON src_col.attrelid = src_tbl.oid AND src_col.attnum = src_colnum.attnum
    JOIN pg_attribute target_col ON target_col.attrelid = target_tbl.oid AND target_col.attnum = target_colnum.attnum
    WHERE con.contype = 'f'
) fk
    ON fk.source_schema = cols.table_schema
   AND fk.source_table = cols.table_name
   AND fk.source_column = cols.column_name
WHERE cols.table_schema IN ($1)
  AND a.attnum > 0
  AND tbl.relkind = 'r'
  AND NOT a.attisdropped
ORDER BY cols.table_schema, cols.table_name, cols.ordinal_position"
    query(connection, sql, params = list(schema_names))
  })
}

get_tables_primary_keys <- function(schema_names, connection_provider) {
  use_connection(connection_provider, function(connection) {
    sql <- "
    SELECT
      kcu.table_schema AS schema,
      kcu.table_name AS table,
      kcu.column_name AS column,
      kcu.ordinal_position AS position
    FROM information_schema.table_constraints tc
    JOIN information_schema.key_column_usage kcu
      ON  kcu.constraint_schema = tc.constraint_schema
      AND kcu.constraint_name   = tc.constraint_name
      AND kcu.table_schema      = tc.table_schema
      AND kcu.table_name        = tc.table_name
    WHERE tc.constraint_type = 'PRIMARY KEY'
      AND tc.table_schema IN ($1)
    ORDER BY
      kcu.table_schema,
      kcu.table_name,
      kcu.ordinal_position "
    pk <- query(connection, sql, params = list(schema_names))
    pk[, .(primary_key_columns = list(column)), by = .(schema, table)]
  })
}

extract_db_metadata <- function(schemas, connection_provider) {
  list(schemas_description = get_schemas_description(schemas, connection_provider),
       tables_description = get_tables_description(schemas, connection_provider),
       tables_columns = get_tables_columns(schemas, connection_provider),
       tables_primary_keys = get_tables_primary_keys(schemas, connection_provider))
}

generate_db_metadata <- function(db_metadata, output_directory) {
  if (!dir.exists(output_directory)) {
    dir.create(output_directory, recursive = TRUE)
  }
  invisible(lapply(names(db_metadata), function(x) {
    data <- db_metadata[[x]]
    if (x == "tables_primary_keys") {
      data <- data[, primary_key_columns := vapply(primary_key_columns, paste, collapse = "|", FUN.VALUE = character(1))]
    }
    write_file(data, file.path(output_directory, sprintf("%s.csv", x)))
  }))
}

#' Load all db metata files.
#'
#' @param root_directory root directory of files to load
#' @return loaded files
#' @export
load_db_metadata <- function(output_directory) {
  list(schemas_description = fread(file.path(output_directory, "schemas_description.csv"), na.strings = c('', 'NA')),
       tables_description = fread(file.path(output_directory, "tables_description.csv"), na.strings = c('', 'NA')),
       tables_columns = fread(file.path(output_directory, "tables_columns.csv"), na.strings = c('', 'NA')),
       tables_primary_keys = fread(file.path(output_directory, "tables_primary_keys.csv"))[, primary_key_columns := strsplit(primary_key_columns, '\\|')])
}

load_db_metadata_object <- function(domain,
                                    version,
                                    root_directory,
                                    db_metadata_supplier) {
  db_metadata_supplier(domain, version, root_directory)
}

#' Generate SQL queries to update comments on database, at schema, table and column level.
#'
#' @param root_directory root directory of files to load
#' @param connection_supplier function to get the connection
#' @param apply flag to apply generated sql queries on database (defaults to \code{TRUE})
#' @return generated sql queries
#' @export
apply_comments_on_db <- function(root_directory, connection_provider, apply = TRUE) {
  files <- load_db_metadata(root_directory)
  use_connection(connection_provider, function(connection) {
    # apply on schemas
    queries <- data.table(files$schemas_description)[!is.na(description) & str_length(description) > 0, sql := sprintf("COMMENT ON SCHEMA %s IS %s;", schema, dbQuoteString(connection, description))][!is.na(sql)]$sql
    # apply on tables
    queries <- append(queries, data.table(files$tables_description)[!is.na(description) & str_length(description) > 0, sql := sprintf("COMMENT ON TABLE %s.%s IS %s;", schema, table, dbQuoteString(connection, description))][!is.na(sql)]$sql)
    # apply on columns
    queries <- append(queries, data.table(files$tables_columns)[!is.na(description) & str_length(description) > 0, sql := sprintf("COMMENT ON COLUMN %s.%s.%s IS %s;", schema, table, column, dbQuoteString(connection, description))][!is.na(sql)]$sql)
    if (apply) {
      # Run all queries
      dbWithTransaction(connection, { lapply(queries, function(x) { dbExecute(connection, x) }) })
    }
    queries
  })
}

#' Generate SQL queries to set not-null constraint on the given data.
#'
#' @param data data table with three columns (shcema, table and column)
#' @param connection_supplier function to get the connection
#' @param apply flag to apply generated sql queries on database (defaults to \code{TRUE})
#' @return generated sql queries
#' @export
set_not_null_on_db <- function(data, connection_provider, apply = TRUE) {
  use_connection(connection_provider, function(connection) {
    # generate sql queries
    queries <- data[, sql := mapply(function(schema, table, column) {
      # total_count <- as.integer(query(connection, sprintf("SELECT COUNT(*) AS count FROM %s.%s", schema, table))$count[[1]])
      # if (total_count == 0) {
      #   return(sprintf("ALTER TABLE %s.%s ALTER COLUMN %s SET NOT NULL;", schema, table, column))
      # }
      count <- as.integer(query(connection, sprintf("SELECT COUNT(*) AS count FROM %s.%s WHERE %s IS NULL", schema, table, column))$count[[1]])
      ifelse(count == 0, sprintf("ALTER TABLE %s.%s ALTER COLUMN %s SET NOT NULL;", schema, table, column),
             sprintf("-- Can not set not null constraint on column %s.%s.%s (There is %s row(s) with NULL value).", schema, table, column, count))
    }, schema, table, column)]$sql
    if (apply) {
      # Run all queries
      dbWithTransaction(connection, { lapply(queries, function(x) { dbExecute(connection, x) }) })
    }
    return(queries)
  })
}


table_location <- R6Class(
  "TableLocation",
  public = list(
    initialize = function(gav) {
      stopifnot(!is.na(gav), is.character(gav), nchar(gav) > 0, gav %like% ".+\\..+")
      split2 <- split_location(gav)
      private$.schema <- split2[[1]]
      private$.table <- split2[[2]]
    },
    schema = function() {
      private$.schema
    },
    table = function() {
      private$.table
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
      stopifnot(!is.na(gav), is.character(gav), nchar(gav) > 0, gav %like% ".+\\..+\\..+")
      split <- split_location(gav)
      private$.schema <- split[[1]]
      private$.table <- split[[2]]
      private$.column <- split[[3]]
    },
    schema = function() {
      private$.schema
    },
    table = function() {
      private$.table
    },
    column = function() {
      private$.column
    },
    table_equals = function(table) {
      table == private$table
    },
    schema_equals = function(schema) {
      schema == private$.schema
    },
    table_gav = function() {
      sprintf("%s.%s", self$schema(), self$table())
    },
    gav = function() {
      sprintf("%s.%s.%s", self$schema(), self$table(), self$column())
    }
    # ,
    # print = function(...) {
    #   cat(self$gav())
    #   invisible(self)
    # }
  ),
  private = list(
    # schema name
    .schema = NULL,
    # table name
    .table = NULL,
    # column name
    .column = NULL
  )
)

as.character.TableLocation <- function(x, ...) {
  x$gav()
}

as.character.ColumnLocation <- function(x, ...) {
  x$gav()
}

db_metadata_table <- R6Class(
  "DbMetadataTable",
  public = list(
    initialize = function(schema, table, description, columns, primary_keys, dependencies, usages) {
      stopifnot(!is.na(schema), is.character(schema), nchar(schema) > 0)
      stopifnot(!is.na(table), is.character(table), nchar(table) > 0)
      private$.schema <- schema
      private$.table <- table
      private$.table_location <- table_location$new(sprintf("%s.%s", schema, table))
      private$.description <- ifelse(str_length(description) == 0, NA, description)
      private$.columns <- copy(columns)[, primary_key := column %in% primary_keys]
      private$.primary_keys <- primary_keys
      private$.dependencies <- copy(dependencies)[, primary_key := column %in% primary_keys]
      private$.usages <- copy(usages)[, primary_key := column %in% primary_keys]
    },
    table_description = function() {
      private$.description
    },
    schema = function() {
      private$.schema
    },
    table = function() {
      private$.table
    },
    table_gav = function() {
      private$.table_location$gav()
    },
    table_location = function() {
      private$.table_location
    },
    columns = function() {
      private$.columns
    },
    primary_keys = function() {
      private$.primary_keys
    },
    dependencies = function() {
      private$.dependencies
    },
    usages = function() {
      private$.usages
    }
  ),
  private = list(
    # schema
    .schema = NULL,
    # table
    .table = NULL,
    # table location object
    .table_location = NULL,
    # description
    .description = NULL,
    # columns
    .columns = NULL,
    # primary keys
    .primary_keys = NULL,
    #dependencies
    .dependencies = NULL,
    # usages
    .usages = NULL
  )
)

db_metadata_schema <- R6Class(
  "DbMetadataSchema",
  public = list(
    initialize = function(schema, description, tables) {
      stopifnot(!is.na(schema), is.character(schema), nchar(schema) > 0)
      private$.schema <- schema
      private$.description <- ifelse(str_length(description) == 0, NA, description)
      private$.tables <- tables
    },
    schema = function() {
      private$.schema
    },
    schema_description = function() {
      private$.description
    },
    table_names = function() {
      names(private$.tables)
    },
    tables = function(schema) {
      Filter(function(x) { x$schema() == schema }, private$.tables)
    },
    all_tables = function(tables_names = NULL) {
      if (is.null(tables_names)) {
        private$.tables }
      else {
        Filter(function(x) { x$table_gav() %in% tables_names }, private$.tables)
      }
    },
    table = function(table) {
      unlist(Filter(function(x) { x$table() == table }, private$.tables))[[1]]
    },
    to_table_descriptions = function() {
      rbindlist(lapply(self$all_tables(), function(x) { data.table(schema = x$schema(), table = x$table(), description = ifelse(is.null(x$table_description()), NA, x$table_description())) }))
    },
    columns = function() {
      rbindlist(lapply(self$all_tables(), function(x) { x$columns() }))
    },
    remove_unused_tables = function(tables_to_remove) {
      private$.tables <- Filter(function(x) { !x$table() %in% tables_to_remove }, private$.tables)
      invisible(self)
    }
  ),
  private = list(
    # schema
    .schema = NULL,
    # description
    .description = NULL,
    # tables
    .tables = NULL
  )
)

db_metadata <- R6Class(
  "DbMetadata",
  public = list(
    initialize = function(domain,
                          version,
                          last_update,
                          schemas_description,
                          tables_description,
                          tables_columns,
                          tables_primary_keys,
                          column_dependency_filter,
                          standalone_tables,
                          entry_point,
                          generate_dependencies_tree_function) {
      stopifnot(!is.na(domain), is.character(domain), nchar(domain) > 0)
      private$.domain <- domain
      private$.version <- version
      private$.last_update <- last_update
      private$.column_dependency_filter <- column_dependency_filter
      private$.standalone_tables <- standalone_tables
      private$.entry_point <- entry_point
      private$.generate_dependencies_tree_function <- generate_dependencies_tree_function
      schema_names <- schemas_description$schema
      # Normalize PK list column if needed
      if (nrow(tables_primary_keys) > 0 &&
        is.character(tables_primary_keys$primary_key_columns)) {
        tables_primary_keys[, primary_key_columns := strsplit(primary_key_columns, "|", fixed = TRUE)]
      }

      # Add primary_key logical flag on columns
      tables_columns[, primary_key := FALSE]

      pk_long <- tables_primary_keys[, .(column = unlist(primary_key_columns)), by = .(schema, table)]

      if (nrow(pk_long) > 0) {
        tables_columns[pk_long, primary_key := TRUE, on = .(schema, table, column)]
      }

      # Keep database column order, based on existing row order
      column_order <- tables_columns[, .(column, column_order = seq_len(.N)), by = .(schema, table)]

      # Compute FK table
      fk <- copy(tables_columns[!is.na(foreign_key) & stringr::str_length(foreign_key) > 0])
      fk[, table_id := paste(schema, table, sep = ".")]
      fk[, mandatory := mandatory == "YES"]
      fk[, column_id := paste(schema, table, column, sep = ".")]
      fk[, c("target_schema", "target_table", "target_column") := tstrsplit(foreign_key, ".", fixed = TRUE)]
      fk[, target_table_id := paste(target_schema, target_table, sep = ".")]

      # Add target column metadata
      target_columns <- tables_columns[, .(target_schema = schema,
                                           target_table = table,
                                           target_column = column,
                                           target_mandatory = mandatory == "YES",
                                           target_primary_key = primary_key)]

      fk <- merge(fk, target_columns, by = c("target_schema", "target_table", "target_column"), all.x = TRUE)

      # Outgoing dependencies:
      # current table column -> target table column
      dependencies <- fk[, .(schema,
                             table,
                             column,
                             table_id,
                             mandatory,
                             primary_key,
                             target_schema,
                             target_table,
                             target_column,
                             target_table_id,
                             target_mandatory,
                             target_primary_key)]
      dependencies <- merge(dependencies, column_order, by = c("schema", "table", "column"), all.x = TRUE)
      setorder(dependencies, schema, table, column_order)

      # Reverse usages:
      # target table column <- usage table column
      usages <- fk[, .(schema = target_schema,
                       table = target_table,
                       column = target_column,
                       table_id = target_table_id,

                       mandatory = target_mandatory,
                       primary_key = target_primary_key,

                       usage_schema = schema,
                       usage_table = table,
                       usage_column = column,
                       usage_table_id = table_id,

                       usage_mandatory = mandatory,
                       usage_primary_key = primary_key)]
      usage_column_order <- column_order[, .(usage_schema = schema,
                                             usage_table = table,
                                             usage_column = column,
                                             usage_column_order = column_order)]

      usages <- merge(usages, usage_column_order, by = c("usage_schema", "usage_table", "usage_column"), all.x = TRUE)
      setorder(usages, schema, table, usage_column_order)

      private$.schemas <- lapply(schema_names, function(schema_name) {
        description <- schemas_description[schema == schema_name]$description
        table_description <- tables_description[schema == schema_name]
        table_names <- table_description$table
        columns <- tables_columns[schema == schema_name]
        tables <- lapply(table_names, function(table_name) {
          table_gav <- paste0(schema_name, ".", table_name)
          primary_key_columns <- tables_primary_keys[schema == schema_name & table == table_name]$primary_key_columns
          primary_key_columns <- unlist(primary_key_columns, use.names = FALSE)
          db_metadata_table$new(schema_name,
                                table_name,
                                table_description[table == table_name]$description,
                                columns[table == table_name],
                                primary_key_columns,
                                dependencies[table_id == table_gav],
                                usages[table_id == table_gav])
        })
        names(tables) <- table_names
        db_metadata_schema$new(schema_name, description, tables)
      })
      names(private$.schemas) <- schema_names
    },
    domain = function() {
      private$.domain
    },
    to_domain_report = function() {
      ifelse(private$.domain == "ALL", "", paste0("_", private$.domain))
    },
    version = function() {
      private$.version
    },
    last_update = function() {
      private$.last_update
    },
    column_dependency_filter = function() {
      private$.column_dependency_filter
    },
    standalone_tables = function() {
      private$.standalone_tables
    },
    entry_point = function() {
      private$.entry_point
    },
    entry_point_table_gav = function() {
      column_location$new(self$entry_point())$table_gav()
    },
    db_reverse_dependencies = function() {
      private$.db_reverse_dependencies
    },
    db_reverse_dependencies_tree = function() {
      private$.db_reverse_dependencies_tree
    },
    all_schemas = function() {
      private$.schemas
    },
    all_tables = function(tables_names = NULL) {
      unlist(lapply(self$all_schemas(), function(x) { x$all_tables(tables_names) }))
    },
    schema = function(schema_name) {
      Filter(function(x) { x$schema() == schema_name }, private$.schemas)[[1]]
    },
    schema_names = function() {
      names(private$.schemas)
    },
    to_schema_descriptions = function() {
      schemas <- self$all_schemas()
      data <- lapply(schemas, function(x) { ifelse(is.null(x$schema_description()), NA, x$schema_description()) })
      data <- data.table(names(data), data)
      names(data) <- c("schema", "description")
      data
    },
    to_table_descriptions = function() {
      rbindlist(lapply(self$all_schemas(), function(x) { x$to_table_descriptions() }))
    },
    columns = function() {
      rbindlist(lapply(self$all_schemas(), function(x) { x$columns() }))
    },
    data_dependencies_tables = function() {
      data_dependencies <- self$columns()[self$column_dependency_filter()(foreign_key)]
      unique(data_dependencies[, `:=`(origin = paste0(schema, ".", table, ".", column), target = foreign_key)][, .(origin, target)], by = c("origin", "target"))
    },
    generate_dependencies = function() {
      deps <- self$data_dependencies_tables()
      schema_names <- self$schema_names()
      private$.db_reverse_dependencies <- lapply(schema_names, function(x) {
        private$.generate_dependencies_tree_function(x, deps)
      })
      names(private$.db_reverse_dependencies) <- schema_names
      private$.db_reverse_dependencies <- Filter(Negate(is.null), private$.db_reverse_dependencies)

      schema_names <- names(private$.db_reverse_dependencies)

      private$.db_reverse_dependencies_tree <- lapply(schema_names, function(x) {
        private$.build_reverse_dependency_tree(private$.db_reverse_dependencies[[x]])
      })
      names(private$.db_reverse_dependencies_tree) <- schema_names
    },
    remove_unused_tables = function() {
      stopifnot(!is.null(private$.db_reverse_dependencies_tree))
      table_names_to_keep <- unique(unlist(lapply(private$.db_reverse_dependencies_tree, function(x) {
        unique(append(x[!is.na(parent_table)]$parent_table, x$table))
      })))
      tables_to_keep <- lapply(table_names_to_keep, table_location$new)
      names(tables_to_keep) <- table_names_to_keep
      lapply(self$all_schemas(), function(schema) {
        tables_to_remove <- Filter(function(x) { !paste0(schema$schema(), ".", x) %in% table_names_to_keep }, schema$table_names())
        schema$remove_unused_tables(tables_to_remove)
        tables_to_remove
      })
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
    # funtion to test if a table column can be added to dependencies
    .column_dependency_filter = NULL,
    # standalone tables
    .standalone_tables = NULL,
    # entry point
    .entry_point = NULL,
    # function to generate dependencies tree
    .generate_dependencies_tree_function = NULL,
    # computed dependencies for each schema
    .db_reverse_dependencies = NULL,
    # computed dependencies tree for each schema
    .db_reverse_dependencies_tree = NULL,
    .build_reverse_dependency_tree = function(deps) {
      entry_point <- self$entry_point()
      standalone_tables <- self$standalone_tables()
      result <- data.table(
        level = integer(),
        parent_table = character(),
        parent_column = character(),
        table = character(),
        table_column = character(),
        link_type = character(),
        path = character()
      )

      visited <- character()

      recurse <- function(current,
                          parent = NA_character_,
                          link_type = NA_character_,
                          level = 0,
                          path = "") {

        current_gav <- column_location$new(current)
        current_table_gav <- current_gav$table_gav()

        result <<- rbind(
          result,
          data.table(
            level = level,
            link_type = link_type,
            parent_table = ifelse(is.na(parent), NA_character_, column_location$new(parent)$table_gav()),
            parent_column = ifelse(is.na(parent), NA_character_, column_location$new(parent)$column()),
            table = current_table_gav,
            table_column = current_gav$column(),
            path = path
          )
        )
        # Prevent cycles
        if (current_table_gav %in% visited) {
          return(NULL)
        }
        # Never add a standalone table (could be used by more than one data table)
        if (current_table_gav %in% standalone_tables) {
          return(NULL)
        }

        visited <<- c(visited, current_table_gav)

        # Find tables depending on current
        children <- deps[
          mapply(function(origin, target) {
            origin_table_gav <- column_location$new(origin)$table_gav()
            target_table_gav <- column_location$new(target)$table_gav()
            target_table_gav == current_table_gav &
              !origin_table_gav %in% visited &
              !str_ilike(path, paste0("% ", origin_table_gav, "%"))
          }, origin, target)]
        link_type <- "←"
        mapply(function(origin, target) {
          recurse(
            current = origin,
            parent = target,
            level = level + 1,
            link_type = link_type,
            path = sprintf("%s (%s%s%s)", path, target, link_type, origin)
          )
        }, children$origin, children$target)

        # Find tables depended by current
        children <- deps[
          mapply(function(origin, target) {
            origin_table_gav <- column_location$new(origin)$table_gav()
            target_table_gav <- column_location$new(target)$table_gav()
            origin_table_gav == current_table_gav &
              !target_table_gav %in% visited &
              !str_ilike(target_table_gav, paste0("% ", origin_table_gav, "%"))
          }, origin, target)]
        link_type <- "→"
        mapply(function(origin, target) {
          recurse(
            current = target,
            parent = origin,
            level = level + 1,
            link_type = link_type,
            path = sprintf("%s (%s%s%s)", path, target, link_type, origin)
          )
        }, children$origin, children$target)
      }

      recurse(entry_point)
      unique(result)
    }
  )
)

to_kW <- function(value, unit) {
  switch(
    unit,
    kW = value,
    hp = value * 0.745699872,
    khp = value * 745.699872,
    stop(sprintf("Unsupported unit: %s", unit))
  )
}