
-- ros_common.capacities (usage: ros_common.trip_vessel.fish_storage_capacity) M3/MT
ALTER TABLE ros_common.trip_vessel ADD column fish_storage_capacity_value double precision;
ALTER TABLE ros_common.trip_vessel ADD column fish_storage_capacity_unit varchar(3) constraint ros_common_trip_vessel_fish_storage_capacity_unit_check CHECK ( fish_storage_capacity_unit IN ('M3','MT') ) ;
UPDATE ros_common.trip_vessel t SET fish_storage_capacity_value = m.value, fish_storage_capacity_unit = upper(m.unit) FROM ros_common.capacities m WHERE t.fish_storage_capacity_id = m.id;
ALTER TABLE ros_common.trip_vessel DROP COLUMN fish_storage_capacity_id;
 
-- ros_common.depths (usage: ros_ps.gear_specifications.maximum_net_depth) M
ALTER TABLE ros_ps.gear_specifications ADD column maximum_net_depth_value double precision;
ALTER TABLE ros_ps.gear_specifications ADD column maximum_net_depth_unit varchar(3) constraint ros_ps_gear_specifications_maximum_net_depth_unit_check CHECK ( maximum_net_depth_unit IN ('M') ) ;
UPDATE ros_ps.gear_specifications t SET maximum_net_depth_value = m.value, maximum_net_depth_unit = upper(m.unit) FROM ros_common.depths m WHERE t.maximum_net_depth_id = m.id;
ALTER TABLE ros_ps.gear_specifications DROP COLUMN maximum_net_depth_id;
 
-- ros_common.depths (usage: ros_pl.bait_fishing_operations.event_depth) M
ALTER TABLE ros_pl.bait_fishing_operations ADD column event_depth_value double precision;
ALTER TABLE ros_pl.bait_fishing_operations ADD column event_depth_unit varchar(3) constraint ros_pl_bait_fishing_operations_event_depth_unit_check CHECK ( event_depth_unit IN ('M') ) ;
UPDATE ros_pl.bait_fishing_operations t SET event_depth_value = m.value, event_depth_unit = upper(m.unit) FROM ros_common.depths m WHERE t.event_depth_id = m.id;
ALTER TABLE ros_pl.bait_fishing_operations DROP COLUMN event_depth_id;
 
-- ros_common.depths (usage: ros_gn.gillnet_configuration.net_depth) M
ALTER TABLE ros_gn.gillnet_configuration ADD column net_depth_value double precision;
ALTER TABLE ros_gn.gillnet_configuration ADD column net_depth_unit varchar(3) constraint ros_gn_gillnet_configuration_net_depth_unit_check CHECK ( net_depth_unit IN ('M') ) ;
UPDATE ros_gn.gillnet_configuration t SET net_depth_value = m.value, net_depth_unit = upper(m.unit) FROM ros_common.depths m WHERE t.net_depth_id = m.id;
ALTER TABLE ros_gn.gillnet_configuration DROP COLUMN net_depth_id;
 
-- ros_common.diameters (usage: ros_ll.branchline_sections.diameter) MM
ALTER TABLE ros_ll.branchline_sections ADD column diameter_value double precision;
ALTER TABLE ros_ll.branchline_sections ADD column diameter_unit varchar(3) constraint ros_ll_branchline_sections_diameter_unit_check CHECK ( diameter_unit IN ('MM') ) ;
UPDATE ros_ll.branchline_sections t SET diameter_value = m.value, diameter_unit = upper(m.unit) FROM ros_common.diameters m WHERE t.diameter_id = m.id;
ALTER TABLE ros_ll.branchline_sections DROP COLUMN diameter_id;
 
-- ros_common.distances (usage: ros_ll.mitigation_measures.hook_sinker_distance)
ALTER TABLE ros_ll.mitigation_measures ADD column hook_sinker_distance_value double precision;
ALTER TABLE ros_ll.mitigation_measures ADD column hook_sinker_distance_unit varchar(3);
UPDATE ros_ll.mitigation_measures t SET hook_sinker_distance_value = m.value, hook_sinker_distance_unit = upper(m.unit) FROM ros_common.distances m WHERE t.hook_sinker_distance_id = m.id;
ALTER TABLE ros_ll.mitigation_measures DROP COLUMN hook_sinker_distance_id;
 
-- ros_common.distances (usage: ros_ll.tori_line_details.streamer_distance)
ALTER TABLE ros_ll.tori_line_details ADD column streamer_distance_value double precision;
ALTER TABLE ros_ll.tori_line_details ADD column streamer_distance_unit varchar(3);
UPDATE ros_ll.tori_line_details t SET streamer_distance_value = m.value, streamer_distance_unit = upper(m.unit) FROM ros_common.distances m WHERE t.streamer_distance_id = m.id;
ALTER TABLE ros_ll.tori_line_details DROP COLUMN streamer_distance_id;
 
