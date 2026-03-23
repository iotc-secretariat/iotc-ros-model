create view ros_meta.v_ps_sets
            (trip_id, trip_uid, set_id, fishing_operation_type, start_time, end_time, grid_1, grid_5, effort,
             total_effort, effort_unit)
as
    SELECT t.id                                                                      AS trip_id,
           t.uid                                                                     AS trip_uid,
           so.id                                                                     AS set_id,
           'PS'::text                                                                AS fishing_operation_type,
           COALESCE(so.start_setting_date_and_time, so.time_start_brailing)          AS start_time,
           COALESCE(so.time_start_brailing, so.time_net_pursed)                      AS end_time,
           ros_meta.to_grid_1(so.start_setting_latitude, so.start_setting_longitude) AS grid_1,
           ros_meta.to_grid_5(so.start_setting_latitude, so.start_setting_longitude) AS grid_5,
           1                                                                         AS effort,
           1                                                                         AS total_effort,
           'SETS'::text                                                              AS effort_unit
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             JOIN ros_ps.fishing_events fed ON fed.trip_id = t.id
             LEFT JOIN ros_ps.setting_operations so ON fed.setting_operation_id = so.id
    WHERE od.vessel_type_code = 'SP';

create view ros_meta.v_ll_sets
            (trip_id, trip_uid, set_id, fishing_operation_type, start_time, end_time, grid_1, grid_5, effort,
             total_effort, effort_unit)
as
    SELECT t.id                                                                     AS trip_id,
           t.uid                                                                    AS trip_uid,
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
           1                                                                        AS effort,
           1                                                                        AS total_effort,
           'SETS'::text                                                             AS effort_unit
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             JOIN ros_ll.fishing_events fed ON fed.trip_id = t.id
             JOIN ros_ll.setting_operations so ON fed.setting_operation_id = so.id
             LEFT JOIN ros_ll.hauling_operations ho ON fed.hauling_operation_id = ho.id
    WHERE od.vessel_type_code = 'LL';

create view ros_meta.v_sets
            (trip_id, trip_uid, set_id, fishing_operation_type, start_time, end_time, grid_1, grid_5, effort,
             total_effort, effort_unit)
as
    SELECT v_ll_sets.trip_id,
           v_ll_sets.trip_uid,
           v_ll_sets.set_id,
           v_ll_sets.fishing_operation_type,
           v_ll_sets.start_time,
           v_ll_sets.end_time,
           v_ll_sets.grid_1,
           v_ll_sets.grid_5,
           v_ll_sets.effort,
           v_ll_sets.total_effort,
           v_ll_sets.effort_unit
    FROM ros_meta.v_ll_sets
    UNION ALL
    SELECT v_ps_sets.trip_id,
           v_ps_sets.trip_uid,
           v_ps_sets.set_id,
           v_ps_sets.fishing_operation_type,
           v_ps_sets.start_time,
           v_ps_sets.end_time,
           v_ps_sets.grid_1,
           v_ps_sets.grid_5,
           v_ps_sets.effort,
           v_ps_sets.total_effort,
           v_ps_sets.effort_unit
    FROM ros_meta.v_ps_sets;

create view ros_meta.v_ps_fdays
    (trip_id, trip_uid, fishing_operation_type, year, month, grid_1, grid_5, effort, effort_unit) as
    SELECT t.id                                                                                                                                        AS trip_id,
           t.uid                                                                                                                                       AS trip_uid,
           'PS'::text                                                                                                                                  AS fishing_operation_type,
           date_part('year'::text, s.start_setting_date_and_time)                                                                                      AS year,
           date_part('month'::text, s.start_setting_date_and_time)                                                                                     AS month,
           ros_meta.to_grid_1(s.start_setting_latitude, s.start_setting_longitude)                                                                     AS grid_1,
           ros_meta.to_grid_5(s.start_setting_latitude, s.start_setting_longitude)                                                                     AS grid_5,
           count(DISTINCT concat(date_part('month'::text, s.start_setting_date_and_time), '/', date_part('day'::text, s.start_setting_date_and_time))) AS effort,
           'FDAYS'::text                                                                                                                               AS effort_unit
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             JOIN ros_ps.fishing_events fe ON fe.trip_id = t.id
             JOIN ros_ps.setting_operations s ON fe.setting_operation_id = s.id
    WHERE od.vessel_type_code = 'PS'
    GROUP BY t.id, t.uid, (date_part('year'::text, s.start_setting_date_and_time)), (date_part('month'::text, s.start_setting_date_and_time)), (ros_meta.to_grid_1(s.start_setting_latitude, s.start_setting_longitude)),
             (ros_meta.to_grid_5(s.start_setting_latitude, s.start_setting_longitude));


create view ros_meta.v_ll_fdays
    (trip_id, trip_uid, fishing_operation_type, year, month, grid_1, grid_5, effort, effort_unit) as
    SELECT t.id                                                                                                                                        AS trip_id,
           t.uid                                                                                                                                       AS trip_uid,
           'LL'::text                                                                                                                                  AS fishing_operation_type,
           date_part('year'::text, s.start_setting_date_and_time)                                                                                      AS year,
           date_part('month'::text, s.start_setting_date_and_time)                                                                                     AS month,
           ros_meta.to_grid_1(s.start_setting_latitude, s.end_setting_latitude)                                                                        AS grid_1,
           ros_meta.to_grid_5(s.start_setting_latitude, s.end_setting_latitude)                                                                        AS grid_5,
           count(DISTINCT concat(date_part('month'::text, s.start_setting_date_and_time), '/', date_part('day'::text, s.start_setting_date_and_time))) AS effort,
           'FDAYS'::text                                                                                                                               AS effort_unit
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             JOIN ros_ll.fishing_events fe ON fe.trip_id = t.id
             JOIN ros_ll.setting_operations s ON fe.setting_operation_id = s.id
    WHERE od.vessel_type_code = 'LL'
    GROUP BY t.id, t.uid, (date_part('year'::text, s.start_setting_date_and_time)), (date_part('month'::text, s.start_setting_date_and_time)), (ros_meta.to_grid_1(s.start_setting_latitude, s.end_setting_latitude)),
             (ros_meta.to_grid_5(s.start_setting_latitude, s.end_setting_latitude));

