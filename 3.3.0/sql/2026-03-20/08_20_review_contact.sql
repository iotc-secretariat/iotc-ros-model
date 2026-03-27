-- move ros_meta.contact to ros_meta.contact
create table if not exists ros_meta.contact
(
    id               integer generated always as identity,
    full_name        varchar(255)         not null,
    active           boolean default true not null,
    email            varchar(255),
    phone            varchar(255),
    comment          varchar(255),
    nationality_code char(3)
);

alter table ros_meta.contact
    add constraint pk_ros_meta_contact
        primary key (id);

alter table ros_meta.contact
    add constraint uk_ros_meta_email_contact
        unique (email);

alter table ros_meta.contact
    add constraint uk_ros_meta_full_name_contact
        unique (full_name);

alter table ros_meta.contact
    add constraint fk_ros_meta_nationality_code_contact
        foreign key (nationality_code) references refs_admin.countries;

create index if not exists idx_ros_meta_full_name_contact on ros_meta.contact (full_name);
create index if not exists idx_ros_meta_nationality_code_contact on ros_meta.contact (nationality_code);

insert into ros_meta.contact(full_name, active, email, phone, comment, nationality_code)
    (SELECT full_name, active, email, phone, comment, nationality_code
     from ros_common.contact);

-- move ros_meta.observer to ros_meta.observer
create table if not exists ros_meta.observer
(
    contact_id               integer      not null,
    iotc_observer_identifier varchar(255) not null,
    national_observer_id     varchar(255),
    accreditation_year       INTEGER,
    accredited_by            varchar(255),
    deregistered_date        DATE
);

alter table ros_meta.observer
    add constraint pk_ros_meta_observer
        primary key (contact_id);

alter table ros_meta.observer
    add constraint uk_ros_meta_iotc_observer_identifier_observer
        unique (iotc_observer_identifier);

alter table ros_meta.observer
    add constraint fk_ros_meta_contact_id_observer
        foreign key (contact_id) references ros_meta.contact;

alter table ros_meta.observer
    add constraint fk_ros_meta_accredited_by_observer
        foreign key (accredited_by) references refs_admin.countries;

create index if not exists idx_ros_meta_contact_id_observer on ros_meta.observer (contact_id);
create index if not exists idx_ros_meta_iotc_observer_identifier_observer on ros_meta.observer (iotc_observer_identifier);

insert into ros_meta.observer(contact_id, iotc_observer_identifier)
    (SELECT m.id, o.iotc_observer_identifier
     from ros_common.contact c
              INNER JOIN ros_common.observer o on c.id = o.contact_id
              INNER JOIN ros_meta.contact m on c.full_name = m.full_name);

-- move ros_meta.observer_identifier_mapping to ros_meta.observer_identifier_mapping
create table if not exists ros_meta.observer_identifier_mapping
(
    legacy_iotc_observer_identifier varchar(16) not null,
    iotc_observer_identifier        varchar(16) not null
);

alter table ros_meta.observer_identifier_mapping
    add constraint ros_meta_observer_identifier_mapping_pkey
        primary key (legacy_iotc_observer_identifier);

alter table ros_meta.observer_identifier_mapping
    add constraint ros_meta_observer_identifier_mapping_uk
        unique (legacy_iotc_observer_identifier, iotc_observer_identifier);

alter table ros_meta.observer_identifier_mapping
    add constraint fk_ros_meta_observer_identifier_mapping
        foreign key (iotc_observer_identifier) references ros_meta.observer (iotc_observer_identifier);

create index if not exists idx_legacy_iotc_observer_identifier_observer_identifier_mapping on ros_meta.observer_identifier_mapping (legacy_iotc_observer_identifier);
create index if not exists idx_iotc_observer_identifier_observer_identifier_mapping on ros_meta.observer_identifier_mapping (iotc_observer_identifier);

insert into ros_meta.observer_identifier_mapping(legacy_iotc_observer_identifier, iotc_observer_identifier)
    (SELECT legacy_iotc_observer_identifier, iotc_observer_identifier
     from ros_common.observer_identifier_mapping);

