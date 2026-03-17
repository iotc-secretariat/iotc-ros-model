ALTER TABLE ros_ll.gear_specifications ADD COLUMN trip_id int;
ALTER TABLE ros_ll.gear_specifications ADD CONSTRAINT fk_ros_ll_gear_specifications_trip FOREIGN KEY (trip_id) REFERENCES ros_common.trip (id);
create index if not exists idx_ros_ll_gear_specifications_trip on ros_common.trip (id);
UPDATE ros_ll.gear_specifications m
SET trip_id = (SELECT trip.id
               FROM ros_common.trip trip
                        INNER JOIN ros_common.observer_data od on od.id = trip.observer_data_id
                        INNER JOIN ros_ll.observer_data t on od.original_id = t.id
               where m.id = t.gear_specifications_id
                 AND od.vessel_type_code = 'LL');
ALTER TABLE ros_ll.gear_specifications ALTER COLUMN trip_id SET NOT NULL;

ALTER TABLE ros_ps.gear_specifications ADD COLUMN trip_id int;
ALTER TABLE ros_ps.gear_specifications ADD CONSTRAINT fk_ros_ps_gear_specifications_trip FOREIGN KEY (trip_id) REFERENCES ros_common.trip (id);
create index if not exists idx_ros_ps_gear_specifications_trip on ros_common.trip (id);
UPDATE ros_ps.gear_specifications m
SET trip_id = (SELECT trip.id
               FROM ros_common.trip trip
                        INNER JOIN ros_common.observer_data od on od.id = trip.observer_data_id
                        INNER JOIN ros_ps.observer_data t on od.original_id = t.id
               where m.id = t.gear_specifications_id
                 AND od.vessel_type_code = 'SP');
ALTER TABLE ros_ps.gear_specifications ALTER COLUMN trip_id SET NOT NULL;

ALTER TABLE ros_gn.gear_specifications ADD COLUMN trip_id int;
ALTER TABLE ros_gn.gear_specifications ADD CONSTRAINT fk_ros_gn_gear_specifications_trip FOREIGN KEY (trip_id) REFERENCES ros_common.trip (id);
create index if not exists idx_ros_gn_gear_specifications_trip on ros_common.trip (id);
UPDATE ros_gn.gear_specifications m
SET trip_id = (SELECT trip.id
               FROM ros_common.trip trip
                        INNER JOIN ros_common.observer_data od on od.id = trip.observer_data_id
                        INNER JOIN ros_ll.observer_data t on od.original_id = t.id
               where m.id = t.gear_specifications_id
                 AND od.vessel_type_code = 'GO');
ALTER TABLE ros_gn.gear_specifications ALTER COLUMN trip_id SET NOT NULL;

ALTER TABLE ros_pl.gear_specifications ADD COLUMN trip_id int;
ALTER TABLE ros_pl.gear_specifications ADD CONSTRAINT fk_ros_pl_gear_specifications_trip FOREIGN KEY (trip_id) REFERENCES ros_common.trip (id);
create index if not exists idx_ros_pl_gear_specifications_trip on ros_common.trip (id);
UPDATE ros_pl.gear_specifications m
SET trip_id = (SELECT trip.id
               FROM ros_common.trip trip
                        INNER JOIN ros_common.observer_data od on od.id = trip.observer_data_id
                        INNER JOIN ros_pl.observer_data t on od.original_id = t.id
               where m.id = t.gear_specifications_id
                 AND od.vessel_type_code = 'LP');
ALTER TABLE ros_pl.gear_specifications ALTER COLUMN trip_id SET NOT NULL;