create view ros_meta.v_fdays
    (trip_id, trip_uid, fishing_operation_type, year, month, grid_1, grid_5, effort, effort_unit) as
    SELECT v_ps_fdays.trip_id,
           v_ps_fdays.trip_uid,
           v_ps_fdays.fishing_operation_type,
           v_ps_fdays.year,
           v_ps_fdays.month,
           v_ps_fdays.grid_1,
           v_ps_fdays.grid_5,
           v_ps_fdays.effort,
           v_ps_fdays.effort_unit
    FROM ros_meta.v_ps_fdays
    UNION ALL
    SELECT v_ll_fdays.trip_id,
           v_ll_fdays.trip_uid,
           v_ll_fdays.fishing_operation_type,
           v_ll_fdays.year,
           v_ll_fdays.month,
           v_ll_fdays.grid_1,
           v_ll_fdays.grid_5,
           v_ll_fdays.effort,
           v_ll_fdays.effort_unit
    FROM ros_meta.v_ll_fdays;

create view ros_meta.v_ll_hooks
            (trip_id, trip_uid, set_id, fishing_operation_type, start_time, end_time, grid_1, grid_5, effort,
             total_effort, effort_unit)
as
    SELECT t.id                                                                     AS trip_id,
           t.uid                                                                    AS trip_uid,
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
           COALESCE(ho.number_of_hooks_observed, so.total_number_of_hooks_set)      AS effort,
           COALESCE(so.total_number_of_hooks_set, ho.number_of_hooks_observed)      AS total_effort,
           'HOOKS'::text                                                            AS effort_unit
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             JOIN ros_ll.fishing_events fed ON fed.trip_id = t.id
             JOIN ros_ll.setting_operations so ON fed.setting_operation_id = so.id
             LEFT JOIN ros_ll.hauling_operations ho ON fed.hauling_operation_id = ho.id
    WHERE od.vessel_type_code = 'LL';

create view ros_meta.v_efforts_m (year, month, grid_1, grid_5, fishing_operation_type, effort, effort_unit) as
    SELECT date_part('year'::text, v_sets.start_time)  AS year,
           date_part('month'::text, v_sets.start_time) AS month,
           v_sets.grid_1,
           v_sets.grid_5,
           v_sets.fishing_operation_type,
           sum(v_sets.effort)                          AS effort,
           v_sets.effort_unit
    FROM ros_meta.v_sets
    GROUP BY (date_part('year'::text, v_sets.start_time)), (date_part('month'::text, v_sets.start_time)), v_sets.grid_1, v_sets.grid_5, v_sets.fishing_operation_type, v_sets.effort_unit
    UNION ALL
    SELECT v_fdays.year,
           v_fdays.month,
           v_fdays.grid_1,
           v_fdays.grid_5,
           v_fdays.fishing_operation_type,
           sum(v_fdays.effort) AS effort,
           v_fdays.effort_unit
    FROM ros_meta.v_fdays
    GROUP BY v_fdays.year, v_fdays.month, v_fdays.grid_1, v_fdays.grid_5, v_fdays.fishing_operation_type, v_fdays.effort_unit
    UNION ALL
    SELECT date_part('year'::text, v_ll_hooks.start_time)  AS year,
           date_part('month'::text, v_ll_hooks.start_time) AS month,
           v_ll_hooks.grid_1,
           v_ll_hooks.grid_5,
           v_ll_hooks.fishing_operation_type,
           sum(v_ll_hooks.effort)                          AS effort,
           v_ll_hooks.effort_unit
    FROM ros_meta.v_ll_hooks
    GROUP BY (date_part('year'::text, v_ll_hooks.start_time)), (date_part('month'::text, v_ll_hooks.start_time)), v_ll_hooks.grid_1, v_ll_hooks.grid_5, v_ll_hooks.fishing_operation_type, v_ll_hooks.effort_unit;

create view ros_meta.v_ll_catches
            (trip_id, trip_uid, set_id, set_number, fishing_operation_type, species, "TYPE", fate, quantity,
             quantity_sampled, unit)
as
    SELECT t.id                 AS trip_id,
           t.uid                AS trip_uid,
           fe.id                AS set_id,
           fe.event_original_id AS set_number,
           'LL'::text           AS fishing_operation_type,
           sp.code              AS species,
           'RC'::text           AS "TYPE",
           CASE
               WHEN f.code IS NULL THEN NULL::text
               ELSE concat(f.code, ' - ', f.name_en)
               END              AS fate,
           count(cd.id)         AS quantity,
           count(cd.id)         AS quantity_sampled,
           'NO'::text           AS unit
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             JOIN ros_ll.fishing_events fe ON fe.trip_id = t.id
             JOIN ros_ll.setting_operations s ON fe.setting_operation_id = s.id
             JOIN ros_ll.catch_details cd ON cd.fishing_event_id = fe.id
             JOIN refs_biology.species sp ON cd.species_code::text = sp.code::text
             LEFT JOIN refs_biology.fates f ON cd.fates_code = f.code
    WHERE od.vessel_type_code = 'LL'
      AND f.code ~~ 'R%'::text
    GROUP BY t.id, t.uid, fe.id, fe.event_original_id, sp.code,
             (
                 CASE
                     WHEN f.code IS NULL THEN NULL::text
                     ELSE concat(f.code, ' - ', f.name_en)
                     END);


