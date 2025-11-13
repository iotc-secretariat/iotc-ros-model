DROP TABLE ros_common.person_details;
DROP TABLE ros_common.person_contact_details;
DROP TABLE ros_common.iotc_person_details;
DROP TABLE ros_common.iotc_person_contact_details;
create or replace view ros_meta.v_ll_trips
            (source, trip_id, trip_uid, trip_number, creation_date, finalization_date, submission_date, has_observer_trip_info, fishing_operation_type, observer_iotc_number, observer_imbarcation_date, observer_disembarcation_date, vessel_info_id,
             vessel_iotc_number, main_gear, reporting_flag, vessel_flag, vessel_departure_date, vessel_departure_port, vessel_departure_country, vessel_return_date, vessel_return_port, vessel_return_country)
as
    SELECT ll_o_d.source,
           ll_o_d.id                             AS trip_id,
           ll_o_d.uid                            AS trip_uid,
           gvt.trip_original_id                  AS trip_number,
           ll_o_d.creation_time                  AS creation_date,
           ll_o_d.finalization_time              AS finalization_date,
           ll_o_d.submission_time                AS submission_date,
           CASE
               WHEN otd.id IS NULL THEN 0
               ELSE 1
               END                               AS has_observer_trip_info,
           'LL'::text                            AS fishing_operation_type,
           oi.iotc_observer_identifier           AS observer_iotc_number,
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
             LEFT JOIN ros_common.observer oi ON gvt.observer_identification_id = oi.contact_id
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
create or replace view ros_meta.v_ps_trips
            (source, trip_id, trip_uid, trip_number, creation_date, finalization_date, submission_date, has_observer_trip_info, fishing_operation_type, observer_iotc_number, observer_imbarcation_date, observer_disembarcation_date, vessel_info_id,
             vessel_iotc_number, main_gear, reporting_flag, vessel_flag, vessel_departure_date, vessel_departure_port, vessel_departure_country, vessel_return_date, vessel_return_port, vessel_return_country)
as
    SELECT ps_o_d.source,
           ps_o_d.id                             AS trip_id,
           ps_o_d.uid                            AS trip_uid,
           gvt.trip_original_id                  AS trip_number,
           ps_o_d.creation_time                  AS creation_date,
           ps_o_d.finalization_time              AS finalization_date,
           ps_o_d.submission_time                AS submission_date,
           CASE
               WHEN otd.id IS NULL THEN 0
               ELSE 1
               END                               AS has_observer_trip_info,
           'PL'::text                            AS fishing_operation_type,
           oi.iotc_observer_identifier           AS observer_iotc_number,
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
             LEFT JOIN ros_common.observer oi ON gvt.observer_identification_id = oi.contact_id
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
create or replace view ros_meta.v_gn_trips
            (source, trip_id, trip_uid, trip_number, creation_date, finalization_date, submission_date, has_observer_trip_info, fishing_operation_type, observer_iotc_number, observer_imbarcation_date, observer_disembarcation_date, vessel_info_id,
             vessel_iotc_number, main_gear, reporting_flag, vessel_flag, vessel_departure_date, vessel_departure_port, vessel_departure_country, vessel_return_date, vessel_return_port, vessel_return_country)
as
    SELECT gn_o_d.source,
           gn_o_d.id                             AS trip_id,
           gn_o_d.uid                            AS trip_uid,
           gvt.trip_original_id                  AS trip_number,
           gn_o_d.creation_time                  AS creation_date,
           gn_o_d.finalization_time              AS finalization_date,
           gn_o_d.submission_time                AS submission_date,
           CASE
               WHEN otd.id IS NULL THEN 0
               ELSE 1
               END                               AS has_observer_trip_info,
           'GN'::text                            AS fishing_operation_type,
           oi.iotc_observer_identifier           AS observer_iotc_number,
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
             LEFT JOIN ros_common.observer oi ON gvt.observer_identification_id = oi.contact_id
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
create or replace view ros_meta.v_pl_trips
            (source, trip_id, trip_uid, trip_number, creation_date, finalization_date, submission_date, has_observer_trip_info, fishing_operation_type, observer_iotc_number, observer_imbarcation_date, observer_disembarcation_date, vessel_info_id,
             vessel_iotc_number, main_gear, reporting_flag, vessel_flag, vessel_departure_date, vessel_departure_port, vessel_departure_country, vessel_return_date, vessel_return_port, vessel_return_country)
as
    SELECT pl_o_d.source,
           pl_o_d.id                             AS trip_id,
           pl_o_d.uid                            AS trip_uid,
           gvt.trip_original_id                  AS trip_number,
           pl_o_d.creation_time                  AS creation_date,
           pl_o_d.finalization_time              AS finalization_date,
           pl_o_d.submission_time                AS submission_date,
           CASE
               WHEN otd.id IS NULL THEN 0
               ELSE 1
               END                               AS has_observer_trip_info,
           'PL'::text                            AS fishing_operation_type,
           oi.iotc_observer_identifier           AS observer_iotc_number,
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
             LEFT JOIN ros_common.observer oi ON gvt.observer_identification_id = oi.contact_id
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
create or replace view ros_meta.v_trips
            (source, trip_id, trip_uid, trip_number, creation_date, finalization_date, submission_date, has_observer_trip_info, fishing_operation_type, observer_iotc_number, observer_imbarcation_date, observer_disembarcation_date, vessel_info_id,
             vessel_iotc_number, main_gear, reporting_flag, vessel_flag, vessel_departure_date, vessel_departure_port, vessel_departure_country, vessel_return_date, vessel_return_port, vessel_return_country)
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
DROP TABLE ros_common.observer_identification;
DROP FUNCTION unaccent_string(text);
