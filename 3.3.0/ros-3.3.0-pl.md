# Abstract

This document summarizes all modification specific to the Pole & Line domain (says the ```ros_pl``` schema) of the _Ros_ database coming from version 3.2.0 to 3.3.0.

The directory [sql](sql) contains all _SQL_ scripts to perform the migration.

## Actions to perform on the database to go to version 3.3.0

* [x] Rename the column ```ros_pl.bait_fishing_events→event_number``` to ```ros_pl.bait_fishing_events→event_original_id```
* [x] Rename the column ```ros_pl.specimens→specimen_number``` to ```ros_pl.specimens→specimen_original_id```
* [x] Rename the column ```ros_pl.tag_details→alternate_tag_number``` to ```ros_pl.tag_details→alternate_tag_original_id```
* [x] Rename the column ```ros_pl.tag_details→tag_number``` to ```ros_pl.tag_details→tag_original_id```
* [x] Rename the column ```ros_pl.tuna_fishing_events→event_number``` to ```ros_pl.tuna_fishing_events→event_original_id```
* [x] Change the type of column ```ros_pl.additional_catch_details_on_ssi→brought_on_board``` to boolean (default value false)
* [x] Change the type of column ```ros_pl.additional_catch_details_on_ssi→revival``` to boolean (default value false)
* [x] Change the type of column ```ros_pl.observer_data→complete``` to boolean (default value false)
* [x] Change the type of column ```ros_pl.tag_details→tag_recovery``` to boolean (default value false)
* [x] Change the type of column ```ros_pl.tag_details→tag_release``` to boolean (default value false)
* [x] Change the type of column ```ros_pl.tuna_fishing_operations→bait_used``` to boolean (default value false)
* [x] Remove the column ```ros_pl.general_gear_attributes→vessel_uses_lures_or_jiggers```
* [x] Remove the column ```ros_pl.tuna_fishing_operations→wind_scale_code```
* [x] Remove the column ```ros_pl.tuna_fishing_operations→sampling_protocol_code```
* [x] Remove the column ```ros_pl.object_details→equipped_with_artificial_lights```
* [x] Remove the column ```ros_pl.catch_details→catch_detail_number```
* [x] Remove the column ```ros_pl.bait_fishing_operations→distance_from_the_coast_id```
* [x] Remove the column ```ros_pl.bait_fishing_operations→wind_scale_code```
* [x] Remove the column ```ros_pl.bait_fishing_operations→bait_school_detection_method_code```
* [x] Remove the column ```ros_pl.bait_fishing_events→object_detail_id```
* [x] Remove the column ```ros_pl.bait_fishing_event_pl_catch_detail→catch_detail_id```
* [ ] Add the column ```ros_pl.bait_fishing_event_pl_catch_detail→estimated_weight_id```
* [x] Remove the table ```ros_pl.observer_data_transhipment_details```
* [x] Remove the table ```ros_pl.bait_fishing_operations_cl_school_sighting_cues```
* [x] Rename ```pl_xxx``` sequence to ```xxx```
* 
**FIXME:** To be continued for baits specimen information, additional details on non target species, additional catch details on ssi, biometric information, etc.

