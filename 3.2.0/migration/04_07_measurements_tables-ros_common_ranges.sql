
ALTER TABLE ros_common.vessel_attributes DROP CONSTRAINT vsslttrbutestnmyrngeid;
INSERT INTO ros_common.ranges(id, unit, value) OVERRIDING SYSTEM VALUE VALUES (1000000, 'UNK', 110.0);
UPDATE ros_common.vessel_attributes SET autonomy_range_id = 1000000 WHERE autonomy_range_id IN (SELECT id FROM ros_common.ranges WHERE unit = 'UNK' AND value = 110.0);
DELETE FROM ros_common.ranges WHERE id < 1000000;
INSERT INTO ros_common.ranges(id, unit, value) OVERRIDING SYSTEM VALUE VALUES (1, 'UNK', 110.0);
UPDATE ros_common.vessel_attributes SET autonomy_range_id = autonomy_range_id - 1000000 + 1;
DELETE FROM ros_common.ranges WHERE id >= 1000000;
ALTER TABLE ros_common.vessel_attributes ADD CONSTRAINT vsslttrbutestnmyrngeid FOREIGN KEY (autonomy_range_id) references ros_common.ranges (id);
ALTER TABLE ros_common.ranges ADD CONSTRAINT uk_ranges UNIQUE (unit,value);
