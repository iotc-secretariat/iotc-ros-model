library(DBI)
library(RPostgres)
library(data.table)

# TODO - Check structure of each code list and if not the same, then block the upserts
# =============================================================================
# ROS Code List Migration Generator
# =============================================================================
#
# Purpose
# -------
#
# Generate SQL migration scripts allowing synchronization of code-list tables
# (schemas matching `refs_*`) from the Reference Data database into the ROS
# database.
#
# The generated SQL is written to files and is never executed directly against
# the target database.
#
# Main features
# -------------
#
# - Detect missing code-list tables in ROS.
# - Generate CREATE SCHEMA and CREATE TABLE statements.
# - Generate primary keys, unique constraints, foreign keys and indexes.
# - Generate table and column comments.
# - Generate INSERT scripts for missing tables.
# - Generate UPSERT scripts for existing tables.
# - Respect foreign-key dependencies between code-list tables.
# - Generate one update script per schema.
#
# Architecture
# ------------
#
# The module is divided into the following parts:
#
# 1. SQL helper functions
#    - identifier quoting
#    - SQL literal generation
#    - table identifier manipulation
#
# 2. Metadata discovery
#    - code-list table discovery
#    - dependency discovery
#    - primary key discovery
#
# 3. DDL generation
#    - CREATE TABLE
#    - constraints
#    - indexes
#    - comments
#
# 4. Data generation
#    - INSERT scripts
#    - UPSERT scripts
#
# 5. Script generators
#    - generate_missing_code_list_tables_script()
#    - generate_existing_code_list_upsert_script()
#
# Dependencies
# ------------
#
# External packages:
#
# - DBI
# - RPostgres
# - data.table
#
# External helper functions:
#
# - use_connection()
# - query()
# - read_sql()
#
# Required SQL files:
#
# - get_code_list_tables.sql
# - get_code_list_tables_dependencies.sql
# - get_table_primary_keys.sql
# - get_table_columns.sql
# - get_table_constraints.sql
# - get_table_indexes.sql
# - get_table_comment.sql
# - get_column_comments.sql
#
# =============================================================================

# -------------------------------------------------------------------
# SQL helpers
# -------------------------------------------------------------------

#' Build a fully qualified table identifier.
#'
#' @param schema Database schema name.
#' @param table Table name.
#'
#' @return A string like `"refs_admin.countries"`.
table_id <- function(schema, table) {
  paste(schema, table, sep = ".")
}

split_table_id <- function(table_id) {
  parts <- strsplit(table_id, "\\.", fixed = FALSE)[[1]]
  list(schema = parts[1], table = parts[2])
}

quote_ident <- function(x) {
  paste0('"', gsub('"', '""', x), '"')
}

quote_table <- function(schema, table) {
  paste(quote_ident(schema), quote_ident(table), sep = ".")
}

quote_value <- function(x) {
  if (is.na(x)) {
    "NULL"
  } else if (inherits(x, "Date")) {
    paste0("'", format(x, "%Y-%m-%d"), "'")
  } else if (inherits(x, "POSIXt")) {
    paste0("'", format(x, "%Y-%m-%d %H:%M:%S%z"), "'")
  } else if (is.logical(x)) {
    ifelse(x, "TRUE", "FALSE")
  } else if (is.numeric(x)) {
    as.character(x)
  } else {
    paste0("'", gsub("'", "''", as.character(x)), "'")
  }
}

get_primary_key_columns <- function(connection_provider, schema, table) {
  use_connection(connection_provider, function(connection) {
    sql <- read_sql("get_table_primary_keys.sql")
    result <- query(connection, sql, params = list(schema, table))
    result$column_name
  })
}

get_code_list_tables_dependencies <- function(connection_provider) {
  use_connection(connection_provider, function(connection) {
    sql <- read_sql("get_code_list_tables_dependencies.sql")
    result <- query(connection, sql, params = list("refs_%"))
  })
}

get_tables_used_by_views <- function(connection_provider) {
  use_connection(connection_provider, function(connection) {
    sql <- read_sql("get_tables_used_by_views.sql")
    result <- query(connection, sql, params = list("ros_%"))
    result[!table_name %like% "v_.+"][, `:=`(schema = table_schema, table_schema = NULL, table = table_name, table_name = NULL)]
  })
}

