alter table ros_ll.observer_data DROP COLUMN vessel_and_trip_information_id;
alter table ros_pl.observer_data DROP COLUMN vessel_and_trip_information_id;
alter table ros_ps.observer_data DROP COLUMN vessel_and_trip_information_id;
alter table ros_gn.observer_data DROP COLUMN vessel_and_trip_information_id;
alter table ros_common.reasons_for_days_lost DROP COLUMN observed_trip_summary_id;

drop table ros_common.vessel_attributes_fish_preservation_method;
drop table ros_common.vessel_attributes_fish_storage_type;
drop table ros_common.vessel_attributes_main_engines;
drop table ros_common.waste_managements;

drop table ros_common.general_vessel_and_trip_information;
drop table ros_common.observer_trip_details;
drop table ros_common.vessel_owner_and_personnel;
drop table ros_common.vessel_attributes;
drop table ros_common.vessel_trip_details;
drop table ros_common.observed_trip_summary;