-- create ros_meta.focal_point
create table if not exists ros_meta.focal_point
(
    contact_id        integer not null,
    email             varchar(255),
    organisation_name varchar(1024),
    comment           varchar(1024)
);

alter table ros_meta.focal_point
    add constraint pk_ros_meta_focal_point
        primary key (contact_id);

alter table ros_meta.focal_point
    add constraint uk_ros_meta_focal_point_email
        unique (email);

alter table ros_meta.focal_point
    add constraint fk_ros_meta_contact_id_focal_point
        foreign key (contact_id) references ros_meta.contact;
create index if not exists idx_ros_meta_contact_id_focal_point on ros_meta.focal_point (contact_id);
create index if not exists idx_ros_meta_email_focal_point on ros_meta.focal_point (email);

insert into ros_meta.focal_point(contact_id, email, comment)
    (SELECT m.id, m.email, m.comment
     from ros_common.contact c
              INNER JOIN ros_common.contact_role cr on c.id = cr.contact_id
              INNER JOIN ros_meta.contact m on c.full_name = m.full_name
     WHERE cr.role_code = 'FP');

ALTER TABLE ros_meta.contact DROP COLUMN email;
ALTER TABLE ros_meta.contact DROP COLUMN active;
ALTER TABLE ros_meta.contact DROP COLUMN phone;
ALTER TABLE ros_meta.contact DROP COLUMN comment;

