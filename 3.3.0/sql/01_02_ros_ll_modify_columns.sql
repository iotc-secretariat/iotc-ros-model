-- Rename the column "ros_ll.mitigation_measures→underwater_setting" to "ros_ll.mitigation_measures→hooks_pods"
ALTER TABLE ros_ll.mitigation_measures RENAME underwater_setting TO hooks_pods;

-- Rename the column "ros_ll.mitigation_measures→branchline_average_weight_id" to "ros_ll.mitigation_measures→average_sinker_weight_id"
ALTER TABLE ros_ll.mitigation_measures RENAME branchline_average_weight_id TO average_sinker_weight_id;

-- Remove the column "ros_ll.general_gear_attributes→line_material_type_code"
ALTER TABLE ros_ll.general_gear_attributes DROP COLUMN line_material_type_code;

-- Remove the column "ros_ll.general_gear_attributes→mainline_length_id"
ALTER TABLE ros_ll.general_gear_attributes DROP CONSTRAINT llgnrlgrttrbmnlnlngthd;
DELETE FROM ros_common.lengths WHERE id IN (SELECT mainline_length_id FROM  ros_ll.general_gear_attributes) AND id NOT IN (SELECT mainline_set_length_id FROM  ros_ll.setting_operations);
ALTER TABLE ros_ll.general_gear_attributes DROP COLUMN mainline_length_id;

-- Remove the column "ros_ll.general_gear_attributes→mainline_diameter_id"
ALTER TABLE ros_ll.general_gear_attributes DROP CONSTRAINT llgnrlgrttrbtmnlndmtrd;
DELETE FROM ros_common.diameters WHERE id IN (SELECT mainline_diameter_id FROM  ros_ll.general_gear_attributes);
ALTER TABLE ros_ll.general_gear_attributes DROP COLUMN mainline_diameter_id;

-- Remove the column "ros_ll.setting_operations→vms_on"
ALTER TABLE ros_ll.setting_operations DROP COLUMN vms_on;

-- Add the column "ros_ll.lights_by_type_and_colour→percentage"
ALTER TABLE ros_ll.lights_by_type_and_colour ADD COLUMN percentage double precision;

-- Rename the column ```ros_ll.catch_details→catch_detail_number``` to ```ros_ll.catch_details→catch_detail_original_id```
ALTER TABLE ros_ll.catch_details RENAME catch_detail_number TO catch_detail_original_id;
-- Rename the column ```ros_ll.fishing_events→event_number``` to ```.ros_ll.fishing_events→event_original_id```
ALTER TABLE ros_ll.fishing_events RENAME event_number TO event_original_id;
-- Rename the column ```ros_ll.specimens→specimen_number``` to ```ros_ll.specimens→specimen_original_id```
ALTER TABLE ros_ll.specimens RENAME specimen_number TO specimen_original_id;
-- Rename the column ```ros_ll.tag_details→alternate_tag_number``` to ```ros_ll.tag_details→alternate_tag_original_id```
ALTER TABLE ros_ll.tag_details RENAME alternate_tag_number TO alternate_tag_original_id;
-- Rename the column ```ros_ll.tag_details→tag_number``` to ```ros_ll.tag_details→tag_original_id```
ALTER TABLE ros_ll.tag_details RENAME tag_number TO tag_original_id;

