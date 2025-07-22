DROP VIEW IF EXISTS ros_rlibs.v_ce;
DROP VIEW IF EXISTS ros_rlibs.v_ca;
DROP VIEW IF EXISTS ros_rlibs.v_ef;
DROP VIEW IF EXISTS ros_rlibs.v_sf;
DROP VIEW IF EXISTS ros_rlibs.v_in;

DROP VIEW IF EXISTS ros_meta.v_sets_by_flag_and_gear CASCADE;
DROP VIEW IF EXISTS ros_meta.v_trips_by_flag_and_gear CASCADE;
DROP VIEW IF EXISTS ros_meta.v_trips_by_year_and_gear CASCADE;
DROP VIEW IF EXISTS ros_meta.v_sets_by_year_flag_and_gear CASCADE;
DROP VIEW IF EXISTS ros_meta.v_sets CASCADE;
DROP VIEW IF EXISTS ros_meta.v_ll_sets CASCADE;
DROP VIEW IF EXISTS ros_meta.v_ps_sets CASCADE;
DROP VIEW IF EXISTS ros_meta.v_sets_by_year_and_gear CASCADE;
DROP VIEW IF EXISTS ros_meta.v_ll_trips CASCADE;
DROP VIEW IF EXISTS ros_meta.v_ps_trips CASCADE;
DROP VIEW IF EXISTS ros_meta.v_gn_trips CASCADE;
DROP VIEW IF EXISTS ros_meta.v_pl_trips CASCADE;
DROP VIEW IF EXISTS ros_meta.v_trips CASCADE;
DROP VIEW IF EXISTS ros_meta.v_ll_fdays CASCADE;
DROP VIEW IF EXISTS ros_meta.v_ps_fdays CASCADE;
DROP VIEW IF EXISTS ros_meta.v_fdays CASCADE;
DROP VIEW IF EXISTS ros_meta.v_target_species_by_trip CASCADE;
DROP VIEW IF EXISTS ros_meta.v_trips_by_year_flag_and_gear CASCADE;
DROP VIEW IF EXISTS ros_meta.v_ll_hooks CASCADE;
DROP VIEW IF EXISTS ros_meta.v_efforts_m CASCADE;
DROP VIEW IF EXISTS ros_meta.v_fishing_days_by_year_flag_and_gear CASCADE;
DROP VIEW IF EXISTS ros_meta.v_ll_catches CASCADE;
DROP VIEW IF EXISTS ros_meta.v_ps_length_weight CASCADE;
DROP VIEW IF EXISTS ros_meta.v_ps_sf CASCADE;
DROP VIEW IF EXISTS ros_meta.v_ps_effort_summary CASCADE;
DROP VIEW IF EXISTS ros_meta.v_ll_effort_summary CASCADE;

DROP VIEW IF EXISTS ros_analysis.v_ll_sets_raw CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_ps_sets_raw CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_ca CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_ll_ca CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_ps_ca CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_ef CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_ll_ef CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_ll_ef_sets CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_ll_ef_fd CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_ll_ef_raw CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_ps_ef_raw CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_ps_ef_fd CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_ps_ef CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_ll_sf_l CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_ps_sf_l CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_sf CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_sf_l CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_ps_sf_w CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_ll_sf_w CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_sf_w CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_in CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_ps_in CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_ll_in CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_ef_raw CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_ef_fd CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_ce CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_ll_ce CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_ps_ce CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_trips_by_year_flag_and_gear CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_observers CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_observers_summary CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_sets_ CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_ll_sets_ CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_ps_sets_ CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_sets_by_year_flag_and_gear CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_efforts_by_year_flag_and_gear CASCADE;
DROP VIEW IF EXISTS ros_analysis.v_ps_lw CASCADE;

CREATE VIEW ros_meta.v_ll_sets
            (trip_id, trip_uid, set_id, fishing_operation_type, start_time, end_time, grid_1, grid_5, effort,
             total_effort, effort_unit)
as
    SELECT o.id                                                                     AS trip_id,
           o.uid                                                                    AS trip_uid,
           so.id                                                                    AS set_id,
           'LL'::text                                                               AS fishing_operation_type,
           COALESCE(ho.start_hauling_date_and_time, so.start_setting_date_and_time) AS start_time,
           COALESCE(ho.end_hauling_date_and_time, so.end_setting_date_and_time)     AS end_time,
           CASE
               WHEN ho.start_hauling_latitude IS NOT NULL AND ho.start_hauling_longitude IS NOT NULL
                   THEN ros_meta.to_grid_1(ho.start_hauling_latitude, ho.start_hauling_longitude)
               WHEN ho.end_hauling_latitude IS NOT NULL AND ho.end_hauling_longitude IS NOT NULL
                   THEN ros_meta.to_grid_1(ho.end_hauling_latitude, ho.end_hauling_longitude)
               WHEN so.start_setting_latitude IS NOT NULL AND so.start_setting_longitude IS NOT NULL
                   THEN ros_meta.to_grid_1(so.start_setting_latitude, so.start_setting_longitude)
               WHEN so.end_setting_latitude IS NOT NULL AND so.end_setting_longitude IS NOT NULL
                   THEN ros_meta.to_grid_1(so.end_setting_latitude, so.end_setting_longitude)
               ELSE NULL::bpchar
               END                                                                  AS grid_1,
           CASE
               WHEN ho.start_hauling_latitude IS NOT NULL AND ho.start_hauling_longitude IS NOT NULL
                   THEN ros_meta.to_grid_5(ho.start_hauling_latitude, ho.start_hauling_longitude)
               WHEN ho.end_hauling_latitude IS NOT NULL AND ho.end_hauling_longitude IS NOT NULL
                   THEN ros_meta.to_grid_5(ho.end_hauling_latitude, ho.end_hauling_longitude)
               WHEN so.start_setting_latitude IS NOT NULL AND so.start_setting_longitude IS NOT NULL
                   THEN ros_meta.to_grid_5(so.start_setting_latitude, so.start_setting_longitude)
               WHEN so.end_setting_latitude IS NOT NULL AND so.end_setting_longitude IS NOT NULL
                   THEN ros_meta.to_grid_5(so.end_setting_latitude, so.end_setting_longitude)
               ELSE NULL::bpchar
               END                                                                  AS grid_5,
           1                                                                        AS effort,
           1                                                                        AS total_effort,
           'SETS'::text                                                             AS effort_unit
    FROM ros_ll.observer_data o
             JOIN ros_common.general_vessel_and_trip_information gvt ON o.vessel_and_trip_information_id = gvt.id
             JOIN ros_ll.fishing_events fed ON fed.observer_data_id = o.id
             JOIN ros_ll.setting_operations so ON fed.setting_operation_id = so.id
             LEFT JOIN ros_ll.hauling_operations ho ON fed.hauling_operation_id = ho.id;

CREATE VIEW ros_meta.v_ps_sets
            (trip_id, trip_uid, set_id, fishing_operation_type, start_time, end_time, grid_1, grid_5, effort,
             total_effort, effort_unit)
as
    SELECT o.id                                                                      AS trip_id,
           o.uid                                                                     AS trip_uid,
           so.id                                                                     AS set_id,
           'PS'::text                                                                AS fishing_operation_type,
           COALESCE(so.start_setting_date_and_time, so.time_start_brailing)          AS start_time,
           COALESCE(so.time_start_brailing, so.time_net_pursed)                      AS end_time,
           ros_meta.to_grid_1(so.start_setting_latitude, so.start_setting_longitude) AS grid_1,
           ros_meta.to_grid_5(so.start_setting_latitude, so.start_setting_longitude) AS grid_5,
           1                                                                         AS effort,
           1                                                                         AS total_effort,
           'SETS'::text                                                              AS effort_unit
    FROM ros_ps.observer_data o
             JOIN ros_common.general_vessel_and_trip_information gvt ON o.vessel_and_trip_information_id = gvt.id
             JOIN ros_ps.fishing_events fed ON fed.observer_data_id = o.id
             LEFT JOIN ros_ps.setting_operations so ON fed.setting_operation_id = so.id;

CREATE VIEW ros_meta.v_sets
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

CREATE VIEW ros_meta.v_sets_by_year_and_gear(year, ps, ll) as
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

CREATE VIEW ros_meta.v_ll_trips
            (source, trip_id, trip_uid, trip_number, creation_date, finalization_date, submission_date,
             has_observer_trip_info, fishing_operation_type, observer_iotc_number, observer_nationality,
             observer_imbarcation_date, observer_disembarcation_date, vessel_info_id, vessel_iotc_number, main_gear,
             reporting_flag, vessel_flag, vessel_departure_date, vessel_departure_port, vessel_departure_country,
             vessel_return_date, vessel_return_port, vessel_return_country)
as
    SELECT ll_o_d.source,
           ll_o_d.id                             AS trip_id,
           ll_o_d.uid                            AS trip_uid,
           gvt.trip_number,
           ll_o_d.creation_time                  AS creation_date,
           ll_o_d.finalization_time              AS finalization_date,
           ll_o_d.submission_time                AS submission_date,
           CASE
               WHEN otd.id IS NULL THEN 0
               ELSE 1
               END                               AS has_observer_trip_info,
           'LL'::text                            AS fishing_operation_type,
           oi.iotc_number                        AS observer_iotc_number,
           n.code                                AS observer_nationality,
           otd.date_time_embarkation             AS observer_imbarcation_date,
           otd.date_time_disembarkation          AS observer_disembarcation_date,
           vi.id                                 AS vessel_info_id,
           vi.iotc_number                        AS vessel_iotc_number,
           g.code                                AS main_gear,
           r.code                                AS reporting_flag,
           f.code                                AS vessel_flag,
           vtd.date_time_vessel_sailed           AS vessel_departure_date,
           pd.name_en                            AS vessel_departure_port,
           cd.code                               AS vessel_departure_country,
           vtd.date_time_vessel_returned_to_port AS vessel_return_date,
           pr.name_en                            AS vessel_return_port,
           cr.code                               AS vessel_return_country
    FROM ros_ll.observer_data ll_o_d
             JOIN ros_common.general_vessel_and_trip_information gvt ON ll_o_d.vessel_and_trip_information_id = gvt.id
             LEFT JOIN ros_common.observer_identification oi ON gvt.observer_identification_id = oi.id
             LEFT JOIN refs_admin.countries n ON oi.nationality_code = n.code
             LEFT JOIN ros_common.observer_trip_details otd ON gvt.observer_trip_detail_id = otd.id
             LEFT JOIN ros_common.vessel_identification vi ON gvt.vessel_identification_id = vi.id
             LEFT JOIN ros_common.vessel_trip_details vtd ON gvt.vessel_trip_details_id = vtd.id
             LEFT JOIN refs_fishery_config.gears g ON vi.main_fishing_gear_code::text = g.code::text
             LEFT JOIN refs_admin.countries f ON vi.flag_code = f.code
             LEFT JOIN refs_admin.countries r ON ll_o_d.reporting_country_code = r.code
             LEFT JOIN refs_admin.ports pd ON vtd.departure_port_code::text = pd.code::text
             LEFT JOIN refs_admin.countries cd ON pd.country_code::bpchar = cd.code
             LEFT JOIN refs_admin.ports pr ON vtd.return_port_code::text = pr.code::text
             LEFT JOIN refs_admin.countries cr ON pr.country_code::bpchar = cr.code;

