create or replace view ros_analysis.v_ps_sf_w(gear, flag, year, month, grid_1, grid_5, species, species_group_code, fate, sex, weight_code, length_unit, size_bin, num_fish) as
    SELECT 'PS'::text                                                                AS gear,
           COALESCE(fl.fleet_code, cl_co.code::character varying)                    AS flag,
           date_part('year'::text, se.start_setting_date_and_time)                   AS year,
           date_part('month'::text, se.start_setting_date_and_time)                  AS month,
           ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
           ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
           cl_sp.code                                                                AS species,
           cl_sp.species_group_code,
           cl_fa.code                                                                AS fate,
           cl_sx.code                                                                AS sex,
           cl_pt.code                                                                AS weight_code,
           we.unit                                                                   AS length_unit,
           floor(we.value)                                                           AS size_bin,
           count(DISTINCT sp.id)                                                     AS num_fish
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             JOIN ros_common.trip_vessel gvti ON t.id = gvti.trip_id
             JOIN ros_common.vessel vi ON gvti.vessel_id = vi.id
             JOIN refs_admin.countries cl_co ON vi.flag_code = cl_co.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON cl_co.code = fl.flag_code::bpchar
             JOIN ros_ps.fishing_events fe ON fe.trip_id = t.id
             LEFT JOIN ros_ps.setting_operations se ON fe.setting_operation_id = se.id
             JOIN ros_ps.catch_details ca ON ca.fishing_event_id = fe.id
             JOIN refs_biology.species cl_sp ON ca.species_code::text = cl_sp.code::text
             LEFT JOIN refs_biology.fates cl_fa ON ca.fates_code = cl_fa.code
             JOIN ros_ps.specimens sp ON sp.catch_detail_id = ca.id
             JOIN ros_common.biometric_information bi ON sp.biometric_information_id = bi.id
             LEFT JOIN refs_biology.sex cl_sx ON bi.sex_code = cl_sx.code
             JOIN ros_common.estimated_weights we ON bi.estimated_weight_id = we.id
             LEFT JOIN refs_fishery.fish_processing_types cl_pt ON we.processing_type_code = cl_pt.code
    WHERE od.vessel_type_code = 'SP'
    GROUP BY (COALESCE(fl.fleet_code, cl_co.code::character varying)), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)),
             (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude)), cl_sp.code, cl_sp.species_group_code, cl_fa.code, cl_sx.code, cl_pt.code,
             (floor(we.value)), we.unit;


create or replace view ros_analysis.v_ps_sf_l(gear, flag, year, month, grid_1, grid_5, species, species_group_code, fate, sex, length_code, length_unit, size_bin, num_fish) as
    SELECT 'PS'::text                                                                AS gear,
           COALESCE(fl.fleet_code, cl_co.code::character varying)                    AS flag,
           date_part('year'::text, se.start_setting_date_and_time)                   AS year,
           date_part('month'::text, se.start_setting_date_and_time)                  AS month,
           ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
           ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
           cl_sp.code                                                                AS species,
           cl_sp.species_group_code,
           cl_fa.code                                                                AS fate,
           cl_sx.code                                                                AS sex,
           cl_le.code                                                                AS length_code,
           ln.unit                                                                   AS length_unit,
           floor(ln.value)                                                           AS size_bin,
           count(DISTINCT sp.id)                                                     AS num_fish
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             JOIN ros_common.trip_vessel gvti ON t.id = gvti.trip_id
             JOIN ros_common.vessel vi ON gvti.vessel_id = vi.id
             JOIN refs_admin.countries cl_co ON vi.flag_code = cl_co.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON cl_co.code = fl.flag_code::bpchar
             JOIN ros_ps.fishing_events fe ON fe.trip_id = t.id
             LEFT JOIN ros_ps.setting_operations se ON fe.setting_operation_id = se.id
             JOIN ros_ps.catch_details ca ON ca.fishing_event_id = fe.id
             JOIN refs_biology.species cl_sp ON ca.species_code::text = cl_sp.code::text
             LEFT JOIN refs_biology.fates cl_fa ON ca.fates_code = cl_fa.code
             JOIN ros_ps.specimens sp ON sp.catch_detail_id = ca.id
             JOIN ros_common.biometric_information bi ON sp.biometric_information_id = bi.id
             LEFT JOIN refs_biology.sex cl_sx ON bi.sex_code = cl_sx.code
             LEFT JOIN ros_common.measured_lengths ln ON bi.measured_length_id = ln.id OR bi.alternative_measured_length_id = ln.id
             JOIN refs_biology.measurements cl_le ON ln.measured_length_type_code = cl_le.code
    WHERE od.vessel_type_code = 'SP'
    GROUP BY (COALESCE(fl.fleet_code, cl_co.code::character varying)), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)),
             (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude)), cl_sp.code, cl_sp.species_group_code, cl_fa.code, cl_sx.code, cl_le.code,
             (floor(ln.value)), ln.unit;

create or replace view ros_analysis.v_ps_sets_raw
            (flag_code, fleet_code, gear_code, fishery_code, fishery_group_code, fishery_type_code, trip_id, trip_uid, set_id, set_uid, event_type_code, start_time, start_lon, start_lat, end_time, end_lon, end_lat, effort, effort_unit_code) as
    SELECT COALESCE(f2f.flag_code, c.code::character varying)                                                        AS flag_code,
           COALESCE(f2f.fleet_code, c.code::character varying)                                                       AS fleet_code,
           'PS'::text                                                                                                AS gear_code,
           'PSOT'::text                                                                                              AS fishery_code,
           'PS'::text                                                                                                AS fishery_group_code,
           'IND'::text                                                                                               AS fishery_type_code,
           t.id                                                                                                      AS trip_id,
           t.uid                                                                                                     AS trip_uid,
           fed.setting_operation_id                                                                                  AS set_id,
           fed.event_original_id                                                                                     AS set_uid,
           'SETTING'::text                                                                                           AS event_type_code,
           so.start_setting_date_and_time                                                                            AS start_time,
           so.start_setting_longitude                                                                                AS start_lon,
           so.start_setting_latitude                                                                                 AS start_lat,
           COALESCE(so.time_end_brailing, so.time_skiff_onboard, so.time_net_pursed, so.start_setting_date_and_time) AS end_time,
           so.start_setting_longitude                                                                                AS end_lon,
           so.start_setting_latitude                                                                                 AS end_lat,
           1                                                                                                         AS effort,
           'SET'::text                                                                                               AS effort_unit_code
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             JOIN ros_common.trip_vessel gvti ON t.id = gvti.trip_id
             JOIN ros_common.vessel vi ON gvti.vessel_id = vi.id
             LEFT JOIN refs_admin.countries c ON vi.flag_code = c.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries f2f ON c.code = f2f.flag_code::bpchar
             JOIN ros_ps.fishing_events fed ON fed.trip_id = t.id
             JOIN ros_ps.setting_operations so ON fed.setting_operation_id = so.id
WHERE od.vessel_type_code = 'SP';