create view ros_meta.v_ps_length_weight
            (flag_code, flag, year, month, lat, lon, operation_type, "TYPE", set_id, species_code, species_name,
             sex_code, sex, length_type_code, length_type, length, additional_length_type_code, additional_length_type,
             additional_length, weight_type_code, weight_type, weight_value, weight_unit)
as
    WITH ps_length_weight AS (SELECT 'PS'::text                                        AS operation_type,
                                     CASE
                                         WHEN f.code ~~ 'R%'::text THEN 'RC'::text
                                         ELSE 'DI'::text
                                         END                                           AS "TYPE",
                                     s.id                                              AS set_id,
                                     sp.code                                           AS species_code,
                                     sp.name_en                                        AS species_name,
                                     COALESCE(x.code, 'UNK'::bpchar)                   AS sex_code,
                                     COALESCE(x.name_en, 'Unknown'::character varying) AS sex,
                                     CASE
                                         WHEN lt.code IS NULL AND l.value IS NOT NULL THEN 'UNK'::bpchar
                                         ELSE lt.code
                                         END                                           AS length_type_code,
                                     CASE
                                         WHEN lt.name_en IS NULL AND l.value IS NOT NULL THEN 'Unknown'::character varying
                                         ELSE lt.name_en
                                         END                                           AS length_type,
                                     l.value                                           AS length,
                                     CASE
                                         WHEN alt.code IS NULL AND al.value IS NOT NULL THEN 'UNK'::bpchar
                                         ELSE alt.code
                                         END::character varying(16)                    AS additional_length_type_code,
                                     CASE
                                         WHEN alt.name_en IS NULL AND al.value IS NOT NULL THEN 'Unknown'::character varying
                                         ELSE alt.name_en
                                         END::character varying(255)                   AS additional_length_type,
                                     al.value                                          AS additional_length,
                                     CASE
                                         WHEN wp.code IS NULL AND w.value IS NOT NULL THEN 'UNK'::bpchar
                                         ELSE wp.code
                                         END                                           AS weight_type_code,
                                     CASE
                                         WHEN wp.name_en IS NULL AND w.value IS NOT NULL THEN 'Unknown'::character varying
                                         ELSE wp.name_en
                                         END                                           AS weight_type,
                                     w.value                                           AS weight_value,
                                     w.unit                                            AS weight_unit
                              FROM ros_ps.fishing_events fe_1
                                       JOIN ros_ps.setting_operations s ON fe_1.setting_operation_id = s.id
                                       JOIN ros_ps.catch_details c_1 ON c_1.fishing_event_id = s.id
                                       JOIN refs_biology.species sp ON c_1.species_code::text = sp.code::text
                                       JOIN refs_biology.fates f ON c_1.fates_code = f.code
                                       JOIN ros_ps.specimens spc ON spc.catch_detail_id = c_1.id
                                       LEFT JOIN ros_common.biometric_information b ON spc.biometric_information_id = b.id
                                       LEFT JOIN refs_biology.sex x ON b.sex_code = x.code
                                       LEFT JOIN ros_common.measured_lengths l ON b.measured_length_id = l.id
                                       LEFT JOIN refs_biology.measurements lt ON l.measured_length_type_code = lt.code
                                       LEFT JOIN ros_common.measured_lengths al ON b.alternative_measured_length_id = al.id
                                       LEFT JOIN refs_biology.measurements alt ON al.measured_length_type_code = alt.code
                                       LEFT JOIN ros_common.estimated_weights w ON b.estimated_weight_id = w.id
                                       LEFT JOIN refs_fishery.fish_processing_types wp ON w.weight_estimation_method_code = wp.code
                              WHERE l.value IS NOT NULL
                                 OR al.value IS NOT NULL
                                 OR w.value IS NOT NULL)
    SELECT c.code                                                   AS flag_code,
           c.name_en                                                AS flag,
           date_part('year'::text, so.start_setting_date_and_time)  AS year,
           date_part('month'::text, so.start_setting_date_and_time) AS month,
           so.start_setting_latitude                                AS lat,
           so.start_setting_longitude                               AS lon,
           lw.operation_type,
           lw."TYPE",
           lw.set_id,
           lw.species_code,
           lw.species_name,
           lw.sex_code,
           lw.sex,
           lw.length_type_code,
           lw.length_type,
           lw.length,
           lw.additional_length_type_code,
           lw.additional_length_type,
           lw.additional_length,
           lw.weight_type_code,
           lw.weight_type,
           lw.weight_value,
           lw.weight_unit
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             JOIN ros_common.trip_vessel gvt ON t.id = gvt.trip_id
             LEFT JOIN ros_common.vessel vi ON gvt.vessel_id = vi.id
             LEFT JOIN refs_admin.countries c ON vi.flag_code = c.code
             JOIN ros_ps.fishing_events fe ON fe.trip_id = t.id
             JOIN ros_ps.setting_operations so ON fe.setting_operation_id = so.id
             JOIN ps_length_weight lw ON lw.set_id = so.id
    WHERE od.vessel_type_code = 'SP';