CREATE VIEW ros_meta.v_ps_trips
            (source, trip_id, trip_uid, trip_number, creation_date, finalization_date, submission_date,
             has_observer_trip_info, fishing_operation_type, observer_iotc_number, observer_nationality,
             observer_imbarcation_date, observer_disembarcation_date, vessel_info_id, vessel_iotc_number, main_gear,
             reporting_flag, vessel_flag, vessel_departure_date, vessel_departure_port, vessel_departure_country,
             vessel_return_date, vessel_return_port, vessel_return_country)
as
    SELECT ps_o_d.source,
           ps_o_d.id                             AS trip_id,
           ps_o_d.uid                            AS trip_uid,
           gvt.trip_number,
           ps_o_d.creation_time                  AS creation_date,
           ps_o_d.finalization_time              AS finalization_date,
           ps_o_d.submission_time                AS submission_date,
           CASE
               WHEN otd.id IS NULL THEN 0
               ELSE 1
               END                               AS has_observer_trip_info,
           'PS'::text                            AS fishing_operation_type,
           oi.iotc_number                        AS observer_iotc_number,
           n.code                                AS observer_nationality,
           otd.date_time_embarkation             AS observer_imbarcation_date,
           otd.date_time_disembarkation          AS observer_disembarcation_date,
           vi.id                                 AS vessel_info_id,
           vi.iotc_number                        AS vessel_iotc_number,
           g.code                                AS main_gear,
           r.code                                AS reporting_flag,
           f.code                                AS vessel_flag,
           vtd.date_time_vessel_sailed           AS vessel_departure_date,
           pd.name_en                            AS vessel_departure_port,
           cd.code                               AS vessel_departure_country,
           vtd.date_time_vessel_returned_to_port AS vessel_return_date,
           pr.name_en                            AS vessel_return_port,
           cr.code                               AS vessel_return_country
    FROM ros_ps.observer_data ps_o_d
             JOIN ros_common.general_vessel_and_trip_information gvt ON ps_o_d.vessel_and_trip_information_id = gvt.id
             LEFT JOIN ros_common.observer_identification oi ON gvt.observer_identification_id = oi.id
             LEFT JOIN refs_admin.countries n ON oi.nationality_code = n.code
             LEFT JOIN ros_common.observer_trip_details otd ON gvt.observer_trip_detail_id = otd.id
             LEFT JOIN ros_common.vessel_identification vi ON gvt.vessel_identification_id = vi.id
             LEFT JOIN ros_common.vessel_trip_details vtd ON gvt.vessel_trip_details_id = vtd.id
             LEFT JOIN refs_fishery_config.gears g ON vi.main_fishing_gear_code::text = g.code::text
             LEFT JOIN refs_admin.countries f ON vi.flag_code = f.code
             LEFT JOIN refs_admin.countries r ON ps_o_d.reporting_country_code = r.code
             LEFT JOIN refs_admin.ports pd ON vtd.departure_port_code::text = pd.code::text
             LEFT JOIN refs_admin.countries cd ON pd.country_code::bpchar = cd.code
             LEFT JOIN refs_admin.ports pr ON vtd.return_port_code::text = pr.code::text
             LEFT JOIN refs_admin.countries cr ON pr.country_code::bpchar = cr.code;

CREATE VIEW ros_meta.v_gn_trips
            (source, trip_id, trip_uid, trip_number, creation_date, finalization_date, submission_date,
             has_observer_trip_info, fishing_operation_type, observer_iotc_number, observer_nationality,
             observer_imbarcation_date, observer_disembarcation_date, vessel_info_id, vessel_iotc_number, main_gear,
             reporting_flag, vessel_flag, vessel_departure_date, vessel_departure_port, vessel_departure_country,
             vessel_return_date, vessel_return_port, vessel_return_country)
as
    SELECT gn_o_d.source,
           gn_o_d.id                             AS trip_id,
           gn_o_d.uid                            AS trip_uid,
           gvt.trip_number,
           gn_o_d.creation_time                  AS creation_date,
           gn_o_d.finalization_time              AS finalization_date,
           gn_o_d.submission_time                AS submission_date,
           CASE
               WHEN otd.id IS NULL THEN 0
               ELSE 1
               END                               AS has_observer_trip_info,
           'GN'::text                            AS fishing_operation_type,
           oi.iotc_number                        AS observer_iotc_number,
           n.code                                AS observer_nationality,
           otd.date_time_embarkation             AS observer_imbarcation_date,
           otd.date_time_disembarkation          AS observer_disembarcation_date,
           vi.id                                 AS vessel_info_id,
           vi.iotc_number                        AS vessel_iotc_number,
           g.code                                AS main_gear,
           r.code                                AS reporting_flag,
           f.code                                AS vessel_flag,
           vtd.date_time_vessel_sailed           AS vessel_departure_date,
           pd.name_en                            AS vessel_departure_port,
           cd.code                               AS vessel_departure_country,
           vtd.date_time_vessel_returned_to_port AS vessel_return_date,
           pr.name_en                            AS vessel_return_port,
           cr.code                               AS vessel_return_country
    FROM ros_gn.observer_data gn_o_d
             JOIN ros_common.general_vessel_and_trip_information gvt ON gn_o_d.vessel_and_trip_information_id = gvt.id
             LEFT JOIN ros_common.observer_identification oi ON gvt.observer_identification_id = oi.id
             LEFT JOIN refs_admin.countries n ON oi.nationality_code = n.code
             LEFT JOIN ros_common.observer_trip_details otd ON gvt.observer_trip_detail_id = otd.id
             LEFT JOIN ros_common.vessel_identification vi ON gvt.vessel_identification_id = vi.id
             LEFT JOIN ros_common.vessel_trip_details vtd ON gvt.vessel_trip_details_id = vtd.id
             LEFT JOIN refs_fishery_config.gears g ON vi.main_fishing_gear_code::text = g.code::text
             LEFT JOIN refs_admin.countries f ON vi.flag_code = f.code
             LEFT JOIN refs_admin.countries r ON gn_o_d.reporting_country_code = r.code
             LEFT JOIN refs_admin.ports pd ON vtd.departure_port_code::text = pd.code::text
             LEFT JOIN refs_admin.countries cd ON pd.country_code::bpchar = cd.code
             LEFT JOIN refs_admin.ports pr ON vtd.return_port_code::text = pr.code::text
             LEFT JOIN refs_admin.countries cr ON pr.country_code::bpchar = cr.code;

CREATE VIEW ros_meta.v_pl_trips
            (source, trip_id, trip_uid, trip_number, creation_date, finalization_date, submission_date,
             has_observer_trip_info, fishing_operation_type, observer_iotc_number, observer_nationality,
             observer_imbarcation_date, observer_disembarcation_date, vessel_info_id, vessel_iotc_number, main_gear,
             reporting_flag, vessel_flag, vessel_departure_date, vessel_departure_port, vessel_departure_country,
             vessel_return_date, vessel_return_port, vessel_return_country)
as
    SELECT pl_o_d.source,
           pl_o_d.id                             AS trip_id,
           pl_o_d.uid                            AS trip_uid,
           gvt.trip_number,
           pl_o_d.creation_time                  AS creation_date,
           pl_o_d.finalization_time              AS finalization_date,
           pl_o_d.submission_time                AS submission_date,
           CASE
               WHEN otd.id IS NULL THEN 0
               ELSE 1
               END                               AS has_observer_trip_info,
           'PL'::text                            AS fishing_operation_type,
           oi.iotc_number                        AS observer_iotc_number,
           n.code                                AS observer_nationality,
           otd.date_time_embarkation             AS observer_imbarcation_date,
           otd.date_time_disembarkation          AS observer_disembarcation_date,
           vi.id                                 AS vessel_info_id,
           vi.iotc_number                        AS vessel_iotc_number,
           g.code                                AS main_gear,
           r.code                                AS reporting_flag,
           f.code                                AS vessel_flag,
           vtd.date_time_vessel_sailed           AS vessel_departure_date,
           pd.name_en                            AS vessel_departure_port,
           cd.code                               AS vessel_departure_country,
           vtd.date_time_vessel_returned_to_port AS vessel_return_date,
           pr.name_en                            AS vessel_return_port,
           cr.code                               AS vessel_return_country
    FROM ros_pl.observer_data pl_o_d
             JOIN ros_common.general_vessel_and_trip_information gvt ON pl_o_d.vessel_and_trip_information_id = gvt.id
             LEFT JOIN ros_common.observer_identification oi ON gvt.observer_identification_id = oi.id
             LEFT JOIN refs_admin.countries n ON oi.nationality_code = n.code
             LEFT JOIN ros_common.observer_trip_details otd ON gvt.observer_trip_detail_id = otd.id
             LEFT JOIN ros_common.vessel_identification vi ON gvt.vessel_identification_id = vi.id
             LEFT JOIN ros_common.vessel_trip_details vtd ON gvt.vessel_trip_details_id = vtd.id
             LEFT JOIN refs_fishery_config.gears g ON vi.main_fishing_gear_code::text = g.code::text
             LEFT JOIN refs_admin.countries f ON vi.flag_code = f.code
             LEFT JOIN refs_admin.countries r ON pl_o_d.reporting_country_code = r.code
             LEFT JOIN refs_admin.ports pd ON vtd.departure_port_code::text = pd.code::text
             LEFT JOIN refs_admin.countries cd ON pd.country_code::bpchar = cd.code
             LEFT JOIN refs_admin.ports pr ON vtd.return_port_code::text = pr.code::text
             LEFT JOIN refs_admin.countries cr ON pr.country_code::bpchar = cr.code;

CREATE VIEW ros_meta.v_trips
            (source, trip_id, trip_uid, trip_number, creation_date, finalization_date, submission_date,
             has_observer_trip_info, fishing_operation_type, observer_iotc_number, observer_nationality,
             observer_imbarcation_date, observer_disembarcation_date, vessel_info_id, vessel_iotc_number, main_gear,
             reporting_flag, vessel_flag, vessel_departure_date, vessel_departure_port, vessel_departure_country,
             vessel_return_date, vessel_return_port, vessel_return_country)
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
           v_ll_trips.observer_nationality,
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
           v_ps_trips.observer_nationality,
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
           v_gn_trips.observer_nationality,
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
           v_pl_trips.observer_nationality,
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

