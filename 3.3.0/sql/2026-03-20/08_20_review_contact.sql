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

-- contact[1/38] full_name='BATCHILDE RONNY', nationality_code=NULL, iotc_observer_identifier='IOTCROSX001', national_observer_id=NULL, accreditation_year=NULL, accredited_by='ESP', deregistered_date=NULL
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('BATCHILDE RONNY', NULL);
INSERT INTO ros_meta.observer(contact_id, iotc_observer_identifier, national_observer_id, accreditation_year, accredited_by, deregistered_date) VALUES(1009, 'IOTCROSX001', NULL, NULL, 'ESP', NULL);
-- contact[2/38] full_name='CHIU CHI-LUN', nationality_code=NULL, iotc_observer_identifier='IOTCROS0796', national_observer_id=NULL, accreditation_year=2025, accredited_by='TWN', deregistered_date=NULL
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('CHIU CHI-LUN', NULL);
INSERT INTO ros_meta.observer(contact_id, iotc_observer_identifier, national_observer_id, accreditation_year, accredited_by, deregistered_date) VALUES(1010, 'IOTCROS0796', NULL, 2025, 'TWN', NULL);
-- contact[3/38] full_name='ELECTRONICA', nationality_code=NULL, iotc_observer_identifier='IOTCROSX002', national_observer_id=NULL, accreditation_year=NULL, accredited_by='ESP', deregistered_date=NULL
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('ELECTRONICA', NULL);
INSERT INTO ros_meta.observer(contact_id, iotc_observer_identifier, national_observer_id, accreditation_year, accredited_by, deregistered_date) VALUES(1011, 'IOTCROSX002', NULL, NULL, 'ESP', NULL);
-- contact[4/38] full_name='GRAIG TIRANT', nationality_code=NULL, iotc_observer_identifier='IOTCROSX003', national_observer_id=NULL, accreditation_year=NULL, accredited_by='SYC', deregistered_date=NULL
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('GRAIG TIRANT', NULL);
INSERT INTO ros_meta.observer(contact_id, iotc_observer_identifier, national_observer_id, accreditation_year, accredited_by, deregistered_date) VALUES(1012, 'IOTCROSX003', NULL, NULL, 'SYC', NULL);
-- contact[5/38] full_name='HUANG YI-CHENG', nationality_code=NULL, iotc_observer_identifier='IOTCROS0791', national_observer_id=NULL, accreditation_year=2025, accredited_by='TWN', deregistered_date=NULL
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('HUANG YI-CHENG', NULL);
INSERT INTO ros_meta.observer(contact_id, iotc_observer_identifier, national_observer_id, accreditation_year, accredited_by, deregistered_date) VALUES(1013, 'IOTCROS0791', NULL, 2025, 'TWN', NULL);
-- contact[6/38] full_name='JEIRSON CRUZ', nationality_code=NULL, iotc_observer_identifier='IOTCROSX004', national_observer_id=NULL, accreditation_year=NULL, accredited_by='ESP', deregistered_date=NULL
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('JEIRSON CRUZ', NULL);
INSERT INTO ros_meta.observer(contact_id, iotc_observer_identifier, national_observer_id, accreditation_year, accredited_by, deregistered_date) VALUES(1014, 'IOTCROSX004', NULL, NULL, 'ESP', NULL);
-- contact[7/38] full_name='JOANNE LABROSE', nationality_code=NULL, iotc_observer_identifier='IOTCROSX005', national_observer_id=NULL, accreditation_year=NULL, accredited_by='SYC', deregistered_date=NULL
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('JOANNE LABROSE', NULL);
INSERT INTO ros_meta.observer(contact_id, iotc_observer_identifier, national_observer_id, accreditation_year, accredited_by, deregistered_date) VALUES(1015, 'IOTCROSX005', NULL, NULL, 'SYC', NULL);
-- contact[8/38] full_name='LABROSE JOANNE', nationality_code=NULL, iotc_observer_identifier='IOTCROSX006', national_observer_id=NULL, accreditation_year=NULL, accredited_by='ESP', deregistered_date=NULL
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('LABROSE JOANNE', NULL);
INSERT INTO ros_meta.observer(contact_id, iotc_observer_identifier, national_observer_id, accreditation_year, accredited_by, deregistered_date) VALUES(1016, 'IOTCROSX006', NULL, NULL, 'ESP', NULL);
-- contact[9/38] full_name='LAI FANG-YI', nationality_code=NULL, iotc_observer_identifier='IOTCROS0792', national_observer_id=NULL, accreditation_year=2025, accredited_by='TWN', deregistered_date=NULL
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('LAI FANG-YI', NULL);
INSERT INTO ros_meta.observer(contact_id, iotc_observer_identifier, national_observer_id, accreditation_year, accredited_by, deregistered_date) VALUES(1017, 'IOTCROS0792', NULL, 2025, 'TWN', NULL);
-- contact[10/38] full_name='LANAQUERA LAIA', nationality_code=NULL, iotc_observer_identifier='IOTCROSX007', national_observer_id=NULL, accreditation_year=NULL, accredited_by='ESP', deregistered_date=NULL
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('LANAQUERA LAIA', NULL);
INSERT INTO ros_meta.observer(contact_id, iotc_observer_identifier, national_observer_id, accreditation_year, accredited_by, deregistered_date) VALUES(1018, 'IOTCROSX007', NULL, NULL, 'ESP', NULL);
-- contact[11/38] full_name='LIN JUI-CHIUN', nationality_code=NULL, iotc_observer_identifier='IOTCROS0793', national_observer_id=NULL, accreditation_year=2025, accredited_by='TWN', deregistered_date=NULL
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('LIN JUI-CHIUN', NULL);
INSERT INTO ros_meta.observer(contact_id, iotc_observer_identifier, national_observer_id, accreditation_year, accredited_by, deregistered_date) VALUES(1019, 'IOTCROS0793', NULL, 2025, 'TWN', NULL);
-- contact[12/38] full_name='LIN LIEN-CHIEN', nationality_code=NULL, iotc_observer_identifier='IOTCROS0795', national_observer_id=NULL, accreditation_year=2025, accredited_by='TWN', deregistered_date=NULL
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('LIN LIEN-CHIEN', NULL);
INSERT INTO ros_meta.observer(contact_id, iotc_observer_identifier, national_observer_id, accreditation_year, accredited_by, deregistered_date) VALUES(1020, 'IOTCROS0795', NULL, 2025, 'TWN', NULL);
-- contact[13/38] full_name='MARIE MIGUEL', nationality_code=NULL, iotc_observer_identifier='IOTCROSX008', national_observer_id=NULL, accreditation_year=NULL, accredited_by='ESP', deregistered_date=NULL
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('MARIE MIGUEL', NULL);
INSERT INTO ros_meta.observer(contact_id, iotc_observer_identifier, national_observer_id, accreditation_year, accredited_by, deregistered_date) VALUES(1021, 'IOTCROSX008', NULL, NULL, 'ESP', NULL);
-- contact[14/38] full_name='MIGUEL ANGEL CHAVERO', nationality_code=NULL, iotc_observer_identifier='IOTCROSX009', national_observer_id=NULL, accreditation_year=NULL, accredited_by='ESP', deregistered_date=NULL
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('MIGUEL ANGEL CHAVERO', NULL);
INSERT INTO ros_meta.observer(contact_id, iotc_observer_identifier, national_observer_id, accreditation_year, accredited_by, deregistered_date) VALUES(1022, 'IOTCROSX009', NULL, NULL, 'ESP', NULL);
-- contact[15/38] full_name='MIGUEL MARIE', nationality_code=NULL, iotc_observer_identifier='IOTCROSX010', national_observer_id=NULL, accreditation_year=NULL, accredited_by='SYC', deregistered_date=NULL
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('MIGUEL MARIE', NULL);
INSERT INTO ros_meta.observer(contact_id, iotc_observer_identifier, national_observer_id, accreditation_year, accredited_by, deregistered_date) VALUES(1023, 'IOTCROSX010', NULL, NULL, 'SYC', NULL);
-- contact[16/38] full_name='RICKPERT WOODCOCK', nationality_code=NULL, iotc_observer_identifier='IOTCROSX011', national_observer_id=NULL, accreditation_year=NULL, accredited_by='SYC', deregistered_date=NULL
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('RICKPERT WOODCOCK', NULL);
INSERT INTO ros_meta.observer(contact_id, iotc_observer_identifier, national_observer_id, accreditation_year, accredited_by, deregistered_date) VALUES(1024, 'IOTCROSX011', NULL, NULL, 'SYC', NULL);
-- contact[17/38] full_name='RICO MARIE', nationality_code=NULL, iotc_observer_identifier='IOTCROSX012', national_observer_id=NULL, accreditation_year=NULL, accredited_by='SYC', deregistered_date=NULL
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('RICO MARIE', NULL);
INSERT INTO ros_meta.observer(contact_id, iotc_observer_identifier, national_observer_id, accreditation_year, accredited_by, deregistered_date) VALUES(1025, 'IOTCROSX012', NULL, NULL, 'SYC', NULL);
-- contact[18/38] full_name='SEDDICK FANNY AL ABDULLA', nationality_code=NULL, iotc_observer_identifier='IOTCROSX013', national_observer_id=NULL, accreditation_year=NULL, accredited_by='SYC', deregistered_date=NULL
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('SEDDICK FANNY AL ABDULLA', NULL);
INSERT INTO ros_meta.observer(contact_id, iotc_observer_identifier, national_observer_id, accreditation_year, accredited_by, deregistered_date) VALUES(1026, 'IOTCROSX013', NULL, NULL, 'SYC', NULL);
-- contact[19/38] full_name='SHI YANCHANG', nationality_code=NULL, iotc_observer_identifier='IOTCROSX014', national_observer_id=NULL, accreditation_year=NULL, accredited_by='CHN', deregistered_date=NULL
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('SHI YANCHANG', NULL);
INSERT INTO ros_meta.observer(contact_id, iotc_observer_identifier, national_observer_id, accreditation_year, accredited_by, deregistered_date) VALUES(1027, 'IOTCROSX014', NULL, NULL, 'CHN', NULL);
-- contact[20/38] full_name='SILVY DUVAL', nationality_code=NULL, iotc_observer_identifier='IOTCROSX015', national_observer_id=NULL, accreditation_year=NULL, accredited_by='SYC', deregistered_date=NULL
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('SILVY DUVAL', NULL);
INSERT INTO ros_meta.observer(contact_id, iotc_observer_identifier, national_observer_id, accreditation_year, accredited_by, deregistered_date) VALUES(1028, 'IOTCROSX015', NULL, NULL, 'SYC', NULL);
-- contact[21/38] full_name='STEPHANO BIJOUX', nationality_code=NULL, iotc_observer_identifier='IOTCROSX016', national_observer_id=NULL, accreditation_year=NULL, accredited_by='SYC', deregistered_date=NULL
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('STEPHANO BIJOUX', NULL);
INSERT INTO ros_meta.observer(contact_id, iotc_observer_identifier, national_observer_id, accreditation_year, accredited_by, deregistered_date) VALUES(1029, 'IOTCROSX016', NULL, NULL, 'SYC', NULL);
-- contact[22/38] full_name='TOULLE MATHIEU', nationality_code=NULL, iotc_observer_identifier='IOTCROSX017', national_observer_id=NULL, accreditation_year=NULL, accredited_by='ESP', deregistered_date=NULL
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('TOULLE MATHIEU', NULL);
INSERT INTO ros_meta.observer(contact_id, iotc_observer_identifier, national_observer_id, accreditation_year, accredited_by, deregistered_date) VALUES(1030, 'IOTCROSX017', NULL, NULL, 'ESP', NULL);
-- contact[23/38] full_name='WILLS MALVINA', nationality_code=NULL, iotc_observer_identifier='IOTCROSX018', national_observer_id=NULL, accreditation_year=NULL, accredited_by='SYC', deregistered_date=NULL
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('WILLS MALVINA', NULL);
INSERT INTO ros_meta.observer(contact_id, iotc_observer_identifier, national_observer_id, accreditation_year, accredited_by, deregistered_date) VALUES(1031, 'IOTCROSX018', NULL, NULL, 'SYC', NULL);
-- contact[24/38] full_name='WOODCOCK RICKPERT', nationality_code=NULL, iotc_observer_identifier='IOTCROSX019', national_observer_id=NULL, accreditation_year=NULL, accredited_by='ESP', deregistered_date=NULL
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('WOODCOCK RICKPERT', NULL);
INSERT INTO ros_meta.observer(contact_id, iotc_observer_identifier, national_observer_id, accreditation_year, accredited_by, deregistered_date) VALUES(1032, 'IOTCROSX019', NULL, NULL, 'ESP', NULL);
-- contact[25/38] full_name='XIAO ZONGJIAN', nationality_code=NULL, iotc_observer_identifier='IOTCROSX020', national_observer_id=NULL, accreditation_year=NULL, accredited_by='CHN', deregistered_date=NULL
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('XIAO ZONGJIAN', NULL);
INSERT INTO ros_meta.observer(contact_id, iotc_observer_identifier, national_observer_id, accreditation_year, accredited_by, deregistered_date) VALUES(1033, 'IOTCROSX020', NULL, NULL, 'CHN', NULL);
INSERT INTO ros_meta.observer_identifier_mapping(legacy_iotc_observer_identifier, iotc_observer_identifier) VALUES('IOTCROS0925', 'IOTCROS0616');
INSERT INTO ros_meta.observer_identifier_mapping(legacy_iotc_observer_identifier, iotc_observer_identifier) VALUES('IOTCROS0887', 'IOTCROS0610');
INSERT INTO ros_meta.observer_identifier_mapping(legacy_iotc_observer_identifier, iotc_observer_identifier) VALUES('IOTCROS0427', 'IOTCROS0426');
INSERT INTO ros_meta.observer_identifier_mapping(legacy_iotc_observer_identifier, iotc_observer_identifier) VALUES('IOTCROS0863', 'IOTCROS0796');
INSERT INTO ros_meta.observer_identifier_mapping(legacy_iotc_observer_identifier, iotc_observer_identifier) VALUES('IOTCROS0858', 'IOTCROS0791');
INSERT INTO ros_meta.observer_identifier_mapping(legacy_iotc_observer_identifier, iotc_observer_identifier) VALUES('IOTCROS0859', 'IOTCROS0792');
INSERT INTO ros_meta.observer_identifier_mapping(legacy_iotc_observer_identifier, iotc_observer_identifier) VALUES('IOTCROS0860', 'IOTCROS0793');
INSERT INTO ros_meta.observer_identifier_mapping(legacy_iotc_observer_identifier, iotc_observer_identifier) VALUES('IOTCROS0862', 'IOTCROS0795');
UPDATE ros_meta.contact SET full_name ='CHAIDEE RTN. PHITHAK' WHERE full_name = 'CHAIDEE, RTN. PHITHAK';
UPDATE ros_meta.contact SET full_name ='NUANGSANG RTN. CHIRAT' WHERE full_name = 'NUANGSANG, RTN. CHIRAT';
UPDATE ros_meta.contact SET full_name ='SIRIPITRAKOOL RTN. PISANU' WHERE full_name = 'SIRIPITRAKOOL, RTN. PISANU';
UPDATE ros_meta.contact SET full_name ='VOLCANES MOLERO VICMARY SARAIS' WHERE full_name = 'VOLCANES MOLERO VICMARY S.';
UPDATE ros_meta.contact SET full_name ='DURANY VALCARCEL XAVIER' WHERE full_name = 'DURANY  VALCARCEL XAVIER';
UPDATE ros_meta.contact SET full_name ='MACAGNO SILVINA' WHERE full_name = 'MACAG SILVINA';
UPDATE ros_meta.contact SET full_name ='PARTO SANJOYO SANJOYO' WHERE full_name = 'SANJOYO PARTO';
delete from ros_meta.observer_identifier_mapping oo   where oo.iotc_observer_identifier in  (select o.iotc_observer_identifier from ros_meta.observer o inner join ros_meta.contact c on c.id = o.contact_id  where full_name = 'SATMANA');
delete from ros_meta.observer o  where o.contact_id in (select id from ros_meta.contact where full_name = 'SATMANA');
delete from ros_meta.contact where full_name = 'SATMANA';
UPDATE ros_meta.contact SET full_name ='SATMANA' WHERE full_name = 'SATAMANA';

