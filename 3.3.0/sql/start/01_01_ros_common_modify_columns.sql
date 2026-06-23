-- Add a foreign key on "ros_common.reasons_for_days_lost→inoperativity_reason" to "refs_fishery.reasons_days_lost→code"
UPDATE ros_common.reasons_for_days_lost a SET inoperativity_reason = b.code FROM (SELECT code_orig, code FROM refs_fishery.reasons_days_lost) AS b WHERE a.inoperativity_reason = b.code_orig;
ALTER TABLE ros_common.reasons_for_days_lost ADD CONSTRAINT fk_reasons_for_days_lost_inoperativity_reason FOREIGN KEY (inoperativity_reason) REFERENCES refs_fishery.reasons_days_lost(code);

-- Rename the column "ros_common.measured_lengths→curved" to "ros_common.measured_lengths→straight" and inverse existing values
ALTER TABLE ros_common.measured_lengths RENAME curved TO straight;
UPDATE ros_common.measured_lengths SET straight = case when straight = 1 then 0 else 1 end ;


-- Rename the column ```ros_common.carrier_vessel_identification→vessel_registration_number``` to ```ros_common.carrier_vessel_identification→vessel_registration_original_id```
ALTER TABLE ros_common.carrier_vessel_identification RENAME vessel_registration_number TO vessel_registration_original_id;
-- Rename the column ```ros_common.general_vessel_and_trip_information→trip_original_id``` to ```ros_common.general_vessel_and_trip_information→trip_original_id```
ALTER TABLE ros_common.general_vessel_and_trip_information RENAME trip_number TO trip_original_id;

-- Remove the column "ros_common.observer_identification→nationality_code
-- Need to update those views:
DROP VIEW ros_analysis.v_trips_by_year_flag_and_gear;
DROP VIEW ros_analysis.v_sets_by_year_flag_and_gear;
DROP VIEW ros_meta.v_trips_by_flag_and_gear;
DROP VIEW ros_meta.v_trips_by_year_and_gear;
DROP VIEW ros_meta.v_target_species_by_trip;
DROP VIEW ros_meta.v_trips_by_year_flag_and_gear;
DROP VIEW ros_meta.v_sets_by_flag_and_gear;
DROP VIEW ros_meta.v_sets_by_year_flag_and_gear;
DROP VIEW ros_meta.v_ps_effort_summary;
DROP VIEW ros_meta.v_ll_effort_summary;
DROP VIEW ros_meta.v_trips;
DROP VIEW ros_meta.v_ll_trips;
DROP VIEW ros_meta.v_ps_trips;
DROP VIEW ros_meta.v_pl_trips;
DROP VIEW ros_meta.v_gn_trips;

-- view ros_meta.v_ll_trips depends on column nationality_code of table ros_common.observer_identification
CREATE VIEW ros_meta.v_ll_trips
            (source, trip_id, trip_uid, trip_original_id, creation_date, finalization_date, submission_date, has_observer_trip_info, fishing_operation_type, observer_iotc_number, observer_imbarcation_date,
             observer_disembarcation_date, vessel_info_id, vessel_iotc_number, main_gear, reporting_flag, vessel_flag, vessel_departure_date, vessel_departure_port, vessel_departure_country, vessel_return_date, vessel_return_port,
             vessel_return_country)
as
    SELECT ll_o_d.source,
           ll_o_d.id                             AS trip_id,
           ll_o_d.uid                            AS trip_uid,
           gvt.trip_original_id,
           ll_o_d.creation_time                  AS creation_date,
           ll_o_d.finalization_time              AS finalization_date,
           ll_o_d.submission_time                AS submission_date,
           CASE
               WHEN otd.id IS NULL THEN 0
               ELSE 1
               END                               AS has_observer_trip_info,
           'LL'::text                            AS fishing_operation_type,
           oi.iotc_number                        AS observer_iotc_number,
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
-- view ros_meta.v_ps_trips depends on column nationality_code of table ros_common.observer_identification
CREATE VIEW ros_meta.v_ps_trips
            (source, trip_id, trip_uid, trip_original_id, creation_date, finalization_date, submission_date, has_observer_trip_info, fishing_operation_type, observer_iotc_number, observer_imbarcation_date,
             observer_disembarcation_date, vessel_info_id, vessel_iotc_number, main_gear, reporting_flag, vessel_flag, vessel_departure_date, vessel_departure_port, vessel_departure_country, vessel_return_date, vessel_return_port,
             vessel_return_country)