CREATE VIEW ros_meta.v_trips_by_flag_and_gear(flag, gear, num_trips) as
    SELECT CASE
               WHEN reporting_flag = ANY (ARRAY ['FRA'::bpchar, 'ESP'::bpchar]) THEN concat('EU.', reporting_flag)::bpchar
               ELSE reporting_flag
               END                AS flag,
           fishing_operation_type AS gear,
           count(*)               AS num_trips
    FROM ros_meta.v_trips t
    GROUP BY reporting_flag, fishing_operation_type;

CREATE VIEW ros_meta.v_trips_by_year_and_gear(year, ps, ll) as
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

CREATE VIEW ros_meta.v_ll_fdays
            (trip_id, trip_uid, fishing_operation_type, year, month, grid_1, grid_5, effort, effort_unit) as
    SELECT od.id                                                                         AS trip_id,
           od.uid                                                                        AS trip_uid,
           'LL'::text                                                                    AS fishing_operation_type,
           date_part('year'::text, s.start_setting_date_and_time)                        AS year,
           date_part('month'::text, s.start_setting_date_and_time)                       AS month,
           ros_meta.to_grid_1(s.start_setting_latitude, s.end_setting_latitude)          AS grid_1,
           ros_meta.to_grid_5(s.start_setting_latitude, s.end_setting_latitude)          AS grid_5,
           count(DISTINCT concat(date_part('month'::text, s.start_setting_date_and_time), '/',
                                 date_part('day'::text, s.start_setting_date_and_time))) AS effort,
           'FDAYS'::text                                                                 AS effort_unit
    FROM ros_ll.observer_data od
             JOIN ros_ll.fishing_events fe ON fe.observer_data_id = od.id
             JOIN ros_ll.setting_operations s ON fe.setting_operation_id = s.id
    GROUP BY od.id, od.uid, (date_part('year'::text, s.start_setting_date_and_time)),
             (date_part('month'::text, s.start_setting_date_and_time)),
             (ros_meta.to_grid_1(s.start_setting_latitude, s.end_setting_latitude)),
             (ros_meta.to_grid_5(s.start_setting_latitude, s.end_setting_latitude));

CREATE VIEW ros_meta.v_ps_fdays
            (trip_id, trip_uid, fishing_operation_type, year, month, grid_1, grid_5, effort, effort_unit) as
    SELECT od.id                                                                         AS trip_id,
           od.uid                                                                        AS trip_uid,
           'PS'::text                                                                    AS fishing_operation_type,
           date_part('year'::text, s.start_setting_date_and_time)                        AS year,
           date_part('month'::text, s.start_setting_date_and_time)                       AS month,
           ros_meta.to_grid_1(s.start_setting_latitude, s.start_setting_longitude)       AS grid_1,
           ros_meta.to_grid_5(s.start_setting_latitude, s.start_setting_longitude)       AS grid_5,
           count(DISTINCT concat(date_part('month'::text, s.start_setting_date_and_time), '/',
                                 date_part('day'::text, s.start_setting_date_and_time))) AS effort,
           'FDAYS'::text                                                                 AS effort_unit
    FROM ros_ps.observer_data od
             JOIN ros_ps.fishing_events fe ON fe.observer_data_id = od.id
             JOIN ros_ps.setting_operations s ON fe.setting_operation_id = s.id
    GROUP BY od.id, od.uid, (date_part('year'::text, s.start_setting_date_and_time)),
             (date_part('month'::text, s.start_setting_date_and_time)),
             (ros_meta.to_grid_1(s.start_setting_latitude, s.start_setting_longitude)),
             (ros_meta.to_grid_5(s.start_setting_latitude, s.start_setting_longitude));

CREATE VIEW ros_meta.v_fdays
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

CREATE VIEW ros_meta.v_target_species_by_trip
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
             LEFT JOIN ros_common.vessel_identification vi ON t.vessel_info_id = vi.id
             LEFT JOIN ros_common.vessel_identification_licensed_target_species vi2lts
                       ON vi2lts.vessel_identification_id = vi.id
             LEFT JOIN refs_biological.species s_t ON vi2lts.licensed_target_species_code::text = s_t.code::text;

CREATE VIEW ros_meta.v_trips_by_year_flag_and_gear(source, year, flag, gear, num_trips) as
    SELECT source,
           date_part('year'::text, COALESCE(vessel_departure_date, vessel_return_date)) AS year,
           CASE
               WHEN reporting_flag = ANY (ARRAY ['FRA'::bpchar, 'ESP'::bpchar]) THEN concat('EU.', reporting_flag)::bpchar
               ELSE reporting_flag
               END                                                                      AS flag,
           fishing_operation_type                                                       AS gear,
           count(*)                                                                     AS num_trips
    FROM ros_meta.v_trips t
    GROUP BY source, (date_part('year'::text, COALESCE(vessel_departure_date, vessel_return_date))), reporting_flag,
             fishing_operation_type;

CREATE VIEW ros_meta.v_ll_hooks
            (trip_id, trip_uid, set_id, fishing_operation_type, start_time, end_time, grid_1, grid_5, effort,
             total_effort, effort_unit)
as
    SELECT o.id                                                                     AS trip_id,
           o.uid                                                                    AS trip_uid,
           so.id                                                                    AS set_id,
           'LL'::text                                                               AS fishing_operation_type,
           COALESCE(ho.start_hauling_date_and_time, so.start_setting_date_and_time) AS start_time,
           COALESCE(ho.end_hauling_date_and_time, so.end_setting_date_and_time)     AS end_time,
           CASE
               WHEN ho.start_hauling_latitude IS NOT NULL AND ho.start_hauling_longitude IS NOT NULL
                   THEN ros_meta.to_grid_1(ho.start_hauling_latitude, ho.start_hauling_longitude)
               WHEN ho.end_hauling_latitude IS NOT NULL AND ho.end_hauling_longitude IS NOT NULL
                   THEN ros_meta.to_grid_1(ho.end_hauling_latitude, ho.end_hauling_longitude)
               WHEN so.start_setting_latitude IS NOT NULL AND so.start_setting_longitude IS NOT NULL
                   THEN ros_meta.to_grid_1(so.start_setting_latitude, so.start_setting_longitude)
               WHEN so.end_setting_latitude IS NOT NULL AND so.end_setting_longitude IS NOT NULL
                   THEN ros_meta.to_grid_1(so.end_setting_latitude, so.end_setting_longitude)
               ELSE NULL::bpchar
               END                                                                  AS grid_1,
           CASE
               WHEN ho.start_hauling_latitude IS NOT NULL AND ho.start_hauling_longitude IS NOT NULL
                   THEN ros_meta.to_grid_5(ho.start_hauling_latitude, ho.start_hauling_longitude)
               WHEN ho.end_hauling_latitude IS NOT NULL AND ho.end_hauling_longitude IS NOT NULL
                   THEN ros_meta.to_grid_5(ho.end_hauling_latitude, ho.end_hauling_longitude)
               WHEN so.start_setting_latitude IS NOT NULL AND so.start_setting_longitude IS NOT NULL
                   THEN ros_meta.to_grid_5(so.start_setting_latitude, so.start_setting_longitude)
               WHEN so.end_setting_latitude IS NOT NULL AND so.end_setting_longitude IS NOT NULL
                   THEN ros_meta.to_grid_5(so.end_setting_latitude, so.end_setting_longitude)
               ELSE NULL::bpchar
               END                                                                  AS grid_5,
           COALESCE(ho.number_of_hooks_observed, so.total_number_of_hooks_set)      AS effort,
           COALESCE(so.total_number_of_hooks_set, ho.number_of_hooks_observed)      AS total_effort,
           'HOOKS'::text                                                            AS effort_unit
    FROM ros_ll.observer_data o
             JOIN ros_common.general_vessel_and_trip_information gvt ON o.vessel_and_trip_information_id = gvt.id
             JOIN ros_ll.fishing_events fed ON fed.observer_data_id = o.id
             JOIN ros_ll.setting_operations so ON fed.setting_operation_id = so.id
             LEFT JOIN ros_ll.hauling_operations ho ON fed.hauling_operation_id = ho.id;

CREATE VIEW ros_meta.v_efforts_m (year, month, grid_1, grid_5, fishing_operation_type, effort, effort_unit) as
    SELECT date_part('year'::text, v_sets.start_time)  AS year,
           date_part('month'::text, v_sets.start_time) AS month,
           v_sets.grid_1,
           v_sets.grid_5,
           v_sets.fishing_operation_type,
           sum(v_sets.effort)                          AS effort,
           v_sets.effort_unit
    FROM ros_meta.v_sets
    GROUP BY (date_part('year'::text, v_sets.start_time)), (date_part('month'::text, v_sets.start_time)), v_sets.grid_1,
             v_sets.grid_5, v_sets.fishing_operation_type, v_sets.effort_unit
    UNION ALL
    SELECT v_fdays.year,
           v_fdays.month,
           v_fdays.grid_1,
           v_fdays.grid_5,
           v_fdays.fishing_operation_type,
           sum(v_fdays.effort) AS effort,
           v_fdays.effort_unit
    FROM ros_meta.v_fdays
    GROUP BY v_fdays.year, v_fdays.month, v_fdays.grid_1, v_fdays.grid_5, v_fdays.fishing_operation_type,
             v_fdays.effort_unit
    UNION ALL
    SELECT date_part('year'::text, v_ll_hooks.start_time)  AS year,
           date_part('month'::text, v_ll_hooks.start_time) AS month,
           v_ll_hooks.grid_1,
           v_ll_hooks.grid_5,
           v_ll_hooks.fishing_operation_type,
           sum(v_ll_hooks.effort)                          AS effort,
           v_ll_hooks.effort_unit
    FROM ros_meta.v_ll_hooks
    GROUP BY (date_part('year'::text, v_ll_hooks.start_time)), (date_part('month'::text, v_ll_hooks.start_time)),
             v_ll_hooks.grid_1, v_ll_hooks.grid_5, v_ll_hooks.fishing_operation_type, v_ll_hooks.effort_unit;

CREATE VIEW ros_meta.v_sets_by_flag_and_gear(flag, gear, num_sets) as
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

CREATE VIEW ros_meta.v_sets_by_year_flag_and_gear(year, flag, gear, num_sets) as
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