create or replace view ros_analysis.v_ps_in(gear, flag, year, month, grid_1, grid_5, species, species_group_code, num_interactions, fate, fate_code, condition, condition_code) as
    SELECT 'PS'::text                                                                AS gear,
           COALESCE(fl.fleet_code, cl_co.code::character varying)                    AS flag,
           date_part('year'::text, se.start_setting_date_and_time)                   AS year,
           date_part('month'::text, se.start_setting_date_and_time)                  AS month,
           ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
           ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
           cl_sp.code                                                                AS species,
           cl_sp.species_group_code,
           CASE
               WHEN count(DISTINCT sp.id) = 0 THEN sum(ca.estimated_catch_in_numbers)
               ELSE count(DISTINCT sp.id)
               END                                                                   AS num_interactions,
           CASE
               WHEN cl_fa.code ~~ 'R%'::text THEN 'RETAINED'::text
               WHEN cl_fa.code ~~ 'D%'::text THEN 'DISCARDED'::text
               WHEN cl_fa.code ~~ 'U%'::text THEN 'UNKNOWN'::text
               ELSE 'NA'::text
               END                                                                   AS fate,
           cl_fa.code                                                                AS fate_code,
           CASE
               WHEN cl_cn.code::text ~~ 'A%'::text THEN 'ALIVE'::text
               WHEN cl_cn.code::text ~~ 'D%'::text THEN 'DEAD'::text
               WHEN cl_cn.code::text ~~ 'U%'::text THEN 'UNKNOWN'::text
               ELSE 'NA'::text
               END                                                                   AS condition,
           cl_cn.code                                                                AS condition_code
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             JOIN ros_common.trip_vessel gvti ON t.id = gvti.trip_id
             JOIN ros_common.vessel vi ON gvti.vessel_id = vi.id
             JOIN refs_admin.countries cl_co ON vi.flag_code = cl_co.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON cl_co.code = fl.flag_code::bpchar
             JOIN ros_ps.fishing_events fe ON fe.trip_id = t.id
             LEFT JOIN ros_ps.setting_operations se ON fe.setting_operation_id = se.id
             JOIN ros_ps.catch_details ca ON ca.fishing_event_id = fe.id
             JOIN refs_biology.species cl_sp ON ca.species_code::text = cl_sp.code::text
             LEFT JOIN refs_biology.fates cl_fa ON ca.fates_code = cl_fa.code
             JOIN ros_ps.specimens sp ON sp.catch_detail_id = ca.id
             LEFT JOIN ros_common.additional_details_on_non_target_species adnt ON sp.additional_specimen_details_non_target_species_id = adnt.id
             LEFT JOIN refs_biology.incidental_captures_conditions cl_cn ON COALESCE(adnt.condition_at_capture_code, adnt.condition_at_release_code)::text = cl_cn.code::text
    WHERE od.vessel_type_code = 'SP'
    GROUP BY (COALESCE(fl.fleet_code, cl_co.code::character varying)), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)),
             (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude)), cl_sp.code, cl_sp.species_group_code,
             (
                 CASE
                     WHEN cl_fa.code ~~ 'R%'::text THEN 'RETAINED'::text
                     WHEN cl_fa.code ~~ 'D%'::text THEN 'DISCARDED'::text
                     WHEN cl_fa.code ~~ 'U%'::text THEN 'UNKNOWN'::text
                     ELSE 'NA'::text
                     END), cl_fa.code,
             (
                 CASE
                     WHEN cl_cn.code::text ~~ 'A%'::text THEN 'ALIVE'::text
                     WHEN cl_cn.code::text ~~ 'D%'::text THEN 'DEAD'::text
                     WHEN cl_cn.code::text ~~ 'U%'::text THEN 'UNKNOWN'::text
                     ELSE 'NA'::text
                     END), cl_cn.code;

create or replace view ros_analysis.v_ps_ef_raw(gear, flag, year, month, grid_1, grid_5, observed_effort, effort_unit) as
    SELECT 'PS'::text                                                                AS gear,
           COALESCE(fl.fleet_code, cl_co.code::character varying)                    AS flag,
           date_part('year'::text, se.start_setting_date_and_time)                   AS year,
           date_part('month'::text, se.start_setting_date_and_time)                  AS month,
           ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
           ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
           count(DISTINCT se.id)                                                     AS observed_effort,
           'SETS'::text                                                              AS effort_unit
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             JOIN ros_common.trip_vessel gvti ON t.id = gvti.trip_id
             JOIN ros_common.vessel vi ON gvti.vessel_id = vi.id
             JOIN refs_admin.countries cl_co ON vi.flag_code = cl_co.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON cl_co.code = fl.flag_code::bpchar
             JOIN ros_ps.fishing_events fe ON fe.trip_id = t.id
             LEFT JOIN ros_ps.setting_operations se ON fe.setting_operation_id = se.id
    WHERE od.vessel_type_code = 'SP'
    GROUP BY (COALESCE(fl.fleet_code, cl_co.code::character varying)), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)),
             (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude));

create or replace view ros_analysis.v_ps_ef_fd(gear, flag, year, month, grid_1, grid_5, effort, effort_unit) as
    SELECT 'PS'::text                                                                AS gear,
           COALESCE(fl.fleet_code, cl_co.code::character varying)                    AS flag,
           date_part('year'::text, se.start_setting_date_and_time)                   AS year,
           date_part('month'::text, se.start_setting_date_and_time)                  AS month,
           ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
           ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
           count(DISTINCT date_part('day'::text, se.start_setting_date_and_time))    AS effort,
           'FDAYS'::text                                                             AS effort_unit
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             JOIN ros_common.trip_vessel gvti ON t.id = gvti.trip_id
             JOIN ros_common.vessel vi ON gvti.vessel_id = vi.id
             JOIN refs_admin.countries cl_co ON vi.flag_code = cl_co.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON cl_co.code = fl.flag_code::bpchar
             JOIN ros_ps.fishing_events fe ON fe.trip_id = t.id
             LEFT JOIN ros_ps.setting_operations se ON fe.setting_operation_id = se.id
    WHERE od.vessel_type_code = 'SP'
    GROUP BY (COALESCE(fl.fleet_code, cl_co.code::character varying)), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)),
             (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude));

create or replace view ros_analysis.v_ps_ef(gear, flag, year, month, grid_1, grid_5, observed_effort, effort_unit) as
    SELECT v_ps_ef_raw.gear,
           v_ps_ef_raw.flag,
           v_ps_ef_raw.year,
           v_ps_ef_raw.month,
           v_ps_ef_raw.grid_1,
           v_ps_ef_raw.grid_5,
           v_ps_ef_raw.observed_effort,
           v_ps_ef_raw.effort_unit
    FROM ros_analysis.v_ps_ef_raw
    UNION ALL
    SELECT v_ps_ef_fd.gear,
           v_ps_ef_fd.flag,
           v_ps_ef_fd.year,
           v_ps_ef_fd.month,
           v_ps_ef_fd.grid_1,
           v_ps_ef_fd.grid_5,
           v_ps_ef_fd.effort AS observed_effort,
           v_ps_ef_fd.effort_unit
    FROM ros_analysis.v_ps_ef_fd;