-- ros_common.distances (usage: ros_gn.gillnet_configuration.distance_between_floats)
ALTER TABLE ros_gn.gillnet_configuration ADD column distance_between_floats_value double precision;
ALTER TABLE ros_gn.gillnet_configuration ADD column distance_between_floats_unit varchar(3);
UPDATE ros_gn.gillnet_configuration t SET distance_between_floats_value = m.value, distance_between_floats_unit = upper(m.unit) FROM ros_common.distances m WHERE t.distance_between_floats_id = m.id;
ALTER TABLE ros_gn.gillnet_configuration DROP COLUMN distance_between_floats_id;
 
-- ros_common.engines (usage: ros_common.trip_vessel_main_engines.main_engines) BHP/HP
ALTER TABLE ros_common.trip_vessel_main_engines ADD column main_engines_make varchar(255);
ALTER TABLE ros_common.trip_vessel_main_engines ADD column main_engines_value double precision;
ALTER TABLE ros_common.trip_vessel_main_engines ADD column main_engines_unit varchar(3) constraint ros_common_trip_vessel_main_engines_main_engines_unit_check CHECK ( main_engines_unit IN ('BHP', 'HP') ) ;
UPDATE ros_common.trip_vessel_main_engines t SET main_engines_make = m.make, main_engines_value = m.value, main_engines_unit = upper(m.unit) FROM ros_common.engines m WHERE t.main_engines_id = m.id;
ALTER TABLE ros_common.trip_vessel_main_engines DROP COLUMN main_engines_id;
ALTER TABLE ros_common.trip_vessel_main_engines ALTER column main_engines_value SET NOT NULL;
ALTER TABLE ros_common.trip_vessel_main_engines ALTER column main_engines_unit SET NOT NULL;

-- ros_common.estimated_weights (usage: ros_common.biometric_information.estimated_weight) KG/T
ALTER TABLE ros_common.biometric_information ADD column estimated_weight_value double precision;
ALTER TABLE ros_common.biometric_information ADD column estimated_weight_unit varchar(3) constraint ros_common_biometric_information_estimated_weight_unit_check CHECK ( estimated_weight_unit IN ('KG', 'T') ) ;
ALTER TABLE ros_common.biometric_information ADD column estimated_weight_type_of_measurement_code char(2);
ALTER TABLE ros_common.biometric_information ADD column estimated_weight_processing_type_code char(2);
ALTER TABLE ros_common.biometric_information ADD column estimated_weight_weight_estimation_method_code char(2);
UPDATE ros_common.biometric_information t SET estimated_weight_value = m.value, estimated_weight_unit = upper(m.unit), estimated_weight_type_of_measurement_code = m.type_of_measurement_code, estimated_weight_processing_type_code = m.processing_type_code, estimated_weight_weight_estimation_method_code = m.weight_estimation_method_code FROM ros_common.estimated_weights m WHERE t.estimated_weight_id = m.id;
ALTER TABLE ros_common.biometric_information DROP COLUMN estimated_weight_id;

-- ros_common.estimated_weights (usage: ros_ps.catch_details.estimated_weight) KG/T
ALTER TABLE ros_ps.catch_details ADD column estimated_weight_value double precision;
ALTER TABLE ros_ps.catch_details ADD column estimated_weight_unit varchar(3) constraint ros_ps_catch_details_estimated_weight_unit_check CHECK ( estimated_weight_unit IN ('KG', 'T') ) ;
ALTER TABLE ros_ps.catch_details ADD column estimated_weight_type_of_measurement_code char(2);
ALTER TABLE ros_ps.catch_details ADD column estimated_weight_processing_type_code char(2);
ALTER TABLE ros_ps.catch_details ADD column estimated_weight_weight_estimation_method_code char(2);
UPDATE ros_ps.catch_details t SET estimated_weight_value = m.value, estimated_weight_unit = upper(m.unit), estimated_weight_type_of_measurement_code = m.type_of_measurement_code, estimated_weight_processing_type_code = m.processing_type_code, estimated_weight_weight_estimation_method_code = m.weight_estimation_method_code FROM ros_common.estimated_weights m WHERE t.estimated_weight_id = m.id;
ALTER TABLE ros_ps.catch_details DROP COLUMN estimated_weight_id;

-- ros_common.estimated_weights (usage: ros_ll.catch_details.estimated_weight) KG/T
ALTER TABLE ros_ll.catch_details ADD column estimated_weight_value double precision;
ALTER TABLE ros_ll.catch_details ADD column estimated_weight_unit varchar(3) constraint ros_ll_catch_details_estimated_weight_unit_check CHECK ( estimated_weight_unit IN ('KG', 'T') ) ;
ALTER TABLE ros_ll.catch_details ADD column estimated_weight_type_of_measurement_code char(2);
ALTER TABLE ros_ll.catch_details ADD column estimated_weight_processing_type_code char(2);
ALTER TABLE ros_ll.catch_details ADD column estimated_weight_weight_estimation_method_code char(2);
UPDATE ros_ll.catch_details t SET estimated_weight_value = m.value, estimated_weight_unit = upper(m.unit), estimated_weight_type_of_measurement_code = m.type_of_measurement_code, estimated_weight_processing_type_code = m.processing_type_code, estimated_weight_weight_estimation_method_code = m.weight_estimation_method_code FROM ros_common.estimated_weights m WHERE t.estimated_weight_id = m.id;
ALTER TABLE ros_ll.catch_details DROP COLUMN estimated_weight_id;

