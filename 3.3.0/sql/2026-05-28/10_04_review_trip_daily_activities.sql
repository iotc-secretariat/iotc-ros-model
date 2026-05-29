ALTER TABLE ros_common.trip_daily_activities ADD COLUMN id INTEGER GENERATED ALWAYS AS IDENTITY;
ALTER TABLE ros_common.trip_daily_activities ADD COLUMN date TIMESTAMP(3);
ALTER TABLE ros_common.trip_daily_activities DROP CONSTRAINT common_trip_daily_activities_pkey;
ALTER TABLE ros_common.trip_daily_activities ADD CONSTRAINT common_trip_daily_activities_pkey PRIMARY KEY (id);
ALTER TABLE ros_common.trip_daily_activities DROP COLUMN daily_activity_id;

create table if not exists ros_common.trip_daily_activity_details
(
    id                     INTEGER GENERATED ALWAYS AS IDENTITY,
    comments               TEXT,
    time_of_day            TIMESTAMP(3),
    latitude               DOUBLE PRECISION,
    longitude              DOUBLE PRECISION,
    activity_code          CHAR(2),
    trip_daily_activity_id INTEGER NOT NULL
);

ALTER TABLE ros_common.trip_daily_activity_details ADD PRIMARY KEY (id);
ALTER TABLE ros_common.trip_daily_activity_details add CONSTRAINT fk_ros_common_trip_daily_activity_details_activity_code FOREIGN KEY (activity_code) REFERENCES refs_biology.bait_conditions(code);
ALTER TABLE ros_common.trip_daily_activity_details add CONSTRAINT fk_common_trip_daily_activity_details_trip_daily_activity_id FOREIGN KEY (trip_daily_activity_id) REFERENCES ros_common.trip_daily_activities(id);