get_table_structure <- function(connection_provider, schema, table) {
  use_connection(connection_provider, function(connection) {
    sql <- read_sql("get_table_structure.sql")
    result <- query(connection, sql, params = list(schema, table))
    result
  })
}
check_same_table_structure <- function(
    reference_data_connection_provider,
    ros_connection_provider,
    schema,
    table,
    check_order = FALSE
) {
  format_value <- function(x) {
    if (length(x) == 0 || is.na(x)) "NULL" else as.character(x)
  }

  format_type <- function(row) {
    type <- row$data_type

    if (type %in% c("character varying", "character") &&
        !is.na(row$character_maximum_length)) {
      type <- paste0(type, "(", row$character_maximum_length, ")")
    }

    if (type == "numeric" && !is.na(row$numeric_precision)) {
      if (!is.na(row$numeric_scale)) {
        type <- paste0(type, "(", row$numeric_precision, ",", row$numeric_scale, ")")
      } else {
        type <- paste0(type, "(", row$numeric_precision, ")")
      }
    }

    type
  }

  format_column_definition <- function(row) {
    paste0(
      row$column_name,
      " ",
      format_type(row),
      if (is_nullable(row$is_nullable)) " NULL" else " NOT NULL"
    )
  }

  is_nullable <- function(x) {
    value <- toupper(as.character(x))

    if (value %in% c("YES", "TRUE", "T", "1")) return(TRUE)
    if (value %in% c("NO", "FALSE", "F", "0")) return(FALSE)

    stop("Unsupported is_nullable value: ", x)
  }

  same_value <- function(a, b) {
    if (length(a) == 0 && length(b) == 0) return(TRUE)
    if (length(a) == 0 || length(b) == 0) return(FALSE)
    if (is.na(a) && is.na(b)) return(TRUE)
    identical(a, b)
  }

  ref <- get_table_structure(reference_data_connection_provider, schema, table)
  ros <- get_table_structure(ros_connection_provider, schema, table)

  if (nrow(ref) == 0) {
    return(list(
      ok = FALSE,
      table_id = paste(schema, table, sep = "."),
      messages = paste0("Reference Data table not found or has no columns: ", schema, ".", table),
      sql = character()
    ))
  }

  if (nrow(ros) == 0) {
    return(list(
      ok = FALSE,
      table_id = paste(schema, table, sep = "."),
      messages = paste0("ROS table not found or has no columns: ", schema, ".", table),
      sql = character()
    ))
  }

  ref_cols <- ref$column_name
  ros_cols <- ros$column_name

  columns_to_add_in_ros <- setdiff(ref_cols, ros_cols)
  columns_to_remove_from_ros <- setdiff(ros_cols, ref_cols)
  common_cols <- intersect(ref_cols, ros_cols)

  compare_fields <- c(
    "data_type",
    "udt_name",
    "character_maximum_length",
    "numeric_precision",
    "numeric_scale",
    "datetime_precision",
    "is_nullable"
  )

  if (check_order) {
    compare_fields <- c(compare_fields, "ordinal_position")
  }

  messages <- character()
  sql_fix <- character()
  columns_to_change_in_ros <- list()

  for (column in columns_to_add_in_ros) {
    row <- ref[column_name == column]

    messages <- c(
      messages,
      "",
      "Columns to ADD in ROS:",
      paste0("  + ", format_column_definition(row))
    )

    sql_fix <- c(
      sql_fix,
      sprintf(
        "ALTER TABLE %s ADD COLUMN %s %s%s;",
        quote_table(schema, table),
        quote_ident(column),
        format_type(row),
        if (!is_nullable(row$is_nullable)) " NOT NULL" else ""
      )
    )
  }

  for (column in columns_to_remove_from_ros) {
    row <- ros[column_name == column]

    messages <- c(
      messages,
      "",
      "Columns to REMOVE from ROS:",
      paste0("  - ", format_column_definition(row))
    )

    sql_fix <- c(
      sql_fix,
      sprintf(
        "ALTER TABLE %s DROP COLUMN %s;",
        quote_table(schema, table),
        quote_ident(column)
      )
    )
  }

  for (column in common_cols) {
    ref_row <- ref[column_name == column]
    ros_row <- ros[column_name == column]

    field_differences <- list()
    type_change_needed <- FALSE

    for (field in compare_fields) {
      ref_value <- ref_row[[field]]
      ros_value <- ros_row[[field]]

      if (!same_value(ref_value, ros_value)) {
        field_differences[[field]] <- list(
          current = ros_value,
          expected = ref_value
        )

        if (field %in% c(
          "data_type",
          "udt_name",
          "character_maximum_length",
          "numeric_precision",
          "numeric_scale",
          "datetime_precision"
        )) {
          type_change_needed <- TRUE
        }
      }
    }

    if (length(field_differences) > 0) {
      columns_to_change_in_ros[[column]] <- field_differences
    }

    if (type_change_needed) {
      sql_fix <- c(
        sql_fix,
        sprintf(
          "ALTER TABLE %s ALTER COLUMN %s TYPE %s;",
          quote_table(schema, table),
          quote_ident(column),
          format_type(ref_row)
        )
      )
    }

    if ("is_nullable" %in% names(field_differences)) {
      current_nullable <- is_nullable(field_differences$is_nullable$current)
      expected_nullable <- is_nullable(field_differences$is_nullable$expected)

      if (current_nullable && !expected_nullable) {
        sql_fix <- c(
          sql_fix,
          sprintf(
            "ALTER TABLE %s ALTER COLUMN %s SET NOT NULL;",
            quote_table(schema, table),
            quote_ident(column)
          )
        )
      }

      if (!current_nullable && expected_nullable) {
        sql_fix <- c(
          sql_fix,
          sprintf(
            "ALTER TABLE %s ALTER COLUMN %s DROP NOT NULL;",
            quote_table(schema, table),
            quote_ident(column)
          )
        )
      }
    }
  }

  if (length(columns_to_change_in_ros) > 0) {
    messages <- c(messages, "", "Columns to CHANGE in ROS:")

    for (column in names(columns_to_change_in_ros)) {
      messages <- c(messages, "", paste0("  * ", column))

      for (field in names(columns_to_change_in_ros[[column]])) {
        diff <- columns_to_change_in_ros[[column]][[field]]

        messages <- c(
          messages,
          paste0(
            "      ",
            field,
            ": current ROS = ",
            format_value(diff$current),
            " | expected Reference Data = ",
            format_value(diff$expected)
          )
        )
      }
    }
  }

  ok <- length(messages) == 0

  list(
    ok = ok,
    table_id = paste(schema, table, sep = "."),
    messages = messages,
    sql = sql_fix
  )
}