-- ros_common.estimated_weights (usage: ros_pl.catch_details.estimated_weight) KG/T
ALTER TABLE ros_pl.catch_details ADD column estimated_weight_value double precision;
ALTER TABLE ros_pl.catch_details ADD column estimated_weight_unit varchar(3) constraint ros_pl_catch_details_estimated_weight_unit_check CHECK ( estimated_weight_unit IN ('KG', 'T') ) ;
ALTER TABLE ros_pl.catch_details ADD column estimated_weight_type_of_measurement_code char(2);
ALTER TABLE ros_pl.catch_details ADD column estimated_weight_processing_type_code char(2);
ALTER TABLE ros_pl.catch_details ADD column estimated_weight_weight_estimation_method_code char(2);
UPDATE ros_pl.catch_details t SET estimated_weight_value = m.value, estimated_weight_unit = upper(m.unit), estimated_weight_type_of_measurement_code = m.type_of_measurement_code, estimated_weight_processing_type_code = m.processing_type_code, estimated_weight_weight_estimation_method_code = m.weight_estimation_method_code FROM ros_common.estimated_weights m WHERE t.estimated_weight_id = m.id;
ALTER TABLE ros_pl.catch_details DROP COLUMN estimated_weight_id;

-- ros_common.estimated_weights (usage: ros_gn.catch_details.estimated_weight) KG/T
ALTER TABLE ros_gn.catch_details ADD column estimated_weight_value double precision;
ALTER TABLE ros_gn.catch_details ADD column estimated_weight_unit varchar(3) constraint ros_gn_catch_details_estimated_weight_unit_check CHECK ( estimated_weight_unit IN ('KG', 'T') ) ;
ALTER TABLE ros_gn.catch_details ADD column estimated_weight_type_of_measurement_code char(2);
ALTER TABLE ros_gn.catch_details ADD column estimated_weight_processing_type_code char(2);
ALTER TABLE ros_gn.catch_details ADD column estimated_weight_weight_estimation_method_code char(2);
UPDATE ros_gn.catch_details t SET estimated_weight_value = m.value, estimated_weight_unit = upper(m.unit), estimated_weight_type_of_measurement_code = m.type_of_measurement_code, estimated_weight_processing_type_code = m.processing_type_code, estimated_weight_weight_estimation_method_code = m.weight_estimation_method_code FROM ros_common.estimated_weights m WHERE t.estimated_weight_id = m.id;
ALTER TABLE ros_gn.catch_details DROP COLUMN estimated_weight_id;

-- ros_common.heights (usage: ros_ll.tori_line_details.attached_height)
ALTER TABLE ros_ll.tori_line_details ADD column attached_height_value double precision;
ALTER TABLE ros_ll.tori_line_details ADD column attached_height_unit varchar(3);
UPDATE ros_ll.tori_line_details t SET attached_height_value = m.value, attached_height_unit = upper(m.unit) FROM ros_common.heights m WHERE t.attached_height_id = m.id;
ALTER TABLE ros_ll.tori_line_details DROP COLUMN attached_height_id;

-- ros_common.lengths (usage: ros_common.trip_vessel.loa) KM/M
ALTER TABLE ros_common.trip_vessel ADD column loa_value double precision;
ALTER TABLE ros_common.trip_vessel ADD column loa_unit varchar(3) constraint ros_common_trip_vessel_estimated_weight_unit_check CHECK ( loa_unit IN ('KM', 'M') ) ;
UPDATE ros_common.trip_vessel t SET loa_value = m.value, loa_unit = upper(m.unit) FROM ros_common.lengths m WHERE t.loa_id = m.id;
ALTER TABLE ros_common.trip_vessel DROP COLUMN loa_id;

-- ros_common.lengths (usage: ros_ps.gear_specifications.maximum_net_length) KM/M
ALTER TABLE ros_ps.gear_specifications ADD column maximum_net_length_value double precision;
ALTER TABLE ros_ps.gear_specifications ADD column maximum_net_length_unit varchar(3)  constraint ros_ps_gear_specifications_maximum_net_length_unit_check CHECK ( maximum_net_length_unit IN ('KM', 'M') ) ;
UPDATE ros_ps.gear_specifications t SET maximum_net_length_value = m.value, maximum_net_length_unit = upper(m.unit) FROM ros_common.lengths m WHERE t.maximum_net_length_id = m.id;
ALTER TABLE ros_ps.gear_specifications DROP COLUMN maximum_net_length_id;

-- ros_common.lengths (usage: ros_ll.branchline_sections.length) KM/M
ALTER TABLE ros_ll.branchline_sections ADD column length_value double precision;
ALTER TABLE ros_ll.branchline_sections ADD column length_unit varchar(3) constraint ros_ll_branchline_sections_length_unit_check CHECK ( length_unit IN ('KM', 'M') ) ;
UPDATE ros_ll.branchline_sections t SET length_value = m.value, length_unit = upper(m.unit) FROM ros_common.lengths m WHERE t.length_id = m.id;
ALTER TABLE ros_ll.branchline_sections DROP COLUMN length_id;

