drop table ros_ll.observer_data_properties;
drop table ros_pl.observer_data_properties;
drop table ros_pl.observer_data_daily_activities;
drop  table ros_ps.observer_data_properties;
drop  table ros_ps.observer_data_daily_activities;
drop  table ros_gn.observer_data_properties;
ALTER TABLE ros_ll.fishing_events DROP COLUMN observer_data_id;
ALTER TABLE ros_ps.fishing_events DROP COLUMN observer_data_id;
ALTER TABLE ros_gn.fishing_events DROP COLUMN observer_data_id;
ALTER TABLE ros_pl.tuna_fishing_events DROP COLUMN observer_data_id;
ALTER TABLE ros_pl.bait_fishing_events DROP COLUMN observer_data_id;
drop table ros_ll.observer_data;
drop table ros_pl.observer_data;
drop  table ros_ps.observer_data;
drop  table ros_gn.observer_data;
ALTER TABLE ros_common.observer_data DROP COLUMN original_id;