generate_drop_views_script <- function(connection_provider, schemas, output_file) {
  views <- use_connection(connection_provider, function(connection) {
    query(
      connection,
      "
      SELECT table_schema AS schema, table_name
      FROM information_schema.views
      WHERE table_schema IN ($1)
      ORDER BY table_name
      ",
      params = list(schemas)
    )
  })

  sql <- c(
    paste0("-- Drop all views from schemas ", paste(schemas, collapse = ", ")),
    paste0("-- Generated at ", Sys.time()),
    ""
  )

  if (nrow(views) == 0) {
    sql <- c(sql, "-- No views found")
  } else {
    sql <- c(
      sql,
      sprintf(
        "DROP VIEW IF EXISTS %s.%s CASCADE;",
        quote_ident(views$schema),
        quote_ident(views$table_name)
      )
    )
  }
  writeLines(sql, output_file)
  invisible(views)
}

generate_drop_unused_code_list_table <- function(output_directory, connection_provider, output_file) {
  code_lists_tables_required <- load_db_metadata(output_directory)$dependencies[table_id %like% "refs_.+"][, `:=`(
    schema = mapply(function(x) { table_location$new(x)$schema() }, table_id),
    table = mapply(function(x) { table_location$new(x)$table() }, table_id))][, .(schema, table)]
  blocked_code_list_tables <- get_tables_used_by_views(connection_provider)
  blocked_code_list_tables <- unique(blocked_code_list_tables[, .(schema, table)])
  code_lists_tables_required <- rbind(code_lists_tables_required, blocked_code_list_tables, data.table(schema = c("refs_meta"), table = c("codelists_versions")))
  code_list_tables_found <- get_code_list_tables(connection_provider)
  code_list_tables_to_remove <- code_list_tables_found[!code_lists_tables_required, on = .(schema, table)]
  code_list_tables_to_remove_sorted <- sort_code_list_tables_to_update(connection_provider, code_list_tables_to_remove)
  sql <- c(
    "-- Generated ROS refs_* remove unused tables script",
    paste0("-- Generated at: ", format(Sys.time(), "%Y-%m-%d %H:%M:%S %z")),
    ""
  )

  if (nrow(code_list_tables_to_remove_sorted) == 0) {
    sql <- c(sql, "-- No refs_* tables found to remove.", "")
    writeLines(sql, output_file)
    return(invisible(code_list_tables_to_remove_sorted))
  }

  for (i in seq_len(nrow(code_list_tables_to_remove_sorted))) {
    schema <- code_list_tables_to_remove_sorted$schema[i]
    table <- code_list_tables_to_remove_sorted$table[i]

    message("DROP table: ", schema, ".", table)

    sql <- c(
      sql,
      "-- ----------------------------------------------------------------",
      paste0("-- ", schema, ".", table),
      "-- ----------------------------------------------------------------",
      paste0("DROP TABLE ", schema, ".", table, ";"),
      ""
    )
  }

  writeLines(sql, output_file)
  invisible(code_list_tables_to_remove_sorted)
}