CREATE VIEW ros_meta.v_fishing_days_by_year_flag_and_gear(year, flag, gear, fishing_days) as
    WITH ps AS (SELECT date_part('year'::text, s.start_setting_date_and_time)                        AS year,
                       c.code                                                                        AS flag,
                       'PS'::text                                                                    AS gear,
                       count(DISTINCT concat(date_part('month'::text, s.start_setting_date_and_time), '-',
                                             date_part('day'::text, s.start_setting_date_and_time))) AS fishing_days
                FROM ros_ps.observer_data od
                         JOIN ros_common.general_vessel_and_trip_information gvt
                              ON od.vessel_and_trip_information_id = gvt.id
                         JOIN ros_ps.fishing_events fe ON fe.observer_data_id = od.id
                         JOIN ros_ps.setting_operations s ON fe.setting_operation_id = s.id
                         JOIN ros_common.vessel_identification vi ON gvt.vessel_identification_id = vi.id
                         JOIN refs_admin.countries c ON vi.flag_code = c.code
                GROUP BY c.code, (date_part('year'::text, s.start_setting_date_and_time))),
         ll AS (SELECT date_part('year'::text, s.start_setting_date_and_time)                        AS year,
                       c.code                                                                        AS flag,
                       'LL'::text                                                                    AS gear,
                       count(DISTINCT concat(date_part('month'::text, s.start_setting_date_and_time), '-',
                                             date_part('day'::text, s.start_setting_date_and_time))) AS fishing_days
                FROM ros_ll.observer_data od
                         JOIN ros_common.general_vessel_and_trip_information gvt
                              ON od.vessel_and_trip_information_id = gvt.id
                         JOIN ros_ll.fishing_events fe ON fe.observer_data_id = od.id
                         JOIN ros_ll.setting_operations s ON fe.setting_operation_id = s.id
                         JOIN ros_common.vessel_identification vi ON gvt.vessel_identification_id = vi.id
                         JOIN refs_admin.countries c ON vi.flag_code = c.code
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

CREATE VIEW ros_meta.v_ll_catches
            (trip_id, trip_uid, set_id, set_number, fishing_operation_type, species, "TYPE", fate, quantity,
             quantity_sampled, unit)
as
    SELECT o.id            AS trip_id,
           o.uid           AS trip_uid,
           fe.id           AS set_id,
           fe.event_number AS set_number,
           'LL'::text      AS fishing_operation_type,
           sp.code         AS species,
           'RC'::text      AS "TYPE",
           CASE
               WHEN f.code IS NULL THEN NULL::text
               ELSE concat(f.code, ' - ', f.name_en)
               END         AS fate,
           count(cd.id)    AS quantity,
           count(cd.id)    AS quantity_sampled,
           'NO'::text      AS unit
    FROM ros_ll.observer_data o
             JOIN ros_ll.fishing_events fe ON fe.observer_data_id = o.id
             JOIN ros_ll.setting_operations s ON fe.setting_operation_id = s.id
             JOIN ros_ll.catch_details cd ON cd.fishing_event_id = fe.id
             JOIN refs_biological.species sp ON cd.species_code::text = sp.code::text
             LEFT JOIN refs_biological.fates f ON cd.fates_code = f.code
    WHERE f.code ~~ 'R%'::text
    GROUP BY o.id, o.uid, fe.id, fe.event_number, sp.code,
             (
                 CASE
                     WHEN f.code IS NULL THEN NULL::text
                     ELSE concat(f.code, ' - ', f.name_en)
                     END);

CREATE VIEW ros_meta.v_ps_length_weight
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
                                         WHEN lt.name_en IS NULL AND l.value IS NOT NULL
                                             THEN 'Unknown'::character varying
                                         ELSE lt.name_en
                                         END                                           AS length_type,
                                     l.value                                           AS length,
                                     CASE
                                         WHEN alt.code IS NULL AND al.value IS NOT NULL THEN 'UNK'::bpchar
                                         ELSE alt.code
                                         END::character varying(16)                    AS additional_length_type_code,
                                     CASE
                                         WHEN alt.name_en IS NULL AND al.value IS NOT NULL
                                             THEN 'Unknown'::character varying
                                         ELSE alt.name_en
                                         END::character varying(255)                   AS additional_length_type,
                                     al.value                                          AS additional_length,
                                     CASE
                                         WHEN wp.code IS NULL AND w.value IS NOT NULL THEN 'UNK'::bpchar
                                         ELSE wp.code
                                         END                                           AS weight_type_code,
                                     CASE
                                         WHEN wp.name_en IS NULL AND w.value IS NOT NULL
                                             THEN 'Unknown'::character varying
                                         ELSE wp.name_en
                                         END                                           AS weight_type,
                                     w.value                                           AS weight_value,
                                     w.unit                                            AS weight_unit
                              FROM ros_ps.fishing_events fe_1
                                       JOIN ros_ps.setting_operations s ON fe_1.setting_operation_id = s.id
                                       JOIN ros_ps.catch_details c_1 ON c_1.fishing_event_id = s.id
                                       JOIN refs_biological.species sp ON c_1.species_code::text = sp.code::text
                                       JOIN refs_biological.fates f ON c_1.fates_code = f.code
                                       JOIN ros_ps.specimens spc ON spc.catch_detail_id = c_1.id
                                       LEFT JOIN ros_common.biometric_information b
                                                 ON spc.biometric_information_id = b.id
                                       LEFT JOIN refs_biological.sex x ON b.sex_code = x.code
                                       LEFT JOIN ros_common.measured_lengths l ON b.measured_length_id = l.id
                                       LEFT JOIN refs_biological.measurements lt
                                                 ON l.measured_length_type_code = lt.code
                                       LEFT JOIN ros_common.measured_lengths al
                                                 ON b.alternative_measured_length_id = al.id
                                       LEFT JOIN refs_biological.measurements alt
                                                 ON al.measured_length_type_code = alt.code
                                       LEFT JOIN ros_common.estimated_weights w ON b.estimated_weight_id = w.id
                                       LEFT JOIN refs_fishery.fish_processing_types wp
                                                 ON w.weight_estimation_method_code = wp.code
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
    FROM ros_ps.observer_data od
             JOIN ros_common.general_vessel_and_trip_information gvt ON od.vessel_and_trip_information_id = gvt.id
             LEFT JOIN ros_common.vessel_identification vi ON gvt.vessel_identification_id = vi.id
             LEFT JOIN refs_admin.countries c ON vi.flag_code = c.code
             JOIN ros_ps.fishing_events fe ON fe.observer_data_id = od.id
             JOIN ros_ps.setting_operations so ON fe.setting_operation_id = so.id
             JOIN ps_length_weight lw ON lw.set_id = so.id;

CREATE VIEW ros_meta.v_ps_sf
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
             JOIN refs_biological.species s ON c.species_code::text = s.code::text
             JOIN refs_biological.fates f ON c.fates_code = f.code
             JOIN ros_ps.specimens sp ON sp.catch_detail_id = c.id
             JOIN ros_common.biometric_information b ON sp.biometric_information_id = b.id
             JOIN ros_common.measured_lengths l ON b.measured_length_id = l.id
             LEFT JOIN refs_biological.measurements lt ON l.measured_length_type_code = lt.code
             LEFT JOIN refs_biological.sex x ON b.sex_code = x.code
    GROUP BY (date_part('year'::text, so.start_setting_date_and_time)),
             (date_part('month'::text, so.start_setting_date_and_time)),
             (ros_meta.to_grid_1(so.start_setting_latitude, so.start_setting_longitude)),
             (ros_meta.to_grid_5(so.start_setting_latitude, so.start_setting_longitude)),
             (
                 CASE
                     WHEN f.code ~~ 'R%'::text THEN 'RC'::text
                     ELSE 'DI'::text
                     END), s.code, x.code, lt.code, l.value;

CREATE VIEW ros_meta.v_ps_effort_summary
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
    GROUP BY (date_part('year'::text, s.start_time)), (date_part('month'::text, s.start_time)), t.vessel_flag, s.grid_1,
             s.grid_5, fg_1.code, fg_5.code;

CREATE VIEW ros_meta.v_ll_effort_summary
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
    GROUP BY (date_part('year'::text, s.start_time)), (date_part('month'::text, s.start_time)), t.vessel_flag, s.grid_1,
             s.grid_5, fg_1.code, fg_5.code;


CREATE VIEW ros_analysis.v_ll_ca as
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
    FROM ros_ll.observer_data od
             JOIN ros_common.general_vessel_and_trip_information gvti ON od.vessel_and_trip_information_id = gvti.id
             JOIN ros_common.vessel_identification vi ON gvti.vessel_identification_id = vi.id
             JOIN refs_admin.countries cl_co ON vi.flag_code = cl_co.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON cl_co.code = fl.flag_code::bpchar
             JOIN ros_ll.fishing_events fe ON fe.observer_data_id = od.id
             LEFT JOIN ros_ll.setting_operations se ON fe.setting_operation_id = se.id
             JOIN ros_ll.catch_details ca ON ca.fishing_event_id = fe.id
             JOIN refs_biological.species cl_sp ON ca.species_code::text = cl_sp.code::text
             LEFT JOIN refs_biological.fates cl_fa ON ca.fates_code = cl_fa.code
             JOIN ros_ll.specimens sp ON sp.catch_detail_id = ca.id
    WHERE se.start_setting_date_and_time IS NOT NULL
    GROUP BY (COALESCE(fl.fleet_code, cl_co.code::character varying)),
             (date_part('year'::text, se.start_setting_date_and_time)),
             (date_part('month'::text, se.start_setting_date_and_time)),
             (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)),
             (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude)), cl_sp.code,
             cl_sp.species_group_code, cl_fa.code;

CREATE VIEW ros_analysis.v_ps_ca as
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
    FROM ros_ps.observer_data od
             JOIN ros_common.general_vessel_and_trip_information gvti ON od.vessel_and_trip_information_id = gvti.id
             JOIN ros_common.vessel_identification vi ON gvti.vessel_identification_id = vi.id
             JOIN refs_admin.countries cl_co ON vi.flag_code = cl_co.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON cl_co.code = fl.flag_code::bpchar
             JOIN ros_ps.fishing_events fe ON fe.observer_data_id = od.id
             LEFT JOIN ros_ps.setting_operations se ON fe.setting_operation_id = se.id
             JOIN ros_ps.catch_details ca ON ca.fishing_event_id = fe.id
             JOIN refs_biological.species cl_sp ON ca.species_code::text = cl_sp.code::text
             LEFT JOIN refs_biological.fates cl_fa ON ca.fates_code = cl_fa.code
             JOIN ros_common.estimated_weights w ON ca.estimated_weight_id = w.id
             LEFT JOIN refs_fishery.fish_processing_types cl_pt ON w.processing_type_code = cl_pt.code
    GROUP BY (COALESCE(fl.fleet_code, cl_co.code::character varying)),
             (date_part('year'::text, se.start_setting_date_and_time)),
             (date_part('month'::text, se.start_setting_date_and_time)),
             (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)),
             (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude)), cl_sp.code,
             cl_sp.species_group_code, cl_fa.code, w.unit;

