
ALTER TABLE ros_common.vessel_attributes_main_engines DROP CONSTRAINT vsslttrbtsmnngnsmnngnd;
INSERT INTO ros_common.engines(id, unit, value) OVERRIDING SYSTEM VALUE VALUES (1000000, 'BHP', 0.0);
UPDATE ros_common.vessel_attributes_main_engines SET main_engine_id = 1000000 WHERE main_engine_id IN (SELECT id FROM ros_common.engines WHERE unit = 'BHP' AND value = 0.0);
INSERT INTO ros_common.engines(id, unit, value) OVERRIDING SYSTEM VALUE VALUES (1000001, 'HP', 1000.0);
UPDATE ros_common.vessel_attributes_main_engines SET main_engine_id = 1000001 WHERE main_engine_id IN (SELECT id FROM ros_common.engines WHERE unit = 'HP' AND value = 1000.0);
DELETE FROM ros_common.engines WHERE id < 1000000;
INSERT INTO ros_common.engines(id, unit, value) OVERRIDING SYSTEM VALUE VALUES (1, 'BHP', 0.0);
INSERT INTO ros_common.engines(id, unit, value) OVERRIDING SYSTEM VALUE VALUES (2, 'HP', 1000.0);
UPDATE ros_common.vessel_attributes_main_engines SET main_engine_id = main_engine_id - 1000000 + 1;
DELETE FROM ros_common.engines WHERE id >= 1000000;
ALTER TABLE ros_common.vessel_attributes_main_engines ADD CONSTRAINT vsslttrbtsmnngnsmnngnd FOREIGN KEY (main_engine_id) references ros_common.engines (id);
ALTER TABLE ros_common.engines ADD CONSTRAINT uk_engines UNIQUE (unit,value);