UPDATE ros_meta.observer SET iotc_observer_identifier ='IOTCROSX021' WHERE observer.iotc_observer_identifier = 'IOTCROS0983';
UPDATE ros_meta.observer SET iotc_observer_identifier ='IOTCROSX022' WHERE observer.iotc_observer_identifier = 'IOTCROS0987';
UPDATE ros_meta.observer SET iotc_observer_identifier ='IOTCROSX024' WHERE observer.iotc_observer_identifier = 'IOTCROS0991';
UPDATE ros_meta.observer SET iotc_observer_identifier ='IOTCROSX025' WHERE observer.iotc_observer_identifier = 'IOTCROS0985';
UPDATE ros_meta.observer SET iotc_observer_identifier ='IOTCROS0409' WHERE contact_id = 381;
UPDATE ros_meta.observer SET iotc_observer_identifier ='IOTCROS0985' WHERE contact_id = 390;
INSERT INTO ros_meta.observer_identifier_mapping(legacy_iotc_observer_identifier, iotc_observer_identifier) VALUES('IOTCJPN006', 'IOTCROS0409');

UPDATE ros_meta.observer_identifier_mapping SET iotc_observer_identifier ='IOTCROSX024' WHERE iotc_observer_identifier = 'IOTCROS0989';
UPDATE ros_meta.observer SET iotc_observer_identifier ='IOTCROSX023' WHERE observer.iotc_observer_identifier = 'IOTCROS0989';
UPDATE ros_meta.observer_identifier_mapping SET iotc_observer_identifier ='IOTCROSX023' WHERE iotc_observer_identifier = 'IOTCROSX024';
UPDATE ros_meta.observer_identifier_mapping SET iotc_observer_identifier ='IOTCROSX023' WHERE iotc_observer_identifier = 'IOTCROSX024';