CREATE VIEW ros_analysis.v_ca as
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

CREATE VIEW ros_analysis.v_ll_ef_sets(gear, flag, year, month, grid_1, grid_5, effort, effort_unit) as
    SELECT 'LL'::text                                                                AS gear,
           COALESCE(fl.fleet_code, cl_co.code::character varying)                    AS flag,
           date_part('year'::text, se.start_setting_date_and_time)                   AS year,
           date_part('month'::text, se.start_setting_date_and_time)                  AS month,
           ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
           ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
           count(DISTINCT fe.event_number)                                           AS effort,
           'SETS'::text                                                              AS effort_unit
    FROM ros_ll.observer_data od
             JOIN ros_common.general_vessel_and_trip_information gvti ON od.vessel_and_trip_information_id = gvti.id
             JOIN ros_common.vessel_identification vi ON gvti.vessel_identification_id = vi.id
             JOIN refs_admin.countries cl_co ON vi.flag_code = cl_co.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON cl_co.code = fl.flag_code::bpchar
             JOIN ros_ll.fishing_events fe ON fe.observer_data_id = od.id
             LEFT JOIN ros_ll.setting_operations se ON fe.setting_operation_id = se.id
             LEFT JOIN ros_ll.hauling_operations ha ON fe.hauling_operation_id = ha.id
    WHERE se.start_setting_date_and_time IS NOT NULL
    GROUP BY (COALESCE(fl.fleet_code, cl_co.code::character varying)),
             (date_part('year'::text, se.start_setting_date_and_time)),
             (date_part('month'::text, se.start_setting_date_and_time)),
             (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)),
             (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude));

CREATE VIEW ros_analysis.v_ll_ef_fd(gear, flag, year, month, grid_1, grid_5, effort, effort_unit) as
    SELECT 'LL'::text                                                                AS gear,
           COALESCE(fl.fleet_code, cl_co.code::character varying)                    AS flag,
           date_part('year'::text, se.start_setting_date_and_time)                   AS year,
           date_part('month'::text, se.start_setting_date_and_time)                  AS month,
           ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
           ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
           count(DISTINCT date_part('day'::text, se.start_setting_date_and_time))    AS effort,
           'FDAYS'::text                                                             AS effort_unit
    FROM ros_ll.observer_data od
             JOIN ros_common.general_vessel_and_trip_information gvti ON od.vessel_and_trip_information_id = gvti.id
             JOIN ros_common.vessel_identification vi ON gvti.vessel_identification_id = vi.id
             JOIN refs_admin.countries cl_co ON vi.flag_code = cl_co.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON cl_co.code = fl.flag_code::bpchar
             JOIN ros_ll.fishing_events fe ON fe.observer_data_id = od.id
             LEFT JOIN ros_ll.setting_operations se ON fe.setting_operation_id = se.id
             LEFT JOIN ros_ll.hauling_operations ha ON fe.hauling_operation_id = ha.id
    WHERE se.start_setting_date_and_time IS NOT NULL
    GROUP BY (COALESCE(fl.fleet_code, cl_co.code::character varying)),
             (date_part('year'::text, se.start_setting_date_and_time)),
             (date_part('month'::text, se.start_setting_date_and_time)),
             (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)),
             (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude));

CREATE VIEW ros_analysis.v_ll_ef_raw(gear, flag, year, month, grid_1, grid_5, observed_effort, effort_unit) as
    SELECT 'LL'::text                                                                AS gear,
           COALESCE(fl.fleet_code, cl_co.code::character varying)                    AS flag,
           date_part('year'::text, se.start_setting_date_and_time)                   AS year,
           date_part('month'::text, se.start_setting_date_and_time)                  AS month,
           ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
           ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
           sum(se.total_number_of_hooks_set)                                         AS observed_effort,
           'HOOKS'::text                                                             AS effort_unit
    FROM ros_ll.observer_data od
             JOIN ros_common.general_vessel_and_trip_information gvti ON od.vessel_and_trip_information_id = gvti.id
             JOIN ros_common.vessel_identification vi ON gvti.vessel_identification_id = vi.id
             JOIN refs_admin.countries cl_co ON vi.flag_code = cl_co.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON cl_co.code = fl.flag_code::bpchar
             JOIN ros_ll.fishing_events fe ON fe.observer_data_id = od.id
             LEFT JOIN ros_ll.setting_operations se ON fe.setting_operation_id = se.id
             LEFT JOIN ros_ll.hauling_operations ha ON fe.hauling_operation_id = ha.id
    WHERE se.start_setting_date_and_time IS NOT NULL
    GROUP BY (COALESCE(fl.fleet_code, cl_co.code::character varying)),
             (date_part('year'::text, se.start_setting_date_and_time)),
             (date_part('month'::text, se.start_setting_date_and_time)),
             (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)),
             (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude));

CREATE VIEW ros_analysis.v_ll_ef(gear, flag, year, month, grid_1, grid_5, observed_effort, effort_unit) as
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

CREATE VIEW ros_analysis.v_ps_ef_raw(gear, flag, year, month, grid_1, grid_5, observed_effort, effort_unit) as
    SELECT 'PS'::text                                                                AS gear,
           COALESCE(fl.fleet_code, cl_co.code::character varying)                    AS flag,
           date_part('year'::text, se.start_setting_date_and_time)                   AS year,
           date_part('month'::text, se.start_setting_date_and_time)                  AS month,
           ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
           ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
           count(DISTINCT se.id)                                                     AS observed_effort,
           'SETS'::text                                                              AS effort_unit
    FROM ros_ps.observer_data od
             JOIN ros_common.general_vessel_and_trip_information gvti ON od.vessel_and_trip_information_id = gvti.id
             JOIN ros_common.vessel_identification vi ON gvti.vessel_identification_id = vi.id
             JOIN refs_admin.countries cl_co ON vi.flag_code = cl_co.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON cl_co.code = fl.flag_code::bpchar
             JOIN ros_ps.fishing_events fe ON fe.observer_data_id = od.id
             LEFT JOIN ros_ps.setting_operations se ON fe.setting_operation_id = se.id
    GROUP BY (COALESCE(fl.fleet_code, cl_co.code::character varying)),
             (date_part('year'::text, se.start_setting_date_and_time)),
             (date_part('month'::text, se.start_setting_date_and_time)),
             (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)),
             (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude));

CREATE VIEW ros_analysis.v_ps_ef_fd(gear, flag, year, month, grid_1, grid_5, effort, effort_unit) as
    SELECT 'PS'::text                                                                AS gear,
           COALESCE(fl.fleet_code, cl_co.code::character varying)                    AS flag,
           date_part('year'::text, se.start_setting_date_and_time)                   AS year,
           date_part('month'::text, se.start_setting_date_and_time)                  AS month,
           ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
           ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
           count(DISTINCT date_part('day'::text, se.start_setting_date_and_time))    AS effort,
           'FDAYS'::text                                                             AS effort_unit
    FROM ros_ps.observer_data od
             JOIN ros_common.general_vessel_and_trip_information gvti ON od.vessel_and_trip_information_id = gvti.id
             JOIN ros_common.vessel_identification vi ON gvti.vessel_identification_id = vi.id
             JOIN refs_admin.countries cl_co ON vi.flag_code = cl_co.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON cl_co.code = fl.flag_code::bpchar
             JOIN ros_ps.fishing_events fe ON fe.observer_data_id = od.id
             LEFT JOIN ros_ps.setting_operations se ON fe.setting_operation_id = se.id
    GROUP BY (COALESCE(fl.fleet_code, cl_co.code::character varying)),
             (date_part('year'::text, se.start_setting_date_and_time)),
             (date_part('month'::text, se.start_setting_date_and_time)),
             (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)),
             (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude));

CREATE VIEW ros_analysis.v_ps_ef(gear, flag, year, month, grid_1, grid_5, observed_effort, effort_unit) as
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

CREATE VIEW ros_analysis.v_ef(gear, flag, year, month, grid_1, grid_5, observed_effort, effort_unit) as
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

CREATE VIEW ros_analysis.v_ll_sf_l as
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
    FROM ros_ll.observer_data od
             JOIN ros_common.general_vessel_and_trip_information gvti ON od.vessel_and_trip_information_id = gvti.id
             JOIN ros_common.vessel_identification vi ON gvti.vessel_identification_id = vi.id
             JOIN refs_admin.countries cl_co ON vi.flag_code = cl_co.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON cl_co.code = fl.flag_code::bpchar
             JOIN ros_ll.fishing_events fe ON fe.observer_data_id = od.id
             LEFT JOIN ros_ll.setting_operations se ON fe.setting_operation_id = se.id
             JOIN ros_ll.catch_details ca ON ca.fishing_event_id = fe.id
             JOIN refs_biological.species cl_sp ON ca.species_code::text = cl_sp.code::text
             LEFT JOIN refs_biological.fates cl_fa ON ca.fates_code = cl_fa.code
             JOIN ros_ll.specimens sp ON sp.catch_detail_id = ca.id
             JOIN ros_common.biometric_information bi ON sp.biometric_information_id = bi.id
             LEFT JOIN refs_biological.sex cl_sx ON bi.sex_code = cl_sx.code
             JOIN ros_common.measured_lengths ln
                  ON bi.measured_length_id = ln.id OR bi.alternative_measured_length_id = ln.id
             LEFT JOIN refs_biological.measurements cl_le ON ln.measured_length_type_code = cl_le.code
    GROUP BY (COALESCE(fl.fleet_code, cl_co.code::character varying)),
             (date_part('year'::text, se.start_setting_date_and_time)),
             (date_part('month'::text, se.start_setting_date_and_time)),
             (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)),
             (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude)), cl_sp.code,
             cl_sp.species_group_code, cl_fa.code, cl_sx.code, cl_le.code, (floor(ln.value)), ln.unit;

CREATE VIEW ros_analysis.v_ps_sf_l as
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
    FROM ros_ps.observer_data od
             JOIN ros_common.general_vessel_and_trip_information gvti ON od.vessel_and_trip_information_id = gvti.id
             JOIN ros_common.vessel_identification vi ON gvti.vessel_identification_id = vi.id
             JOIN refs_admin.countries cl_co ON vi.flag_code = cl_co.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON cl_co.code = fl.flag_code::bpchar
             JOIN ros_ps.fishing_events fe ON fe.observer_data_id = od.id
             LEFT JOIN ros_ps.setting_operations se ON fe.setting_operation_id = se.id
             JOIN ros_ps.catch_details ca ON ca.fishing_event_id = fe.id
             JOIN refs_biological.species cl_sp ON ca.species_code::text = cl_sp.code::text
             LEFT JOIN refs_biological.fates cl_fa ON ca.fates_code = cl_fa.code
             JOIN ros_ps.specimens sp ON sp.catch_detail_id = ca.id
             JOIN ros_common.biometric_information bi ON sp.biometric_information_id = bi.id
             LEFT JOIN refs_biological.sex cl_sx ON bi.sex_code = cl_sx.code
             LEFT JOIN ros_common.measured_lengths ln
                       ON bi.measured_length_id = ln.id OR bi.alternative_measured_length_id = ln.id
             JOIN refs_biological.measurements cl_le ON ln.measured_length_type_code = cl_le.code
    GROUP BY (COALESCE(fl.fleet_code, cl_co.code::character varying)),
             (date_part('year'::text, se.start_setting_date_and_time)),
             (date_part('month'::text, se.start_setting_date_and_time)),
             (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)),
             (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude)), cl_sp.code,
             cl_sp.species_group_code, cl_fa.code, cl_sx.code, cl_le.code, (floor(ln.value)), ln.unit;

