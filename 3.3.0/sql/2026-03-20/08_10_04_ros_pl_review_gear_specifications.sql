ALTER TABLE ros_pl.gear_specifications ADD COLUMN live_bait_tanks_capacity double precision;
ALTER TABLE ros_pl.gear_specifications ADD COLUMN number_of_automatic_poles INTEGER;

ALTER TABLE ros_pl.gear_specifications ADD COLUMN number_of_anglers INTEGER;
ALTER TABLE ros_pl.gear_specifications ADD COLUMN pole_material VARCHAR(255);
ALTER TABLE ros_pl.gear_specifications ADD COLUMN pole_material_description TEXT;
ALTER TABLE ros_pl.gear_specifications ADD COLUMN hook_type_code CHAR(3);

create index if not exists index_pl_general_specifications_hook_type_code
    on ros_pl.gear_specifications (hook_type_code);

alter table ros_pl.gear_specifications
    add constraint fk_ros_pl_gear_specifications_hook_type_code
        foreign key (hook_type_code) references refs_fishery.hook_types;

UPDATE ros_pl.gear_specifications as main
SET live_bait_tanks_capacity = (SELECT live_bait_tanks_capacity FROM ros_pl.special_equipment l WHERE main.special_equipment_id = l.id),
    number_of_automatic_poles = (SELECT number_of_automatic_poles FROM ros_pl.special_equipment l WHERE main.special_equipment_id = l.id);

UPDATE ros_pl.gear_specifications as main
SET number_of_anglers = (SELECT number_of_anglers FROM ros_pl.general_gear_attributes l WHERE main.general_gear_attributes_id = l.id),
    pole_material = (SELECT pole_material FROM ros_pl.general_gear_attributes l WHERE main.general_gear_attributes_id = l.id),
    pole_material_description = (SELECT pole_material_description FROM ros_pl.general_gear_attributes l WHERE main.general_gear_attributes_id = l.id),
    hook_type_code = (SELECT hook_type_code FROM ros_pl.general_gear_attributes l WHERE main.general_gear_attributes_id = l.id);

ALTER TABLE ros_pl.lures_or_jiggers_by_type ADD COLUMN gear_specifications_id INTEGER;

create index if not exists index_pl_lures_or_jiggers_by_type_gear_specifications_id
    on ros_pl.lures_or_jiggers_by_type (gear_specifications_id);

alter table ros_pl.lures_or_jiggers_by_type
    add constraint fk_ros_pl_lures_or_jiggers_by_type_gear_specifications_id
        foreign key (gear_specifications_id) references ros_pl.gear_specifications;

UPDATE ros_pl.lures_or_jiggers_by_type as main
SET gear_specifications_id = (SELECT id FROM ros_pl.gear_specifications l WHERE main.general_gear_attributes_id = l.id);
