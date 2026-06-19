library(htmltools)
library(rmarkdown)
library(data.table)
library(stringr)
library(DT)
library(visNetwork)
library(jsonlite)
library(whisker)

render_column_name <- function(column, mandatory = FALSE, primary_key = FALSE, foreign_key = FALSE) {
  not_null <- if (!is.na(mandatory) & (isTRUE(mandatory) | mandatory == "YES")) {
    "<span class='mandatory-icon'></span>"
  } else {
    ""
  }
  pk <- if (isTRUE(primary_key)) {
    "<span class='pk-icon'></span>"
  } else {
    ""
  }
  fk <- if (isTRUE(foreign_key)) {
    "<span class='fk-icon'></span>"
  } else {
    ""
  }
  label <- htmltools::htmlEscape(column)
  if (isTRUE(primary_key)) {
    label <- paste0("<span class='pk-column'>", label, "</span>")
  }
  paste0(pk, fk, not_null, label)
}

out_table_columns <- function(data) {
  hidden_columns <- c("mandatory", "primary_key")
  real_data <- data.table(data)[, `:=`(column = mapply(render_column_name, column, mandatory, primary_key, !is.na(foreign_key)),
                                       description = fifelse(is.na(description) | description == "", "Not filled", description),
                                       schema = NULL, table = NULL, foreign_key = NULL)]
  datatable(real_data,
            autoHideNavigation = TRUE,
            rownames = FALSE,
            lazyRender = TRUE,
            fillContainer = FALSE,
            escape = FALSE,
            colnames = c("Column", "Type", "mandatory", "Description", "primary_key"),
            options = list(dom = "t", ordering = FALSE,
                           columnDefs = list(
                             list(visible = FALSE, targets = which(names(real_data) %in% hidden_columns) - 1),
                             list(
                               targets = "description",
                               createdCell = JS(
                                 "function(td, cellData) {",
                                 "  if(cellData === 'Not filled') {",
                                 "    $(td).css({'color': 'red', 'font-style':'italic'});",
                                 "  }",
                                 "}"
                               )
                             )))
  ) %>% formatStyle(
    "primary_key",
    target = "row",
    fontWeight = styleEqual(c(TRUE, FALSE), c("bold", "normal")))
}

out_table_dependencies <- function(data) {
  hidden_columns <- c("mandatory", "primary_key", "dependency_mandatory", "dependency_primary_key")
  real_data <- data.table(data)[, `:=`(column = mapply(render_column_name, column, mandatory, primary_key), dependency_column = mapply(render_column_name, dependency_column, dependency_mandatory, dependency_primary_key))]
  datatable(
    real_data,
    colnames = c("Column", "mandatory", "primary_key", "Relation type", "Dependency table", "Dependency column"),
    escape = FALSE,
    autoHideNavigation = TRUE,
    rownames = FALSE,
    lazyRender = TRUE,
    fillContainer = FALSE,
    options = list(dom = "t",
                   ordering = FALSE,
                   columnDefs = list(list(visible = FALSE, targets = which(names(real_data) %in% hidden_columns) - 1)))
  ) %>% formatStyle(
    "primary_key",
    target = "row",
    fontWeight = styleEqual(c(TRUE, FALSE), c("bold", "normal")))
}

out_table_usages <- function(data) {
  hidden_columns <- c("mandatory", "primary_key", "usage_mandatory", "usage_primary_key")
  real_data <- data.table(data)[, `:=`(column = mapply(render_column_name, column, mandatory, primary_key), usage_column = mapply(render_column_name, usage_column, usage_mandatory, usage_primary_key))]
  datatable(
    real_data,
    colnames = c("Column", "mandatory", "primary_key", "Relation type", "Usage table", "Usage column"),
    escape = FALSE,
    autoHideNavigation = TRUE,
    rownames = FALSE,
    lazyRender = TRUE,
    fillContainer = FALSE,
    options = list(dom = "t",
                   ordering = FALSE,
                   columnDefs = list(list(visible = FALSE, targets = which(names(real_data) %in% hidden_columns) - 1)))
  ) %>% formatStyle("primary_key", target = "row", fontWeight = styleEqual(c(TRUE, FALSE), c("bold", "normal")))
}

