-- Rename the column ```ros_gn.catch_details→catch_detail_number``` to ```ros_gn.catch_details→catch_detail_original_id```
ALTER TABLE ros_gn.catch_details RENAME catch_detail_number TO catch_detail_original_id;
-- Rename the column ```ros_gn.fishing_events→event_number``` to ```ros_gn.fishing_events→event_original_id```
ALTER TABLE ros_gn.fishing_events RENAME event_number TO event_original_id;
-- Rename the column ```ros_gn.gillnet_configuration→gillnet_sequential_number``` to ```ros_gn.gillnet_configuration→gillnet_sequential_original_id```
ALTER TABLE ros_gn.gillnet_configuration RENAME gillnet_sequential_number TO gillnet_sequential_original_id;
-- Rename the column ```ros_gn.setting_operations→gillnet_sequential_number``` to ```ros_gn.setting_operations→gillnet_sequential_original_id```
ALTER TABLE ros_gn.setting_operations RENAME gillnet_sequential_number TO gillnet_sequential_original_id;
-- Rename the column ```ros_gn.specimens→specimen_number``` to ```ros_gn.specimens→specimen_original_id```
ALTER TABLE ros_gn.specimens RENAME specimen_number TO specimen_original_id;
-- Rename the column ```ros_gn.tag_details→alternate_tag_number``` to ```ros_gn.tag_details→alternate_tag_original_id```
ALTER TABLE ros_gn.tag_details RENAME alternate_tag_number TO alternate_tag_original_id;
-- Rename the column ```ros_gn.tag_details→tag_number``` to ```ros_gn.tag_details→tag_original_id```
ALTER TABLE ros_gn.tag_details RENAME tag_number TO tag_original_id;

-- Change the type of column ```ros_gn.additional_catch_details_on_ssi→brought_on_board``` type to boolean (default value false)
ALTER TABLE ros_gn.additional_catch_details_on_ssi ADD COLUMN brought_on_board2 BOOLEAN DEFAULT FALSE;
UPDATE ros_gn.additional_catch_details_on_ssi SET brought_on_board2 = case when brought_on_board = 0 then FALSE when brought_on_board = 1 then TRUE end;
ALTER TABLE ros_gn.additional_catch_details_on_ssi DROP COLUMN brought_on_board;
ALTER TABLE ros_gn.additional_catch_details_on_ssi RENAME brought_on_board2 TO brought_on_board;
-- Change the type of column ```ros_gn.additional_catch_details_on_ssi→revival``` type to boolean (default value false)
ALTER TABLE ros_gn.additional_catch_details_on_ssi ADD COLUMN revival2 BOOLEAN DEFAULT FALSE;
UPDATE ros_gn.additional_catch_details_on_ssi SET revival2 = case when revival = 0 then FALSE when revival = 1 then TRUE end;
ALTER TABLE ros_gn.additional_catch_details_on_ssi DROP COLUMN revival;
ALTER TABLE ros_gn.additional_catch_details_on_ssi RENAME revival2 TO revival;
-- Change the type of column ```ros_gn.gillnet_configuration→droplines_used``` type to boolean (default value false)
ALTER TABLE ros_gn.gillnet_configuration ADD COLUMN droplines_used2 BOOLEAN DEFAULT FALSE;
UPDATE ros_gn.gillnet_configuration SET droplines_used2 = case when droplines_used = 0 then FALSE when droplines_used = 1 then TRUE end;
ALTER TABLE ros_gn.gillnet_configuration DROP COLUMN droplines_used;
ALTER TABLE ros_gn.gillnet_configuration RENAME droplines_used2 TO droplines_used;
-- Change the type of column ```ros_gn.gillnet_configuration→panels_stacked``` type to boolean (default value false)
ALTER TABLE ros_gn.gillnet_configuration ADD COLUMN panels_stacked2 BOOLEAN DEFAULT FALSE;
UPDATE ros_gn.gillnet_configuration SET panels_stacked2 = case when panels_stacked = 0 then FALSE when panels_stacked = 1 then TRUE end;
ALTER TABLE ros_gn.gillnet_configuration DROP COLUMN panels_stacked;
ALTER TABLE ros_gn.gillnet_configuration RENAME panels_stacked2 TO panels_stacked;
-- Change the type of column ```ros_gn.mitigation_measures→mitigation_measures``` type to boolean (default value false)
ALTER TABLE ros_gn.mitigation_measures ADD COLUMN mitigation_measures2 BOOLEAN DEFAULT FALSE;
UPDATE ros_gn.mitigation_measures SET mitigation_measures2 = case when mitigation_measures = 0 then FALSE when mitigation_measures = 1 then TRUE end;
ALTER TABLE ros_gn.mitigation_measures DROP COLUMN mitigation_measures;
ALTER TABLE ros_gn.mitigation_measures RENAME mitigation_measures2 TO mitigation_measures;
-- Change the type of column ```ros_gn.observer_data→complete``` type to boolean (default value false)
ALTER TABLE ros_gn.observer_data ADD COLUMN complete2 BOOLEAN DEFAULT FALSE NOT NULL;
UPDATE ros_gn.observer_data SET complete2 = case when complete = 0 then FALSE when complete = 1 then TRUE end;
ALTER TABLE ros_gn.observer_data DROP COLUMN complete;
ALTER TABLE ros_gn.observer_data RENAME complete2 TO complete;
-- Change the type of column ```ros_gn.special_equipment→net_drum_hauler``` type to boolean (default value false)
ALTER TABLE ros_gn.special_equipment ADD COLUMN net_drum_hauler2 BOOLEAN DEFAULT FALSE;
UPDATE ros_gn.special_equipment SET net_drum_hauler2 = case when net_drum_hauler = 0 then FALSE when net_drum_hauler = 1 then TRUE end;
ALTER TABLE ros_gn.special_equipment DROP COLUMN net_drum_hauler;
ALTER TABLE ros_gn.special_equipment RENAME net_drum_hauler2 TO net_drum_hauler;
-- Change the type of column ```ros_gn.tag_details→tag_recovery``` type to boolean (default value false)
ALTER TABLE ros_gn.tag_details ADD COLUMN tag_recovery2 BOOLEAN DEFAULT FALSE;
UPDATE ros_gn.tag_details SET tag_recovery2 = case when tag_recovery = 0 then FALSE when tag_recovery = 1 then TRUE end;
ALTER TABLE ros_gn.tag_details DROP COLUMN tag_recovery;
ALTER TABLE ros_gn.tag_details RENAME tag_recovery2 TO tag_recovery;
-- Change the type of column ```ros_gn.tag_details→tag_release``` type to boolean (default value false)
ALTER TABLE ros_gn.tag_details ADD COLUMN tag_release2 BOOLEAN DEFAULT FALSE;
UPDATE ros_gn.tag_details SET tag_release2 = case when tag_release = 0 then FALSE when tag_release = 1 then TRUE end;
ALTER TABLE ros_gn.tag_details DROP COLUMN tag_release;
ALTER TABLE ros_gn.tag_details RENAME tag_release2 TO tag_release;