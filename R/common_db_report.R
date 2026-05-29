library(htmltools)
library(rmarkdown)
library(data.table)
library(stringr)
library(DT)
library(visNetwork)

out_table_columns <- function(data) {
  datatable(data.table(data)[, `:=`(comment = fifelse(is.na(comment) | comment == "", "Not filled", comment), schema = NULL, table = NULL, foreign_key = NULL)],
            autoHideNavigation = TRUE,
            rownames = FALSE,
            lazyRender = TRUE,
            fillContainer = FALSE,
            options = list(dom = "t", ordering = FALSE,
                           columnDefs = list(
                             list(
                               targets = "comment",
                               createdCell = JS(
                                 "function(td, cellData) {",
                                 "  if(cellData === 'Not filled') {",
                                 "    $(td).css({'color': 'red', 'font-style':'italic'});",
                                 "  }",
                                 "}"
                               )
                             ))))
}

out_table_dependencies <- function(data) {
  datatable(data,
            escape = FALSE,
            autoHideNavigation = TRUE,
            rownames = FALSE,
            lazyRender = TRUE,
            fillContainer = FALSE,
            options = list(dom = "t", ordering = FALSE))
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
    DT::formatStyle(
      "tree_view",
      target = "row",
      fontWeight = DT::styleEqual(
        column_location$new(entry_point)$table_gav(),
        "bold"
      )
    ) %>%
    htmlwidgets::onRender("
    function(el,x){
      $(el).find('thead').remove();
    }
  ")
}

out_data_dependencies_graph <- function(schema_name, data, output_file = NULL, entry_point) {

  deps <- as.data.frame(data)
  # Force character vectors
  deps$origin <- as.character(deps$origin)
  deps$target <- as.character(deps$target)

  # Create node vector ONCE
  nodes_vec <- unique(c(deps$origin, deps$target))

  # Build nodes
  nodes <- data.frame(
    id = nodes_vec,
    label = nodes_vec,
    stringsAsFactors = FALSE
  )

  # Build edges
  edges <- data.frame(
    from = deps$origin,
    to = deps$target,
    stringsAsFactors = FALSE
  )

  # Reset row names
  rownames(nodes) <- NULL
  rownames(edges) <- NULL

  # Default selected node
  default_node <- entry_point

  graph <- visNetwork(
    nodes,
    edges,
    width = '100%',
    height = '1500px'
  ) %>%
    visNodes(
      shape = 'dot',
      size = 15
    ) %>%
    visEdges(
      smooth = TRUE,
      length = 200
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
    visOptions(
      highlightNearest = list(
        enabled = TRUE,
        hover = TRUE
      ),
      nodesIdSelection = list(
        enabled = TRUE,
        selected = default_node
      )
    ) %>%
    visEvents(
      stabilized = "
      function () {

        // Find generated combo-box
        var select = document.querySelector('select.dropdown');
        if(select){
          // Increase width
          select.style.width = '600px';
          select.style.minWidth = '600px';
        }
      }
    "
    )
  if (is.null(output_file)) {
    return(graph)
  }
  htmlwidgets::saveWidget(graph, output_file, title = sprintf("Dependency tree for schema %s", schema_name), selfcontained = TRUE, libdir = NULL)
}

generate_db_metadata_dependencies <- function(db_metadata, export_directory, report_prefix) {

  db_reverse_dependencies <- db_metadata$db_reverse_dependencies()
  #TODO Use the tree to generate the graph with labels on edges
  db_reverse_dependencies_tree <- db_metadata$db_reverse_dependencies_tree()

  for (schema_name in names(db_reverse_dependencies)) {
    graph_location <- file.path(export_directory, sprintf("%s_%s_dependencies_%s.html", report_prefix, db_metadata$domain(), schema_name))
    db_schema_reverse_dependencies <- data.table(db_reverse_dependencies[[schema_name]])[,
      `:=`(origin = lapply(origin, function(x) { column_location$new(x)$table_gav() }), target = lapply(target, function(x) { column_location$new(x)$table_gav() }))]
    out_data_dependencies_graph(schema_name, db_schema_reverse_dependencies, graph_location, column_location$new(db_metadata$entry_point())$table_gav())
    # Remove generated files we do not want
    files_location <- file.path(export_directory, sprintf("%s_%s_dependencies_%s_files", report_prefix, db_metadata$domain(), schema_name))
    if (dir.exists(files_location)) {
      unlink(files_location, recursive = TRUE, force = TRUE)
    }
  }
}

generate_db_metadata_report <- function(domain,
                                        version,
                                        root_directory,
                                        export_directory,
                                        timestamp = format_timestamp(Sys.time()),
                                        db_metadata_supplier,
                                        db_metadata_report_template_supplier,
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
  generate_db_metadata_dependencies(db_metadata, export_directory, report_prefix)
  options(DT.options = list(pageLength = -1))
  file_location <- file.path(export_directory, sprintf("%s_%s.html", report_prefix, db_metadata$domain()))
  render(template,
         output_format = "html_document",
         output_file = basename(file_location),
         output_dir = dirname(file_location))
}