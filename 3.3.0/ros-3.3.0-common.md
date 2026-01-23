# Abstract

This document summarizes all modification specific to the common domain (says the ```ros_common``` schema) of the _Ros_ database coming from version 3.2.0 to 3.3.0.

The directory [sql](sql) contains all _SQL_ scripts to perform the migration.

## Actions to perform on the database to go to version 3.3.0

* [x] Add a foreign key on ```ros_common.reasons_for_days_lost→inoperativity_reason``` to ```refs_fishery.reasons_days_lost→code```
* [ ] ~~Rename column ```ros_common.locations→NAME``` to ```ros_common.locations→port_code``` and add a foreign key to ```refs_admin.ports→code```~~ (can't do this since there is some ```At Sea``` locations)
* [x] Rename the column ```ros_common.measured_lengths→curved``` to ```ros_common.measured_lengths→straight``` and inverse existing values
* [x] Rename the column ```ros_common.carrier_vessel_identification→vessel_registration_number``` to ```ros_common.carrier_vessel_identification→vessel_registration_original_id```
* [x] Rename the column ```ros_common.general_vessel_and_trip_information→trip_number``` to ```ros_common.general_vessel_and_trip_information→trip_original_id```
* [x] Change the type of column ```ros_common.measured_lengths→straight``` to boolean (default value false)
* [x] Change the type of column ```ros_common.vessel_electronics→ais``` to boolean (default value false)
* [x] Change the type of column ```ros_common.vessel_electronics→depth_sounder``` to boolean (default value false)
* [x] Change the type of column ```ros_common.vessel_electronics→doppler_current_meter``` to boolean (default value false)
* [x] Change the type of column ```ros_common.vessel_electronics→expendable_bathythermographs``` to boolean (default value false)
* [x] Change the type of column ```ros_common.vessel_electronics→fisheries_information_services``` to boolean (default value false)
* [x] Change the type of column ```ros_common.vessel_electronics→gps``` to boolean (default value false)
* [x] Change the type of column ```ros_common.vessel_electronics→hf_radios``` to boolean (default value false)
* [x] Change the type of column ```ros_common.vessel_electronics→radars``` to boolean (default value false)
* [x] Change the type of column ```ros_common.vessel_electronics→satellite_communication_systems``` to boolean (default value false)
* [x] Change the type of column ```ros_common.vessel_electronics→sonar``` to boolean (default value false)
* [x] Change the type of column ```ros_common.vessel_electronics→track_plotter``` to boolean (default value false)
* [x] Change the type of column ```ros_common.vessel_electronics→vhf_radios``` to boolean (default value false)
* [x] Change the type of column ```ros_common.vessel_electronics→vms``` to boolean (default value false)
* [x] Remove the column ```ros_common.observer_identification→nationality_code``` (need to update some views to be able to perform this one)
* [x] Remove the column ```ros_common.vessel_owner_and_personnel.registered_vessel_owner_id```
* [x] Remove the column ```ros_common.vessel_owner_and_personnel.charter_or_operator_id```
* [x] Remove the column ```ros_common.vessel_electronics→sea_surface_temperature_gauge```
* [x] Remove the column ```ros_common.vessel_electronics→weather_facsimile```
* [x] Remove the table ```ros_common.transhipment_details```
* [x] Remove the table ```ros_common.transhipment_details_product_transhipped```
* [x] Remove the table ```ros_common.species_by_product_type```
* [x] Remove the table ```ros_common.texts``` (no more used)
* [x] Remove the table ```ros_common.vessel_identification_email```
* [x] Remove the table ```ros_common.vessel_identification_fax```
* [x] Remove the table ```ros_common.vessel_identification_phone```
* [x] Remove the table ```ros_common.measured_weights``` (never used)

## Simplify the trip scope model

Actually, the model is quite complex, so we decided to simplify it by removing some tables and rearranging some others.

The ```ros_common.general_vessel_and_trip_information``` table is the entry point to a trip; it contains:

- ```trip_original_id``` column is external data (so nothing more to do for it)
- ```observer_id``` and ```vessel_identification_id``` columns are pointing to observer registry and to vessel registry, those data do not depend on the trip, ids are legimit, but they could be moved to new tables (see below)
- ```observed_trip_summary_id``` points to ```ros_common.observed_trip_summary``` table, we should move this table data inside the ```ros_common.general_vessel_and_trip_information``` table or add ```observer_id``` column on it and remove his own id to use the ```ros_common.general_vessel_and_trip_information``` id
- ```observer_trip_detail_id``` points to ```ros_common.observer_trip_details``` table, we should move this table data inside the ```ros_common.general_vessel_and_trip_information``` table, we do not find any reason to keep this extra table
- ```vessel_attributes_id```, ```vessel_electronics_id```,  ```vessel_owner_and_personnel_id``` and ```vessel_trip_details_id``` points to ```ros_common.vessel_attributes```, ```ros_common.vessel_electronics```, ```ros_common.vessel_owner_and_personnel``` and ```ros_common.vessel_trip_details``` tables. Their scopes are the same as the trip, there is no point that they have their own id.
  Moreover, there is no extra-value to keep them in a separate table; we should merge them into a new table ```ros_common.trip_vessel_details``` and use the ```ros_common.general_vessel_and_trip_information``` id as the primary key.

The ```ros_common.general_vessel_and_trip_information``` table name should be changed to ```ros_common.trip```.

### New model proposal

#### Table ```ros_common.trip```

This is the new entry point to a trip, it will contain only two columns:

1. ```id```
2. ```trip_original_id```

Observer and vessel information will be linked to his trip by the ```ros_common.trip.id```.

#### Table ```ros_common.trip_observer```

This table will contain all information about the observer (it has no own id and will use the ```trip.id```), here is his definition:

1. ```trip_id``` column is pointing to ```ros_common.trip``` table and is the primary key
2. ```observer_id``` column is pointing to ```ros_common.observer_identification``` table (moved from ```ros_common.general_vessel_and_trip_information```)
3. ```date_time_disembarkation``` (moved from ```ros_common.observer_trip_details```)
4. ```date_time_embarkation``` (moved from ```ros_common.observer_trip_details```)
5. ```disembarkation_location_id``` (moved from ```ros_common.observer_trip_details```)
6. ```embarkation_location_id``` (moved from ```ros_common.observer_trip_details```)

#### Table ```ros_common.trip_vessel```

This table will contain all information about the vessel (it has no own id and will use the ```trip.id```), here is his definition:

1. ```trip_id``` column is pointing to ```ros_common.trip``` table and is the primary key
2. ```vessel_identification_id``` column is pointing to ```ros_common.vessel_identification``` table (moved from ```ros_common.general_vessel_and_trip_information```)
3. all columns from ```ros_common.observed_trip_summary``` (except the ```id``` column)
4. all columns from ```ros_common.vessel_attributes``` (except the ```id``` column)
5. all columns from ```ros_common.vessel_electronics``` (except the ```id``` column)
6. all columns from ```ros_common.vessel_owner_and_personnel``` (except the ```id``` column)
7. all columns from ```ros_common.vessel_trip_details``` (except the ```id``` column)

All related tables around ```ros_common.vessel_attributes``` should be renamed to ```trip_vessel_xxx```:

1. ```ros_common.vessel_attributes_fish_preservation_method``` will be renamed to ```ros_common.trip_vessel_fish_preservation_method```
2. ```ros_common.vessel_attributes_fish_storage_type``` will be renamed to ```ros_common.trip_vessel_fish_storage_type```
3. ```ros_common.vessel_attributes_main_engines``` will be renamed to ```ros_common.trip_vessel_main_engines```


### Summary

#### Table ```ros_common.trip```

This is the entry point for the trip information, with two columns:

| column name      | original table                      | original column  |
|------------------|-------------------------------------|------------------|
| id               | general_vessel_and_trip_information | id               |
| trip_original_id | general_vessel_and_trip_information | trip_original_id |

## Table ```ros_common.trip_observer```

This is the entry point for the observer information on a trip, with six columns:

| column name                | original table                      | original column            |
|----------------------------|-------------------------------------|----------------------------|
| trip_id                    | general_vessel_and_trip_information | id                         |
| observer_id                | general_vessel_and_trip_information | observer_identification_id |
| date_time_disembarkation   | observer_trip_details               | date_time_embarkation      |
| date_time_embarkation      | observer_trip_details               | date_time_disembarkation   |
| disembarkation_location_id | observer_trip_details               | embarkation_location_id    |
| embarkation_location_id    | observer_trip_details               | disembarkation_location_id |

## Table ```ros_common.trip_vessel```

This is the entry point for the vessel information on a trip, with 34 columns:

| column name                                              | original table                      | original column                                          |
|----------------------------------------------------------|-------------------------------------|----------------------------------------------------------|
| trip_id                                                  | general_vessel_and_trip_information | id                                                       |
| vessel_id                                                | general_vessel_and_trip_information | vessel_identification_id                                 |
| number_of_active_fishing_days                            | observed_trip_summary               | number_of_active_fishing_days                            |
| number_of_conducted_fishing_events_with_observer_onboard | observed_trip_summary               | number_of_conducted_fishing_events_with_observer_onboard |
| number_of_days_in_fishing_area                           | observed_trip_summary               | number_of_days_in_fishing_area                           |
| number_of_days_lost                                      | observed_trip_summary               | number_of_days_lost                                      |
| number_of_days_searching                                 | observed_trip_summary               | number_of_days_searching                                 |
| number_of_days_transiting                                | observed_trip_summary               | number_of_days_transiting                                |
| number_of_observed_fishing_events                        | observed_trip_summary               | number_of_observed_fishing_events                        |
| loa_id                                                   | vessel_attributes                   | loa_id                                                   |
| autonomy_range_id                                        | vessel_attributes                   | autonomy_range_id                                        |
| fish_storage_capacity_id                                 | vessel_attributes                   | fish_storage_capacity_id                                 |
| tonnage_id                                               | vessel_attributes                   | tonnage_id                                               |
| hull_material_code                                       | vessel_attributes                   | hull_material_code                                       |
| ais                                                      | vessel_electronics                  | ais                                                      |
| gps                                                      | vessel_electronics                  | gps                                                      |
| vms                                                      | vessel_electronics                  | vms                                                      |
| depth_sounder                                            | vessel_electronics                  | depth_sounder                                            |
| doppler_current_meter                                    | vessel_electronics                  | doppler_current_meter                                    |
| expendable_bathythermographs                             | vessel_electronics                  | expendable_bathythermographs                             |
| fisheries_information_services                           | vessel_electronics                  | fisheries_information_services                           |
| hf_radios                                                | vessel_electronics                  | hf_radios                                                |
| radars                                                   | vessel_electronics                  | radars                                                   |
| satellite_communication_systems                          | vessel_electronics                  | satellite_communication_systems                          |
| sonar                                                    | vessel_electronics                  | sonar                                                    |
| track_plotter                                            | vessel_electronics                  | track_plotter                                            |
| vhf_radios                                               | vessel_electronics                  | vhf_radios                                               |
| number_of_crew                                           | vessel_owner_and_personnel          | number_of_crew                                           |
| fishing_master_id                                        | vessel_owner_and_personnel          | fishing_master_id                                        |
| skipper_id                                               | vessel_owner_and_personnel          | skipper_id                                               |
| date_time_vessel_returned_to_port                        | vessel_trip_details                 | date_time_vessel_returned_to_port                        |
| date_time_vessel_sailed                                  | vessel_trip_details                 | date_time_vessel_sailed                                  |
| departure_port_code                                      | vessel_trip_details                 | departure_port_code                                      |
| return_port_code                                         | vessel_trip_details                 | return_port_code                                         |

#### Table ```ros_common.trip_vessel_fish_preservation_method```

To replace ```ros_common.vessel_attributes_fish_preservation_method``` table.

| column name                   | original table                             | original column               |
|-------------------------------|--------------------------------------------|-------------------------------|
| trip_id                       | general_vessel_and_trip_information        | id                            |
| fish_preservation_method_code | vessel_attributes_fish_preservation_method | fish_preservation_method_code |

#### Table ```ros_common.trip_vessel_fish_storage_type```

To replace ```ros_common.vessel_attributes_fish_storage_type``` table.

| column name            | original table                      | original column        |
|------------------------|-------------------------------------|------------------------|
| trip_id                | general_vessel_and_trip_information | id                     |
| fish_storage_type_code | vessel_attributes_fish_storage_type | fish_storage_type_code |

#### Table ```ros_common.trip_vessel_main_engines```

To replace ```ros_common.vessel_attributes_main_engines``` table.

| column name    | original table                      | original column |
|----------------|-------------------------------------|-----------------|
| trip_id        | general_vessel_and_trip_information | id              |
| main_engine_id | vessel_attributes_main_engines      | main_engine_id  |

#### Adapt other tables

In each subdomain ```observer_data``` tables, replace column ```vessel_and_trip_information_id``` by ```trip_id```.

In table ```ros_common.reasons_for_days_lost```, replace column ```observed_trip_summary_id``` by ```trip_id```.