create view ros_meta.v_ps_sf
    (operation_type, year, month, grid_1, grid_5, "TYPE", species_code, sex_code, length_type, length, num) as
    SELECT 'PS'::text                                                                AS operation_type,
           date_part('year'::text, so.start_setting_date_and_time)                   AS year,
           date_part('month'::text, so.start_setting_date_and_time)                  AS month,
           ros_meta.to_grid_1(so.start_setting_latitude, so.start_setting_longitude) AS grid_1,
           ros_meta.to_grid_5(so.start_setting_latitude, so.start_setting_longitude) AS grid_5,
           CASE
               WHEN f.code ~~ 'R%'::text THEN 'RC'::text
               ELSE 'DI'::text
               END                                                                   AS "TYPE",
           s.code                                                                    AS species_code,
           COALESCE(x.code, 'UNK'::bpchar)                                           AS sex_code,
           COALESCE(lt.code, 'UNK'::bpchar)                                          AS length_type,
           l.value                                                                   AS length,
           count(*)                                                                  AS num
    FROM ros_ps.fishing_events fe
             JOIN ros_ps.setting_operations so ON fe.setting_operation_id = so.id
             JOIN ros_ps.catch_details c ON c.fishing_event_id = fe.id
             JOIN refs_biology.species s ON c.species_code::text = s.code::text
             JOIN refs_biology.fates f ON c.fates_code = f.code
             JOIN ros_ps.specimens sp ON sp.catch_detail_id = c.id
             JOIN ros_common.biometric_information b ON sp.biometric_information_id = b.id
             JOIN ros_common.measured_lengths l ON b.measured_length_id = l.id
             LEFT JOIN refs_biology.measurements lt ON l.measured_length_type_code = lt.code
             LEFT JOIN refs_biology.sex x ON b.sex_code = x.code
    GROUP BY (date_part('year'::text, so.start_setting_date_and_time)), (date_part('month'::text, so.start_setting_date_and_time)), (ros_meta.to_grid_1(so.start_setting_latitude, so.start_setting_longitude)),
             (ros_meta.to_grid_5(so.start_setting_latitude, so.start_setting_longitude)),
             (
                 CASE
                     WHEN f.code ~~ 'R%'::text THEN 'RC'::text
                     ELSE 'DI'::text
                     END), s.code, x.code, lt.code, l.value;

create view ros_meta.v_ps_trips
            (source, trip_id, trip_uid, trip_number, creation_date, finalization_date, submission_date,
             has_observer_trip_info, fishing_operation_type, observer_iotc_number, observer_imbarcation_date,
             observer_disembarcation_date, vessel_info_id, vessel_iotc_number, main_gear, reporting_flag, vessel_flag,
             vessel_departure_date, vessel_departure_port, vessel_departure_country, vessel_return_date,
             vessel_return_port, vessel_return_country)
as
    SELECT od.source,
           t.id                         AS trip_id,
           t.uid                        AS trip_uid,
           t.trip_original_id           AS trip_number,
           od.creation_time             AS creation_date,
           od.finalization_time         AS finalization_date,
           od.submission_time           AS submission_date,
           CASE
               WHEN otd.trip_id IS NULL THEN 0
               ELSE 1
               END                      AS has_observer_trip_info,
           'PL'::text                   AS fishing_operation_type,
           oi.iotc_observer_identifier  AS observer_iotc_number,
           otd.date_time_embarkation    AS observer_imbarcation_date,
           otd.date_time_disembarkation AS observer_disembarcation_date,
           vi.id                        AS vessel_info_id,
           vi.iotc_vessel_identifier    AS vessel_iotc_number,
           g.code                       AS main_gear,
           r.code                       AS reporting_flag,
           f.code                       AS vessel_flag,
           gvt.departure_timestamp      AS vessel_departure_date,
           pd.name_en                   AS vessel_departure_port,
           cd.code                      AS vessel_departure_country,
           gvt.return_timestamp         AS vessel_return_date,
           pr.name_en                   AS vessel_return_port,
           cr.code                      AS vessel_return_country
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             LEFT JOIN ros_common.trip_vessel gvt ON t.id = gvt.trip_id
             LEFT JOIN ros_common.locations tvdl ON tvdl.id = gvt.departure_location
             LEFT JOIN ros_common.locations tvrl ON tvdl.id = gvt.return_location
             LEFT JOIN ros_common.trip_observer otd ON t.id = otd.trip_id
             LEFT JOIN ros_common.observer oi ON otd.observer_id = oi.contact_id
             LEFT JOIN ros_common.vessel vi ON gvt.vessel_id = vi.id
             LEFT JOIN refs_fishery_config.gears g ON vi.main_fishing_gear_code::text = g.code::text
             LEFT JOIN refs_admin.countries f ON vi.flag_code = f.code
             LEFT JOIN refs_admin.countries r ON od.reporting_country_code = r.code
             LEFT JOIN refs_admin.ports pd ON tvdl.port_code::text = pd.code::text
             LEFT JOIN refs_admin.countries cd ON pd.country_code::bpchar = cd.code
             LEFT JOIN refs_admin.ports pr ON tvrl.port_code::text = pr.code::text
             LEFT JOIN refs_admin.countries cr ON pr.country_code::bpchar = cr.code
    WHERE od.vessel_type_code = 'SP';

create view ros_meta.v_pl_trips
            (source, trip_id, trip_uid, trip_number, creation_date, finalization_date, submission_date,
             has_observer_trip_info, fishing_operation_type, observer_iotc_number, observer_imbarcation_date,
             observer_disembarcation_date, vessel_info_id, vessel_iotc_number, main_gear, reporting_flag, vessel_flag,
             vessel_departure_date, vessel_departure_port, vessel_departure_country, vessel_return_date,
             vessel_return_port, vessel_return_country)
