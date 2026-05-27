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

out_table_code_list <- function(data) {
  datatable(data.table(data)[, `:=`(schema = NULL, table = NULL, type = NULL, comment = NULL, foreign_key = NULL, code_list = foreign_key)],
            autoHideNavigation = TRUE,
            rownames = FALSE,
            lazyRender = TRUE,
            fillContainer = FALSE,
            options = list(dom = "t", ordering = FALSE))
}

out_table_data_dependencies <- function(data) {
  datatable(data.table(data)[, `:=`(schema = NULL, table = NULL, type = NULL, comment = NULL, foreign_key = NULL, data_dependency = foreign_key)],
            autoHideNavigation = TRUE,
            rownames = FALSE,
            lazyRender = TRUE,
            fillContainer = FALSE,
            options = list(dom = "t", ordering = FALSE))
}

out_data_dependencies <- function(data, entry_point) {
  data[
    ,
    tree_view := paste0(
      strrep("&nbsp;&nbsp;&nbsp;&nbsp;", level),
      ifelse(level == 0, "", "└── "),
      table
    )
  ]
  datatable(
    data[
      ,
      .(
        # Level = level,
        Tree = tree_view
        # , Parent = parent
        , Path = path
      )
    ],
    escape = FALSE,
    rownames = FALSE,
    options = list(dom = "t", ordering = FALSE, autoWidth = FALSE)
  ) %>%
    DT::formatStyle(
      "Tree",
      target = "row",
      fontWeight = DT::styleEqual(
        entry_point,
        "bold"
      )
    ) %>%
    htmlwidgets::onRender("
    function(el,x){
      $(el).find('thead').remove();
    }
  ")
}

out_data_dependencies_graph <- function(schema_name, data, output_file, entry_point) {

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
  htmlwidgets::saveWidget(graph, output_file, title = sprintf("Dependency tree for schema %s", schema_name), selfcontained = TRUE, libdir = NULL)
}

generate_db_metadata_report <- function(domain,
                                        version,
                                        root_directory,
                                        export_directory,
                                        timestamp = format_timestamp(Sys.time()),
                                        db_metadata_supplier,
                                        db_metadata_report_template_supplier,
                                        extra_report_generator,
                                        report_prefix) {
  db_metadata <- db_metadata_supplier(domain, version, root_directory)
  template <- db_metadata_report_template_supplier(db_metadata)
  options(DT.options = list(pageLength = -1))
  db_extra_data <- extra_report_generator(db_metadata, export_directory, timestamp, report_prefix)
  file_location <- file.path(export_directory, sprintf("%s_%s%s.html", report_prefix, db_metadata$domain(), timestamp))
  render(template,
         output_format = "html_document",
         output_file = basename(file_location),
         output_dir = dirname(file_location))
}