create or replace view ros_views.v_ll_sets(trip_id, trip_uid, set_id, fishing_operation_type, start_time, end_time, grid_1, grid_5, latitude, longitude, effort, total_effort, effort_unit) as
    SELECT o.id                                                                     AS trip_id,
           o.uid                                                                    AS trip_uid,
           so.id                                                                    AS set_id,
           'LL'::text                                                               AS fishing_operation_type,
           COALESCE(ho.start_hauling_date_and_time, so.start_setting_date_and_time) AS start_time,
           COALESCE(ho.end_hauling_date_and_time, so.end_setting_date_and_time)     AS end_time,
           CASE
               WHEN ho.start_hauling_latitude IS NOT NULL AND ho.start_hauling_longitude IS NOT NULL THEN ros_meta.to_grid_1(ho.start_hauling_latitude, ho.start_hauling_longitude)
               WHEN ho.end_hauling_latitude IS NOT NULL AND ho.end_hauling_longitude IS NOT NULL THEN ros_meta.to_grid_1(ho.end_hauling_latitude, ho.end_hauling_longitude)
               WHEN so.start_setting_latitude IS NOT NULL AND so.start_setting_longitude IS NOT NULL THEN ros_meta.to_grid_1(so.start_setting_latitude, so.start_setting_longitude)
               WHEN so.end_setting_latitude IS NOT NULL AND so.end_setting_longitude IS NOT NULL THEN ros_meta.to_grid_1(so.end_setting_latitude, so.end_setting_longitude)
               ELSE NULL::bpchar
               END                                                                  AS grid_1,
           CASE
               WHEN ho.start_hauling_latitude IS NOT NULL AND ho.start_hauling_longitude IS NOT NULL THEN ros_meta.to_grid_5(ho.start_hauling_latitude, ho.start_hauling_longitude)
               WHEN ho.end_hauling_latitude IS NOT NULL AND ho.end_hauling_longitude IS NOT NULL THEN ros_meta.to_grid_5(ho.end_hauling_latitude, ho.end_hauling_longitude)
               WHEN so.start_setting_latitude IS NOT NULL AND so.start_setting_longitude IS NOT NULL THEN ros_meta.to_grid_5(so.start_setting_latitude, so.start_setting_longitude)
               WHEN so.end_setting_latitude IS NOT NULL AND so.end_setting_longitude IS NOT NULL THEN ros_meta.to_grid_5(so.end_setting_latitude, so.end_setting_longitude)
               ELSE NULL::bpchar
               END                                                                  AS grid_5,
           CASE
               WHEN ho.start_hauling_latitude IS NOT NULL AND ho.start_hauling_longitude IS NOT NULL THEN ho.start_hauling_latitude
               WHEN ho.end_hauling_latitude IS NOT NULL AND ho.end_hauling_longitude IS NOT NULL THEN ho.end_hauling_latitude
               WHEN so.start_setting_latitude IS NOT NULL AND so.start_setting_longitude IS NOT NULL THEN so.start_setting_latitude
               WHEN so.end_setting_latitude IS NOT NULL AND so.end_setting_longitude IS NOT NULL THEN so.end_setting_latitude
               ELSE NULL::double precision
               END                                                                  AS latitude,
           CASE
               WHEN ho.start_hauling_latitude IS NOT NULL AND ho.start_hauling_longitude IS NOT NULL THEN ho.start_hauling_longitude
               WHEN ho.end_hauling_latitude IS NOT NULL AND ho.end_hauling_longitude IS NOT NULL THEN ho.end_hauling_longitude
               WHEN so.start_setting_latitude IS NOT NULL AND so.start_setting_longitude IS NOT NULL THEN so.start_setting_longitude
               WHEN so.end_setting_latitude IS NOT NULL AND so.end_setting_longitude IS NOT NULL THEN so.end_setting_longitude
               ELSE NULL::double precision
               END                                                                  AS longitude,
           COALESCE(ho.number_of_hooks_observed, so.total_number_of_hooks_set)      AS effort,
           COALESCE(so.total_number_of_hooks_set, ho.number_of_hooks_observed)      AS total_effort,
           'HK'::text                                                               AS effort_unit
    FROM ros_ll.observer_data o
--              JOIN ros_common.general_vessel_and_trip_information gvt ON o.vessel_and_trip_information_id = gvt.id
             JOIN ros_ll.fishing_events fed ON fed.observer_data_id = o.id
             JOIN ros_ll.setting_operations so ON fed.setting_operation_id = so.id
             LEFT JOIN ros_ll.hauling_operations ho ON fed.hauling_operation_id = ho.id;

create or replace view ros_views.v_ps_sets(trip_id, trip_uid, set_id, fishing_operation_type, start_time, end_time, grid_1, grid_5, latitude, longitude, effort, total_effort, effort_unit) as
    SELECT o.id                                                                      AS trip_id,
           o.uid                                                                     AS trip_uid,
           so.id                                                                     AS set_id,
           'PS'::text                                                                AS fishing_operation_type,
           COALESCE(so.start_setting_date_and_time, so.time_start_brailing)          AS start_time,
           COALESCE(so.time_start_brailing, so.time_net_pursed)                      AS end_time,
           ros_meta.to_grid_1(so.start_setting_latitude, so.start_setting_longitude) AS grid_1,
           ros_meta.to_grid_5(so.start_setting_latitude, so.start_setting_longitude) AS grid_5,
           so.start_setting_latitude                                                 AS latitude,
           so.start_setting_longitude                                                AS longitude,
           1                                                                         AS effort,
           1                                                                         AS total_effort,
           'SETS'::text                                                              AS effort_unit
    FROM ros_ps.observer_data o
--              JOIN ros_common.general_vessel_and_trip_information gvt ON o.vessel_and_trip_information_id = gvt.id
             JOIN ros_ps.fishing_events fed ON fed.observer_data_id = o.id
             LEFT JOIN ros_ps.setting_operations so ON fed.setting_operation_id = so.id;

create or replace view ros_views.v_sets(trip_id, trip_uid, set_id, fishing_operation_type, start_time, end_time, grid_1, grid_5, latitude, longitude, effort, total_effort, effort_unit) as
    SELECT v_ll_sets.trip_id,
           v_ll_sets.trip_uid,
           v_ll_sets.set_id,
           v_ll_sets.fishing_operation_type,
           v_ll_sets.start_time,
           v_ll_sets.end_time,
           v_ll_sets.grid_1,
           v_ll_sets.grid_5,
           v_ll_sets.latitude,
           v_ll_sets.longitude,
           v_ll_sets.effort,
           v_ll_sets.total_effort,
           v_ll_sets.effort_unit
    FROM ros_views.v_ll_sets
    UNION ALL
    SELECT v_ps_sets.trip_id,
           v_ps_sets.trip_uid,
           v_ps_sets.set_id,
           v_ps_sets.fishing_operation_type,
           v_ps_sets.start_time,
           v_ps_sets.end_time,
           v_ps_sets.grid_1,
           v_ps_sets.grid_5,
           v_ps_sets.latitude,
           v_ps_sets.longitude,
           v_ps_sets.effort,
           v_ps_sets.total_effort,
           v_ps_sets.effort_unit
    FROM ros_views.v_ps_sets;