as
    SELECT ps_o_d.source,
           ps_o_d.id                             AS trip_id,
           ps_o_d.uid                            AS trip_uid,
           gvt.trip_original_id,
           ps_o_d.creation_time                  AS creation_date,
           ps_o_d.finalization_time              AS finalization_date,
           ps_o_d.submission_time                AS submission_date,
           CASE
               WHEN otd.id IS NULL THEN 0
               ELSE 1
               END                               AS has_observer_trip_info,
           'PL'::text                            AS fishing_operation_type,
           oi.iotc_number                        AS observer_iotc_number,
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
-- view ros_meta.v_gn_trips depends on column nationality_code of table ros_common.observer_identification
CREATE VIEW ros_meta.v_gn_trips
            (source, trip_id, trip_uid, trip_original_id, creation_date, finalization_date, submission_date, has_observer_trip_info, fishing_operation_type, observer_iotc_number, observer_imbarcation_date,
             observer_disembarcation_date, vessel_info_id, vessel_iotc_number, main_gear, reporting_flag, vessel_flag, vessel_departure_date, vessel_departure_port, vessel_departure_country, vessel_return_date, vessel_return_port,
             vessel_return_country)
as
    SELECT gn_o_d.source,
           gn_o_d.id                             AS trip_id,
           gn_o_d.uid                            AS trip_uid,
           gvt.trip_original_id,
           gn_o_d.creation_time                  AS creation_date,
           gn_o_d.finalization_time              AS finalization_date,
           gn_o_d.submission_time                AS submission_date,
           CASE
               WHEN otd.id IS NULL THEN 0
               ELSE 1
               END                               AS has_observer_trip_info,
           'GN'::text                            AS fishing_operation_type,
           oi.iotc_number                        AS observer_iotc_number,
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

-- view ros_meta.v_pl_trips depends on column nationality_code of table ros_common.observer_identification
CREATE VIEW ros_meta.v_pl_trips
            (source, trip_id, trip_uid, trip_original_id, creation_date, finalization_date, submission_date, has_observer_trip_info, fishing_operation_type, observer_iotc_number, observer_imbarcation_date,
             observer_disembarcation_date, vessel_info_id, vessel_iotc_number, main_gear, reporting_flag, vessel_flag, vessel_departure_date, vessel_departure_port, vessel_departure_country, vessel_return_date, vessel_return_port,
             vessel_return_country)
as
    SELECT pl_o_d.source,
           pl_o_d.id                             AS trip_id,
           pl_o_d.uid                            AS trip_uid,
           gvt.trip_original_id,
           pl_o_d.creation_time                  AS creation_date,
           pl_o_d.finalization_time              AS finalization_date,
           pl_o_d.submission_time                AS submission_date,
           CASE
               WHEN otd.id IS NULL THEN 0
               ELSE 1
               END                               AS has_observer_trip_info,
           'PL'::text                            AS fishing_operation_type,
           oi.iotc_number                        AS observer_iotc_number,
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

-- view ros_meta.v_trips depends on view ros_meta.v_pl_trips
CREATE VIEW ros_meta.v_trips
            (source, trip_id, trip_uid, trip_original_id, creation_date, finalization_date, submission_date, has_observer_trip_info, fishing_operation_type, observer_iotc_number, observer_imbarcation_date,
             observer_disembarcation_date, vessel_info_id, vessel_iotc_number, main_gear, reporting_flag, vessel_flag, vessel_departure_date, vessel_departure_port, vessel_departure_country, vessel_return_date, vessel_return_port,
             vessel_return_country)