-- ros_common.lengths (usage: ros_ll.floatlines.floatline_length) KM/M
ALTER TABLE ros_ll.floatlines ADD column floatline_length_value double precision;
ALTER TABLE ros_ll.floatlines ADD column floatline_length_unit varchar(3) constraint ros_ll_floatlines_floatline_length_unit_check CHECK ( floatline_length_unit IN ('KM', 'M') ) ;
UPDATE ros_ll.floatlines t SET floatline_length_value = m.value, floatline_length_unit = upper(m.unit) FROM ros_common.lengths m WHERE t.floatline_length_id = m.id;
ALTER TABLE ros_ll.floatlines DROP COLUMN floatline_length_id;

-- ros_common.lengths (usage: ros_ll.leader_set.total_branchline_minimum_length) KM/M
ALTER TABLE ros_ll.leader_set ADD column total_branchline_minimum_length_value double precision;
ALTER TABLE ros_ll.leader_set ADD column total_branchline_minimum_length_unit varchar(3) constraint ros_ll_leader_set_total_branchline_minimum_length_unit_check CHECK ( total_branchline_minimum_length_unit IN ('KM', 'M') ) ;
UPDATE ros_ll.leader_set t SET total_branchline_minimum_length_value = m.value, total_branchline_minimum_length_unit = upper(m.unit) FROM ros_common.lengths m WHERE t.total_branchline_minimum_length_id = m.id;
ALTER TABLE ros_ll.leader_set DROP COLUMN total_branchline_minimum_length_id;
ALTER TABLE ros_ll.leader_set ALTER column total_branchline_minimum_length_value SET NOT NULL;
ALTER TABLE ros_ll.leader_set ALTER column total_branchline_minimum_length_unit SET NOT NULL;

-- ros_common.lengths (usage: ros_ll.leader_set.total_branchline_maximum_length) KM/M
ALTER TABLE ros_ll.leader_set ADD column total_branchline_maximum_length_value double precision;
ALTER TABLE ros_ll.leader_set ADD column total_branchline_maximum_length_unit varchar(3) constraint ros_ll_leader_set_total_branchline_maximum_length_unit_check CHECK ( total_branchline_maximum_length_unit IN ('KM', 'M') ) ;
UPDATE ros_ll.leader_set t SET total_branchline_maximum_length_value = m.value, total_branchline_maximum_length_unit = upper(m.unit) FROM ros_common.lengths m WHERE t.total_branchline_maximum_length_id = m.id;
ALTER TABLE ros_ll.leader_set DROP COLUMN total_branchline_maximum_length_id;
ALTER TABLE ros_ll.leader_set ALTER column total_branchline_maximum_length_value SET NOT NULL;
ALTER TABLE ros_ll.leader_set ALTER column total_branchline_maximum_length_unit SET NOT NULL;

-- ros_common.lengths (usage: ros_ll.setting_operations.mainline_set_length) KM/M
ALTER TABLE ros_ll.setting_operations ADD column mainline_set_length_value double precision;
ALTER TABLE ros_ll.setting_operations ADD column mainline_set_length_unit varchar(3) constraint ros_ll_setting_operations_mainline_set_length_unit_check CHECK ( mainline_set_length_unit IN ('KM', 'M') ) ;
UPDATE ros_ll.setting_operations t SET mainline_set_length_value = m.value, mainline_set_length_unit = upper(m.unit) FROM ros_common.lengths m WHERE t.mainline_set_length_id = m.id;
ALTER TABLE ros_ll.setting_operations DROP COLUMN mainline_set_length_id;

-- ros_common.lengths (usage: ros_ll.tori_line_details.tori_line_length) KM/M
ALTER TABLE ros_ll.tori_line_details ADD column tori_line_length_value double precision;
ALTER TABLE ros_ll.tori_line_details ADD column tori_line_length_unit varchar(3) constraint ros_ll_tori_line_details_tori_line_length_unit_check CHECK ( tori_line_length_unit IN ('KM', 'M') ) ;
UPDATE ros_ll.tori_line_details t SET tori_line_length_value = m.value, tori_line_length_unit = upper(m.unit) FROM ros_common.lengths m WHERE t.tori_line_length_id = m.id;
ALTER TABLE ros_ll.tori_line_details DROP COLUMN tori_line_length_id;

-- ros_common.lengths (usage: ros_ll.tori_line_details.streamer_line_length_max) KM/M
ALTER TABLE ros_ll.tori_line_details ADD column streamer_line_length_max_value double precision;
ALTER TABLE ros_ll.tori_line_details ADD column streamer_line_length_max_unit varchar(3) constraint ros_ll_tori_line_details_streamer_line_length_max_unit_check CHECK ( streamer_line_length_max_unit IN ('KM', 'M') ) ;
UPDATE ros_ll.tori_line_details t SET streamer_line_length_max_value = m.value, streamer_line_length_max_unit = upper(m.unit) FROM ros_common.lengths m WHERE t.streamer_line_length_max_id = m.id;
ALTER TABLE ros_ll.tori_line_details DROP COLUMN streamer_line_length_max_id;