as
    SELECT od.source,
           t.id                         AS trip_id,
           t.uid                        AS trip_uid,
           t.trip_original_id           AS trip_number,
           od.creation_time             AS creation_date,
           od.finalization_time         AS finalization_date,
           od.submission_time           AS submission_date,
           CASE
               WHEN otd.trip_id IS NULL THEN 0
               ELSE 1
               END                      AS has_observer_trip_info,
           'PL'::text                   AS fishing_operation_type,
           oi.iotc_observer_identifier  AS observer_iotc_number,
           otd.date_time_embarkation    AS observer_imbarcation_date,
           otd.date_time_disembarkation AS observer_disembarcation_date,
           vi.id                        AS vessel_info_id,
           vi.iotc_vessel_identifier    AS vessel_iotc_number,
           g.code                       AS main_gear,
           r.code                       AS reporting_flag,
           f.code                       AS vessel_flag,
           gvt.departure_timestamp      AS vessel_departure_date,
           pd.name_en                   AS vessel_departure_port,
           cd.code                      AS vessel_departure_country,
           gvt.return_timestamp         AS vessel_return_date,
           pr.name_en                   AS vessel_return_port,
           cr.code                      AS vessel_return_country
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             LEFT JOIN ros_common.trip_vessel gvt ON t.id = gvt.trip_id
             LEFT JOIN ros_common.locations tvdl ON tvdl.id = gvt.departure_location
             LEFT JOIN ros_common.locations tvrl ON tvdl.id = gvt.return_location
             LEFT JOIN ros_common.trip_observer otd ON t.id = otd.trip_id
             LEFT JOIN ros_common.observer oi ON otd.observer_id = oi.contact_id
             LEFT JOIN ros_common.vessel vi ON gvt.vessel_id = vi.id
             LEFT JOIN refs_fishery_config.gears g ON vi.main_fishing_gear_code::text = g.code::text
             LEFT JOIN refs_admin.countries f ON vi.flag_code = f.code
             LEFT JOIN refs_admin.countries r ON od.reporting_country_code = r.code
             LEFT JOIN refs_admin.ports pd ON tvdl.port_code::text = pd.code::text
             LEFT JOIN refs_admin.countries cd ON pd.country_code::bpchar = cd.code
             LEFT JOIN refs_admin.ports pr ON tvrl.port_code::text = pr.code::text
             LEFT JOIN refs_admin.countries cr ON pr.country_code::bpchar = cr.code
    WHERE od.vessel_type_code = 'LP';

create view ros_meta.v_ll_trips
            (source, trip_id, trip_uid, trip_number, creation_date, finalization_date, submission_date,
             has_observer_trip_info, fishing_operation_type, observer_iotc_number, observer_imbarcation_date,
             observer_disembarcation_date, vessel_info_id, vessel_iotc_number, main_gear, reporting_flag, vessel_flag,
             vessel_departure_date, vessel_departure_port, vessel_departure_country, vessel_return_date,
             vessel_return_port, vessel_return_country)
as
    SELECT od.source,
           t.id                         AS trip_id,
           t.uid                        AS trip_uid,
           t.trip_original_id           AS trip_number,
           od.creation_time             AS creation_date,
           od.finalization_time         AS finalization_date,
           od.submission_time           AS submission_date,
           CASE
               WHEN otd.trip_id IS NULL THEN 0
               ELSE 1
               END                      AS has_observer_trip_info,
           'LL'::text                   AS fishing_operation_type,
           oi.iotc_observer_identifier  AS observer_iotc_number,
           otd.date_time_embarkation    AS observer_imbarcation_date,
           otd.date_time_disembarkation AS observer_disembarcation_date,
           vi.id                        AS vessel_info_id,
           vi.iotc_vessel_identifier    AS vessel_iotc_number,
           g.code                       AS main_gear,
           r.code                       AS reporting_flag,
           f.code                       AS vessel_flag,
           gvt.departure_timestamp      AS vessel_departure_date,
           pd.name_en                   AS vessel_departure_port,
           cd.code                      AS vessel_departure_country,
           gvt.return_timestamp         AS vessel_return_date,
           pr.name_en                   AS vessel_return_port,
           cr.code                      AS vessel_return_country
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             LEFT JOIN ros_common.trip_vessel gvt ON t.id = gvt.trip_id
             LEFT JOIN ros_common.locations tvdl ON tvdl.id = gvt.departure_location
             LEFT JOIN ros_common.locations tvrl ON tvdl.id = gvt.return_location
             LEFT JOIN ros_common.trip_observer otd ON t.id = otd.trip_id
             LEFT JOIN ros_common.observer oi ON otd.observer_id = oi.contact_id
             LEFT JOIN ros_common.vessel vi ON gvt.vessel_id = vi.id
             LEFT JOIN refs_fishery_config.gears g ON vi.main_fishing_gear_code::text = g.code::text
             LEFT JOIN refs_admin.countries f ON vi.flag_code = f.code
             LEFT JOIN refs_admin.countries r ON od.reporting_country_code = r.code
             LEFT JOIN refs_admin.ports pd ON tvdl.port_code::text = pd.code::text
             LEFT JOIN refs_admin.countries cd ON pd.country_code::bpchar = cd.code
             LEFT JOIN refs_admin.ports pr ON tvrl.port_code::text = pr.code::text
             LEFT JOIN refs_admin.countries cr ON pr.country_code::bpchar = cr.code
    WHERE od.vessel_type_code = 'LL';

create view ros_meta.v_gn_trips
            (source, trip_id, trip_uid, trip_number, creation_date, finalization_date, submission_date,
             has_observer_trip_info, fishing_operation_type, observer_iotc_number, observer_imbarcation_date,
             observer_disembarcation_date, vessel_info_id, vessel_iotc_number, main_gear, reporting_flag, vessel_flag,
             vessel_departure_date, vessel_departure_port, vessel_departure_country, vessel_return_date,
             vessel_return_port, vessel_return_country)
