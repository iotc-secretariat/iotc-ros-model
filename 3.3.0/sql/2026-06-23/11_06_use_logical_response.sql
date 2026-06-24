-- change ros_common.trip_vessel.ais to logical response
ALTER TABLE ros_common.trip_vessel ADD COLUMN ais2 VARCHAR(5);
UPDATE ros_common.trip_vessel SET ais2 = 'UNK' WHERE ais IS NULL;
UPDATE ros_common.trip_vessel SET ais2 = 'TRUE' WHERE ais = TRUE;
UPDATE ros_common.trip_vessel SET ais2 = 'FALSE' WHERE ais = FALSE;
ALTER TABLE ros_common.trip_vessel DROP COLUMN ais;
ALTER TABLE ros_common.trip_vessel RENAME COLUMN ais2 TO  ais;
ALTER TABLE ros_common.trip_vessel ADD CONSTRAINT fk_ros_common_trip_vessel_ais FOREIGN KEY (ais) REFERENCES refs_data.logical_responses (code);
-- change ros_common.trip_vessel.gps to logical response
ALTER TABLE ros_common.trip_vessel ADD COLUMN gps2 VARCHAR(5);
UPDATE ros_common.trip_vessel SET gps2 = 'UNK' WHERE gps IS NULL;
UPDATE ros_common.trip_vessel SET gps2 = 'TRUE' WHERE gps = TRUE;
UPDATE ros_common.trip_vessel SET gps2 = 'FALSE' WHERE gps = FALSE;
ALTER TABLE ros_common.trip_vessel DROP COLUMN gps;
ALTER TABLE ros_common.trip_vessel RENAME COLUMN gps2 TO  gps;
ALTER TABLE ros_common.trip_vessel ADD CONSTRAINT fk_ros_common_trip_vessel_gps FOREIGN KEY (gps) REFERENCES refs_data.logical_responses (code);
-- change ros_common.trip_vessel.vms to logical response
ALTER TABLE ros_common.trip_vessel ADD COLUMN vms2 VARCHAR(5);
UPDATE ros_common.trip_vessel SET vms2 = 'UNK' WHERE vms IS NULL;
UPDATE ros_common.trip_vessel SET vms2 = 'TRUE' WHERE vms = TRUE;
UPDATE ros_common.trip_vessel SET vms2 = 'FALSE' WHERE vms = FALSE;
ALTER TABLE ros_common.trip_vessel DROP COLUMN vms;
ALTER TABLE ros_common.trip_vessel RENAME COLUMN vms2 TO  vms;
ALTER TABLE ros_common.trip_vessel ADD CONSTRAINT fk_ros_common_trip_vessel_vms FOREIGN KEY (vms) REFERENCES refs_data.logical_responses (code);
-- change ros_common.trip_vessel.depth_sounder to logical response
ALTER TABLE ros_common.trip_vessel ADD COLUMN depth_sounder2 VARCHAR(5);
UPDATE ros_common.trip_vessel SET depth_sounder2 = 'UNK' WHERE depth_sounder IS NULL;
UPDATE ros_common.trip_vessel SET depth_sounder2 = 'TRUE' WHERE depth_sounder = TRUE;
UPDATE ros_common.trip_vessel SET depth_sounder2 = 'FALSE' WHERE depth_sounder = FALSE;
ALTER TABLE ros_common.trip_vessel DROP COLUMN depth_sounder;
ALTER TABLE ros_common.trip_vessel RENAME COLUMN depth_sounder2 TO  depth_sounder;
ALTER TABLE ros_common.trip_vessel ADD CONSTRAINT fk_ros_common_trip_vessel_depth_sounder FOREIGN KEY (depth_sounder) REFERENCES refs_data.logical_responses (code);
-- change ros_common.trip_vessel.doppler_current_meter to logical response
ALTER TABLE ros_common.trip_vessel ADD COLUMN doppler_current_meter2 VARCHAR(5);
UPDATE ros_common.trip_vessel SET doppler_current_meter2 = 'UNK' WHERE doppler_current_meter IS NULL;
UPDATE ros_common.trip_vessel SET doppler_current_meter2 = 'TRUE' WHERE doppler_current_meter = TRUE;
UPDATE ros_common.trip_vessel SET doppler_current_meter2 = 'FALSE' WHERE doppler_current_meter = FALSE;
ALTER TABLE ros_common.trip_vessel DROP COLUMN doppler_current_meter;
ALTER TABLE ros_common.trip_vessel RENAME COLUMN doppler_current_meter2 TO  doppler_current_meter;
ALTER TABLE ros_common.trip_vessel ADD CONSTRAINT fk_ros_common_trip_vessel_doppler_current_meter FOREIGN KEY (doppler_current_meter) REFERENCES refs_data.logical_responses (code);
-- change ros_common.trip_vessel.expendable_bathythermographs to logical response
ALTER TABLE ros_common.trip_vessel ADD COLUMN expendable_bathythermographs2 VARCHAR(5);
UPDATE ros_common.trip_vessel SET expendable_bathythermographs2 = 'UNK' WHERE expendable_bathythermographs IS NULL;
UPDATE ros_common.trip_vessel SET expendable_bathythermographs2 = 'TRUE' WHERE expendable_bathythermographs = TRUE;
UPDATE ros_common.trip_vessel SET expendable_bathythermographs2 = 'FALSE' WHERE expendable_bathythermographs = FALSE;
ALTER TABLE ros_common.trip_vessel DROP COLUMN expendable_bathythermographs;
ALTER TABLE ros_common.trip_vessel RENAME COLUMN expendable_bathythermographs2 TO  expendable_bathythermographs;
ALTER TABLE ros_common.trip_vessel ADD CONSTRAINT fk_ros_common_trip_vessel_expendable_bathythermographs FOREIGN KEY (expendable_bathythermographs) REFERENCES refs_data.logical_responses (code);
-- change ros_common.trip_vessel.fisheries_information_services to logical response
ALTER TABLE ros_common.trip_vessel ADD COLUMN fisheries_information_services2 VARCHAR(5);
UPDATE ros_common.trip_vessel SET fisheries_information_services2 = 'UNK' WHERE fisheries_information_services IS NULL;
UPDATE ros_common.trip_vessel SET fisheries_information_services2 = 'TRUE' WHERE fisheries_information_services = TRUE;
UPDATE ros_common.trip_vessel SET fisheries_information_services2 = 'FALSE' WHERE fisheries_information_services = FALSE;
ALTER TABLE ros_common.trip_vessel DROP COLUMN fisheries_information_services;
ALTER TABLE ros_common.trip_vessel RENAME COLUMN fisheries_information_services2 TO  fisheries_information_services;
ALTER TABLE ros_common.trip_vessel ADD CONSTRAINT fk_ros_common_trip_vessel_fisheries_information_services FOREIGN KEY (fisheries_information_services) REFERENCES refs_data.logical_responses (code);
-- change ros_common.trip_vessel.hf_radios to logical response
ALTER TABLE ros_common.trip_vessel ADD COLUMN hf_radios2 VARCHAR(5);
UPDATE ros_common.trip_vessel SET hf_radios2 = 'UNK' WHERE hf_radios IS NULL;
UPDATE ros_common.trip_vessel SET hf_radios2 = 'TRUE' WHERE hf_radios = TRUE;
UPDATE ros_common.trip_vessel SET hf_radios2 = 'FALSE' WHERE hf_radios = FALSE;
ALTER TABLE ros_common.trip_vessel DROP COLUMN hf_radios;
ALTER TABLE ros_common.trip_vessel RENAME COLUMN hf_radios2 TO  hf_radios;
ALTER TABLE ros_common.trip_vessel ADD CONSTRAINT fk_ros_common_trip_vessel_hf_radios FOREIGN KEY (hf_radios) REFERENCES refs_data.logical_responses (code);
-- change ros_common.trip_vessel.radars to logical response
ALTER TABLE ros_common.trip_vessel ADD COLUMN radars2 VARCHAR(5);
UPDATE ros_common.trip_vessel SET radars2 = 'UNK' WHERE radars IS NULL;
UPDATE ros_common.trip_vessel SET radars2 = 'TRUE' WHERE radars = TRUE;
UPDATE ros_common.trip_vessel SET radars2 = 'FALSE' WHERE radars = FALSE;
ALTER TABLE ros_common.trip_vessel DROP COLUMN radars;
ALTER TABLE ros_common.trip_vessel RENAME COLUMN radars2 TO  radars;
ALTER TABLE ros_common.trip_vessel ADD CONSTRAINT fk_ros_common_trip_vessel_radars FOREIGN KEY (radars) REFERENCES refs_data.logical_responses (code);
-- change ros_common.trip_vessel.satellite_communication_systems to logical response
ALTER TABLE ros_common.trip_vessel ADD COLUMN satellite_communication_systems2 VARCHAR(5);
UPDATE ros_common.trip_vessel SET satellite_communication_systems2 = 'UNK' WHERE satellite_communication_systems IS NULL;
UPDATE ros_common.trip_vessel SET satellite_communication_systems2 = 'TRUE' WHERE satellite_communication_systems = TRUE;
UPDATE ros_common.trip_vessel SET satellite_communication_systems2 = 'FALSE' WHERE satellite_communication_systems = FALSE;
ALTER TABLE ros_common.trip_vessel DROP COLUMN satellite_communication_systems;
ALTER TABLE ros_common.trip_vessel RENAME COLUMN satellite_communication_systems2 TO  satellite_communication_systems;
ALTER TABLE ros_common.trip_vessel ADD CONSTRAINT fk_ros_common_trip_vessel_satellite_communication_systems FOREIGN KEY (satellite_communication_systems) REFERENCES refs_data.logical_responses (code);
-- change ros_common.trip_vessel.sonar to logical response
ALTER TABLE ros_common.trip_vessel ADD COLUMN sonar2 VARCHAR(5);
UPDATE ros_common.trip_vessel SET sonar2 = 'UNK' WHERE sonar IS NULL;
UPDATE ros_common.trip_vessel SET sonar2 = 'TRUE' WHERE sonar = TRUE;
UPDATE ros_common.trip_vessel SET sonar2 = 'FALSE' WHERE sonar = FALSE;
ALTER TABLE ros_common.trip_vessel DROP COLUMN sonar;
ALTER TABLE ros_common.trip_vessel RENAME COLUMN sonar2 TO  sonar;
ALTER TABLE ros_common.trip_vessel ADD CONSTRAINT fk_ros_common_trip_vessel_sonar FOREIGN KEY (sonar) REFERENCES refs_data.logical_responses (code);
-- change ros_common.trip_vessel.track_plotter to logical response
ALTER TABLE ros_common.trip_vessel ADD COLUMN track_plotter2 VARCHAR(5);
UPDATE ros_common.trip_vessel SET track_plotter2 = 'UNK' WHERE track_plotter IS NULL;
UPDATE ros_common.trip_vessel SET track_plotter2 = 'TRUE' WHERE track_plotter = TRUE;
UPDATE ros_common.trip_vessel SET track_plotter2 = 'FALSE' WHERE track_plotter = FALSE;
ALTER TABLE ros_common.trip_vessel DROP COLUMN track_plotter;
ALTER TABLE ros_common.trip_vessel RENAME COLUMN track_plotter2 TO  track_plotter;
ALTER TABLE ros_common.trip_vessel ADD CONSTRAINT fk_ros_common_trip_vessel_track_plotter FOREIGN KEY (track_plotter) REFERENCES refs_data.logical_responses (code);
-- change ros_common.trip_vessel.vhf_radios to logical response
ALTER TABLE ros_common.trip_vessel ADD COLUMN vhf_radios2 VARCHAR(5);
UPDATE ros_common.trip_vessel SET vhf_radios2 = 'UNK' WHERE vhf_radios IS NULL;
UPDATE ros_common.trip_vessel SET vhf_radios2 = 'TRUE' WHERE vhf_radios = TRUE;
UPDATE ros_common.trip_vessel SET vhf_radios2 = 'FALSE' WHERE vhf_radios = FALSE;
ALTER TABLE ros_common.trip_vessel DROP COLUMN vhf_radios;
ALTER TABLE ros_common.trip_vessel RENAME COLUMN vhf_radios2 TO  vhf_radios;
ALTER TABLE ros_common.trip_vessel ADD CONSTRAINT fk_ros_common_trip_vessel_vhf_radios FOREIGN KEY (vhf_radios) REFERENCES refs_data.logical_responses (code);
-- change ros_ll.setting_operations.shark_lines_set to logical response
ALTER TABLE ros_ll.setting_operations ADD COLUMN shark_lines_set2 VARCHAR(5);
UPDATE ros_ll.setting_operations SET shark_lines_set2 = 'UNK' WHERE shark_lines_set IS NULL;
UPDATE ros_ll.setting_operations SET shark_lines_set2 = 'TRUE' WHERE shark_lines_set = TRUE;
UPDATE ros_ll.setting_operations SET shark_lines_set2 = 'FALSE' WHERE shark_lines_set = FALSE;
ALTER TABLE ros_ll.setting_operations DROP COLUMN shark_lines_set;
ALTER TABLE ros_ll.setting_operations RENAME COLUMN shark_lines_set2 TO  shark_lines_set;
ALTER TABLE ros_ll.setting_operations ADD CONSTRAINT fk_ros_ll_setting_operations_shark_lines_set FOREIGN KEY (shark_lines_set) REFERENCES refs_data.logical_responses (code);
-- change ros_ll.hauling_operations.bird_scaring_device_at_hauler to logical response
ALTER TABLE ros_ll.hauling_operations ADD COLUMN bird_scaring_device_at_hauler2 VARCHAR(5);
UPDATE ros_ll.hauling_operations SET bird_scaring_device_at_hauler2 = 'UNK' WHERE bird_scaring_device_at_hauler IS NULL;
UPDATE ros_ll.hauling_operations SET bird_scaring_device_at_hauler2 = 'TRUE' WHERE bird_scaring_device_at_hauler = TRUE;
UPDATE ros_ll.hauling_operations SET bird_scaring_device_at_hauler2 = 'FALSE' WHERE bird_scaring_device_at_hauler = FALSE;
ALTER TABLE ros_ll.hauling_operations DROP COLUMN bird_scaring_device_at_hauler;
ALTER TABLE ros_ll.hauling_operations RENAME COLUMN bird_scaring_device_at_hauler2 TO  bird_scaring_device_at_hauler;
ALTER TABLE ros_ll.hauling_operations ADD CONSTRAINT fk_ros_ll_hauling_operations_bird_scaring_device_at_hauler FOREIGN KEY (bird_scaring_device_at_hauler) REFERENCES refs_data.logical_responses (code);
-- change ros_common.biometric_information.alternative_measured_length_straight to logical response
ALTER TABLE ros_common.biometric_information ADD COLUMN alternative_measured_length_straight2 VARCHAR(5);
UPDATE ros_common.biometric_information SET alternative_measured_length_straight2 = 'UNK' WHERE alternative_measured_length_straight IS NULL;
UPDATE ros_common.biometric_information SET alternative_measured_length_straight2 = 'TRUE' WHERE alternative_measured_length_straight = TRUE;
UPDATE ros_common.biometric_information SET alternative_measured_length_straight2 = 'FALSE' WHERE alternative_measured_length_straight = FALSE;
ALTER TABLE ros_common.biometric_information DROP COLUMN alternative_measured_length_straight;
ALTER TABLE ros_common.biometric_information RENAME COLUMN alternative_measured_length_straight2 TO  alternative_measured_length_straight;
ALTER TABLE ros_common.biometric_information ADD CONSTRAINT fk_ros_common_biometric_information_alternative_measured_length_straight FOREIGN KEY (alternative_measured_length_straight) REFERENCES refs_data.logical_responses (code);
-- change ros_common.biometric_information.measured_length_straight to logical response
ALTER TABLE ros_common.biometric_information ADD COLUMN measured_length_straight2 VARCHAR(5);
UPDATE ros_common.biometric_information SET measured_length_straight2 = 'UNK' WHERE measured_length_straight IS NULL;
UPDATE ros_common.biometric_information SET measured_length_straight2 = 'TRUE' WHERE measured_length_straight = TRUE;
UPDATE ros_common.biometric_information SET measured_length_straight2 = 'FALSE' WHERE measured_length_straight = FALSE;
ALTER TABLE ros_common.biometric_information DROP COLUMN measured_length_straight;
ALTER TABLE ros_common.biometric_information RENAME COLUMN measured_length_straight2 TO  measured_length_straight;
ALTER TABLE ros_common.biometric_information ADD CONSTRAINT fk_ros_common_biometric_information_measured_length_straight FOREIGN KEY (measured_length_straight) REFERENCES refs_data.logical_responses (code);
-- change ros_gn.additional_catch_details_on_ssi.brought_on_board to logical response
ALTER TABLE ros_gn.additional_catch_details_on_ssi ADD COLUMN brought_on_board2 VARCHAR(5);
UPDATE ros_gn.additional_catch_details_on_ssi SET brought_on_board2 = 'UNK' WHERE brought_on_board IS NULL;
UPDATE ros_gn.additional_catch_details_on_ssi SET brought_on_board2 = 'TRUE' WHERE brought_on_board = TRUE;
UPDATE ros_gn.additional_catch_details_on_ssi SET brought_on_board2 = 'FALSE' WHERE brought_on_board = FALSE;
ALTER TABLE ros_gn.additional_catch_details_on_ssi DROP COLUMN brought_on_board;
ALTER TABLE ros_gn.additional_catch_details_on_ssi RENAME COLUMN brought_on_board2 TO  brought_on_board;
ALTER TABLE ros_gn.additional_catch_details_on_ssi ADD CONSTRAINT fk_ros_gn_additional_catch_details_on_ssi_brought_on_board FOREIGN KEY (brought_on_board) REFERENCES refs_data.logical_responses (code);
-- change ros_gn.additional_catch_details_on_ssi.revival to logical response
ALTER TABLE ros_gn.additional_catch_details_on_ssi ADD COLUMN revival2 VARCHAR(5);
UPDATE ros_gn.additional_catch_details_on_ssi SET revival2 = 'UNK' WHERE revival IS NULL;
UPDATE ros_gn.additional_catch_details_on_ssi SET revival2 = 'TRUE' WHERE revival = TRUE;
UPDATE ros_gn.additional_catch_details_on_ssi SET revival2 = 'FALSE' WHERE revival = FALSE;
ALTER TABLE ros_gn.additional_catch_details_on_ssi DROP COLUMN revival;
ALTER TABLE ros_gn.additional_catch_details_on_ssi RENAME COLUMN revival2 TO  revival;
ALTER TABLE ros_gn.additional_catch_details_on_ssi ADD CONSTRAINT fk_ros_gn_additional_catch_details_on_ssi_revival FOREIGN KEY (revival) REFERENCES refs_data.logical_responses (code);
-- change ros_gn.gear_specifications.net_drum_hauler to logical response
ALTER TABLE ros_gn.gear_specifications ADD COLUMN net_drum_hauler2 VARCHAR(5);
UPDATE ros_gn.gear_specifications SET net_drum_hauler2 = 'UNK' WHERE net_drum_hauler IS NULL;
UPDATE ros_gn.gear_specifications SET net_drum_hauler2 = 'TRUE' WHERE net_drum_hauler = TRUE;
UPDATE ros_gn.gear_specifications SET net_drum_hauler2 = 'FALSE' WHERE net_drum_hauler = FALSE;
ALTER TABLE ros_gn.gear_specifications DROP COLUMN net_drum_hauler;
ALTER TABLE ros_gn.gear_specifications RENAME COLUMN net_drum_hauler2 TO  net_drum_hauler;
ALTER TABLE ros_gn.gear_specifications ADD CONSTRAINT fk_ros_gn_gear_specifications_net_drum_hauler FOREIGN KEY (net_drum_hauler) REFERENCES refs_data.logical_responses (code);
-- change ros_gn.gillnet_configuration.droplines_used to logical response
ALTER TABLE ros_gn.gillnet_configuration ADD COLUMN droplines_used2 VARCHAR(5);
UPDATE ros_gn.gillnet_configuration SET droplines_used2 = 'UNK' WHERE droplines_used IS NULL;
UPDATE ros_gn.gillnet_configuration SET droplines_used2 = 'TRUE' WHERE droplines_used = TRUE;
UPDATE ros_gn.gillnet_configuration SET droplines_used2 = 'FALSE' WHERE droplines_used = FALSE;
ALTER TABLE ros_gn.gillnet_configuration DROP COLUMN droplines_used;
ALTER TABLE ros_gn.gillnet_configuration RENAME COLUMN droplines_used2 TO  droplines_used;
ALTER TABLE ros_gn.gillnet_configuration ADD CONSTRAINT fk_ros_gn_gillnet_configuration_droplines_used FOREIGN KEY (droplines_used) REFERENCES refs_data.logical_responses (code);
-- change ros_gn.gillnet_configuration.panels_stacked to logical response
ALTER TABLE ros_gn.gillnet_configuration ADD COLUMN panels_stacked2 VARCHAR(5);
UPDATE ros_gn.gillnet_configuration SET panels_stacked2 = 'UNK' WHERE panels_stacked IS NULL;
UPDATE ros_gn.gillnet_configuration SET panels_stacked2 = 'TRUE' WHERE panels_stacked = TRUE;
UPDATE ros_gn.gillnet_configuration SET panels_stacked2 = 'FALSE' WHERE panels_stacked = FALSE;
ALTER TABLE ros_gn.gillnet_configuration DROP COLUMN panels_stacked;
ALTER TABLE ros_gn.gillnet_configuration RENAME COLUMN panels_stacked2 TO  panels_stacked;
ALTER TABLE ros_gn.gillnet_configuration ADD CONSTRAINT fk_ros_gn_gillnet_configuration_panels_stacked FOREIGN KEY (panels_stacked) REFERENCES refs_data.logical_responses (code);
-- change ros_gn.mitigation_measures.mitigation_measures to logical response
ALTER TABLE ros_gn.mitigation_measures ADD COLUMN mitigation_measures2 VARCHAR(5);
UPDATE ros_gn.mitigation_measures SET mitigation_measures2 = 'UNK' WHERE mitigation_measures IS NULL;
UPDATE ros_gn.mitigation_measures SET mitigation_measures2 = 'TRUE' WHERE mitigation_measures = TRUE;
UPDATE ros_gn.mitigation_measures SET mitigation_measures2 = 'FALSE' WHERE mitigation_measures = FALSE;
ALTER TABLE ros_gn.mitigation_measures DROP COLUMN mitigation_measures;
ALTER TABLE ros_gn.mitigation_measures RENAME COLUMN mitigation_measures2 TO  mitigation_measures;
ALTER TABLE ros_gn.mitigation_measures ADD CONSTRAINT fk_ros_gn_mitigation_measures_mitigation_measures FOREIGN KEY (mitigation_measures) REFERENCES refs_data.logical_responses (code);
-- change ros_gn.tag_details.tag_recovery to logical response
ALTER TABLE ros_gn.tag_details ADD COLUMN tag_recovery2 VARCHAR(5);
UPDATE ros_gn.tag_details SET tag_recovery2 = 'UNK' WHERE tag_recovery IS NULL;
UPDATE ros_gn.tag_details SET tag_recovery2 = 'TRUE' WHERE tag_recovery = TRUE;
UPDATE ros_gn.tag_details SET tag_recovery2 = 'FALSE' WHERE tag_recovery = FALSE;
ALTER TABLE ros_gn.tag_details DROP COLUMN tag_recovery;
ALTER TABLE ros_gn.tag_details RENAME COLUMN tag_recovery2 TO  tag_recovery;
ALTER TABLE ros_gn.tag_details ADD CONSTRAINT fk_ros_gn_tag_details_tag_recovery FOREIGN KEY (tag_recovery) REFERENCES refs_data.logical_responses (code);
-- change ros_gn.tag_details.tag_release to logical response
ALTER TABLE ros_gn.tag_details ADD COLUMN tag_release2 VARCHAR(5);
UPDATE ros_gn.tag_details SET tag_release2 = 'UNK' WHERE tag_release IS NULL;
UPDATE ros_gn.tag_details SET tag_release2 = 'TRUE' WHERE tag_release = TRUE;
UPDATE ros_gn.tag_details SET tag_release2 = 'FALSE' WHERE tag_release = FALSE;
ALTER TABLE ros_gn.tag_details DROP COLUMN tag_release;
ALTER TABLE ros_gn.tag_details RENAME COLUMN tag_release2 TO  tag_release;
ALTER TABLE ros_gn.tag_details ADD CONSTRAINT fk_ros_gn_tag_details_tag_release FOREIGN KEY (tag_release) REFERENCES refs_data.logical_responses (code);
-- change ros_ll.additional_catch_details_on_ssi.brought_on_board to logical response
ALTER TABLE ros_ll.additional_catch_details_on_ssi ADD COLUMN brought_on_board2 VARCHAR(5);
UPDATE ros_ll.additional_catch_details_on_ssi SET brought_on_board2 = 'UNK' WHERE brought_on_board IS NULL;
UPDATE ros_ll.additional_catch_details_on_ssi SET brought_on_board2 = 'TRUE' WHERE brought_on_board = TRUE;
UPDATE ros_ll.additional_catch_details_on_ssi SET brought_on_board2 = 'FALSE' WHERE brought_on_board = FALSE;
ALTER TABLE ros_ll.additional_catch_details_on_ssi DROP COLUMN brought_on_board;
ALTER TABLE ros_ll.additional_catch_details_on_ssi RENAME COLUMN brought_on_board2 TO  brought_on_board;
ALTER TABLE ros_ll.additional_catch_details_on_ssi ADD CONSTRAINT fk_ros_ll_additional_catch_details_on_ssi_brought_on_board FOREIGN KEY (brought_on_board) REFERENCES refs_data.logical_responses (code);
-- change ros_ll.additional_catch_details_on_ssi.light_attached_to_branchline to logical response
ALTER TABLE ros_ll.additional_catch_details_on_ssi ADD COLUMN light_attached_to_branchline2 VARCHAR(5);
UPDATE ros_ll.additional_catch_details_on_ssi SET light_attached_to_branchline2 = 'UNK' WHERE light_attached_to_branchline IS NULL;
UPDATE ros_ll.additional_catch_details_on_ssi SET light_attached_to_branchline2 = 'TRUE' WHERE light_attached_to_branchline = TRUE;
UPDATE ros_ll.additional_catch_details_on_ssi SET light_attached_to_branchline2 = 'FALSE' WHERE light_attached_to_branchline = FALSE;
ALTER TABLE ros_ll.additional_catch_details_on_ssi DROP COLUMN light_attached_to_branchline;
ALTER TABLE ros_ll.additional_catch_details_on_ssi RENAME COLUMN light_attached_to_branchline2 TO  light_attached_to_branchline;
ALTER TABLE ros_ll.additional_catch_details_on_ssi ADD CONSTRAINT fk_ros_ll_additional_catch_details_on_ssi_light_attached_to_branchline FOREIGN KEY (light_attached_to_branchline) REFERENCES refs_data.logical_responses (code);
-- change ros_ll.additional_catch_details_on_ssi.revival to logical response
ALTER TABLE ros_ll.additional_catch_details_on_ssi ADD COLUMN revival2 VARCHAR(5);
UPDATE ros_ll.additional_catch_details_on_ssi SET revival2 = 'UNK' WHERE revival IS NULL;
UPDATE ros_ll.additional_catch_details_on_ssi SET revival2 = 'TRUE' WHERE revival = TRUE;
UPDATE ros_ll.additional_catch_details_on_ssi SET revival2 = 'FALSE' WHERE revival = FALSE;
ALTER TABLE ros_ll.additional_catch_details_on_ssi DROP COLUMN revival;
ALTER TABLE ros_ll.additional_catch_details_on_ssi RENAME COLUMN revival2 TO  revival;
ALTER TABLE ros_ll.additional_catch_details_on_ssi ADD CONSTRAINT fk_ros_ll_additional_catch_details_on_ssi_revival FOREIGN KEY (revival) REFERENCES refs_data.logical_responses (code);
-- change ros_ll.gear_specifications.bait_casting_machine to logical response
ALTER TABLE ros_ll.gear_specifications ADD COLUMN bait_casting_machine2 VARCHAR(5);
UPDATE ros_ll.gear_specifications SET bait_casting_machine2 = 'UNK' WHERE bait_casting_machine IS NULL;
UPDATE ros_ll.gear_specifications SET bait_casting_machine2 = 'TRUE' WHERE bait_casting_machine = TRUE;
UPDATE ros_ll.gear_specifications SET bait_casting_machine2 = 'FALSE' WHERE bait_casting_machine = FALSE;
ALTER TABLE ros_ll.gear_specifications DROP COLUMN bait_casting_machine;
ALTER TABLE ros_ll.gear_specifications RENAME COLUMN bait_casting_machine2 TO  bait_casting_machine;
ALTER TABLE ros_ll.gear_specifications ADD CONSTRAINT fk_ros_ll_gear_specifications_bait_casting_machine FOREIGN KEY (bait_casting_machine) REFERENCES refs_data.logical_responses (code);
-- change ros_ll.gear_specifications.line_hauler to logical response
ALTER TABLE ros_ll.gear_specifications ADD COLUMN line_hauler2 VARCHAR(5);
UPDATE ros_ll.gear_specifications SET line_hauler2 = 'UNK' WHERE line_hauler IS NULL;
UPDATE ros_ll.gear_specifications SET line_hauler2 = 'TRUE' WHERE line_hauler = TRUE;
UPDATE ros_ll.gear_specifications SET line_hauler2 = 'FALSE' WHERE line_hauler = FALSE;
ALTER TABLE ros_ll.gear_specifications DROP COLUMN line_hauler;
ALTER TABLE ros_ll.gear_specifications RENAME COLUMN line_hauler2 TO  line_hauler;
ALTER TABLE ros_ll.gear_specifications ADD CONSTRAINT fk_ros_ll_gear_specifications_line_hauler FOREIGN KEY (line_hauler) REFERENCES refs_data.logical_responses (code);
-- change ros_ll.gear_specifications.line_setter to logical response
ALTER TABLE ros_ll.gear_specifications ADD COLUMN line_setter2 VARCHAR(5);
UPDATE ros_ll.gear_specifications SET line_setter2 = 'UNK' WHERE line_setter IS NULL;
UPDATE ros_ll.gear_specifications SET line_setter2 = 'TRUE' WHERE line_setter = TRUE;
UPDATE ros_ll.gear_specifications SET line_setter2 = 'FALSE' WHERE line_setter = FALSE;
ALTER TABLE ros_ll.gear_specifications DROP COLUMN line_setter;
ALTER TABLE ros_ll.gear_specifications RENAME COLUMN line_setter2 TO  line_setter;
ALTER TABLE ros_ll.gear_specifications ADD CONSTRAINT fk_ros_ll_gear_specifications_line_setter FOREIGN KEY (line_setter) REFERENCES refs_data.logical_responses (code);
-- change ros_ll.mitigation_measures.branchline_weighted to logical response
ALTER TABLE ros_ll.mitigation_measures ADD COLUMN branchline_weighted2 VARCHAR(5);
UPDATE ros_ll.mitigation_measures SET branchline_weighted2 = 'UNK' WHERE branchline_weighted IS NULL;
UPDATE ros_ll.mitigation_measures SET branchline_weighted2 = 'TRUE' WHERE branchline_weighted = TRUE;
UPDATE ros_ll.mitigation_measures SET branchline_weighted2 = 'FALSE' WHERE branchline_weighted = FALSE;
ALTER TABLE ros_ll.mitigation_measures DROP COLUMN branchline_weighted;
ALTER TABLE ros_ll.mitigation_measures RENAME COLUMN branchline_weighted2 TO  branchline_weighted;
ALTER TABLE ros_ll.mitigation_measures ADD CONSTRAINT fk_ros_ll_mitigation_measures_branchline_weighted FOREIGN KEY (branchline_weighted) REFERENCES refs_data.logical_responses (code);
-- change ros_ll.mitigation_measures.hooks_set_between_dusk_and_dawn to logical response
ALTER TABLE ros_ll.mitigation_measures ADD COLUMN hooks_set_between_dusk_and_dawn2 VARCHAR(5);
UPDATE ros_ll.mitigation_measures SET hooks_set_between_dusk_and_dawn2 = 'UNK' WHERE hooks_set_between_dusk_and_dawn IS NULL;
UPDATE ros_ll.mitigation_measures SET hooks_set_between_dusk_and_dawn2 = 'TRUE' WHERE hooks_set_between_dusk_and_dawn = TRUE;
UPDATE ros_ll.mitigation_measures SET hooks_set_between_dusk_and_dawn2 = 'FALSE' WHERE hooks_set_between_dusk_and_dawn = FALSE;
ALTER TABLE ros_ll.mitigation_measures DROP COLUMN hooks_set_between_dusk_and_dawn;
ALTER TABLE ros_ll.mitigation_measures RENAME COLUMN hooks_set_between_dusk_and_dawn2 TO  hooks_set_between_dusk_and_dawn;
ALTER TABLE ros_ll.mitigation_measures ADD CONSTRAINT fk_ros_ll_mitigation_measures_hooks_set_between_dusk_and_dawn FOREIGN KEY (hooks_set_between_dusk_and_dawn) REFERENCES refs_data.logical_responses (code);
-- change ros_ll.mitigation_measures.minimum_deck_lighting_used to logical response
ALTER TABLE ros_ll.mitigation_measures ADD COLUMN minimum_deck_lighting_used2 VARCHAR(5);
UPDATE ros_ll.mitigation_measures SET minimum_deck_lighting_used2 = 'UNK' WHERE minimum_deck_lighting_used IS NULL;
UPDATE ros_ll.mitigation_measures SET minimum_deck_lighting_used2 = 'TRUE' WHERE minimum_deck_lighting_used = TRUE;
UPDATE ros_ll.mitigation_measures SET minimum_deck_lighting_used2 = 'FALSE' WHERE minimum_deck_lighting_used = FALSE;
ALTER TABLE ros_ll.mitigation_measures DROP COLUMN minimum_deck_lighting_used;
ALTER TABLE ros_ll.mitigation_measures RENAME COLUMN minimum_deck_lighting_used2 TO  minimum_deck_lighting_used;
ALTER TABLE ros_ll.mitigation_measures ADD CONSTRAINT fk_ros_ll_mitigation_measures_minimum_deck_lighting_used FOREIGN KEY (minimum_deck_lighting_used) REFERENCES refs_data.logical_responses (code);
-- change ros_ll.mitigation_measures.hooks_pods to logical response
ALTER TABLE ros_ll.mitigation_measures ADD COLUMN hooks_pods2 VARCHAR(5);
UPDATE ros_ll.mitigation_measures SET hooks_pods2 = 'UNK' WHERE hooks_pods IS NULL;
UPDATE ros_ll.mitigation_measures SET hooks_pods2 = 'TRUE' WHERE hooks_pods = TRUE;
UPDATE ros_ll.mitigation_measures SET hooks_pods2 = 'FALSE' WHERE hooks_pods = FALSE;
ALTER TABLE ros_ll.mitigation_measures DROP COLUMN hooks_pods;
ALTER TABLE ros_ll.mitigation_measures RENAME COLUMN hooks_pods2 TO  hooks_pods;
ALTER TABLE ros_ll.mitigation_measures ADD CONSTRAINT fk_ros_ll_mitigation_measures_hooks_pods FOREIGN KEY (hooks_pods) REFERENCES refs_data.logical_responses (code);
-- change ros_ll.tag_details.tag_recovery to logical response
ALTER TABLE ros_ll.tag_details ADD COLUMN tag_recovery2 VARCHAR(5);
UPDATE ros_ll.tag_details SET tag_recovery2 = 'UNK' WHERE tag_recovery IS NULL;
UPDATE ros_ll.tag_details SET tag_recovery2 = 'TRUE' WHERE tag_recovery = TRUE;
UPDATE ros_ll.tag_details SET tag_recovery2 = 'FALSE' WHERE tag_recovery = FALSE;
ALTER TABLE ros_ll.tag_details DROP COLUMN tag_recovery;
ALTER TABLE ros_ll.tag_details RENAME COLUMN tag_recovery2 TO  tag_recovery;
ALTER TABLE ros_ll.tag_details ADD CONSTRAINT fk_ros_ll_tag_details_tag_recovery FOREIGN KEY (tag_recovery) REFERENCES refs_data.logical_responses (code);
-- change ros_ll.tag_details.tag_release to logical response
ALTER TABLE ros_ll.tag_details ADD COLUMN tag_release2 VARCHAR(5);
UPDATE ros_ll.tag_details SET tag_release2 = 'UNK' WHERE tag_release IS NULL;
UPDATE ros_ll.tag_details SET tag_release2 = 'TRUE' WHERE tag_release = TRUE;
UPDATE ros_ll.tag_details SET tag_release2 = 'FALSE' WHERE tag_release = FALSE;
ALTER TABLE ros_ll.tag_details DROP COLUMN tag_release;
ALTER TABLE ros_ll.tag_details RENAME COLUMN tag_release2 TO  tag_release;
ALTER TABLE ros_ll.tag_details ADD CONSTRAINT fk_ros_ll_tag_details_tag_release FOREIGN KEY (tag_release) REFERENCES refs_data.logical_responses (code);
-- change ros_ll.tori_line_details.streamers_reach_surface to logical response
ALTER TABLE ros_ll.tori_line_details ADD COLUMN streamers_reach_surface2 VARCHAR(5);
UPDATE ros_ll.tori_line_details SET streamers_reach_surface2 = 'UNK' WHERE streamers_reach_surface IS NULL;
UPDATE ros_ll.tori_line_details SET streamers_reach_surface2 = 'TRUE' WHERE streamers_reach_surface = TRUE;
UPDATE ros_ll.tori_line_details SET streamers_reach_surface2 = 'FALSE' WHERE streamers_reach_surface = FALSE;
ALTER TABLE ros_ll.tori_line_details DROP COLUMN streamers_reach_surface;
ALTER TABLE ros_ll.tori_line_details RENAME COLUMN streamers_reach_surface2 TO  streamers_reach_surface;
ALTER TABLE ros_ll.tori_line_details ADD CONSTRAINT fk_ros_ll_tori_line_details_streamers_reach_surface FOREIGN KEY (streamers_reach_surface) REFERENCES refs_data.logical_responses (code);
-- change ros_pl.additional_catch_details_on_ssi.brought_on_board to logical response
ALTER TABLE ros_pl.additional_catch_details_on_ssi ADD COLUMN brought_on_board2 VARCHAR(5);
UPDATE ros_pl.additional_catch_details_on_ssi SET brought_on_board2 = 'UNK' WHERE brought_on_board IS NULL;
UPDATE ros_pl.additional_catch_details_on_ssi SET brought_on_board2 = 'TRUE' WHERE brought_on_board = TRUE;
UPDATE ros_pl.additional_catch_details_on_ssi SET brought_on_board2 = 'FALSE' WHERE brought_on_board = FALSE;
ALTER TABLE ros_pl.additional_catch_details_on_ssi DROP COLUMN brought_on_board;
ALTER TABLE ros_pl.additional_catch_details_on_ssi RENAME COLUMN brought_on_board2 TO  brought_on_board;
ALTER TABLE ros_pl.additional_catch_details_on_ssi ADD CONSTRAINT fk_ros_pl_additional_catch_details_on_ssi_brought_on_board FOREIGN KEY (brought_on_board) REFERENCES refs_data.logical_responses (code);
-- change ros_pl.additional_catch_details_on_ssi.revival to logical response
ALTER TABLE ros_pl.additional_catch_details_on_ssi ADD COLUMN revival2 VARCHAR(5);
UPDATE ros_pl.additional_catch_details_on_ssi SET revival2 = 'UNK' WHERE revival IS NULL;
UPDATE ros_pl.additional_catch_details_on_ssi SET revival2 = 'TRUE' WHERE revival = TRUE;
UPDATE ros_pl.additional_catch_details_on_ssi SET revival2 = 'FALSE' WHERE revival = FALSE;
ALTER TABLE ros_pl.additional_catch_details_on_ssi DROP COLUMN revival;
ALTER TABLE ros_pl.additional_catch_details_on_ssi RENAME COLUMN revival2 TO  revival;
ALTER TABLE ros_pl.additional_catch_details_on_ssi ADD CONSTRAINT fk_ros_pl_additional_catch_details_on_ssi_revival FOREIGN KEY (revival) REFERENCES refs_data.logical_responses (code);
-- change ros_pl.tag_details.tag_recovery to logical response
ALTER TABLE ros_pl.tag_details ADD COLUMN tag_recovery2 VARCHAR(5);
UPDATE ros_pl.tag_details SET tag_recovery2 = 'UNK' WHERE tag_recovery IS NULL;
UPDATE ros_pl.tag_details SET tag_recovery2 = 'TRUE' WHERE tag_recovery = TRUE;
UPDATE ros_pl.tag_details SET tag_recovery2 = 'FALSE' WHERE tag_recovery = FALSE;
ALTER TABLE ros_pl.tag_details DROP COLUMN tag_recovery;
ALTER TABLE ros_pl.tag_details RENAME COLUMN tag_recovery2 TO  tag_recovery;
ALTER TABLE ros_pl.tag_details ADD CONSTRAINT fk_ros_pl_tag_details_tag_recovery FOREIGN KEY (tag_recovery) REFERENCES refs_data.logical_responses (code);
-- change ros_pl.tag_details.tag_release to logical response
ALTER TABLE ros_pl.tag_details ADD COLUMN tag_release2 VARCHAR(5);
UPDATE ros_pl.tag_details SET tag_release2 = 'UNK' WHERE tag_release IS NULL;
UPDATE ros_pl.tag_details SET tag_release2 = 'TRUE' WHERE tag_release = TRUE;
UPDATE ros_pl.tag_details SET tag_release2 = 'FALSE' WHERE tag_release = FALSE;
ALTER TABLE ros_pl.tag_details DROP COLUMN tag_release;
ALTER TABLE ros_pl.tag_details RENAME COLUMN tag_release2 TO  tag_release;
ALTER TABLE ros_pl.tag_details ADD CONSTRAINT fk_ros_pl_tag_details_tag_release FOREIGN KEY (tag_release) REFERENCES refs_data.logical_responses (code);
-- change ros_pl.tuna_fishing_operations.bait_used to logical response
ALTER TABLE ros_pl.tuna_fishing_operations ADD COLUMN bait_used2 VARCHAR(5);
UPDATE ros_pl.tuna_fishing_operations SET bait_used2 = 'UNK' WHERE bait_used IS NULL;
UPDATE ros_pl.tuna_fishing_operations SET bait_used2 = 'TRUE' WHERE bait_used = TRUE;
UPDATE ros_pl.tuna_fishing_operations SET bait_used2 = 'FALSE' WHERE bait_used = FALSE;
ALTER TABLE ros_pl.tuna_fishing_operations DROP COLUMN bait_used;
ALTER TABLE ros_pl.tuna_fishing_operations RENAME COLUMN bait_used2 TO  bait_used;
ALTER TABLE ros_pl.tuna_fishing_operations ADD CONSTRAINT fk_ros_pl_tuna_fishing_operations_bait_used FOREIGN KEY (bait_used) REFERENCES refs_data.logical_responses (code);
-- change ros_ps.additional_catch_details_on_ssi.brought_on_board to logical response
ALTER TABLE ros_ps.additional_catch_details_on_ssi ADD COLUMN brought_on_board2 VARCHAR(5);
UPDATE ros_ps.additional_catch_details_on_ssi SET brought_on_board2 = 'UNK' WHERE brought_on_board IS NULL;
UPDATE ros_ps.additional_catch_details_on_ssi SET brought_on_board2 = 'TRUE' WHERE brought_on_board = TRUE;
UPDATE ros_ps.additional_catch_details_on_ssi SET brought_on_board2 = 'FALSE' WHERE brought_on_board = FALSE;
ALTER TABLE ros_ps.additional_catch_details_on_ssi DROP COLUMN brought_on_board;
ALTER TABLE ros_ps.additional_catch_details_on_ssi RENAME COLUMN brought_on_board2 TO  brought_on_board;
ALTER TABLE ros_ps.additional_catch_details_on_ssi ADD CONSTRAINT fk_ros_ps_additional_catch_details_on_ssi_brought_on_board FOREIGN KEY (brought_on_board) REFERENCES refs_data.logical_responses (code);
-- change ros_ps.additional_catch_details_on_ssi.revival to logical response
ALTER TABLE ros_ps.additional_catch_details_on_ssi ADD COLUMN revival2 VARCHAR(5);
UPDATE ros_ps.additional_catch_details_on_ssi SET revival2 = 'UNK' WHERE revival IS NULL;
UPDATE ros_ps.additional_catch_details_on_ssi SET revival2 = 'TRUE' WHERE revival = TRUE;
UPDATE ros_ps.additional_catch_details_on_ssi SET revival2 = 'FALSE' WHERE revival = FALSE;
ALTER TABLE ros_ps.additional_catch_details_on_ssi DROP COLUMN revival;
ALTER TABLE ros_ps.additional_catch_details_on_ssi RENAME COLUMN revival2 TO  revival;
ALTER TABLE ros_ps.additional_catch_details_on_ssi ADD CONSTRAINT fk_ros_ps_additional_catch_details_on_ssi_revival FOREIGN KEY (revival) REFERENCES refs_data.logical_responses (code);
-- change ros_ps.cetaceans_whale_shark_sightings.caught_inside_the_net to logical response
ALTER TABLE ros_ps.cetaceans_whale_shark_sightings ADD COLUMN caught_inside_the_net2 VARCHAR(5);
UPDATE ros_ps.cetaceans_whale_shark_sightings SET caught_inside_the_net2 = 'UNK' WHERE caught_inside_the_net IS NULL;
UPDATE ros_ps.cetaceans_whale_shark_sightings SET caught_inside_the_net2 = 'TRUE' WHERE caught_inside_the_net = TRUE;
UPDATE ros_ps.cetaceans_whale_shark_sightings SET caught_inside_the_net2 = 'FALSE' WHERE caught_inside_the_net = FALSE;
ALTER TABLE ros_ps.cetaceans_whale_shark_sightings DROP COLUMN caught_inside_the_net;
ALTER TABLE ros_ps.cetaceans_whale_shark_sightings RENAME COLUMN caught_inside_the_net2 TO  caught_inside_the_net;
ALTER TABLE ros_ps.cetaceans_whale_shark_sightings ADD CONSTRAINT fk_ros_ps_cetaceans_whale_shark_sightings_caught_inside_the_net FOREIGN KEY (caught_inside_the_net) REFERENCES refs_data.logical_responses (code);
-- change ros_ps.cetaceans_whale_shark_sightings.sighting_occurred_before_setting to logical response
ALTER TABLE ros_ps.cetaceans_whale_shark_sightings ADD COLUMN sighting_occurred_before_setting2 VARCHAR(5);
UPDATE ros_ps.cetaceans_whale_shark_sightings SET sighting_occurred_before_setting2 = 'UNK' WHERE sighting_occurred_before_setting IS NULL;
UPDATE ros_ps.cetaceans_whale_shark_sightings SET sighting_occurred_before_setting2 = 'TRUE' WHERE sighting_occurred_before_setting = TRUE;
UPDATE ros_ps.cetaceans_whale_shark_sightings SET sighting_occurred_before_setting2 = 'FALSE' WHERE sighting_occurred_before_setting = FALSE;
ALTER TABLE ros_ps.cetaceans_whale_shark_sightings DROP COLUMN sighting_occurred_before_setting;
ALTER TABLE ros_ps.cetaceans_whale_shark_sightings RENAME COLUMN sighting_occurred_before_setting2 TO  sighting_occurred_before_setting;
ALTER TABLE ros_ps.cetaceans_whale_shark_sightings ADD CONSTRAINT fk_ros_ps_cetaceans_whale_shark_sightings_sighting_occurred_before_setting FOREIGN KEY (sighting_occurred_before_setting) REFERENCES refs_data.logical_responses (code);
-- change ros_ps.gear_specifications.power_block to logical response
ALTER TABLE ros_ps.gear_specifications ADD COLUMN power_block2 VARCHAR(5);
UPDATE ros_ps.gear_specifications SET power_block2 = 'UNK' WHERE power_block IS NULL;
UPDATE ros_ps.gear_specifications SET power_block2 = 'TRUE' WHERE power_block = TRUE;
UPDATE ros_ps.gear_specifications SET power_block2 = 'FALSE' WHERE power_block = FALSE;
ALTER TABLE ros_ps.gear_specifications DROP COLUMN power_block;
ALTER TABLE ros_ps.gear_specifications RENAME COLUMN power_block2 TO  power_block;
ALTER TABLE ros_ps.gear_specifications ADD CONSTRAINT fk_ros_ps_gear_specifications_power_block FOREIGN KEY (power_block) REFERENCES refs_data.logical_responses (code);
-- change ros_ps.gear_specifications.purse_winch to logical response
ALTER TABLE ros_ps.gear_specifications ADD COLUMN purse_winch2 VARCHAR(5);
UPDATE ros_ps.gear_specifications SET purse_winch2 = 'UNK' WHERE purse_winch IS NULL;
UPDATE ros_ps.gear_specifications SET purse_winch2 = 'TRUE' WHERE purse_winch = TRUE;
UPDATE ros_ps.gear_specifications SET purse_winch2 = 'FALSE' WHERE purse_winch = FALSE;
ALTER TABLE ros_ps.gear_specifications DROP COLUMN purse_winch;
ALTER TABLE ros_ps.gear_specifications RENAME COLUMN purse_winch2 TO  purse_winch;
ALTER TABLE ros_ps.gear_specifications ADD CONSTRAINT fk_ros_ps_gear_specifications_purse_winch FOREIGN KEY (purse_winch) REFERENCES refs_data.logical_responses (code);
-- change ros_ps.object_details.equipped_with_artificial_lights_at_deploy to logical response
ALTER TABLE ros_ps.object_details ADD COLUMN equipped_with_artificial_lights_at_deploy2 VARCHAR(5);
UPDATE ros_ps.object_details SET equipped_with_artificial_lights_at_deploy2 = 'UNK' WHERE equipped_with_artificial_lights_at_deploy IS NULL;
UPDATE ros_ps.object_details SET equipped_with_artificial_lights_at_deploy2 = 'TRUE' WHERE equipped_with_artificial_lights_at_deploy = TRUE;
UPDATE ros_ps.object_details SET equipped_with_artificial_lights_at_deploy2 = 'FALSE' WHERE equipped_with_artificial_lights_at_deploy = FALSE;
ALTER TABLE ros_ps.object_details DROP COLUMN equipped_with_artificial_lights_at_deploy;
ALTER TABLE ros_ps.object_details RENAME COLUMN equipped_with_artificial_lights_at_deploy2 TO  equipped_with_artificial_lights_at_deploy;
ALTER TABLE ros_ps.object_details ADD CONSTRAINT fk_ros_ps_object_details_equipped_with_artificial_lights_at_deploy FOREIGN KEY (equipped_with_artificial_lights_at_deploy) REFERENCES refs_data.logical_responses (code);
-- change ros_ps.object_details.equipped_with_artificial_lights_on_retrieval to logical response
ALTER TABLE ros_ps.object_details ADD COLUMN equipped_with_artificial_lights_on_retrieval2 VARCHAR(5);
UPDATE ros_ps.object_details SET equipped_with_artificial_lights_on_retrieval2 = 'UNK' WHERE equipped_with_artificial_lights_on_retrieval IS NULL;
UPDATE ros_ps.object_details SET equipped_with_artificial_lights_on_retrieval2 = 'TRUE' WHERE equipped_with_artificial_lights_on_retrieval = TRUE;
UPDATE ros_ps.object_details SET equipped_with_artificial_lights_on_retrieval2 = 'FALSE' WHERE equipped_with_artificial_lights_on_retrieval = FALSE;
ALTER TABLE ros_ps.object_details DROP COLUMN equipped_with_artificial_lights_on_retrieval;
ALTER TABLE ros_ps.object_details RENAME COLUMN equipped_with_artificial_lights_on_retrieval2 TO  equipped_with_artificial_lights_on_retrieval;
ALTER TABLE ros_ps.object_details ADD CONSTRAINT fk_ros_ps_object_details_equipped_with_artificial_lights_on_retrieval FOREIGN KEY (equipped_with_artificial_lights_on_retrieval) REFERENCES refs_data.logical_responses (code);
-- change ros_ps.tag_details.tag_recovery to logical response
ALTER TABLE ros_ps.tag_details ADD COLUMN tag_recovery2 VARCHAR(5);
UPDATE ros_ps.tag_details SET tag_recovery2 = 'UNK' WHERE tag_recovery IS NULL;
UPDATE ros_ps.tag_details SET tag_recovery2 = 'TRUE' WHERE tag_recovery = TRUE;
UPDATE ros_ps.tag_details SET tag_recovery2 = 'FALSE' WHERE tag_recovery = FALSE;
ALTER TABLE ros_ps.tag_details DROP COLUMN tag_recovery;
ALTER TABLE ros_ps.tag_details RENAME COLUMN tag_recovery2 TO  tag_recovery;
ALTER TABLE ros_ps.tag_details ADD CONSTRAINT fk_ros_ps_tag_details_tag_recovery FOREIGN KEY (tag_recovery) REFERENCES refs_data.logical_responses (code);
-- change ros_ps.tag_details.tag_release to logical response
ALTER TABLE ros_ps.tag_details ADD COLUMN tag_release2 VARCHAR(5);
UPDATE ros_ps.tag_details SET tag_release2 = 'UNK' WHERE tag_release IS NULL;
UPDATE ros_ps.tag_details SET tag_release2 = 'TRUE' WHERE tag_release = TRUE;
UPDATE ros_ps.tag_details SET tag_release2 = 'FALSE' WHERE tag_release = FALSE;
ALTER TABLE ros_ps.tag_details DROP COLUMN tag_release;
ALTER TABLE ros_ps.tag_details RENAME COLUMN tag_release2 TO  tag_release;
ALTER TABLE ros_ps.tag_details ADD CONSTRAINT fk_ros_ps_tag_details_tag_release FOREIGN KEY (tag_release) REFERENCES refs_data.logical_responses (code);
