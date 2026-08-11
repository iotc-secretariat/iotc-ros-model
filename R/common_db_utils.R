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
  fwrite(content, file = output_file, sep = ",", sep2 = c("", "\"", ""), quote = "auto", encoding = "UTF-8", bom = TRUE)
}

split_location <- function(value) {
  unlist(strsplit(value, "\\."))
}

read_sql <- function(name) {
  path <- file.path("sql", name)
  if (!file.exists(path)) {
    stop("SQL file not found: ", path, call. = FALSE)
  }
  paste(readLines(path, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
}

get_schemas_description <- function(schema_names, connection_provider) {
  use_connection(connection_provider, function(connection) {
    sql <- read_sql("get_schemas_description.sql")
    result <- query(connection, sql, params = list(schema_names))
    result[, `:=`(schema = schema_name, schema_name = NULL)][, .(
      schema, description)]

  })
}

get_tables_description <- function(schema_names, connection_provider) {
  use_connection(connection_provider, function(connection) {
    sql <- read_sql("get_tables_description.sql")
    result <- query(connection, sql, params = list(schema_names))
    result[, `:=`(schema = schema_name,
                  schema_name = NULL,
                  table = table_name,
                  table_name = NULL)][, .(
      schema, table, description)]
  })
}

get_tables_columns <- function(schema_names, connection_provider) {
  use_connection(connection_provider, function(connection) {
    sql <- read_sql("get_tables_columns.sql")
    result <- query(connection, sql, params = list(schema_names))
    result[, `:=`(schema = schema_name,
                  schema_name = NULL,
                  table = table_name,
                  table_name = NULL,
                  column = column_name,
                  column_name = NULL)][, .(
      schema, table, column, type, mandatory, description)]
  })
}

get_tables_foreign_keys <- function(schema_names, connection_provider) {
  use_connection(connection_provider, function(connection) {
    sql <- read_sql("get_tables_foreign_keys.sql")
    result <- query(connection, sql, params = list(schema_names))
    result[,
      .(
        columns = list(column_name),
        target_schema = first(target_schema),
        target_table = first(target_table),
        target_columns = list(target_column)
      ),
      by = .(schema = schema_name, table = table_name, foreign_key)]
  })
}

get_tables_primary_keys <- function(schema_names, connection_provider) {
  use_connection(connection_provider, function(connection) {
    sql <- read_sql("get_tables_primary_keys.sql")
    result <- query(connection, sql, params = list(schema_names))
    result[, .(primary_key_columns = list(column_name)), by = .(schema = schema_name, table = table_name)]
  })
}

extract_db_metadata <- function(schemas, connection_provider) {
  list(schemas_description = get_schemas_description(schemas, connection_provider),
       tables_description = get_tables_description(schemas, connection_provider),
       tables_columns = get_tables_columns(schemas, connection_provider),
       tables_foreign_keys = get_tables_foreign_keys(schemas, connection_provider),
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
    } else if (x == "tables_foreign_keys") {
      data <- data[, `:=`(columns = vapply(columns, paste, collapse = "|", FUN.VALUE = character(1)),
                          target_columns = vapply(target_columns, paste, collapse = "|", FUN.VALUE = character(1)))]
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
  dependencies <- NULL
  if (file.exists(file.path(output_directory, "dependencies.csv"))) {
    dependencies <- fread(file.path(output_directory, "dependencies.csv"))
  }
  list(schemas_description = fread(file.path(output_directory, "schemas_description.csv"), na.strings = c('', 'NA')),
       tables_description = fread(file.path(output_directory, "tables_description.csv"), na.strings = c('', 'NA')),
       tables_columns = fread(file.path(output_directory, "tables_columns.csv"), na.strings = c('', 'NA')),
       tables_foreign_keys = fread(file.path(output_directory, "tables_foreign_keys.csv"))[, `:=`(columns = strsplit(columns, '\\|'), target_columns = strsplit(target_columns, '\\|'))],
       tables_primary_keys = fread(file.path(output_directory, "tables_primary_keys.csv"))[, primary_key_columns := strsplit(primary_key_columns, '\\|')],
       dependencies = dependencies)
}

load_db_metadata_object <- function(domain,
                                    version,
                                    root_directory,
                                    db_metadata_supplier) {
  db_metadata_supplier(domain, version, root_directory)
}

generate_shell_dependencies <- function(domain,
                                        version,
                                        root_directory,
                                        db_metadata_supplier) {
  db_metadata <- load_db_metadata_object(domain, version, root_directory, db_metadata_supplier)
  write_file(db_metadata$compute_shell_dependencies_table(), file.path(root_directory, "dependencies.csv"))
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
      private$.description <- ifelse(is.na(description) || str_length(description) == 0, NA, description)
      private$.columns <- copy(columns)
      private$.columns[, primary_key := column %in% primary_keys]
      private$.primary_keys <- primary_keys
      private$.dependencies <- copy(dependencies)[, `:=`(column_order = NULL)]
      private$.usages <- copy(usages)[, `:=`(usage_column_order = NULL, column_order = NULL)]
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
    dependencies = function() {
      rbindlist(lapply(self$all_tables(), function(x) { x$dependencies() }))
    },
    usages = function() {
      rbindlist(lapply(self$all_tables(), function(x) { x$usages() }))
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
                          tables_foreign_keys,
                          tables_primary_keys,
                          dependencies_table,
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

      # Normalize mandatory
      tables_columns[, mandatory := mandatory == "YES"]

      # Add foreign_key logical flag on columns
      tables_columns[, foreign_key := FALSE]

      fk_columns <- tables_foreign_keys[
        ,
        .(
          column = unlist(columns)
        ),
        by = .(schema, table)
      ]

      fk_columns <- unique(
        fk_columns,
        by = c("schema", "table", "column")
      )

      if (nrow(fk_columns) > 0) {
        tables_columns[
          fk_columns,
          foreign_key := TRUE,
          on = .(schema, table, column)
        ]
      }

      # Keep database column order, based on existing row order
      column_order <- tables_columns[, .(column, column_order = seq_len(.N)), by = .(schema, table)]

      # Column metadata lookup
      column_flags <- tables_columns[
        ,
        .(
          mandatory,
          primary_key,
          foreign_key
        ),
        by = .(schema, table, column)
      ]

      get_column_flag <- function(schema_name, table_name, column_names, flag_name) {
        values <- column_flags[
          schema == schema_name &
            table == table_name &
            column %in% column_names
        ]

        values <- values[
          match(column_names, column)
        ]

        values[[flag_name]]
      }

      get_column_order <- function(schema_name, table_name, column_names) {
        values <- column_order[
          schema == schema_name &
            table == table_name &
            column %in% column_names
        ]

        values <- values[
          match(column_names, column)
        ]

        values$column_order
      }

      # Dependencies:
      # one row per FK constraint, columns stay as list columns
      dependencies <- copy(tables_foreign_keys)

      dependencies[, table_id := paste(schema, table, sep = ".")]
      dependencies[, target_table_id := paste(target_schema, target_table, sep = ".")]

      dependencies[
        ,
        `:=`(
          mandatory = list(get_column_flag(schema, table, columns[[1]], "mandatory")),
          primary_key = list(get_column_flag(schema, table, columns[[1]], "primary_key")),
          foreign_key = foreign_key,
          target_mandatory = list(get_column_flag(target_schema, target_table, target_columns[[1]], "mandatory")),
          target_primary_key = list(get_column_flag(target_schema, target_table, target_columns[[1]], "primary_key")),
          target_foreign_key = list(get_column_flag(target_schema, target_table, target_columns[[1]], "foreign_key")),
          column_order = min(get_column_order(schema, table, columns[[1]]), na.rm = TRUE)
        ),
        by = seq_len(nrow(dependencies))
      ]

      setorder(dependencies, schema, table, column_order, foreign_key)

      # Reverse usages:
      # target table columns <- usage table columns
      usages <- dependencies[
        ,
        .(
          schema = target_schema,
          table = target_table,
          columns = target_columns,
          table_id = target_table_id,

          mandatory = target_mandatory,
          primary_key = target_primary_key,
          foreign_key = target_foreign_key,

          usage_schema = schema,
          usage_table = table,
          usage_columns = columns,
          usage_table_id = table_id,
          usage_foreign_key = foreign_key,

          usage_mandatory = mandatory,
          usage_primary_key = primary_key,
          usage_column_order = column_order
        )
      ]

      usages[
        ,
        column_order := min(
          get_column_order(schema, table, columns[[1]]),
          na.rm = TRUE
        ),
        by = seq_len(nrow(usages))
      ]

      setorder(usages, schema, table, usage_column_order, usage_foreign_key)

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
      if (is.null(dependencies_table)) {
        dependencies_table <- self$compute_shell_dependencies_table()
      }
      private$.dependencies <- dependencies_table
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
    dependencies_table = function() {
      private$.dependencies
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
    dependencies = function() {
      rbindlist(lapply(self$all_schemas(), function(x) { x$dependencies() }))
    },
    usages = function() {
      rbindlist(lapply(self$all_schemas(), function(x) { x$usages() }))
    },
    data_dependencies_tables = function() {
      data_dependencies <- self$dependencies()[self$column_dependency_filter()(schema) & self$column_dependency_filter()(target_schema)]
      unique(
        data_dependencies[
          ,
          .(
            origin = table_id,
            origin_schema = schema,
            origin_table = table,
            origin_columns = columns,

            target = target_table_id,
            target_schema,
            target_table,
            target_columns,

            foreign_key
          )
        ],
        by = c("origin", "target", "foreign_key")
      )
    },
    generate_dependencies = function() {
      deps <- self$data_dependencies_tables()
      schema_names <- Filter(self$column_dependency_filter(), self$schema_names())
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
    direct_dependencies = function() {
      self$dependencies_table()[direct_dependency]$table_id
    },
    outer_dependencies = function() {
      self$dependencies_table()[outer_dependency]$table_id
    },
    shell_dependencies = function() {
      self$dependencies_table()$table_id
    },
    compute_shell_dependencies_table = function() {
      filter <- self$column_dependency_filter()
      direct <- private$.compute_direct_dependencies()
      outer <- private$.compute_outer_dependencies()
      shell <- private$.compute_shell_dependencies()
      data.table(
        table_id = shell,
        direct_dependency = shell %in% direct,
        outer_dependency = shell %in% outer,
        outer_transitive_dependency = !shell %in% outer & !shell %in% direct & !filter(table_location$new(shell)$schema())
      )[order(table_id)]
    },
    remove_unused_tables = function() {
      table_names_to_keep <- self$shell_dependencies()
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
    # computed dependencies
    .dependencies = NULL,
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
    .compute_direct_dependencies = function() {
      filter <- self$column_dependency_filter()
      all_dependencies <- self$dependencies()
      sort(unique(c(all_dependencies[filter(schema)]$target_table_id, all_dependencies[filter(target_schema)]$table_id)))
    },
    .compute_outer_dependencies = function() {
      filter <- self$column_dependency_filter()
      direct_dependencies <- private$.compute_direct_dependencies()
      Filter(function(x) { !filter(table_location$new(x)$schema()) }, direct_dependencies)
    },
    .compute_shell_dependencies = function() {
      all_dependencies <- self$dependencies()
      # first pass to get direct dependencies
      direct_dependencies <- private$.compute_direct_dependencies()
      # second pass: recurse on direct dependencies to found the hole shell
      recurse <- function(incoming) {
        result <- unique(c(incoming,
                           all_dependencies[table_id %in% incoming]$target_table_id,
                           all_dependencies[target_table_id %in% incoming]$table_id))
        if (length(result) == length(incoming)) {
          return(result)
        }
        recurse(result)
      }

      sort(recurse(direct_dependencies))
    },
    .build_reverse_dependency_tree = function(deps) {
      entry_point <- self$entry_point()
      standalone_tables <- self$standalone_tables()
      entry_point_location <- column_location$new(entry_point)
      entry_point_table_gav <- entry_point_location$table_gav()
      entry_point_column <- entry_point_location$column()
      result <- data.table(
        level = integer(),
        parent_table = character(),
        parent_columns = list(),
        table = character(),
        table_columns = list(),
        foreign_key = character(),
        link_type = character(),
        path = character()
      )

      visited <- character()

      recurse <- function(current_table_gav,
                          current_columns = list(character()),
                          parent_table_gav = NA_character_,
                          parent_columns = list(character()),
                          foreign_key = NA_character_,
                          link_type = NA_character_,
                          level = 0,
                          path = "") {

        result <<- rbind(
          result,
          data.table(
            level = level,
            link_type = link_type,
            parent_table = parent_table_gav,
            parent_columns = parent_columns,
            table = current_table_gav,
            table_columns = current_columns,
            foreign_key = foreign_key,
            path = path
          ),
          fill = TRUE
        )
        # Prevent cycles
        if (current_table_gav %in% visited) {
          return(NULL)
        }
        # Never add a standalone table
        if (current_table_gav %in% standalone_tables) {
          return(NULL)
        }

        visited <<- c(visited, current_table_gav)
        # Find tables depending on current:
        # origin -> target, current is target
        children <- deps[
          target == current_table_gav &
            !origin %in% visited &
            !str_ilike(path, paste0("% ", origin, "%"))
        ]

        link_type <- "←"

        mapply(function(origin,
                        target,
                        origin_columns,
                        target_columns,
                        foreign_key) {
          recurse(
            current_table_gav = origin,
            current_columns = list(origin_columns),
            parent_table_gav = target,
            parent_columns = list(target_columns),
            foreign_key = foreign_key,
            level = level + 1,
            link_type = link_type,
            path = sprintf("%s (%s%s%s)", path, target, link_type, origin)
          )
        }, children$origin, children$target, children$origin_columns, children$target_columns, children$foreign_key)

        # Find tables depended by current:
        # origin -> target, current is origin
        children <- deps[
          origin == current_table_gav &
            !target %in% visited &
            !str_ilike(path, paste0("% ", target, "%"))
        ]

        link_type <- "→"

        mapply(function(origin,
                        target,
                        origin_columns,
                        target_columns,
                        foreign_key) {
          recurse(
            current_table_gav = target,
            current_columns = list(target_columns),
            parent_table_gav = origin,
            parent_columns = list(origin_columns),
            foreign_key = foreign_key,
            level = level + 1,
            link_type = link_type,
            path = sprintf("%s (%s%s%s)", path, origin, link_type, target)
          )
        }, children$origin, children$target, children$origin_columns, children$target_columns, children$foreign_key)
      }

      recurse(
        current_table_gav = entry_point_table_gav,
        current_columns = list(entry_point_column)
      )

      unique(
        result,
        by = c(
          "level",
          "parent_table",
          "table",
          "foreign_key",
          "link_type",
          "path"
        )
      )
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