create or replace view ros_analysis.v_ps_ca(gear, flag, year, month, grid_1, grid_5, species, species_group_code, fate, observed_catch, catch_unit) as
    SELECT 'PS'::text                                                                AS gear,
           COALESCE(fl.fleet_code, cl_co.code::character varying)                    AS flag,
           date_part('year'::text, se.start_setting_date_and_time)                   AS year,
           date_part('month'::text, se.start_setting_date_and_time)                  AS month,
           ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
           ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
           cl_sp.code                                                                AS species,
           cl_sp.species_group_code,
           cl_fa.code                                                                AS fate,
           sum(
                   CASE
                       WHEN w.unit::text = 'MT'::text THEN 1000
                       ELSE 1
                       END::double precision * w.value)                              AS observed_catch,
           'KG'::text                                                                AS catch_unit
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             JOIN ros_common.trip_vessel gvti ON t.id = gvti.trip_id
             JOIN ros_common.vessel vi ON gvti.vessel_id = vi.id
             JOIN refs_admin.countries cl_co ON vi.flag_code = cl_co.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON cl_co.code = fl.flag_code::bpchar
             JOIN ros_ps.fishing_events fe ON fe.trip_id = t.id
             LEFT JOIN ros_ps.setting_operations se ON fe.setting_operation_id = se.id
             JOIN ros_ps.catch_details ca ON ca.fishing_event_id = fe.id
             JOIN refs_biology.species cl_sp ON ca.species_code::text = cl_sp.code::text
             LEFT JOIN refs_biology.fates cl_fa ON ca.fates_code = cl_fa.code
             JOIN ros_common.estimated_weights w ON ca.estimated_weight_id = w.id
             LEFT JOIN refs_fishery.fish_processing_types cl_pt ON w.processing_type_code = cl_pt.code
    WHERE od.vessel_type_code = 'SP'
    GROUP BY (COALESCE(fl.fleet_code, cl_co.code::character varying)), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)),
             (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude)), cl_sp.code, cl_sp.species_group_code, cl_fa.code, w.unit;

create or replace view ros_analysis.v_ll_sf_w(gear, flag, year, month, grid_1, grid_5, species, species_group_code, fate, sex, weight_code, weight_unit, size_bin, num_fish) as
    SELECT 'LL'::text                                                                AS gear,
           COALESCE(fl.fleet_code, cl_co.code::character varying)                    AS flag,
           date_part('year'::text, se.start_setting_date_and_time)                   AS year,
           date_part('month'::text, se.start_setting_date_and_time)                  AS month,
           ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
           ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
           cl_sp.code                                                                AS species,
           cl_sp.species_group_code,
           cl_fa.code                                                                AS fate,
           cl_sx.code                                                                AS sex,
           cl_pt.code                                                                AS weight_code,
           we.unit                                                                   AS weight_unit,
           floor(we.value)                                                           AS size_bin,
           count(DISTINCT sp.id)                                                     AS num_fish
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             JOIN ros_common.trip_vessel gvti ON t.id = gvti.trip_id
             JOIN ros_common.vessel vi ON gvti.vessel_id = vi.id
             JOIN refs_admin.countries cl_co ON vi.flag_code = cl_co.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON cl_co.code = fl.flag_code::bpchar
             JOIN ros_ll.fishing_events fe ON fe.trip_id = t.id
             LEFT JOIN ros_ll.setting_operations se ON fe.setting_operation_id = se.id
             JOIN ros_ll.catch_details ca ON ca.fishing_event_id = fe.id
             JOIN refs_biology.species cl_sp ON ca.species_code::text = cl_sp.code::text
             LEFT JOIN refs_biology.fates cl_fa ON ca.fates_code = cl_fa.code
             JOIN ros_ll.specimens sp ON sp.catch_detail_id = ca.id
             JOIN ros_common.biometric_information bi ON sp.biometric_information_id = bi.id
             LEFT JOIN refs_biology.sex cl_sx ON bi.sex_code = cl_sx.code
             JOIN ros_common.estimated_weights we ON bi.estimated_weight_id = we.id
             LEFT JOIN refs_fishery.fish_processing_types cl_pt ON we.processing_type_code = cl_pt.code
    WHERE od.vessel_type_code = 'LL'
    GROUP BY (COALESCE(fl.fleet_code, cl_co.code::character varying)), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)),
             (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude)), cl_sp.code, cl_sp.species_group_code, cl_fa.code, cl_sx.code, cl_pt.code,
             (floor(we.value)), we.unit;

create or replace view ros_analysis.v_ll_sf_l(gear, flag, year, month, grid_1, grid_5, species, species_group_code, fate, sex, length_code, length_unit, size_bin, num_fish) as
    SELECT 'LL'::text                                                                AS gear,
           COALESCE(fl.fleet_code, cl_co.code::character varying)                    AS flag,
           date_part('year'::text, se.start_setting_date_and_time)                   AS year,
           date_part('month'::text, se.start_setting_date_and_time)                  AS month,
           ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
           ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
           cl_sp.code                                                                AS species,
           cl_sp.species_group_code,
           cl_fa.code                                                                AS fate,
           cl_sx.code                                                                AS sex,
           cl_le.code                                                                AS length_code,
           ln.unit                                                                   AS length_unit,
           floor(ln.value)                                                           AS size_bin,
           count(DISTINCT sp.id)                                                     AS num_fish
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             JOIN ros_common.trip_vessel gvti ON t.id = gvti.trip_id
             JOIN ros_common.vessel vi ON gvti.vessel_id = vi.id
             JOIN refs_admin.countries cl_co ON vi.flag_code = cl_co.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON cl_co.code = fl.flag_code::bpchar
             JOIN ros_ll.fishing_events fe ON fe.trip_id = t.id
             LEFT JOIN ros_ll.setting_operations se ON fe.setting_operation_id = se.id
             JOIN ros_ll.catch_details ca ON ca.fishing_event_id = fe.id
             JOIN refs_biology.species cl_sp ON ca.species_code::text = cl_sp.code::text
             LEFT JOIN refs_biology.fates cl_fa ON ca.fates_code = cl_fa.code
             JOIN ros_ll.specimens sp ON sp.catch_detail_id = ca.id
             JOIN ros_common.biometric_information bi ON sp.biometric_information_id = bi.id
             LEFT JOIN refs_biology.sex cl_sx ON bi.sex_code = cl_sx.code
             JOIN ros_common.measured_lengths ln ON bi.measured_length_id = ln.id OR bi.alternative_measured_length_id = ln.id
             LEFT JOIN refs_biology.measurements cl_le ON ln.measured_length_type_code = cl_le.code
    WHERE od.vessel_type_code = 'LL'
    GROUP BY (COALESCE(fl.fleet_code, cl_co.code::character varying)), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)),
             (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude)), cl_sp.code, cl_sp.species_group_code, cl_fa.code, cl_sx.code, cl_le.code,
             (floor(ln.value)), ln.unit;

