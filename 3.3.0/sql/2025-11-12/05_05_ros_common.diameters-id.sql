ALTER TABLE ros_common.diameters ALTER COLUMN id DROP IDENTITY;
-- remove 1 foreign key(s) from ros_common.diameters→id
-- remove the foreign key for ros_ll.branchline_sections→diameter_id:brnchlnesectionsdmtrid
ALTER TABLE ros_ll.branchline_sections DROP CONSTRAINT brnchlnesectionsdmtrid;
UPDATE ros_ll.branchline_sections SET diameter_id = 1 WHERE diameter_id = 12;
UPDATE ros_ll.branchline_sections SET diameter_id = 2 WHERE diameter_id = 13;
UPDATE ros_ll.branchline_sections SET diameter_id = 3 WHERE diameter_id = 14;
UPDATE ros_ll.branchline_sections SET diameter_id = 4 WHERE diameter_id = 15;
UPDATE ros_common.diameters SET id = 1 WHERE id = 12;
UPDATE ros_common.diameters SET id = 2 WHERE id = 13;
UPDATE ros_common.diameters SET id = 3 WHERE id = 14;
UPDATE ros_common.diameters SET id = 4 WHERE id = 15;
ALTER TABLE ros_common.diameters ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;
-- add 1 foreign key(s) from ros_common.diameters→id
-- add the foreign key brnchlnesectionsdmtrid for ros_ll.branchline_sections→diameter_id:brnchlnesectionsdmtrid
ALTER TABLE ros_ll.branchline_sections ADD CONSTRAINT brnchlnesectionsdmtrid FOREIGN KEY (diameter_id) REFERENCES ros_common.diameters(id);
