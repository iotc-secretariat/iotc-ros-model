ALTER TABLE ros_ll.gear_specifications ADD COLUMN bait_casting_machine BOOLEAN DEFAULT FALSE;
ALTER TABLE ros_ll.gear_specifications ADD COLUMN line_hauler BOOLEAN DEFAULT FALSE;
ALTER TABLE ros_ll.gear_specifications ADD COLUMN line_setter BOOLEAN DEFAULT FALSE;

UPDATE ros_ll.gear_specifications as main
SET bait_casting_machine = (SELECT bait_casting_machine FROM ros_ll.special_equipment l WHERE main.special_equipment_id = l.id),
    line_hauler          = (SELECT line_hauler FROM ros_ll.special_equipment l WHERE main.special_equipment_id = l.id),
    line_setter          = (SELECT line_setter FROM ros_ll.special_equipment l WHERE main.special_equipment_id = l.id);
