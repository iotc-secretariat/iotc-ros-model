CREATE VIEW ros_views.v_ps_lw_raw AS
    SELECT 'PS'::text                                        AS operation_type,
           CASE
               WHEN (fa.code ~~ 'R%'::text) THEN 'RC'::text
               WHEN (fa.code ~~ 'D%'::text) THEN 'DI'::text
               ELSE 'UN'::text
               END                                           AS "TYPE",
           s.id                                              AS set_id,
           sp.code                                           AS species_code,
           sp.name_en                                        AS species_name,
           COALESCE(x.code, 'UNK'::bpchar)                   AS sex_code,
           COALESCE(x.name_en, 'Unknown'::character varying) AS sex,
           CASE
               WHEN ((lt.code IS NULL) AND (l.value IS NOT NULL)) THEN 'UNK'::bpchar
               ELSE lt.code
               END                                           AS length_type_code,
           CASE
               WHEN ((lt.name_en IS NULL) AND (l.value IS NOT NULL)) THEN 'Unknown'::character varying
               ELSE lt.name_en
               END                                           AS length_type,
           l.value                                           AS length,
           NULL::text                                        AS additional_length_type_code,
           NULL::text                                        AS additional_length_type,
           NULL::text                                        AS additional_length,
           CASE
               WHEN ((wp.code IS NULL) AND (w.value IS NOT NULL)) THEN 'UNK'::bpchar
               ELSE wp.code
               END                                           AS weight_type_code,
           CASE
               WHEN ((wp.name_en IS NULL) AND (w.value IS NOT NULL)) THEN 'Unknown'::character varying
               ELSE wp.name_en
               END                                           AS weight_type,
           w.value                                           AS weight_value,
           w.unit                                            AS weight_unit
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             JOIN ros_ll.fishing_events fe ON fe.trip_id = t.id
             JOIN ros_ps.setting_operations s ON fe.setting_operation_id = s.id
             JOIN ros_ps.catch_details c ON c.fishing_event_id = fe.id
             JOIN refs_biology.species sp ON c.species_code::text = (sp.code)::text
             LEFT JOIN refs_biology.fates fa ON c.fates_code = fa.code
             JOIN ros_ps.specimens spc ON spc.catch_detail_id = c.id
             JOIN ros_common.biometric_information bs ON spc.biometric_information_id = bs.id
             LEFT JOIN refs_biology.sex x ON bs.sex_code = x.code
             LEFT JOIN ros_common.measured_lengths l ON bs.measured_length_id = l.id
             LEFT JOIN refs_biology.measurements lt ON l.measured_length_type_code = lt.code
             LEFT JOIN ros_common.estimated_weights w ON bs.estimated_weight_id = w.id
             LEFT JOIN refs_fishery.fish_processing_types wp ON w.weight_estimation_method_code = wp.code
    WHERE od.vessel_type_code = 'SP' AND (l.value IS NOT NULL OR w.value IS NOT NULL);

CREATE VIEW ros_views.v_ps_lw AS
    SELECT date_part('year'::text, s.start_setting_date_and_time)                  AS year,
           date_part('month'::text, s.start_setting_date_and_time)                 AS month,
           lw.operation_type                                                       AS gear,
           ros_meta.to_grid_1(s.start_setting_latitude, s.start_setting_longitude) AS grid_1,
           ros_meta.to_grid_5(s.start_setting_latitude, s.start_setting_longitude) AS grid_5,
           lw.species_code,
           lw.species_name,
           lw.sex_code,
           lw."TYPE",
           lw.length_type_code,
           lw.length_type,
           lw.length,
           lw.additional_length_type_code,
           lw.additional_length_type,
           lw.additional_length,
           lw.weight_type_code,
           lw.weight_type,
           lw.weight_value                                                         AS weight,
           lw.weight_unit
    FROM (ros_views.v_ps_lw_raw lw
        JOIN ros_ps.setting_operations s ON ((lw.set_id = s.id)));



