create table if not exists ros_meta.observer_accreditation
(
    observer_id        integer not null,
    accreditation_year integer,
    accredited_by      varchar(255),
    deregistered_date  date
);

create index if not exists idx_ros_meta_contact_id_observer
    on ros_meta.observer (contact_id);

alter table ros_meta.observer_accreditation
    add constraint uk_ros_meta_observer_accreditation
        unique (observer_id, accreditation_year, accredited_by);

alter table ros_meta.observer_accreditation
    add constraint fk_ros_meta_observer_accreditation_accredited
        foreign key (accredited_by) references refs_admin.countries;

alter table ros_meta.observer_accreditation
    add constraint fk_ros_meta_observer_accreditation_observer_id
        foreign key (observer_id) references ros_meta.observer (contact_id);

INSERT INTO ros_meta.observer_accreditation(observer_id, accreditation_year, accredited_by, deregistered_date)
SELECT contact_id,
       accreditation_year,
       accredited_by,
       deregistered_date
FROM ros_meta.observer;

-- Unify `AL-ABDULLA SEDDICK FANNY` and `SEDDICK FANNY AL ABDULLA`

delete from ros_meta.observer_accreditation WHERE observer_id = (SELECT id from ros_meta.contact o where o.full_name = 'SEDDICK FANNY AL ABDULLA');
delete from ros_meta.observer_identifier_mapping WHERE iotc_observer_identifier = 'IOTCROSX013';
delete from ros_meta.observer WHERE contact_id = (SELECT id from ros_meta.contact o where o.full_name='SEDDICK FANNY AL ABDULLA');
delete from ros_meta.contact WHERE full_name='SEDDICK FANNY AL ABDULLA';

update ros_meta.contact SET full_name ='SEDDICK FANNY AL ABDULLA' WHERE full_name ='AL-ABDULLA SEDDICK FANNY';
insert into ros_meta.observer_accreditation (observer_id, accreditation_year, accredited_by) SELECT id, '2025', 'ESP' FROM ros_meta.contact WHERE full_name = 'SEDDICK FANNY AL ABDULLA';
insert into ros_meta.observer_accreditation (observer_id, accreditation_year, accredited_by) SELECT id, NULL, 'SYC' FROM ros_meta.contact WHERE full_name = 'SEDDICK FANNY AL ABDULLA';

update ros_meta.contact SET full_name ='' WHERE full_name ='';

-- Unify `JOANNE LABROSE` and `LABROSE JOANNE`
delete from ros_meta.observer_accreditation WHERE observer_id = (SELECT id from ros_meta.contact o where o.full_name = 'JOANNE LABROSE');
delete from ros_meta.observer_identifier_mapping WHERE iotc_observer_identifier = 'IOTCROSX005';
delete from ros_meta.observer WHERE iotc_observer_identifier = 'IOTCROSX005';
delete from ros_meta.contact WHERE full_name='JOANNE LABROSE';
insert into ros_meta.observer_accreditation (observer_id, accreditation_year, accredited_by) SELECT id, NULL, 'ESP' FROM ros_meta.contact WHERE full_name = 'LABROSE JOANNE';
insert into ros_meta.observer_accreditation (observer_id, accreditation_year, accredited_by) SELECT id, NULL, 'SYC' FROM ros_meta.contact WHERE full_name = 'LABROSE JOANNE';

-- Unify `JUN SEUNG KIM` and `SEUNG JUN KIM`
delete from ros_meta.observer_accreditation WHERE observer_id = (SELECT id from ros_meta.contact o where o.full_name = 'SEUNG JUN KIM');
delete from ros_meta.observer_identifier_mapping WHERE iotc_observer_identifier = 'IOTCROS0511';
delete from ros_meta.observer WHERE iotc_observer_identifier = 'IOTCROS0511';
delete from ros_meta.contact WHERE full_name='SEUNG JUN KIM';
insert into ros_meta.observer_identifier_mapping (legacy_iotc_observer_identifier, iotc_observer_identifier)
VALUES ('IOTCROS0511', 'IOTCROS0499'),('IOTCKOR076','IOTCROS0499');
insert into ros_meta.observer_accreditation (observer_id, accreditation_year, accredited_by) SELECT id, NULL, 'KOR' FROM ros_meta.contact WHERE full_name = 'JUN SEUNG KIM';

-- Unify `RICKPERT WOODCOCK` and `WOODCOCK RICKPERT`
delete from ros_meta.observer_accreditation WHERE observer_id = (SELECT id from ros_meta.contact o where o.full_name = 'RICKPERT WOODCOCK');
delete from ros_meta.observer_identifier_mapping WHERE iotc_observer_identifier = 'IOTCROSX011';
delete from ros_meta.observer WHERE iotc_observer_identifier = 'IOTCROSX011';
delete from ros_meta.contact WHERE full_name='RICKPERT WOODCOCK';
insert into ros_meta.observer_accreditation (observer_id, accreditation_year, accredited_by) SELECT id, NULL, 'ESP' FROM ros_meta.contact WHERE full_name = 'WOODCOCK RICKPERT';
insert into ros_meta.observer_accreditation (observer_id, accreditation_year, accredited_by) SELECT id, NULL, 'SYC' FROM ros_meta.contact WHERE full_name = 'WOODCOCK RICKPERT';

-- Unify `MARIE MIGUEL` and `MIGUEL MARIE`
delete from ros_meta.observer_accreditation WHERE observer_id = (SELECT id from ros_meta.contact o where o.full_name = 'MIGUEL MARIE');
delete from ros_meta.observer_identifier_mapping WHERE iotc_observer_identifier = 'IOTCROSX010';
delete from ros_meta.observer WHERE iotc_observer_identifier = 'IOTCROSX010';
delete from ros_meta.contact WHERE full_name='MIGUEL MARIE';

insert into ros_meta.observer_accreditation (observer_id, accreditation_year, accredited_by) SELECT id, NULL, 'ESP' FROM ros_meta.contact WHERE full_name = 'MARIE MIGUEL';
insert into ros_meta.observer_accreditation (observer_id, accreditation_year, accredited_by) SELECT id, NULL, 'SYC' FROM ros_meta.contact WHERE full_name = 'MARIE MIGUEL';