create or replace view ros_analysis.v_sf_w(gear, flag, year, month, grid_1, grid_5, species, species_group_code, fate, sex, weight_code, length_unit, size_bin, num_fish) as
    SELECT v_ps_sf_w.gear,
           v_ps_sf_w.flag,
           v_ps_sf_w.year,
           v_ps_sf_w.month,
           v_ps_sf_w.grid_1,
           v_ps_sf_w.grid_5,
           v_ps_sf_w.species,
           v_ps_sf_w.species_group_code,
           v_ps_sf_w.fate,
           v_ps_sf_w.sex,
           v_ps_sf_w.weight_code,
           v_ps_sf_w.length_unit,
           v_ps_sf_w.size_bin,
           v_ps_sf_w.num_fish
    FROM ros_analysis.v_ps_sf_w
    WHERE v_ps_sf_w.year IS NOT NULL
    UNION ALL
    SELECT v_ll_sf_w.gear,
           v_ll_sf_w.flag,
           v_ll_sf_w.year,
           v_ll_sf_w.month,
           v_ll_sf_w.grid_1,
           v_ll_sf_w.grid_5,
           v_ll_sf_w.species,
           v_ll_sf_w.species_group_code,
           v_ll_sf_w.fate,
           v_ll_sf_w.sex,
           v_ll_sf_w.weight_code,
           v_ll_sf_w.weight_unit AS length_unit,
           v_ll_sf_w.size_bin,
           v_ll_sf_w.num_fish
    FROM ros_analysis.v_ll_sf_w
    WHERE v_ll_sf_w.year IS NOT NULL;

create or replace view ros_analysis.v_sf_l(gear, flag, year, month, grid_1, grid_5, species, species_group_code, fate, sex, length_code, length_unit, size_bin, num_fish) as
    SELECT v_ps_sf_l.gear,
           v_ps_sf_l.flag,
           v_ps_sf_l.year,
           v_ps_sf_l.month,
           v_ps_sf_l.grid_1,
           v_ps_sf_l.grid_5,
           v_ps_sf_l.species,
           v_ps_sf_l.species_group_code,
           v_ps_sf_l.fate,
           v_ps_sf_l.sex,
           v_ps_sf_l.length_code,
           v_ps_sf_l.length_unit,
           v_ps_sf_l.size_bin,
           v_ps_sf_l.num_fish
    FROM ros_analysis.v_ps_sf_l
    WHERE v_ps_sf_l.year IS NOT NULL
    UNION ALL
    SELECT v_ll_sf_l.gear,
           v_ll_sf_l.flag,
           v_ll_sf_l.year,
           v_ll_sf_l.month,
           v_ll_sf_l.grid_1,
           v_ll_sf_l.grid_5,
           v_ll_sf_l.species,
           v_ll_sf_l.species_group_code,
           v_ll_sf_l.fate,
           v_ll_sf_l.sex,
           v_ll_sf_l.length_code,
           v_ll_sf_l.length_unit,
           v_ll_sf_l.size_bin,
           v_ll_sf_l.num_fish
    FROM ros_analysis.v_ll_sf_l
    WHERE v_ll_sf_l.year IS NOT NULL;

create or replace view ros_analysis.v_sf(gear, flag, year, month, grid_1, grid_5, species, species_group_code, fate, sex, length_code, length_unit, size_bin, num_fish) as
    SELECT v_sf_l.gear,
           v_sf_l.flag,
           v_sf_l.year,
           v_sf_l.month,
           v_sf_l.grid_1,
           v_sf_l.grid_5,
           v_sf_l.species,
           v_sf_l.species_group_code,
           v_sf_l.fate,
           v_sf_l.sex,
           v_sf_l.length_code,
           v_sf_l.length_unit,
           v_sf_l.size_bin,
           v_sf_l.num_fish
    FROM ros_analysis.v_sf_l
    UNION ALL
    SELECT v_sf_w.gear,
           v_sf_w.flag,
           v_sf_w.year,
           v_sf_w.month,
           v_sf_w.grid_1,
           v_sf_w.grid_5,
           v_sf_w.species,
           v_sf_w.species_group_code,
           v_sf_w.fate,
           v_sf_w.sex,
           v_sf_w.weight_code AS length_code,
           v_sf_w.length_unit,
           v_sf_w.size_bin,
           v_sf_w.num_fish
    FROM ros_analysis.v_sf_w;

create or replace view ros_analysis.v_ll_sets_raw
            (flag_code, fleet_code, gear_code, fishery_code, fishery_group_code, fishery_type_code, trip_id, trip_uid, set_id, set_uid, event_type_code, start_time, start_lon, start_lat, end_time, end_lon, end_lat, effort, effort_unit_code) as
    SELECT COALESCE(f2f.flag_code, c.code::character varying)  AS flag_code,
           COALESCE(f2f.fleet_code, c.code::character varying) AS fleet_code,
           'LL'::text                                          AS gear_code,
           'LLO'::text                                         AS fishery_code,
           'LL'::text                                          AS fishery_group_code,
           'IND'::text                                         AS fishery_type_code,
           t.id                                                AS trip_id,
           t.uid                                               AS trip_uid,
           fed.setting_operation_id                            AS set_id,
           fed.event_original_id                               AS set_uid,
           'SETTING'::text                                     AS event_type_code,
           so.start_setting_date_and_time                      AS start_time,
           so.start_setting_longitude                          AS start_lon,
           so.start_setting_latitude                           AS start_lat,
           so.end_setting_date_and_time                        AS end_time,
           so.end_setting_longitude                            AS end_lon,
           so.end_setting_latitude                             AS end_lat,
           so.total_number_of_hooks_set                        AS effort,
           'HK'::text                                          AS effort_unit_code
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             JOIN ros_common.trip_vessel gvti ON t.id = gvti.trip_id
             JOIN ros_common.vessel vi ON gvti.vessel_id = vi.id
             LEFT JOIN refs_admin.countries c ON vi.flag_code = c.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries f2f ON c.code = f2f.flag_code::bpchar
             JOIN ros_ll.fishing_events fed ON fed.trip_id = t.id
             JOIN ros_ll.setting_operations so ON fed.setting_operation_id = so.id
    WHERE od.vessel_type_code = 'LL'
    UNION ALL
    SELECT COALESCE(f2f.flag_code, c.code::character varying)  AS flag_code,
           COALESCE(f2f.fleet_code, c.code::character varying) AS fleet_code,
           'LL'::text                                          AS gear_code,
           'LLO'::text                                         AS fishery_code,
           'LL'::text                                          AS fishery_group_code,
           'IND'::text                                         AS fishery_type_code,
           t.id                                                AS trip_id,
           t.uid                                               AS trip_uid,
           fed.setting_operation_id                            AS set_id,
           fed.event_original_id                               AS set_uid,
           'HAULING'::text                                     AS event_type_code,
           ho.start_hauling_date_and_time                      AS start_time,
           ho.start_hauling_longitude                          AS start_lon,
           ho.start_hauling_latitude                           AS start_lat,
           ho.end_hauling_date_and_time                        AS end_time,
           ho.end_hauling_longitude                            AS end_lon,
           ho.end_hauling_latitude                             AS end_lat,
           ho.number_of_hooks_observed                         AS effort,
           'HK'::text                                          AS effort_unit_code
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             JOIN ros_common.trip_vessel gvti ON t.id = gvti.trip_id
             JOIN ros_common.vessel vi ON gvti.vessel_id = vi.id
             LEFT JOIN refs_admin.countries c ON vi.flag_code = c.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries f2f ON c.code = f2f.flag_code::bpchar
             JOIN ros_ll.fishing_events fed ON fed.trip_id = t.id
             JOIN ros_ll.hauling_operations ho ON fed.hauling_operation_id = ho.id
