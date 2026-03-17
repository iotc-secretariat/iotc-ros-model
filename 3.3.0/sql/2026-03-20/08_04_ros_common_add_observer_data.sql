drop table if exists ros_common.observer_data cascade;
create table if not exists ros_common.observer_data
(
    id                     integer generated always as identity,
    original_id            integer               not null,
    vessel_type_code       char(3)               not null,
    reporting_country_code char(3)               not null,
    complete               boolean default false not null,
    creation_time        timestamp(6)          not null,
    originator             varchar(255)          not null,
    originator_version     varchar(255)          not null,
    ros_codelists_version  varchar(255)          not null,
    ros_model_version      varchar(255)          not null,
    source                 varchar(255)          not null,
    status                 varchar(255)          not null,
    submitter_id           integer               not null,
    submission_time        timestamp(6),
    finalization_time      timestamp(6),
    constraint ros_common_observer_data_pkey
        primary key (id),
    constraint fk_ros_common_observer_data_reporting_country_code
        foreign key (reporting_country_code) references refs_admin.countries,
    constraint fk_ros_common_observer_data_vessel_type_code
        foreign key (vessel_type_code) references refs_fishery.vessel_types,
    constraint fk_ros_common_observer_data_submitter_id
        foreign key (submitter_id) references ros_common.contact
);

create index if not exists index_common_observer_data_reporting_country_code
    on ros_common.observer_data (reporting_country_code);

create index if not exists index_common_observer_data_vessel_type_code
    on ros_common.observer_data (vessel_type_code);

create index if not exists index_ll_observer_data_submitter_id
    on ros_common.observer_data (submitter_id);

INSERT INTO ros_common.observer_data(original_id,
                                     complete,
                                     creation_time,
                                     submission_time,
                                     originator,
                                     originator_version,
                                     ros_codelists_version,
                                     ros_model_version,
                                     source,
                                     status,
                                     submitter_id,
                                     reporting_country_code,
                                     vessel_type_code,
                                     finalization_time)
SELECT id,
       complete,
       creation_time,
       submission_time,
       originator,
       originator_version,
       ros_codelists_version,
       ros_model_version,
       source,
       status,
       submitter_id,
       reporting_country_code,
       'LL',
       finalization_time
from ros_ll.observer_data;

INSERT INTO ros_common.observer_data(original_id,
                                     complete,
                                     creation_time,
                                     submission_time,
                                     originator,
                                     originator_version,
                                     ros_codelists_version,
                                     ros_model_version,
                                     source,
                                     status,
                                     submitter_id,
                                     reporting_country_code,
                                     vessel_type_code,
                                     finalization_time)
SELECT id,
       complete,
       creation_time,
       submission_time,
       originator,
       originator_version,
       ros_codelists_version,
       ros_model_version,
       source,
       status,
       creator_id,
       reporting_country_code,
       'SP',
       finalization_time
from ros_ps.observer_data;

INSERT INTO ros_common.observer_data(original_id,
                                     complete,
                                     creation_time,
                                     submission_time,
                                     originator,
                                     originator_version,
                                     ros_codelists_version,
                                     ros_model_version,
                                     source,
                                     status,
                                     submitter_id,
                                     reporting_country_code,
                                     vessel_type_code,
                                     finalization_time)
SELECT id,
       complete,
       creation_time,
       submission_time,
       originator,
       originator_version,
       ros_codelists_version,
       ros_model_version,
       source,
       status,
       submitter_id,
       reporting_country_code,
       'GO',
       finalization_time
from ros_gn.observer_data g;

INSERT INTO ros_common.observer_data(original_id,
                                     complete,
                                     creation_time,
                                     submission_time,
                                     originator,
                                     originator_version,
                                     ros_codelists_version,
                                     ros_model_version,
                                     source,
                                     status,
                                     submitter_id,
                                     reporting_country_code,
                                     vessel_type_code,
                                     finalization_time)
