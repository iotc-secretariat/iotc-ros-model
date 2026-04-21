library(RPostgres)
library(data.table)
library(stringr)

#' Load the observer resources from the ROS database.
#'
#' The result is a \code{list} with entries:
#' \code{contact_table, contact_role_table, observer_table, observer_identifier_mapping_table, contact_sequence_value}
#'
#' @param connection_supplier connection supplier (the connection will be closed inside the method)
#' @return the loaded list
#' @export
load_observer_ros_tables <- function(connection_supplier) {
  connection <- NULL
  tryCatch({
    connection <- do.call(connection_supplier, args = list())
    list(
      contact_table = load_table("ros_meta", "contact", columns = NULL, connection),
      observer_table = load_table("ros_meta", "observer", columns = NULL, connection),
      focal_point_table = load_table("ros_meta", "focal_point", columns = NULL, connection),
      observer_identifier_mapping_table = load_table("ros_meta", "observer_identifier_mapping", columns = NULL, connection),
      contact_sequence_value = get_sequence_value("ros_meta", "contact", connection)
    )
  }, finally = {
    if (!is.null(connection)) {
      RPostgres::dbDisconnect(connection)
    }
  })
}

add_missing_observers <- function(input_data, db_tables, output_file) {
  contact_table <- db_tables$contact_table
  setkey(contact_table, id)
  observer_table <- db_tables$observer_table
  setkey(observer_table, contact_id)
  full_observer_table <- observer_table[contact_table, on = .(contact_id = id)]
  missing_contact <- unique(input_data[!full_name %in% full_observer_table$full_name], by = c("full_name", "iotc_observer_identifier", "nationality_code"))
  print(sprintf("Found %s observer(s) to add in Ros database", nrow(missing_contact)))
  doublon_full_names <- missing_contact[, .N, .(full_name)][N > 1]
  if (nrow(doublon_full_names) > 0) {
    print(sprintf("Can't add %s new contact(s), there is some doublon on full name: %s", nrow(doublon_full_names), toString(doublon_full_names$full_name)))
  }
  doublon_iotc_observer_identifier <- missing_contact[iotc_observer_identifier %in% db_tables$observer_table$iotc_observer_identifier]
  if (nrow(doublon_iotc_observer_identifier) > 0) {
    print(sprintf("Can't add %s new contact(s), their iotc_observer_identifier are already in database: %s", nrow(doublon_iotc_observer_identifier), toString(doublon_iotc_observer_identifier$iotc_observer_identifier)))
    doublon_observer_table <- full_observer_table[iotc_observer_identifier %in% doublon_iotc_observer_identifier$iotc_observer_identifier, .(contact_id, full_name, iotc_observer_identifier, nationality_code)]
    link_table <- doublon_iotc_observer_identifier[, .(full_name, iotc_observer_identifier, nationality_code)][doublon_observer_table, on = .(iotc_observer_identifier = iotc_observer_identifier)]
    write_file(doublon_observer_table[, .(full_name, nationality_code)], "observers.csv")
    print(link_table)
  }
  missing_contact <- missing_contact[!iotc_observer_identifier %in% doublon_iotc_observer_identifier$iotc_observer_identifier]
  contact_sequence_value <- db_tables$contact_sequence_value
  added_count <- 0
  result <- list()
  total_count <- nrow(missing_contact)
  if (total_count == 0) {
    return(result)
  }
  for (i in seq(1:total_count)) {
    row <- missing_contact[i]
    if (row$full_name %in% doublon_full_names$full_name) {
      next
    }
    if (row$iotc_observer_identifier %in% doublon_iotc_observer_identifier) {
      next
    }
    added_count <- added_count + 1
    contact_id <- contact_sequence_value + added_count
    full_name <- simple_quote(row$full_name)
    result[[full_name]] <- contact_id
    nationality_code <- simple_quote(row$nationality_code)
    iotc_observer_identifier <- simple_quote(row$iotc_observer_identifier)
    national_observer_id <- simple_quote(row$national_observer_id)
    accreditation_year <- ifelse(is.na(row$accreditation_year), "NULL", row$accreditation_year)
    accredited_by <- simple_quote(row$accredited_by)
    deregistered_date <- simple_quote(row$deregistered_date)
    cat(
      sprintf("-- contact[%s/%s] full_name=%s, nationality_code=%s, iotc_observer_identifier=%s, national_observer_id=%s, accreditation_year=%s, accredited_by=%s, deregistered_date=%s", added_count, total_count, full_name, nationality_code,
              iotc_observer_identifier,
              national_observer_id, accreditation_year, accredited_by, deregistered_date),
      sprintf("INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES(%s, %s);", full_name, nationality_code),
      sprintf("INSERT INTO ros_meta.observer(contact_id, iotc_observer_identifier, national_observer_id, accreditation_year, accredited_by, deregistered_date) VALUES(%s, %s, %s, %s, %s, %s);", contact_id, iotc_observer_identifier,
              national_observer_id, accreditation_year, accredited_by, deregistered_date),
      file = output_file, sep = "\n", append = TRUE)
  }
  if (added_count > 0)
    print(sprintf("Added %s observer(s).", added_count))
  result
}