CREATE VIEW ros_analysis.v_sf_l as
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

CREATE VIEW ros_analysis.v_ps_sf_w as
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
    FROM ros_ps.observer_data od
             JOIN ros_common.general_vessel_and_trip_information gvti ON od.vessel_and_trip_information_id = gvti.id
             JOIN ros_common.vessel_identification vi ON gvti.vessel_identification_id = vi.id
             JOIN refs_admin.countries cl_co ON vi.flag_code = cl_co.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON cl_co.code = fl.flag_code::bpchar
             JOIN ros_ps.fishing_events fe ON fe.observer_data_id = od.id
             LEFT JOIN ros_ps.setting_operations se ON fe.setting_operation_id = se.id
             JOIN ros_ps.catch_details ca ON ca.fishing_event_id = fe.id
             JOIN refs_biological.species cl_sp ON ca.species_code::text = cl_sp.code::text
             LEFT JOIN refs_biological.fates cl_fa ON ca.fates_code = cl_fa.code
             JOIN ros_ps.specimens sp ON sp.catch_detail_id = ca.id
             JOIN ros_common.biometric_information bi ON sp.biometric_information_id = bi.id
             LEFT JOIN refs_biological.sex cl_sx ON bi.sex_code = cl_sx.code
             JOIN ros_common.estimated_weights we ON bi.estimated_weight_id = we.id
             LEFT JOIN refs_fishery.fish_processing_types cl_pt ON we.processing_type_code = cl_pt.code
    GROUP BY (COALESCE(fl.fleet_code, cl_co.code::character varying)),
             (date_part('year'::text, se.start_setting_date_and_time)),
             (date_part('month'::text, se.start_setting_date_and_time)),
             (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)),
             (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude)), cl_sp.code,
             cl_sp.species_group_code, cl_fa.code, cl_sx.code, cl_pt.code, (floor(we.value)), we.unit;

CREATE VIEW ros_analysis.v_ll_sf_w as
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
    FROM ros_ll.observer_data od
             JOIN ros_common.general_vessel_and_trip_information gvti ON od.vessel_and_trip_information_id = gvti.id
             JOIN ros_common.vessel_identification vi ON gvti.vessel_identification_id = vi.id
             JOIN refs_admin.countries cl_co ON vi.flag_code = cl_co.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON cl_co.code = fl.flag_code::bpchar
             JOIN ros_ll.fishing_events fe ON fe.observer_data_id = od.id
             LEFT JOIN ros_ll.setting_operations se ON fe.setting_operation_id = se.id
             JOIN ros_ll.catch_details ca ON ca.fishing_event_id = fe.id
             JOIN refs_biological.species cl_sp ON ca.species_code::text = cl_sp.code::text
             LEFT JOIN refs_biological.fates cl_fa ON ca.fates_code = cl_fa.code
             JOIN ros_ll.specimens sp ON sp.catch_detail_id = ca.id
             JOIN ros_common.biometric_information bi ON sp.biometric_information_id = bi.id
             LEFT JOIN refs_biological.sex cl_sx ON bi.sex_code = cl_sx.code
             JOIN ros_common.estimated_weights we ON bi.estimated_weight_id = we.id
             LEFT JOIN refs_fishery.fish_processing_types cl_pt ON we.processing_type_code = cl_pt.code
    GROUP BY (COALESCE(fl.fleet_code, cl_co.code::character varying)),
             (date_part('year'::text, se.start_setting_date_and_time)),
             (date_part('month'::text, se.start_setting_date_and_time)),
             (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)),
             (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude)), cl_sp.code,
             cl_sp.species_group_code, cl_fa.code, cl_sx.code, cl_pt.code, (floor(we.value)), we.unit;

CREATE VIEW ros_analysis.v_sf_w as
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

CREATE VIEW ros_analysis.v_sf as
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

CREATE VIEW ros_analysis.v_ps_in as
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
    FROM ros_ps.observer_data od
             JOIN ros_common.general_vessel_and_trip_information gvti ON od.vessel_and_trip_information_id = gvti.id
             JOIN ros_common.vessel_identification vi ON gvti.vessel_identification_id = vi.id
             JOIN refs_admin.countries cl_co ON vi.flag_code = cl_co.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON cl_co.code = fl.flag_code::bpchar
             JOIN ros_ps.fishing_events fe ON fe.observer_data_id = od.id
             LEFT JOIN ros_ps.setting_operations se ON fe.setting_operation_id = se.id
             JOIN ros_ps.catch_details ca ON ca.fishing_event_id = fe.id
             JOIN refs_biological.species cl_sp ON ca.species_code::text = cl_sp.code::text
             LEFT JOIN refs_biological.fates cl_fa ON ca.fates_code = cl_fa.code
             JOIN ros_ps.specimens sp ON sp.catch_detail_id = ca.id
             LEFT JOIN ros_common.additional_details_on_non_target_species adnt
                       ON sp.additional_specimen_details_non_target_species_id = adnt.id
             LEFT JOIN refs_biological.incidental_captures_conditions cl_cn
                       ON COALESCE(adnt.condition_at_capture_code, adnt.condition_at_release_code)::text = cl_cn.code::text
    GROUP BY (COALESCE(fl.fleet_code, cl_co.code::character varying)),
             (date_part('year'::text, se.start_setting_date_and_time)),
             (date_part('month'::text, se.start_setting_date_and_time)),
             (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)),
             (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude)), cl_sp.code,
             cl_sp.species_group_code,
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

CREATE VIEW ros_analysis.v_ll_in as
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
    FROM ros_ll.observer_data od
             JOIN ros_common.general_vessel_and_trip_information gvti ON od.vessel_and_trip_information_id = gvti.id
             JOIN ros_common.vessel_identification vi ON gvti.vessel_identification_id = vi.id
             JOIN refs_admin.countries cl_co ON vi.flag_code = cl_co.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON cl_co.code = fl.flag_code::bpchar
             JOIN ros_ll.fishing_events fe ON fe.observer_data_id = od.id
             LEFT JOIN ros_ll.setting_operations se ON fe.setting_operation_id = se.id
             JOIN ros_ll.catch_details ca ON ca.fishing_event_id = fe.id
             JOIN refs_biological.species cl_sp ON ca.species_code::text = cl_sp.code::text
             LEFT JOIN refs_biological.fates cl_fa ON ca.fates_code = cl_fa.code
             LEFT JOIN ros_ll.specimens sp ON sp.catch_detail_id = ca.id
             LEFT JOIN ros_common.additional_details_on_non_target_species adnt
                       ON sp.additional_specimen_details_non_target_species_id = adnt.id
             LEFT JOIN refs_biological.incidental_captures_conditions cl_cn
                       ON COALESCE(adnt.condition_at_capture_code, adnt.condition_at_release_code)::text = cl_cn.code::text
    GROUP BY (COALESCE(fl.fleet_code, cl_co.code::character varying)),
             (date_part('year'::text, se.start_setting_date_and_time)),
             (date_part('month'::text, se.start_setting_date_and_time)),
             (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)),
             (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude)), cl_sp.code,
             cl_sp.species_group_code,
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

CREATE VIEW ros_analysis.v_in as
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

CREATE VIEW ros_analysis.v_ef_raw(gear, flag, year, month, grid_1, grid_5, observed_effort, effort_unit) as
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

CREATE VIEW ros_analysis.v_ll_ce as
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
             LEFT JOIN ros_analysis.v_ll_ca c
                       ON e.gear = c.gear AND e.flag::text = c.flag::text AND e.year = c.year AND e.month = c.month AND
                          e.grid_1 = c.grid_1 AND e.grid_5 = c.grid_5;

CREATE VIEW ros_analysis.v_ef_fd(gear, flag, year, month, grid_1, grid_5, effort, effort_unit) as
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

CREATE VIEW ros_analysis.v_ps_ce as
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
             LEFT JOIN ros_analysis.v_ps_ca c
                       ON e.gear = c.gear AND e.flag::text = c.flag::text AND e.year = c.year AND e.month = c.month AND
                          e.grid_1 = c.grid_1 AND e.grid_5 = c.grid_5;

CREATE VIEW ros_analysis.v_ce as
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
             LEFT JOIN ros_analysis.v_ca c
                       ON e.gear = c.gear AND e.flag::text = c.flag::text AND e.year = c.year AND e.month = c.month AND
                          e.grid_1 = c.grid_1 AND e.grid_5 = c.grid_5;

CREATE VIEW ros_analysis.v_trips_by_year_flag_and_gear(year, flag, gear, num_trips) as
    SELECT year,
           flag,
           gear,
           sum(num_trips) AS num_trips
    FROM ros_meta.v_trips_by_year_flag_and_gear
    GROUP BY year, flag, gear;

CREATE VIEW ros_analysis.v_observers (iotc_number, flag_code, last_name, first_name, nationality_code, active) as
    WITH obs AS (SELECT ob.iotc_number,
                        f.code AS flag_code,
                        ob.last_name,
                        ob.first_name,
                        n.code AS nationality_code,
                        ob.active
                 FROM ros_meta.observers ob
                          JOIN ros_meta.observers_2_flags o2f ON ob.iotc_number = o2f.iotc_number
                          JOIN refs_admin.countries f ON o2f.flag_code = f.code
                          JOIN refs_admin.countries n ON ob.nationality_code = n.code)
    SELECT DISTINCT iotc_number,
                    CASE
                        WHEN iotc_number ~~ '%EUR%'::text THEN 'EUR'::bpchar
                        ELSE flag_code
                        END AS flag_code,
                    last_name,
                    first_name,
                    nationality_code,
                    active
    FROM obs
    WHERE iotc_number !~~ '%DUM%'::text
      AND last_name::text !~~ '%DUMMY%'::text
      AND last_name::text !~~ '%KEN ROS%'::text;