-- ros_common.lengths (usage: ros_ll.tori_line_details.streamer_line_length_min) KM/M
ALTER TABLE ros_ll.tori_line_details ADD column streamer_line_length_min_value double precision;
ALTER TABLE ros_ll.tori_line_details ADD column streamer_line_length_min_unit varchar(3) constraint ros_ll_tori_line_details_streamer_line_length_min_unit_check CHECK ( streamer_line_length_min_unit IN ('KM', 'M') ) ;
UPDATE ros_ll.tori_line_details t SET streamer_line_length_min_value = m.value, streamer_line_length_min_unit = upper(m.unit) FROM ros_common.lengths m WHERE t.streamer_line_length_min_id = m.id;
ALTER TABLE ros_ll.tori_line_details DROP COLUMN streamer_line_length_min_id;

-- ros_common.lengths (usage: ros_gn.gillnet_configuration.droplines_length) KM/M
ALTER TABLE ros_gn.gillnet_configuration ADD column droplines_length_value double precision;
ALTER TABLE ros_gn.gillnet_configuration ADD column droplines_length_unit varchar(3) constraint ros_gn_gillnet_configuration_droplines_length_unit_check CHECK ( droplines_length_unit IN ('KM', 'M') ) ;
UPDATE ros_gn.gillnet_configuration t SET droplines_length_value = m.value, droplines_length_unit = upper(m.unit) FROM ros_common.lengths m WHERE t.droplines_length_id = m.id;
ALTER TABLE ros_gn.gillnet_configuration DROP COLUMN droplines_length_id;

-- ros_common.lengths (usage: ros_gn.gillnet_configuration.net_length) KM/M
ALTER TABLE ros_gn.gillnet_configuration ADD column net_length_value double precision;
ALTER TABLE ros_gn.gillnet_configuration ADD column net_length_unit varchar(3) constraint ros_gn_gillnet_configuration_net_length_unit_check CHECK ( net_length_unit IN ('KM', 'M') ) ;
UPDATE ros_gn.gillnet_configuration t SET net_length_value = m.value, net_length_unit = upper(m.unit) FROM ros_common.lengths m WHERE t.net_length_id = m.id;
ALTER TABLE ros_gn.gillnet_configuration DROP COLUMN net_length_id;

-- ros_common.locations (usage: ros_common.trip_observer.disembarkation_location)
ALTER TABLE ros_common.trip_observer ADD column disembarkation_location_name varchar(255);
ALTER TABLE ros_common.trip_observer ADD column disembarkation_latitude double precision;
ALTER TABLE ros_common.trip_observer ADD column disembarkation_longitude double precision;
ALTER TABLE ros_common.trip_observer ADD column disembarkation_country_code char(3);
ALTER TABLE ros_common.trip_observer ADD column disembarkation_port_code varchar(16);
UPDATE ros_common.trip_observer t SET disembarkation_location_name = m.location_name, disembarkation_latitude = m.latitude, disembarkation_longitude = m.longitude, disembarkation_country_code = m.country_code, disembarkation_port_code = m.port_code  FROM ros_common.locations m WHERE t.disembarkation_location_id = m.id;
ALTER TABLE ros_common.trip_observer DROP COLUMN disembarkation_location_id;
ALTER TABLE ros_common.trip_observer add constraint fk_ros_common_trip_observer_disembarkation_country_code foreign key (disembarkation_country_code) references refs_admin.countries(code);
ALTER TABLE ros_common.trip_observer add constraint fk_ros_common_trip_observer_disembarkation_port_code foreign key (disembarkation_port_code) references refs_admin.ports (code);

-- ros_common.locations (usage: ros_common.trip_observer.embarkation_location)
ALTER TABLE ros_common.trip_observer ADD column embarkation_location_name varchar(255);
ALTER TABLE ros_common.trip_observer ADD column embarkation_latitude double precision;
ALTER TABLE ros_common.trip_observer ADD column embarkation_longitude double precision;
ALTER TABLE ros_common.trip_observer ADD column embarkation_country_code char(3);
ALTER TABLE ros_common.trip_observer ADD column embarkation_port_code varchar(16);
UPDATE ros_common.trip_observer t SET embarkation_location_name = m.location_name, embarkation_latitude = m.latitude, embarkation_longitude = m.longitude, embarkation_country_code = m.country_code, embarkation_port_code = m.port_code  FROM ros_common.locations m WHERE t.embarkation_location_id = m.id;
ALTER TABLE ros_common.trip_observer DROP COLUMN embarkation_location_id;
ALTER TABLE ros_common.trip_observer add constraint fk_ros_common_trip_observer_embarkation_country_code foreign key (embarkation_country_code) references refs_admin.countries(code);
ALTER TABLE ros_common.trip_observer add constraint fk_ros_common_trip_observer_embarkation_port_code foreign key (embarkation_port_code) references refs_admin.ports (code);

