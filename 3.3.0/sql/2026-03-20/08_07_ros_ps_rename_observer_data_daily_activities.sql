CREATE TABLE ros_common.trip_daily_activities
(
    trip_id           integer NOT NULL,
    daily_activity_id integer NOT NULL
);

ALTER TABLE ONLY ros_common.trip_daily_activities ADD CONSTRAINT common_trip_daily_activities_pkey PRIMARY KEY (trip_id, daily_activity_id);
ALTER TABLE ONLY ros_common.trip_daily_activities ADD CONSTRAINT fk_common_trip_daily_activities_daily_activity FOREIGN KEY (daily_activity_id) REFERENCES ros_common.daily_activities (id);
ALTER TABLE ONLY ros_common.trip_daily_activities ADD CONSTRAINT fk_common_trip_daily_activities_trip FOREIGN KEY (trip_id) REFERENCES ros_common.trip (id);
CREATE INDEX index_common_trip_daily_activities_daily_activity_id ON ros_common.trip_daily_activities USING btree (daily_activity_id);
CREATE INDEX index_common_trip_daily_activities_trip_id ON ros_common.trip_daily_activities USING btree (trip_id);

INSERT INTO ros_common.trip_daily_activities(trip_id,
                                         daily_activity_id)
SELECT t.id,
       a.daily_activity_id
from ros_ps.observer_data_daily_activities a
         INNER JOIN ros_common.observer_data od on od.original_id = a.observer_data_id
         INNER JOIN ros_common.trip t on od.id = t.observer_data_id;
