# Abstract

This document summarizes all modification specific to the Longline domain (says the ```ros_ll``` schema) of the _Ros_ database coming from version 3.2.0 to 3.3.0.

The directory [sql](sql) contains all _SQL_ scripts to perform this migration.

## Actions to perform on the database to go to version 3.3.0

* [x] Rename the column ```ros_ll.mitigation_measures→underwater_setting``` to ```ros_ll.mitigation_measures→hooks_pods```
* [x] Rename the column ```ros_ll.mitigation_measures→branchline_average_weight_id``` to ```ros_ll.mitigation_measures→average_sinker_weight_id```
* [x] Rename the column ```ros_ll.catch_details→catch_detail_number``` to ```ros_ll.catch_details→catch_detail_original_id```
* [x] Rename the column ```ros_ll.fishing_events→event_number``` to ```.ros_ll.fishing_events→event_original_id```
* [x] Rename the column ```ros_ll.specimens→specimen_number``` to ```ros_ll.specimens→specimen_original_id```
* [x] Rename the column ```ros_ll.tag_details→alternate_tag_number``` to ```ros_ll.tag_details→alternate_tag_original_id```
* [x] Rename the column ```ros_ll.tag_details→tag_number``` to ```ros_ll.tag_details→tag_original_id```
* [x] Change the type of column ```ros_ll.additional_catch_details_on_ssi→brought_on_board``` to boolean (default value false)
* [x] Change the type of column ```ros_ll.additional_catch_details_on_ssi→light_attached_to_branchline``` to boolean (default value false)
* [x] Change the type of column ```ros_ll.additional_catch_details_on_ssi→revival``` to boolean (default value false)
* [x] Change the type of column ```ros_ll.hauling_operations→bird_scaring_device_at_hauler``` to boolean (default value false)
* [x] Change the type of column ```ros_ll.mitigation_measures→branchline_weighted``` to boolean (default value false)
* [x] Change the type of column ```ros_ll.mitigation_measures→hooks_pods``` to boolean (default value false)
* [x] Change the type of column ```ros_ll.mitigation_measures→hooks_set_between_dusk_and_dawn``` to boolean (default value false)
* [x] Change the type of column ```ros_ll.mitigation_measures→minimum_deck_lighting_used``` to boolean (default value false)
* [x] Change the type of column ```ros_ll.observer_data→complete``` to boolean (default value false)
* [x] Change the type of column ```ros_ll.setting_operations→shark_lines_set``` to boolean (default value false)
* [x] Change the type of column ```ros_ll.special_equipment→bait_casting_machine``` to boolean (default value false)
* [x] Change the type of column ```ros_ll.special_equipment→line_hauler``` to boolean (default value false)
* [x] Change the type of column ```ros_ll.special_equipment→line_setter``` to boolean (default value false)
* [x] Change the type of column ```ros_ll.tag_details→tag_recovery``` to boolean (default value false)
* [x] Change the type of column ```ros_ll.tag_details→tag_release``` to boolean (default value false)
* [x] Change the type of column ```ros_ll.tori_line_details→streamers_reach_surface``` to boolean (default value false)
* [x] Remove the column ```ros_ll.general_gear_attributes→line_material_type_code```
* [x] Remove the column ```ros_ll.general_gear_attributes→mainline_length_id```
* [x] Remove the column ```ros_ll.general_gear_attributes→mainline_diameter_id```
* [x] Remove the column ```ros_ll.setting_operations→vms_on```
* [x] Remove the table ```ros_ll.hauling_operations_stunning_methods```
* [x] Remove the table ```ros_ll.observer_data_transhipment_details```
* [x] Add table ```ros_ll.leader_set```
  * column ```id```
  * column ```setting_operation_id```
  * column ```leader_material_type_code``` (foreign key to ```refs_fishery.line_material_types```)
  * column ```percentage_of_branchlines``` (_double_ or _integer_?)
  * column ```total_branchline_minimum_length_id``` (foreign key to ```ros_common.lengths```, unit is ```M```)
  * column ```total_branchline_maximum_length_id``` (foreign key to ```ros_common.lengths```, unit is ```M```)
* [x] Add table ```ros_ll.branchline_configurations_storage```
  * column ```branchline_configuration_id``` (foreign key to ```ros_ll.branchline_configurations```)
  * column ```branchline_storage_code``` (foreign key to ```refs_fishery.branchline_storages```)

