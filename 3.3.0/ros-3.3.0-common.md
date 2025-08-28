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

