# generate_indexes.R

library(rmarkdown)


# -------------------------------------------------------------------------
# Configuration
# -------------------------------------------------------------------------

# Root directory to scan
root_dir <- "doc"

# R Markdown template used to generate each index.html
template_rmd <- "RMDs/directory_index.Rmd"

# If TRUE, folders with no subdirectories and no HTML files are skipped
skip_empty_directories <- TRUE

# -------------------------------------------------------------------------
# Helpers
# -------------------------------------------------------------------------

normalize_path_safe <- function(path, must_work = FALSE) {
  normalizePath(
    path,
    winslash = "/",
    mustWork = must_work
  )
}

get_relative_path <- function(path, root) {
  path_abs <- normalize_path_safe(path, must_work = FALSE)
  root_abs <- normalize_path_safe(root, must_work = TRUE)

  relative <- sub(
    pattern = paste0("^", gsub("([.|()\\^{}+$*?\\[\\]\\\\])", "\\\\\\1", root_abs), "/?"),
    replacement = "",
    x = path_abs
  )

  if (identical(relative, "") || identical(relative, ".")) {
    basename(root_abs)
  } else {
    relative
  }
}

get_directory_content <- function(dir) {
  entries <- list.files(
    path = dir,
    all.files = FALSE,
    no.. = TRUE,
    full.names = FALSE
  )

  if (length(entries) == 0) {
    return(list(
      directories = character(),
      html_files = character()
    ))
  }

  full_paths <- file.path(dir, entries)
  info <- file.info(full_paths)

  directories <- entries[isTRUE(length(entries) > 0) & info$isdir]

  html_files <- entries[
    !info$isdir &
      grepl("\\.html?$", entries, ignore.case = TRUE) &
      tolower(entries) != "index.html"
  ]

  list(
    directories = sort(directories),
    html_files = sort(html_files)
  )
}

generate_index_for_directory <- function(dir, root_dir, template_rmd) {
  content <- get_directory_content(dir)

  directories <- content$directories
  html_files <- content$html_files

  if (
    isTRUE(skip_empty_directories) &&
      length(directories) == 0 &&
      length(html_files) == 0
  ) {
    message("Skipped empty directory: ", dir)
    return(invisible(FALSE))
  }

  relative_dir <- get_relative_path(dir, root_dir)

  rmarkdown::render(
    input = template_rmd,
    output_file = "index.html",
    output_dir = dir,
    params = list(
      current_dir = dir,
      relative_dir = relative_dir,
      directories = directories,
      html_files = html_files
    ),
    envir = new.env(parent = globalenv()),
    quiet = TRUE
  )

  message("Generated: ", file.path(dir, "index.html"))

  invisible(TRUE)
}

# -------------------------------------------------------------------------
# Checks
# -------------------------------------------------------------------------

if (!dir.exists(root_dir)) {
  stop("Root directory does not exist: ", root_dir)
}

if (!file.exists(template_rmd)) {
  stop("R Markdown template does not exist: ", template_rmd)
}

root_dir <- normalize_path_safe(root_dir, must_work = TRUE)
template_rmd <- normalize_path_safe(template_rmd, must_work = TRUE)

# -------------------------------------------------------------------------
# Generate indexes
# -------------------------------------------------------------------------

all_dirs <- c(
  root_dir,
  list.dirs(
    path = root_dir,
    recursive = TRUE,
    full.names = TRUE
  )
)

generated <- 0
skipped <- 0

for (dir in all_dirs) {
  ok <- generate_index_for_directory(
    dir = dir,
    root_dir = root_dir,
    template_rmd = template_rmd
  )

  if (isTRUE(ok)) {
    generated <- generated + 1
  } else {
    skipped <- skipped + 1
  }
}

message("Done.")
message("Generated indexes: ", generated)
message("Skipped directories: ", skipped)