as
    SELECT od.source,
           t.id                         AS trip_id,
           t.uid                        AS trip_uid,
           t.trip_original_id           AS trip_number,
           od.creation_time             AS creation_date,
           od.finalization_time         AS finalization_date,
           od.submission_time           AS submission_date,
           CASE
               WHEN otd.trip_id IS NULL THEN 0
               ELSE 1
               END                      AS has_observer_trip_info,
           'GN'::text                   AS fishing_operation_type,
           oi.iotc_observer_identifier  AS observer_iotc_number,
           otd.date_time_embarkation    AS observer_imbarcation_date,
           otd.date_time_disembarkation AS observer_disembarcation_date,
           vi.id                        AS vessel_info_id,
           vi.iotc_vessel_identifier    AS vessel_iotc_number,
           g.code                       AS main_gear,
           r.code                       AS reporting_flag,
           f.code                       AS vessel_flag,
           gvt.departure_timestamp      AS vessel_departure_date,
           pd.name_en                   AS vessel_departure_port,
           cd.code                      AS vessel_departure_country,
           gvt.return_timestamp         AS vessel_return_date,
           pr.name_en                   AS vessel_return_port,
           cr.code                      AS vessel_return_country
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             LEFT JOIN ros_common.trip_vessel gvt ON t.id = gvt.trip_id
             LEFT JOIN ros_common.locations tvdl ON tvdl.id = gvt.departure_location
             LEFT JOIN ros_common.locations tvrl ON tvdl.id = gvt.return_location
             LEFT JOIN ros_common.trip_observer otd ON t.id = otd.trip_id
             LEFT JOIN ros_common.observer oi ON otd.observer_id = oi.contact_id
             LEFT JOIN ros_common.vessel vi ON gvt.vessel_id = vi.id
             LEFT JOIN refs_fishery_config.gears g ON vi.main_fishing_gear_code::text = g.code::text
             LEFT JOIN refs_admin.countries f ON vi.flag_code = f.code
             LEFT JOIN refs_admin.countries r ON od.reporting_country_code = r.code
             LEFT JOIN refs_admin.ports pd ON tvdl.port_code::text = pd.code::text
             LEFT JOIN refs_admin.countries cd ON pd.country_code::bpchar = cd.code
             LEFT JOIN refs_admin.ports pr ON tvrl.port_code::text = pr.code::text
             LEFT JOIN refs_admin.countries cr ON pr.country_code::bpchar = cr.code
    WHERE od.vessel_type_code = 'GO';

create view ros_meta.v_trips
            (source, trip_id, trip_uid, trip_number, creation_date, finalization_date, submission_date,
             has_observer_trip_info, fishing_operation_type, observer_iotc_number, observer_imbarcation_date,
             observer_disembarcation_date, vessel_info_id, vessel_iotc_number, main_gear, reporting_flag, vessel_flag,
             vessel_departure_date, vessel_departure_port, vessel_departure_country, vessel_return_date,
             vessel_return_port, vessel_return_country)
as
    SELECT v_ll_trips.source,
           v_ll_trips.trip_id,
           v_ll_trips.trip_uid,
           v_ll_trips.trip_number,
           v_ll_trips.creation_date,
           v_ll_trips.finalization_date,
           v_ll_trips.submission_date,
           v_ll_trips.has_observer_trip_info,
           v_ll_trips.fishing_operation_type,
           v_ll_trips.observer_iotc_number,
           v_ll_trips.observer_imbarcation_date,
           v_ll_trips.observer_disembarcation_date,
           v_ll_trips.vessel_info_id,
           v_ll_trips.vessel_iotc_number,
           v_ll_trips.main_gear,
           v_ll_trips.reporting_flag,
           v_ll_trips.vessel_flag,
           v_ll_trips.vessel_departure_date,
           v_ll_trips.vessel_departure_port,
           v_ll_trips.vessel_departure_country,
           v_ll_trips.vessel_return_date,
           v_ll_trips.vessel_return_port,
           v_ll_trips.vessel_return_country
    FROM ros_meta.v_ll_trips
    UNION ALL
    SELECT v_ps_trips.source,
           v_ps_trips.trip_id,
           v_ps_trips.trip_uid,
           v_ps_trips.trip_number,
           v_ps_trips.creation_date,
           v_ps_trips.finalization_date,
           v_ps_trips.submission_date,
           v_ps_trips.has_observer_trip_info,
           v_ps_trips.fishing_operation_type,
           v_ps_trips.observer_iotc_number,
           v_ps_trips.observer_imbarcation_date,
           v_ps_trips.observer_disembarcation_date,
           v_ps_trips.vessel_info_id,
           v_ps_trips.vessel_iotc_number,
           v_ps_trips.main_gear,
           v_ps_trips.reporting_flag,
           v_ps_trips.vessel_flag,
           v_ps_trips.vessel_departure_date,
           v_ps_trips.vessel_departure_port,
           v_ps_trips.vessel_departure_country,
           v_ps_trips.vessel_return_date,
           v_ps_trips.vessel_return_port,
           v_ps_trips.vessel_return_country
    FROM ros_meta.v_ps_trips
    UNION ALL
    SELECT v_gn_trips.source,
           v_gn_trips.trip_id,
           v_gn_trips.trip_uid,
           v_gn_trips.trip_number,
           v_gn_trips.creation_date,
           v_gn_trips.finalization_date,
           v_gn_trips.submission_date,
           v_gn_trips.has_observer_trip_info,
           v_gn_trips.fishing_operation_type,
           v_gn_trips.observer_iotc_number,
           v_gn_trips.observer_imbarcation_date,
           v_gn_trips.observer_disembarcation_date,
           v_gn_trips.vessel_info_id,
           v_gn_trips.vessel_iotc_number,
           v_gn_trips.main_gear,
           v_gn_trips.reporting_flag,
           v_gn_trips.vessel_flag,
           v_gn_trips.vessel_departure_date,
           v_gn_trips.vessel_departure_port,
           v_gn_trips.vessel_departure_country,
           v_gn_trips.vessel_return_date,
           v_gn_trips.vessel_return_port,
           v_gn_trips.vessel_return_country
    FROM ros_meta.v_gn_trips
    UNION ALL
    SELECT v_pl_trips.source,
           v_pl_trips.trip_id,
           v_pl_trips.trip_uid,
           v_pl_trips.trip_number,
           v_pl_trips.creation_date,
           v_pl_trips.finalization_date,
           v_pl_trips.submission_date,
           v_pl_trips.has_observer_trip_info,
           v_pl_trips.fishing_operation_type,
           v_pl_trips.observer_iotc_number,
           v_pl_trips.observer_imbarcation_date,
           v_pl_trips.observer_disembarcation_date,
           v_pl_trips.vessel_info_id,
           v_pl_trips.vessel_iotc_number,
           v_pl_trips.main_gear,
           v_pl_trips.reporting_flag,
           v_pl_trips.vessel_flag,
           v_pl_trips.vessel_departure_date,
           v_pl_trips.vessel_departure_port,
           v_pl_trips.vessel_departure_country,
           v_pl_trips.vessel_return_date,
           v_pl_trips.vessel_return_port,
           v_pl_trips.vessel_return_country
    FROM ros_meta.v_pl_trips;

