-- Remove the column ```ros_pl.general_gear_attributes→vessel_uses_lures_or_jiggers```
ALTER TABLE ros_pl.general_gear_attributes DROP COLUMN vessel_uses_lures_or_jiggers;

-- Remove the column ```ros_pl.tuna_fishing_operations→wind_scale_code```
ALTER TABLE ros_pl.tuna_fishing_operations DROP COLUMN wind_scale_code;

-- Remove the column ```ros_pl.tuna_fishing_operations→sampling_protocol_code```
ALTER TABLE ros_pl.tuna_fishing_operations DROP COLUMN sampling_protocol_code;

-- Remove the column ```ros_pl.object_details→equipped_with_artificial_lights```
ALTER TABLE ros_pl.object_details DROP COLUMN equipped_with_artificial_lights;

-- Remove the column ```ros_pl.catch_details→catch_detail_number```
ALTER TABLE ros_pl.catch_details DROP COLUMN catch_detail_number;

-- Remove the column ```ros_pl.bait_fishing_operations→distance_from_the_coast_id```
ALTER TABLE ros_pl.bait_fishing_operations DROP COLUMN distance_from_the_coast_id;

-- Remove the column ```ros_pl.bait_fishing_operations→wind_scale_code```
ALTER TABLE ros_pl.bait_fishing_operations DROP COLUMN wind_scale_code;

-- Remove the column ```ros_pl.bait_fishing_operations→bait_school_detection_method_code```
ALTER TABLE ros_pl.bait_fishing_operations DROP COLUMN bait_school_detection_method_code;

-- Remove the column ```ros_pl.bait_fishing_events→object_detail_id```
ALTER TABLE ros_pl.bait_fishing_events DROP COLUMN object_detail_id;

-- Remove the column ```ros_pl.bait_fishing_event_pl_catch_detail→catch_detail_id```
ALTER TABLE ros_pl.bait_fishing_event_pl_catch_detail DROP COLUMN catch_detail_id;

-- Rename the column ```ros_pl.bait_fishing_events→event_number``` to ```ros_pl.bait_fishing_events→event_original_id```
ALTER TABLE ros_pl.bait_fishing_events RENAME event_number TO event_original_id;
-- Rename the column ```ros_pl.specimens→specimen_number``` to ```ros_pl.specimens→specimen_original_id```
ALTER TABLE ros_pl.specimens RENAME specimen_number TO specimen_original_id;
-- Rename the column ```ros_pl.tag_details→alternate_tag_number``` to ```ros_pl.tag_details→alternate_tag_original_id```
ALTER TABLE ros_pl.tag_details RENAME alternate_tag_number TO alternate_tag_original_id;
-- Rename the column ```ros_pl.tag_details→tag_number``` to ```ros_pl.tag_details→tag_original_id```
ALTER TABLE ros_pl.tag_details RENAME tag_number TO tag_original_id;
-- Rename the column ```ros_pl.tuna_fishing_events→event_number``` to ```ros_pl.tuna_fishing_events→event_original_id```
ALTER TABLE ros_pl.tuna_fishing_events RENAME event_number TO event_original_id;

-- Change the type of column ```ros_pl.additional_catch_details_on_ssi→brought_on_board``` to boolean (default value false)
ALTER TABLE ros_pl.additional_catch_details_on_ssi ADD COLUMN brought_on_board2 BOOLEAN DEFAULT FALSE;
UPDATE ros_pl.additional_catch_details_on_ssi SET brought_on_board2 = case when brought_on_board = 0 then FALSE when brought_on_board = 1 then TRUE end;
ALTER TABLE ros_pl.additional_catch_details_on_ssi DROP COLUMN brought_on_board;
ALTER TABLE ros_pl.additional_catch_details_on_ssi RENAME brought_on_board2 TO brought_on_board;
-- Change the type of column ```ros_pl.additional_catch_details_on_ssi→revival``` to boolean (default value false)
ALTER TABLE ros_pl.additional_catch_details_on_ssi ADD COLUMN revival2 BOOLEAN DEFAULT FALSE;
UPDATE ros_pl.additional_catch_details_on_ssi SET revival2 = case when revival = 0 then FALSE when revival = 1 then TRUE end;
ALTER TABLE ros_pl.additional_catch_details_on_ssi DROP COLUMN revival;
ALTER TABLE ros_pl.additional_catch_details_on_ssi RENAME revival2 TO revival;
-- Change the type of column ```ros_pl.observer_data→complete``` to boolean (default value false)
ALTER TABLE ros_pl.observer_data ADD COLUMN complete2 BOOLEAN DEFAULT FALSE NOT NULL;
UPDATE ros_pl.observer_data SET complete2 = case when complete = 0 then FALSE when complete = 1 then TRUE end;
ALTER TABLE ros_pl.observer_data DROP COLUMN complete;
ALTER TABLE ros_pl.observer_data RENAME complete2 TO complete;
-- Change the type of column ```ros_pl.tag_details→tag_recovery``` to boolean (default value false)
ALTER TABLE ros_pl.tag_details ADD COLUMN tag_recovery2 BOOLEAN DEFAULT FALSE;
UPDATE ros_pl.tag_details SET tag_recovery2 = case when tag_recovery = 0 then FALSE when tag_recovery = 1 then TRUE end;
ALTER TABLE ros_pl.tag_details DROP COLUMN tag_recovery;
ALTER TABLE ros_pl.tag_details RENAME tag_recovery2 TO tag_recovery;
-- Change the type of column ```ros_pl.tag_details→tag_release``` to boolean (default value false)
ALTER TABLE ros_pl.tag_details ADD COLUMN tag_release2 BOOLEAN DEFAULT FALSE;
UPDATE ros_pl.tag_details SET tag_release2 = case when tag_release = 0 then FALSE when tag_release = 1 then TRUE end;
ALTER TABLE ros_pl.tag_details DROP COLUMN tag_release;
ALTER TABLE ros_pl.tag_details RENAME tag_release2 TO tag_release;
-- Change the type of column ```ros_pl.tuna_fishing_operations→bait_used``` to boolean (default value false)
ALTER TABLE ros_pl.tuna_fishing_operations ADD COLUMN bait_used2 BOOLEAN DEFAULT FALSE;
UPDATE ros_pl.tuna_fishing_operations SET bait_used2 = case when bait_used = 0 then FALSE when bait_used = 1 then TRUE end;
ALTER TABLE ros_pl.tuna_fishing_operations DROP COLUMN bait_used;
ALTER TABLE ros_pl.tuna_fishing_operations RENAME bait_used2 TO bait_used;