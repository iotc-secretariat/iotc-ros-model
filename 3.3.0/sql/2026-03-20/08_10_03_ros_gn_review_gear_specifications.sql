ALTER TABLE ros_gn.gear_specifications ADD COLUMN net_drum_hauler BOOLEAN DEFAULT FALSE;

UPDATE ros_gn.gear_specifications as main
SET net_drum_hauler = (SELECT net_drum_hauler FROM ros_gn.special_equipment l WHERE main.special_equipment_id = l.id);
