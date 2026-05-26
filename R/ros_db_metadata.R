library(htmltools)
library(rmarkdown)
library(data.table)
library(stringr)
library(DT)
library(visNetwork)

#'The constants holding the name of the latest IOTC_Ros database
#'@export
IOTC_ROS <- "IOTC_Ros_3_3_0_2026_04_16"


#'The constants holding the name of all schemas of the Ros database
#'@export
ALL_SCHEMAS <- c("ros_meta", "ros_common", "ros_ps", "ros_ll", "ros_pl", "ros_gn")

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

STANDALONE_TABLES <- list(
  "ros_common.capacities",
  "ros_common.depths",
  "ros_common.diameters",
  "ros_common.distances",
  "ros_common.engines",
  "ros_common.estimated_weights",
  "ros_common.heights",
  "ros_common.lengths",
  "ros_common.locations",
  "ros_common.maturity_stages",
  "ros_common.measured_lengths",
  "ros_common.powers",
  "ros_common.properties",
  "ros_common.ranges",
  "ros_common.sample_collection_details",
  "ros_common.sampling_details",
  "ros_common.sizes",
  "ros_common.speeds",
  "ros_common.thicknesses",
  "ros_common.tonnages",
  "ros_common.weights"
)

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

out_table_columns <- function(data) {
  datatable(data[, `:=`(comment = fifelse(is.na(comment) | comment == "", "Not filled", comment), schema = NULL, table = NULL, foreign_key = NULL)],
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
  datatable(data[, `:=`(schema = NULL, table = NULL, type = NULL, foreign_key = NULL, code_list = lapply(foreign_key, function(x) { column_location$new(x)$table()$gav() }))],
            autoHideNavigation = TRUE,
            rownames = FALSE,
            lazyRender = TRUE,
            fillContainer = FALSE,
            options = list(dom = "t", ordering = FALSE))
}

out_table_data_dependencies <- function(data) {
  datatable(data[, `:=`(schema = NULL, table = NULL, foreign_key = NULL, data_dependency = lapply(foreign_key, function(x) { column_location$new(x)$table()$gav() }))],
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
        Level = level,
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

out_data_dependencies_graph <- function(schema_name, data, output_file) {

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
  default_node <- "ros_common.observer_data"


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
    for (table in schema$all_tables()) {
      content <- append(content, sprintf("
```{r}
db_table <- db_schema$table('%s')
```
```{r child='ros_metatadata-table.Rmd'}
```", table$table()))
    }
    if (!schema$schema() %like% "ros_common|ros_meta") {
      content <- append(content, "
```{r child='ros_metatadata-schema-dependencies.Rmd'}
```")
    }
  }
  writeLines(content, file_location)
  file_location
}

load_db_metadata_object <- function(domain,
                                    version = IOTC_ROS,
                                    root_directory = DB_METADATA_DIRECTORY) {
  files <- load_db_metadata(domain, root_directory)
  db_metadata$new(domain, version, withr::with_locale(c(LC_TIME = "C"), format(Sys.time(), '%d %B %Y %H:%M %Z')), files$schemas_comment, files$tables_comment, files$tables_columns)
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
  db_reverse_dependencies <- db_metadata$data_dependencies_tables_per_schema()
  for (schema_name in names(db_reverse_dependencies)) {
    if (!is.null(db_reverse_dependencies[[schema_name]])) {
      graph_location <- file.path(export_directory, sprintf("ROS_database_%s_dependencies_%s%s.html", db_metadata$domain(), schema_name, timestamp))
      out_data_dependencies_graph(schema_name, db_reverse_dependencies[[schema_name]], graph_location)
      # Remove generated files we do not want
      files_location <- file.path(export_directory, sprintf("ROS_database_%s_dependencies_%s%s_files", db_metadata$domain(), schema_name, timestamp))
      if (dir.exists(files_location)) {
        unlink(files_location, recursive = TRUE, force = TRUE)
      }
    }
  }
  render(template,
         output_format = "html_document",
         output_file = basename(file_location),
         output_dir = dirname(file_location))
}

# ll_deps <- load_db_metadata_object("LL")$data_dependencies_tables()
# tree1 <- build_reverse_dependency_tree(ll_deps, "ros_common.observer_data")
# print(tree1$path)