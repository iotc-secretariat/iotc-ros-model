-- SQL statements extracted from the modified end of ChangeLog.md.

-- Review some foreign keys name
alter table refs_fishery.gear_types_deprecated rename constraint pk_gear_types to pk_gear_types_deprecated;
alter table refs_fishery.hook_and_terminal_devices rename constraint pk_hook_types to pk_hook_and_terminal_devices;
ALTER TABLE refs_fishery.mechanisation_types rename CONSTRAINT pk_mechanization_types to pk_mechanisation_types;
alter table refs_fishery.net_material_types rename constraint pk_gillnet_material_types to pk_net_material_types;
ALTER TABLE refs_fishery.vessel_measurement_types rename CONSTRAINT pk_vessel_size_types to pk_vessel_measurement_types;

alter table refs_fishery_config.fishery_types drop constraint fk_fishery_types_purposes;
ALTER TABLE refs_fishery_config.fishery_purposes rename CONSTRAINT pk_purposes to pk_fishery_purposes;
alter table refs_fishery_config.fishery_types add constraint fk_fishery_types_purposes foreign key (purpose_code) references refs_fishery_config.fishery_purposes on update cascade on delete cascade;

-- Add missing foreign keys
alter table refs_biology.recommended_measurements add constraint fk_biology_recommended_measurements_type_of_measurement_code foreign key (type_of_measurement_code) references refs_biology.types_of_measurement( code);

-- Add missing primary key on refs_admin.fleet_to_flags_and_fisheries
ALTER TABLE refs_admin.fleet_to_flags_and_fisheries ADD COLUMN id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY;
ALTER TABLE refs_admin.fleet_to_flags_and_fisheries
ADD CONSTRAINT uk_refs_admin_fleet_to_flags_and_fisheries
UNIQUE NULLS NOT DISTINCT (
  fleet_code,
  reporting_entity_code,
  flag_code,
  iotc_main_area_code,
  fishery_type_code,
  gear_category_code,
  gear_code,
  gear_configuration_code,
  fishing_mode_code,
  target_species_code,
  from_year,
  to_year
);

-- Review refs_admin.ports primary key
ALTER table refs_admin.ports DROP CONSTRAINT pk_cl_ports;
ALTER TABLE refs_admin.ports ADD CONSTRAINT pk_refs_admin_ports PRIMARY KEY (code);
ALTER TABLE refs_admin.ports DROP COLUMN id;