-- contact[1/6] full_name='ANDRIANSYAH VERY', nationality_code='IDN', iotc_observer_identifier='IOTCROS0989', national_observer_id=NULL, accreditation_year=2025, accredited_by='JPN', deregistered_date=NULL
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('ANDRIANSYAH VERY', 'IDN');
INSERT INTO ros_meta.observer(contact_id, iotc_observer_identifier, national_observer_id, accreditation_year, accredited_by, deregistered_date) VALUES(1034, 'IOTCROS0989', NULL, 2025, 'JPN', NULL);
-- contact[2/6] full_name='IRMA SURYANI ADE', nationality_code='IDN', iotc_observer_identifier='IOTCROS0995', national_observer_id=NULL, accreditation_year=2025, accredited_by='JPN', deregistered_date=NULL
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('IRMA SURYANI ADE', 'IDN');
INSERT INTO ros_meta.observer(contact_id, iotc_observer_identifier, national_observer_id, accreditation_year, accredited_by, deregistered_date) VALUES(1035, 'IOTCROS0995', NULL, 2025, 'JPN', NULL);
-- contact[3/6] full_name='KRISNA WIGUNA HARRI', nationality_code='IDN', iotc_observer_identifier='IOTCROS0987', national_observer_id=NULL, accreditation_year=2025, accredited_by='JPN', deregistered_date=NULL
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('KRISNA WIGUNA HARRI', 'IDN');
INSERT INTO ros_meta.observer(contact_id, iotc_observer_identifier, national_observer_id, accreditation_year, accredited_by, deregistered_date) VALUES(1036, 'IOTCROS0987', NULL, 2025, 'JPN', NULL);
-- contact[4/6] full_name='PRIATNA NANA', nationality_code='IDN', iotc_observer_identifier='IOTCROS0991', national_observer_id=NULL, accreditation_year=2025, accredited_by='JPN', deregistered_date=NULL
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('PRIATNA NANA', 'IDN');
INSERT INTO ros_meta.observer(contact_id, iotc_observer_identifier, national_observer_id, accreditation_year, accredited_by, deregistered_date) VALUES(1037, 'IOTCROS0991', NULL, 2025, 'JPN', NULL);
-- contact[5/6] full_name='SUHERLAN ANANG', nationality_code='IDN', iotc_observer_identifier='IOTCROS0983', national_observer_id=NULL, accreditation_year=2025, accredited_by='JPN', deregistered_date=NULL
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('SUHERLAN ANANG', 'IDN');
INSERT INTO ros_meta.observer(contact_id, iotc_observer_identifier, national_observer_id, accreditation_year, accredited_by, deregistered_date) VALUES(1038, 'IOTCROS0983', NULL, 2025, 'JPN', NULL);
-- contact[6/6] full_name='TOIP ENCEP', nationality_code='IDN', iotc_observer_identifier='IOTCROS0994', national_observer_id=NULL, accreditation_year=2025, accredited_by='JPN', deregistered_date=NULL
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('TOIP ENCEP', 'IDN');
INSERT INTO ros_meta.observer(contact_id, iotc_observer_identifier, national_observer_id, accreditation_year, accredited_by, deregistered_date) VALUES(1039, 'IOTCROS0994', NULL, 2025, 'JPN', NULL);

