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
ROS_ALL_SCHEMAS <- c("ros_meta", "ros_common", "ros_ps", "ros_ll", "ros_pl", "ros_gn")

#'The constants holding the name of schemas used by LL domain.
#'@export
ROS_LL_SCHEMAS <- c("ros_meta", "ros_common", "ros_ll")

#'The constants holding the name of schemas used by PS domain.
#'@export
ROS_PS_SCHEMAS <- c("ros_meta", "ros_common", "ros_ps")

#'The path of db models
DB_METADATA_DIRECTORY <- file.path("./models", IOTC_ROS)

#' Default time-stamp used to suffix any generated files
#' @export
DEFAULT_TIME_STAMP <- "-2026-05-22"

ROS_STANDALONE_TABLES <- list(
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

ros_db_metadata_create <- function(domain,
                                   version = IOTC_ROS,
                                   root_directory = DB_METADATA_DIRECTORY) {
  files <- load_db_metadata(domain, root_directory)
  db_metadata$new(domain,
                  version,
                  withr::with_locale(c(LC_TIME = "C"), format(Sys.time(), '%d %B %Y %H:%M %Z')),
                  files$schemas_comment,
                  files$tables_comment,
                  files$tables_columns,
                  function(foreign_key) { str_length(foreign_key) > 0 & foreign_key %like% "refs_.+|ros_meta.+" },
                  function(foreign_key) { str_length(foreign_key) > 0 & !foreign_key %like% "refs_.+|ros_meta.+" },
                  ROS_STANDALONE_TABLES)
}

ros_extra_report_generator <- function(db_metadata, export_directory, timestamp, report_prefix) {
  deps <- db_metadata$data_dependencies_tables()
  schema_names <- db_metadata$schema_names()
  db_reverse_dependencies <- lapply(schema_names, function(x) {
    if (x %like% "ros_common|ros_meta") { return(NULL) }
    pattern <- sprintf("ros_common.+|%s.+", x)
    deps[origin %like% pattern]
  })
  names(db_reverse_dependencies) <- schema_names
  db_reverse_dependencies <- Filter(Negate(is.null), db_reverse_dependencies)

  for (schema_name in names(db_reverse_dependencies)) {
    graph_location <- file.path(export_directory, sprintf("%s_%s_dependencies_%s%s.html", report_prefix, db_metadata$domain(), schema_name, timestamp))
    out_data_dependencies_graph(schema_name, db_reverse_dependencies[[schema_name]], graph_location, "ros_common.observer_data")
    # Remove generated files we do not want
    files_location <- file.path(export_directory, sprintf("%s_%s_dependencies_%s%s_files", report_prefix, db_metadata$domain(), schema_name, timestamp))
    if (dir.exists(files_location)) {
      unlink(files_location, recursive = TRUE, force = TRUE)
    }
  }
  list(db_reverse_dependencies = db_reverse_dependencies)
}

ros_db_metadata_report_template_supplier <- function(db_metadata, export_directory = "./RMDs", template = "./RMDs/ros_metatadata.Rmd") {
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

ros_db_metadata_generate_report <- function(domain,
                                            version = IOTC_ROS,
                                            timestamp = DEFAULT_TIME_STAMP,
                                            root_directory = DB_METADATA_DIRECTORY,
                                            export_directory = DB_METADATA_DIRECTORY) {
  generate_db_metadata_report(domain = domain,
                              version = version,
                              timestamp = timestamp,
                              root_directory = root_directory,
                              export_directory = export_directory,
                              db_metadata_supplier = ros_db_metadata_create,
                              db_metadata_report_template_supplier = ros_db_metadata_report_template_supplier,
                              extra_report_generator = ros_extra_report_generator,
                              report_prefix = "ROS_database")
}

ll_model <- ros_db_metadata_create(domain = "LL", version = IOTC_ROS, root_directory = DB_METADATA_DIRECTORY)

ll_deps <- ll_model$data_dependencies_tables()
ll_tree <- tree <- build_reverse_dependency_tree(ll_deps, 'ros_common.observer_data', ll_model$standalone_tables())
# print(tree1$path)