CREATE VIEW ros_analysis.v_observers_summary(flag_code, num_active, num_inactive) as
    SELECT CASE
               WHEN iotc_number ~~ '%EUR%'::text THEN 'EUR'::bpchar
               ELSE flag_code
               END          AS flag_code,
           sum(
                   CASE
                       WHEN active = 1 THEN 1
                       ELSE 0
                       END) AS num_active,
           sum(
                   CASE
                       WHEN active = 0 THEN 1
                       ELSE 0
                       END) AS num_inactive
    FROM ros_analysis.v_observers v
    GROUP BY (
                 CASE
                     WHEN iotc_number ~~ '%EUR%'::text THEN 'EUR'::bpchar
                     ELSE flag_code
                     END);

CREATE VIEW ros_analysis.v_ll_sets_raw
            (flag_code, fleet_code, gear_code, fishery_code, fishery_group_code, fishery_type_code, trip_id, trip_uid,
             set_id, set_uid, event_type_code, start_time, start_lon, start_lat, end_time, end_lon, end_lat, effort,
             effort_unit_code)
as
    SELECT COALESCE(f2f.flag_code, c.code::character varying)  AS flag_code,
           COALESCE(f2f.fleet_code, c.code::character varying) AS fleet_code,
           'LL'::text                                          AS gear_code,
           'LLO'::text                                         AS fishery_code,
           'LL'::text                                          AS fishery_group_code,
           'IND'::text                                         AS fishery_type_code,
           o.id                                                AS trip_id,
           o.uid                                               AS trip_uid,
           fed.setting_operation_id                         AS set_id,
           fed.event_number                                    AS set_uid,
           'SETTING'::text                                     AS event_type_code,
           so.start_setting_date_and_time                      AS start_time,
           so.start_setting_longitude                          AS start_lon,
           so.start_setting_latitude                           AS start_lat,
           so.end_setting_date_and_time                        AS end_time,
           so.end_setting_longitude                            AS end_lon,
           so.end_setting_latitude                             AS end_lat,
           so.total_number_of_hooks_set                        AS effort,
           'HK'::text                                          AS effort_unit_code
    FROM ros_ll.observer_data o
             JOIN ros_common.general_vessel_and_trip_information gvt ON o.vessel_and_trip_information_id = gvt.id
             JOIN ros_common.vessel_identification vi ON gvt.vessel_identification_id = vi.id
             LEFT JOIN refs_admin.countries c ON vi.flag_code = c.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries f2f ON c.code = f2f.flag_code::bpchar
             JOIN ros_ll.fishing_events fed ON fed.observer_data_id = o.id
             JOIN ros_ll.setting_operations so ON fed.setting_operation_id = so.id
    UNION ALL
    SELECT COALESCE(f2f.flag_code, c.code::character varying)  AS flag_code,
           COALESCE(f2f.fleet_code, c.code::character varying) AS fleet_code,
           'LL'::text                                          AS gear_code,
           'LLO'::text                                         AS fishery_code,
           'LL'::text                                          AS fishery_group_code,
           'IND'::text                                         AS fishery_type_code,
           o.id                                                AS trip_id,
           o.uid                                               AS trip_uid,
           fed.setting_operation_id                         AS set_id,
           fed.event_number                                    AS set_uid,
           'HAULING'::text                                     AS event_type_code,
           ho.start_hauling_date_and_time                      AS start_time,
           ho.start_hauling_longitude                          AS start_lon,
           ho.start_hauling_latitude                           AS start_lat,
           ho.end_hauling_date_and_time                        AS end_time,
           ho.end_hauling_longitude                            AS end_lon,
           ho.end_hauling_latitude                             AS end_lat,
           ho.number_of_hooks_observed                         AS effort,
           'HK'::text                                          AS effort_unit_code
    FROM ros_ll.observer_data o
             JOIN ros_common.general_vessel_and_trip_information gvt ON o.vessel_and_trip_information_id = gvt.id
             JOIN ros_common.vessel_identification vi ON gvt.vessel_identification_id = vi.id
             LEFT JOIN refs_admin.countries c ON vi.flag_code = c.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries f2f ON c.code = f2f.flag_code::bpchar
             JOIN ros_ll.fishing_events fed ON fed.observer_data_id = o.id
             JOIN ros_ll.hauling_operations ho ON fed.hauling_operation_id = ho.id;

CREATE VIEW ros_analysis.v_ps_sets_raw
            (flag_code, fleet_code, gear_code, fishery_code, fishery_group_code, fishery_type_code, trip_id, trip_uid,
             set_id, set_uid, event_type_code, start_time, start_lon, start_lat, end_time, end_lon, end_lat, effort,
             effort_unit_code)
as
    SELECT COALESCE(f2f.flag_code, c.code::character varying)  AS flag_code,
           COALESCE(f2f.fleet_code, c.code::character varying) AS fleet_code,
           'PS'::text                                          AS gear_code,
           'PSOT'::text                                        AS fishery_code,
           'PS'::text                                          AS fishery_group_code,
           'IND'::text                                         AS fishery_type_code,
           o.id                                                AS trip_id,
           o.uid                                               AS trip_uid,
           fed.setting_operation_id                         AS set_id,
           fed.event_number                                    AS set_uid,
           'SETTING'::text                                     AS event_type_code,
           so.start_setting_date_and_time                      AS start_time,
           so.start_setting_longitude                          AS start_lon,
           so.start_setting_latitude                           AS start_lat,
           COALESCE(so.time_end_brailing, so.time_skiff_onboard, so.time_net_pursed,
                    so.start_setting_date_and_time)            AS end_time,
           so.start_setting_longitude                          AS end_lon,
           so.start_setting_latitude                           AS end_lat,
           1                                                   AS effort,
           'SET'::text                                         AS effort_unit_code
    FROM ros_ps.observer_data o
             JOIN ros_common.general_vessel_and_trip_information gvt ON o.vessel_and_trip_information_id = gvt.id
             JOIN ros_common.vessel_identification vi ON gvt.vessel_identification_id = vi.id
             LEFT JOIN refs_admin.countries c ON vi.flag_code = c.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries f2f ON c.code = f2f.flag_code::bpchar
             JOIN ros_ps.fishing_events fed ON fed.observer_data_id = o.id
             JOIN ros_ps.setting_operations so ON fed.setting_operation_id = so.id;

CREATE VIEW ros_analysis.v_sets_raw
            (flag_code, fleet_code, gear_code, fishery_code, fishery_group_code, fishery_type_code, trip_id, trip_uid,
             set_id, set_uid, event_type_code, start_time, start_lon, start_lat, end_time, end_lon, end_lat, effort,
             effort_unit_code)
as
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

CREATE VIEW ros_analysis.v_sets_by_year_flag_and_gear(year, flag, gear, num_sets) as
    SELECT year,
           flag,
           gear,
           num_sets
    FROM ros_meta.v_sets_by_year_flag_and_gear;

CREATE VIEW ros_analysis.v_efforts_by_year_flag_and_gear(gear, flag, year, observed_effort, effort_unit) as
    SELECT 'LL'::text                                              AS gear,
           COALESCE(fl.fleet_code, cl_co.code::character varying)  AS flag,
           date_part('year'::text, se.start_setting_date_and_time) AS year,
           sum(se.total_number_of_hooks_set)                       AS observed_effort,
           'HOOK'::text                                            AS effort_unit
    FROM ros_ll.observer_data od
             JOIN ros_common.general_vessel_and_trip_information gvti ON od.vessel_and_trip_information_id = gvti.id
             JOIN ros_common.vessel_identification vi ON gvti.vessel_identification_id = vi.id
             JOIN refs_admin.countries cl_co ON vi.flag_code = cl_co.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON cl_co.code = fl.flag_code::bpchar
             JOIN ros_ll.fishing_events fe ON fe.observer_data_id = od.id
             LEFT JOIN ros_ll.setting_operations se ON fe.setting_operation_id = se.id
             LEFT JOIN ros_ll.hauling_operations ha ON fe.hauling_operation_id = ha.id
    GROUP BY (COALESCE(fl.fleet_code, cl_co.code::character varying)),
             (date_part('year'::text, se.start_setting_date_and_time))
    UNION ALL
    SELECT 'PS'::text                                              AS gear,
           COALESCE(fl.fleet_code, cl_co.code::character varying)  AS flag,
           date_part('year'::text, se.start_setting_date_and_time) AS year,
           count(DISTINCT se.id)                                   AS observed_effort,
           'SET'::text                                             AS effort_unit
    FROM ros_ps.observer_data od
             JOIN ros_common.general_vessel_and_trip_information gvti ON od.vessel_and_trip_information_id = gvti.id
             JOIN ros_common.vessel_identification vi ON gvti.vessel_identification_id = vi.id
             JOIN refs_admin.countries cl_co ON vi.flag_code = cl_co.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON cl_co.code = fl.flag_code::bpchar
             JOIN ros_ps.fishing_events fe ON fe.observer_data_id = od.id
             LEFT JOIN ros_ps.setting_operations se ON fe.setting_operation_id = se.id
    GROUP BY (COALESCE(fl.fleet_code, cl_co.code::character varying)),
             (date_part('year'::text, se.start_setting_date_and_time));

CREATE VIEW ros_analysis.v_ps_lw as
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
    FROM ros_ps.observer_data od
             JOIN ros_common.general_vessel_and_trip_information gvti ON od.vessel_and_trip_information_id = gvti.id
             JOIN ros_common.vessel_identification vi ON gvti.vessel_identification_id = vi.id
             JOIN refs_admin.countries cl_co ON vi.flag_code = cl_co.code
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON cl_co.code = fl.flag_code::bpchar
             JOIN ros_ps.fishing_events fe ON fe.observer_data_id = od.id
             LEFT JOIN ros_ps.setting_operations se ON fe.setting_operation_id = se.id
             JOIN ros_ps.catch_details ca ON ca.fishing_event_id = fe.id
             JOIN refs_biological.species cl_sp ON ca.species_code::text = cl_sp.code::text
             LEFT JOIN refs_biological.fates cl_fa ON ca.fates_code = cl_fa.code
             JOIN ros_ps.specimens sp ON sp.catch_detail_id = ca.id
             JOIN ros_common.biometric_information bi ON sp.biometric_information_id = bi.id
             LEFT JOIN refs_biological.sex cl_sx ON bi.sex_code = cl_sx.code
             JOIN ros_common.measured_lengths ln ON bi.measured_length_id = ln.id
             LEFT JOIN refs_biological.measurements cl_le ON ln.measured_length_type_code = cl_le.code
             JOIN ros_common.estimated_weights ew ON bi.estimated_weight_id = ew.id
             LEFT JOIN refs_fishery.fish_processing_types cl_pt ON ew.processing_type_code = cl_pt.code;


