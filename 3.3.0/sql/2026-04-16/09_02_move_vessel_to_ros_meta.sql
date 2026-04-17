create table if not exists ros_meta.vessel
(
    id                      integer not null generated always as identity (SEQUENCE NAME ros_meta.vessel_seq
        START WITH 1
        INCREMENT BY 1
        NO MINVALUE
        NO MAXVALUE
        CACHE 1),
    imo_identifier          varchar(255),
    iotc_vessel_identifier  varchar(255) not null,
    ircs_identifier         varchar(255),
    vessel_name             varchar(255) not null,
    registration_identifier varchar(255),
    main_fishing_gear_code  varchar(16)  not null,
    flag_code               char(3),
    port_code               varchar(16)
);

alter table ros_meta.vessel
    add constraint pk_ros_meta_vessel_pkey
        primary key (id);

alter table ros_meta.vessel
    add constraint uk_ros_meta_vessel_imo_identifier
        unique (imo_identifier);

alter table ros_meta.vessel
    add constraint uk_ros_meta_vessel_iotc_observer_identifier
        unique (iotc_vessel_identifier);

alter table ros_meta.vessel
    add constraint uk_ros_meta_vessel_ircs_identifier
        unique (ircs_identifier);

alter table ros_meta.vessel
    add constraint uk_ros_meta_vessel_registration_identifier
        unique (registration_identifier);

alter table ros_meta.vessel
    add constraint vessel_vessel_name_key
        unique (vessel_name);

alter table ros_meta.vessel
    add constraint fk_ros_meta_flag_code_vessel
        foreign key (flag_code) references refs_admin.countries;

alter table ros_meta.vessel
    add constraint fk_ros_meta_main_fishing_gear_code_vessel
        foreign key (main_fishing_gear_code) references refs_fishery_config.gears;

alter table ros_meta.vessel
    add constraint fk_ros_meta_port_code_vessel
        foreign key (port_code) references refs_admin.ports (code);

create table if not exists ros_meta.vessel_licensed_target_species
(
    vessel_id                    integer not null,
    licensed_target_species_code varchar(16)
);

alter table ros_meta.vessel_licensed_target_species
    add constraint fk_ros_meta_vessel_licensed_target_species_species_code
        foreign key (licensed_target_species_code) references refs_biology.species;

alter table ros_meta.vessel_licensed_target_species
    add constraint fk_ros_meta_vessel_licensed_target_species_vessel_id
        foreign key (vessel_id) references ros_meta.vessel;

INSERT INTO ros_meta.vessel(id, imo_identifier, iotc_vessel_identifier, ircs_identifier, vessel_name, registration_identifier, main_fishing_gear_code, flag_code, port_code) OVERRIDING SYSTEM VALUE
SELECT id,
       imo_identifier,
       iotc_vessel_identifier,
       ircs_identifier,
       vessel_name,
       registration_identifier,
       main_fishing_gear_code,
       flag_code,
       port_code
FROM ros_common.vessel;

INSERT INTO ros_meta.vessel_licensed_target_species(vessel_id, licensed_target_species_code)
SELECT vessel_id, licensed_target_species_code
FROM ros_common.vessel_licensed_target_species;

ALTER TABLE ros_common.trip_vessel ADD COLUMN vessel_id_2 INTEGER;

alter table ros_common.trip_vessel
    add constraint fk_ros_common_trip_vessel_vessel_id
        foreign key (vessel_id_2) references ros_meta.vessel;

-- noinspection SqlWithoutWhere
UPDATE ros_common.trip_vessel set vessel_id_2 = vessel_id;

ALTER TABLE ros_common.trip_vessel DROP COLUMN vessel_id;
ALTER TABLE ros_common.trip_vessel RENAME vessel_id_2 TO vessel_id;


create index if not exists index_trip_vessel_vessel_id on ros_common.trip_vessel (vessel_id);