create view ros_meta.v_sets_by_year_and_gear(year, ps, ll) as
    SELECT date_part('year'::text, COALESCE(start_time, end_time)) AS year,
           sum(
                   CASE
                       WHEN fishing_operation_type = 'PS'::text THEN 1
                       ELSE 0
                       END)                                        AS ps,
           sum(
                   CASE
                       WHEN fishing_operation_type = 'LL'::text THEN 1
                       ELSE 0
                       END)                                        AS ll
    FROM ros_meta.v_sets s
    GROUP BY (date_part('year'::text, COALESCE(start_time, end_time)));

create view ros_meta.v_sets_by_flag_and_gear(flag, gear, num_sets) as
    SELECT CASE
               WHEN t.vessel_flag = ANY (ARRAY ['FRA'::bpchar, 'ESP'::bpchar]) THEN concat('EU.', t.vessel_flag)::bpchar
               ELSE t.vessel_flag
               END                  AS flag,
           t.fishing_operation_type AS gear,
           count(*)                 AS num_sets
    FROM ros_meta.v_sets s
             JOIN ros_meta.v_trips t ON s.trip_uid::text = t.trip_uid::text
    GROUP BY (
                 CASE
                     WHEN t.vessel_flag = ANY (ARRAY ['FRA'::bpchar, 'ESP'::bpchar]) THEN concat('EU.', t.vessel_flag)::bpchar
                     ELSE t.vessel_flag
                     END), t.fishing_operation_type;

create view ros_meta.v_fishing_days_by_year_flag_and_gear(year, flag, gear, fishing_days) as
    WITH ps AS (SELECT date_part('year'::text, s.start_setting_date_and_time)                                                                                      AS year,
                       c.code                                                                                                                                      AS flag,
                       'PS'::text                                                                                                                                  AS gear,
                       count(DISTINCT concat(date_part('month'::text, s.start_setting_date_and_time), '-', date_part('day'::text, s.start_setting_date_and_time))) AS fishing_days
                FROM ros_common.observer_data od
                         JOIN ros_common.trip t ON od.id = t.observer_data_id
                         JOIN ros_common.trip_vessel gvt ON t.id = gvt.trip_id
                         JOIN ros_ps.fishing_events fe ON fe.trip_id = t.id
                         JOIN ros_ps.setting_operations s ON fe.setting_operation_id = s.id
                         JOIN ros_common.vessel vi ON gvt.vessel_id = vi.id
                         JOIN refs_admin.countries c ON vi.flag_code = c.code
                WHERE od.vessel_type_code = 'SP'
                GROUP BY c.code, (date_part('year'::text, s.start_setting_date_and_time))),
         ll AS (SELECT date_part('year'::text, s.start_setting_date_and_time)                                                                                      AS year,
                       c.code                                                                                                                                      AS flag,
                       'LL'::text                                                                                                                                  AS gear,
                       count(DISTINCT concat(date_part('month'::text, s.start_setting_date_and_time), '-', date_part('day'::text, s.start_setting_date_and_time))) AS fishing_days
                FROM ros_common.observer_data od
                         JOIN ros_common.trip t ON od.id = t.observer_data_id
                         JOIN ros_common.trip_vessel gvt ON t.id = gvt.trip_id
                         JOIN ros_ll.fishing_events fe ON fe.trip_id = t.id
                         JOIN ros_ll.setting_operations s ON fe.setting_operation_id = s.id
                         JOIN ros_common.vessel vi ON gvt.vessel_id = vi.id
                         JOIN refs_admin.countries c ON vi.flag_code = c.code
                WHERE od.vessel_type_code = 'LL'
                GROUP BY c.code, (date_part('year'::text, s.start_setting_date_and_time)))
    SELECT ps.year,
           ps.flag,
           ps.gear,
           ps.fishing_days
    FROM ps
    UNION ALL
    SELECT ll.year,
           ll.flag,
           ll.gear,
           ll.fishing_days
    FROM ll;

create view ros_meta.v_target_species_by_trip
            (trip_id, trip_uid, trip_number, vessel_flag, fishing_operation_type, main_gear, target_species_code,
             target_species)
