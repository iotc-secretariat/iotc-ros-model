# Abstract

This document summarizes all modification specific to the Pure seine domain (says the ```ros_ps``` schema) of the _Ros_ database coming from version 3.2.0 to 3.3.0.

The directory [sql](sql) contains all _SQL_ scripts to perform the migration.

## Actions to perform on the database to go to version 3.3.0

* [x] Rename the column ```ros_ps.catch_details→catch_detail_number``` to ```ros_ps.catch_details→catch_detail_original_id```
* [x] Rename the column ```ros_ps.fishing_events→event_number``` to ```ros_ps.fishing_events→event_original_id```
* [x] Rename the column ```ros_ps.specimens→specimen_number``` to ```ros_ps.specimens→specimen_original_id```
* [x] Rename the column ```ros_ps.tag_details→alternate_tag_number``` to ```ros_ps.tag_details→alternate_tag_original_id```
* [x] Rename the column ```ros_ps.tag_details→tag_number``` to ```ros_ps.tag_details→tag_original_id```
* [x] Change the type of column ```ros_ps.additional_catch_details_on_ssi→brought_on_board``` to boolean (default value false)
* [x] Change the type of column ```ros_ps.additional_catch_details_on_ssi→revival``` to boolean (default value false)
* [x] Change the type of column ```ros_ps.cetaceans_whale_shark_sightings→caught_inside_the_net``` to boolean (default value false)
* [x] Change the type of column ```ros_ps.cetaceans_whale_shark_sightings→sighting_occurred_before_setting``` to boolean (default value false)
* [x] Change the type of column ```ros_ps.object_details→equipped_with_artificial_lights_at_deploy``` to boolean (default value false)
* [x] Change the type of column ```ros_ps.object_details→equipped_with_artificial_lights_on_retrieval``` to boolean (default value false)
* [x] Change the type of column ```ros_ps.observer_data→complete``` to boolean (default value false)
* [x] Change the type of column ```ros_ps.special_equipment→power_block``` to boolean (default value false)
* [x] Change the type of column ```ros_ps.special_equipment→purse_winch``` to boolean (default value false)
* [x] Change the type of column ```ros_ps.tag_details→tag_recovery``` to boolean (default value false)
* [x] Change the type of column ```ros_ps.tag_details→tag_release``` to boolean (default value false)
* [x] Remove the column ```ros_ps.general_gear_attributes→skiff_power_id```
* [x] Remove the column ```ros_ps.setting_operations→wind_scale_code```
* [x] Remove the column ```ros_ps.catch_details→additional_catch_details_non_target_species_id```
* [x] Remove the table ```ros_ps.observer_data_transhipment_details```
* [x] Remove the table ```ros_ps.support_vessel_details```
* [x] Remove the table ```ros_ps.current_details```
* [x] Rename ```ps_xxx``` sequence to ```xxx```