sort_tables_by_dependencies <- function(tables, dependencies) {
  tables <- copy(tables)
  dependencies <- copy(dependencies)
  tables[, id := table_id(schema, table)]

  dependencies[, source_id := table_id(source_schema, source_table)]
  dependencies[, target_id := table_id(target_schema, target_table)]

  # Keep only dependencies where both tables are in the selected list
  dependencies <- dependencies[
    source_id %in% tables$id &
      target_id %in% tables$id &
      source_id != target_id
  ]

  remaining <- copy(tables)
  ordered <- character()

  while (nrow(remaining) > 0) {

    remaining_ids <- remaining$id

    blocked <- dependencies[
      source_id %in% remaining_ids &
        target_id %in% remaining_ids,
      unique(source_id)
    ]

    ready <- remaining[!id %in% blocked]

    if (nrow(ready) == 0) {
      stop(
        "Circular dependency detected between refs_* tables: ",
        paste(remaining$id, collapse = ", ")
      )
    }

    ready <- ready[order(schema, table)]

    ordered <- c(ordered, ready$id)

    remaining <- remaining[!id %in% ready$id]
  }

  result <- data.table(id = ordered)

  result[, schema := vapply(strsplit(id, "\\."), `[`, character(1), 1)]
  result[, table := vapply(strsplit(id, "\\."), `[`, character(1), 2)]
  result[, id := NULL]

  result[]
}

# ================================================================
# Discovery
# ================================================================

get_code_list_tables <- function(connection_provider,
                                 schema_excluder = function(schema) { FALSE }) {
  use_connection(connection_provider, function(connection) {
    sql <- read_sql("get_code_list_tables.sql")
    result <- query(connection, sql)
    result[!schema_excluder(schema_name)][, `:=`(schema = schema_name, schema_name = NULL, table = table_name, table_name = NULL)]
  })
}

detect_missing_refs_tables <- function(reference_data_connection_provider,
                                       ros_connection_provider,
                                       schema_excluder = function(schema) { FALSE }) {
  reference_data_tables <- get_code_list_tables(reference_data_connection_provider, schema_excluder)
  ros_tables <- get_code_list_tables(ros_connection_provider, schema_excluder)
  missing <- reference_data_tables[!ros_tables, on = c("schema", "table")]
  missing[]
}

detect_existing_refs_tables <- function(reference_data_connection_provider,
                                        ros_connection_provider,
                                        schema_excluder = function(schema) { FALSE },
                                        table_excluder = function(schema, table) { FALSE }) {
  reference_data_tables <- get_code_list_tables(reference_data_connection_provider, schema_excluder)[!table_excluder(schema, table)]
  ros_tables <- get_code_list_tables(ros_connection_provider, schema_excluder)[!table_excluder(schema, table)]
  reference_data_tables[
    ros_tables,
    on = c("schema", "table")
  ][]
}

# -------------------------------------------------------------------
# Generate CREATE TABLE
# -------------------------------------------------------------------

# ================================================================
# Columns / CREATE TABLE
# ================================================================

get_columns <- function(connection_provider, schema, table) {
  use_connection(connection_provider, function(connection) {
    sql <- read_sql("get_table_columns.sql")
    result <- query(connection, sql, params = list(schema, table))
    result
  })
}

format_column_type <- function(row) {
  data_type <- row$data_type

  if (data_type == "character varying") {
    sprintf("varchar(%s)", row$character_maximum_length)

  } else if (data_type == "character") {
    sprintf("char(%s)", row$character_maximum_length)

  } else if (data_type == "numeric" && !is.na(row$numeric_precision)) {
    if (!is.na(row$numeric_scale)) {
      sprintf("numeric(%s,%s)", row$numeric_precision, row$numeric_scale)
    } else {
      sprintf("numeric(%s)", row$numeric_precision)
    }

  } else if (data_type == "timestamp without time zone") {
    "timestamp without time zone"

  } else if (data_type == "timestamp with time zone") {
    "timestamp with time zone"

  } else if (data_type == "time without time zone") {
    "time without time zone"

  } else if (data_type == "time with time zone") {
    "time with time zone"

  } else if (data_type == "USER-DEFINED") {
    quote_ident(row$udt_name)

  } else {
    data_type
  }
}

generate_create_table_sql <- function(connection_provider, schema, table) {
  columns <- get_columns(connection_provider, schema, table)

  column_lines <- apply(columns, 1, function(row) {
    row <- as.list(row)

    line <- paste(
      quote_ident(row$column_name),
      format_column_type(row)
    )

    if (!is.na(row$column_default)) {
      line <- paste(line, "DEFAULT", row$column_default)
    }

    if (row$is_nullable == "NO") {
      line <- paste(line, "NOT NULL")
    }

    line
  })

  c(
    sprintf("CREATE SCHEMA IF NOT EXISTS %s;", quote_ident(schema)),
    "",
    sprintf("CREATE TABLE %s (", quote_table(schema, table)),
    paste0("  ", column_lines, collapse = ",\n"),
    ");"
  )
}