WHERE od.vessel_type_code = 'LL';

create or replace view ros_analysis.v_ll_in(gear, flag, year, month, grid_1, grid_5, species, species_group_code, num_interactions, fate, fate_code, condition, condition_code) as
    SELECT 'LL'::text                                                                AS gear,
           COALESCE(fl.fleet_code, cl_co.code::character varying)                    AS flag,
           date_part('year'::text, se.start_setting_date_and_time)                   AS year,
           date_part('month'::text, se.start_setting_date_and_time)                  AS month,
           ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
           ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
           cl_sp.code                                                                AS species,
           cl_sp.species_group_code,
           CASE
               WHEN count(DISTINCT sp.id) = 0 THEN sum(ca.estimated_catch_in_numbers)
               ELSE count(DISTINCT sp.id)
               END                                                                   AS num_interactions,
           CASE
               WHEN cl_fa.code ~~ 'R%'::text THEN 'RETAINED'::text
               WHEN cl_fa.code ~~ 'D%'::text THEN 'DISCARDED'::text
               WHEN cl_fa.code ~~ 'U%'::text THEN 'UNKNOWN'::text
               ELSE 'NA'::text
               END                                                                   AS fate,
           cl_fa.code                                                                AS fate_code,
           CASE
               WHEN cl_cn.code::text ~~ 'A%'::text THEN 'ALIVE'::text
               WHEN cl_cn.code::text ~~ 'D%'::text THEN 'DEAD'::text
               WHEN cl_cn.code::text ~~ 'U%'::text THEN 'UNKNOWN'::text
               ELSE 'NA'::text
               END                                                                   AS condition,
           cl_cn.code                                                                AS condition_code
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             JOIN ros_common.trip_vessel gvti ON t.id = gvti.trip_id
             JOIN ros_common.vessel vi ON gvti.vessel_id = vi.id
             JOIN refs_admin.countries cl_co ON vi.flag_code = cl_co.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON cl_co.code = fl.flag_code::bpchar
             JOIN ros_ll.fishing_events fe ON fe.trip_id = t.id
             LEFT JOIN ros_ll.setting_operations se ON fe.setting_operation_id = se.id
             JOIN ros_ll.catch_details ca ON ca.fishing_event_id = fe.id
             JOIN refs_biology.species cl_sp ON ca.species_code::text = cl_sp.code::text
             LEFT JOIN refs_biology.fates cl_fa ON ca.fates_code = cl_fa.code
             LEFT JOIN ros_ll.specimens sp ON sp.catch_detail_id = ca.id
             LEFT JOIN ros_common.additional_details_on_non_target_species adnt ON sp.additional_specimen_details_non_target_species_id = adnt.id
             LEFT JOIN refs_biology.incidental_captures_conditions cl_cn ON COALESCE(adnt.condition_at_capture_code, adnt.condition_at_release_code)::text = cl_cn.code::text
    WHERE od.vessel_type_code = 'LL'
    GROUP BY (COALESCE(fl.fleet_code, cl_co.code::character varying)), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)),
             (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude)), cl_sp.code, cl_sp.species_group_code,
             (
                 CASE
                     WHEN cl_fa.code ~~ 'R%'::text THEN 'RETAINED'::text
                     WHEN cl_fa.code ~~ 'D%'::text THEN 'DISCARDED'::text
                     WHEN cl_fa.code ~~ 'U%'::text THEN 'UNKNOWN'::text
                     ELSE 'NA'::text
                     END), cl_fa.code,
             (
                 CASE
                     WHEN cl_cn.code::text ~~ 'A%'::text THEN 'ALIVE'::text
                     WHEN cl_cn.code::text ~~ 'D%'::text THEN 'DEAD'::text
                     WHEN cl_cn.code::text ~~ 'U%'::text THEN 'UNKNOWN'::text
                     ELSE 'NA'::text
                     END), cl_cn.code;

create or replace view ros_analysis.v_ll_ef_sets(gear, flag, year, month, grid_1, grid_5, effort, effort_unit) as
    SELECT 'LL'::text                                                                AS gear,
           COALESCE(fl.fleet_code, cl_co.code::character varying)                    AS flag,
           date_part('year'::text, se.start_setting_date_and_time)                   AS year,
           date_part('month'::text, se.start_setting_date_and_time)                  AS month,
           ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
           ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
           count(DISTINCT fe.event_original_id)                                      AS effort,
           'SETS'::text                                                              AS effort_unit
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             JOIN ros_common.trip_vessel gvti ON t.id = gvti.trip_id
             JOIN ros_common.vessel vi ON gvti.vessel_id = vi.id
             JOIN refs_admin.countries cl_co ON vi.flag_code = cl_co.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON cl_co.code = fl.flag_code::bpchar
             JOIN ros_ll.fishing_events fe ON fe.trip_id = t.id
             LEFT JOIN ros_ll.setting_operations se ON fe.setting_operation_id = se.id
             LEFT JOIN ros_ll.hauling_operations ha ON fe.hauling_operation_id = ha.id
    WHERE od.vessel_type_code = 'LL' AND se.start_setting_date_and_time IS NOT NULL
    GROUP BY (COALESCE(fl.fleet_code, cl_co.code::character varying)), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)),
             (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude));

create or replace view ros_analysis.v_ll_ef_raw(gear, flag, year, month, grid_1, grid_5, observed_effort, effort_unit) as
    SELECT 'LL'::text                                                                AS gear,
           COALESCE(fl.fleet_code, cl_co.code::character varying)                    AS flag,
           date_part('year'::text, se.start_setting_date_and_time)                   AS year,
           date_part('month'::text, se.start_setting_date_and_time)                  AS month,
           ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
           ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
           sum(se.total_number_of_hooks_set)                                         AS observed_effort,
           'HOOKS'::text                                                             AS effort_unit
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             JOIN ros_common.trip_vessel gvti ON t.id = gvti.trip_id
             JOIN ros_common.vessel vi ON gvti.vessel_id = vi.id
             JOIN refs_admin.countries cl_co ON vi.flag_code = cl_co.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON cl_co.code = fl.flag_code::bpchar
             JOIN ros_ll.fishing_events fe ON fe.trip_id = t.id
             LEFT JOIN ros_ll.setting_operations se ON fe.setting_operation_id = se.id
             LEFT JOIN ros_ll.hauling_operations ha ON fe.hauling_operation_id = ha.id
    WHERE od.vessel_type_code = 'LL' AND se.start_setting_date_and_time IS NOT NULL
    GROUP BY (COALESCE(fl.fleet_code, cl_co.code::character varying)), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)),
             (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude));

