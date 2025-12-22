create table if not exists ros_common.speeds
(
    id    integer generated always as identity (SEQUENCE NAME ros_common.speeds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1),
    unit  varchar(3) NOT NULL,
    value double precision NOT NULL
);

alter table ros_common.speeds add primary key (id);
alter table ros_common.speeds add constraint uk_speeds unique (unit, value);

alter table ros_ll.setting_operations ADD column vessel_speed_id integer;
alter table ros_ll.setting_operations ADD constraint ros_ll_setting_operations_vessel_speed_id_fk FOREIGN KEY (vessel_speed_id) REFERENCES ros_common.speeds (id);
insert into ros_common.speeds(value, unit) SELECT distinct vessel_speed, 'KN' from ros_ll.setting_operations where vessel_speed is not null order by vessel_speed;
UPDATE ros_ll.setting_operations SET vessel_speed_id = s.id FROM ros_common.speeds s WHERE s.value = vessel_speed AND s.unit = 'KN';
alter table  ros_ll.setting_operations drop column vessel_speed;

alter table ros_ll.setting_operations ADD column line_setter_speed_id integer;
alter table ros_ll.setting_operations ADD constraint ros_ll_setting_operations_line_setter_speed_id FOREIGN KEY (line_setter_speed_id) REFERENCES ros_common.speeds (id);
insert into ros_common.speeds(value, unit) SELECT distinct line_setter_speed, 'MS' from ros_ll.setting_operations where line_setter_speed is not null order by line_setter_speed;
UPDATE ros_ll.setting_operations SET line_setter_speed_id = s.id FROM ros_common.speeds s WHERE s.value = line_setter_speed AND s.unit = 'MS';
alter table  ros_ll.setting_operations drop column line_setter_speed;

