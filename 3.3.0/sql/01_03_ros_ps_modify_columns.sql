-- Remove the column ```ros_ps.general_gear_attributes→skiff_power_id```
ALTER TABLE ros_ps.general_gear_attributes DROP CONSTRAINT psgnrlgrttrbtsskffpwrd;
DELETE FROM ros_common.powers WHERE id IN (SELECT skiff_power_id FROM  ros_ps.general_gear_attributes);
ALTER TABLE ros_ps.general_gear_attributes DROP COLUMN skiff_power_id;

-- Remove the column ```ros_ps.setting_operations→wind_scale_code```
ALTER TABLE ros_ps.setting_operations DROP COLUMN wind_scale_code;

-- Remove the column ```ros_ps.catch_details→additional_catch_details_non_target_species_id```
ALTER TABLE ros_ps.catch_details DROP CONSTRAINT psddtnlctchdtlsnntrgts;
DELETE FROM ros_common.additional_details_on_non_target_species WHERE id IN (SELECT additional_catch_details_non_target_species_id FROM  ros_ps.catch_details);
ALTER TABLE ros_ps.catch_details DROP COLUMN additional_catch_details_non_target_species_id;

-- Rename the column ```ros_ps.catch_details→catch_detail_number``` to ```ros_ps.catch_details→catch_detail_original_id```
ALTER TABLE ros_ps.catch_details RENAME catch_detail_number TO catch_detail_original_id;
-- Rename the column ```ros_ps.fishing_events→event_number``` to ```ros_ps.fishing_events→event_original_id```
ALTER TABLE ros_ps.fishing_events RENAME event_number TO event_original_id;
-- Rename the column ```ros_ps.specimens→specimen_number``` to ```ros_ps.specimens→specimen_original_id```
ALTER TABLE ros_ps.specimens RENAME specimen_number TO specimen_original_id;
-- Rename the column ```ros_ps.tag_details→alternate_tag_number``` to ```ros_ps.tag_details→alternate_tag_original_id```
ALTER TABLE ros_ps.tag_details RENAME alternate_tag_number TO alternate_tag_original_id;
-- Rename the column ```ros_ps.tag_details→tag_number``` to ```ros_ps.tag_details→tag_original_id```
ALTER TABLE ros_ps.tag_details RENAME tag_number TO tag_original_id;