-- VESSEL_INFORMATION_OWNER_AND_PERSONNEL_FISHING_MASTER_FULL_NAME
-- "Aitor Santiago Ortega",
-- "Andoni Kaltzakorta Zabala",
-- "Bittor Atxurra Barainka",
-- "CHEN MING YU",
-- "Iker Galbaniatu",
-- "Jokin Carrasco",
-- "Julio García Lorenzo",
-- "Pascal Landrein Jean-Jacques",
-- "Unax Panciano Sánchez",

-- VESSEL_INFORMATION_OWNER_AND_PERSONNEL_SKIPPER_CAPTAIN_FULL_NAME
-- "Carlos Vidal",
-- "CHEN MING YU",
-- "Iñaki Iradi Garmendia",
-- "José Luis Durán Diz",
-- "José Manuel Pinazas",
-- "Josu Arana Iñarra",
-- "Julen Laucircia Martínez",
-- "Patxi Valadés",
-- "Txabi I. San Pedro",
-- contact[1/17] full_name='AITOR SANTIAGO ORTEGA'
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('AITOR SANTIAGO ORTEGA', NULL);
-- contact[2/17] full_name='ANDONI KALTZAKORTA ZABALA'
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('ANDONI KALTZAKORTA ZABALA', NULL);
-- contact[3/17] full_name='BITTOR ATXURRA BARAINKA'
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('BITTOR ATXURRA BARAINKA', NULL);
-- contact[4/17] full_name='CHEN MING YU'
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('CHEN MING YU', NULL);
-- contact[5/17] full_name='IKER GALBANIATU'
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('IKER GALBANIATU', NULL);
-- contact[6/17] full_name='JOKIN CARRASCO'
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('JOKIN CARRASCO', NULL);
-- contact[7/17] full_name='JULIO GARCIA LORENZO'
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('JULIO GARCIA LORENZO', NULL);
-- contact[8/17] full_name='PASCAL LANDREIN JEAN-JACQUES'
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('PASCAL LANDREIN JEAN-JACQUES', NULL);
-- contact[9/17] full_name='UNAX PANCIANO SANCHEZ'
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('UNAX PANCIANO SANCHEZ', NULL);
-- contact[10/17] full_name='CARLOS VIDAL'
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('CARLOS VIDAL', NULL);
-- contact[11/17] full_name='INAKI IRADI GARMENDIA'
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('INAKI IRADI GARMENDIA', NULL);
-- contact[12/17] full_name='JOSE LUIS DURAN DIZ'
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('JOSE LUIS DURAN DIZ', NULL);
-- contact[13/17] full_name='JOSE MANUEL PINAZAS'
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('JOSE MANUEL PINAZAS', NULL);
-- contact[14/17] full_name='JOSU ARANA INARRA'
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('JOSU ARANA INARRA', NULL);
-- contact[15/17] full_name='JULEN LAUCIRCIA MARTINEZ'
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('JULEN LAUCIRCIA MARTINEZ', NULL);
-- contact[16/17] full_name='PATXI VALADES'
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('PATXI VALADES', NULL);
-- contact[17/17] full_name='TXABI I. SAN PEDRO'
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('TXABI I. SAN PEDRO', NULL);

