ALTER TABLE ros_ll.fishing_events ADD COLUMN trip_id int;
ALTER TABLE ros_ll.fishing_events ADD CONSTRAINT fk_ros_ll_fishing_events_trip FOREIGN KEY (trip_id) REFERENCES ros_common.trip (id);
create index if not exists idx_ros_ll_fishing_events_trip on ros_common.trip (id);
UPDATE ros_ll.fishing_events m
SET trip_id = (SELECT trip.id
               FROM ros_common.trip trip
                        INNER JOIN ros_common.observer_data od on od.id = trip.observer_data_id
                        INNER JOIN ros_ll.observer_data t on od.original_id = t.id
               where m.observer_data_id = t.id
                 AND od.vessel_type_code = 'LL');
ALTER TABLE ros_ll.fishing_events ALTER COLUMN trip_id SET NOT NULL;

ALTER TABLE ros_ps.fishing_events ADD COLUMN trip_id int;
ALTER TABLE ros_ps.fishing_events ADD CONSTRAINT fk_ros_ps_fishing_events_trip FOREIGN KEY (trip_id) REFERENCES ros_common.trip (id);
create index if not exists idx_ros_ps_fishing_events_trip on ros_common.trip (id);
UPDATE ros_ps.fishing_events m
SET trip_id = (SELECT trip.id
               FROM ros_common.trip trip
                        INNER JOIN ros_common.observer_data od on od.id = trip.observer_data_id
                        INNER JOIN ros_ps.observer_data t on od.original_id = t.id
               where m.observer_data_id = t.id
                 AND od.vessel_type_code = 'SP');
ALTER TABLE ros_ps.fishing_events ALTER COLUMN trip_id SET NOT NULL;

ALTER TABLE ros_gn.fishing_events ADD COLUMN trip_id int;
ALTER TABLE ros_gn.fishing_events ADD CONSTRAINT fk_ros_gn_fishing_events_trip FOREIGN KEY (trip_id) REFERENCES ros_common.trip (id);
create index if not exists idx_ros_gn_fishing_events_trip on ros_common.trip (id);
UPDATE ros_gn.fishing_events m
SET trip_id = (SELECT trip.id
               FROM ros_common.trip trip
                        INNER JOIN ros_common.observer_data od on od.id = trip.observer_data_id
                        INNER JOIN ros_ll.observer_data t on od.original_id = t.id
               where m.observer_data_id = t.id
                 AND od.vessel_type_code = 'GO');
ALTER TABLE ros_gn.fishing_events ALTER COLUMN trip_id SET NOT NULL;

ALTER TABLE ros_pl.tuna_fishing_events ADD COLUMN trip_id int;
ALTER TABLE ros_pl.tuna_fishing_events ADD CONSTRAINT fk_ros_pl_tuna_fishing_events_trip FOREIGN KEY (trip_id) REFERENCES ros_common.trip (id);
create index if not exists idx_ros_pl_tuna_fishing_events_trip on ros_common.trip (id);
UPDATE ros_pl.tuna_fishing_events m
SET trip_id = (SELECT trip.id
               FROM ros_common.trip trip
                        INNER JOIN ros_common.observer_data od on od.id = trip.observer_data_id
                        INNER JOIN ros_pl.observer_data t on od.original_id = t.id
               where m.observer_data_id = t.id
                 AND od.vessel_type_code = 'LP');
ALTER TABLE ros_pl.tuna_fishing_events ALTER COLUMN trip_id SET NOT NULL;

ALTER TABLE ros_pl.bait_fishing_events ADD COLUMN trip_id int;
ALTER TABLE ros_pl.bait_fishing_events ADD CONSTRAINT fk_ros_pl_bait_fishing_events_trip FOREIGN KEY (trip_id) REFERENCES ros_common.trip (id);
create index if not exists idx_ros_pl_bait_fishing_events_trip on ros_common.trip (id);
UPDATE ros_pl.bait_fishing_events m
SET trip_id = (SELECT trip.id
               FROM ros_common.trip trip
                        INNER JOIN ros_common.observer_data od on od.id = trip.observer_data_id
                        INNER JOIN ros_pl.observer_data t on od.original_id = t.id
               where m.observer_data_id = t.id
                 AND od.vessel_type_code = 'LP');
ALTER TABLE ros_pl.bait_fishing_events ALTER COLUMN trip_id SET NOT NULL;