-- ros_common.locations (usage: ros_common.trip_vessel.departure_location)
ALTER TABLE ros_common.trip_vessel ADD column departure_location_name varchar(255);
ALTER TABLE ros_common.trip_vessel ADD column departure_latitude double precision;
ALTER TABLE ros_common.trip_vessel ADD column departure_longitude double precision;
ALTER TABLE ros_common.trip_vessel ADD column departure_country_code char(3);
ALTER TABLE ros_common.trip_vessel ADD column departure_port_code varchar(16);
UPDATE ros_common.trip_vessel t SET departure_location_name = m.location_name, departure_latitude = m.latitude, departure_longitude = m.longitude, departure_country_code = m.country_code, departure_port_code = m.port_code  FROM ros_common.locations m WHERE t.departure_location = m.id;
ALTER TABLE ros_common.trip_vessel DROP COLUMN departure_location;
ALTER TABLE ros_common.trip_vessel add constraint fk_ros_common_trip_vessel_departure_country_code foreign key (departure_country_code) references refs_admin.countries(code);
ALTER TABLE ros_common.trip_vessel add constraint fk_ros_common_trip_vessel_departure_port_code foreign key (departure_port_code) references refs_admin.ports (code);

-- ros_common.locations (usage: ros_common.trip_vessel.return_location)
ALTER TABLE ros_common.trip_vessel ADD column return_location_name varchar(255);
ALTER TABLE ros_common.trip_vessel ADD column return_latitude double precision;
ALTER TABLE ros_common.trip_vessel ADD column return_longitude double precision;
ALTER TABLE ros_common.trip_vessel ADD column return_country_code char(3);
ALTER TABLE ros_common.trip_vessel ADD column return_port_code varchar(16);
UPDATE ros_common.trip_vessel t SET return_location_name = m.location_name, return_latitude = m.latitude, return_longitude = m.longitude, return_country_code = m.country_code, return_port_code = m.port_code  FROM ros_common.locations m WHERE t.return_location = m.id;
ALTER TABLE ros_common.trip_vessel DROP COLUMN return_location;
ALTER TABLE ros_common.trip_vessel add constraint fk_ros_common_trip_vessel_return_country_code foreign key (return_country_code) references refs_admin.countries(code);
ALTER TABLE ros_common.trip_vessel add constraint fk_ros_common_trip_vessel_return_port_code foreign key (return_port_code) references refs_admin.ports (code);

-- ros_common.maturity_stages (usage: ros_common.biometric_information.maturity_stage)
ALTER TABLE ros_common.biometric_information ADD column maturity_stage_level integer;
ALTER TABLE ros_common.biometric_information ADD column maturity_stage_scale varchar(255);
UPDATE ros_common.biometric_information t SET maturity_stage_level = m.maturity_level, maturity_stage_scale = m.scale FROM ros_common.maturity_stages m WHERE t.maturity_stage_id = m.id;
ALTER TABLE ros_common.biometric_information DROP COLUMN maturity_stage_id;

-- ros_common.measured_lengths (usage: ros_common.biometric_information.alternative_measured_length) CM
ALTER TABLE ros_common.biometric_information ADD column alternative_measured_length_value double precision;
ALTER TABLE ros_common.biometric_information ADD column alternative_measured_length_unit varchar(3) constraint ros_c_biometric_info_alternative_measured_length_unit_check CHECK ( alternative_measured_length_unit IN ('CM') ) ;
ALTER TABLE ros_common.biometric_information ADD column alternative_measured_length_straight boolean default FALSE;
ALTER TABLE ros_common.biometric_information ADD column alternative_measured_length_type_of_measurement_code char(2);
ALTER TABLE ros_common.biometric_information ADD column alternative_measured_length_measured_length_type_code char(2);
ALTER TABLE ros_common.biometric_information ADD column alternative_measured_length_length_measuring_tool_code char(2);
UPDATE ros_common.biometric_information t SET alternative_measured_length_value = m.value, alternative_measured_length_unit = upper(m.unit), alternative_measured_length_straight = m.straight, alternative_measured_length_type_of_measurement_code = m.type_of_measurement_code, alternative_measured_length_measured_length_type_code = m.measured_length_type_code, alternative_measured_length_length_measuring_tool_code = m.length_measuring_tool_code FROM ros_common.measured_lengths m WHERE t.alternative_measured_length_id = m.id;
alter table ros_common.biometric_information add constraint fk_ros_c_biometric_i_alternative_measured_length_measuring_tool foreign key (alternative_measured_length_length_measuring_tool_code, alternative_measured_length_type_of_measurement_code) references refs_biology.measurement_tools (code, type_of_measurement_code);
alter table ros_common.biometric_information add constraint fk_ros_c_biometric_information_alternative_measured_length_type foreign key (alternative_measured_length_measured_length_type_code, alternative_measured_length_type_of_measurement_code) references refs_biology.measurements (code, type_of_measurement_code);
ALTER TABLE ros_common.biometric_information DROP COLUMN alternative_measured_length_id;

