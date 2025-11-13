ALTER TABLE ros_common.reasons_for_days_lost ALTER COLUMN id DROP IDENTITY;
-- remove 0 foreign key(s) from ros_common.reasons_for_days_lost→id
UPDATE ros_common.reasons_for_days_lost SET id = 1 WHERE id = 9;
UPDATE ros_common.reasons_for_days_lost SET id = 2 WHERE id = 10;
UPDATE ros_common.reasons_for_days_lost SET id = 3 WHERE id = 11;
UPDATE ros_common.reasons_for_days_lost SET id = 4 WHERE id = 12;
UPDATE ros_common.reasons_for_days_lost SET id = 5 WHERE id = 13;
UPDATE ros_common.reasons_for_days_lost SET id = 6 WHERE id = 14;
UPDATE ros_common.reasons_for_days_lost SET id = 7 WHERE id = 15;
UPDATE ros_common.reasons_for_days_lost SET id = 8 WHERE id = 16;
UPDATE ros_common.reasons_for_days_lost SET id = 9 WHERE id = 17;
UPDATE ros_common.reasons_for_days_lost SET id = 10 WHERE id = 18;
UPDATE ros_common.reasons_for_days_lost SET id = 11 WHERE id = 19;
UPDATE ros_common.reasons_for_days_lost SET id = 12 WHERE id = 20;
UPDATE ros_common.reasons_for_days_lost SET id = 13 WHERE id = 21;
UPDATE ros_common.reasons_for_days_lost SET id = 14 WHERE id = 22;
UPDATE ros_common.reasons_for_days_lost SET id = 15 WHERE id = 23;
UPDATE ros_common.reasons_for_days_lost SET id = 16 WHERE id = 24;
UPDATE ros_common.reasons_for_days_lost SET id = 17 WHERE id = 29;
UPDATE ros_common.reasons_for_days_lost SET id = 18 WHERE id = 31;
UPDATE ros_common.reasons_for_days_lost SET id = 19 WHERE id = 32;
ALTER TABLE ros_common.reasons_for_days_lost ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;
-- add 0 foreign key(s) from ros_common.reasons_for_days_lost→id
