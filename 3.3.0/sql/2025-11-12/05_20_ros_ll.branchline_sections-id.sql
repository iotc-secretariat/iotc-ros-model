ALTER TABLE ros_ll.branchline_sections ALTER COLUMN id DROP IDENTITY;
-- remove 0 foreign key(s) from ros_ll.branchline_sections→id
UPDATE ros_ll.branchline_sections SET id = 1 WHERE id = 18;
UPDATE ros_ll.branchline_sections SET id = 2 WHERE id = 19;
UPDATE ros_ll.branchline_sections SET id = 3 WHERE id = 20;
UPDATE ros_ll.branchline_sections SET id = 4 WHERE id = 21;
UPDATE ros_ll.branchline_sections SET id = 5 WHERE id = 22;
UPDATE ros_ll.branchline_sections SET id = 6 WHERE id = 23;
UPDATE ros_ll.branchline_sections SET id = 7 WHERE id = 24;
ALTER TABLE ros_ll.branchline_sections ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;
-- add 0 foreign key(s) from ros_ll.branchline_sections→id
