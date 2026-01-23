create table if not exists ros_common.trip
(
    id               integer generated always as identity (SEQUENCE NAME ros_common.trip_id_seq
        START WITH 1
        INCREMENT BY 1
        NO MINVALUE
        NO MAXVALUE
        CACHE 1),
    trip_original_id varchar(255) not null,
   constraint pk_ros_common_trip primary key (id)
);

create index if not exists idx_ros_common_trip_id on ros_common.trip (id);

insert into ros_common.trip (id, trip_original_id) OVERRIDING SYSTEM VALUE
SELECT id, trip_original_id
FROM ros_common.general_vessel_and_trip_information
order by id;

create table if not exists ros_common.trip_observer
(
    trip_id                    integer not null,
    observer_id                integer not null references ros_common.observer,
    date_time_disembarkation   timestamp(6),
    date_time_embarkation      timestamp(6),
    disembarkation_location_id integer,
    embarkation_location_id    integer,
    constraint pk_ros_common_trip_observer primary key (trip_id),
    constraint fk_trip_observer_trip_id foreign key (trip_id) references ros_common.trip(id),
    constraint fk_trip_observer_observer_id foreign key (observer_id) references ros_common.observer(contact_id),
    constraint fk_trip_observer_disembarkation_location_id foreign key (disembarkation_location_id) references ros_common.locations(id),
    constraint fk_trip_observer_embarkation_location_id foreign key (embarkation_location_id) references ros_common.locations(id)
);

create index if not exists index_trip_observer_observer_id on ros_common.trip_observer (observer_id);
create index if not exists index_trip_observer_disembarkation_location_id on ros_common.trip_observer (disembarkation_location_id);
create index if not exists index_trip_observer_trip_embarkation_location_id on ros_common.trip_observer (embarkation_location_id);
insert into ros_common.trip_observer (trip_id,
                                      observer_id,
                                      date_time_disembarkation,
                                      date_time_embarkation,
                                      disembarkation_location_id,
                                      embarkation_location_id)
SELECT a.id,
       a.observer_identification_id,
       b.date_time_embarkation,
       b.date_time_disembarkation,
       b.embarkation_location_id,
       b.disembarkation_location_id
FROM ros_common.general_vessel_and_trip_information a
         INNER JOIN ros_common.observer_trip_details b on b.id = a.observer_trip_detail_id
order by a.id;

create table if not exists ros_common.trip_vessel
(
    trip_id                                                  integer not null,
    vessel_id                                                integer not null references ros_common.vessel,
    number_of_active_fishing_days                            integer,
    number_of_conducted_fishing_events_with_observer_onboard integer,
    number_of_days_in_fishing_area                           integer,
    number_of_days_lost                                      integer,
    number_of_days_searching                                 integer,
    number_of_days_transiting                                integer,
    number_of_observed_fishing_events                        integer,
    loa_id                                                   integer,
    autonomy_range_id                                        integer,
    fish_storage_capacity_id                                 integer,
    tonnage_id                                               integer,
    hull_material_code                                       char(2),
    ais                                                      boolean default false,
    gps                                                      boolean default false,
    vms                                                      boolean default false,
    depth_sounder                                            boolean default false,
    doppler_current_meter                                    boolean default false,
    expendable_bathythermographs                             boolean default false,
    fisheries_information_services                           boolean default false,
    hf_radios                                                boolean default false,
    radars                                                   boolean default false,
    satellite_communication_systems                          boolean default false,
    sonar                                                    boolean default false,
    track_plotter                                            boolean default false,
    vhf_radios                                               boolean default false,
    number_of_crew                                           integer,
    fishing_master_id                                        integer,
    skipper_id                                               integer,
    date_time_vessel_returned_to_port                        timestamp(6),
    date_time_vessel_sailed                                  timestamp(6),
    departure_port_code                                      varchar(16),
    return_port_code                                         varchar(16),
    constraint pk_ros_common_trip_vessel primary key (trip_id),
    constraint fk_trip_vessel_trip_id foreign key (trip_id) references ros_common.trip(id),
    constraint fk_trip_vessel_vessel_id foreign key (vessel_id) references ros_common.vessel(id),
    constraint fk_trip_vessel_loa_id foreign key (loa_id) references ros_common.lengths(id),
    constraint fk_trip_vessel_autonomy_range_id foreign key (autonomy_range_id) references ros_common.ranges(id),
    constraint fk_trip_vessel_fish_storage_capacity_id foreign key (fish_storage_capacity_id) references ros_common.capacities(id),
    constraint fk_trip_vessel_tonnage_id foreign key (tonnage_id) references ros_common.tonnages(id),
    constraint fk_trip_vessel_hull_material_code foreign key (hull_material_code) references refs_fishery.hull_material_types(code),
    constraint fk_trip_vessel_fishing_master_id foreign key (fishing_master_id) references ros_common.contact(id),
    constraint fk_trip_vessel_skipper_id foreign key (skipper_id) references ros_common.contact(id),
    constraint fk_trip_vessel_departure_port_code foreign key (departure_port_code) references refs_admin.ports(code),
    constraint fk_trip_vessel_return_port_code foreign key (return_port_code) references refs_admin.ports(code)
);