-- Change the type of column ```ros_ll.additional_catch_details_on_ssi.brought_on_board``` to boolean (default value false)
ALTER TABLE ros_ll.additional_catch_details_on_ssi ADD COLUMN brought_on_board2 BOOLEAN DEFAULT FALSE;
UPDATE ros_ll.additional_catch_details_on_ssi SET brought_on_board2 = case when brought_on_board = 0 then FALSE when brought_on_board = 1 then TRUE end;
ALTER TABLE ros_ll.additional_catch_details_on_ssi DROP COLUMN brought_on_board;
ALTER TABLE ros_ll.additional_catch_details_on_ssi RENAME brought_on_board2 TO brought_on_board;
-- Change the type of column ```ros_ll.additional_catch_details_on_ssi.light_attached_to_branchline``` to boolean (default value false)
ALTER TABLE ros_ll.additional_catch_details_on_ssi ADD COLUMN light_attached_to_branchline2 BOOLEAN DEFAULT FALSE;
UPDATE ros_ll.additional_catch_details_on_ssi SET light_attached_to_branchline2 = case when light_attached_to_branchline = 0 then FALSE when light_attached_to_branchline = 1 then TRUE end;
ALTER TABLE ros_ll.additional_catch_details_on_ssi DROP COLUMN light_attached_to_branchline;
ALTER TABLE ros_ll.additional_catch_details_on_ssi RENAME light_attached_to_branchline2 TO light_attached_to_branchline;
-- Change the type of column ```ros_ll.additional_catch_details_on_ssi.revival``` to boolean (default value false)
ALTER TABLE ros_ll.additional_catch_details_on_ssi ADD COLUMN revival2 BOOLEAN DEFAULT FALSE;
UPDATE ros_ll.additional_catch_details_on_ssi SET revival2 = case when revival = 0 then FALSE when revival = 1 then TRUE end;
ALTER TABLE ros_ll.additional_catch_details_on_ssi DROP COLUMN revival;
ALTER TABLE ros_ll.additional_catch_details_on_ssi RENAME revival2 TO revival;
-- Change the type of column ```ros_ll.hauling_operations.bird_scaring_device_at_hauler``` to boolean (default value false)
ALTER TABLE ros_ll.hauling_operations ADD COLUMN bird_scaring_device_at_hauler2 BOOLEAN DEFAULT FALSE;
UPDATE ros_ll.hauling_operations SET bird_scaring_device_at_hauler2 = case when bird_scaring_device_at_hauler = 0 then FALSE when bird_scaring_device_at_hauler = 1 then TRUE end;
ALTER TABLE ros_ll.hauling_operations DROP COLUMN bird_scaring_device_at_hauler;
ALTER TABLE ros_ll.hauling_operations RENAME bird_scaring_device_at_hauler2 TO bird_scaring_device_at_hauler;
-- Change the type of column ```ros_ll.mitigation_measures.branchline_weighted``` to boolean (default value false)
ALTER TABLE ros_ll.mitigation_measures ADD COLUMN branchline_weighted2 BOOLEAN DEFAULT FALSE;
UPDATE ros_ll.mitigation_measures SET branchline_weighted2 = case when branchline_weighted = 0 then FALSE when branchline_weighted = 1 then TRUE end;
ALTER TABLE ros_ll.mitigation_measures DROP COLUMN branchline_weighted;
ALTER TABLE ros_ll.mitigation_measures RENAME branchline_weighted2 TO branchline_weighted;
-- Change the type of column ```ros_ll.mitigation_measures.hooks_pods``` to boolean (default value false)
ALTER TABLE ros_ll.mitigation_measures ADD COLUMN hooks_pods2 BOOLEAN DEFAULT FALSE;
UPDATE ros_ll.mitigation_measures SET hooks_pods2 = case when hooks_pods = 0 then FALSE when hooks_pods = 1 then TRUE end;
ALTER TABLE ros_ll.mitigation_measures DROP COLUMN hooks_pods;
ALTER TABLE ros_ll.mitigation_measures RENAME hooks_pods2 TO hooks_pods;
-- Change the type of column ```ros_ll.mitigation_measures.hooks_set_between_dusk_and_dawn``` to boolean (default value false)
ALTER TABLE ros_ll.mitigation_measures ADD COLUMN hooks_set_between_dusk_and_dawn2 BOOLEAN DEFAULT FALSE;
UPDATE ros_ll.mitigation_measures SET hooks_set_between_dusk_and_dawn2 = case when hooks_set_between_dusk_and_dawn = 0 then FALSE when hooks_set_between_dusk_and_dawn = 1 then TRUE end;
ALTER TABLE ros_ll.mitigation_measures DROP COLUMN hooks_set_between_dusk_and_dawn;
ALTER TABLE ros_ll.mitigation_measures RENAME hooks_set_between_dusk_and_dawn2 TO hooks_set_between_dusk_and_dawn;
-- Change the type of column ```ros_ll.mitigation_measures.minimum_deck_lighting_used``` to boolean (default value false)
ALTER TABLE ros_ll.mitigation_measures ADD COLUMN minimum_deck_lighting_used2 BOOLEAN DEFAULT FALSE;
UPDATE ros_ll.mitigation_measures SET minimum_deck_lighting_used2 = case when minimum_deck_lighting_used = 0 then FALSE when minimum_deck_lighting_used = 1 then TRUE end;
ALTER TABLE ros_ll.mitigation_measures DROP COLUMN minimum_deck_lighting_used;
ALTER TABLE ros_ll.mitigation_measures RENAME minimum_deck_lighting_used2 TO minimum_deck_lighting_used;
-- Change the type of column ```ros_ll.observer_data.complete``` to boolean (default value false)
ALTER TABLE ros_ll.observer_data ADD COLUMN complete2 BOOLEAN DEFAULT FALSE NOT NULL;
UPDATE ros_ll.observer_data SET complete2 = case when complete = 0 then FALSE when complete = 1 then TRUE end;
ALTER TABLE ros_ll.observer_data DROP COLUMN complete;
ALTER TABLE ros_ll.observer_data RENAME complete2 TO complete;
-- Change the type of column ```ros_ll.setting_operations.shark_lines_set``` to boolean (default value false)
ALTER TABLE ros_ll.setting_operations ADD COLUMN shark_lines_set2 BOOLEAN DEFAULT FALSE;
UPDATE ros_ll.setting_operations SET shark_lines_set2 = case when shark_lines_set = 0 then FALSE when shark_lines_set = 1 then TRUE end;
ALTER TABLE ros_ll.setting_operations DROP COLUMN shark_lines_set;
ALTER TABLE ros_ll.setting_operations RENAME shark_lines_set2 TO shark_lines_set;
-- Change the type of column ```ros_ll.special_equipment.bait_casting_machine``` to boolean (default value false)
ALTER TABLE ros_ll.special_equipment ADD COLUMN bait_casting_machine2 BOOLEAN DEFAULT FALSE;
UPDATE ros_ll.special_equipment SET bait_casting_machine2 = case when bait_casting_machine = 0 then FALSE when bait_casting_machine = 1 then TRUE end;
ALTER TABLE ros_ll.special_equipment DROP COLUMN bait_casting_machine;
ALTER TABLE ros_ll.special_equipment RENAME bait_casting_machine2 TO bait_casting_machine;
-- Change the type of column ```ros_ll.special_equipment.line_hauler``` to boolean (default value false)
ALTER TABLE ros_ll.special_equipment ADD COLUMN line_hauler2 BOOLEAN DEFAULT FALSE;
UPDATE ros_ll.special_equipment SET line_hauler2 = case when line_hauler = 0 then FALSE when line_hauler = 1 then TRUE end;
ALTER TABLE ros_ll.special_equipment DROP COLUMN line_hauler;
ALTER TABLE ros_ll.special_equipment RENAME line_hauler2 TO line_hauler;
-- Change the type of column ```ros_ll.special_equipment.line_setter``` to boolean (default value false)
ALTER TABLE ros_ll.special_equipment ADD COLUMN line_setter2 BOOLEAN DEFAULT FALSE;
UPDATE ros_ll.special_equipment SET line_setter2 = case when line_setter = 0 then FALSE when line_setter = 1 then TRUE end;
ALTER TABLE ros_ll.special_equipment DROP COLUMN line_setter;
ALTER TABLE ros_ll.special_equipment RENAME line_setter2 TO line_setter;
-- Change the type of column ```ros_ll.tag_details.tag_recovery``` to boolean (default value false)
ALTER TABLE ros_ll.tag_details ADD COLUMN tag_recovery2 BOOLEAN DEFAULT FALSE;
UPDATE ros_ll.tag_details SET tag_recovery2 = case when tag_recovery = 0 then FALSE when tag_recovery = 1 then TRUE end;
ALTER TABLE ros_ll.tag_details DROP COLUMN tag_recovery;
ALTER TABLE ros_ll.tag_details RENAME tag_recovery2 TO tag_recovery;
-- Change the type of column ```ros_ll.tag_details.tag_release``` to boolean (default value false)
ALTER TABLE ros_ll.tag_details ADD COLUMN tag_release2 BOOLEAN DEFAULT FALSE;
UPDATE ros_ll.tag_details SET tag_release2 = case when tag_release = 0 then FALSE when tag_release = 1 then TRUE end;
ALTER TABLE ros_ll.tag_details DROP COLUMN tag_release;
ALTER TABLE ros_ll.tag_details RENAME tag_release2 TO tag_release;
-- Change the type of column ```ros_ll.tori_line_details.streamers_reach_surface``` to boolean (default value false)
ALTER TABLE ros_ll.tori_line_details ADD COLUMN streamers_reach_surface2 BOOLEAN DEFAULT FALSE;
UPDATE ros_ll.tori_line_details SET streamers_reach_surface2 = case when streamers_reach_surface = 0 then FALSE when streamers_reach_surface = 1 then TRUE end;
ALTER TABLE ros_ll.tori_line_details DROP COLUMN streamers_reach_surface;
ALTER TABLE ros_ll.tori_line_details RENAME streamers_reach_surface2 TO streamers_reach_surface;


