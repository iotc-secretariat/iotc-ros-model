create table if not exists ros_ll.branchline_configurations_storage
(
    branchline_configuration_id integer not null,
    branchline_storage_code     char(2) not null
);

alter table ros_ll.branchline_configurations_storage
    add constraint ll_branchline_configurations_storage_pkey
        primary key (branchline_configuration_id, branchline_storage_code);

alter table ros_ll.branchline_configurations_storage
    add constraint fk_ros_ll_branchline_configurations_storage_configuration
        foreign key (branchline_configuration_id) references ros_ll.branchline_configurations;

alter table ros_ll.branchline_configurations_storage
    add constraint fk_ros_ll_branchline_configurations_storage_code
        foreign key (branchline_storage_code) references refs_fishery.branchline_storages;