-- Change the type of column ```ros_ps.additional_catch_details_on_ssi→brought_on_board``` to boolean (default value false)
ALTER TABLE ros_ps.additional_catch_details_on_ssi ADD COLUMN brought_on_board2 BOOLEAN DEFAULT FALSE;
UPDATE ros_ps.additional_catch_details_on_ssi SET brought_on_board2 = case when brought_on_board = 0 then FALSE when brought_on_board = 1 then TRUE end;
ALTER TABLE ros_ps.additional_catch_details_on_ssi DROP COLUMN brought_on_board;
ALTER TABLE ros_ps.additional_catch_details_on_ssi RENAME brought_on_board2 TO brought_on_board;
-- Change the type of column ```ros_ps.additional_catch_details_on_ssi→revival``` to boolean (default value false)
ALTER TABLE ros_ps.additional_catch_details_on_ssi ADD COLUMN revival2 BOOLEAN DEFAULT FALSE;
UPDATE ros_ps.additional_catch_details_on_ssi SET revival2 = case when revival = 0 then FALSE when revival = 1 then TRUE end;
ALTER TABLE ros_ps.additional_catch_details_on_ssi DROP COLUMN revival;
ALTER TABLE ros_ps.additional_catch_details_on_ssi RENAME revival2 TO revival;
-- Change the type of column ```ros_ps.cetaceans_whale_shark_sightings→caught_inside_the_net``` to boolean (default value false)
ALTER TABLE ros_ps.cetaceans_whale_shark_sightings ADD COLUMN caught_inside_the_net2 BOOLEAN DEFAULT FALSE;
UPDATE ros_ps.cetaceans_whale_shark_sightings SET caught_inside_the_net2 = case when caught_inside_the_net = 0 then FALSE when caught_inside_the_net = 1 then TRUE end;
ALTER TABLE ros_ps.cetaceans_whale_shark_sightings DROP COLUMN caught_inside_the_net;
ALTER TABLE ros_ps.cetaceans_whale_shark_sightings RENAME caught_inside_the_net2 TO caught_inside_the_net;
-- Change the type of column ```ros_ps.cetaceans_whale_shark_sightings→sighting_occurred_before_setting``` to boolean (default value false)
ALTER TABLE ros_ps.cetaceans_whale_shark_sightings ADD COLUMN sighting_occurred_before_setting2 BOOLEAN DEFAULT FALSE;
UPDATE ros_ps.cetaceans_whale_shark_sightings SET sighting_occurred_before_setting2 = case when sighting_occurred_before_setting = 0 then FALSE when sighting_occurred_before_setting = 1 then TRUE end;
ALTER TABLE ros_ps.cetaceans_whale_shark_sightings DROP COLUMN sighting_occurred_before_setting;
ALTER TABLE ros_ps.cetaceans_whale_shark_sightings RENAME sighting_occurred_before_setting2 TO sighting_occurred_before_setting;
-- Change the type of column ```ros_ps.object_details→equipped_with_artificial_lights_at_deploy``` to boolean (default value false)
ALTER TABLE ros_ps.object_details ADD COLUMN equipped_with_artificial_lights_at_deploy2 BOOLEAN DEFAULT FALSE;
UPDATE ros_ps.object_details SET equipped_with_artificial_lights_at_deploy2 = case when equipped_with_artificial_lights_at_deploy = 0 then FALSE when equipped_with_artificial_lights_at_deploy = 1 then TRUE end;
ALTER TABLE ros_ps.object_details DROP COLUMN equipped_with_artificial_lights_at_deploy;
ALTER TABLE ros_ps.object_details RENAME equipped_with_artificial_lights_at_deploy2 TO equipped_with_artificial_lights_at_deploy;
-- Change the type of column ```ros_ps.object_details→equipped_with_artificial_lights_on_retrieval``` to boolean (default value false)
ALTER TABLE ros_ps.object_details ADD COLUMN equipped_with_artificial_lights_on_retrieval2 BOOLEAN DEFAULT FALSE;
UPDATE ros_ps.object_details SET equipped_with_artificial_lights_on_retrieval2 = case when equipped_with_artificial_lights_on_retrieval = 0 then FALSE when equipped_with_artificial_lights_on_retrieval = 1 then TRUE end;
ALTER TABLE ros_ps.object_details DROP COLUMN equipped_with_artificial_lights_on_retrieval;
ALTER TABLE ros_ps.object_details RENAME equipped_with_artificial_lights_on_retrieval2 TO equipped_with_artificial_lights_on_retrieval;
-- Change the type of column ```ros_ps.observer_data→complete``` to boolean (default value false)
ALTER TABLE ros_ps.observer_data ADD COLUMN complete2 BOOLEAN DEFAULT FALSE NOT NULL;
UPDATE ros_ps.observer_data SET complete2 = case when complete = 0 then FALSE when complete = 1 then TRUE end;
ALTER TABLE ros_ps.observer_data DROP COLUMN complete;
ALTER TABLE ros_ps.observer_data RENAME complete2 TO complete;
-- Change the type of column ```ros_ps.special_equipment→power_block``` to boolean (default value false)
ALTER TABLE ros_ps.special_equipment ADD COLUMN power_block2 BOOLEAN DEFAULT FALSE;
UPDATE ros_ps.special_equipment SET power_block2 = case when power_block = 0 then FALSE when power_block = 1 then TRUE end;
ALTER TABLE ros_ps.special_equipment DROP COLUMN power_block;
ALTER TABLE ros_ps.special_equipment RENAME power_block2 TO power_block;
-- Change the type of column ```ros_ps.special_equipment→purse_winch``` to boolean (default value false)
ALTER TABLE ros_ps.special_equipment ADD COLUMN purse_winch2 BOOLEAN DEFAULT FALSE;
UPDATE ros_ps.special_equipment SET purse_winch2 = case when purse_winch = 0 then FALSE when purse_winch = 1 then TRUE end;
ALTER TABLE ros_ps.special_equipment DROP COLUMN purse_winch;
ALTER TABLE ros_ps.special_equipment RENAME purse_winch2 TO purse_winch;
-- Change the type of column ```ros_ps.tag_details→tag_recovery``` to boolean (default value false)
ALTER TABLE ros_ps.tag_details ADD COLUMN tag_recovery2 BOOLEAN DEFAULT FALSE;
UPDATE ros_ps.tag_details SET tag_recovery2 = case when tag_recovery = 0 then FALSE when tag_recovery = 1 then TRUE end;
ALTER TABLE ros_ps.tag_details DROP COLUMN tag_recovery;
ALTER TABLE ros_ps.tag_details RENAME tag_recovery2 TO tag_recovery;
-- Change the type of column ```ros_ps.tag_details→tag_release``` to boolean (default value false)
ALTER TABLE ros_ps.tag_details ADD COLUMN tag_release2 BOOLEAN DEFAULT FALSE;
UPDATE ros_ps.tag_details SET tag_release2 = case when tag_release = 0 then FALSE when tag_release = 1 then TRUE end;
ALTER TABLE ros_ps.tag_details DROP COLUMN tag_release;
ALTER TABLE ros_ps.tag_details RENAME tag_release2 TO tag_release;