# ================================================================
# Constraints
# ================================================================

get_constraints <- function(connection_provider, schema, table, types = c("p", "u", "f")) {
  # type_sql <- paste(sprintf("'%s'", types), collapse = ", ")
  use_connection(connection_provider, function(connection) {
    sql <- read_sql("get_table_constraints.sql")
    result <- query(connection, sql, params = list(schema, table, paste(types, collapse = ", ")))
    result
  })
}

generate_constraint_sql <- function(connection_provider, schema, table, types = c("p", "u", "f")) {
  constraints <- get_constraints(connection_provider, schema, table, types)
  if (nrow(constraints) == 0) {
    return(character())
  }

  apply(constraints, 1, function(row) {
    row <- as.list(row)

    sprintf(
      "ALTER TABLE %s ADD CONSTRAINT %s %s;",
      quote_table(schema, table),
      quote_ident(row$conname),
      row$definition
    )
  })
}

# ================================================================
# Indexes
# ================================================================

get_indexes <- function(connection_provider, schema, table) {
  use_connection(connection_provider, function(connection) {
    sql <- read_sql("get_table_indexes.sql")
    result <- query(connection, sql, params = list(schema, table))
    result
  })
}

generate_index_sql <- function(connection_provider, schema, table) {
  indexes <- get_indexes(connection_provider, schema, table)

  if (nrow(indexes) == 0) {
    return(character())
  }

  # Skip indexes automatically created by primary key / unique constraints.
  constraints <- get_constraints(connection_provider, schema, table, types = c("p", "u"))
  constraint_names <- constraints$conname

  indexes <- indexes[!indexname %in% constraint_names]

  if (nrow(indexes) == 0) {
    return(character())
  }

  paste0(indexes$indexdef, ";")
}

# ================================================================
# Comments
# ================================================================

sql_quote_literal <- function(x) {
  paste0("'", gsub("'", "''", x), "'")
}

get_table_comment <- function(connection_provider, schema, table) {
  use_connection(connection_provider, function(connection) {
    sql <- read_sql("get_table_comment.sql")
    result <- query(connection, sql, params = list(schema, table))
    result$comment[1]
  })
}

get_column_comments <- function(connection_provider, schema, table) {
  use_connection(connection_provider, function(connection) {
    sql <- read_sql("get_column_comments.sql")
    result <- query(connection, sql, params = list(schema, table))
    result
  })
}

generate_comment_sql <- function(connection_provider, schema, table) {
  sql <- character()

  table_comment <- get_table_comment(connection_provider, schema, table)

  if (!is.na(table_comment) && nzchar(table_comment)) {
    sql <- c(
      sql,
      sprintf(
        "COMMENT ON TABLE %s IS %s;",
        quote_table(schema, table),
        sql_quote_literal(table_comment)
      )
    )
  }

  column_comments <- get_column_comments(connection_provider, schema, table)

  if (nrow(column_comments) > 0) {
    sql <- c(
      sql,
      apply(column_comments, 1, function(row) {
        row <- as.list(row)
        sprintf(
          "COMMENT ON COLUMN %s.%s IS %s;",
          quote_table(schema, table),
          quote_ident(row$column_name),
          sql_quote_literal(row$comment)
        )
      })
    )
  }
  sql
}


# -------------------------------------------------------------------
# Generate INSERT values
# -------------------------------------------------------------------

generate_insert_sql <- function(connection_provider, schema, table) {
  data <- use_connection(connection_provider, function(connection) {
    result <- as.data.table(dbReadTable(connection, Id(schema = schema, table = table)))
    result
  })
  if (nrow(data) == 0) {
    return(sprintf("-- No data in %s", quote_table(schema, table)))
  }

  columns <- names(data)
  insert_prefix <- sprintf("INSERT INTO %s (%s) VALUES", quote_table(schema, table), paste(quote_ident(columns), collapse = ", "))

  value_lines <- apply(data, 1, function(row) {
    values <- paste(vapply(row, quote_value, character(1)), collapse = ", ")
    paste0("  (", values, ")")
  })
  c(insert_prefix, paste0(value_lines, collapse = ",\n"), ";"
  )
}

# -------------------------------------------------------------------
# Generate UPSERT values
# -------------------------------------------------------------------