create or replace view ros_analysis.v_ll_ef_fd(gear, flag, year, month, grid_1, grid_5, effort, effort_unit) as
    SELECT 'LL'::text                                                                AS gear,
           COALESCE(fl.fleet_code, cl_co.code::character varying)                    AS flag,
           date_part('year'::text, se.start_setting_date_and_time)                   AS year,
           date_part('month'::text, se.start_setting_date_and_time)                  AS month,
           ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
           ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
           count(DISTINCT date_part('day'::text, se.start_setting_date_and_time))    AS effort,
           'FDAYS'::text                                                             AS effort_unit
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             JOIN ros_common.trip_vessel gvti ON t.id = gvti.trip_id
             JOIN ros_common.vessel vi ON gvti.vessel_id = vi.id
             JOIN refs_admin.countries cl_co ON vi.flag_code = cl_co.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON cl_co.code = fl.flag_code::bpchar
             JOIN ros_ll.fishing_events fe ON fe.trip_id = t.id
             LEFT JOIN ros_ll.setting_operations se ON fe.setting_operation_id = se.id
             LEFT JOIN ros_ll.hauling_operations ha ON fe.hauling_operation_id = ha.id
    WHERE od.vessel_type_code = 'LL' AND se.start_setting_date_and_time IS NOT NULL
    GROUP BY (COALESCE(fl.fleet_code, cl_co.code::character varying)), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)),
             (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude));

create or replace view ros_analysis.v_ll_ef(gear, flag, year, month, grid_1, grid_5, observed_effort, effort_unit) as
    SELECT v_ll_ef_raw.gear,
           v_ll_ef_raw.flag,
           v_ll_ef_raw.year,
           v_ll_ef_raw.month,
           v_ll_ef_raw.grid_1,
           v_ll_ef_raw.grid_5,
           v_ll_ef_raw.observed_effort,
           v_ll_ef_raw.effort_unit
    FROM ros_analysis.v_ll_ef_raw
    UNION ALL
    SELECT v_ll_ef_fd.gear,
           v_ll_ef_fd.flag,
           v_ll_ef_fd.year,
           v_ll_ef_fd.month,
           v_ll_ef_fd.grid_1,
           v_ll_ef_fd.grid_5,
           v_ll_ef_fd.effort AS observed_effort,
           v_ll_ef_fd.effort_unit
    FROM ros_analysis.v_ll_ef_fd
    UNION ALL
    SELECT v_ll_ef_sets.gear,
           v_ll_ef_sets.flag,
           v_ll_ef_sets.year,
           v_ll_ef_sets.month,
           v_ll_ef_sets.grid_1,
           v_ll_ef_sets.grid_5,
           v_ll_ef_sets.effort AS observed_effort,
           v_ll_ef_sets.effort_unit
    FROM ros_analysis.v_ll_ef_sets;
create or replace view ros_analysis.v_ll_ca(gear, flag, year, month, grid_1, grid_5, species, species_group_code, fate, observed_catch, catch_unit) as
    SELECT 'LL'::text                                                                AS gear,
           COALESCE(fl.fleet_code, cl_co.code::character varying)                    AS flag,
           date_part('year'::text, se.start_setting_date_and_time)                   AS year,
           date_part('month'::text, se.start_setting_date_and_time)                  AS month,
           ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
           ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
           cl_sp.code                                                                AS species,
           cl_sp.species_group_code,
           cl_fa.code                                                                AS fate,
           count(DISTINCT sp.id)                                                     AS observed_catch,
           'NO'::text                                                                AS catch_unit
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             JOIN ros_common.trip_vessel gvti ON t.id = gvti.trip_id
             JOIN ros_common.vessel vi ON gvti.vessel_id = vi.id
             JOIN refs_admin.countries cl_co ON vi.flag_code = cl_co.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON cl_co.code = fl.flag_code::bpchar
             JOIN ros_ll.fishing_events fe ON fe.trip_id = t.id
             LEFT JOIN ros_ll.setting_operations se ON fe.setting_operation_id = se.id
             JOIN ros_ll.catch_details ca ON ca.fishing_event_id = fe.id
             JOIN refs_biology.species cl_sp ON ca.species_code::text = cl_sp.code::text
             LEFT JOIN refs_biology.fates cl_fa ON ca.fates_code = cl_fa.code
             JOIN ros_ll.specimens sp ON sp.catch_detail_id = ca.id
    WHERE od.vessel_type_code = 'LL' AND se.start_setting_date_and_time IS NOT NULL
    GROUP BY (COALESCE(fl.fleet_code, cl_co.code::character varying)), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)),
             (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude)), cl_sp.code, cl_sp.species_group_code, cl_fa.code;

create or replace view ros_analysis.v_in(gear, flag, year, month, grid_1, grid_5, species, species_group_code, num_interactions, fate, fate_code, condition, condition_code) as
    SELECT v_ll_in.gear,
           v_ll_in.flag,
           v_ll_in.year,
           v_ll_in.month,
           v_ll_in.grid_1,
           v_ll_in.grid_5,
           v_ll_in.species,
           v_ll_in.species_group_code,
           v_ll_in.num_interactions,
           v_ll_in.fate,
           v_ll_in.fate_code,
           v_ll_in.condition,
           v_ll_in.condition_code
    FROM ros_analysis.v_ll_in
    UNION ALL
    SELECT v_ps_in.gear,
           v_ps_in.flag,
           v_ps_in.year,
           v_ps_in.month,
           v_ps_in.grid_1,
           v_ps_in.grid_5,
           v_ps_in.species,
           v_ps_in.species_group_code,
           v_ps_in.num_interactions,
           v_ps_in.fate,
           v_ps_in.fate_code,
           v_ps_in.condition,
           v_ps_in.condition_code
    FROM ros_analysis.v_ps_in;

create or replace view ros_analysis.v_ef(gear, flag, year, month, grid_1, grid_5, observed_effort, effort_unit) as
    SELECT v_ll_ef.gear,
           v_ll_ef.flag,
           v_ll_ef.year,
           v_ll_ef.month,
           v_ll_ef.grid_1,
           v_ll_ef.grid_5,
           v_ll_ef.observed_effort,
           v_ll_ef.effort_unit
    FROM ros_analysis.v_ll_ef
    UNION ALL
    SELECT v_ps_ef.gear,
           v_ps_ef.flag,
           v_ps_ef.year,
           v_ps_ef.month,
           v_ps_ef.grid_1,
           v_ps_ef.grid_5,
           v_ps_ef.observed_effort,
           v_ps_ef.effort_unit
    FROM ros_analysis.v_ps_ef;

