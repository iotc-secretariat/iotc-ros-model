-- Can not set not null constraint on column refs_admin.cpc_history.withdrawal_date (There is 31 row(s) with NULL value).
-- Can not set not null constraint on column refs_admin.entities.code_iso2 (There is 4 row(s) with NULL value).
-- Can not set not null constraint on column refs_admin.entities.code_iso3 (There is 3 row(s) with NULL value).
-- Can not set not null constraint on column refs_admin.fleet_to_flags_and_fisheries.iotc_main_area_code (There is 104 row(s) with NULL value).
-- Can not set not null constraint on column refs_admin.fleet_to_flags_and_fisheries.fishery_type_code (There is 90 row(s) with NULL value).
-- Can not set not null constraint on column refs_admin.fleet_to_flags_and_fisheries.gear_category_code (There is 253 row(s) with NULL value).
-- Can not set not null constraint on column refs_admin.fleet_to_flags_and_fisheries.gear_code (There is 90 row(s) with NULL value).
-- Can not set not null constraint on column refs_admin.fleet_to_flags_and_fisheries.gear_configuration_code (There is 133 row(s) with NULL value).
-- Can not set not null constraint on column refs_admin.fleet_to_flags_and_fisheries.fishing_mode_code (There is 253 row(s) with NULL value).
-- Can not set not null constraint on column refs_admin.fleet_to_flags_and_fisheries.target_species_code (There is 240 row(s) with NULL value).
-- Can not set not null constraint on column refs_admin.fleet_to_flags_and_fisheries.from_year (There is 251 row(s) with NULL value).
-- Can not set not null constraint on column refs_admin.fleet_to_flags_and_fisheries.to_year (There is 251 row(s) with NULL value).
ALTER TABLE refs_admin.fleets ALTER COLUMN name_fr SET NOT NULL;
-- Can not set not null constraint on column refs_admin.fleets.cpc_code (There is 45 row(s) with NULL value).
-- Can not set not null constraint on column refs_admin.ports.name_fr (There is 10320 row(s) with NULL value).
-- Can not set not null constraint on column refs_admin.ports.lat (There is 4415 row(s) with NULL value).
-- Can not set not null constraint on column refs_admin.ports.lon (There is 4415 row(s) with NULL value).
-- Can not set not null constraint on column refs_admin.ports.point (There is 4415 row(s) with NULL value).
ALTER TABLE refs_biology.biological_materials ALTER COLUMN name_en SET NOT NULL;
ALTER TABLE refs_biology.biological_materials ALTER COLUMN name_fr SET NOT NULL;
ALTER TABLE refs_biology.fish_status ALTER COLUMN name_en SET NOT NULL;
ALTER TABLE refs_biology.fish_status ALTER COLUMN name_fr SET NOT NULL;
ALTER TABLE refs_biology.fish_status ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_biology.fish_status ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_biology.incidental_captures_conditions ALTER COLUMN name_en SET NOT NULL;
ALTER TABLE refs_biology.incidental_captures_conditions ALTER COLUMN name_fr SET NOT NULL;
ALTER TABLE refs_biology.maturity_stages ALTER COLUMN name_en SET NOT NULL;
ALTER TABLE refs_biology.maturity_stages ALTER COLUMN name_fr SET NOT NULL;
ALTER TABLE refs_biology.maturity_stages ALTER COLUMN description_male_en SET NOT NULL;
ALTER TABLE refs_biology.maturity_stages ALTER COLUMN description_male_fr SET NOT NULL;
ALTER TABLE refs_biology.maturity_stages ALTER COLUMN description_female_en SET NOT NULL;
ALTER TABLE refs_biology.maturity_stages ALTER COLUMN description_female_fr SET NOT NULL;
ALTER TABLE refs_biology.measurements ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_biology.measurements ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_biology.sample_preservation_methods ALTER COLUMN name_en SET NOT NULL;
ALTER TABLE refs_biology.sample_preservation_methods ALTER COLUMN name_fr SET NOT NULL;
ALTER TABLE refs_biology.sample_preservation_methods ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_biology.sample_preservation_methods ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_biology.sampling_methods_for_catch_estimation ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_biology.sampling_methods_for_catch_estimation ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_biology.sampling_methods_for_sampling_collections ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_biology.sampling_methods_for_sampling_collections ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_biology.sampling_protocols ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_biology.sampling_protocols ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_biology.scars ALTER COLUMN name_en SET NOT NULL;
ALTER TABLE refs_biology.scars ALTER COLUMN name_fr SET NOT NULL;
-- Can not set not null constraint on column refs_biology.species.name_en (There is 4 row(s) with NULL value).
-- Can not set not null constraint on column refs_biology.species.name_fr (There is 39 row(s) with NULL value).
-- Can not set not null constraint on column refs_biology.species.name_scientific (There is 9 row(s) with NULL value).
-- Can not set not null constraint on column refs_biology.species.species_family (There is 30 row(s) with NULL value).
-- Can not set not null constraint on column refs_biology.species.species_order (There is 18 row(s) with NULL value).
-- Can not set not null constraint on column refs_biology.species.is_target (There is 11 row(s) with NULL value).
-- Can not set not null constraint on column refs_biology.species.is_predator (There is 11 row(s) with NULL value).
-- Can not set not null constraint on column refs_biology.species.is_asfis (There is 7 row(s) with NULL value).
ALTER TABLE refs_data.coverage_types ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_data.coverage_types ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_data.logical_responses ALTER COLUMN name_en SET NOT NULL;
ALTER TABLE refs_data.logical_responses ALTER COLUMN name_fr SET NOT NULL;
ALTER TABLE refs_data.logical_responses ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_data.logical_responses ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_fishery.bait_fishing_methods ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_fishery.bait_fishing_methods ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_fishery.branchline_storages ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_fishery.branchline_storages ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_fishery.buoy_models ALTER COLUMN name_en SET NOT NULL;
ALTER TABLE refs_fishery.buoy_models ALTER COLUMN is_echo_sounder SET NOT NULL;
ALTER TABLE refs_fishery.buoy_models ALTER COLUMN brand SET NOT NULL;
-- Can not set not null constraint on column refs_fishery.buoy_models.start_year (There is 13 row(s) with NULL value).
-- Can not set not null constraint on column refs_fishery.buoy_models.comment (There is 12 row(s) with NULL value).
ALTER TABLE refs_fishery.buoy_models ALTER COLUMN active SET NOT NULL;
ALTER TABLE refs_fishery.dehooker_types ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_fishery.dehooker_types ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_fishery.dfad_biodegradability_categories ALTER COLUMN name_en SET NOT NULL;
ALTER TABLE refs_fishery.dfad_biodegradability_categories ALTER COLUMN name_fr SET NOT NULL;
ALTER TABLE refs_fishery.dfad_biodegradability_categories ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_fishery.dfad_biodegradability_categories ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_fishery.dfad_biodegradability_categories ALTER COLUMN state SET NOT NULL;
ALTER TABLE refs_fishery.fish_preservation_methods ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_fishery.fish_preservation_methods ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_fishery.fish_storage_types ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_fishery.fish_storage_types ALTER COLUMN description_fr SET NOT NULL;
-- Can not set not null constraint on column refs_fishery.fisheries.gear_configuration_code (There is 1151 row(s) with NULL value).
-- Can not set not null constraint on column refs_fishery.fisheries.fishing_mode_code (There is 1005 row(s) with NULL value).
-- Can not set not null constraint on column refs_fishery.fisheries.target_species_code (There is 266 row(s) with NULL value).
-- Can not set not null constraint on column refs_fishery.fisheries.iotdb_gear_code (There is 140 row(s) with NULL value).
-- Can not set not null constraint on column refs_fishery.fisheries.iotc_fishery_code (There is 307 row(s) with NULL value).
ALTER TABLE refs_fishery.float_types ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_fishery.float_types ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_fishery.hook_and_terminal_devices ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_fishery.hook_and_terminal_devices ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_fishery.hull_material_types ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_fishery.hull_material_types ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_fishery.light_colours ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_fishery.light_colours ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_fishery.light_types ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_fishery.light_types ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_fishery.line_material_types ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_fishery.line_material_types ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_fishery.mechanisation_types ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_fishery.mechanisation_types ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_fishery.mitigation_devices ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_fishery.mitigation_devices ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_fishery.net_colours ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_fishery.net_colours ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_fishery.net_configurations ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_fishery.net_configurations ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_fishery.net_deploy_depths ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_fishery.net_deploy_depths ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_fishery.net_material_types ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_fishery.net_material_types ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_fishery.net_setting_strategies ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_fishery.net_setting_strategies ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_fishery.offal_management_types ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_fishery.offal_management_types ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_fishery.pole_material_types ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_fishery.pole_material_types ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_fishery.school_sighting_cues ALTER COLUMN school_type_category_code SET NOT NULL;
ALTER TABLE refs_fishery.school_type_categories ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_fishery.school_type_categories ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_fishery.sinker_material_types ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_fishery.sinker_material_types ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_fishery.streamer_types ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_fishery.streamer_types ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_fishery.surface_fishery_activities ALTER COLUMN name_en SET NOT NULL;
ALTER TABLE refs_fishery.surface_fishery_activities ALTER COLUMN name_fr SET NOT NULL;
ALTER TABLE refs_fishery.vessel_measurement_types ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_fishery.vessel_measurement_types ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_fishery_config.areas_of_operation ALTER COLUMN name_fr SET NOT NULL;
ALTER TABLE refs_fishery_config.areas_of_operation ALTER COLUMN description_fr SET NOT NULL;
-- Can not set not null constraint on column refs_fishery_config.fishery_categories.minimum_grid_size (There is 1 row(s) with NULL value).
ALTER TABLE refs_fishery_config.fishery_purposes ALTER COLUMN name_en SET NOT NULL;
ALTER TABLE refs_fishery_config.fishery_purposes ALTER COLUMN name_fr SET NOT NULL;
ALTER TABLE refs_fishery_config.fishery_purposes ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_fishery_config.fishery_purposes ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_fishery_config.loa_classes ALTER COLUMN name_en SET NOT NULL;
ALTER TABLE refs_fishery_config.loa_classes ALTER COLUMN name_fr SET NOT NULL;
ALTER TABLE refs_fishery_config.loa_classes ALTER COLUMN description_en SET NOT NULL;
ALTER TABLE refs_fishery_config.loa_classes ALTER COLUMN description_fr SET NOT NULL;
ALTER TABLE refs_gis.area_intersections ALTER COLUMN intersection_area SET NOT NULL;
ALTER TABLE refs_gis.area_intersections_iotc ALTER COLUMN intersection_area SET NOT NULL;
-- Can not set not null constraint on column refs_gis.area_types.fishing_ground_prefix (There is 1 row(s) with NULL value).
-- Can not set not null constraint on column refs_gis.areas.area_geometry_old (There is 73 row(s) with NULL value).
ALTER TABLE refs_mappings.irregular_areas ALTER COLUMN legacy_code SET NOT NULL;
ALTER TABLE refs_mappings.irregular_areas ALTER COLUMN code SET NOT NULL;
ALTER TABLE refs_meta.codelists_versions ALTER COLUMN last_update SET NOT NULL;
-- Can not set not null constraint on column refs_meta.codelists_versions.url (There is 161 row(s) with NULL value).
ALTER TABLE refs_meta.codelists_versions ALTER COLUMN current_doi SET NOT NULL;
ALTER TABLE refs_socio_economics.currencies ALTER COLUMN name_en SET NOT NULL;
ALTER TABLE refs_socio_economics.currencies ALTER COLUMN name_fr SET NOT NULL;
ALTER TABLE refs_socio_economics.mapping_country_currency ALTER COLUMN country_code SET NOT NULL;
ALTER TABLE refs_socio_economics.mapping_country_currency ALTER COLUMN currency_code SET NOT NULL;