# NOTE:
#
# OVERRIDING SYSTEM VALUE is generated to support identity columns.
#
# It is harmless for most code-list tables but can be removed if no
# GENERATED ALWAYS AS IDENTITY columns exist in the reference database.
generate_upsert_sql <- function(connection_provider, schema, table) {

  data <- use_connection(connection_provider, function(connection) {
    result <- as.data.table(dbReadTable(connection, Id(schema = schema, table = table)))
    result
  })

  if (nrow(data) == 0) {
    return(sprintf("-- No data in %s", quote_table(schema, table)))
  }

  key <- get_primary_key_columns(connection_provider, schema, table)

  if (length(key) == 0) {
    stop("No primary key found for ", schema, ".", table)
  }

  columns <- names(data)
  update_columns <- setdiff(columns, key)

  insert_columns <- paste(quote_ident(columns), collapse = ", ")
  conflict_columns <- paste(quote_ident(key), collapse = ", ")

  if (length(update_columns) == 0) {
    return(apply(data, 1, function(row) {
      values <- paste(
        vapply(row, quote_value, character(1)),
        collapse = ", "
      )

      sprintf(
        "INSERT INTO %s (%s) OVERRIDING SYSTEM VALUE VALUES (%s) ON CONFLICT (%s) DO NOTHING;",
        quote_table(schema, table),
        insert_columns,
        values,
        conflict_columns
      )
    }))
  }

  target_alias <- "t"

  update_part <- paste(
    paste0(
      quote_ident(update_columns),
      " = EXCLUDED.",
      quote_ident(update_columns)
    ),
    collapse = ", "
  )

  current_values <- paste(
    paste0(target_alias, ".", quote_ident(update_columns)),
    collapse = ", "
  )

  excluded_values <- paste(
    paste0("EXCLUDED.", quote_ident(update_columns)),
    collapse = ", "
  )

  distinct_where <- sprintf(
    "(%s) IS DISTINCT FROM (%s)",
    current_values,
    excluded_values
  )

  apply(data, 1, function(row) {
    values <- paste(
      vapply(row, quote_value, character(1)),
      collapse = ", "
    )

    sprintf(
      paste(
        "INSERT INTO %s AS %s (%s) OVERRIDING SYSTEM VALUE",
        "VALUES (%s)",
        "ON CONFLICT (%s)",
        "DO UPDATE SET %s",
        "WHERE %s;"
      ),
      quote_table(schema, table),
      target_alias,
      insert_columns,
      values,
      conflict_columns,
      update_part,
      distinct_where
    )
  })
}

# -------------------------------------------------------------------
# Main generator
# -------------------------------------------------------------------

# =============================================================================
# Missing code-list table generator
# =============================================================================
#
# Generate a SQL script creating all code-list tables that exist in the
# Reference Data database but are missing from ROS.
#
# Generation order:
#
#   1. CREATE SCHEMA
#   2. CREATE TABLE
#   3. PRIMARY KEY / UNIQUE constraints
#   4. INSERT data
#   5. FOREIGN KEYS
#   6. INDEXES
#   7. COMMENTS
#
# Data insertion order is computed from foreign-key dependencies to ensure that
# referenced tables are populated before dependent tables.
#
# Parameters
# ----------
#
# reference_data_connection_provider
#   Connection provider for the Reference Data database.
#
# ros_connection_provider
#   Connection provider for the ROS database.
#
# schema_excluder
#   Predicate receiving a schema name and returning TRUE when the schema must
#   be excluded.
#
# output_file
#   Generated SQL file path.
#
# Returns
# -------
#
# Invisibly returns a data.table containing the generated tables.
#
# =============================================================================