-- Focal points
-- Chia Chun WU
-- Chia-Chun WU
-- Wu Jia Chun
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('WU JIA CHUN', 'TWN');
INSERT INTO ros_meta.focal_point(contact_id, email) SELECT id, 'jiachun@ms1.fa.gov.tw' from ros_meta.contact WHERE full_name = 'WU JIA CHUN';

-- Lucía Sarricolea Balufo
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('SARRICOLEA BALUFO LUCIA', 'ESP');
INSERT INTO ros_meta.focal_point(contact_id, email) SELECT id, 'lsarricolea@mapa.es' from ros_meta.contact WHERE full_name = 'SARRICOLEA BALUFO LUCIA';

-- Ranwel N. Mbukwah RANWEL N. MBUKWAH,TZA,ranwell.mbukwah@dsfa.go.tz,,
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('N. MBUKWAH RANWEL', 'TZA');
INSERT INTO ros_meta.focal_point(contact_id, email) SELECT id, 'ranwell.mbukwah@dsfa.go.tz' from ros_meta.contact WHERE full_name = 'N. MBUKWAH';

-- Shanghai Ocean University SHANGHAI OCEAN UNIVERSITY,CHN,liyananxiadayeah.net,,
INSERT INTO ros_meta.contact(full_name, nationality_code) VALUES('SHANGHAI OCEAN UNIVERSITY', 'CHN');
INSERT INTO ros_meta.focal_point(contact_id, email) SELECT id, 'liyananxiadayeah.net' from ros_meta.contact WHERE full_name = 'SHANGHAI OCEAN UNIVERSITY';