out_data_dependencies <- function(data, entry_point) {
  data <- data.table(data[,
                       tree_view := mapply(
                         function(level, table, table_column, parent_table, parent_column, link_type) {
                           result <- sprintf("%s%s%s",
                                             strrep("&nbsp;&nbsp;&nbsp;&nbsp;", level),
                                             ifelse(level == 0, "", "└── "),
                                             table)
                           ifelse(level == 0,
                                  result,
                                  ifelse(link_type == "←",
                                         sprintf("%s (%s.%s %s %s.%s)",
                                                 result,
                                                 table,
                                                 table_column,
                                                 link_type,
                                                 parent_table,
                                                 parent_column),
                                         sprintf("%s (%s.%s %s %s.%s)",
                                                 result,
                                                 parent_table,
                                                 parent_column,
                                                 link_type,
                                                 table,
                                                 table_column)))
                         },
                         level,
                         table,
                         table_column,
                         parent_table,
                         parent_column,
                         link_type
                       )])[, .(tree_view)]
  datatable(
    data,
    escape = FALSE,
    rownames = FALSE,
    options = list(dom = "t", ordering = FALSE, autoWidth = FALSE)
  ) %>%
    formatStyle(
      "tree_view",
      target = "row",
      fontWeight = styleEqual(column_location$new(entry_point)$table_gav(), "bold")
    ) %>%
    htmlwidgets::onRender("
    function(el,x){
      $(el).find('thead').remove();
    }")
}

out_data_graph <- function(data) {
  visNetwork(
    data$nodes,
    data$edges,
    width = '100%',
    height = '85vh'
  ) %>%
    visNodes(
      shape = 'dot',
      size = 20,
      borderWidth = 1,
      borderWidthSelected = 5,
      color = list(
        border = "#A0A0A0",
        highlight = list(
          border = "#222222"
        )
      )
    ) %>%
    visEdges(
      arrows = list(
        to = list(enabled = TRUE)
      ),
      length = 200,
      smooth = TRUE,
      font = list(
        align = 'bottom',
        size = 14
      )
    ) %>%
    visPhysics(
      solver = 'barnesHut',
      stabilization = list(
        enabled = TRUE,
        iterations = 1000
      ),
      barnesHut = list(
        gravitationalConstant = -8000,
        springLength = 180,
        springConstant = 0.04,
        damping = 0.09
      )
    ) %>%
    visInteraction(
      navigationButtons = TRUE,
      dragNodes = TRUE,
      zoomView = TRUE
    ) %>%
    visEvents(
      afterDrawing = "
      function() {
        window.myNetwork = this;
      }",
      selectNode = "
      function(properties) {
        if (!properties.nodes.length) return;
        const nodeId = properties.nodes[0]
        window.location.hash = nodeId;

      }",
      deselectNode = "
    function(properties) {
      window.location.hash = '';
    }")
}

generate_graph_data_input <- function(data, entry_point) {
  deps <- data.table(data[!is.na(parent_table)])
  inverse_deps <- deps[link_type == "←"][, `:=`(parent_table = table, parent_column = table_column, table = parent_table, table_column = parent_column)]
  direct_deps <- deps[link_type == "→"]
  deps <- rbind(inverse_deps, direct_deps)

  # Create node vector ONCE
  nodes_vec <- unique(c(deps$table, deps$parent_table))

  # Build nodes
  nodes <- data.table(
    id = nodes_vec,
    label = nodes_vec,
    stringsAsFactors = FALSE
  )
  nodes$color <- 'orange'
  nodes$color[nodes$id %like% "ros_meta"] <- 'lightgray'
  nodes$color[nodes$id %like% "ros_common"] <- 'lightblue'
  nodes$color[nodes$id == entry_point] <- 'red'

  # Build edges
  edges <- data.table(
    from = deps$parent_table,
    from_column = deps$parent_column,
    to = deps$table,
    to_column = deps$table_column,
    relation = deps$link_type,
    stringsAsFactors = FALSE)
  edges$title <- paste0(edges$from, ".", edges$from_column, " → ", edges$to, ".", edges$to_column)
  edges$color <- ifelse(edges$relation == "←", "#FF7F0E", "1F77B4")
  edges$dashes <- edges$relation == "←"

  list(nodes = nodes, edges = edges)
}

generate_data_graph_js <- function(tables_columns, tables_dependencies, tables_usages, table_descriptions) {
  columns <- toJSON(tables_columns, dataframe = 'rows', auto_unbox = TRUE)
  dependencies <- toJSON(tables_dependencies, dataframe = 'rows', auto_unbox = TRUE)
  usages <- toJSON(tables_usages, dataframe = 'rows', auto_unbox = TRUE)
  descriptions <- toJSON(table_descriptions, auto_unbox = TRUE)
  js_template <- paste(readLines("./templates/graph.js", warn = FALSE), collapse = "\n")
  js_content <- sprintf(paste0("<script>\n", js_template, "\n</script>"), columns, dependencies, usages, descriptions)
  writeLines(js_content, "./templates/generated-graph.js")
}

generate_db_metadata_dependencies <- function(db_metadata, db_reverse_dependencies_tree, db_tables_columns, db_tables_dependencies, db_tables_usages, export_directory, timestamp, report_prefix) {
  for (schema_name in names(db_reverse_dependencies_tree)) {
    graph_location <- file.path(export_directory, sprintf("%s%s_dependencies_%s.html", report_prefix, db_metadata$to_domain_report(), schema_name))
    db_schema_reverse_dependencies_tree <- data.table(db_reverse_dependencies_tree[[schema_name]])
    db_schema_tables_names <- unique(append(db_schema_reverse_dependencies_tree[!is.na(parent_table)]$parent_table, db_schema_reverse_dependencies_tree$table))
    db_schema_tables_columns <- db_tables_columns[names(db_tables_columns) %in% db_schema_tables_names]
    dt <- db_metadata$to_table_descriptions()[, gav := paste0(schema, ".", table)][, .(gav, description)]
    db_tables_descriptions <- setNames(as.list(dt$description), dt$gav)
    # FIXME add this in db_metadata class
    filter <- sprintf("ros_common|ros_meta|refs_|%s", schema_name)
    db_schema_tables_dependencies <- lapply(db_tables_dependencies[names(db_tables_dependencies) %in% db_schema_tables_names], function(x) { data.table(x)[dependency_table_raw %like% filter][, dependency_table_raw := NULL] })
    db_schema_tables_usages <- lapply(db_tables_usages[names(db_tables_usages) %in% db_schema_tables_names], function(x) { data.table(x)[usage_table_raw %like% filter][, usage_table_raw := NULL] })
    entry_point_table_gav <- db_metadata$entry_point_table_gav()
    graph_data <- generate_graph_data_input(db_schema_reverse_dependencies_tree, entry_point_table_gav)
    generate_data_graph_js(db_schema_tables_columns, db_schema_tables_dependencies, db_schema_tables_usages, db_tables_descriptions)
    render("./RMDs/ros_metatadata-schema-graph.Rmd",
           output_format = "html_document",
           output_file = basename(graph_location),
           output_dir = dirname(graph_location),
           quiet = TRUE)
    file.remove("./templates/generated-graph.js")
  }
}

format_timestamp <- function(timestamp) {
  str_replace_all(timestamp, "[ :.]", "_")
}

render_template <- function(template_path, data) {
  template <- paste(readLines(template_path, warn = FALSE), collapse = "\n")
  whisker.render(template, data)
}

sanitize_id <- function(...) {
  x <- paste(..., sep = "_")
  x <- gsub("[^A-Za-z0-9_-]", "_", x)
  x <- gsub("_+", "_", x)
  tolower(x)
}

render_description <- function(description) {
  ifelse(is.na(description), '<p class="error">Not filled</p>', description)
}

generate_db_metadata_report_template <- function(domain,
                                                 version,
                                                 root_directory,
                                                 db_metadata_supplier,
                                                 db_metadata_report_template_supplier,
                                                 remove_unused_tables = FALSE) {
  print("Generating template...")
  if (is.function(db_metadata_supplier)) {
    db_metadata <- db_metadata_supplier(domain, version, root_directory)
    db_metadata$generate_dependencies()
    if (remove_unused_tables) {
      db_metadata$remove_unused_tables()
    }
  } else {
    db_metadata <- db_metadata_supplier
  }
  template <- db_metadata_report_template_supplier(db_metadata)
  print(sprintf("Generated template at %s", template))
  template
}

patch_tocify_hash_generator <- function(html_file) {

  html <- paste(readLines(html_file, warn = FALSE, encoding = "UTF-8"), collapse = "\n")

  old <- 'hashGenerator: function \\(text\\) \\{\\n\\s*return text\\.replace\\(/\\[\\.\\\\\\\\/\\?&!#<>\\]/g, \'\'\\)\\.replace\\(/\\\\s/g, \'_\'\\);\\n\\s*\\}'

  new <- 'hashGenerator: function (text) {
        var foundId = null;

        $("div.section[id] > h1, div.section[id] > h2, div.section[id] > h3").each(function () {
          var headingText = $(this).clone().children().remove().end().text().trim();
          if (headingText === text && foundId === null) {
            foundId = $(this).parent().attr("id");
          }
        });

        if (foundId) return foundId;

        return text.replace(/[.\\\\/?&!#<>]/g, \'\').replace(/\\s/g, \'_\');
      }'

  html2 <- sub(old, new, html, perl = TRUE)

  if (identical(html, html2)) {
    stop("Could not patch tocify hashGenerator: pattern not found")
  }

  writeLines(html2, html_file, useBytes = TRUE)
}


to_dependencies_table <- function(db_table, link_to_type, link_to_url) {
  data.table(db_table$dependencies())[, `:=`(
    dependency_type = sapply(target_table_id, link_to_type),
    dependency_table_raw = target_table_id,
    dependency_table = mapply(link_to_url, target_schema, target_table, target_table_id),
    dependency_column = target_column,
    dependency_mandatory = target_mandatory,
    dependency_primary_key = target_primary_key
  )][, .(column, mandatory, primary_key, dependency_type, dependency_table_raw, dependency_table, dependency_column, dependency_mandatory, dependency_primary_key)]
}

to_usages_table <- function(db_table, link_to_type, link_to_url) {
  data.table(db_table$usages())[, `:=`(
    usage_type = sapply(usage_table_id, link_to_type),
    usage_table_raw = usage_table_id,
    usage_table = mapply(link_to_url, usage_schema, usage_table, usage_table_id),
    usage_column = usage_column
  )][, .(column, mandatory, primary_key, usage_type, usage_table_raw, usage_table, usage_column, usage_mandatory, usage_primary_key)]
}

generate_db_metadata_report <- function(domain,
                                        version,
                                        root_directory,
                                        export_directory,
                                        timestamp = format_timestamp(Sys.time()),
                                        db_metadata_supplier,
                                        db_metadata_report_template_supplier,
                                        link_to_type,
                                        link_to_url,
                                        report_prefix,
                                        remove_unused_tables = FALSE) {
  db_metadata <- db_metadata_supplier(domain, version, root_directory)
  db_metadata$generate_dependencies()
  if (remove_unused_tables) {
    db_metadata$remove_unused_tables()
  }
  template <- generate_db_metadata_report_template(domain,
                                                   version,
                                                   root_directory,
                                                   db_metadata,
                                                   db_metadata_report_template_supplier,
                                                   remove_unused_tables)
  export_directory <- file.path(export_directory, timestamp)
  if (!dir.exists(export_directory)) {
    dir.create(export_directory, recursive = TRUE)
  }
  file_location <- file.path(export_directory, sprintf("%s%s.html", report_prefix, db_metadata$to_domain_report()))
  print("Preparing variables...")
  # print("Preparing db_reverse_dependencies_tree...")
  db_reverse_dependencies_tree <- db_metadata$db_reverse_dependencies_tree()
  # print("Preparing db_tables_columns...")
  db_tables_columns <- lapply(db_metadata$all_tables(), function(x) { x$columns() })
  # print("Preparing db_tables_dependencies...")
  db_tables_dependencies <- lapply(db_metadata$all_tables(), function(x) { to_dependencies_table(x, link_to_type, link_to_url) })
  # print("Preparing db_tables_usages...")
  db_tables_usages <- lapply(db_metadata$all_tables(), function(x) { to_usages_table(x, link_to_type, link_to_url) })
  print("Generating db_metadata_dependencies...")
  generate_db_metadata_dependencies(db_metadata, db_reverse_dependencies_tree, db_tables_columns, db_tables_dependencies, db_tables_usages, export_directory, timestamp, report_prefix)
  db_tables_dependencies <- lapply(db_tables_dependencies, function(x) { x[, dependency_table_raw := NULL] })
  db_tables_usages <- lapply(db_tables_usages, function(x) { x[, usage_table_raw := NULL] })
  options(DT.options = list(pageLength = -1))
  print(sprintf("Generating report: %s...", file_location))
  render(template,
         output_format = "html_document",
         output_file = basename(file_location),
         output_dir = dirname(file_location),
         quiet = TRUE)
  print(sprintf("Generated report: %s...", file_location))
  print(sprintf("Patching report: %s...", file_location))
  patch_tocify_hash_generator(file_location)
}