create index if not exists index_trip_vessel_vessel_id on ros_common.trip_vessel (vessel_id);
create index if not exists index_trip_vessel_loa_id on ros_common.trip_vessel (loa_id);
create index if not exists index_trip_vessel_autonomy_range_id on ros_common.trip_vessel (autonomy_range_id);
create index if not exists index_trip_vessel_fish_storage_capacity_id on ros_common.trip_vessel (fish_storage_capacity_id);
create index if not exists index_trip_vessel_tonnage_id on ros_common.trip_vessel (tonnage_id);
create index if not exists index_trip_vessel_hull_material_code on ros_common.trip_vessel (hull_material_code);
create index if not exists index_trip_vessel_fishing_master_id on ros_common.trip_vessel (fishing_master_id);
create index if not exists index_trip_vessel_skipper_id on ros_common.trip_vessel (skipper_id);
create index if not exists index_trip_vessel_departure_port_code on ros_common.trip_vessel (departure_port_code);
create index if not exists index_trip_vessel_return_port_code on ros_common.trip_vessel (return_port_code);

insert into ros_common.trip_vessel (trip_id,
                                    vessel_id,
                                    number_of_active_fishing_days,
                                    number_of_conducted_fishing_events_with_observer_onboard,
                                    number_of_days_in_fishing_area,
                                    number_of_days_lost,
                                    number_of_days_searching,
                                    number_of_days_transiting,
                                    number_of_observed_fishing_events,
                                    loa_id,
                                    autonomy_range_id,
                                    fish_storage_capacity_id,
                                    tonnage_id, hull_material_code,
                                    ais,
                                    gps,
                                    vms,
                                    depth_sounder,
                                    doppler_current_meter,
                                    expendable_bathythermographs,
                                    fisheries_information_services,
                                    hf_radios,
                                    radars,
                                    satellite_communication_systems,
                                    sonar,
                                    track_plotter,
                                    vhf_radios,
                                    number_of_crew,
                                    fishing_master_id,
                                    skipper_id,
                                    date_time_vessel_returned_to_port,
                                    date_time_vessel_sailed,
                                    departure_port_code,
                                    return_port_code)
SELECT a.id,
       a.vessel_identification_id,
       b.number_of_active_fishing_days,
       b.number_of_conducted_fishing_events_with_observer_onboard,
       b.number_of_days_in_fishing_area,
       b.number_of_days_lost,
       b.number_of_days_searching,
       b.number_of_days_transiting,
       b.number_of_observed_fishing_events,
       c.loa_id,
       c.autonomy_range_id,
       c.fish_storage_capacity_id,
       c.tonnage_id,
       c.hull_material_code,
       d.ais,
       d.gps,
       d.vms,
       d.depth_sounder,
       d.doppler_current_meter,
       d.expendable_bathythermographs,
       d.fisheries_information_services,
       d.hf_radios,
       d.radars,
       d.satellite_communication_systems,
       d.sonar,
       d.track_plotter,
       d.vhf_radios,
       e.number_of_crew,
       e.fishing_master_id,
       e.skipper_id,
       f.date_time_vessel_returned_to_port,
       f.date_time_vessel_sailed,
       f.departure_port_code,
       f.return_port_code
FROM ros_common.general_vessel_and_trip_information a
         LEFT JOIN ros_common.observed_trip_summary b on b.id = a.observed_trip_summary_id
         LEFT JOIN ros_common.vessel_attributes c on c.id = a.vessel_attributes_id
         LEFT JOIN ros_common.vessel_electronics d on d.id = a.vessel_electronics_id
         LEFT JOIN ros_common.vessel_owner_and_personnel e on e.id = a.vessel_owner_and_personnel_id
         LEFT JOIN ros_common.vessel_trip_details f on f.id = a.vessel_trip_details_id
order by a.id;

drop table if exists ros_common.trip_vessel_fish_preservation_method;
create table if not exists ros_common.trip_vessel_fish_preservation_method
(
    trip_id                       integer not null,
    fish_preservation_method_code char(2) not null,
    constraint pk_ros_common_trip_vessel_fish_preservation_method primary key (trip_id, fish_preservation_method_code),
    constraint fk_ros_common_trip_vessel_fish_preservation_method_method_code foreign key (fish_preservation_method_code) references refs_fishery.fish_preservation_methods (code),
    constraint fk_ros_common_trip_vessel_fish_preservation_method_trip_id foreign key (trip_id) references ros_common.trip (id),
    constraint uk_trip_vessel_fish_preservation_method unique (trip_id, fish_preservation_method_code)
);

