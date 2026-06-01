library(htmltools)
library(rmarkdown)
library(data.table)
library(stringr)
library(DT)
library(visNetwork)
library(jsonlite)

out_table_columns <- function(data) {
  real_data <- data.table(data)[, `:=`(description = fifelse(is.na(description) | description == "", "Not filled", description), schema = NULL, table = NULL, foreign_key = NULL)]
  datatable(real_data,
            autoHideNavigation = TRUE,
            rownames = FALSE,
            lazyRender = TRUE,
            fillContainer = FALSE,
            options = list(dom = "t", ordering = FALSE,
                           columnDefs = list(
                             list(visible = FALSE, targets = which(names(real_data) == "mandatory") - 1),
                             list(
                               targets = "description",
                               createdCell = JS(
                                 "function(td, cellData) {",
                                 "  if(cellData === 'Not filled') {",
                                 "    $(td).css({'color': 'red', 'font-style':'italic'});",
                                 "  }",
                                 "}"
                               )
                             )))) %>% formatStyle("mandatory",
                                                  target = "row",
                                                  fontWeight = styleEqual(
                                                    c("YES", "NO"),
                                                    c("bold", "normal")
                                                  ),
                                                  backgroundColor = styleEqual(
                                                    c("YES", "NO"),
                                                    c("#fff8e1", NA)
                                                  )
  )
}

out_table_dependencies <- function(data) {
  datatable(
    data,
    colnames = c(
       "Column",
       "mandatory",
       "Relation type",
       "Dependency table",
       "Dependency column"
    ),
    escape = FALSE,
    autoHideNavigation = TRUE,
    rownames = FALSE,
    lazyRender = TRUE,
    fillContainer = FALSE,
    options = list(dom = "t",
                   ordering = FALSE,
                   columnDefs = list(list(visible = FALSE, targets = which(names(data) == "mandatory") - 1)))
  ) %>% formatStyle(
    "mandatory",
    target = "row",
    fontWeight = styleEqual(c("YES", "NO"), c("bold", "normal")),
    backgroundColor = styleEqual(c("YES", "NO"), c("#fff8e1", NA)))
}

out_table_usages <- function(data) {
  datatable(
    data,
    colnames = c(
       "Column",
       "mandatory",
       "Relation type",
       "Usage table",
       "Usage column"
    ),
    escape = FALSE,
    autoHideNavigation = TRUE,
    rownames = FALSE,
    lazyRender = TRUE,
    fillContainer = FALSE,
    options = list(dom = "t",
                   ordering = FALSE,
                   columnDefs = list(list(visible = FALSE, targets = which(names(data) == "mandatory") - 1)))
  ) %>% formatStyle(
    "mandatory",
    target = "row",
    fontWeight = styleEqual(c("YES", "NO"), c("bold", "normal")),
    backgroundColor = styleEqual(c("YES", "NO"), c("#fff8e1", NA)))
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

generate_data_graph_js <- function(tables_columns, tables_dependencies, tables_usages) {
  columns <- toJSON(tables_columns, dataframe = 'rows', auto_unbox = TRUE)
  dependencies <- toJSON(tables_dependencies, dataframe = 'rows', auto_unbox = TRUE)
  usages <- toJSON(tables_usages, dataframe = 'rows', auto_unbox = TRUE)
  js_template <- paste(readLines("./templates/graph.js", warn = FALSE), collapse = "\n")
  js_content <- sprintf(paste0("<script>\n", js_template, "\n</script>"), columns, dependencies, usages)
  writeLines(js_content, "./templates/generated-graph.js")
}

generate_db_metadata_dependencies <- function(db_metadata, db_reverse_dependencies_tree, db_tables_columns, db_tables_dependencies, db_tables_usages, export_directory, timestamp, report_prefix) {
  for (schema_name in names(db_reverse_dependencies_tree)) {
    graph_location <- file.path(export_directory, sprintf("%s%s_dependencies_%s.html", report_prefix, db_metadata$to_domain_report(), schema_name))
    db_schema_reverse_dependencies_tree <- data.table(db_reverse_dependencies_tree[[schema_name]])
    db_schema_tables_names <- unique(append(db_schema_reverse_dependencies_tree[!is.na(parent_table)]$parent_table, db_schema_reverse_dependencies_tree$table))
    db_schema_tables_columns <- db_tables_columns[names(db_tables_columns) %in% db_schema_tables_names]
    # FIXME add this in db_metadata class
    filter <- sprintf("ros_common|ros_meta|refs_|%s", schema_name)
    db_schema_tables_dependencies <- lapply(db_tables_dependencies[names(db_tables_dependencies) %in% db_schema_tables_names], function(x) { data.table(x)[dependency_table_raw %like% filter][, dependency_table_raw := NULL] })
    db_schema_tables_usages <- lapply(db_tables_usages[names(db_tables_usages) %in% db_schema_tables_names], function(x) { data.table(x)[usage_table_raw %like% filter][, usage_table_raw := NULL] })
    entry_point_table_gav <- db_metadata$entry_point_table_gav()
    graph_data <- generate_graph_data_input(db_schema_reverse_dependencies_tree, entry_point_table_gav)
    generate_data_graph_js(db_schema_tables_columns, db_schema_tables_dependencies, db_schema_tables_usages)
    render("./RMDs/ros_metatadata-schema-graph.Rmd",
           output_format = "html_document",
           output_file = basename(graph_location),
           output_dir = dirname(graph_location),
           quiet = TRUE)
    file.remove("./templates/generated-graph.js")
  }
}

generate_db_metadata_report <- function(domain,
                                        version,
                                        root_directory,
                                        export_directory,
                                        timestamp = format_timestamp(Sys.time()),
                                        db_metadata_supplier,
                                        db_metadata_report_template_supplier,
                                        build_tables_dependencies_supplier,
                                        build_tables_usages_supplier,
                                        report_prefix,
                                        remove_unused_tables = FALSE) {
  db_metadata <- db_metadata_supplier(domain, version, root_directory)
  db_metadata$generate_dependencies()
  if (remove_unused_tables) {
    db_metadata$remove_unused_tables()
  }
  template <- db_metadata_report_template_supplier(db_metadata)
  export_directory <- file.path(export_directory, timestamp)
  if (!dir.exists(export_directory)) {
    dir.create(export_directory, recursive = TRUE)
  }
  file_location <- file.path(export_directory, sprintf("%s%s.html", report_prefix, db_metadata$to_domain_report()))
  db_reverse_dependencies_tree <- db_metadata$db_reverse_dependencies_tree()
  db_tables_columns <- lapply(db_metadata$all_tables(), function(x) { x$columns() })
  db_tables_dependencies <- build_tables_dependencies_supplier(db_metadata)
  db_tables_usages <- build_tables_usages_supplier(db_metadata, db_tables_dependencies)
  generate_db_metadata_dependencies(db_metadata, db_reverse_dependencies_tree, db_tables_columns, db_tables_dependencies, db_tables_usages, export_directory, timestamp, report_prefix)
  db_tables_dependencies <- lapply(db_tables_dependencies, function(x) { x[, dependency_table_raw := NULL] })
  db_tables_usages <- lapply(db_tables_usages, function(x) { x[, usage_table_raw := NULL] })
  options(DT.options = list(pageLength = -1))

  render(template,
         output_format = "html_document",
         output_file = basename(file_location),
         output_dir = dirname(file_location),
         quiet = TRUE)
}