as
    SELECT v_ll_trips.source,
           v_ll_trips.trip_id,
           v_ll_trips.trip_uid,
           v_ll_trips.trip_original_id,
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
           v_ps_trips.trip_original_id,
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
           v_gn_trips.trip_original_id,
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
           v_pl_trips.trip_original_id,
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
-- view ros_meta.v_trips_by_flag_and_gear depends on view ros_meta.v_trips
create view ros_meta.v_trips_by_flag_and_gear(flag, gear, num_trips) as
    SELECT CASE
               WHEN reporting_flag = ANY (ARRAY ['FRA'::bpchar, 'ESP'::bpchar]) THEN concat('EU.', reporting_flag)::bpchar
               ELSE reporting_flag
               END                AS flag,
           fishing_operation_type AS gear,
           count(*)               AS num_trips
    FROM ros_meta.v_trips t
    GROUP BY reporting_flag, fishing_operation_type;

-- view ros_meta.v_trips_by_year_and_gear depends on view ros_meta.v_trips
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
-- view ros_meta.v_target_species_by_trip depends on view ros_meta.v_trips
create view ros_meta.v_target_species_by_trip(trip_id, trip_uid, trip_original_id, vessel_flag, fishing_operation_type, main_gear, target_species_code, target_species) as
    SELECT t.trip_id,
           t.trip_uid,
           t.trip_original_id,
           t.vessel_flag,
           t.fishing_operation_type,
           t.main_gear,
           s_t.code    AS target_species_code,
           s_t.name_en AS target_species
    FROM ros_meta.v_trips t
             LEFT JOIN ros_common.vessel_identification vi ON t.vessel_info_id = vi.id
             LEFT JOIN ros_common.vessel_identification_licensed_target_species vi2lts ON vi2lts.vessel_identification_id = vi.id
             LEFT JOIN refs_biological.species s_t ON vi2lts.licensed_target_species_code::text = s_t.code::text;
-- view ros_meta.v_trips_by_year_flag_and_gear depends on view ros_meta.v_trips
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
-- view ros_meta.v_sets_by_flag_and_gear depends on view ros_meta.v_trips
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
-- view ros_meta.v_sets_by_year_flag_and_gear depends on view ros_meta.v_trips
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
-- view ros_meta.v_ps_effort_summary depends on view ros_meta.v_trips
create view ros_meta.v_ps_effort_summary(year, month, vessel_flag, grid_1, grid_5, valid_grid_1, valid_grid_5, effort) as
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
-- view ros_meta.v_ll_effort_summary depends on view ros_meta.v_trips
create view ros_meta.v_ll_effort_summary(year, month, vessel_flag, grid_1, grid_5, valid_grid_1, valid_grid_5, effort) as
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
-- view ros_analysis.v_trips_by_year_flag_and_gear depends on view ros_meta.v_trips_by_year_flag_and_gear
create view ros_analysis.v_trips_by_year_flag_and_gear(year, flag, gear, num_trips) as
    SELECT year,
           flag,
           gear,
           sum(num_trips) AS num_trips
    FROM ros_meta.v_trips_by_year_flag_and_gear
    GROUP BY year, flag, gear;
-- view ros_analysis.v_sets_by_year_flag_and_gear depends on view ros_meta.v_sets_by_year_flag_and_gear
create view ros_analysis.v_sets_by_year_flag_and_gear(year, flag, gear, num_sets) as
    SELECT year,
           flag,
           gear,
           num_sets
    FROM ros_meta.v_sets_by_year_flag_and_gear;

ALTER TABLE ros_common.observer_identification DROP COLUMN nationality_code;

-- Remove the column "ros_common.vessel_owner_and_personnel.registered_vessel_owner_id"
ALTER TABLE ros_common.vessel_owner_and_personnel DROP CONSTRAINT vsslwnrnrgstrdvsslwnrd;
DELETE FROM ros_common.person_contact_details WHERE id IN (SELECT registered_vessel_owner_id FROM  ros_common.vessel_owner_and_personnel);
ALTER TABLE ros_common.vessel_owner_and_personnel DROP COLUMN registered_vessel_owner_id;

-- Remove the column "ros_common.vessel_owner_and_personnel.charter_or_operator_id"
ALTER TABLE ros_common.vessel_owner_and_personnel DROP CONSTRAINT vsslwnrndprchrtrrprtrd;
DELETE FROM ros_common.person_contact_details WHERE id IN (SELECT charter_or_operator_id FROM  ros_common.vessel_owner_and_personnel);
ALTER TABLE ros_common.vessel_owner_and_personnel DROP COLUMN charter_or_operator_id;