add_missing_legacy_observer_identifiers <- function(input_data, ros_db_tables, added_contacts_id_mapping, output_file) {
  existing_identifiers <- ros_db_tables$
    observer_table$
    iotc_observer_identifier
  old_mapping <- ros_db_tables$observer_identifier_mapping_table[, .(iotc_observer_identifier, legacy_iotc_observer_identifier)]
  new_mapping <- input_data[, .(iotc_observer_identifier, legacy_iotc_observer_identifier)]
  result <- list()
  added_count <- 0
  for (i in seq(1:nrow(new_mapping))) {
    input_row <- new_mapping[i]
    input_iotc_observer_identifier <- input_row$iotc_observer_identifier
    if (!input_iotc_observer_identifier %in% existing_identifiers) {
      # If identifier does not exist in the Ros database, do nothing
      next
    }
    input_legacy_iotc_observer_identifiers <- input_row$legacy_iotc_observer_identifier
    if (is.na(input_legacy_iotc_observer_identifiers)) {
      # we should remove from Ros database? Not a very good idea, these data should never be removed...
      next
    }
    for (input_legacy_iotc_observer_identifier in str_split_1(input_legacy_iotc_observer_identifiers, "\\|")) {
      old_row <- old_mapping[legacy_iotc_observer_identifier == input_legacy_iotc_observer_identifier]
      if (nrow(old_row) == 0) {
        # Need to add it
        added_count <- added_count + 1
        result[[input_legacy_iotc_observer_identifier]] <- input_iotc_observer_identifier
        cat(
          sprintf("INSERT INTO ros_meta.observer_identifier_mapping(legacy_iotc_observer_identifier, iotc_observer_identifier) VALUES(%s, %s);", simple_quote(input_legacy_iotc_observer_identifier), simple_quote(input_iotc_observer_identifier)),
          file = output_file, sep = "\n", append = TRUE)
      }
    }
  }
  if (added_count > 0)
    print(sprintf("Added %s observer legacy identifier mapping(s).", added_count))
  result
}

add_missing_contacts <- function(contacts_to_add, db_tables, output_file) {
  safe_full_names <- as.data.table(unlist(lapply(unique(contacts_to_add), normalize_full_name)))
  names(safe_full_names) <- c("full_name")
  contact_table <- db_tables$contact_table
  missing_contact <- safe_full_names[!full_name %in% contact_table$full_name]
  print(sprintf("Found %s observer(s) to add in Ros database", nrow(missing_contact)))
  contact_sequence_value <- db_tables$contact_sequence_value
  added_count <- 0
  result <- list()
  total_count <- nrow(missing_contact)
  if (total_count == 0) {
    return(result)
  }
  for (i in seq(1:total_count)) {
    row <- missing_contact[i]
    added_count <- added_count + 1
    contact_id <- contact_sequence_value + added_count
    full_name <- simple_quote(row$full_name)
    result[[full_name]] <- contact_id
    cat(
      sprintf("-- contact[%s/%s] full_name=%s", added_count, total_count, full_name),
      sprintf("INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES(%s, NULL);", full_name),
      file = output_file, sep = "\n", append = TRUE)
  }
  if (added_count > 0)
    print(sprintf("Added %s observer(s).", added_count))
  result
}

run <- function() {

  registry_observers <- load_observers("../iotc-registries/ros/observers.csv")
  ros_db_tables <- load_observer_ros_tables(DB_IOTC_ROS)
  missing_observers <- add_missing_observers(registry_observers, ros_db_tables, "../iotc-ros-model/3.3.0/sql/add_observers.sql")
  missing_legacy_observer_identifiers <- add_missing_legacy_observer_identifiers(registry_observers, ros_db_tables, missing_observers, "../iotc-ros-model/3.3.0/sql/update_observer_legacy_mapping_from_registry.sql")

  contacts_to_add <- list(
    "Aitor Santiago Ortega",
    "Andoni Kaltzakorta Zabala",
    "Bittor Atxurra Barainka",
    "CHEN MING YU",
    "Iker Galbaniatu",
    "Jokin Carrasco",
    "Julio García Lorenzo",
    "Pascal Landrein Jean-Jacques",
    "Unax Panciano Sánchez",
    "Carlos Vidal",
    "CHEN MING YU",
    "Iñaki Iradi Garmendia",
    "José Luis Durán Diz",
    "José Manuel Pinazas",
    "Josu Arana Iñarra",
    "Julen Laucircia Martínez",
    "Patxi Valadés",
    "Txabi I. San Pedro"
  )

  missing_contacts <- add_missing_contacts(contacts_to_add, ros_db_tables, "../iotc-ros-model/3.3.0/sql/add_observers.sql")
}
