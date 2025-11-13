ALTER TABLE ros_ll.tori_line_details ALTER COLUMN id DROP IDENTITY;
-- remove 1 foreign key(s) from ros_ll.tori_line_details→id
-- remove the foreign key for ros_ll.gear_specifications→tori_line_detail_id:llgrspcfctionstrlndtld
ALTER TABLE ros_ll.gear_specifications DROP CONSTRAINT llgrspcfctionstrlndtld;
UPDATE ros_ll.gear_specifications SET tori_line_detail_id = 1 WHERE tori_line_detail_id = 29;
UPDATE ros_ll.gear_specifications SET tori_line_detail_id = 2 WHERE tori_line_detail_id = 30;
UPDATE ros_ll.gear_specifications SET tori_line_detail_id = 3 WHERE tori_line_detail_id = 31;
UPDATE ros_ll.gear_specifications SET tori_line_detail_id = 4 WHERE tori_line_detail_id = 33;
UPDATE ros_ll.gear_specifications SET tori_line_detail_id = 5 WHERE tori_line_detail_id = 35;
UPDATE ros_ll.gear_specifications SET tori_line_detail_id = 6 WHERE tori_line_detail_id = 36;
UPDATE ros_ll.gear_specifications SET tori_line_detail_id = 7 WHERE tori_line_detail_id = 37;
UPDATE ros_ll.gear_specifications SET tori_line_detail_id = 8 WHERE tori_line_detail_id = 38;
UPDATE ros_ll.tori_line_details SET id = 1 WHERE id = 29;
UPDATE ros_ll.tori_line_details SET id = 2 WHERE id = 30;
UPDATE ros_ll.tori_line_details SET id = 3 WHERE id = 31;
UPDATE ros_ll.tori_line_details SET id = 4 WHERE id = 33;
UPDATE ros_ll.tori_line_details SET id = 5 WHERE id = 35;
UPDATE ros_ll.tori_line_details SET id = 6 WHERE id = 36;
UPDATE ros_ll.tori_line_details SET id = 7 WHERE id = 37;
UPDATE ros_ll.tori_line_details SET id = 8 WHERE id = 38;
ALTER TABLE ros_ll.tori_line_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;
-- add 1 foreign key(s) from ros_ll.tori_line_details→id
-- add the foreign key llgrspcfctionstrlndtld for ros_ll.gear_specifications→tori_line_detail_id:llgrspcfctionstrlndtld
ALTER TABLE ros_ll.gear_specifications ADD CONSTRAINT llgrspcfctionstrlndtld FOREIGN KEY (tori_line_detail_id) REFERENCES ros_ll.tori_line_details(id);
