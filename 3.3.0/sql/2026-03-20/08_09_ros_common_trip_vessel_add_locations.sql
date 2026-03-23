ALTER TABLE ros_common.trip_vessel ADD COLUMN departure_location INTEGER;
ALTER TABLE ros_common.trip_vessel ADD CONSTRAINT fk_ros_common_trip_vessel_departure_location FOREIGN KEY (departure_location) REFERENCES ros_common.locations (id);
CREATE INDEX IF NOT EXISTS idx_ros_common_trip_vessel_departure_location ON ros_common.trip_vessel (departure_location);
ALTER TABLE ros_common.trip_vessel ADD COLUMN return_location INTEGER;
ALTER TABLE ros_common.trip_vessel ADD CONSTRAINT fk_ros_common_trip_vessel_return_location FOREIGN KEY (return_location) REFERENCES ros_common.locations (id);
CREATE INDEX IF NOT EXISTS idx_ros_common_trip_vessel_return_location ON ros_common.trip_vessel (return_location);

select setval('ros_common.locations_id_seq', (SELECT MAX(id) from ros_common.locations));

DROP FUNCTION IF EXISTS public.fix_trip_vessel_locations();
CREATE FUNCTION public.fix_trip_vessel_locations() RETURNS void
    LANGUAGE plpgsql
AS
$$
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN
        SELECT t.trip_id             AS mv_id,
               t.departure_port_code AS mv_port_code
        FROM ros_common.trip_vessel t
        WHERE t.departure_port_code IS NOT NULL
        ORDER BY t.trip_id
        LOOP
            RAISE NOTICE 'Insert departure location on trip % for port code %...',
                rec.mv_id,
                rec.mv_port_code;
            INSERT INTO ros_common.locations(port_code) VALUES (rec.mv_port_code);
            UPDATE ros_common.trip_vessel SET departure_location = (SELECT max(id) FROM ros_common.locations) WHERE trip_id = rec.mv_id;
        END LOOP;
    FOR rec IN
        SELECT t.trip_id             AS mv_id,
               t.return_port_code AS mv_port_code
        FROM ros_common.trip_vessel t
        WHERE t.return_port_code IS NOT NULL
        ORDER BY t.trip_id
        LOOP

            RAISE NOTICE 'Insert return_port_code location on trip % for port code %...',
                rec.mv_id,
                rec.mv_port_code;
            INSERT INTO ros_common.locations(port_code) VALUES (rec.mv_port_code);
            UPDATE ros_common.trip_vessel SET return_location = (SELECT max(id) FROM ros_common.locations) WHERE trip_id = rec.mv_id;
        END LOOP;

END;
$$;

select fix_trip_vessel_locations();
DROP FUNCTION IF EXISTS public.fix_trip_vessel_locations();

ALTER TABLE ros_common.trip_vessel RENAME date_time_vessel_sailed TO departure_timestamp;
ALTER TABLE ros_common.trip_vessel RENAME date_time_vessel_returned_to_port TO return_timestamp;