-- Remove the column "ros_common.vessel_electronics→sea_surface_temperature_gauge"
ALTER TABLE ros_common.vessel_electronics DROP COLUMN sea_surface_temperature_gauge;

-- Remove the column "ros_common.vessel_electronics→weather_facsimile"
ALTER TABLE ros_common.vessel_electronics DROP COLUMN weather_facsimile;

-- Change the type of column ```ros_common.measured_lengths→straight``` to boolean (default value false)
ALTER TABLE ros_common.measured_lengths ADD COLUMN straight2 BOOLEAN DEFAULT FALSE;
UPDATE ros_common.measured_lengths SET straight2 = case when straight = 0 then FALSE else TRUE end;
ALTER TABLE ros_common.measured_lengths DROP COLUMN straight;
ALTER TABLE ros_common.measured_lengths RENAME straight2 TO straight;
-- Change the type of column ```ros_common.vessel_electronics→ais``` to boolean (default value false)
ALTER TABLE ros_common.vessel_electronics ADD COLUMN ais2 BOOLEAN DEFAULT FALSE;
UPDATE ros_common.vessel_electronics SET ais2 = case when ais = 0 then FALSE else TRUE end;
ALTER TABLE ros_common.vessel_electronics DROP COLUMN ais;
ALTER TABLE ros_common.vessel_electronics RENAME ais2 TO ais;
-- Change the type of column ```ros_common.vessel_electronics→depth_sounder``` to boolean (default value false)
ALTER TABLE ros_common.vessel_electronics ADD COLUMN depth_sounder2 BOOLEAN DEFAULT FALSE;
UPDATE ros_common.vessel_electronics SET depth_sounder2 = case when depth_sounder = 0 then FALSE else TRUE end;
ALTER TABLE ros_common.vessel_electronics DROP COLUMN depth_sounder;
ALTER TABLE ros_common.vessel_electronics RENAME depth_sounder2 TO depth_sounder;
-- Change the type of column ```ros_common.vessel_electronics→doppler_current_meter``` to boolean (default value false)
ALTER TABLE ros_common.vessel_electronics ADD COLUMN doppler_current_meter2 BOOLEAN DEFAULT FALSE;
UPDATE ros_common.vessel_electronics SET doppler_current_meter2 = case when doppler_current_meter = 0 then FALSE else TRUE end;
ALTER TABLE ros_common.vessel_electronics DROP COLUMN doppler_current_meter;
ALTER TABLE ros_common.vessel_electronics RENAME doppler_current_meter2 TO doppler_current_meter;
-- Change the type of column ```ros_common.vessel_electronics→expendable_bathythermographs``` to boolean (default value false)
ALTER TABLE ros_common.vessel_electronics ADD COLUMN expendable_bathythermographs2 BOOLEAN DEFAULT FALSE;
UPDATE ros_common.vessel_electronics SET expendable_bathythermographs2 = case when expendable_bathythermographs = 0 then FALSE else TRUE end;
ALTER TABLE ros_common.vessel_electronics DROP COLUMN expendable_bathythermographs;
ALTER TABLE ros_common.vessel_electronics RENAME expendable_bathythermographs2 TO expendable_bathythermographs;
-- Change the type of column ```ros_common.vessel_electronics→fisheries_information_services``` to boolean (default value false)
ALTER TABLE ros_common.vessel_electronics ADD COLUMN fisheries_information_services2 BOOLEAN DEFAULT FALSE;
UPDATE ros_common.vessel_electronics SET fisheries_information_services2 = case when fisheries_information_services = 0 then FALSE else TRUE end;
ALTER TABLE ros_common.vessel_electronics DROP COLUMN fisheries_information_services;
ALTER TABLE ros_common.vessel_electronics RENAME fisheries_information_services2 TO fisheries_information_services;
-- Change the type of column ```ros_common.vessel_electronics→gps``` to boolean (default value false)
ALTER TABLE ros_common.vessel_electronics ADD COLUMN gps2 BOOLEAN DEFAULT FALSE;
UPDATE ros_common.vessel_electronics SET gps2 = case when gps = 0 then FALSE else TRUE end;
ALTER TABLE ros_common.vessel_electronics DROP COLUMN gps;
ALTER TABLE ros_common.vessel_electronics RENAME gps2 TO gps;
-- Change the type of column ```ros_common.vessel_electronics→hf_radios``` to boolean (default value false)
ALTER TABLE ros_common.vessel_electronics ADD COLUMN hf_radios2 BOOLEAN DEFAULT FALSE;
UPDATE ros_common.vessel_electronics SET hf_radios2 = case when hf_radios = 0 then FALSE else TRUE end;
ALTER TABLE ros_common.vessel_electronics DROP COLUMN hf_radios;
ALTER TABLE ros_common.vessel_electronics RENAME hf_radios2 TO hf_radios;
-- Change the type of column ```ros_common.vessel_electronics→radars``` to boolean (default value false)
ALTER TABLE ros_common.vessel_electronics ADD COLUMN radars2 BOOLEAN DEFAULT FALSE;
UPDATE ros_common.vessel_electronics SET radars2 = case when radars = 0 then FALSE else TRUE end;
ALTER TABLE ros_common.vessel_electronics DROP COLUMN radars;
ALTER TABLE ros_common.vessel_electronics RENAME radars2 TO radars;
-- Change the type of column ```ros_common.vessel_electronics→satellite_communication_systems``` to boolean (default value false)
ALTER TABLE ros_common.vessel_electronics ADD COLUMN satellite_communication_systems2 BOOLEAN DEFAULT FALSE;
UPDATE ros_common.vessel_electronics SET satellite_communication_systems2 = case when satellite_communication_systems = 0 then FALSE else TRUE end;
ALTER TABLE ros_common.vessel_electronics DROP COLUMN satellite_communication_systems;
ALTER TABLE ros_common.vessel_electronics RENAME satellite_communication_systems2 TO satellite_communication_systems;
-- Change the type of column ```ros_common.vessel_electronics→sonar``` to boolean (default value false)
ALTER TABLE ros_common.vessel_electronics ADD COLUMN sonar2 BOOLEAN DEFAULT FALSE;
UPDATE ros_common.vessel_electronics SET sonar2 = case when sonar = 0 then FALSE else TRUE end;
ALTER TABLE ros_common.vessel_electronics DROP COLUMN sonar;
ALTER TABLE ros_common.vessel_electronics RENAME sonar2 TO sonar;
-- Change the type of column ```ros_common.vessel_electronics→track_plotter``` to boolean (default value false)
ALTER TABLE ros_common.vessel_electronics ADD COLUMN track_plotter2 BOOLEAN DEFAULT FALSE;
UPDATE ros_common.vessel_electronics SET track_plotter2 = case when track_plotter = 0 then FALSE else TRUE end;
ALTER TABLE ros_common.vessel_electronics DROP COLUMN track_plotter;
ALTER TABLE ros_common.vessel_electronics RENAME track_plotter2 TO track_plotter;
-- Change the type of column ```ros_common.vessel_electronics→vhf_radios``` to boolean (default value false)
ALTER TABLE ros_common.vessel_electronics ADD COLUMN vhf_radios2 BOOLEAN DEFAULT FALSE;
UPDATE ros_common.vessel_electronics SET vhf_radios2 = case when vhf_radios = 0 then FALSE else TRUE end;
ALTER TABLE ros_common.vessel_electronics DROP COLUMN vhf_radios;
ALTER TABLE ros_common.vessel_electronics RENAME vhf_radios2 TO vhf_radios;
-- Change the type of column ```ros_common.vessel_electronics→vms``` to boolean (default value false)
ALTER TABLE ros_common.vessel_electronics ADD COLUMN vms2 BOOLEAN DEFAULT FALSE;
UPDATE ros_common.vessel_electronics SET vms2 = case when vms = 0 then FALSE else TRUE end;
ALTER TABLE ros_common.vessel_electronics DROP COLUMN vms;
ALTER TABLE ros_common.vessel_electronics RENAME vms2 TO vms;