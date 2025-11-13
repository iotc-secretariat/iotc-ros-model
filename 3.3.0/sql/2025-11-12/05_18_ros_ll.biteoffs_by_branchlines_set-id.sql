ALTER TABLE ros_ll.biteoffs_by_branchlines_set ALTER COLUMN id DROP IDENTITY;
-- remove 0 foreign key(s) from ros_ll.biteoffs_by_branchlines_set→id
UPDATE ros_ll.biteoffs_by_branchlines_set SET id = 1 WHERE id = 10;
UPDATE ros_ll.biteoffs_by_branchlines_set SET id = 2 WHERE id = 11;
UPDATE ros_ll.biteoffs_by_branchlines_set SET id = 3 WHERE id = 12;
ALTER TABLE ros_ll.biteoffs_by_branchlines_set ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;
-- add 0 foreign key(s) from ros_ll.biteoffs_by_branchlines_set→id