SELECT id,
       complete,
       creation_time,
       submission_time,
       originator,
       originator_version,
       ros_codelists_version,
       ros_model_version,
       source,
       status,
       submitter_id,
       reporting_country_code,
       'LP',
       finalization_time
from ros_pl.observer_data;

ALTER TABLE ros_common.trip ADD COLUMN observer_data_id int;
ALTER TABLE ros_common.trip ADD CONSTRAINT fk_ros_common_trip_observer_data FOREIGN KEY (observer_data_id) REFERENCES ros_common.observer_data (id);

create index if not exists idx_ros_common_trip_observer_data on ros_common.trip (observer_data_id);

ALTER TABLE ros_common.trip ADD COLUMN uid varchar(255);

UPDATE ros_common.trip as trip
SET observer_data_id = (SELECT od.id
                        FROM ros_common.observer_data od
                                 INNER JOIN ros_ll.observer_data t on od.original_id = t.id
                        where trip.id = od.id
                          AND od.vessel_type_code = 'LL'),
    uid = (SELECT t.uid
                        FROM ros_common.observer_data od
                                 INNER JOIN ros_ll.observer_data t on od.original_id = t.id
                        where trip.id = od.id
                          AND od.vessel_type_code = 'LL')
WHERE trip.id in (SELECT od.id
                        FROM ros_common.observer_data od
                                 INNER JOIN ros_ll.observer_data t on od.original_id = t.id AND od.vessel_type_code = 'LL');

UPDATE ros_common.trip as trip
SET observer_data_id = (SELECT od.id
                        FROM ros_common.observer_data od
                                 INNER JOIN ros_ps.observer_data t on od.original_id = t.id
                        where trip.id = od.id
                          AND od.vessel_type_code = 'SP'),
    uid = (SELECT t.uid
                        FROM ros_common.observer_data od
                                 INNER JOIN ros_ps.observer_data t on od.original_id = t.id
                        where trip.id = od.id
                          AND od.vessel_type_code = 'SP')
WHERE trip.id in (SELECT od.id
                        FROM ros_common.observer_data od
                                 INNER JOIN ros_ps.observer_data t on od.original_id = t.id AND od.vessel_type_code = 'SP');

UPDATE ros_common.trip as trip
SET observer_data_id = (SELECT od.id
                        FROM ros_common.observer_data od
                                 INNER JOIN ros_pl.observer_data t on od.original_id = t.id
                        where trip.id = od.id
                          AND od.vessel_type_code = 'LP'),
    uid = (SELECT t.uid
                        FROM ros_common.observer_data od
                                 INNER JOIN ros_pl.observer_data t on od.original_id = t.id
                        where trip.id = od.id
                          AND od.vessel_type_code = 'LP')
WHERE trip.id in (SELECT od.id
                        FROM ros_common.observer_data od
                                 INNER JOIN ros_pl.observer_data t on od.original_id = t.id AND od.vessel_type_code = 'LP');

UPDATE ros_common.trip as trip
SET observer_data_id = (SELECT od.id
                        FROM ros_common.observer_data od
                                 INNER JOIN ros_gn.observer_data t on od.original_id = t.id
                        where trip.id = od.id
                          AND od.vessel_type_code = 'GO'),
    uid = (SELECT t.uid
                        FROM ros_common.observer_data od
                                 INNER JOIN ros_gn.observer_data t on od.original_id = t.id
                        where trip.id = od.id
                          AND od.vessel_type_code = 'GO')
WHERE trip.id in (SELECT od.id
                        FROM ros_common.observer_data od
                                 INNER JOIN ros_gn.observer_data t on od.original_id = t.id AND od.vessel_type_code = 'GO');

ALTER TABLE ros_common.trip ALTER COLUMN observer_data_id SET NOT NULL;
ALTER TABLE ros_common.trip ALTER COLUMN uid SET NOT NULL;
