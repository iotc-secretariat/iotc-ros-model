create or replace view ros_rlibs.v_ca
            (year, month_start, month_end, flag_code, fleet_code, gear_code, fishery_code, fishery_group_code, fishery_type_code, catch_school_type_code, fishing_ground_code, species_code, species_category_code, species_group_code, species_wp_code,
             is_iotc_species, is_species_aggregate, is_ssi, catch, catch_unit_code, fate_code)
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
             LEFT JOIN refs_biology.species s ON c.species::text = s.code::text;

create or replace view ros_rlibs.v_ef (year, month_start, month_end, flag_code, fleet_code, gear_code, fishery_code, fishery_group_code, fishery_type_code, effort_school_type_code, fishing_ground_code, effort, effort_unit_code) as
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

create or replace view ros_rlibs.v_ce
            (year, month_start, month_end, flag_code, fleet_code, gear_code, fishery_code, fishery_group_code, fishery_type_code, effort_school_type_code, fishing_ground_code, effort, effort_unit_code, catch_school_type_code, species_code,
             species_category_code, species_group_code, species_wp_code, is_iotc_species, is_species_aggregate, is_ssi, catch, catch_unit_code, fate_code)
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
             LEFT JOIN ros_rlibs.v_ca c ON e.year = c.year AND e.month_start = c.month_start AND e.flag_code::text = c.flag_code::text AND e.gear_code = c.gear_code AND e.fishing_ground_code = c.fishing_ground_code;

create or replace view ros_rlibs.v_in
            (year, month_start, month_end, flag_code, fleet_code, gear_code, fishery_code, fishery_group_code, fishery_type_code, catch_school_type_code, fishing_ground_code, species_code, species_category_code, species_group_code, species_wp_code,
             is_iotc_species, is_species_aggregate, is_ssi, num_interactions, fate_code, condition_code)
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
             LEFT JOIN refs_biology.species s ON c.species::text = s.code::text;

create or replace view ros_rlibs.v_sf
            (year, month_start, month_end, flag_code, fleet_code, gear_code, fishery_code, fishery_group_code, fishery_type_code, school_type_code, fishing_ground_code, species_code, species_category_code, species_group_code, species_wp_code,
             is_iotc_species, is_species_aggregate, is_ssi, sex_code, measure_type_code, measure_unit_code, fate_code, class_low, class_high, fish_count)
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
             LEFT JOIN refs_biology.species s ON c.species_code::text = s.code::text
    GROUP BY c.year, c.month_start, c.month_end, c.flag_code, c.fleet_code, c.gear_code, c.fishery_code, c.fishery_group_code, c.fishery_type_code, c.school_type_code, c.fishing_ground_code, s.code, s.species_category_code, s.species_group_code,
             s.is_iotc, s.is_aggregate, s.is_ssi, c.sex_code, c.measure_type_code, c.measure_unit_code, c.fate_code, c.class_low, c.class_high;