-- ros_common.trip_observer.observer_id -> ros_meta.observer.contact_id
ALTER TABLE ros_common.trip_observer ADD COLUMN observer_id_2 integer;
UPDATE ros_common.trip_observer SET observer_id_2 = ros_meta.observer.contact_id FROM ros_meta.observer WHERE ros_common.trip_observer.observer_id = ros_meta.observer.contact_id;
ALTER TABLE ros_common.trip_observer DROP COLUMN observer_id;
ALTER TABLE ros_common.trip_observer RENAME observer_id_2 TO observer_id;
ALTER TABLE ros_common.trip_observer ALTER COLUMN observer_id SET NOT NULL;
create index if not exists index_trip_observer_observer_id on ros_common.trip_observer (observer_id);
alter table ros_common.trip_observer add constraint fk_trip_observer_observer_id foreign key (observer_id) references ros_meta.observer(contact_id);
-- ros_common.trip_vessel.skipper_id -> ros_meta.contact.id
ALTER TABLE ros_common.trip_vessel ADD COLUMN skipper_id_2 integer;
UPDATE ros_common.trip_vessel SET skipper_id_2 = ros_meta.contact.id FROM ros_meta.contact WHERE ros_common.trip_vessel.skipper_id = ros_meta.contact.id;
ALTER TABLE ros_common.trip_vessel DROP COLUMN skipper_id;
ALTER TABLE ros_common.trip_vessel RENAME skipper_id_2 TO skipper_id;
create index if not exists index_trip_vessel_skipper_id on ros_common.trip_vessel (skipper_id);
alter table ros_common.trip_vessel add constraint fk_trip_vessel_skipper_id foreign key (skipper_id) references ros_meta.contact(id);
-- ros_common.trip_vessel.fishing_master_id -> ros_meta.contact.id
ALTER TABLE ros_common.trip_vessel ADD COLUMN fishing_master_id_2 integer;
UPDATE ros_common.trip_vessel SET fishing_master_id_2 = ros_meta.contact.id FROM ros_meta.contact WHERE ros_common.trip_vessel.fishing_master_id = ros_meta.contact.id;
ALTER TABLE ros_common.trip_vessel DROP COLUMN fishing_master_id;
ALTER TABLE ros_common.trip_vessel RENAME fishing_master_id_2 TO fishing_master_id;
create index if not exists index_trip_vessel_fishing_master_id on ros_common.trip_vessel (fishing_master_id);
alter table ros_common.trip_vessel add constraint fk_trip_vessel_fishing_master_id foreign key (fishing_master_id) references ros_meta.contact(id);
-- ros_common.observer_data.submitter_id -> ros_meta.contact.id
ALTER TABLE ros_common.observer_data ADD COLUMN submitter_id_2 integer;
UPDATE ros_common.observer_data SET submitter_id_2 = ros_meta.contact.id FROM ros_meta.contact WHERE ros_common.observer_data.submitter_id = ros_meta.contact.id;
ALTER TABLE ros_common.observer_data DROP COLUMN submitter_id;
ALTER TABLE ros_common.observer_data RENAME submitter_id_2 TO submitter_id;
create index if not exists index_observer_data_submitter_id on ros_common.observer_data (submitter_id);
alter table ros_common.observer_data add constraint fk_observer_data_submitter_id foreign key (submitter_id) references ros_meta.contact(id);
-- ros_ll.tag_details.tag_finder_id -> ros_meta.contact.id
ALTER TABLE ros_ll.tag_details ADD COLUMN tag_finder_id_2 integer;
UPDATE ros_ll.tag_details SET tag_finder_id_2 = ros_meta.contact.id FROM ros_meta.contact WHERE ros_ll.tag_details.tag_finder_id = ros_meta.contact.id;
ALTER TABLE ros_ll.tag_details DROP COLUMN tag_finder_id;
ALTER TABLE ros_ll.tag_details RENAME tag_finder_id_2 TO tag_finder_id;
create index if not exists index_tag_details_tag_finder_id on ros_ll.tag_details (tag_finder_id);
alter table ros_ll.tag_details add constraint fk_tag_details_tag_finder_id foreign key (tag_finder_id) references ros_meta.contact(id);
-- ros_ps.tag_details.tag_finder_id -> ros_meta.contact.id
ALTER TABLE ros_ps.tag_details ADD COLUMN tag_finder_id_2 integer;
UPDATE ros_ps.tag_details SET tag_finder_id_2 = ros_meta.contact.id FROM ros_meta.contact WHERE ros_ps.tag_details.tag_finder_id = ros_meta.contact.id;
ALTER TABLE ros_ps.tag_details DROP COLUMN tag_finder_id;
ALTER TABLE ros_ps.tag_details RENAME tag_finder_id_2 TO tag_finder_id;
create index if not exists index_tag_details_tag_finder_id on ros_ps.tag_details (tag_finder_id);
alter table ros_ps.tag_details add constraint fk_tag_details_tag_finder_id foreign key (tag_finder_id) references ros_meta.contact(id);
-- ros_gn.tag_details.tag_finder_id -> ros_meta.contact.id
ALTER TABLE ros_gn.tag_details ADD COLUMN tag_finder_id_2 integer;
UPDATE ros_gn.tag_details SET tag_finder_id_2 = ros_meta.contact.id FROM ros_meta.contact WHERE ros_gn.tag_details.tag_finder_id = ros_meta.contact.id;
ALTER TABLE ros_gn.tag_details DROP COLUMN tag_finder_id;
ALTER TABLE ros_gn.tag_details RENAME tag_finder_id_2 TO tag_finder_id;
create index if not exists index_tag_details_tag_finder_id on ros_gn.tag_details (tag_finder_id);
alter table ros_gn.tag_details add constraint fk_tag_details_tag_finder_id foreign key (tag_finder_id) references ros_meta.contact(id);
-- ros_pl.tag_details.tag_finder_id -> ros_meta.contact.id
ALTER TABLE ros_pl.tag_details ADD COLUMN tag_finder_id_2 integer;
UPDATE ros_pl.tag_details SET tag_finder_id_2 = ros_meta.contact.id FROM ros_meta.contact WHERE ros_pl.tag_details.tag_finder_id = ros_meta.contact.id;
ALTER TABLE ros_pl.tag_details DROP COLUMN tag_finder_id;
ALTER TABLE ros_pl.tag_details RENAME tag_finder_id_2 TO tag_finder_id;
create index if not exists index_tag_details_tag_finder_id on ros_pl.tag_details (tag_finder_id);
alter table ros_pl.tag_details add constraint fk_tag_details_tag_finder_id foreign key (tag_finder_id) references ros_meta.contact(id);