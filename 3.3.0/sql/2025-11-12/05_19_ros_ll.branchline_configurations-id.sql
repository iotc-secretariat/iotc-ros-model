ALTER TABLE ros_ll.branchline_configurations ALTER COLUMN id DROP IDENTITY;
-- remove 2 foreign key(s) from ros_ll.branchline_configurations→id
-- remove the foreign key for ros_ll.branchline_sections→branchline_configuration_id:brnchlnbrnchlncnfgrtnd
ALTER TABLE ros_ll.branchline_sections DROP CONSTRAINT brnchlnbrnchlncnfgrtnd;
-- remove the foreign key for ros_ll.branchline_configurations_storage→branchline_configuration_id:fk_ros_ll_branchline_configurations_storage_configuration
ALTER TABLE ros_ll.branchline_configurations_storage DROP CONSTRAINT fk_ros_ll_branchline_configurations_storage_configuration;
UPDATE ros_ll.branchline_sections SET branchline_configuration_id = 1 WHERE branchline_configuration_id = 8;
UPDATE ros_ll.branchline_sections SET branchline_configuration_id = 2 WHERE branchline_configuration_id = 9;
UPDATE ros_ll.branchline_sections SET branchline_configuration_id = 3 WHERE branchline_configuration_id = 10;
UPDATE ros_ll.branchline_configurations SET id = 1 WHERE id = 8;
UPDATE ros_ll.branchline_configurations SET id = 2 WHERE id = 9;
UPDATE ros_ll.branchline_configurations SET id = 3 WHERE id = 10;
ALTER TABLE ros_ll.branchline_configurations ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;
-- add 2 foreign key(s) from ros_ll.branchline_configurations→id
-- add the foreign key brnchlnbrnchlncnfgrtnd for ros_ll.branchline_sections→branchline_configuration_id:brnchlnbrnchlncnfgrtnd
ALTER TABLE ros_ll.branchline_sections ADD CONSTRAINT brnchlnbrnchlncnfgrtnd FOREIGN KEY (branchline_configuration_id) REFERENCES ros_ll.branchline_configurations(id);
-- add the foreign key fk_ros_ll_branchline_configurations_storage_configuration for ros_ll.branchline_configurations_storage→branchline_configuration_id:fk_ros_ll_branchline_configurations_storage_configuration
ALTER TABLE ros_ll.branchline_configurations_storage ADD CONSTRAINT fk_ros_ll_branchline_configurations_storage_configuration FOREIGN KEY (branchline_configuration_id) REFERENCES ros_ll.branchline_configurations(id);