CREATE VIEW ros_views.v_alternate_ll_effort_fdays AS
    SELECT 'LL'::text                                                                                         AS gear_code,
           date_part('year'::text, s.start_setting_date_and_time)                                             AS year,
           date_part('month'::text, s.start_setting_date_and_time)                                            AS month,
           s.start_setting_latitude                                                                           AS lat,
           s.start_setting_longitude                                                                          AS lon,
           count(DISTINCT concat(t.uid, '_', date_part('day'::text, s.start_setting_date_and_time))) AS observed_effort,
           'FDAYS'::text                                                                                      AS effort_unit
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             JOIN ros_ll.fishing_events fe ON fe.trip_id = t.id
             JOIN ros_ll.setting_operations s ON fe.setting_operation_id = s.id
    WHERE od.vessel_type_code = 'LL'
    GROUP BY (date_part('year'::text, s.start_setting_date_and_time)), (date_part('month'::text, s.start_setting_date_and_time)), s.start_setting_latitude, s.start_setting_longitude;

CREATE VIEW ros_views.v_alternate_ll_effort_set AS
    SELECT 'LL'::text                                              AS gear_code,
           date_part('year'::text, s.start_setting_date_and_time)  AS year,
           date_part('month'::text, s.start_setting_date_and_time) AS month,
           s.start_setting_latitude                                AS lat,
           s.start_setting_longitude                               AS lon,
           count(t.*)                                              AS observed_effort,
           'SET'::text                                             AS effort_unit
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             JOIN ros_ll.fishing_events fe ON fe.trip_id = t.id
             JOIN ros_ll.setting_operations s ON fe.setting_operation_id = s.id
    WHERE od.vessel_type_code = 'LL'
    GROUP BY (date_part('year'::text, s.start_setting_date_and_time)), (date_part('month'::text, s.start_setting_date_and_time)), s.start_setting_latitude, s.start_setting_longitude;

CREATE VIEW ros_views.v_alternate_ps_effort_fdays AS
    SELECT 'PS'::text                                                                                          AS gear_code,
           date_part('year'::text, s.start_setting_date_and_time)                                              AS year,
           date_part('month'::text, s.start_setting_date_and_time)                                             AS month,
           s.start_setting_latitude                                                                            AS lat,
           s.start_setting_longitude                                                                           AS lon,
           count(DISTINCT concat(t.uid, '_', date_part('day'::text, s.start_setting_date_and_time))) AS observed_effort,
           'FDAYS'::text                                                                                       AS effort_unit
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             JOIN ros_ps.fishing_events fe ON fe.trip_id = t.id
             JOIN ros_ps.setting_operations s ON fe.setting_operation_id = s.id
    WHERE od.vessel_type_code = 'SP'
    GROUP BY (date_part('year'::text, s.start_setting_date_and_time)), (date_part('month'::text, s.start_setting_date_and_time)), s.start_setting_latitude, s.start_setting_longitude;


CREATE VIEW ros_views.v_alternate_ps_effort_set AS
    SELECT 'PS'::text                                              AS gear_code,
           date_part('year'::text, s.start_setting_date_and_time)  AS year,
           date_part('month'::text, s.start_setting_date_and_time) AS month,
           s.start_setting_latitude                                AS lat,
           s.start_setting_longitude                               AS lon,
           count(t.*)                                              AS observed_effort,
           'SET'::text                                             AS effort_unit
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             JOIN ros_ps.fishing_events fe ON fe.trip_id = t.id
             JOIN ros_ps.setting_operations s ON fe.setting_operation_id = s.id
    WHERE od.vessel_type_code = 'SP'
    GROUP BY (date_part('year'::text, s.start_setting_date_and_time)), (date_part('month'::text, s.start_setting_date_and_time)), s.start_setting_latitude, s.start_setting_longitude;