as
    SELECT t.trip_id,
           t.trip_uid,
           t.trip_number,
           t.vessel_flag,
           t.fishing_operation_type,
           t.main_gear,
           s_t.code    AS target_species_code,
           s_t.name_en AS target_species
    FROM ros_meta.v_trips t
             LEFT JOIN ros_common.vessel vi ON t.vessel_info_id = vi.id
             LEFT JOIN ros_common.vessel_licensed_target_species vi2lts ON vi2lts.vessel_id = vi.id
             LEFT JOIN refs_biology.species s_t ON vi2lts.licensed_target_species_code::text = s_t.code::text;

create view ros_meta.v_ps_effort_summary
    (year, month, vessel_flag, grid_1, grid_5, valid_grid_1, valid_grid_5, effort) as
    SELECT date_part('year'::text, s.start_time)  AS year,
           date_part('month'::text, s.start_time) AS month,
           t.vessel_flag,
           s.grid_1,
           s.grid_5,
           CASE
               WHEN fg_1.code IS NULL THEN 0
               ELSE 1
               END                                AS valid_grid_1,
           CASE
               WHEN fg_5.code IS NULL THEN 0
               ELSE 1
               END                                AS valid_grid_5,
           sum(s.effort)                          AS effort
    FROM ros_meta.v_sets s
             JOIN ros_meta.v_trips t ON s.trip_id = t.trip_id
             LEFT JOIN refs_gis.areas fg_1 ON s.grid_1 = fg_1.code::bpchar
             LEFT JOIN refs_gis.areas fg_5 ON s.grid_5 = fg_5.code::bpchar
    WHERE s.fishing_operation_type = 'PS'::text
    GROUP BY (date_part('year'::text, s.start_time)), (date_part('month'::text, s.start_time)), t.vessel_flag, s.grid_1, s.grid_5, fg_1.code, fg_5.code;

create view ros_meta.v_ll_effort_summary
    (year, month, vessel_flag, grid_1, grid_5, valid_grid_1, valid_grid_5, effort) as
    SELECT date_part('year'::text, s.start_time)  AS year,
           date_part('month'::text, s.start_time) AS month,
           t.vessel_flag,
           s.grid_1,
           s.grid_5,
           CASE
               WHEN fg_1.code IS NULL THEN 0
               ELSE 1
               END                                AS valid_grid_1,
           CASE
               WHEN fg_5.code IS NULL THEN 0
               ELSE 1
               END                                AS valid_grid_5,
           sum(s.effort)                          AS effort
    FROM ros_meta.v_sets s
             JOIN ros_meta.v_trips t ON s.trip_id = t.trip_id
             LEFT JOIN refs_gis.areas fg_1 ON s.grid_1 = fg_1.code::bpchar
             LEFT JOIN refs_gis.areas fg_5 ON s.grid_5 = fg_5.code::bpchar
    WHERE s.fishing_operation_type = 'LL'::text
    GROUP BY (date_part('year'::text, s.start_time)), (date_part('month'::text, s.start_time)), t.vessel_flag, s.grid_1, s.grid_5, fg_1.code, fg_5.code;

create view ros_meta.v_sets_by_year_flag_and_gear(year, flag, gear, num_sets) as
    SELECT date_part('year'::text, COALESCE(s.start_time, s.end_time)) AS year,
           CASE
               WHEN t.vessel_flag = ANY (ARRAY ['FRA'::bpchar, 'ESP'::bpchar]) THEN concat('EU.', t.vessel_flag)::bpchar
               ELSE t.vessel_flag
               END                                                     AS flag,
           t.fishing_operation_type                                    AS gear,
           count(*)                                                    AS num_sets
    FROM ros_meta.v_sets s
             JOIN ros_meta.v_trips t ON s.trip_uid::text = t.trip_uid::text
    GROUP BY (date_part('year'::text, COALESCE(s.start_time, s.end_time))), t.vessel_flag, t.fishing_operation_type;

create view ros_meta.v_trips_by_year_flag_and_gear(source, year, flag, gear, num_trips) as
    SELECT source,
           date_part('year'::text, COALESCE(vessel_departure_date, vessel_return_date)) AS year,
           CASE
               WHEN reporting_flag = ANY (ARRAY ['FRA'::bpchar, 'ESP'::bpchar]) THEN concat('EU.', reporting_flag)::bpchar
               ELSE reporting_flag
               END                                                                      AS flag,
           fishing_operation_type                                                       AS gear,
           count(*)                                                                     AS num_trips
    FROM ros_meta.v_trips t
    GROUP BY source, (date_part('year'::text, COALESCE(vessel_departure_date, vessel_return_date))), reporting_flag, fishing_operation_type;

create view ros_meta.v_trips_by_flag_and_gear(flag, gear, num_trips) as
    SELECT CASE
               WHEN reporting_flag = ANY (ARRAY ['FRA'::bpchar, 'ESP'::bpchar]) THEN concat('EU.', reporting_flag)::bpchar
               ELSE reporting_flag
               END                AS flag,
           fishing_operation_type AS gear,
           count(*)               AS num_trips
    FROM ros_meta.v_trips t
    GROUP BY reporting_flag, fishing_operation_type;

create view ros_meta.v_trips_by_year_and_gear(year, ps, ll) as
    SELECT date_part('year'::text, COALESCE(vessel_departure_date, vessel_return_date)) AS year,
           sum(
                   CASE
                       WHEN fishing_operation_type = 'PS'::text THEN 1
                       ELSE 0
                       END)                                                             AS ps,
           sum(
                   CASE
                       WHEN fishing_operation_type = 'LL'::text THEN 1
                       ELSE 0
                       END)                                                             AS ll
    FROM ros_meta.v_trips t
    GROUP BY (date_part('year'::text, COALESCE(vessel_departure_date, vessel_return_date)));