generate_missing_code_list_tables_script <- function(reference_data_connection_provider,
                                                     ros_connection_provider,
                                                     schema_excluder = function(x) { FALSE },
                                                     output_file = "create_missing_refs_tables.sql"
) {
  missing_tables <- detect_missing_refs_tables(reference_data_connection_provider, ros_connection_provider, schema_excluder)
  dependencies <- get_code_list_tables_dependencies(reference_data_connection_provider)
  missing_tables <- sort_tables_by_dependencies(tables = missing_tables, dependencies = dependencies)
  sql <- c(
    "-- Generated ROS refs_* missing tables script",
    paste0("-- Generated at: ", format(Sys.time(), "%Y-%m-%d %H:%M:%S %z")),
    ""
  )

  if (nrow(missing_tables) == 0) {
    sql <- c(sql, "-- No missing refs_* tables found.", "")
    writeLines(sql, output_file)
    return(invisible(missing_tables))
  }

  # 1. CREATE TABLE
  sql <- c(
    sql,
    "-- ================================================================",
    "-- CREATE SCHEMA / CREATE TABLE",
    "-- ================================================================",
    ""
  )

  for (i in seq_len(nrow(missing_tables))) {
    schema <- missing_tables$schema[i]
    table <- missing_tables$table[i]

    message("CREATE TABLE for missing table: ", schema, ".", table)

    sql <- c(
      sql,
      "-- ----------------------------------------------------------------",
      paste0("-- ", schema, ".", table),
      "-- ----------------------------------------------------------------",
      "",
      generate_create_table_sql(reference_data_connection_provider, schema, table),
      ""
    )
  }

  # 2. Primary keys + unique constraints
  sql <- c(
    sql,
    "-- ================================================================",
    "-- PRIMARY KEYS / UNIQUE CONSTRAINTS",
    "-- ================================================================",
    ""
  )

  for (i in seq_len(nrow(missing_tables))) {
    schema <- missing_tables$schema[i]
    table <- missing_tables$table[i]

    sql <- c(
      sql,
      paste0("-- ", schema, ".", table),
      generate_constraint_sql(reference_data_connection_provider, schema, table, types = c("p", "u")),
      ""
    )
  }

  # 3. Data
  sql <- c(
    sql,
    "-- ================================================================",
    "-- INSERT DATA",
    "-- ================================================================",
    ""
  )

  for (i in seq_len(nrow(missing_tables))) {
    schema <- missing_tables$schema[i]
    table <- missing_tables$table[i]

    message("INSERT data for missing table: ", schema, ".", table)

    sql <- c(
      sql,
      paste0("-- ", schema, ".", table),
      generate_insert_sql(reference_data_connection_provider, schema, table),
      ""
    )
  }

  # 4. Foreign keys
  sql <- c(
    sql,
    "-- ================================================================",
    "-- FOREIGN KEYS",
    "-- ================================================================",
    ""
  )

  for (i in seq_len(nrow(missing_tables))) {
    schema <- missing_tables$schema[i]
    table <- missing_tables$table[i]

    sql <- c(
      sql,
      paste0("-- ", schema, ".", table),
      generate_constraint_sql(reference_data_connection_provider, schema, table, types = c("f")),
      ""
    )
  }

  # 5. Indexes
  sql <- c(
    sql,
    "-- ================================================================",
    "-- INDEXES",
    "-- ================================================================",
    ""
  )

  for (i in seq_len(nrow(missing_tables))) {
    schema <- missing_tables$schema[i]
    table <- missing_tables$table[i]

    sql <- c(
      sql,
      paste0("-- ", schema, ".", table),
      generate_index_sql(reference_data_connection_provider, schema, table),
      ""
    )
  }

  # 6. Comments
  sql <- c(
    sql,
    "-- ================================================================",
    "-- COMMENTS",
    "-- ================================================================",
    ""
  )

  for (i in seq_len(nrow(missing_tables))) {
    schema <- missing_tables$schema[i]
    table <- missing_tables$table[i]

    sql <- c(
      sql,
      paste0("-- ", schema, ".", table),
      generate_comment_sql(reference_data_connection_provider, schema, table),
      ""
    )
  }

  writeLines(sql, output_file)
  invisible(missing_tables)
}

# =============================================================================
# Existing code-list table discovery
# =============================================================================
#
# Detect code-list tables existing in both databases and return them ordered
# according to foreign-key dependencies.
#
# This function is typically used before generating update scripts.
#
# Returns
# -------
#
# A dependency-sorted data.table containing:
#
# - schema
# - table
#
# =============================================================================
get_code_list_tables_to_update <- function(
  reference_data_connection_provider,
  ros_connection_provider,
  schema_excluder = function(schema) { FALSE },
  table_excluder = function(schema, table) { FALSE }) {
  existing_tables <- detect_existing_refs_tables(reference_data_connection_provider, ros_connection_provider, schema_excluder, table_excluder)
  dependencies <- get_code_list_tables_dependencies(reference_data_connection_provider)
  sort_tables_by_dependencies(tables = existing_tables, dependencies = dependencies)
}

sort_code_list_tables_to_update <- function(connection_provider, tables) {
  dependencies <- get_code_list_tables_dependencies(connection_provider)
  sort_tables_by_dependencies(tables = tables, dependencies = dependencies)
}

# =============================================================================
# Existing code-list update generator
# =============================================================================
#
# Generate one UPSERT script per schema.
#
# Each generated statement uses:
#
#   INSERT ... ON CONFLICT (...) DO UPDATE
#
# and only performs an UPDATE when at least one non-key column differs:
#
#   WHERE (...) IS DISTINCT FROM (...)
#
# This avoids unnecessary updates and reduces PostgreSQL WAL generation.
#
# The input table list must already be dependency ordered, typically using
# get_code_list_tables_to_update().
#
# Generated files
# ---------------
#
# One file per schema.
#
# Example:
#
#   01_update_code_list_refs_admin.sql
#   02_update_code_list_refs_biology.sql
#
# =============================================================================

