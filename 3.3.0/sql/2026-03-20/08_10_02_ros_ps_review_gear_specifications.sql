ALTER TABLE ros_ps.gear_specifications ADD COLUMN power_block BOOLEAN DEFAULT FALSE;
ALTER TABLE ros_ps.gear_specifications ADD COLUMN purse_winch BOOLEAN DEFAULT FALSE;
ALTER TABLE ros_ps.gear_specifications ADD COLUMN maximum_brail_capacity double precision;
ALTER TABLE ros_ps.gear_specifications ADD COLUMN bunt_stretched_mesh_size_id INTEGER;
ALTER TABLE ros_ps.gear_specifications ADD COLUMN maximum_net_depth_id INTEGER;
ALTER TABLE ros_ps.gear_specifications ADD COLUMN maximum_net_length_id INTEGER;
ALTER TABLE ros_ps.gear_specifications ADD COLUMN mid_net_stretched_mesh_size_id INTEGER;

create index if not exists index_ps_general_specifications_bunt_stretched_mesh_size_id
    on ros_ps.gear_specifications (bunt_stretched_mesh_size_id);

create index if not exists index_ps_general_specifications_maximum_net_depth_id
    on ros_ps.gear_specifications (maximum_net_depth_id);

create index if not exists index_ps_general_specifications_maximum_net_length_id
    on ros_ps.gear_specifications (maximum_net_length_id);

create index if not exists index_ps_general_specifications_mid_net_stretched_mesh_size_id
    on ros_ps.gear_specifications (mid_net_stretched_mesh_size_id);

alter table ros_ps.gear_specifications
    add constraint fk_ros_ps_gear_specifications_bunt_stretched_mesh_size_id
        foreign key (bunt_stretched_mesh_size_id) references ros_common.sizes;

alter table ros_ps.gear_specifications
    add constraint fk_ros_ps_gear_specifications_maximum_net_length_id
        foreign key (maximum_net_length_id) references ros_common.lengths;

alter table ros_ps.gear_specifications
    add constraint fk_ros_ps_gear_specifications_maximum_net_depth_id
        foreign key (maximum_net_depth_id) references ros_common.depths;

alter table ros_ps.gear_specifications
    add constraint fk_ros_ps_gear_specifications_mid_net_stretched_mesh_size_id
        foreign key (mid_net_stretched_mesh_size_id) references ros_common.sizes;

UPDATE ros_ps.gear_specifications as main
SET power_block = (SELECT power_block FROM ros_ps.special_equipment l WHERE main.special_equipment_id = l.id),
    purse_winch = (SELECT purse_winch FROM ros_ps.special_equipment l WHERE main.special_equipment_id = l.id);

UPDATE ros_ps.gear_specifications as main
SET maximum_brail_capacity = (SELECT maximum_brail_capacity FROM ros_ps.general_gear_attributes l WHERE main.general_gear_attributes_id = l.id),
    bunt_stretched_mesh_size_id = (SELECT bunt_stretched_mesh_size_id FROM ros_ps.general_gear_attributes l WHERE main.general_gear_attributes_id = l.id),
    maximum_net_depth_id = (SELECT maximum_net_depth_id FROM ros_ps.general_gear_attributes l WHERE main.general_gear_attributes_id = l.id),
    maximum_net_length_id = (SELECT maximum_net_length_id FROM ros_ps.general_gear_attributes l WHERE main.general_gear_attributes_id = l.id),
    mid_net_stretched_mesh_size_id = (SELECT mid_net_stretched_mesh_size_id FROM ros_ps.general_gear_attributes l WHERE main.general_gear_attributes_id = l.id);