create index if not exists index_trip_vessel_fish_preservation_method on ros_common.trip_vessel_fish_preservation_method (trip_id, fish_preservation_method_code);

insert into ros_common.trip_vessel_fish_preservation_method (trip_id, fish_preservation_method_code)
SELECT a.id,
       b.fish_preservation_method_code
FROM ros_common.general_vessel_and_trip_information a
         INNER JOIN ros_common.vessel_attributes_fish_preservation_method b on b.vessel_attributes_id_fpm = a.vessel_attributes_id
order by a.id;

drop table if exists ros_common.trip_vessel_fish_storage_type;
create table if not exists ros_common.trip_vessel_fish_storage_type
(
    trip_id                       integer not null,
    fish_storage_type_code char(2) not null,
    constraint pk_ros_common_trip_vessel_fish_storage_type primary key (trip_id, fish_storage_type_code),
    constraint fk_ros_common_trip_vessel_fish_storage_type_code foreign key (fish_storage_type_code) references refs_fishery.fish_storage_types(code),
    constraint fk_ros_common_trip_vessel_fish_storage_type_trip_id foreign key (trip_id) references ros_common.trip (id),
    constraint uk_trip_vessel_fish_storage_type unique (trip_id, fish_storage_type_code)
);

create index if not exists index_trip_vessel_fish_storage_type on ros_common.trip_vessel_fish_storage_type (trip_id, fish_storage_type_code);

insert into ros_common.trip_vessel_fish_storage_type (trip_id, fish_storage_type_code)
SELECT a.id,
       b.fish_storage_type_code
FROM ros_common.general_vessel_and_trip_information a
         INNER JOIN ros_common.vessel_attributes_fish_storage_type b on b.vessel_attributes_id_fst = a.vessel_attributes_id
order by a.id;

drop table if exists ros_common.trip_vessel_main_engines;
create table if not exists ros_common.trip_vessel_main_engines
(
    trip_id                       integer not null,
    main_engines_id integer not null,
    constraint pk_ros_common_trip_vessel_main_engines primary key (trip_id, main_engines_id),
    constraint fk_ros_common_trip_vessel_main_engines_code foreign key (main_engines_id) references ros_common.engines(id),
    constraint fk_ros_common_trip_vessel_main_engines_trip_id foreign key (trip_id) references ros_common.trip (id),
    constraint uk_trip_vessel_main_engines unique (trip_id, main_engines_id)
);

create index if not exists index_trip_vessel_main_engines on ros_common.trip_vessel_main_engines (trip_id, main_engines_id);

insert into ros_common.trip_vessel_main_engines (trip_id, main_engines_id)
SELECT a.id,
       b.main_engine_id
FROM ros_common.general_vessel_and_trip_information a
         INNER JOIN ros_common.vessel_attributes_main_engines b on b.vessel_attributes_id_me = a.vessel_attributes_id
order by a.id;

alter table ros_ll.observer_data ADD COLUMN trip_id integer constraint fk_ros_ll_observer_data_trip_id references ros_common.trip(id);
update ros_ll.observer_data set trip_id = vessel_and_trip_information_id;
alter table ros_ll.observer_data ALTER COLUMN trip_id SET NOT NULL;

alter table ros_ps.observer_data ADD COLUMN trip_id integer constraint fk_ros_ps_observer_data_trip_id references ros_common.trip(id);
update ros_ps.observer_data set trip_id = vessel_and_trip_information_id;
alter table ros_ps.observer_data ALTER COLUMN trip_id SET NOT NULL;

alter table ros_pl.observer_data ADD COLUMN trip_id integer constraint fk_ros_gl_observer_data_trip_id references ros_common.trip(id);
update ros_pl.observer_data set trip_id = vessel_and_trip_information_id;
alter table ros_pl.observer_data ALTER COLUMN trip_id SET NOT NULL;

alter table ros_gn.observer_data ADD COLUMN trip_id integer constraint fk_ros_gn_observer_data_trip_id references ros_common.trip(id);
update ros_gn.observer_data set trip_id = vessel_and_trip_information_id;
alter table ros_gn.observer_data ALTER COLUMN trip_id SET NOT NULL;

alter table ros_common.reasons_for_days_lost ADD COLUMN trip_id integer constraint fk_ros_common_reasons_for_days_lost_trip_id references ros_common.trip(id);
update ros_common.reasons_for_days_lost set trip_id = observed_trip_summary_id;
alter table ros_common.reasons_for_days_lost ALTER COLUMN trip_id SET NOT NULL;