CREATE VIEW ros_rlibs.v_ca
            (year, month_start, month_end, flag_code, fleet_code, gear_code, fishery_code, fishery_group_code,
             fishery_type_code, catch_school_type_code, fishing_ground_code, species_code, species_category_code,
             species_group_code, species_wp_code, is_iotc_species, is_species_aggregate, is_ssi, catch, catch_unit_code,
             fate_code)
as
    WITH ca AS (SELECT v_ca.year,
                       v_ca.month,
                       v_ca.flag,
                       v_ca.gear,
                       CASE
                           WHEN v_ca.gear = 'PS'::text THEN v_ca.grid_1
                           ELSE v_ca.grid_5
                           END                                                  AS grid,
                       v_ca.species,
                       v_ca.fate,
                       sum(
                               CASE
                                   WHEN v_ca.catch_unit = 'KG'::text THEN 0.001
                                   ELSE 1::numeric
                                   END::double precision * v_ca.observed_catch) AS observed_catch,
                       CASE
                           WHEN v_ca.catch_unit = 'KG'::text THEN 'MT'::text
                           ELSE v_ca.catch_unit
                           END                                                  AS catch_unit
                FROM ros_analysis.v_ca
                GROUP BY v_ca.year, v_ca.month, v_ca.flag, v_ca.gear,
                         (
                             CASE
                                 WHEN v_ca.gear = 'PS'::text THEN v_ca.grid_1
                                 ELSE v_ca.grid_5
                                 END), v_ca.species, v_ca.fate,
                         (
                             CASE
                                 WHEN v_ca.catch_unit = 'KG'::text THEN 'MT'::text
                                 ELSE v_ca.catch_unit
                                 END))
    SELECT c.year,
           c.month                        AS month_start,
           c.month                        AS month_end,
           COALESCE(f.flag_code, c.flag)  AS flag_code,
           COALESCE(f.fleet_code, c.flag) AS fleet_code,
           c.gear                         AS gear_code,
           CASE
               WHEN c.gear = 'LL'::text THEN 'LLO'::text
               WHEN c.gear = 'PS'::text THEN 'PSOT'::text
               ELSE c.gear
               END                        AS fishery_code,
           c.gear                         AS fishery_group_code,
           'IND'::text                    AS fishery_type_code,
           NULL::text                     AS catch_school_type_code,
           c.grid                         AS fishing_ground_code,
           s.code                         AS species_code,
           s.species_category_code,
           s.species_group_code,
           'WP_CODE'::text                AS species_wp_code,
           s.is_iotc                      AS is_iotc_species,
           s.is_aggregate                 AS is_species_aggregate,
           s.is_ssi,
           c.observed_catch               AS catch,
           c.catch_unit                   AS catch_unit_code,
           c.fate                         AS fate_code
    FROM ca c
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries f ON f.fleet_code::text = c.flag::text
             LEFT JOIN refs_biological.species s ON c.species::text = s.code::text;

CREATE VIEW ros_rlibs.v_ef
            (year, month_start, month_end, flag_code, fleet_code, gear_code, fishery_code, fishery_group_code,
             fishery_type_code, effort_school_type_code, fishing_ground_code, effort, effort_unit_code)
as
    WITH ef AS (SELECT v_ef.year,
                       v_ef.month,
                       v_ef.flag,
                       v_ef.gear,
                       CASE
                           WHEN v_ef.gear = 'PS'::text THEN v_ef.grid_1
                           ELSE v_ef.grid_5
                           END                   AS grid,
                       sum(v_ef.observed_effort) AS effort,
                       v_ef.effort_unit
                FROM ros_analysis.v_ef
                GROUP BY v_ef.year, v_ef.month, v_ef.flag, v_ef.gear,
                         (
                             CASE
                                 WHEN v_ef.gear = 'PS'::text THEN v_ef.grid_1
                                 ELSE v_ef.grid_5
                                 END), v_ef.effort_unit)
    SELECT e.year,
           e.month                        AS month_start,
           e.month                        AS month_end,
           COALESCE(f.flag_code, e.flag)  AS flag_code,
           COALESCE(f.fleet_code, e.flag) AS fleet_code,
           e.gear                         AS gear_code,
           CASE
               WHEN e.gear = 'LL'::text THEN 'LLO'::text
               WHEN e.gear = 'PS'::text THEN 'PSOT'::text
               ELSE e.gear
               END                        AS fishery_code,
           e.gear                         AS fishery_group_code,
           'IND'::text                    AS fishery_type_code,
           NULL::text                     AS effort_school_type_code,
           e.grid                         AS fishing_ground_code,
           e.effort,
           e.effort_unit                  AS effort_unit_code
    FROM ef e
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries f ON f.fleet_code::text = e.flag::text;

CREATE VIEW ros_rlibs.v_ce
            (year, month_start, month_end, flag_code, fleet_code, gear_code, fishery_code, fishery_group_code,
             fishery_type_code, effort_school_type_code, fishing_ground_code, effort, effort_unit_code,
             catch_school_type_code, species_code, species_category_code, species_group_code, species_wp_code,
             is_iotc_species, is_species_aggregate, is_ssi, catch, catch_unit_code, fate_code)
as
    SELECT e.year,
           e.month_start,
           e.month_end,
           e.flag_code,
           e.fleet_code,
           e.gear_code,
           e.fishery_code,
           e.fishery_group_code,
           e.fishery_type_code,
           e.effort_school_type_code,
           e.fishing_ground_code,
           e.effort,
           e.effort_unit_code,
           c.catch_school_type_code,
           c.species_code,
           c.species_category_code,
           c.species_group_code,
           c.species_wp_code,
           c.is_iotc_species,
           c.is_species_aggregate,
           c.is_ssi,
           c.catch,
           c.catch_unit_code,
           c.fate_code
    FROM ros_rlibs.v_ef e
             LEFT JOIN ros_rlibs.v_ca c ON e.year = c.year AND e.month_start = c.month_start AND
                                           e.flag_code::text = c.flag_code::text AND e.gear_code = c.gear_code AND
                                           e.fishing_ground_code = c.fishing_ground_code;

CREATE VIEW ros_rlibs.v_sf
            (year, month_start, month_end, flag_code, fleet_code, gear_code, fishery_code, fishery_group_code,
             fishery_type_code, school_type_code, fishing_ground_code, species_code, species_category_code,
             species_group_code, species_wp_code, is_iotc_species, is_species_aggregate, is_ssi, sex_code,
             measure_type_code, measure_unit_code, fate_code, class_low, class_high, fish_count)
as
    WITH sf AS (SELECT c_1.year,
                       c_1.month                          AS month_start,
                       c_1.month                          AS month_end,
                       COALESCE(f.flag_code, c_1.flag)    AS flag_code,
                       COALESCE(f.fleet_code, c_1.flag)   AS fleet_code,
                       c_1.gear                           AS gear_code,
                       CASE
                           WHEN c_1.gear = 'LL'::text THEN 'LLO'::text
                           WHEN c_1.gear = 'PS'::text THEN 'PSOT'::text
                           ELSE c_1.gear
                           END                            AS fishery_code,
                       c_1.gear                           AS fishery_group_code,
                       'IND'::text                        AS fishery_type_code,
                       NULL::text                         AS school_type_code,
                       CASE
                           WHEN c_1.gear = 'PS'::text THEN c_1.grid_1
                           ELSE c_1.grid_5
                           END                            AS fishing_ground_code,
                       c_1.species                        AS species_code,
                       c_1.sex                            AS sex_code,
                       c_1.length_code                    AS measure_type_code,
                       c_1.length_unit                    AS measure_unit_code,
                       c_1.fate                           AS fate_code,
                       c_1.size_bin                       AS class_low,
                       c_1.size_bin + 1::double precision AS class_high,
                       c_1.num_fish                       AS fish_count
                FROM ros_analysis.v_sf c_1
                         LEFT JOIN refs_admin.fleet_to_flags_and_fisheries f ON f.fleet_code::text = c_1.flag::text)
    SELECT c.year,
           c.month_start,
           c.month_end,
           c.flag_code,
           c.fleet_code,
           c.gear_code,
           c.fishery_code,
           c.fishery_group_code,
           c.fishery_type_code,
           c.school_type_code,
           c.fishing_ground_code,
           s.code            AS species_code,
           s.species_category_code,
           s.species_group_code,
           'WP_CODE'::text   AS species_wp_code,
           s.is_iotc         AS is_iotc_species,
           s.is_aggregate    AS is_species_aggregate,
           s.is_ssi,
           c.sex_code,
           c.measure_type_code,
           c.measure_unit_code,
           c.fate_code,
           c.class_low,
           c.class_high,
           sum(c.fish_count) AS fish_count
    FROM sf c
             LEFT JOIN refs_biological.species s ON c.species_code::text = s.code::text
    GROUP BY c.year, c.month_start, c.month_end, c.flag_code, c.fleet_code, c.gear_code, c.fishery_code,
             c.fishery_group_code, c.fishery_type_code, c.school_type_code, c.fishing_ground_code, s.code,
             s.species_category_code, s.species_group_code, s.is_iotc, s.is_aggregate, s.is_ssi, c.sex_code,
             c.measure_type_code, c.measure_unit_code, c.fate_code, c.class_low, c.class_high;

CREATE VIEW ros_rlibs.v_in
            (year, month_start, month_end, flag_code, fleet_code, gear_code, fishery_code, fishery_group_code,
             fishery_type_code, catch_school_type_code, fishing_ground_code, species_code, species_category_code,
             species_group_code, species_wp_code, is_iotc_species, is_species_aggregate, is_ssi, num_interactions,
             fate_code, condition_code)
as
    SELECT c.year,
           c.month                        AS month_start,
           c.month                        AS month_end,
           COALESCE(f.flag_code, c.flag)  AS flag_code,
           COALESCE(f.fleet_code, c.flag) AS fleet_code,
           c.gear                         AS gear_code,
           CASE
               WHEN c.gear = 'LL'::text THEN 'LLO'::text
               WHEN c.gear = 'PS'::text THEN 'PSOT'::text
               ELSE c.gear
               END                        AS fishery_code,
           c.gear                         AS fishery_group_code,
           'IND'::text                    AS fishery_type_code,
           NULL::text                     AS catch_school_type_code,
           CASE
               WHEN c.gear = 'PS'::text THEN c.grid_1
               ELSE c.grid_5
               END                        AS fishing_ground_code,
           s.code                         AS species_code,
           s.species_category_code,
           s.species_group_code,
           'WP_CODE'::text                AS species_wp_code,
           s.is_iotc                      AS is_iotc_species,
           s.is_aggregate                 AS is_species_aggregate,
           s.is_ssi,
           c.num_interactions,
           c.fate_code,
           c.condition_code
    FROM ros_analysis.v_in c
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries f ON f.fleet_code::text = c.flag::text
             LEFT JOIN refs_biological.species s ON c.species::text = s.code::text;