create or replace view ros_analysis.v_ca(gear, flag, year, month, grid_1, grid_5, species, species_group_code, fate, observed_catch, catch_unit) as
    SELECT v_ll_ca.gear,
           v_ll_ca.flag,
           v_ll_ca.year,
           v_ll_ca.month,
           v_ll_ca.grid_1,
           v_ll_ca.grid_5,
           v_ll_ca.species,
           v_ll_ca.species_group_code,
           v_ll_ca.fate,
           v_ll_ca.observed_catch,
           v_ll_ca.catch_unit
    FROM ros_analysis.v_ll_ca
    UNION ALL
    SELECT v_ps_ca.gear,
           v_ps_ca.flag,
           v_ps_ca.year,
           v_ps_ca.month,
           v_ps_ca.grid_1,
           v_ps_ca.grid_5,
           v_ps_ca.species,
           v_ps_ca.species_group_code,
           v_ps_ca.fate,
           v_ps_ca.observed_catch,
           v_ps_ca.catch_unit
    FROM ros_analysis.v_ps_ca;

create or replace view ros_analysis.v_sets_raw
            (flag_code, fleet_code, gear_code, fishery_code, fishery_group_code, fishery_type_code, trip_id, trip_uid, set_id, set_uid, event_type_code, start_time, start_lon, start_lat, end_time, end_lon, end_lat, effort, effort_unit_code) as
    SELECT v_ps_sets_raw.flag_code,
           v_ps_sets_raw.fleet_code,
           v_ps_sets_raw.gear_code,
           v_ps_sets_raw.fishery_code,
           v_ps_sets_raw.fishery_group_code,
           v_ps_sets_raw.fishery_type_code,
           v_ps_sets_raw.trip_id,
           v_ps_sets_raw.trip_uid,
           v_ps_sets_raw.set_id,
           v_ps_sets_raw.set_uid,
           v_ps_sets_raw.event_type_code,
           v_ps_sets_raw.start_time,
           v_ps_sets_raw.start_lon,
           v_ps_sets_raw.start_lat,
           v_ps_sets_raw.end_time,
           v_ps_sets_raw.end_lon,
           v_ps_sets_raw.end_lat,
           v_ps_sets_raw.effort,
           v_ps_sets_raw.effort_unit_code
    FROM ros_analysis.v_ps_sets_raw
    UNION ALL
    SELECT v_ll_sets_raw.flag_code,
           v_ll_sets_raw.fleet_code,
           v_ll_sets_raw.gear_code,
           v_ll_sets_raw.fishery_code,
           v_ll_sets_raw.fishery_group_code,
           v_ll_sets_raw.fishery_type_code,
           v_ll_sets_raw.trip_id,
           v_ll_sets_raw.trip_uid,
           v_ll_sets_raw.set_id,
           v_ll_sets_raw.set_uid,
           v_ll_sets_raw.event_type_code,
           v_ll_sets_raw.start_time,
           v_ll_sets_raw.start_lon,
           v_ll_sets_raw.start_lat,
           v_ll_sets_raw.end_time,
           v_ll_sets_raw.end_lon,
           v_ll_sets_raw.end_lat,
           v_ll_sets_raw.effort,
           v_ll_sets_raw.effort_unit_code
    FROM ros_analysis.v_ll_sets_raw;

create or replace view ros_analysis.v_ps_lw(gear, flag, year, month, grid_1, grid_5, species, species_group_code, fate, sex, length_code, length, length_unit, weight_type, weight, weight_unit) as
    SELECT 'PS'::text                                                                AS gear,
           COALESCE(fl.fleet_code, cl_co.code::character varying)                    AS flag,
           date_part('year'::text, se.start_setting_date_and_time)                   AS year,
           date_part('month'::text, se.start_setting_date_and_time)                  AS month,
           ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
           ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
           cl_sp.code                                                                AS species,
           cl_sp.species_group_code,
           cl_fa.code                                                                AS fate,
           cl_sx.code                                                                AS sex,
           cl_le.code                                                                AS length_code,
           ln.value                                                                  AS length,
           ln.unit                                                                   AS length_unit,
           cl_pt.code                                                                AS weight_type,
           ew.value                                                                  AS weight,
           ew.unit                                                                   AS weight_unit
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             JOIN ros_common.trip_vessel gvti ON t.id = gvti.trip_id
             JOIN ros_common.vessel vi ON gvti.vessel_id = vi.id
             JOIN refs_admin.countries cl_co ON vi.flag_code = cl_co.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON cl_co.code = fl.flag_code::bpchar
             JOIN ros_ps.fishing_events fe ON fe.trip_id = t.id
             LEFT JOIN ros_ps.setting_operations se ON fe.setting_operation_id = se.id
             JOIN ros_ps.catch_details ca ON ca.fishing_event_id = fe.id
             JOIN refs_biology.species cl_sp ON ca.species_code::text = cl_sp.code::text
             LEFT JOIN refs_biology.fates cl_fa ON ca.fates_code = cl_fa.code
             JOIN ros_ps.specimens sp ON sp.catch_detail_id = ca.id
             JOIN ros_common.biometric_information bi ON sp.biometric_information_id = bi.id
             LEFT JOIN refs_biology.sex cl_sx ON bi.sex_code = cl_sx.code
             JOIN ros_common.measured_lengths ln ON bi.measured_length_id = ln.id
             LEFT JOIN refs_biology.measurements cl_le ON ln.measured_length_type_code = cl_le.code
             JOIN ros_common.estimated_weights ew ON bi.estimated_weight_id = ew.id
             LEFT JOIN refs_fishery.fish_processing_types cl_pt ON ew.processing_type_code = cl_pt.code
WHERE od.vessel_type_code = 'SP';

create or replace view ros_analysis.v_ps_ce(gear, flag, year, month, grid_1, grid_5, observed_effort, effort_unit, species, species_group_code, fate, observed_catch, catch_unit) as
    SELECT e.gear,
           e.flag,
           e.year,
           e.month,
           e.grid_1,
           e.grid_5,
           e.observed_effort,
           e.effort_unit,
           c.species,
           c.species_group_code,
           c.fate,
           c.observed_catch,
           c.catch_unit
    FROM ros_analysis.v_ps_ef e
             LEFT JOIN ros_analysis.v_ps_ca c ON e.gear = c.gear AND e.flag::text = c.flag::text AND e.year = c.year AND e.month = c.month AND e.grid_1 = c.grid_1 AND e.grid_5 = c.grid_5;