CREATE VIEW ros_views.v_alternate_effort AS
    SELECT v_alternate_ll_effort_set.year,
           v_alternate_ll_effort_set.month,
           v_alternate_ll_effort_set.gear_code            AS gear,
           v_alternate_ll_effort_set.lat,
           v_alternate_ll_effort_set.lon,
           sum(v_alternate_ll_effort_set.observed_effort) AS observed_effort,
           v_alternate_ll_effort_set.effort_unit
    FROM ros_views.v_alternate_ll_effort_set
    GROUP BY v_alternate_ll_effort_set.year, v_alternate_ll_effort_set.month, v_alternate_ll_effort_set.gear_code, v_alternate_ll_effort_set.lat, v_alternate_ll_effort_set.lon, v_alternate_ll_effort_set.effort_unit
    UNION ALL
    SELECT v_alternate_ll_effort_fdays.year,
           v_alternate_ll_effort_fdays.month,
           v_alternate_ll_effort_fdays.gear_code            AS gear,
           v_alternate_ll_effort_fdays.lat,
           v_alternate_ll_effort_fdays.lon,
           sum(v_alternate_ll_effort_fdays.observed_effort) AS observed_effort,
           v_alternate_ll_effort_fdays.effort_unit
    FROM ros_views.v_alternate_ll_effort_fdays
    GROUP BY v_alternate_ll_effort_fdays.year, v_alternate_ll_effort_fdays.month, v_alternate_ll_effort_fdays.gear_code, v_alternate_ll_effort_fdays.lat, v_alternate_ll_effort_fdays.lon, v_alternate_ll_effort_fdays.effort_unit
    UNION ALL
    SELECT v_alternate_ps_effort_set.year,
           v_alternate_ps_effort_set.month,
           v_alternate_ps_effort_set.gear_code            AS gear,
           v_alternate_ps_effort_set.lat,
           v_alternate_ps_effort_set.lon,
           sum(v_alternate_ps_effort_set.observed_effort) AS observed_effort,
           v_alternate_ps_effort_set.effort_unit
    FROM ros_views.v_alternate_ps_effort_set
    GROUP BY v_alternate_ps_effort_set.year, v_alternate_ps_effort_set.month, v_alternate_ps_effort_set.gear_code, v_alternate_ps_effort_set.lat, v_alternate_ps_effort_set.lon, v_alternate_ps_effort_set.effort_unit
    UNION ALL
    SELECT v_alternate_ps_effort_fdays.year,
           v_alternate_ps_effort_fdays.month,
           v_alternate_ps_effort_fdays.gear_code            AS gear,
           v_alternate_ps_effort_fdays.lat,
           v_alternate_ps_effort_fdays.lon,
           sum(v_alternate_ps_effort_fdays.observed_effort) AS observed_effort,
           v_alternate_ps_effort_fdays.effort_unit
    FROM ros_views.v_alternate_ps_effort_fdays
    GROUP BY v_alternate_ps_effort_fdays.year, v_alternate_ps_effort_fdays.month, v_alternate_ps_effort_fdays.gear_code, v_alternate_ps_effort_fdays.lat, v_alternate_ps_effort_fdays.lon, v_alternate_ps_effort_fdays.effort_unit;


create or replace view ros_views.v_ll_sets(trip_id, trip_uid, set_id, fishing_operation_type, start_time, end_time, grid_1, grid_5, latitude, longitude, effort, total_effort, effort_unit) as
    SELECT t.id                                                                     AS trip_id,
           t.uid                                                                     AS trip_id,
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
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             JOIN ros_ll.fishing_events fed ON fed.trip_id = t.id
             JOIN ros_ll.setting_operations so ON fed.setting_operation_id = so.id
             LEFT JOIN ros_ll.hauling_operations ho ON fed.hauling_operation_id = ho.id
    WHERE od.vessel_type_code = 'LL';

create or replace view ros_views.v_ps_sets(trip_id, trip_uid, set_id, fishing_operation_type, start_time, end_time, grid_1, grid_5, latitude, longitude, effort, total_effort, effort_unit) as
    SELECT t.id                                                                      AS trip_id,
           t.uid                                                                      AS trip_uid,
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
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             JOIN ros_ps.fishing_events fed ON fed.trip_id = t.id
             LEFT JOIN ros_ps.setting_operations so ON fed.setting_operation_id = so.id
    WHERE od.vessel_type_code = 'SP';

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




