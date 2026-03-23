create table if not exists ros_common.waste_managements
(
    id                                     integer generated always as identity,
    trip_id integer,
    waste_storage_or_disposal_method_code  char(2),
    waste_category_code                    char(2),
    primary key (id),
    constraint fk_ros_common_waste_managements_waste_category_code
        foreign key (waste_category_code) references refs_fishery.waste_categories,
    constraint fk_ros_common_waste_managements_storage_or_disposal_method_code
        foreign key (waste_storage_or_disposal_method_code) references refs_fishery.waste_disposal_methods,
    constraint fk_ros_common_waste_managements_trip_id
        foreign key (trip_id) references ros_common.trip
);

create index if not exists idx_ros_common_waste_managements_trip_id
    on ros_common.waste_managements (trip_id);