collect_existing_code_list_upsert_errors <- function(
  reference_data_connection_provider,
  ros_connection_provider,
  tables_to_update,
  schemas_to_file_prefix
) {
  reports <- list()
  sql_fix <- character()

  schemas_to_update <- unique(tables_to_update$schema)

  missing_prefixes <- setdiff(schemas_to_update, names(schemas_to_file_prefix))

  if (length(missing_prefixes) > 0) {
    reports[[length(reports) + 1]] <- list(
      ok = FALSE,
      table_id = "schema prefixes",
      messages = paste0(
        "Missing file prefix for schema(s): ",
        paste(missing_prefixes, collapse = ", ")
      ),
      sql = character()
    )
  }

  for (i in seq_len(nrow(tables_to_update))) {
    schema <- tables_to_update$schema[i]
    table <- tables_to_update$table[i]

    report <- check_same_table_structure(
      reference_data_connection_provider = reference_data_connection_provider,
      ros_connection_provider = ros_connection_provider,
      schema = schema,
      table = table,
      check_order = FALSE
    )

    if (!report$ok) {
      reports[[length(reports) + 1]] <- report
      sql_fix <- c(sql_fix, paste0("-- ", report$table_id), report$sql, "")
    }
  }

  list(
    ok = length(reports) == 0,
    reports = reports,
    sql = sql_fix
  )
}

generate_existing_code_list_upsert_script <- function(
    reference_data_connection_provider,
    ros_connection_provider,
    tables_to_update,
    schemas_to_file_prefix,
    output_file_pattern = "update_existing_%s_code_list_%s.sql",
    structure_fix_file
) {

  checks <- collect_existing_code_list_upsert_errors(
    reference_data_connection_provider = reference_data_connection_provider,
    ros_connection_provider = ros_connection_provider,
    tables_to_update = tables_to_update,
    schemas_to_file_prefix = schemas_to_file_prefix
  )

  if (!checks$ok) {

    if (length(checks$sql) > 0) {

      writeLines(
        c(
          "-- Generated ROS structure fix script",
          paste0("-- Generated at: ", format(Sys.time(), "%Y-%m-%d %H:%M:%S %z")),
          "",
          checks$sql
        ),
        structure_fix_file
      )
    }

    message("")
    message("============================================================")
    message("Cannot generate code-list update scripts")
    message("============================================================")
    message("")
    message("Reference Data is the source of truth.")
    message("ROS structure must be fixed before generating upserts.")
    message("")

    for (report in checks$reports) {

      message("------------------------------------------------------------")
      message(report$table_id)
      message("------------------------------------------------------------")

      for (line in report$messages) {
        message(line)
      }

      message("")
    }

    if (length(checks$sql) > 0) {
      message("Structure fix script generated:")
      message("  ", normalizePath(structure_fix_file, winslash = "/", mustWork = FALSE))
      message("")
    }

    stop(
      sprintf(
        "Detected %s table structure mismatch(es). Apply '%s' and rerun.",
        length(checks$reports),
        structure_fix_file
      )
    )
  }

  schemas_to_update <- unique(tables_to_update$schema)

  for (schema_name in schemas_to_update) {

    stopifnot(schema_name %in% names(schemas_to_file_prefix))

    output_file <- sprintf(
      output_file_pattern,
      schemas_to_file_prefix[[schema_name]],
      schema_name
    )

    schema_tables <- tables_to_update[schema == schema_name]

    generate_existing_code_list_upsert_script_for_schema(
      connection_provider = reference_data_connection_provider,
      schema_name = schema_name,
      tables_to_update = schema_tables,
      output_file = output_file
    )
  }

  invisible(tables_to_update)
}

generate_existing_code_list_upsert_script_for_schema <- function(connection_provider,
                                                                 schema_name,
                                                                 tables_to_update,
                                                                 output_file) {
  message("Generating upsert for schema: ", schema_name)
  sql <- c(
    paste0("-- Generated ", schema_name, " code list update script"),
    paste0("-- Generated at: ", format(Sys.time(), "%Y-%m-%d %H:%M:%S %z")),
    ""
  )

  if (nrow(tables_to_update) == 0) {
    sql <- c(
      sql,
      paste0("-- No existing ", schema_name, " tables found."),
      "")

    writeLines(sql, output_file)
    return(invisible(tables_to_update))
  }

  for (i in seq_len(nrow(tables_to_update))) {
    schema <- tables_to_update$schema[i]
    table <- tables_to_update$table[i]

    message("Generating upsert for table: ", schema, ".", table)

    sql <- c(
      sql,
      "-- -------------------------------------------------------------------",
      paste0("-- ", schema, ".", table),
      "-- -------------------------------------------------------------------",
      "",
      generate_upsert_sql(connection_provider, schema, table),
      "",
      generate_comment_sql(connection_provider, schema, table),
      ""
    )
  }
  writeLines(sql, output_file)
  invisible(tables_to_update)
}