# Abstract

This document summarizes all modification specific to the GN domain (says the ```ros_ps``` schema) of the _Ros_ database coming from version 3.2.0 to 3.3.0.

The directory [sql](sql) contains all _SQL_ scripts to perform the migration.

## Actions to perform on the database to go to version 3.3.0

* [x] Rename the column ```ros_gn.catch_details→catch_detail_number``` to ```ros_gn.catch_details→catch_detail_original_id```
* [x] Rename the column ```ros_gn.fishing_events→event_number``` to ```ros_gn.fishing_events→event_original_id```
* [x] Rename the column ```ros_gn.gillnet_configuration→gillnet_sequential_number``` to ```ros_gn.gillnet_configuration→gillnet_sequential_original_id```
* [x] Rename the column ```ros_gn.setting_operations→gillnet_sequential_number``` to ```ros_gn.setting_operations→gillnet_sequential_original_id```
* [x] Rename the column ```ros_gn.specimens→specimen_number``` to ```ros_gn.specimens→specimen_original_id```
* [x] Rename the column ```ros_gn.tag_details→alternate_tag_number``` to ```ros_gn.tag_details→alternate_tag_original_id```
* [x] Rename the column ```ros_gn.tag_details→tag_number``` to ```ros_gn.tag_details→tag_original_id```
* [x] Change the type of column ```ros_gn.additional_catch_details_on_ssi→brought_on_board``` type to boolean (default value false)
* [x] Change the type of column ```ros_gn.additional_catch_details_on_ssi→revival``` type to boolean (default value false)
* [x] Change the type of column ```ros_gn.gillnet_configuration→droplines_used``` type to boolean (default value false)
* [x] Change the type of column ```ros_gn.gillnet_configuration→panels_stacked``` type to boolean (default value false)
* [x] Change the type of column ```ros_gn.mitigation_measures→mitigation_measures``` type to boolean (default value false)
* [x] Change the type of column ```ros_gn.observer_data→complete``` type to boolean (default value false)
* [x] Change the type of column ```ros_gn.special_equipment→net_drum_hauler``` type to boolean (default value false)
* [x] Change the type of column ```ros_gn.tag_details→tag_recovery``` type to boolean (default value false)
* [x] Change the type of column ```ros_gn.tag_details→tag_release``` type to boolean (default value false)
* [x] Remove the table ```ros_gn.observer_data_transhipment_details```
* [x] Rename ```gn_xxx``` sequence to ```xxx```