-- ros_common.measured_lengths (usage: ros_common.biometric_information.measured_length) CM
ALTER TABLE ros_common.biometric_information ADD column measured_length_value double precision;
ALTER TABLE ros_common.biometric_information ADD column measured_length_unit varchar(3) constraint ros_common_biometric_information_measured_length_unit_check CHECK ( measured_length_unit IN ('CM') ) ;
ALTER TABLE ros_common.biometric_information ADD column measured_length_straight boolean default FALSE;
ALTER TABLE ros_common.biometric_information ADD column measured_length_type_of_measurement_code char(2);
ALTER TABLE ros_common.biometric_information ADD column measured_length_measured_length_type_code char(2);
ALTER TABLE ros_common.biometric_information ADD column measured_length_length_measuring_tool_code char(2);
UPDATE ros_common.biometric_information t SET measured_length_value = m.value, measured_length_unit = upper(m.unit), measured_length_straight = m.straight, measured_length_type_of_measurement_code = m.type_of_measurement_code, measured_length_measured_length_type_code = m.measured_length_type_code, measured_length_length_measuring_tool_code = m.length_measuring_tool_code FROM ros_common.measured_lengths m WHERE t.measured_length_id = m.id;
alter table ros_common.biometric_information add constraint fk_ros_c_biometric_information_measured_length_measuring_tool foreign key (measured_length_length_measuring_tool_code, measured_length_type_of_measurement_code) references refs_biology.measurement_tools (code, type_of_measurement_code);
alter table ros_common.biometric_information add constraint fk_ros_c_biometric_information_measured_length_type foreign key (measured_length_measured_length_type_code, measured_length_type_of_measurement_code) references refs_biology.measurements (code, type_of_measurement_code);
ALTER TABLE ros_common.biometric_information DROP COLUMN measured_length_id;

-- ros_common.ranges (usage: ros_common.trip_vessel.autonomy_range) UNK
ALTER TABLE ros_common.trip_vessel ADD column autonomy_range_value double precision;
ALTER TABLE ros_common.trip_vessel ADD column autonomy_range_unit varchar(3);
UPDATE ros_common.trip_vessel t SET autonomy_range_value = m.value, autonomy_range_unit = upper(m.unit) FROM ros_common.ranges m WHERE t.autonomy_range_id = m.id;
ALTER TABLE ros_common.trip_vessel DROP COLUMN autonomy_range_id;

-- ros_common.sample_collection_details (usage: ros_common.biometric_information.sample_collection_detail)
ALTER TABLE ros_common.biometric_information ADD column sample_collection_detail_destination varchar(255);
ALTER TABLE ros_common.biometric_information ADD column sample_collection_detail_preservation_method text;
ALTER TABLE ros_common.biometric_information ADD column sample_collection_detail_sample_type varchar(255);
UPDATE ros_common.biometric_information t SET sample_collection_detail_destination = m.destination, sample_collection_detail_preservation_method = m.preservation_method, sample_collection_detail_sample_type = m.sample_type FROM ros_common.sample_collection_details m WHERE t.sample_collection_detail_id = m.id;
ALTER TABLE ros_common.biometric_information DROP COLUMN sample_collection_detail_id;

-- ros_common.sizes (usage: ros_ps.gear_specifications.bunt_stretched_mesh_size) MM
ALTER TABLE ros_ps.gear_specifications ADD column bunt_stretched_mesh_size_value double precision;
ALTER TABLE ros_ps.gear_specifications ADD column bunt_stretched_mesh_size_unit varchar(3) constraint ros_ps_gear_specifications_bunt_stretched_mesh_size_unit_check CHECK ( bunt_stretched_mesh_size_unit IN ('MM') ) ;
UPDATE ros_ps.gear_specifications t SET bunt_stretched_mesh_size_value = m.value, bunt_stretched_mesh_size_unit = upper(m.unit) FROM ros_common.sizes m WHERE t.bunt_stretched_mesh_size_id = m.id;
ALTER TABLE ros_ps.gear_specifications DROP COLUMN bunt_stretched_mesh_size_id;

-- ros_common.sizes (usage: ros_ps.gear_specifications.mid_net_stretched_mesh_size) MM
ALTER TABLE ros_ps.gear_specifications ADD column mid_net_stretched_mesh_size_value double precision;
ALTER TABLE ros_ps.gear_specifications ADD column mid_net_stretched_mesh_size_unit varchar(3) constraint ros_ps_gear_spec_mid_net_stretched_mesh_size_unit_check CHECK ( mid_net_stretched_mesh_size_unit IN ('MM') ) ;
UPDATE ros_ps.gear_specifications t SET mid_net_stretched_mesh_size_value = m.value, mid_net_stretched_mesh_size_unit = upper(m.unit) FROM ros_common.sizes m WHERE t.mid_net_stretched_mesh_size_id = m.id;
ALTER TABLE ros_ps.gear_specifications DROP COLUMN mid_net_stretched_mesh_size_id;