--
-- create or replace view ros_analysis.v_observers(iotc_number, flag_code, last_name, first_name, nationality_code, active) as
--     WITH obs AS (SELECT ob.iotc_number,
--                         f.code AS flag_code,
--                         ob.last_name,
--                         ob.first_name,
--                         n.code AS nationality_code,
--                         ob.active
--                  FROM ros_meta.observers ob
--                           JOIN ros_meta.observers_2_flags o2f ON ob.iotc_number = o2f.iotc_number
--                           JOIN refs_admin.countries f ON o2f.flag_code = f.code
--                           JOIN refs_admin.countries n ON ob.nationality_code = n.code)
--     SELECT DISTINCT iotc_number,
--                     CASE
--                         WHEN iotc_number ~~ '%EUR%'::text THEN 'EUR'::bpchar
--                         ELSE flag_code
--                         END AS flag_code,
--                     last_name,
--                     first_name,
--                     nationality_code,
--                     active
--     FROM obs
--     WHERE iotc_number !~~ '%DUM%'::text
--       AND last_name::text !~~ '%DUMMY%'::text
--       AND last_name::text !~~ '%KEN ROS%'::text;

create or replace view ros_analysis.v_ll_ce(gear, flag, year, month, grid_1, grid_5, observed_effort, effort_unit, species, species_group_code, fate, observed_catch, catch_unit) as
    SELECT e.gear,
           e.flag,
           e.year,
           e.month,
           e.grid_1,
           e.grid_5,
           e.observed_effort,
           e.effort_unit,
           c.species,
           c.species_group_code,
           c.fate,
           c.observed_catch,
           c.catch_unit
    FROM ros_analysis.v_ll_ef e
             LEFT JOIN ros_analysis.v_ll_ca c ON e.gear = c.gear AND e.flag::text = c.flag::text AND e.year = c.year AND e.month = c.month AND e.grid_1 = c.grid_1 AND e.grid_5 = c.grid_5;

create or replace view ros_analysis.v_efforts_by_year_flag_and_gear(gear, flag, year, observed_effort, effort_unit) as
    SELECT 'LL'::text                                              AS gear,
           COALESCE(fl.fleet_code, cl_co.code::character varying)  AS flag,
           date_part('year'::text, se.start_setting_date_and_time) AS year,
           sum(se.total_number_of_hooks_set)                       AS observed_effort,
           'HOOK'::text                                            AS effort_unit
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             JOIN ros_common.trip_vessel gvti ON t.id = gvti.trip_id
             JOIN ros_common.vessel vi ON gvti.vessel_id = vi.id
             JOIN refs_admin.countries cl_co ON vi.flag_code = cl_co.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON cl_co.code = fl.flag_code::bpchar
             JOIN ros_ll.fishing_events fe ON fe.trip_id = t.id
             LEFT JOIN ros_ll.setting_operations se ON fe.setting_operation_id = se.id
             LEFT JOIN ros_ll.hauling_operations ha ON fe.hauling_operation_id = ha.id
    WHERE od.vessel_type_code = 'LL'
    GROUP BY (COALESCE(fl.fleet_code, cl_co.code::character varying)), (date_part('year'::text, se.start_setting_date_and_time))
    UNION ALL
    SELECT 'PS'::text                                              AS gear,
           COALESCE(fl.fleet_code, cl_co.code::character varying)  AS flag,
           date_part('year'::text, se.start_setting_date_and_time) AS year,
           count(DISTINCT se.id)                                   AS observed_effort,
           'SET'::text                                             AS effort_unit
    FROM ros_common.observer_data od
             JOIN ros_common.trip t ON od.id = t.observer_data_id
             JOIN ros_common.trip_vessel gvti ON t.id = gvti.trip_id
             JOIN ros_common.vessel vi ON gvti.vessel_id = vi.id
             JOIN refs_admin.countries cl_co ON vi.flag_code = cl_co.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON cl_co.code = fl.flag_code::bpchar
             JOIN ros_ps.fishing_events fe ON fe.trip_id = t.id
             LEFT JOIN ros_ps.setting_operations se ON fe.setting_operation_id = se.id
    WHERE od.vessel_type_code = 'SP'
    GROUP BY (COALESCE(fl.fleet_code, cl_co.code::character varying)), (date_part('year'::text, se.start_setting_date_and_time));

create or replace view ros_analysis.v_ef_raw(gear, flag, year, month, grid_1, grid_5, observed_effort, effort_unit) as
    SELECT v_ll_ef_raw.gear,
           v_ll_ef_raw.flag,
           v_ll_ef_raw.year,
           v_ll_ef_raw.month,
           v_ll_ef_raw.grid_1,
           v_ll_ef_raw.grid_5,
           v_ll_ef_raw.observed_effort,
           v_ll_ef_raw.effort_unit
    FROM ros_analysis.v_ll_ef_raw
    UNION ALL
    SELECT v_ps_ef_raw.gear,
           v_ps_ef_raw.flag,
           v_ps_ef_raw.year,
           v_ps_ef_raw.month,
           v_ps_ef_raw.grid_1,
           v_ps_ef_raw.grid_5,
           v_ps_ef_raw.observed_effort,
           v_ps_ef_raw.effort_unit
    FROM ros_analysis.v_ps_ef_raw;

create or replace view ros_analysis.v_ef_fd(gear, flag, year, month, grid_1, grid_5, effort, effort_unit) as
    SELECT v_ll_ef_fd.gear,
           v_ll_ef_fd.flag,
           v_ll_ef_fd.year,
           v_ll_ef_fd.month,
           v_ll_ef_fd.grid_1,
           v_ll_ef_fd.grid_5,
           v_ll_ef_fd.effort,
           v_ll_ef_fd.effort_unit
    FROM ros_analysis.v_ll_ef_fd
    UNION ALL
    SELECT v_ps_ef_fd.gear,
           v_ps_ef_fd.flag,
           v_ps_ef_fd.year,
           v_ps_ef_fd.month,
           v_ps_ef_fd.grid_1,
           v_ps_ef_fd.grid_5,
           v_ps_ef_fd.effort,
           v_ps_ef_fd.effort_unit
    FROM ros_analysis.v_ps_ef_fd;
create or replace view ros_analysis.v_ce(gear, flag, year, month, grid_1, grid_5, observed_effort, effort_unit, species, species_group_code, fate, observed_catch, catch_unit) as
    SELECT e.gear,
           e.flag,
           e.year,
           e.month,
           e.grid_1,
           e.grid_5,
           e.observed_effort,
           e.effort_unit,
           c.species,
           c.species_group_code,
           c.fate,
           c.observed_catch,
           c.catch_unit
    FROM ros_analysis.v_ef e
             LEFT JOIN ros_analysis.v_ca c ON e.gear = c.gear AND e.flag::text = c.flag::text AND e.year = c.year AND e.month = c.month AND e.grid_1 = c.grid_1 AND e.grid_5 = c.grid_5;

create or replace view ros_analysis.v_sets_by_year_flag_and_gear(year, flag, gear, num_sets) as
    SELECT year,
           flag,
           gear,
           num_sets
    FROM ros_meta.v_sets_by_year_flag_and_gear;

create or replace view ros_analysis.v_trips_by_year_flag_and_gear(year, flag, gear, num_trips) as
    SELECT year,
           flag,
           gear,
           sum(num_trips) AS num_trips
    FROM ros_meta.v_trips_by_year_flag_and_gear
    GROUP BY year, flag, gear;
