drop table ros_common.vessel_licensed_target_species;
drop table ros_common.vessel;

ALTER TABLE ros_meta.observer DROP COLUMN accreditation_year;
ALTER TABLE ros_meta.observer DROP COLUMN accredited_by;
ALTER TABLE ros_meta.observer DROP COLUMN deregistered_date;