-- ros_common.sizes (usage: ros_gn.gillnet_configuration_stretched_mesh_sizes.stretched_mesh_size) MM
ALTER TABLE ros_gn.gillnet_configuration_stretched_mesh_sizes ADD column stretched_mesh_size_value double precision;
ALTER TABLE ros_gn.gillnet_configuration_stretched_mesh_sizes ADD column stretched_mesh_size_unit varchar(3) constraint ros_gn_g_conf_stre_mesh_sizes_stretched_mesh_size_unit_check CHECK ( stretched_mesh_size_unit IN ('MM') ) ;
UPDATE ros_gn.gillnet_configuration_stretched_mesh_sizes t SET stretched_mesh_size_value = m.value, stretched_mesh_size_unit = upper(m.unit) FROM ros_common.sizes m WHERE t.stretched_mesh_size_id = m.id;
ALTER TABLE ros_gn.gillnet_configuration_stretched_mesh_sizes DROP COLUMN stretched_mesh_size_id;
ALTER TABLE ros_gn.gillnet_configuration_stretched_mesh_sizes ALTER column stretched_mesh_size_value SET NOT NULL;
ALTER TABLE ros_gn.gillnet_configuration_stretched_mesh_sizes ALTER column stretched_mesh_size_unit SET NOT NULL;

-- ros_common.speeds (usage: ros_ll.setting_operations.vessel_speed) KN
ALTER TABLE ros_ll.setting_operations ADD column vessel_speed_value double precision;
ALTER TABLE ros_ll.setting_operations ADD column vessel_speed_unit varchar(3) constraint ros_ll_setting_operations_vessel_speed_unit_check CHECK ( vessel_speed_unit IN ('KN') ) ;
UPDATE ros_ll.setting_operations t SET vessel_speed_value = m.value, vessel_speed_unit = upper(m.unit) FROM ros_common.speeds m WHERE t.vessel_speed_id = m.id;
ALTER TABLE ros_ll.setting_operations DROP COLUMN vessel_speed_id;

-- ros_common.speeds (usage: ros_ll.setting_operations.line_setter_speed) KN
ALTER TABLE ros_ll.setting_operations ADD column line_setter_speed_value double precision;
ALTER TABLE ros_ll.setting_operations ADD column line_setter_speed_unit varchar(3) constraint ros_ll_setting_operations_line_setter_speed_unit_check CHECK ( line_setter_speed_unit IN ('KN') ) ;
UPDATE ros_ll.setting_operations t SET line_setter_speed_value = m.value, line_setter_speed_unit = upper(m.unit) FROM ros_common.speeds m WHERE t.line_setter_speed_id = m.id;
ALTER TABLE ros_ll.setting_operations DROP COLUMN line_setter_speed_id;

-- ros_common.thicknesses (usage: ros_ll.additional_catch_details_on_ssi.leader_thickness)
ALTER TABLE ros_ll.additional_catch_details_on_ssi ADD column leader_thickness_value double precision;
ALTER TABLE ros_ll.additional_catch_details_on_ssi ADD column leader_thickness_unit varchar(3);
UPDATE ros_ll.additional_catch_details_on_ssi t SET leader_thickness_value = m.value, leader_thickness_unit = upper(m.unit) FROM ros_common.thicknesses m WHERE t.leader_thickness_id = m.id;
ALTER TABLE ros_ll.additional_catch_details_on_ssi DROP COLUMN leader_thickness_id;

-- ros_common.tonnages (usage: ros_common.trip_vessel.tonnage) GRT/GT
ALTER TABLE ros_common.trip_vessel ADD column tonnage_value double precision;
ALTER TABLE ros_common.trip_vessel ADD column tonnage_unit varchar(3) constraint ros_common_trip_vessel_tonnage_unit_check CHECK ( tonnage_unit IN ('GRT', 'GT') ) ;
UPDATE ros_common.trip_vessel t SET tonnage_value = m.value, tonnage_unit = upper(m.unit) FROM ros_common.tonnages m WHERE t.tonnage_id = m.id;
ALTER TABLE ros_common.trip_vessel DROP COLUMN tonnage_id;

-- ros_common.weights (usage: ros_ll.mitigation_measures.average_sinker_weight)
ALTER TABLE ros_ll.mitigation_measures ADD column average_sinker_weight_value double precision;
ALTER TABLE ros_ll.mitigation_measures ADD column average_sinker_weight_unit varchar(3);
UPDATE ros_ll.mitigation_measures t SET average_sinker_weight_value = m.value, average_sinker_weight_unit = upper(m.unit) FROM ros_common.weights m WHERE t.average_sinker_weight_id = m.id;
ALTER TABLE ros_ll.mitigation_measures DROP COLUMN average_sinker_weight_id;

-- ros_common.weights (usage: ros_gn.sinkers_by_type.average_sinker_weight)
ALTER TABLE ros_gn.sinkers_by_type ADD column average_sinker_weight_value double precision;
ALTER TABLE ros_gn.sinkers_by_type ADD column average_sinker_weight_unit varchar(3);
UPDATE ros_gn.sinkers_by_type t SET average_sinker_weight_value = m.value, average_sinker_weight_unit = upper(m.unit) FROM ros_common.weights m WHERE t.average_sinker_weight_id = m.id;
ALTER TABLE ros_gn.sinkers_by_type DROP COLUMN average_sinker_weight_id;
