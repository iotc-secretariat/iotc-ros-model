alter table ros_ll.leader_set
    add constraint fk_ros_ll_leader_set_setting_operation_id
        foreign key (setting_operation_id) references ros_ll.setting_operations;

alter table ros_common.observer_data DROP CONSTRAINT fk_observer_data_submitter_id;

insert into ros_meta.focal_point(contact_id)
SELECT distinct(c.id)
FROM ros_common.observer_data t JOIN ros_meta.contact c on c.id = t.submitter_id
WHERE submitter_id not in (select contact_id from ros_meta.focal_point);
alter table ros_common.observer_data
    add constraint fk_observer_data_submitter_id
        foreign key (submitter_id) references ros_meta.focal_point (contact_id);
