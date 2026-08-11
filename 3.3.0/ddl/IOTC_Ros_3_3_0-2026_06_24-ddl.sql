--
-- PostgreSQL database dump
--

\restrict ylDCc8nv5Tl3KZKiQcohXITG23SJjQlLdQj95mdML0kOGDi20ZXghXfOhIbDAQk

-- Dumped from database version 16.14 (Ubuntu 16.14-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.14 (Ubuntu 16.14-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: ros_analysis; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA ros_analysis;


--
-- Name: ros_common; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA ros_common;


--
-- Name: ros_gn; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA ros_gn;


--
-- Name: ros_ll; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA ros_ll;


--
-- Name: ros_meta; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA ros_meta;


--
-- Name: ros_pl; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA ros_pl;


--
-- Name: ros_ps; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA ros_ps;


--
-- Name: ros_rlibs; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA ros_rlibs;


--
-- Name: ros_views; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA ros_views;


--
-- Name: coords_to_grid_1(integer, integer, character, integer, integer, character); Type: FUNCTION; Schema: ros_meta; Owner: -
--

CREATE FUNCTION ros_meta.coords_to_grid_1(v_lat_deg integer, v_lat_min integer, v_lat_emi character, v_lon_deg integer, v_lon_min integer, v_lon_emi character) RETURNS character
    LANGUAGE plpgsql
    AS $$

DECLARE
    V_GRID VARCHAR(7);
    V_TEMP VARCHAR(3);

BEGIN
    IF (V_LAT_DEG > 90) THEN
        V_LAT_DEG := 90;
    END IF;
    IF (V_LON_DEG > 180) THEN
        V_LON_DEG := 180;
    END IF;

    V_GRID := '5';

    IF (V_LAT_EMI = 'N') THEN
        V_GRID := V_GRID + '1';
    ELSE
        V_GRID := V_GRID + '2';
    END IF;

    V_TEMP := CAST(V_LAT_DEG AS VARCHAR(2));
    V_TEMP := RIGHT('00' + V_TEMP, 2);

    V_GRID := V_GRID + V_TEMP;

    V_TEMP := CAST(V_LON_DEG AS VARCHAR(3));
    V_TEMP := RIGHT('000' + V_TEMP, 3);

    RETURN CAST(V_GRID + V_TEMP AS CHAR(7));
END;
$$;


--
-- Name: coords_to_grid_5(integer, integer, character, integer, integer, character); Type: FUNCTION; Schema: ros_meta; Owner: -
--

CREATE FUNCTION ros_meta.coords_to_grid_5(v_lat_deg integer, v_lat_min integer, v_lat_emi character, v_lon_deg integer, v_lon_min integer, v_lon_emi character) RETURNS character
    LANGUAGE plpgsql
    AS $$

DECLARE
    V_GRID VARCHAR(7);
    V_TEMP VARCHAR(3);

BEGIN
    IF (V_LAT_DEG > 90) THEN
        V_LAT_DEG := 90;
    END IF;
    IF (V_LON_DEG > 180) THEN
        V_LON_DEG := 180;
    END IF;

    V_LAT_DEG := V_LAT_DEG / 5 * 5;
    V_LON_DEG := V_LON_DEG / 5 * 5;

    V_GRID := '6';

    IF (V_LAT_EMI = 'N') THEN
        V_GRID := V_GRID + '1';
    ELSE
        V_GRID := V_GRID + '2';
    END IF;

    V_TEMP := CAST(V_LAT_DEG AS VARCHAR(2));
    V_TEMP := RIGHT('00' + V_TEMP, 2);

    V_GRID := V_GRID + V_TEMP;

    V_TEMP := CAST(V_LON_DEG AS VARCHAR(3));
    V_TEMP := RIGHT('000' + V_TEMP, 3);

    RETURN CAST(V_GRID + V_TEMP AS CHAR(7));
END;
$$;


--
-- Name: latlon_to_grid_1(double precision, double precision); Type: FUNCTION; Schema: ros_meta; Owner: -
--

CREATE FUNCTION ros_meta.latlon_to_grid_1(v_lat double precision, v_lon double precision) RETURNS character
    LANGUAGE plpgsql
    AS $$

DECLARE
    V_LAT_E   CHAR(1);
    V_LON_E   CHAR(1);
    V_LAT_DEG INT;
    V_LAT_MIN INT;
    V_LON_DEG INT;
    V_LON_MIN INT;

BEGIN

    IF (V_LAT < 0) THEN
        V_LAT_E := 'S';
    ELSE
        V_LAT_E := 'N';
    END IF;
    IF (V_LON < 0) THEN
        V_LON_E := 'W';
    ELSE
        V_LON_E := 'E';
    END IF;

    V_LAT_DEG := FLOOR(ABS(V_LAT));
    V_LAT_MIN := 0;

    V_LON_DEG := FLOOR(ABS(V_LON));
    V_LON_MIN := 0;

    RETURN ROS_meta.COORDS_TO_GRID_1(V_LAT_DEG, V_LAT_MIN, V_LAT_E, V_LON_DEG, V_LON_MIN, V_LON_E);
END;
$$;


--
-- Name: latlon_to_grid_5(double precision, double precision); Type: FUNCTION; Schema: ros_meta; Owner: -
--

CREATE FUNCTION ros_meta.latlon_to_grid_5(v_lat double precision, v_lon double precision) RETURNS character
    LANGUAGE plpgsql
    AS $$

DECLARE
    V_LAT_E   CHAR(1);
    V_LON_E   CHAR(1);
    V_LAT_DEG INT;
    V_LAT_MIN INT;
    V_LON_DEG INT;
    V_LON_MIN INT;

BEGIN

    IF (V_LAT < 0) THEN
        V_LAT_E := 'S';
    ELSE
        V_LAT_E := 'N';
    END IF;
    IF (V_LON < 0) THEN
        V_LON_E := 'W';
    ELSE
        V_LON_E := 'E';
    END IF;

    V_LAT_DEG := FLOOR(ABS(V_LAT));
    V_LAT_MIN := 0;

    V_LON_DEG := FLOOR(ABS(V_LON));
    V_LON_MIN := 0;

    RETURN ROS_meta.COORDS_TO_GRID_5(V_LAT_DEG, V_LAT_MIN, V_LAT_E, V_LON_DEG, V_LON_MIN, V_LON_E);
END;
$$;


--
-- Name: password_hash(character varying, character varying); Type: FUNCTION; Schema: ros_meta; Owner: -
--

CREATE FUNCTION ros_meta.password_hash(v_username character varying, v_password character varying) RETURNS character
    LANGUAGE plpgsql
    AS $$

BEGIN
    RETURN HASH(CONCAT('ROS_', V_password, '_', V_username));
END;
$$;


--
-- Name: to_grid_1(double precision, double precision); Type: FUNCTION; Schema: ros_meta; Owner: -
--

CREATE FUNCTION ros_meta.to_grid_1(v_lat double precision, v_lon double precision) RETURNS character
    LANGUAGE plpgsql
    AS $$

DECLARE
    V_GRID VARCHAR(7);
    V_TEMP VARCHAR(3);

BEGIN
    IF (V_LAT > 90) THEN
        V_LAT := 90;
    END IF;
    IF (V_LAT < -90) THEN
        V_LAT := -90;
    END IF;
    IF (V_LON > 180) THEN
        V_LON := 180;
    END IF;
    IF (V_LON < -180) THEN
        V_LON := -180;
    END IF;

    V_GRID := '5';

    IF (V_LAT <= 0) THEN
        V_GRID := V_GRID || '2';
    ELSE
        V_GRID := V_GRID || '1';
    END IF;

    V_TEMP := CAST(FLOOR(ABS(V_LAT)) AS VARCHAR(2));
    V_TEMP := RIGHT('00' || V_TEMP, 2);

    V_GRID := V_GRID || V_TEMP;

    V_TEMP := CAST(FLOOR(ABS(V_LON)) AS VARCHAR(3));
    V_TEMP := RIGHT('000' || V_TEMP, 3);

    RETURN CAST(V_GRID || V_TEMP AS CHAR(7));
END;
$$;


--
-- Name: to_grid_5(double precision, double precision); Type: FUNCTION; Schema: ros_meta; Owner: -
--

CREATE FUNCTION ros_meta.to_grid_5(v_lat double precision, v_lon double precision) RETURNS character
    LANGUAGE plpgsql
    AS $$

DECLARE
    V_GRID VARCHAR(7);
    V_TEMP VARCHAR(3);

BEGIN
    IF (V_LAT > 90) THEN
        V_LAT := 90;
    END IF;
    IF (V_LAT < -90) THEN
        V_LAT := -90;
    END IF;
    IF (V_LON > 180) THEN
        V_LON := 180;
    END IF;
    IF (V_LON < -180) THEN
        V_LON := -180;
    END IF;

    V_GRID := '6';

    IF (V_LAT <= 0) THEN
        V_GRID := V_GRID || '2';
    ELSE
        V_GRID := V_GRID || '1';
    END IF;

    V_TEMP := CAST((CAST(ABS(V_LAT) AS INT) / 5 * 5) AS VARCHAR(2));
    V_TEMP := RIGHT('00' || V_TEMP, 2);

    V_GRID := V_GRID || V_TEMP;

    V_TEMP := CAST((CAST(ABS(V_LON) AS INT) / 5 * 5) AS VARCHAR(3));
    V_TEMP := RIGHT('000' || V_TEMP, 3);

    RETURN CAST(V_GRID || V_TEMP AS CHAR(7));
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: observation_dataset; Type: TABLE; Schema: ros_common; Owner: -
--

CREATE TABLE ros_common.observation_dataset (
    id integer NOT NULL,
    vessel_type_code character(3) NOT NULL,
    reporting_country_code character(3) NOT NULL,
    complete boolean DEFAULT false NOT NULL,
    creation_time timestamp(6) without time zone NOT NULL,
    originator character varying(255) NOT NULL,
    originator_version character varying(255) NOT NULL,
    ros_codelists_version character varying(255) NOT NULL,
    ros_model_version character varying(255) NOT NULL,
    source character varying(255) NOT NULL,
    status character varying(255) NOT NULL,
    submission_time timestamp(6) without time zone,
    finalization_time timestamp(6) without time zone,
    submitter_id integer NOT NULL,
    reporting_year integer,
    reporting_entity_code character varying(4),
    reporting_source_dataset_code character(2),
    reporting_source_code character(2),
    CONSTRAINT observation_dataset_reporting_source_dataset_code_check CHECK ((reporting_source_dataset_code = 'RO'::bpchar))
);


--
-- Name: trip; Type: TABLE; Schema: ros_common; Owner: -
--

CREATE TABLE ros_common.trip (
    id integer NOT NULL,
    trip_original_id character varying(255) NOT NULL,
    observation_dataset_id integer NOT NULL,
    uid character varying(255) NOT NULL
);


--
-- Name: trip_vessel; Type: TABLE; Schema: ros_common; Owner: -
--

CREATE TABLE ros_common.trip_vessel (
    trip_id integer NOT NULL,
    number_of_active_fishing_days integer,
    number_of_conducted_fishing_events_with_observer_onboard integer,
    number_of_days_in_fishing_area integer,
    number_of_days_lost integer,
    number_of_days_searching integer,
    number_of_days_transiting integer,
    number_of_observed_fishing_events integer,
    hull_material_code character(2),
    number_of_crew integer,
    return_timestamp timestamp(6) without time zone,
    departure_timestamp timestamp(6) without time zone,
    skipper_id integer,
    fishing_master_id integer,
    vessel_id integer,
    fish_storage_capacity_value double precision,
    fish_storage_capacity_unit character varying(3),
    loa_value double precision,
    loa_unit character varying(3),
    departure_location_name character varying(255),
    departure_latitude double precision,
    departure_longitude double precision,
    departure_country_code character(3),
    departure_port_code character varying(16),
    return_location_name character varying(255),
    return_latitude double precision,
    return_longitude double precision,
    return_country_code character(3),
    return_port_code character varying(16),
    autonomy_range_value double precision,
    autonomy_range_unit character varying(3),
    tonnage_value double precision,
    tonnage_unit character varying(3),
    ais character varying(5),
    gps character varying(5),
    vms character varying(5),
    depth_sounder character varying(5),
    doppler_current_meter character varying(5),
    expendable_bathythermographs character varying(5),
    fisheries_information_services character varying(5),
    hf_radios character varying(5),
    radars character varying(5),
    satellite_communication_systems character varying(5),
    sonar character varying(5),
    track_plotter character varying(5),
    vhf_radios character varying(5),
    CONSTRAINT ros_common_trip_vessel_estimated_weight_unit_check CHECK (((loa_unit)::text = ANY ((ARRAY['km'::character varying, 'm'::character varying])::text[]))),
    CONSTRAINT ros_common_trip_vessel_fish_storage_capacity_unit_check CHECK (((fish_storage_capacity_unit)::text = ANY ((ARRAY['m3'::character varying, 'mt'::character varying])::text[]))),
    CONSTRAINT ros_common_trip_vessel_tonnage_unit_check CHECK (((tonnage_unit)::text = ANY ((ARRAY['grt'::character varying, 'gt'::character varying])::text[])))
);


--
-- Name: catch_details; Type: TABLE; Schema: ros_ll; Owner: -
--

CREATE TABLE ros_ll.catch_details (
    id integer NOT NULL,
    catch_detail_original_id character varying(255) NOT NULL,
    comments text,
    estimated_catch_in_numbers integer,
    fishing_event_id integer,
    type_of_fate_code character(2),
    estimated_weight_sampling_method_code character(2),
    fates_code character(2),
    species_code character varying(16),
    estimated_weight_value double precision,
    estimated_weight_unit character varying(3),
    estimated_weight_type_of_measurement_code character(2),
    estimated_weight_processing_type_code character(2),
    estimated_weight_method_code character(2),
    CONSTRAINT ros_ll_catch_details_estimated_weight_unit_check CHECK (((estimated_weight_unit)::text = ANY ((ARRAY['kg'::character varying, 't'::character varying])::text[])))
);


--
-- Name: fishing_events; Type: TABLE; Schema: ros_ll; Owner: -
--

CREATE TABLE ros_ll.fishing_events (
    id integer NOT NULL,
    comments text,
    event_original_id character varying(255),
    hauling_operation_id integer,
    mitigation_measure_id integer,
    setting_operation_id integer,
    trip_id integer NOT NULL
);


--
-- Name: setting_operations; Type: TABLE; Schema: ros_ll; Owner: -
--

CREATE TABLE ros_ll.setting_operations (
    id integer NOT NULL,
    branchline_clip_on_time double precision,
    buoys_clip_on_time double precision,
    distance_between_branchlines double precision,
    end_setting_date_and_time timestamp(6) without time zone,
    number_of_hooks_set_between_floats integer,
    number_of_shark_lines_set integer,
    start_setting_date_and_time timestamp(6) without time zone,
    total_number_of_floats_set integer,
    total_number_of_hooks_set integer,
    total_radio_dhan_buoys_set integer,
    end_setting_latitude double precision,
    end_setting_longitude double precision,
    start_setting_latitude double precision,
    start_setting_longitude double precision,
    mainline_set_length_value double precision,
    mainline_set_length_unit character varying(3),
    vessel_speed_value double precision,
    vessel_speed_unit character varying(3),
    line_setter_speed_value double precision,
    line_setter_speed_unit character varying(3),
    shark_lines_set character varying(5),
    CONSTRAINT ros_ll_setting_operations_line_setter_speed_unit_check CHECK (((line_setter_speed_unit)::text = 'kn'::text)),
    CONSTRAINT ros_ll_setting_operations_mainline_set_length_unit_check CHECK (((mainline_set_length_unit)::text = ANY ((ARRAY['km'::character varying, 'm'::character varying])::text[]))),
    CONSTRAINT ros_ll_setting_operations_vessel_speed_unit_check CHECK (((vessel_speed_unit)::text = 'kn'::text))
);


--
-- Name: specimens; Type: TABLE; Schema: ros_ll; Owner: -
--

CREATE TABLE ros_ll.specimens (
    id integer NOT NULL,
    sampling_period character varying(255),
    specimen_original_id character varying(255) NOT NULL,
    additional_catch_details_on_ssis_id integer,
    additional_specimen_details_non_target_species_id integer,
    biometric_information_id integer,
    depredation_detail_id integer,
    tag_detail_id integer,
    catch_detail_id integer
);


--
-- Name: vessel; Type: TABLE; Schema: ros_meta; Owner: -
--

CREATE TABLE ros_meta.vessel (
    id integer NOT NULL,
    imo_identifier character varying(255),
    iotc_vessel_identifier character varying(255) NOT NULL,
    ircs_identifier character varying(255),
    vessel_name character varying(255) NOT NULL,
    registration_identifier character varying(255),
    main_fishing_gear_code character varying(16) NOT NULL,
    flag_code character(3),
    port_code character varying(16)
);


--
-- Name: v_ll_ca; Type: VIEW; Schema: ros_analysis; Owner: -
--

CREATE VIEW ros_analysis.v_ll_ca AS
 SELECT 'LL'::text AS gear,
    COALESCE(fl.fleet_code, (cl_co.code)::character varying) AS flag,
    date_part('year'::text, se.start_setting_date_and_time) AS year,
    date_part('month'::text, se.start_setting_date_and_time) AS month,
    ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
    ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
    cl_sp.code AS species,
    cl_sp.species_group_code,
    cl_fa.code AS fate,
    count(DISTINCT sp.id) AS observed_catch,
    'NO'::text AS catch_unit
   FROM (((((((((((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     JOIN ros_common.trip_vessel gvti ON ((t.id = gvti.trip_id)))
     JOIN ros_meta.vessel vi ON ((gvti.vessel_id = vi.id)))
     JOIN refs_admin.countries cl_co ON ((vi.flag_code = cl_co.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON ((cl_co.code = (fl.flag_code)::bpchar)))
     JOIN ros_ll.fishing_events fe ON ((fe.trip_id = t.id)))
     LEFT JOIN ros_ll.setting_operations se ON ((fe.setting_operation_id = se.id)))
     JOIN ros_ll.catch_details ca ON ((ca.fishing_event_id = fe.id)))
     JOIN refs_biology.species cl_sp ON (((ca.species_code)::text = (cl_sp.code)::text)))
     LEFT JOIN refs_biology.fates cl_fa ON ((ca.fates_code = cl_fa.code)))
     JOIN ros_ll.specimens sp ON ((sp.catch_detail_id = ca.id)))
  WHERE ((od.vessel_type_code = 'LL'::bpchar) AND (se.start_setting_date_and_time IS NOT NULL))
  GROUP BY COALESCE(fl.fleet_code, (cl_co.code)::character varying), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)), (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude)), cl_sp.code, cl_sp.species_group_code, cl_fa.code;


--
-- Name: catch_details; Type: TABLE; Schema: ros_ps; Owner: -
--

CREATE TABLE ros_ps.catch_details (
    id integer NOT NULL,
    catch_detail_original_id character varying(255) NOT NULL,
    comments text,
    estimated_catch_in_numbers integer,
    fishing_event_id integer NOT NULL,
    type_of_fate_code character(2) NOT NULL,
    estimated_weight_sampling_method_code character(2),
    fates_code character(2),
    species_code character varying(16),
    estimated_weight_value double precision,
    estimated_weight_unit character varying(3),
    estimated_weight_type_of_measurement_code character(2),
    estimated_weight_processing_type_code character(2),
    estimated_weight_method_code character(2),
    CONSTRAINT ros_ps_catch_details_estimated_weight_unit_check CHECK (((estimated_weight_unit)::text = ANY ((ARRAY['kg'::character varying, 't'::character varying])::text[])))
);


--
-- Name: fishing_events; Type: TABLE; Schema: ros_ps; Owner: -
--

CREATE TABLE ros_ps.fishing_events (
    id integer NOT NULL,
    comments text,
    event_original_id character varying(255),
    setting_operation_id integer NOT NULL,
    trip_id integer NOT NULL
);


--
-- Name: setting_operations; Type: TABLE; Schema: ros_ps; Owner: -
--

CREATE TABLE ros_ps.setting_operations (
    id integer NOT NULL,
    maximum_closing_net_depth double precision,
    school_size double precision,
    start_setting_date_and_time timestamp(6) without time zone,
    time_end_brailing timestamp(6) without time zone,
    time_net_pursed timestamp(6) without time zone,
    time_skiff_onboard timestamp(6) without time zone,
    time_start_brailing timestamp(6) without time zone,
    start_setting_latitude double precision,
    start_setting_longitude double precision,
    ps_object_detail_id integer,
    first_school_detection_method_code character(2)
);


--
-- Name: v_ps_ca; Type: VIEW; Schema: ros_analysis; Owner: -
--

CREATE VIEW ros_analysis.v_ps_ca AS
 SELECT 'PS'::text AS gear,
    COALESCE(fl.fleet_code, (cl_co.code)::character varying) AS flag,
    date_part('year'::text, se.start_setting_date_and_time) AS year,
    date_part('month'::text, se.start_setting_date_and_time) AS month,
    ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
    ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
    cl_sp.code AS species,
    cl_sp.species_group_code,
    cl_fa.code AS fate,
    sum(((
        CASE
            WHEN ((ca.estimated_weight_unit)::text = 'MT'::text) THEN 1000
            ELSE 1
        END)::double precision * ca.estimated_weight_value)) AS observed_catch,
    'KG'::text AS catch_unit
   FROM (((((((((((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     JOIN ros_common.trip_vessel gvti ON ((t.id = gvti.trip_id)))
     JOIN ros_meta.vessel vi ON ((gvti.vessel_id = vi.id)))
     JOIN refs_admin.countries cl_co ON ((vi.flag_code = cl_co.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON ((cl_co.code = (fl.flag_code)::bpchar)))
     JOIN ros_ps.fishing_events fe ON ((fe.trip_id = t.id)))
     LEFT JOIN ros_ps.setting_operations se ON ((fe.setting_operation_id = se.id)))
     JOIN ros_ps.catch_details ca ON ((ca.fishing_event_id = fe.id)))
     JOIN refs_biology.species cl_sp ON (((ca.species_code)::text = (cl_sp.code)::text)))
     LEFT JOIN refs_biology.fates cl_fa ON ((ca.fates_code = cl_fa.code)))
     LEFT JOIN refs_fishery.fish_processing_types cl_pt ON ((ca.estimated_weight_processing_type_code = cl_pt.code)))
  WHERE (od.vessel_type_code = 'SP'::bpchar)
  GROUP BY COALESCE(fl.fleet_code, (cl_co.code)::character varying), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)), (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude)), cl_sp.code, cl_sp.species_group_code, cl_fa.code, ca.estimated_weight_unit;


--
-- Name: v_ca; Type: VIEW; Schema: ros_analysis; Owner: -
--

CREATE VIEW ros_analysis.v_ca AS
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


--
-- Name: hauling_operations; Type: TABLE; Schema: ros_ll; Owner: -
--

CREATE TABLE ros_ll.hauling_operations (
    id integer NOT NULL,
    end_hauling_date_and_time timestamp(6) without time zone,
    number_of_hooks_observed integer,
    offal_management character varying(255),
    start_hauling_date_and_time timestamp(6) without time zone,
    end_hauling_latitude double precision,
    end_hauling_longitude double precision,
    start_hauling_latitude double precision,
    start_hauling_longitude double precision,
    sampling_protocol_code character(2),
    bird_scaring_device_at_hauler character varying(5)
);


--
-- Name: v_ll_ef_fd; Type: VIEW; Schema: ros_analysis; Owner: -
--

CREATE VIEW ros_analysis.v_ll_ef_fd AS
 SELECT 'LL'::text AS gear,
    COALESCE(fl.fleet_code, (cl_co.code)::character varying) AS flag,
    date_part('year'::text, se.start_setting_date_and_time) AS year,
    date_part('month'::text, se.start_setting_date_and_time) AS month,
    ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
    ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
    count(DISTINCT date_part('day'::text, se.start_setting_date_and_time)) AS effort,
    'FDAYS'::text AS effort_unit
   FROM ((((((((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     JOIN ros_common.trip_vessel gvti ON ((t.id = gvti.trip_id)))
     JOIN ros_meta.vessel vi ON ((gvti.vessel_id = vi.id)))
     JOIN refs_admin.countries cl_co ON ((vi.flag_code = cl_co.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON ((cl_co.code = (fl.flag_code)::bpchar)))
     JOIN ros_ll.fishing_events fe ON ((fe.trip_id = t.id)))
     LEFT JOIN ros_ll.setting_operations se ON ((fe.setting_operation_id = se.id)))
     LEFT JOIN ros_ll.hauling_operations ha ON ((fe.hauling_operation_id = ha.id)))
  WHERE ((od.vessel_type_code = 'LL'::bpchar) AND (se.start_setting_date_and_time IS NOT NULL))
  GROUP BY COALESCE(fl.fleet_code, (cl_co.code)::character varying), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)), (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude));


--
-- Name: v_ll_ef_raw; Type: VIEW; Schema: ros_analysis; Owner: -
--

CREATE VIEW ros_analysis.v_ll_ef_raw AS
 SELECT 'LL'::text AS gear,
    COALESCE(fl.fleet_code, (cl_co.code)::character varying) AS flag,
    date_part('year'::text, se.start_setting_date_and_time) AS year,
    date_part('month'::text, se.start_setting_date_and_time) AS month,
    ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
    ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
    sum(se.total_number_of_hooks_set) AS observed_effort,
    'HOOKS'::text AS effort_unit
   FROM ((((((((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     JOIN ros_common.trip_vessel gvti ON ((t.id = gvti.trip_id)))
     JOIN ros_meta.vessel vi ON ((gvti.vessel_id = vi.id)))
     JOIN refs_admin.countries cl_co ON ((vi.flag_code = cl_co.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON ((cl_co.code = (fl.flag_code)::bpchar)))
     JOIN ros_ll.fishing_events fe ON ((fe.trip_id = t.id)))
     LEFT JOIN ros_ll.setting_operations se ON ((fe.setting_operation_id = se.id)))
     LEFT JOIN ros_ll.hauling_operations ha ON ((fe.hauling_operation_id = ha.id)))
  WHERE ((od.vessel_type_code = 'LL'::bpchar) AND (se.start_setting_date_and_time IS NOT NULL))
  GROUP BY COALESCE(fl.fleet_code, (cl_co.code)::character varying), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)), (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude));


--
-- Name: v_ll_ef_sets; Type: VIEW; Schema: ros_analysis; Owner: -
--

CREATE VIEW ros_analysis.v_ll_ef_sets AS
 SELECT 'LL'::text AS gear,
    COALESCE(fl.fleet_code, (cl_co.code)::character varying) AS flag,
    date_part('year'::text, se.start_setting_date_and_time) AS year,
    date_part('month'::text, se.start_setting_date_and_time) AS month,
    ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
    ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
    count(DISTINCT fe.event_original_id) AS effort,
    'SETS'::text AS effort_unit
   FROM ((((((((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     JOIN ros_common.trip_vessel gvti ON ((t.id = gvti.trip_id)))
     JOIN ros_meta.vessel vi ON ((gvti.vessel_id = vi.id)))
     JOIN refs_admin.countries cl_co ON ((vi.flag_code = cl_co.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON ((cl_co.code = (fl.flag_code)::bpchar)))
     JOIN ros_ll.fishing_events fe ON ((fe.trip_id = t.id)))
     LEFT JOIN ros_ll.setting_operations se ON ((fe.setting_operation_id = se.id)))
     LEFT JOIN ros_ll.hauling_operations ha ON ((fe.hauling_operation_id = ha.id)))
  WHERE ((od.vessel_type_code = 'LL'::bpchar) AND (se.start_setting_date_and_time IS NOT NULL))
  GROUP BY COALESCE(fl.fleet_code, (cl_co.code)::character varying), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)), (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude));


--
-- Name: v_ll_ef; Type: VIEW; Schema: ros_analysis; Owner: -
--

CREATE VIEW ros_analysis.v_ll_ef AS
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


--
-- Name: v_ps_ef_fd; Type: VIEW; Schema: ros_analysis; Owner: -
--

CREATE VIEW ros_analysis.v_ps_ef_fd AS
 SELECT 'PS'::text AS gear,
    COALESCE(fl.fleet_code, (cl_co.code)::character varying) AS flag,
    date_part('year'::text, se.start_setting_date_and_time) AS year,
    date_part('month'::text, se.start_setting_date_and_time) AS month,
    ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
    ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
    count(DISTINCT date_part('day'::text, se.start_setting_date_and_time)) AS effort,
    'FDAYS'::text AS effort_unit
   FROM (((((((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     JOIN ros_common.trip_vessel gvti ON ((t.id = gvti.trip_id)))
     JOIN ros_meta.vessel vi ON ((gvti.vessel_id = vi.id)))
     JOIN refs_admin.countries cl_co ON ((vi.flag_code = cl_co.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON ((cl_co.code = (fl.flag_code)::bpchar)))
     JOIN ros_ps.fishing_events fe ON ((fe.trip_id = t.id)))
     LEFT JOIN ros_ps.setting_operations se ON ((fe.setting_operation_id = se.id)))
  WHERE (od.vessel_type_code = 'SP'::bpchar)
  GROUP BY COALESCE(fl.fleet_code, (cl_co.code)::character varying), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)), (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude));


--
-- Name: v_ps_ef_raw; Type: VIEW; Schema: ros_analysis; Owner: -
--

CREATE VIEW ros_analysis.v_ps_ef_raw AS
 SELECT 'PS'::text AS gear,
    COALESCE(fl.fleet_code, (cl_co.code)::character varying) AS flag,
    date_part('year'::text, se.start_setting_date_and_time) AS year,
    date_part('month'::text, se.start_setting_date_and_time) AS month,
    ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
    ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
    count(DISTINCT se.id) AS observed_effort,
    'SETS'::text AS effort_unit
   FROM (((((((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     JOIN ros_common.trip_vessel gvti ON ((t.id = gvti.trip_id)))
     JOIN ros_meta.vessel vi ON ((gvti.vessel_id = vi.id)))
     JOIN refs_admin.countries cl_co ON ((vi.flag_code = cl_co.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON ((cl_co.code = (fl.flag_code)::bpchar)))
     JOIN ros_ps.fishing_events fe ON ((fe.trip_id = t.id)))
     LEFT JOIN ros_ps.setting_operations se ON ((fe.setting_operation_id = se.id)))
  WHERE (od.vessel_type_code = 'SP'::bpchar)
  GROUP BY COALESCE(fl.fleet_code, (cl_co.code)::character varying), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)), (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude));


--
-- Name: v_ps_ef; Type: VIEW; Schema: ros_analysis; Owner: -
--

CREATE VIEW ros_analysis.v_ps_ef AS
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


--
-- Name: v_ef; Type: VIEW; Schema: ros_analysis; Owner: -
--

CREATE VIEW ros_analysis.v_ef AS
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


--
-- Name: v_ce; Type: VIEW; Schema: ros_analysis; Owner: -
--

CREATE VIEW ros_analysis.v_ce AS
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
   FROM (ros_analysis.v_ef e
     LEFT JOIN ros_analysis.v_ca c ON (((e.gear = c.gear) AND ((e.flag)::text = (c.flag)::text) AND (e.year = c.year) AND (e.month = c.month) AND (e.grid_1 = c.grid_1) AND (e.grid_5 = c.grid_5))));


--
-- Name: v_ef_fd; Type: VIEW; Schema: ros_analysis; Owner: -
--

CREATE VIEW ros_analysis.v_ef_fd AS
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


--
-- Name: v_ef_raw; Type: VIEW; Schema: ros_analysis; Owner: -
--

CREATE VIEW ros_analysis.v_ef_raw AS
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


--
-- Name: v_efforts_by_year_flag_and_gear; Type: VIEW; Schema: ros_analysis; Owner: -
--

CREATE VIEW ros_analysis.v_efforts_by_year_flag_and_gear AS
 SELECT 'LL'::text AS gear,
    COALESCE(fl.fleet_code, (cl_co.code)::character varying) AS flag,
    date_part('year'::text, se.start_setting_date_and_time) AS year,
    sum(se.total_number_of_hooks_set) AS observed_effort,
    'HOOK'::text AS effort_unit
   FROM ((((((((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     JOIN ros_common.trip_vessel gvti ON ((t.id = gvti.trip_id)))
     JOIN ros_meta.vessel vi ON ((gvti.vessel_id = vi.id)))
     JOIN refs_admin.countries cl_co ON ((vi.flag_code = cl_co.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON ((cl_co.code = (fl.flag_code)::bpchar)))
     JOIN ros_ll.fishing_events fe ON ((fe.trip_id = t.id)))
     LEFT JOIN ros_ll.setting_operations se ON ((fe.setting_operation_id = se.id)))
     LEFT JOIN ros_ll.hauling_operations ha ON ((fe.hauling_operation_id = ha.id)))
  WHERE (od.vessel_type_code = 'LL'::bpchar)
  GROUP BY COALESCE(fl.fleet_code, (cl_co.code)::character varying), (date_part('year'::text, se.start_setting_date_and_time))
UNION ALL
 SELECT 'PS'::text AS gear,
    COALESCE(fl.fleet_code, (cl_co.code)::character varying) AS flag,
    date_part('year'::text, se.start_setting_date_and_time) AS year,
    count(DISTINCT se.id) AS observed_effort,
    'SET'::text AS effort_unit
   FROM (((((((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     JOIN ros_common.trip_vessel gvti ON ((t.id = gvti.trip_id)))
     JOIN ros_meta.vessel vi ON ((gvti.vessel_id = vi.id)))
     JOIN refs_admin.countries cl_co ON ((vi.flag_code = cl_co.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON ((cl_co.code = (fl.flag_code)::bpchar)))
     JOIN ros_ps.fishing_events fe ON ((fe.trip_id = t.id)))
     LEFT JOIN ros_ps.setting_operations se ON ((fe.setting_operation_id = se.id)))
  WHERE (od.vessel_type_code = 'SP'::bpchar)
  GROUP BY COALESCE(fl.fleet_code, (cl_co.code)::character varying), (date_part('year'::text, se.start_setting_date_and_time));


--
-- Name: additional_details_on_non_target_species; Type: TABLE; Schema: ros_common; Owner: -
--

CREATE TABLE ros_common.additional_details_on_non_target_species (
    id integer NOT NULL,
    condition_at_capture_code character varying(3),
    condition_at_release_code character varying(3)
);


--
-- Name: v_ll_in; Type: VIEW; Schema: ros_analysis; Owner: -
--

CREATE VIEW ros_analysis.v_ll_in AS
 SELECT 'LL'::text AS gear,
    COALESCE(fl.fleet_code, (cl_co.code)::character varying) AS flag,
    date_part('year'::text, se.start_setting_date_and_time) AS year,
    date_part('month'::text, se.start_setting_date_and_time) AS month,
    ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
    ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
    cl_sp.code AS species,
    cl_sp.species_group_code,
        CASE
            WHEN (count(DISTINCT sp.id) = 0) THEN sum(ca.estimated_catch_in_numbers)
            ELSE count(DISTINCT sp.id)
        END AS num_interactions,
        CASE
            WHEN (cl_fa.code ~~ 'R%'::text) THEN 'RETAINED'::text
            WHEN (cl_fa.code ~~ 'D%'::text) THEN 'DISCARDED'::text
            WHEN (cl_fa.code ~~ 'U%'::text) THEN 'UNKNOWN'::text
            ELSE 'NA'::text
        END AS fate,
    cl_fa.code AS fate_code,
        CASE
            WHEN ((cl_cn.code)::text ~~ 'A%'::text) THEN 'ALIVE'::text
            WHEN ((cl_cn.code)::text ~~ 'D%'::text) THEN 'DEAD'::text
            WHEN ((cl_cn.code)::text ~~ 'U%'::text) THEN 'UNKNOWN'::text
            ELSE 'NA'::text
        END AS condition,
    cl_cn.code AS condition_code
   FROM (((((((((((((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     JOIN ros_common.trip_vessel gvti ON ((t.id = gvti.trip_id)))
     JOIN ros_meta.vessel vi ON ((gvti.vessel_id = vi.id)))
     JOIN refs_admin.countries cl_co ON ((vi.flag_code = cl_co.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON ((cl_co.code = (fl.flag_code)::bpchar)))
     JOIN ros_ll.fishing_events fe ON ((fe.trip_id = t.id)))
     LEFT JOIN ros_ll.setting_operations se ON ((fe.setting_operation_id = se.id)))
     JOIN ros_ll.catch_details ca ON ((ca.fishing_event_id = fe.id)))
     JOIN refs_biology.species cl_sp ON (((ca.species_code)::text = (cl_sp.code)::text)))
     LEFT JOIN refs_biology.fates cl_fa ON ((ca.fates_code = cl_fa.code)))
     LEFT JOIN ros_ll.specimens sp ON ((sp.catch_detail_id = ca.id)))
     LEFT JOIN ros_common.additional_details_on_non_target_species adnt ON ((sp.additional_specimen_details_non_target_species_id = adnt.id)))
     LEFT JOIN refs_biology.incidental_captures_conditions cl_cn ON (((COALESCE(adnt.condition_at_capture_code, adnt.condition_at_release_code))::text = (cl_cn.code)::text)))
  WHERE (od.vessel_type_code = 'LL'::bpchar)
  GROUP BY COALESCE(fl.fleet_code, (cl_co.code)::character varying), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)), (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude)), cl_sp.code, cl_sp.species_group_code,
        CASE
            WHEN (cl_fa.code ~~ 'R%'::text) THEN 'RETAINED'::text
            WHEN (cl_fa.code ~~ 'D%'::text) THEN 'DISCARDED'::text
            WHEN (cl_fa.code ~~ 'U%'::text) THEN 'UNKNOWN'::text
            ELSE 'NA'::text
        END, cl_fa.code,
        CASE
            WHEN ((cl_cn.code)::text ~~ 'A%'::text) THEN 'ALIVE'::text
            WHEN ((cl_cn.code)::text ~~ 'D%'::text) THEN 'DEAD'::text
            WHEN ((cl_cn.code)::text ~~ 'U%'::text) THEN 'UNKNOWN'::text
            ELSE 'NA'::text
        END, cl_cn.code;


--
-- Name: specimens; Type: TABLE; Schema: ros_ps; Owner: -
--

CREATE TABLE ros_ps.specimens (
    id integer NOT NULL,
    specimen_original_id character varying(255) NOT NULL,
    additional_catch_details_on_ssis_id integer,
    additional_specimen_details_non_target_species_id integer,
    biometric_information_id integer,
    tag_detail_id integer,
    catch_detail_id integer
);


--
-- Name: v_ps_in; Type: VIEW; Schema: ros_analysis; Owner: -
--

CREATE VIEW ros_analysis.v_ps_in AS
 SELECT 'PS'::text AS gear,
    COALESCE(fl.fleet_code, (cl_co.code)::character varying) AS flag,
    date_part('year'::text, se.start_setting_date_and_time) AS year,
    date_part('month'::text, se.start_setting_date_and_time) AS month,
    ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
    ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
    cl_sp.code AS species,
    cl_sp.species_group_code,
        CASE
            WHEN (count(DISTINCT sp.id) = 0) THEN sum(ca.estimated_catch_in_numbers)
            ELSE count(DISTINCT sp.id)
        END AS num_interactions,
        CASE
            WHEN (cl_fa.code ~~ 'R%'::text) THEN 'RETAINED'::text
            WHEN (cl_fa.code ~~ 'D%'::text) THEN 'DISCARDED'::text
            WHEN (cl_fa.code ~~ 'U%'::text) THEN 'UNKNOWN'::text
            ELSE 'NA'::text
        END AS fate,
    cl_fa.code AS fate_code,
        CASE
            WHEN ((cl_cn.code)::text ~~ 'A%'::text) THEN 'ALIVE'::text
            WHEN ((cl_cn.code)::text ~~ 'D%'::text) THEN 'DEAD'::text
            WHEN ((cl_cn.code)::text ~~ 'U%'::text) THEN 'UNKNOWN'::text
            ELSE 'NA'::text
        END AS condition,
    cl_cn.code AS condition_code
   FROM (((((((((((((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     JOIN ros_common.trip_vessel gvti ON ((t.id = gvti.trip_id)))
     JOIN ros_meta.vessel vi ON ((gvti.vessel_id = vi.id)))
     JOIN refs_admin.countries cl_co ON ((vi.flag_code = cl_co.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON ((cl_co.code = (fl.flag_code)::bpchar)))
     JOIN ros_ps.fishing_events fe ON ((fe.trip_id = t.id)))
     LEFT JOIN ros_ps.setting_operations se ON ((fe.setting_operation_id = se.id)))
     JOIN ros_ps.catch_details ca ON ((ca.fishing_event_id = fe.id)))
     JOIN refs_biology.species cl_sp ON (((ca.species_code)::text = (cl_sp.code)::text)))
     LEFT JOIN refs_biology.fates cl_fa ON ((ca.fates_code = cl_fa.code)))
     JOIN ros_ps.specimens sp ON ((sp.catch_detail_id = ca.id)))
     LEFT JOIN ros_common.additional_details_on_non_target_species adnt ON ((sp.additional_specimen_details_non_target_species_id = adnt.id)))
     LEFT JOIN refs_biology.incidental_captures_conditions cl_cn ON (((COALESCE(adnt.condition_at_capture_code, adnt.condition_at_release_code))::text = (cl_cn.code)::text)))
  WHERE (od.vessel_type_code = 'SP'::bpchar)
  GROUP BY COALESCE(fl.fleet_code, (cl_co.code)::character varying), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)), (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude)), cl_sp.code, cl_sp.species_group_code,
        CASE
            WHEN (cl_fa.code ~~ 'R%'::text) THEN 'RETAINED'::text
            WHEN (cl_fa.code ~~ 'D%'::text) THEN 'DISCARDED'::text
            WHEN (cl_fa.code ~~ 'U%'::text) THEN 'UNKNOWN'::text
            ELSE 'NA'::text
        END, cl_fa.code,
        CASE
            WHEN ((cl_cn.code)::text ~~ 'A%'::text) THEN 'ALIVE'::text
            WHEN ((cl_cn.code)::text ~~ 'D%'::text) THEN 'DEAD'::text
            WHEN ((cl_cn.code)::text ~~ 'U%'::text) THEN 'UNKNOWN'::text
            ELSE 'NA'::text
        END, cl_cn.code;


--
-- Name: v_in; Type: VIEW; Schema: ros_analysis; Owner: -
--

CREATE VIEW ros_analysis.v_in AS
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


--
-- Name: v_ll_ce; Type: VIEW; Schema: ros_analysis; Owner: -
--

CREATE VIEW ros_analysis.v_ll_ce AS
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
   FROM (ros_analysis.v_ll_ef e
     LEFT JOIN ros_analysis.v_ll_ca c ON (((e.gear = c.gear) AND ((e.flag)::text = (c.flag)::text) AND (e.year = c.year) AND (e.month = c.month) AND (e.grid_1 = c.grid_1) AND (e.grid_5 = c.grid_5))));


--
-- Name: v_ll_sets_raw; Type: VIEW; Schema: ros_analysis; Owner: -
--

CREATE VIEW ros_analysis.v_ll_sets_raw AS
 SELECT COALESCE(f2f.flag_code, (c.code)::character varying) AS flag_code,
    COALESCE(f2f.fleet_code, (c.code)::character varying) AS fleet_code,
    'LL'::text AS gear_code,
    'LLO'::text AS fishery_code,
    'LL'::text AS fishery_group_code,
    'IND'::text AS fishery_type_code,
    t.id AS trip_id,
    t.uid AS trip_uid,
    fed.setting_operation_id AS set_id,
    fed.event_original_id AS set_uid,
    'SETTING'::text AS event_type_code,
    so.start_setting_date_and_time AS start_time,
    so.start_setting_longitude AS start_lon,
    so.start_setting_latitude AS start_lat,
    so.end_setting_date_and_time AS end_time,
    so.end_setting_longitude AS end_lon,
    so.end_setting_latitude AS end_lat,
    so.total_number_of_hooks_set AS effort,
    'HK'::text AS effort_unit_code
   FROM (((((((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     JOIN ros_common.trip_vessel gvti ON ((t.id = gvti.trip_id)))
     JOIN ros_meta.vessel vi ON ((gvti.vessel_id = vi.id)))
     LEFT JOIN refs_admin.countries c ON ((vi.flag_code = c.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries f2f ON ((c.code = (f2f.flag_code)::bpchar)))
     JOIN ros_ll.fishing_events fed ON ((fed.trip_id = t.id)))
     JOIN ros_ll.setting_operations so ON ((fed.setting_operation_id = so.id)))
  WHERE (od.vessel_type_code = 'LL'::bpchar)
UNION ALL
 SELECT COALESCE(f2f.flag_code, (c.code)::character varying) AS flag_code,
    COALESCE(f2f.fleet_code, (c.code)::character varying) AS fleet_code,
    'LL'::text AS gear_code,
    'LLO'::text AS fishery_code,
    'LL'::text AS fishery_group_code,
    'IND'::text AS fishery_type_code,
    t.id AS trip_id,
    t.uid AS trip_uid,
    fed.setting_operation_id AS set_id,
    fed.event_original_id AS set_uid,
    'HAULING'::text AS event_type_code,
    ho.start_hauling_date_and_time AS start_time,
    ho.start_hauling_longitude AS start_lon,
    ho.start_hauling_latitude AS start_lat,
    ho.end_hauling_date_and_time AS end_time,
    ho.end_hauling_longitude AS end_lon,
    ho.end_hauling_latitude AS end_lat,
    ho.number_of_hooks_observed AS effort,
    'HK'::text AS effort_unit_code
   FROM (((((((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     JOIN ros_common.trip_vessel gvti ON ((t.id = gvti.trip_id)))
     JOIN ros_meta.vessel vi ON ((gvti.vessel_id = vi.id)))
     LEFT JOIN refs_admin.countries c ON ((vi.flag_code = c.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries f2f ON ((c.code = (f2f.flag_code)::bpchar)))
     JOIN ros_ll.fishing_events fed ON ((fed.trip_id = t.id)))
     JOIN ros_ll.hauling_operations ho ON ((fed.hauling_operation_id = ho.id)))
  WHERE (od.vessel_type_code = 'LL'::bpchar);


--
-- Name: biometric_information; Type: TABLE; Schema: ros_common; Owner: -
--

CREATE TABLE ros_common.biometric_information (
    id integer NOT NULL,
    bio_collection_sampling_method_code character(2),
    sex_code character(1),
    estimated_weight_value double precision,
    estimated_weight_unit character varying(3),
    estimated_weight_type_of_measurement_code character(2),
    estimated_weight_processing_type_code character(2),
    estimated_weight_method_code character(2),
    maturity_stage_level integer,
    maturity_stage_scale character varying(255),
    alternative_measured_length_value double precision,
    alternative_measured_length_unit character varying(3),
    alternative_measured_length_type_of_measurement_code character(2),
    alternative_measured_length_measured_length_type_code character(2),
    alternative_measured_length_length_measuring_tool_code character(2),
    measured_length_value double precision,
    measured_length_unit character varying(3),
    measured_length_type_of_measurement_code character(2),
    measured_length_measured_length_type_code character(2),
    measured_length_length_measuring_tool_code character(2),
    sample_collection_detail_destination character varying(255),
    sample_collection_detail_preservation_method text,
    sample_collection_detail_sample_type character varying(255),
    alternative_measured_length_straight character varying(5),
    measured_length_straight character varying(5),
    CONSTRAINT ros_c_biometric_info_alternative_measured_length_unit_check CHECK (((alternative_measured_length_unit)::text = 'cm'::text)),
    CONSTRAINT ros_common_biometric_information_estimated_weight_unit_check CHECK (((estimated_weight_unit)::text = ANY ((ARRAY['kg'::character varying, 't'::character varying])::text[]))),
    CONSTRAINT ros_common_biometric_information_measured_length_unit_check CHECK (((measured_length_unit)::text = 'cm'::text))
);


--
-- Name: v_ll_sf_l; Type: VIEW; Schema: ros_analysis; Owner: -
--

CREATE VIEW ros_analysis.v_ll_sf_l AS
 SELECT 'LL'::text AS gear,
    COALESCE(fl.fleet_code, (cl_co.code)::character varying) AS flag,
    date_part('year'::text, se.start_setting_date_and_time) AS year,
    date_part('month'::text, se.start_setting_date_and_time) AS month,
    ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
    ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
    cl_sp.code AS species,
    cl_sp.species_group_code,
    cl_fa.code AS fate,
    cl_sx.code AS sex,
    COALESCE(cl_le.code, cl_alt_le.code) AS length_code,
    COALESCE(bi.measured_length_unit, bi.alternative_measured_length_unit) AS length_unit,
    floor(COALESCE(bi.measured_length_value, bi.alternative_measured_length_value)) AS size_bin,
    count(DISTINCT sp.id) AS num_fish
   FROM (((((((((((((((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     JOIN ros_common.trip_vessel gvti ON ((t.id = gvti.trip_id)))
     JOIN ros_meta.vessel vi ON ((gvti.vessel_id = vi.id)))
     JOIN refs_admin.countries cl_co ON ((vi.flag_code = cl_co.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON ((cl_co.code = (fl.flag_code)::bpchar)))
     JOIN ros_ll.fishing_events fe ON ((fe.trip_id = t.id)))
     LEFT JOIN ros_ll.setting_operations se ON ((fe.setting_operation_id = se.id)))
     JOIN ros_ll.catch_details ca ON ((ca.fishing_event_id = fe.id)))
     JOIN refs_biology.species cl_sp ON (((ca.species_code)::text = (cl_sp.code)::text)))
     LEFT JOIN refs_biology.fates cl_fa ON ((ca.fates_code = cl_fa.code)))
     JOIN ros_ll.specimens sp ON ((sp.catch_detail_id = ca.id)))
     JOIN ros_common.biometric_information bi ON ((sp.biometric_information_id = bi.id)))
     LEFT JOIN refs_biology.sex cl_sx ON ((bi.sex_code = cl_sx.code)))
     LEFT JOIN refs_biology.measurements cl_le ON ((bi.measured_length_measured_length_type_code = cl_le.code)))
     LEFT JOIN refs_biology.measurements cl_alt_le ON ((bi.alternative_measured_length_measured_length_type_code = cl_alt_le.code)))
  WHERE (od.vessel_type_code = 'LL'::bpchar)
  GROUP BY COALESCE(fl.fleet_code, (cl_co.code)::character varying), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)), (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude)), cl_sp.code, cl_sp.species_group_code, cl_fa.code, cl_sx.code, COALESCE(cl_le.code, cl_alt_le.code), COALESCE(bi.measured_length_unit, bi.alternative_measured_length_unit), (floor(COALESCE(bi.measured_length_value, bi.alternative_measured_length_value)));


--
-- Name: v_ll_sf_w; Type: VIEW; Schema: ros_analysis; Owner: -
--

CREATE VIEW ros_analysis.v_ll_sf_w AS
 SELECT 'LL'::text AS gear,
    COALESCE(fl.fleet_code, (cl_co.code)::character varying) AS flag,
    date_part('year'::text, se.start_setting_date_and_time) AS year,
    date_part('month'::text, se.start_setting_date_and_time) AS month,
    ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
    ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
    cl_sp.code AS species,
    cl_sp.species_group_code,
    cl_fa.code AS fate,
    cl_sx.code AS sex,
    cl_pt.code AS weight_code,
    bi.estimated_weight_unit AS weight_unit,
    floor(bi.estimated_weight_value) AS size_bin,
    count(DISTINCT sp.id) AS num_fish
   FROM ((((((((((((((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     JOIN ros_common.trip_vessel gvti ON ((t.id = gvti.trip_id)))
     JOIN ros_meta.vessel vi ON ((gvti.vessel_id = vi.id)))
     JOIN refs_admin.countries cl_co ON ((vi.flag_code = cl_co.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON ((cl_co.code = (fl.flag_code)::bpchar)))
     JOIN ros_ll.fishing_events fe ON ((fe.trip_id = t.id)))
     LEFT JOIN ros_ll.setting_operations se ON ((fe.setting_operation_id = se.id)))
     JOIN ros_ll.catch_details ca ON ((ca.fishing_event_id = fe.id)))
     JOIN refs_biology.species cl_sp ON (((ca.species_code)::text = (cl_sp.code)::text)))
     LEFT JOIN refs_biology.fates cl_fa ON ((ca.fates_code = cl_fa.code)))
     JOIN ros_ll.specimens sp ON ((sp.catch_detail_id = ca.id)))
     JOIN ros_common.biometric_information bi ON ((sp.biometric_information_id = bi.id)))
     LEFT JOIN refs_biology.sex cl_sx ON ((bi.sex_code = cl_sx.code)))
     LEFT JOIN refs_fishery.fish_processing_types cl_pt ON ((bi.estimated_weight_processing_type_code = cl_pt.code)))
  WHERE (od.vessel_type_code = 'LL'::bpchar)
  GROUP BY COALESCE(fl.fleet_code, (cl_co.code)::character varying), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)), (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude)), cl_sp.code, cl_sp.species_group_code, cl_fa.code, cl_sx.code, cl_pt.code, (floor(bi.estimated_weight_value)), bi.estimated_weight_unit;


--
-- Name: v_ps_ce; Type: VIEW; Schema: ros_analysis; Owner: -
--

CREATE VIEW ros_analysis.v_ps_ce AS
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
   FROM (ros_analysis.v_ps_ef e
     LEFT JOIN ros_analysis.v_ps_ca c ON (((e.gear = c.gear) AND ((e.flag)::text = (c.flag)::text) AND (e.year = c.year) AND (e.month = c.month) AND (e.grid_1 = c.grid_1) AND (e.grid_5 = c.grid_5))));


--
-- Name: v_ps_lw; Type: VIEW; Schema: ros_analysis; Owner: -
--

CREATE VIEW ros_analysis.v_ps_lw AS
 SELECT 'PS'::text AS gear,
    COALESCE(fl.fleet_code, (cl_co.code)::character varying) AS flag,
    date_part('year'::text, se.start_setting_date_and_time) AS year,
    date_part('month'::text, se.start_setting_date_and_time) AS month,
    ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
    ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
    cl_sp.code AS species,
    cl_sp.species_group_code,
    cl_fa.code AS fate,
    cl_sx.code AS sex,
    cl_le.code AS length_code,
    bi.measured_length_value AS length,
    bi.measured_length_unit AS length_unit,
    cl_pt.code AS weight_type,
    bi.estimated_weight_value AS weight,
    bi.estimated_weight_unit AS weight_unit
   FROM (((((((((((((((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     JOIN ros_common.trip_vessel gvti ON ((t.id = gvti.trip_id)))
     JOIN ros_meta.vessel vi ON ((gvti.vessel_id = vi.id)))
     JOIN refs_admin.countries cl_co ON ((vi.flag_code = cl_co.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON ((cl_co.code = (fl.flag_code)::bpchar)))
     JOIN ros_ps.fishing_events fe ON ((fe.trip_id = t.id)))
     LEFT JOIN ros_ps.setting_operations se ON ((fe.setting_operation_id = se.id)))
     JOIN ros_ps.catch_details ca ON ((ca.fishing_event_id = fe.id)))
     JOIN refs_biology.species cl_sp ON (((ca.species_code)::text = (cl_sp.code)::text)))
     LEFT JOIN refs_biology.fates cl_fa ON ((ca.fates_code = cl_fa.code)))
     JOIN ros_ps.specimens sp ON ((sp.catch_detail_id = ca.id)))
     JOIN ros_common.biometric_information bi ON ((sp.biometric_information_id = bi.id)))
     LEFT JOIN refs_biology.sex cl_sx ON ((bi.sex_code = cl_sx.code)))
     LEFT JOIN refs_biology.measurements cl_le ON ((bi.measured_length_measured_length_type_code = cl_le.code)))
     LEFT JOIN refs_fishery.fish_processing_types cl_pt ON ((bi.estimated_weight_processing_type_code = cl_pt.code)))
  WHERE (od.vessel_type_code = 'SP'::bpchar);


--
-- Name: v_ps_sets_raw; Type: VIEW; Schema: ros_analysis; Owner: -
--

CREATE VIEW ros_analysis.v_ps_sets_raw AS
 SELECT COALESCE(f2f.flag_code, (c.code)::character varying) AS flag_code,
    COALESCE(f2f.fleet_code, (c.code)::character varying) AS fleet_code,
    'PS'::text AS gear_code,
    'PSOT'::text AS fishery_code,
    'PS'::text AS fishery_group_code,
    'IND'::text AS fishery_type_code,
    t.id AS trip_id,
    t.uid AS trip_uid,
    fed.setting_operation_id AS set_id,
    fed.event_original_id AS set_uid,
    'SETTING'::text AS event_type_code,
    so.start_setting_date_and_time AS start_time,
    so.start_setting_longitude AS start_lon,
    so.start_setting_latitude AS start_lat,
    COALESCE(so.time_end_brailing, so.time_skiff_onboard, so.time_net_pursed, so.start_setting_date_and_time) AS end_time,
    so.start_setting_longitude AS end_lon,
    so.start_setting_latitude AS end_lat,
    1 AS effort,
    'SET'::text AS effort_unit_code
   FROM (((((((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     JOIN ros_common.trip_vessel gvti ON ((t.id = gvti.trip_id)))
     JOIN ros_meta.vessel vi ON ((gvti.vessel_id = vi.id)))
     LEFT JOIN refs_admin.countries c ON ((vi.flag_code = c.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries f2f ON ((c.code = (f2f.flag_code)::bpchar)))
     JOIN ros_ps.fishing_events fed ON ((fed.trip_id = t.id)))
     JOIN ros_ps.setting_operations so ON ((fed.setting_operation_id = so.id)))
  WHERE (od.vessel_type_code = 'SP'::bpchar);


--
-- Name: v_ps_sf_l; Type: VIEW; Schema: ros_analysis; Owner: -
--

CREATE VIEW ros_analysis.v_ps_sf_l AS
 SELECT 'PS'::text AS gear,
    COALESCE(fl.fleet_code, (cl_co.code)::character varying) AS flag,
    date_part('year'::text, se.start_setting_date_and_time) AS year,
    date_part('month'::text, se.start_setting_date_and_time) AS month,
    ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
    ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
    cl_sp.code AS species,
    cl_sp.species_group_code,
    cl_fa.code AS fate,
    cl_sx.code AS sex,
    COALESCE(cl_le.code, cl_alt_le.code) AS length_code,
    COALESCE(bi.measured_length_unit, bi.alternative_measured_length_unit) AS length_unit,
    floor(COALESCE(bi.measured_length_value, bi.alternative_measured_length_value)) AS size_bin,
    count(DISTINCT sp.id) AS num_fish
   FROM (((((((((((((((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     JOIN ros_common.trip_vessel gvti ON ((t.id = gvti.trip_id)))
     JOIN ros_meta.vessel vi ON ((gvti.vessel_id = vi.id)))
     JOIN refs_admin.countries cl_co ON ((vi.flag_code = cl_co.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON ((cl_co.code = (fl.flag_code)::bpchar)))
     JOIN ros_ps.fishing_events fe ON ((fe.trip_id = t.id)))
     LEFT JOIN ros_ps.setting_operations se ON ((fe.setting_operation_id = se.id)))
     JOIN ros_ps.catch_details ca ON ((ca.fishing_event_id = fe.id)))
     JOIN refs_biology.species cl_sp ON (((ca.species_code)::text = (cl_sp.code)::text)))
     LEFT JOIN refs_biology.fates cl_fa ON ((ca.fates_code = cl_fa.code)))
     JOIN ros_ps.specimens sp ON ((sp.catch_detail_id = ca.id)))
     JOIN ros_common.biometric_information bi ON ((sp.biometric_information_id = bi.id)))
     LEFT JOIN refs_biology.sex cl_sx ON ((bi.sex_code = cl_sx.code)))
     LEFT JOIN refs_biology.measurements cl_le ON ((bi.measured_length_measured_length_type_code = cl_le.code)))
     LEFT JOIN refs_biology.measurements cl_alt_le ON ((bi.alternative_measured_length_measured_length_type_code = cl_alt_le.code)))
  WHERE (od.vessel_type_code = 'SP'::bpchar)
  GROUP BY COALESCE(fl.fleet_code, (cl_co.code)::character varying), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)), (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude)), cl_sp.code, cl_sp.species_group_code, cl_fa.code, cl_sx.code, COALESCE(cl_le.code, cl_alt_le.code), COALESCE(bi.measured_length_unit, bi.alternative_measured_length_unit), (floor(COALESCE(bi.measured_length_value, bi.alternative_measured_length_value)));


--
-- Name: v_ps_sf_w; Type: VIEW; Schema: ros_analysis; Owner: -
--

CREATE VIEW ros_analysis.v_ps_sf_w AS
 SELECT 'PS'::text AS gear,
    COALESCE(fl.fleet_code, (cl_co.code)::character varying) AS flag,
    date_part('year'::text, se.start_setting_date_and_time) AS year,
    date_part('month'::text, se.start_setting_date_and_time) AS month,
    ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
    ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
    cl_sp.code AS species,
    cl_sp.species_group_code,
    cl_fa.code AS fate,
    cl_sx.code AS sex,
    cl_pt.code AS weight_code,
    bi.estimated_weight_unit AS length_unit,
    floor(bi.estimated_weight_value) AS size_bin,
    count(DISTINCT sp.id) AS num_fish
   FROM ((((((((((((((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     JOIN ros_common.trip_vessel gvti ON ((t.id = gvti.trip_id)))
     JOIN ros_meta.vessel vi ON ((gvti.vessel_id = vi.id)))
     JOIN refs_admin.countries cl_co ON ((vi.flag_code = cl_co.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON ((cl_co.code = (fl.flag_code)::bpchar)))
     JOIN ros_ps.fishing_events fe ON ((fe.trip_id = t.id)))
     LEFT JOIN ros_ps.setting_operations se ON ((fe.setting_operation_id = se.id)))
     JOIN ros_ps.catch_details ca ON ((ca.fishing_event_id = fe.id)))
     JOIN refs_biology.species cl_sp ON (((ca.species_code)::text = (cl_sp.code)::text)))
     LEFT JOIN refs_biology.fates cl_fa ON ((ca.fates_code = cl_fa.code)))
     JOIN ros_ps.specimens sp ON ((sp.catch_detail_id = ca.id)))
     JOIN ros_common.biometric_information bi ON ((sp.biometric_information_id = bi.id)))
     LEFT JOIN refs_biology.sex cl_sx ON ((bi.sex_code = cl_sx.code)))
     LEFT JOIN refs_fishery.fish_processing_types cl_pt ON ((bi.estimated_weight_processing_type_code = cl_pt.code)))
  WHERE (od.vessel_type_code = 'SP'::bpchar)
  GROUP BY COALESCE(fl.fleet_code, (cl_co.code)::character varying), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)), (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude)), cl_sp.code, cl_sp.species_group_code, cl_fa.code, cl_sx.code, cl_pt.code, (floor(bi.estimated_weight_value)), bi.estimated_weight_unit;


--
-- Name: trip_observer; Type: TABLE; Schema: ros_common; Owner: -
--

CREATE TABLE ros_common.trip_observer (
    trip_id integer NOT NULL,
    date_time_disembarkation timestamp(6) without time zone,
    date_time_embarkation timestamp(6) without time zone,
    observer_id integer NOT NULL,
    disembarkation_location_name character varying(255),
    disembarkation_latitude double precision,
    disembarkation_longitude double precision,
    disembarkation_country_code character(3),
    disembarkation_port_code character varying(16),
    embarkation_location_name character varying(255),
    embarkation_latitude double precision,
    embarkation_longitude double precision,
    embarkation_country_code character(3),
    embarkation_port_code character varying(16)
);


--
-- Name: observer; Type: TABLE; Schema: ros_meta; Owner: -
--

CREATE TABLE ros_meta.observer (
    contact_id integer NOT NULL,
    iotc_observer_identifier character varying(255) NOT NULL,
    national_observer_id character varying(255)
);


--
-- Name: v_gn_trips; Type: VIEW; Schema: ros_meta; Owner: -
--

CREATE VIEW ros_meta.v_gn_trips AS
 SELECT od.source,
    t.id AS trip_id,
    t.uid AS trip_uid,
    t.trip_original_id AS trip_number,
    od.creation_time AS creation_date,
    od.finalization_time AS finalization_date,
    od.submission_time AS submission_date,
        CASE
            WHEN (otd.trip_id IS NULL) THEN 0
            ELSE 1
        END AS has_observer_trip_info,
    'GN'::text AS fishing_operation_type,
    oi.iotc_observer_identifier AS observer_iotc_number,
    otd.date_time_embarkation AS observer_imbarcation_date,
    otd.date_time_disembarkation AS observer_disembarcation_date,
    vi.id AS vessel_info_id,
    vi.iotc_vessel_identifier AS vessel_iotc_number,
    g.code AS main_gear,
    r.code AS reporting_flag,
    f.code AS vessel_flag,
    gvt.departure_timestamp AS vessel_departure_date,
    pd.name_en AS vessel_departure_port,
    cd.code AS vessel_departure_country,
    gvt.return_timestamp AS vessel_return_date,
    pr.name_en AS vessel_return_port,
    cr.code AS vessel_return_country
   FROM ((((((((((((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     LEFT JOIN ros_common.trip_vessel gvt ON ((t.id = gvt.trip_id)))
     LEFT JOIN ros_common.trip_observer otd ON ((t.id = otd.trip_id)))
     LEFT JOIN ros_meta.observer oi ON ((otd.observer_id = oi.contact_id)))
     LEFT JOIN ros_meta.vessel vi ON ((gvt.vessel_id = vi.id)))
     LEFT JOIN refs_fishery_config.gears g ON (((vi.main_fishing_gear_code)::text = (g.code)::text)))
     LEFT JOIN refs_admin.countries f ON ((vi.flag_code = f.code)))
     LEFT JOIN refs_admin.countries r ON ((od.reporting_country_code = r.code)))
     LEFT JOIN refs_admin.ports pd ON (((gvt.departure_port_code)::text = (pd.code)::text)))
     LEFT JOIN refs_admin.countries cd ON (((gvt.departure_country_code)::bpchar = cd.code)))
     LEFT JOIN refs_admin.ports pr ON (((gvt.return_port_code)::text = (pr.code)::text)))
     LEFT JOIN refs_admin.countries cr ON (((gvt.return_country_code)::bpchar = cr.code)))
  WHERE (od.vessel_type_code = 'GO'::bpchar);


--
-- Name: v_ll_sets; Type: VIEW; Schema: ros_meta; Owner: -
--

CREATE VIEW ros_meta.v_ll_sets AS
 SELECT t.id AS trip_id,
    t.uid AS trip_uid,
    so.id AS set_id,
    'LL'::text AS fishing_operation_type,
    COALESCE(ho.start_hauling_date_and_time, so.start_setting_date_and_time) AS start_time,
    COALESCE(ho.end_hauling_date_and_time, so.end_setting_date_and_time) AS end_time,
        CASE
            WHEN ((ho.start_hauling_latitude IS NOT NULL) AND (ho.start_hauling_longitude IS NOT NULL)) THEN ros_meta.to_grid_1(ho.start_hauling_latitude, ho.start_hauling_longitude)
            WHEN ((ho.end_hauling_latitude IS NOT NULL) AND (ho.end_hauling_longitude IS NOT NULL)) THEN ros_meta.to_grid_1(ho.end_hauling_latitude, ho.end_hauling_longitude)
            WHEN ((so.start_setting_latitude IS NOT NULL) AND (so.start_setting_longitude IS NOT NULL)) THEN ros_meta.to_grid_1(so.start_setting_latitude, so.start_setting_longitude)
            WHEN ((so.end_setting_latitude IS NOT NULL) AND (so.end_setting_longitude IS NOT NULL)) THEN ros_meta.to_grid_1(so.end_setting_latitude, so.end_setting_longitude)
            ELSE NULL::bpchar
        END AS grid_1,
        CASE
            WHEN ((ho.start_hauling_latitude IS NOT NULL) AND (ho.start_hauling_longitude IS NOT NULL)) THEN ros_meta.to_grid_5(ho.start_hauling_latitude, ho.start_hauling_longitude)
            WHEN ((ho.end_hauling_latitude IS NOT NULL) AND (ho.end_hauling_longitude IS NOT NULL)) THEN ros_meta.to_grid_5(ho.end_hauling_latitude, ho.end_hauling_longitude)
            WHEN ((so.start_setting_latitude IS NOT NULL) AND (so.start_setting_longitude IS NOT NULL)) THEN ros_meta.to_grid_5(so.start_setting_latitude, so.start_setting_longitude)
            WHEN ((so.end_setting_latitude IS NOT NULL) AND (so.end_setting_longitude IS NOT NULL)) THEN ros_meta.to_grid_5(so.end_setting_latitude, so.end_setting_longitude)
            ELSE NULL::bpchar
        END AS grid_5,
    1 AS effort,
    1 AS total_effort,
    'SETS'::text AS effort_unit
   FROM ((((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     JOIN ros_ll.fishing_events fed ON ((fed.trip_id = t.id)))
     JOIN ros_ll.setting_operations so ON ((fed.setting_operation_id = so.id)))
     LEFT JOIN ros_ll.hauling_operations ho ON ((fed.hauling_operation_id = ho.id)))
  WHERE (od.vessel_type_code = 'LL'::bpchar);


--
-- Name: v_ll_trips; Type: VIEW; Schema: ros_meta; Owner: -
--

CREATE VIEW ros_meta.v_ll_trips AS
 SELECT od.source,
    t.id AS trip_id,
    t.uid AS trip_uid,
    t.trip_original_id AS trip_number,
    od.creation_time AS creation_date,
    od.finalization_time AS finalization_date,
    od.submission_time AS submission_date,
        CASE
            WHEN (otd.trip_id IS NULL) THEN 0
            ELSE 1
        END AS has_observer_trip_info,
    'LL'::text AS fishing_operation_type,
    oi.iotc_observer_identifier AS observer_iotc_number,
    otd.date_time_embarkation AS observer_imbarcation_date,
    otd.date_time_disembarkation AS observer_disembarcation_date,
    vi.id AS vessel_info_id,
    vi.iotc_vessel_identifier AS vessel_iotc_number,
    g.code AS main_gear,
    r.code AS reporting_flag,
    f.code AS vessel_flag,
    gvt.departure_timestamp AS vessel_departure_date,
    pd.name_en AS vessel_departure_port,
    cd.code AS vessel_departure_country,
    gvt.return_timestamp AS vessel_return_date,
    pr.name_en AS vessel_return_port,
    cr.code AS vessel_return_country
   FROM ((((((((((((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     LEFT JOIN ros_common.trip_vessel gvt ON ((t.id = gvt.trip_id)))
     LEFT JOIN ros_common.trip_observer otd ON ((t.id = otd.trip_id)))
     LEFT JOIN ros_meta.observer oi ON ((otd.observer_id = oi.contact_id)))
     LEFT JOIN ros_meta.vessel vi ON ((gvt.vessel_id = vi.id)))
     LEFT JOIN refs_fishery_config.gears g ON (((vi.main_fishing_gear_code)::text = (g.code)::text)))
     LEFT JOIN refs_admin.countries f ON ((vi.flag_code = f.code)))
     LEFT JOIN refs_admin.countries r ON ((od.reporting_country_code = r.code)))
     LEFT JOIN refs_admin.ports pd ON (((gvt.departure_port_code)::text = (pd.code)::text)))
     LEFT JOIN refs_admin.countries cd ON (((gvt.departure_country_code)::bpchar = cd.code)))
     LEFT JOIN refs_admin.ports pr ON (((gvt.return_port_code)::text = (pr.code)::text)))
     LEFT JOIN refs_admin.countries cr ON (((gvt.return_country_code)::bpchar = cr.code)))
  WHERE (od.vessel_type_code = 'LL'::bpchar);


--
-- Name: v_pl_trips; Type: VIEW; Schema: ros_meta; Owner: -
--

CREATE VIEW ros_meta.v_pl_trips AS
 SELECT od.source,
    t.id AS trip_id,
    t.uid AS trip_uid,
    t.trip_original_id AS trip_number,
    od.creation_time AS creation_date,
    od.finalization_time AS finalization_date,
    od.submission_time AS submission_date,
        CASE
            WHEN (otd.trip_id IS NULL) THEN 0
            ELSE 1
        END AS has_observer_trip_info,
    'PL'::text AS fishing_operation_type,
    oi.iotc_observer_identifier AS observer_iotc_number,
    otd.date_time_embarkation AS observer_imbarcation_date,
    otd.date_time_disembarkation AS observer_disembarcation_date,
    vi.id AS vessel_info_id,
    vi.iotc_vessel_identifier AS vessel_iotc_number,
    g.code AS main_gear,
    r.code AS reporting_flag,
    f.code AS vessel_flag,
    gvt.departure_timestamp AS vessel_departure_date,
    pd.name_en AS vessel_departure_port,
    cd.code AS vessel_departure_country,
    gvt.return_timestamp AS vessel_return_date,
    pr.name_en AS vessel_return_port,
    cr.code AS vessel_return_country
   FROM ((((((((((((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     LEFT JOIN ros_common.trip_vessel gvt ON ((t.id = gvt.trip_id)))
     LEFT JOIN ros_common.trip_observer otd ON ((t.id = otd.trip_id)))
     LEFT JOIN ros_meta.observer oi ON ((otd.observer_id = oi.contact_id)))
     LEFT JOIN ros_meta.vessel vi ON ((gvt.vessel_id = vi.id)))
     LEFT JOIN refs_fishery_config.gears g ON (((vi.main_fishing_gear_code)::text = (g.code)::text)))
     LEFT JOIN refs_admin.countries f ON ((vi.flag_code = f.code)))
     LEFT JOIN refs_admin.countries r ON ((od.reporting_country_code = r.code)))
     LEFT JOIN refs_admin.ports pd ON (((gvt.departure_port_code)::text = (pd.code)::text)))
     LEFT JOIN refs_admin.countries cd ON (((gvt.departure_country_code)::bpchar = cd.code)))
     LEFT JOIN refs_admin.ports pr ON (((gvt.return_port_code)::text = (pr.code)::text)))
     LEFT JOIN refs_admin.countries cr ON (((gvt.return_country_code)::bpchar = cr.code)))
  WHERE (od.vessel_type_code = 'LP'::bpchar);


--
-- Name: v_ps_sets; Type: VIEW; Schema: ros_meta; Owner: -
--

CREATE VIEW ros_meta.v_ps_sets AS
 SELECT t.id AS trip_id,
    t.uid AS trip_uid,
    so.id AS set_id,
    'PS'::text AS fishing_operation_type,
    COALESCE(so.start_setting_date_and_time, so.time_start_brailing) AS start_time,
    COALESCE(so.time_start_brailing, so.time_net_pursed) AS end_time,
    ros_meta.to_grid_1(so.start_setting_latitude, so.start_setting_longitude) AS grid_1,
    ros_meta.to_grid_5(so.start_setting_latitude, so.start_setting_longitude) AS grid_5,
    1 AS effort,
    1 AS total_effort,
    'SETS'::text AS effort_unit
   FROM (((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     JOIN ros_ps.fishing_events fed ON ((fed.trip_id = t.id)))
     LEFT JOIN ros_ps.setting_operations so ON ((fed.setting_operation_id = so.id)))
  WHERE (od.vessel_type_code = 'SP'::bpchar);


--
-- Name: v_ps_trips; Type: VIEW; Schema: ros_meta; Owner: -
--

CREATE VIEW ros_meta.v_ps_trips AS
 SELECT od.source,
    t.id AS trip_id,
    t.uid AS trip_uid,
    t.trip_original_id AS trip_number,
    od.creation_time AS creation_date,
    od.finalization_time AS finalization_date,
    od.submission_time AS submission_date,
        CASE
            WHEN (otd.trip_id IS NULL) THEN 0
            ELSE 1
        END AS has_observer_trip_info,
    'PL'::text AS fishing_operation_type,
    oi.iotc_observer_identifier AS observer_iotc_number,
    otd.date_time_embarkation AS observer_imbarcation_date,
    otd.date_time_disembarkation AS observer_disembarcation_date,
    vi.id AS vessel_info_id,
    vi.iotc_vessel_identifier AS vessel_iotc_number,
    g.code AS main_gear,
    r.code AS reporting_flag,
    f.code AS vessel_flag,
    gvt.departure_timestamp AS vessel_departure_date,
    pd.name_en AS vessel_departure_port,
    cd.code AS vessel_departure_country,
    gvt.return_timestamp AS vessel_return_date,
    pr.name_en AS vessel_return_port,
    cr.code AS vessel_return_country
   FROM ((((((((((((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     LEFT JOIN ros_common.trip_vessel gvt ON ((t.id = gvt.trip_id)))
     LEFT JOIN ros_common.trip_observer otd ON ((t.id = otd.trip_id)))
     LEFT JOIN ros_meta.observer oi ON ((otd.observer_id = oi.contact_id)))
     LEFT JOIN ros_meta.vessel vi ON ((gvt.vessel_id = vi.id)))
     LEFT JOIN refs_fishery_config.gears g ON (((vi.main_fishing_gear_code)::text = (g.code)::text)))
     LEFT JOIN refs_admin.countries f ON ((vi.flag_code = f.code)))
     LEFT JOIN refs_admin.countries r ON ((od.reporting_country_code = r.code)))
     LEFT JOIN refs_admin.ports pd ON (((gvt.departure_port_code)::text = (pd.code)::text)))
     LEFT JOIN refs_admin.countries cd ON (((gvt.departure_country_code)::bpchar = cd.code)))
     LEFT JOIN refs_admin.ports pr ON (((gvt.return_port_code)::text = (pr.code)::text)))
     LEFT JOIN refs_admin.countries cr ON (((gvt.return_country_code)::bpchar = cr.code)))
  WHERE (od.vessel_type_code = 'SP'::bpchar);


--
-- Name: v_sets; Type: VIEW; Schema: ros_meta; Owner: -
--

CREATE VIEW ros_meta.v_sets AS
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


--
-- Name: v_trips; Type: VIEW; Schema: ros_meta; Owner: -
--

CREATE VIEW ros_meta.v_trips AS
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


--
-- Name: v_sets_by_year_flag_and_gear; Type: VIEW; Schema: ros_meta; Owner: -
--

CREATE VIEW ros_meta.v_sets_by_year_flag_and_gear AS
 SELECT date_part('year'::text, COALESCE(s.start_time, s.end_time)) AS year,
        CASE
            WHEN (t.vessel_flag = ANY (ARRAY['FRA'::bpchar, 'ESP'::bpchar])) THEN (concat('EU.', t.vessel_flag))::bpchar
            ELSE t.vessel_flag
        END AS flag,
    t.fishing_operation_type AS gear,
    count(*) AS num_sets
   FROM (ros_meta.v_sets s
     JOIN ros_meta.v_trips t ON (((s.trip_uid)::text = (t.trip_uid)::text)))
  GROUP BY (date_part('year'::text, COALESCE(s.start_time, s.end_time))), t.vessel_flag, t.fishing_operation_type;


--
-- Name: v_sets_by_year_flag_and_gear; Type: VIEW; Schema: ros_analysis; Owner: -
--

CREATE VIEW ros_analysis.v_sets_by_year_flag_and_gear AS
 SELECT year,
    flag,
    gear,
    num_sets
   FROM ros_meta.v_sets_by_year_flag_and_gear;


--
-- Name: v_sets_raw; Type: VIEW; Schema: ros_analysis; Owner: -
--

CREATE VIEW ros_analysis.v_sets_raw AS
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


--
-- Name: v_sf_l; Type: VIEW; Schema: ros_analysis; Owner: -
--

CREATE VIEW ros_analysis.v_sf_l AS
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
  WHERE (v_ps_sf_l.year IS NOT NULL)
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
  WHERE (v_ll_sf_l.year IS NOT NULL);


--
-- Name: v_sf_w; Type: VIEW; Schema: ros_analysis; Owner: -
--

CREATE VIEW ros_analysis.v_sf_w AS
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
  WHERE (v_ps_sf_w.year IS NOT NULL)
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
  WHERE (v_ll_sf_w.year IS NOT NULL);


--
-- Name: v_sf; Type: VIEW; Schema: ros_analysis; Owner: -
--

CREATE VIEW ros_analysis.v_sf AS
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


--
-- Name: v_trips_by_year_flag_and_gear; Type: VIEW; Schema: ros_meta; Owner: -
--

CREATE VIEW ros_meta.v_trips_by_year_flag_and_gear AS
 SELECT source,
    date_part('year'::text, COALESCE(vessel_departure_date, vessel_return_date)) AS year,
        CASE
            WHEN (reporting_flag = ANY (ARRAY['FRA'::bpchar, 'ESP'::bpchar])) THEN (concat('EU.', reporting_flag))::bpchar
            ELSE reporting_flag
        END AS flag,
    fishing_operation_type AS gear,
    count(*) AS num_trips
   FROM ros_meta.v_trips t
  GROUP BY source, (date_part('year'::text, COALESCE(vessel_departure_date, vessel_return_date))), reporting_flag, fishing_operation_type;


--
-- Name: v_trips_by_year_flag_and_gear; Type: VIEW; Schema: ros_analysis; Owner: -
--

CREATE VIEW ros_analysis.v_trips_by_year_flag_and_gear AS
 SELECT year,
    flag,
    gear,
    sum(num_trips) AS num_trips
   FROM ros_meta.v_trips_by_year_flag_and_gear
  GROUP BY year, flag, gear;


--
-- Name: additional_details_on_non_target_species_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: -
--

ALTER TABLE ros_common.additional_details_on_non_target_species ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.additional_details_on_non_target_species_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: biometric_information_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: -
--

ALTER TABLE ros_common.biometric_information ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.biometric_information_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: depredation_details; Type: TABLE; Schema: ros_common; Owner: -
--

CREATE TABLE ros_common.depredation_details (
    id integer NOT NULL,
    depredation_source_code character varying(3),
    predator_observed_code character varying(16)
);


--
-- Name: depredation_details_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: -
--

ALTER TABLE ros_common.depredation_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.depredation_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: observer_data_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: -
--

ALTER TABLE ros_common.observation_dataset ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.observer_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: trip_reasons_for_days_lost; Type: TABLE; Schema: ros_common; Owner: -
--

CREATE TABLE ros_common.trip_reasons_for_days_lost (
    id integer NOT NULL,
    reason text,
    inoperativity_reason character varying(255),
    trip_id integer NOT NULL
);


--
-- Name: reasons_for_days_lost_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: -
--

ALTER TABLE ros_common.trip_reasons_for_days_lost ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.reasons_for_days_lost_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: trip_daily_activities; Type: TABLE; Schema: ros_common; Owner: -
--

CREATE TABLE ros_common.trip_daily_activities (
    trip_id integer NOT NULL,
    id integer NOT NULL,
    date timestamp(3) without time zone NOT NULL
);


--
-- Name: trip_daily_activities_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: -
--

ALTER TABLE ros_common.trip_daily_activities ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.trip_daily_activities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: trip_daily_activity_details; Type: TABLE; Schema: ros_common; Owner: -
--

CREATE TABLE ros_common.trip_daily_activity_details (
    id integer NOT NULL,
    comments text,
    time_of_day timestamp(3) without time zone,
    latitude double precision,
    longitude double precision,
    activity_code character(2),
    trip_daily_activity_id integer NOT NULL
);


--
-- Name: trip_daily_activity_details_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: -
--

ALTER TABLE ros_common.trip_daily_activity_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.trip_daily_activity_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: trip_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: -
--

ALTER TABLE ros_common.trip ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.trip_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: trip_vessel_fish_preservation_method; Type: TABLE; Schema: ros_common; Owner: -
--

CREATE TABLE ros_common.trip_vessel_fish_preservation_method (
    trip_id integer NOT NULL,
    fish_preservation_method_code character(2) NOT NULL
);


--
-- Name: trip_vessel_fish_storage_type; Type: TABLE; Schema: ros_common; Owner: -
--

CREATE TABLE ros_common.trip_vessel_fish_storage_type (
    trip_id integer NOT NULL,
    fish_storage_type_code character(2) NOT NULL
);


--
-- Name: trip_vessel_main_engines; Type: TABLE; Schema: ros_common; Owner: -
--

CREATE TABLE ros_common.trip_vessel_main_engines (
    trip_id integer NOT NULL,
    main_engines_make character varying(255),
    main_engines_value double precision NOT NULL,
    main_engines_unit character varying(3) NOT NULL,
    CONSTRAINT ros_common_trip_vessel_main_engines_main_engines_unit_check CHECK (((main_engines_unit)::text = ANY ((ARRAY['bhp'::character varying, 'hp'::character varying])::text[])))
);


--
-- Name: trip_waste_managements; Type: TABLE; Schema: ros_common; Owner: -
--

CREATE TABLE ros_common.trip_waste_managements (
    id integer NOT NULL,
    trip_id integer NOT NULL,
    waste_storage_or_disposal_method_code character(2),
    waste_category_code character(2)
);


--
-- Name: waste_managements_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: -
--

ALTER TABLE ros_common.trip_waste_managements ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.waste_managements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: additional_catch_details_on_ssi; Type: TABLE; Schema: ros_gn; Owner: -
--

CREATE TABLE ros_gn.additional_catch_details_on_ssi (
    id integer NOT NULL,
    photo_id character varying(255),
    gear_interaction_code character(2),
    handling_method_code character(2),
    brought_on_board character varying(5),
    revival character varying(5)
);


--
-- Name: additional_catch_details_on_ssi_id_seq; Type: SEQUENCE; Schema: ros_gn; Owner: -
--

ALTER TABLE ros_gn.additional_catch_details_on_ssi ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_gn.additional_catch_details_on_ssi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: catch_details; Type: TABLE; Schema: ros_gn; Owner: -
--

CREATE TABLE ros_gn.catch_details (
    id integer NOT NULL,
    catch_detail_original_id character varying(255) NOT NULL,
    comments text,
    estimated_catch_in_numbers integer,
    fishing_event_id integer,
    type_of_fate_code character(2) NOT NULL,
    estimated_weight_sampling_method_code character(2),
    fates_code character(2),
    species_code character varying(16),
    estimated_weight_value double precision,
    estimated_weight_unit character varying(3),
    estimated_weight_type_of_measurement_code character(2),
    estimated_weight_processing_type_code character(2),
    estimated_weight_method_code character(2),
    CONSTRAINT ros_gn_catch_details_estimated_weight_unit_check CHECK (((estimated_weight_unit)::text = ANY ((ARRAY['kg'::character varying, 't'::character varying])::text[])))
);


--
-- Name: catch_details_id_seq; Type: SEQUENCE; Schema: ros_gn; Owner: -
--

ALTER TABLE ros_gn.catch_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_gn.catch_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: fishing_events; Type: TABLE; Schema: ros_gn; Owner: -
--

CREATE TABLE ros_gn.fishing_events (
    id integer NOT NULL,
    comments text,
    event_original_id character varying(255),
    hauling_operation_id integer,
    mitigation_measure_id integer,
    setting_operation_id integer,
    trip_id integer NOT NULL
);


--
-- Name: fishing_events_id_seq; Type: SEQUENCE; Schema: ros_gn; Owner: -
--

ALTER TABLE ros_gn.fishing_events ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_gn.fishing_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: gear_specifications; Type: TABLE; Schema: ros_gn; Owner: -
--

CREATE TABLE ros_gn.gear_specifications (
    id integer NOT NULL,
    trip_id integer NOT NULL,
    net_drum_hauler character varying(5)
);


--
-- Name: gear_specifications_id_seq; Type: SEQUENCE; Schema: ros_gn; Owner: -
--

ALTER TABLE ros_gn.gear_specifications ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_gn.gear_specifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: gillnet_configuration; Type: TABLE; Schema: ros_gn; Owner: -
--

CREATE TABLE ros_gn.gillnet_configuration (
    id integer NOT NULL,
    gillnet_sequential_original_id character varying(255),
    hanging_ratio double precision,
    number_of_floats integer,
    total_number_of_panels integer,
    vertical_mesh_count integer,
    gillnet_configuration_id integer,
    float_type_code character(2),
    gillnet_material_type_code character(2),
    net_depth_value double precision,
    net_depth_unit character varying(3),
    distance_between_floats_value double precision,
    distance_between_floats_unit character varying(3),
    droplines_length_value double precision,
    droplines_length_unit character varying(3),
    net_length_value double precision,
    net_length_unit character varying(3),
    droplines_used character varying(5),
    panels_stacked character varying(5),
    CONSTRAINT ros_gn_gillnet_configuration_droplines_length_unit_check CHECK (((droplines_length_unit)::text = ANY ((ARRAY['km'::character varying, 'm'::character varying])::text[]))),
    CONSTRAINT ros_gn_gillnet_configuration_net_depth_unit_check CHECK (((net_depth_unit)::text = 'm'::text)),
    CONSTRAINT ros_gn_gillnet_configuration_net_length_unit_check CHECK (((net_length_unit)::text = ANY ((ARRAY['km'::character varying, 'm'::character varying])::text[])))
);


--
-- Name: gillnet_configuration_id_seq; Type: SEQUENCE; Schema: ros_gn; Owner: -
--

ALTER TABLE ros_gn.gillnet_configuration ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_gn.gillnet_configuration_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: gillnet_configuration_net_web_colours; Type: TABLE; Schema: ros_gn; Owner: -
--

CREATE TABLE ros_gn.gillnet_configuration_net_web_colours (
    gillnet_configuration_id_nwc integer NOT NULL,
    net_colour_code character(2) NOT NULL
);


--
-- Name: gillnet_configuration_stretched_mesh_sizes; Type: TABLE; Schema: ros_gn; Owner: -
--

CREATE TABLE ros_gn.gillnet_configuration_stretched_mesh_sizes (
    gillnet_configuration_id_sms integer NOT NULL,
    stretched_mesh_size_value double precision NOT NULL,
    stretched_mesh_size_unit character varying(3) NOT NULL,
    CONSTRAINT ros_gn_g_conf_stre_mesh_sizes_stretched_mesh_size_unit_check CHECK (((stretched_mesh_size_unit)::text = 'mm'::text))
);


--
-- Name: hauling_operations; Type: TABLE; Schema: ros_gn; Owner: -
--

CREATE TABLE ros_gn.hauling_operations (
    id integer NOT NULL,
    end_hauling_date_and_time timestamp(6) without time zone,
    number_of_net_panels_observed integer,
    number_of_net_panels_retrieved integer,
    start_hauling_date_and_time timestamp(6) without time zone,
    end_hauling_latitude double precision,
    end_hauling_longitude double precision,
    start_hauling_latitude double precision,
    start_hauling_longitude double precision,
    net_condition_code character(2),
    sampling_protocol_code character(2)
);


--
-- Name: hauling_operations_id_seq; Type: SEQUENCE; Schema: ros_gn; Owner: -
--

ALTER TABLE ros_gn.hauling_operations ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_gn.hauling_operations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: mitigation_measures; Type: TABLE; Schema: ros_gn; Owner: -
--

CREATE TABLE ros_gn.mitigation_measures (
    id integer NOT NULL,
    mitigation_measures character varying(5)
);


--
-- Name: mitigation_measures_id_seq; Type: SEQUENCE; Schema: ros_gn; Owner: -
--

ALTER TABLE ros_gn.mitigation_measures ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_gn.mitigation_measures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: mitigation_measures_mitigation_devices; Type: TABLE; Schema: ros_gn; Owner: -
--

CREATE TABLE ros_gn.mitigation_measures_mitigation_devices (
    mitigation_measure_id integer NOT NULL,
    mitigation_device_code character(2) NOT NULL
);


--
-- Name: setting_operations; Type: TABLE; Schema: ros_gn; Owner: -
--

CREATE TABLE ros_gn.setting_operations (
    id integer NOT NULL,
    end_setting_date_and_time timestamp(6) without time zone,
    gillnet_sequential_original_id integer,
    start_setting_date_and_time timestamp(6) without time zone,
    vessel_speed double precision,
    end_setting_latitude double precision,
    end_setting_longitude double precision,
    start_setting_latitude double precision,
    start_setting_longitude double precision,
    net_configuration_code character(2),
    net_deploy_depth_code character(2),
    net_setting_strategy_code character(2)
);


--
-- Name: setting_operations_id_seq; Type: SEQUENCE; Schema: ros_gn; Owner: -
--

ALTER TABLE ros_gn.setting_operations ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_gn.setting_operations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: sinkers_by_type; Type: TABLE; Schema: ros_gn; Owner: -
--

CREATE TABLE ros_gn.sinkers_by_type (
    id integer NOT NULL,
    number integer,
    gillnet_configuration_id integer,
    sinker_material_type_code character(2),
    average_sinker_weight_value double precision,
    average_sinker_weight_unit character varying(3)
);


--
-- Name: sinkers_by_type_id_seq; Type: SEQUENCE; Schema: ros_gn; Owner: -
--

ALTER TABLE ros_gn.sinkers_by_type ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_gn.sinkers_by_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: specimens; Type: TABLE; Schema: ros_gn; Owner: -
--

CREATE TABLE ros_gn.specimens (
    id integer NOT NULL,
    specimen_original_id character varying(255) NOT NULL,
    additional_catch_details_on_ssis_id integer,
    additional_specimen_details_non_target_species_id integer,
    biometric_information_id integer,
    depredation_detail_id integer,
    tag_detail_id integer,
    catch_detail_id integer
);


--
-- Name: specimens_id_seq; Type: SEQUENCE; Schema: ros_gn; Owner: -
--

ALTER TABLE ros_gn.specimens ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_gn.specimens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: tag_details; Type: TABLE; Schema: ros_gn; Owner: -
--

CREATE TABLE ros_gn.tag_details (
    id integer NOT NULL,
    alternate_tag_original_id character varying(255),
    tag_original_id character varying(255),
    tag_type_code character(2),
    tag_finder_id integer,
    tag_recovery character varying(5),
    tag_release character varying(5)
);


--
-- Name: tag_details_id_seq; Type: SEQUENCE; Schema: ros_gn; Owner: -
--

ALTER TABLE ros_gn.tag_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_gn.tag_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: additional_catch_details_on_ssi; Type: TABLE; Schema: ros_ll; Owner: -
--

CREATE TABLE ros_ll.additional_catch_details_on_ssi (
    id integer NOT NULL,
    bait_type character varying(255),
    photo_id character varying(255),
    bait_condition_code character(2),
    dehooker_device_code character(2),
    gear_interaction_code character(2),
    handling_method_code character(2),
    leader_material_type_code character(2),
    hook_type_code character(3),
    leader_thickness_value double precision,
    leader_thickness_unit character varying(3),
    brought_on_board character varying(5),
    light_attached_to_branchline character varying(5),
    revival character varying(5)
);


--
-- Name: additional_catch_details_on_ssi_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: -
--

ALTER TABLE ros_ll.additional_catch_details_on_ssi ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ll.additional_catch_details_on_ssi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: baits_by_conditions; Type: TABLE; Schema: ros_ll; Owner: -
--

CREATE TABLE ros_ll.baits_by_conditions (
    id integer NOT NULL,
    dye_colour character varying(255),
    ratio double precision,
    setting_operation_id integer NOT NULL,
    bait_condition_code character(2),
    species_code character varying(16)
);


--
-- Name: baits_by_conditions_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: -
--

ALTER TABLE ros_ll.baits_by_conditions ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ll.baits_by_conditions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: biteoffs_by_branchlines_set; Type: TABLE; Schema: ros_ll; Owner: -
--

CREATE TABLE ros_ll.biteoffs_by_branchlines_set (
    id integer NOT NULL,
    branchline_configuration_number integer,
    number_of_biteoffs integer,
    hauling_operation_id integer NOT NULL
);


--
-- Name: biteoffs_by_branchlines_set_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: -
--

ALTER TABLE ros_ll.biteoffs_by_branchlines_set ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ll.biteoffs_by_branchlines_set_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: branchline_configurations; Type: TABLE; Schema: ros_ll; Owner: -
--

CREATE TABLE ros_ll.branchline_configurations (
    id integer NOT NULL,
    configuration_number integer,
    gear_specification_id integer NOT NULL
);


--
-- Name: branchline_configurations_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: -
--

ALTER TABLE ros_ll.branchline_configurations ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ll.branchline_configurations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: branchline_configurations_storage; Type: TABLE; Schema: ros_ll; Owner: -
--

CREATE TABLE ros_ll.branchline_configurations_storage (
    branchline_configuration_id integer NOT NULL,
    branchline_storage_code character(2) NOT NULL
);


--
-- Name: branchline_sections; Type: TABLE; Schema: ros_ll; Owner: -
--

CREATE TABLE ros_ll.branchline_sections (
    id integer NOT NULL,
    section_number integer,
    branchline_configuration_id integer NOT NULL,
    branchline_material_type_code character(2),
    diameter_value double precision,
    diameter_unit character varying(3),
    length_value double precision,
    length_unit character varying(3),
    CONSTRAINT ros_ll_branchline_sections_diameter_unit_check CHECK (((diameter_unit)::text = 'mm'::text)),
    CONSTRAINT ros_ll_branchline_sections_length_unit_check CHECK (((length_unit)::text = ANY ((ARRAY['km'::character varying, 'm'::character varying])::text[])))
);


--
-- Name: branchline_sections_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: -
--

ALTER TABLE ros_ll.branchline_sections ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ll.branchline_sections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: branchlines_set; Type: TABLE; Schema: ros_ll; Owner: -
--

CREATE TABLE ros_ll.branchlines_set (
    id integer NOT NULL,
    branchline_configuration_number integer,
    number_of_branchlines integer,
    setting_operation_id integer NOT NULL
);


--
-- Name: branchlines_set_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: -
--

ALTER TABLE ros_ll.branchlines_set ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ll.branchlines_set_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: catch_details_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: -
--

ALTER TABLE ros_ll.catch_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ll.catch_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: fishing_events_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: -
--

ALTER TABLE ros_ll.fishing_events ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ll.fishing_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: floatlines; Type: TABLE; Schema: ros_ll; Owner: -
--

CREATE TABLE ros_ll.floatlines (
    id integer NOT NULL,
    floatline_number integer,
    setting_operation_id integer NOT NULL,
    floatline_length_value double precision,
    floatline_length_unit character varying(3),
    CONSTRAINT ros_ll_floatlines_floatline_length_unit_check CHECK (((floatline_length_unit)::text = ANY ((ARRAY['km'::character varying, 'm'::character varying])::text[])))
);


--
-- Name: floatlines_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: -
--

ALTER TABLE ros_ll.floatlines ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ll.floatlines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: gear_specifications; Type: TABLE; Schema: ros_ll; Owner: -
--

CREATE TABLE ros_ll.gear_specifications (
    id integer NOT NULL,
    storage character varying(255),
    tori_line_detail_id integer,
    trip_id integer NOT NULL,
    bait_casting_machine character varying(5),
    line_hauler character varying(5),
    line_setter character varying(5)
);


--
-- Name: gear_specifications_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: -
--

ALTER TABLE ros_ll.gear_specifications ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ll.gear_specifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: gear_specifications_mitigation_device; Type: TABLE; Schema: ros_ll; Owner: -
--

CREATE TABLE ros_ll.gear_specifications_mitigation_device (
    gear_specification_id integer NOT NULL,
    mitigation_device_code character(2) NOT NULL
);


--
-- Name: hauling_offal_disposal_positions; Type: TABLE; Schema: ros_ll; Owner: -
--

CREATE TABLE ros_ll.hauling_offal_disposal_positions (
    hauling_operation_id integer NOT NULL,
    offal_disposal_position character varying(255) NOT NULL
);


--
-- Name: hauling_operations_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: -
--

ALTER TABLE ros_ll.hauling_operations ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ll.hauling_operations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: hooks_by_type; Type: TABLE; Schema: ros_ll; Owner: -
--

CREATE TABLE ros_ll.hooks_by_type (
    id integer NOT NULL,
    percentage_of_set double precision,
    variations character varying(255),
    setting_operation_id integer NOT NULL,
    hook_type_code character(3)
);


--
-- Name: hooks_by_type_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: -
--

ALTER TABLE ros_ll.hooks_by_type ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ll.hooks_by_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: leader_set; Type: TABLE; Schema: ros_ll; Owner: -
--

CREATE TABLE ros_ll.leader_set (
    id integer NOT NULL,
    setting_operation_id integer NOT NULL,
    leader_material_type_code character(2) NOT NULL,
    percentage_of_branchline double precision NOT NULL,
    total_branchline_minimum_length_value double precision NOT NULL,
    total_branchline_minimum_length_unit character varying(3) NOT NULL,
    total_branchline_maximum_length_value double precision NOT NULL,
    total_branchline_maximum_length_unit character varying(3) NOT NULL,
    CONSTRAINT ros_ll_leader_set_total_branchline_maximum_length_unit_check CHECK (((total_branchline_maximum_length_unit)::text = ANY ((ARRAY['km'::character varying, 'm'::character varying])::text[]))),
    CONSTRAINT ros_ll_leader_set_total_branchline_minimum_length_unit_check CHECK (((total_branchline_minimum_length_unit)::text = ANY ((ARRAY['km'::character varying, 'm'::character varying])::text[])))
);


--
-- Name: leader_set_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: -
--

ALTER TABLE ros_ll.leader_set ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ll.leader_set_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: lights_by_type_and_colour; Type: TABLE; Schema: ros_ll; Owner: -
--

CREATE TABLE ros_ll.lights_by_type_and_colour (
    id integer NOT NULL,
    number_of_lights_by_type_and_colour integer,
    setting_operation_id integer NOT NULL,
    light_colour_code character(2),
    light_type_code character(2)
);


--
-- Name: lights_by_type_and_colour_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: -
--

ALTER TABLE ros_ll.lights_by_type_and_colour ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ll.lights_by_type_and_colour_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: mitigation_measures; Type: TABLE; Schema: ros_ll; Owner: -
--

CREATE TABLE ros_ll.mitigation_measures (
    id integer NOT NULL,
    number_of_tori_lines_deployed integer,
    percentage_of_branchlines_weighted double precision,
    hook_sinker_distance_value double precision,
    hook_sinker_distance_unit character varying(3),
    average_sinker_weight_value double precision,
    average_sinker_weight_unit character varying(3),
    branchline_weighted character varying(5),
    hooks_set_between_dusk_and_dawn character varying(5),
    minimum_deck_lighting_used character varying(5),
    hooks_pods character varying(5)
);


--
-- Name: mitigation_measures_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: -
--

ALTER TABLE ros_ll.mitigation_measures ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ll.mitigation_measures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: mitigation_measures_mitigation_devices; Type: TABLE; Schema: ros_ll; Owner: -
--

CREATE TABLE ros_ll.mitigation_measures_mitigation_devices (
    mitigation_measure_id integer NOT NULL,
    mitigation_device_code character(2) NOT NULL
);


--
-- Name: setting_operations_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: -
--

ALTER TABLE ros_ll.setting_operations ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ll.setting_operations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: setting_operations_target_species; Type: TABLE; Schema: ros_ll; Owner: -
--

CREATE TABLE ros_ll.setting_operations_target_species (
    setting_operation_id integer NOT NULL,
    target_species_code character varying(16) NOT NULL
);


--
-- Name: specimens_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: -
--

ALTER TABLE ros_ll.specimens ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ll.specimens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: tag_details; Type: TABLE; Schema: ros_ll; Owner: -
--

CREATE TABLE ros_ll.tag_details (
    id integer NOT NULL,
    alternate_tag_original_id character varying(255),
    tag_original_id character varying(255),
    tag_type_code character(2),
    tag_finder_id integer,
    tag_recovery character varying(5),
    tag_release character varying(5)
);


--
-- Name: tag_details_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: -
--

ALTER TABLE ros_ll.tag_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ll.tag_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: tori_line_details; Type: TABLE; Schema: ros_ll; Owner: -
--

CREATE TABLE ros_ll.tori_line_details (
    id integer NOT NULL,
    number_of_streamers_per_line integer,
    streamer_type character varying(255),
    towed_objects_number integer,
    towed_objects_type character varying(255),
    streamer_distance_value double precision,
    streamer_distance_unit character varying(3),
    attached_height_value double precision,
    attached_height_unit character varying(3),
    tori_line_length_value double precision,
    tori_line_length_unit character varying(3),
    streamer_line_length_max_value double precision,
    streamer_line_length_max_unit character varying(3),
    streamer_line_length_min_value double precision,
    streamer_line_length_min_unit character varying(3),
    streamers_reach_surface character varying(5),
    CONSTRAINT ros_ll_tori_line_details_streamer_line_length_max_unit_check CHECK (((streamer_line_length_max_unit)::text = ANY ((ARRAY['km'::character varying, 'm'::character varying])::text[]))),
    CONSTRAINT ros_ll_tori_line_details_streamer_line_length_min_unit_check CHECK (((streamer_line_length_min_unit)::text = ANY ((ARRAY['km'::character varying, 'm'::character varying])::text[]))),
    CONSTRAINT ros_ll_tori_line_details_tori_line_length_unit_check CHECK (((tori_line_length_unit)::text = ANY ((ARRAY['km'::character varying, 'm'::character varying])::text[])))
);


--
-- Name: tori_line_details_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: -
--

ALTER TABLE ros_ll.tori_line_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ll.tori_line_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: contact; Type: TABLE; Schema: ros_meta; Owner: -
--

CREATE TABLE ros_meta.contact (
    id integer NOT NULL,
    full_name character varying(255) NOT NULL,
    nationality_code character(3)
);


--
-- Name: contact_id_seq; Type: SEQUENCE; Schema: ros_meta; Owner: -
--

ALTER TABLE ros_meta.contact ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_meta.contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: focal_point; Type: TABLE; Schema: ros_meta; Owner: -
--

CREATE TABLE ros_meta.focal_point (
    contact_id integer NOT NULL,
    email character varying(255),
    organisation_name character varying(1024),
    comment character varying(1024)
);


--
-- Name: observer_accreditation; Type: TABLE; Schema: ros_meta; Owner: -
--

CREATE TABLE ros_meta.observer_accreditation (
    observer_id integer NOT NULL,
    accreditation_year integer,
    accredited_by character varying(255),
    deregistered_date date
);


--
-- Name: observer_identifier_mapping; Type: TABLE; Schema: ros_meta; Owner: -
--

CREATE TABLE ros_meta.observer_identifier_mapping (
    legacy_iotc_observer_identifier character varying(16) NOT NULL,
    iotc_observer_identifier character varying(16) NOT NULL
);


--
-- Name: v_ll_fdays; Type: VIEW; Schema: ros_meta; Owner: -
--

CREATE VIEW ros_meta.v_ll_fdays AS
 SELECT t.id AS trip_id,
    t.uid AS trip_uid,
    'LL'::text AS fishing_operation_type,
    date_part('year'::text, s.start_setting_date_and_time) AS year,
    date_part('month'::text, s.start_setting_date_and_time) AS month,
    ros_meta.to_grid_1(s.start_setting_latitude, s.end_setting_latitude) AS grid_1,
    ros_meta.to_grid_5(s.start_setting_latitude, s.end_setting_latitude) AS grid_5,
    count(DISTINCT concat(date_part('month'::text, s.start_setting_date_and_time), '/', date_part('day'::text, s.start_setting_date_and_time))) AS effort,
    'FDAYS'::text AS effort_unit
   FROM (((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     JOIN ros_ll.fishing_events fe ON ((fe.trip_id = t.id)))
     JOIN ros_ll.setting_operations s ON ((fe.setting_operation_id = s.id)))
  WHERE (od.vessel_type_code = 'LL'::bpchar)
  GROUP BY t.id, t.uid, (date_part('year'::text, s.start_setting_date_and_time)), (date_part('month'::text, s.start_setting_date_and_time)), (ros_meta.to_grid_1(s.start_setting_latitude, s.end_setting_latitude)), (ros_meta.to_grid_5(s.start_setting_latitude, s.end_setting_latitude));


--
-- Name: v_ps_fdays; Type: VIEW; Schema: ros_meta; Owner: -
--

CREATE VIEW ros_meta.v_ps_fdays AS
 SELECT t.id AS trip_id,
    t.uid AS trip_uid,
    'PS'::text AS fishing_operation_type,
    date_part('year'::text, s.start_setting_date_and_time) AS year,
    date_part('month'::text, s.start_setting_date_and_time) AS month,
    ros_meta.to_grid_1(s.start_setting_latitude, s.start_setting_longitude) AS grid_1,
    ros_meta.to_grid_5(s.start_setting_latitude, s.start_setting_longitude) AS grid_5,
    count(DISTINCT concat(date_part('month'::text, s.start_setting_date_and_time), '/', date_part('day'::text, s.start_setting_date_and_time))) AS effort,
    'FDAYS'::text AS effort_unit
   FROM (((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     JOIN ros_ps.fishing_events fe ON ((fe.trip_id = t.id)))
     JOIN ros_ps.setting_operations s ON ((fe.setting_operation_id = s.id)))
  WHERE (od.vessel_type_code = 'PS'::bpchar)
  GROUP BY t.id, t.uid, (date_part('year'::text, s.start_setting_date_and_time)), (date_part('month'::text, s.start_setting_date_and_time)), (ros_meta.to_grid_1(s.start_setting_latitude, s.start_setting_longitude)), (ros_meta.to_grid_5(s.start_setting_latitude, s.start_setting_longitude));


--
-- Name: v_fdays; Type: VIEW; Schema: ros_meta; Owner: -
--

CREATE VIEW ros_meta.v_fdays AS
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


--
-- Name: v_ll_hooks; Type: VIEW; Schema: ros_meta; Owner: -
--

CREATE VIEW ros_meta.v_ll_hooks AS
 SELECT t.id AS trip_id,
    t.uid AS trip_uid,
    so.id AS set_id,
    'LL'::text AS fishing_operation_type,
    COALESCE(ho.start_hauling_date_and_time, so.start_setting_date_and_time) AS start_time,
    COALESCE(ho.end_hauling_date_and_time, so.end_setting_date_and_time) AS end_time,
        CASE
            WHEN ((ho.start_hauling_latitude IS NOT NULL) AND (ho.start_hauling_longitude IS NOT NULL)) THEN ros_meta.to_grid_1(ho.start_hauling_latitude, ho.start_hauling_longitude)
            WHEN ((ho.end_hauling_latitude IS NOT NULL) AND (ho.end_hauling_longitude IS NOT NULL)) THEN ros_meta.to_grid_1(ho.end_hauling_latitude, ho.end_hauling_longitude)
            WHEN ((so.start_setting_latitude IS NOT NULL) AND (so.start_setting_longitude IS NOT NULL)) THEN ros_meta.to_grid_1(so.start_setting_latitude, so.start_setting_longitude)
            WHEN ((so.end_setting_latitude IS NOT NULL) AND (so.end_setting_longitude IS NOT NULL)) THEN ros_meta.to_grid_1(so.end_setting_latitude, so.end_setting_longitude)
            ELSE NULL::bpchar
        END AS grid_1,
        CASE
            WHEN ((ho.start_hauling_latitude IS NOT NULL) AND (ho.start_hauling_longitude IS NOT NULL)) THEN ros_meta.to_grid_5(ho.start_hauling_latitude, ho.start_hauling_longitude)
            WHEN ((ho.end_hauling_latitude IS NOT NULL) AND (ho.end_hauling_longitude IS NOT NULL)) THEN ros_meta.to_grid_5(ho.end_hauling_latitude, ho.end_hauling_longitude)
            WHEN ((so.start_setting_latitude IS NOT NULL) AND (so.start_setting_longitude IS NOT NULL)) THEN ros_meta.to_grid_5(so.start_setting_latitude, so.start_setting_longitude)
            WHEN ((so.end_setting_latitude IS NOT NULL) AND (so.end_setting_longitude IS NOT NULL)) THEN ros_meta.to_grid_5(so.end_setting_latitude, so.end_setting_longitude)
            ELSE NULL::bpchar
        END AS grid_5,
    COALESCE(ho.number_of_hooks_observed, so.total_number_of_hooks_set) AS effort,
    COALESCE(so.total_number_of_hooks_set, ho.number_of_hooks_observed) AS total_effort,
    'HOOKS'::text AS effort_unit
   FROM ((((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     JOIN ros_ll.fishing_events fed ON ((fed.trip_id = t.id)))
     JOIN ros_ll.setting_operations so ON ((fed.setting_operation_id = so.id)))
     LEFT JOIN ros_ll.hauling_operations ho ON ((fed.hauling_operation_id = ho.id)))
  WHERE (od.vessel_type_code = 'LL'::bpchar);


--
-- Name: v_efforts_m; Type: VIEW; Schema: ros_meta; Owner: -
--

CREATE VIEW ros_meta.v_efforts_m AS
 SELECT date_part('year'::text, v_sets.start_time) AS year,
    date_part('month'::text, v_sets.start_time) AS month,
    v_sets.grid_1,
    v_sets.grid_5,
    v_sets.fishing_operation_type,
    sum(v_sets.effort) AS effort,
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
 SELECT date_part('year'::text, v_ll_hooks.start_time) AS year,
    date_part('month'::text, v_ll_hooks.start_time) AS month,
    v_ll_hooks.grid_1,
    v_ll_hooks.grid_5,
    v_ll_hooks.fishing_operation_type,
    sum(v_ll_hooks.effort) AS effort,
    v_ll_hooks.effort_unit
   FROM ros_meta.v_ll_hooks
  GROUP BY (date_part('year'::text, v_ll_hooks.start_time)), (date_part('month'::text, v_ll_hooks.start_time)), v_ll_hooks.grid_1, v_ll_hooks.grid_5, v_ll_hooks.fishing_operation_type, v_ll_hooks.effort_unit;


--
-- Name: v_fishing_days_by_year_flag_and_gear; Type: VIEW; Schema: ros_meta; Owner: -
--

CREATE VIEW ros_meta.v_fishing_days_by_year_flag_and_gear AS
 WITH ps AS (
         SELECT date_part('year'::text, s.start_setting_date_and_time) AS year,
            c.code AS flag,
            'PS'::text AS gear,
            count(DISTINCT concat(date_part('month'::text, s.start_setting_date_and_time), '-', date_part('day'::text, s.start_setting_date_and_time))) AS fishing_days
           FROM ((((((ros_common.observation_dataset od
             JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
             JOIN ros_common.trip_vessel gvt ON ((t.id = gvt.trip_id)))
             JOIN ros_ps.fishing_events fe ON ((fe.trip_id = t.id)))
             JOIN ros_ps.setting_operations s ON ((fe.setting_operation_id = s.id)))
             JOIN ros_meta.vessel vi ON ((gvt.vessel_id = vi.id)))
             JOIN refs_admin.countries c ON ((vi.flag_code = c.code)))
          WHERE (od.vessel_type_code = 'SP'::bpchar)
          GROUP BY c.code, (date_part('year'::text, s.start_setting_date_and_time))
        ), ll AS (
         SELECT date_part('year'::text, s.start_setting_date_and_time) AS year,
            c.code AS flag,
            'LL'::text AS gear,
            count(DISTINCT concat(date_part('month'::text, s.start_setting_date_and_time), '-', date_part('day'::text, s.start_setting_date_and_time))) AS fishing_days
           FROM ((((((ros_common.observation_dataset od
             JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
             JOIN ros_common.trip_vessel gvt ON ((t.id = gvt.trip_id)))
             JOIN ros_ll.fishing_events fe ON ((fe.trip_id = t.id)))
             JOIN ros_ll.setting_operations s ON ((fe.setting_operation_id = s.id)))
             JOIN ros_meta.vessel vi ON ((gvt.vessel_id = vi.id)))
             JOIN refs_admin.countries c ON ((vi.flag_code = c.code)))
          WHERE (od.vessel_type_code = 'LL'::bpchar)
          GROUP BY c.code, (date_part('year'::text, s.start_setting_date_and_time))
        )
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


--
-- Name: v_ll_catches; Type: VIEW; Schema: ros_meta; Owner: -
--

CREATE VIEW ros_meta.v_ll_catches AS
 SELECT t.id AS trip_id,
    t.uid AS trip_uid,
    fe.id AS set_id,
    fe.event_original_id AS set_number,
    'LL'::text AS fishing_operation_type,
    sp.code AS species,
    'RC'::text AS "TYPE",
        CASE
            WHEN (f.code IS NULL) THEN NULL::text
            ELSE concat(f.code, ' - ', f.name_en)
        END AS fate,
    count(cd.id) AS quantity,
    count(cd.id) AS quantity_sampled,
    'NO'::text AS unit
   FROM ((((((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     JOIN ros_ll.fishing_events fe ON ((fe.trip_id = t.id)))
     JOIN ros_ll.setting_operations s ON ((fe.setting_operation_id = s.id)))
     JOIN ros_ll.catch_details cd ON ((cd.fishing_event_id = fe.id)))
     JOIN refs_biology.species sp ON (((cd.species_code)::text = (sp.code)::text)))
     LEFT JOIN refs_biology.fates f ON ((cd.fates_code = f.code)))
  WHERE ((od.vessel_type_code = 'LL'::bpchar) AND (f.code ~~ 'R%'::text))
  GROUP BY t.id, t.uid, fe.id, fe.event_original_id, sp.code,
        CASE
            WHEN (f.code IS NULL) THEN NULL::text
            ELSE concat(f.code, ' - ', f.name_en)
        END;


--
-- Name: v_ll_effort_summary; Type: VIEW; Schema: ros_meta; Owner: -
--

CREATE VIEW ros_meta.v_ll_effort_summary AS
 SELECT date_part('year'::text, s.start_time) AS year,
    date_part('month'::text, s.start_time) AS month,
    t.vessel_flag,
    s.grid_1,
    s.grid_5,
        CASE
            WHEN (fg_1.code IS NULL) THEN 0
            ELSE 1
        END AS valid_grid_1,
        CASE
            WHEN (fg_5.code IS NULL) THEN 0
            ELSE 1
        END AS valid_grid_5,
    sum(s.effort) AS effort
   FROM (((ros_meta.v_sets s
     JOIN ros_meta.v_trips t ON ((s.trip_id = t.trip_id)))
     LEFT JOIN refs_gis.areas fg_1 ON ((s.grid_1 = (fg_1.code)::bpchar)))
     LEFT JOIN refs_gis.areas fg_5 ON ((s.grid_5 = (fg_5.code)::bpchar)))
  WHERE (s.fishing_operation_type = 'LL'::text)
  GROUP BY (date_part('year'::text, s.start_time)), (date_part('month'::text, s.start_time)), t.vessel_flag, s.grid_1, s.grid_5, fg_1.code, fg_5.code;


--
-- Name: v_observer; Type: VIEW; Schema: ros_meta; Owner: -
--

CREATE VIEW ros_meta.v_observer AS
 SELECT t.id,
    t.full_name,
    o.iotc_observer_identifier,
    t.nationality_code
   FROM (ros_meta.observer o
     JOIN ros_meta.contact t ON ((t.id = o.contact_id)))
  ORDER BY t.full_name;


--
-- Name: v_ps_effort_summary; Type: VIEW; Schema: ros_meta; Owner: -
--

CREATE VIEW ros_meta.v_ps_effort_summary AS
 SELECT date_part('year'::text, s.start_time) AS year,
    date_part('month'::text, s.start_time) AS month,
    t.vessel_flag,
    s.grid_1,
    s.grid_5,
        CASE
            WHEN (fg_1.code IS NULL) THEN 0
            ELSE 1
        END AS valid_grid_1,
        CASE
            WHEN (fg_5.code IS NULL) THEN 0
            ELSE 1
        END AS valid_grid_5,
    sum(s.effort) AS effort
   FROM (((ros_meta.v_sets s
     JOIN ros_meta.v_trips t ON ((s.trip_id = t.trip_id)))
     LEFT JOIN refs_gis.areas fg_1 ON ((s.grid_1 = (fg_1.code)::bpchar)))
     LEFT JOIN refs_gis.areas fg_5 ON ((s.grid_5 = (fg_5.code)::bpchar)))
  WHERE (s.fishing_operation_type = 'PS'::text)
  GROUP BY (date_part('year'::text, s.start_time)), (date_part('month'::text, s.start_time)), t.vessel_flag, s.grid_1, s.grid_5, fg_1.code, fg_5.code;


--
-- Name: v_ps_length_weight; Type: VIEW; Schema: ros_meta; Owner: -
--

CREATE VIEW ros_meta.v_ps_length_weight AS
 WITH ps_length_weight AS (
         SELECT 'PS'::text AS operation_type,
                CASE
                    WHEN (f.code ~~ 'R%'::text) THEN 'RC'::text
                    ELSE 'DI'::text
                END AS "TYPE",
            s.id AS set_id,
            sp.code AS species_code,
            sp.name_en AS species_name,
            COALESCE(x.code, 'UNK'::bpchar) AS sex_code,
            COALESCE(x.name_en, 'Unknown'::character varying) AS sex,
                CASE
                    WHEN ((lt.code IS NULL) AND (b.measured_length_value IS NOT NULL)) THEN 'UNK'::bpchar
                    ELSE lt.code
                END AS length_type_code,
                CASE
                    WHEN ((lt.name_en IS NULL) AND (b.measured_length_value IS NOT NULL)) THEN 'Unknown'::character varying
                    ELSE lt.name_en
                END AS length_type,
            b.measured_length_value AS length,
            (
                CASE
                    WHEN ((alt.code IS NULL) AND (b.alternative_measured_length_value IS NOT NULL)) THEN 'UNK'::bpchar
                    ELSE alt.code
                END)::character varying(16) AS additional_length_type_code,
            (
                CASE
                    WHEN ((alt.name_en IS NULL) AND (b.alternative_measured_length_value IS NOT NULL)) THEN 'Unknown'::character varying
                    ELSE alt.name_en
                END)::character varying(255) AS additional_length_type,
            b.alternative_measured_length_value AS additional_length,
                CASE
                    WHEN ((wp.code IS NULL) AND (b.estimated_weight_value IS NOT NULL)) THEN 'UNK'::bpchar
                    ELSE wp.code
                END AS weight_type_code,
                CASE
                    WHEN ((wp.name_en IS NULL) AND (b.estimated_weight_value IS NOT NULL)) THEN 'Unknown'::character varying
                    ELSE wp.name_en
                END AS weight_type,
            b.estimated_weight_value AS weight_value,
            b.estimated_weight_unit AS weight_unit
           FROM ((((((((((ros_ps.fishing_events fe_1
             JOIN ros_ps.setting_operations s ON ((fe_1.setting_operation_id = s.id)))
             JOIN ros_ps.catch_details c_1 ON ((c_1.fishing_event_id = s.id)))
             JOIN refs_biology.species sp ON (((c_1.species_code)::text = (sp.code)::text)))
             JOIN refs_biology.fates f ON ((c_1.fates_code = f.code)))
             JOIN ros_ps.specimens spc ON ((spc.catch_detail_id = c_1.id)))
             LEFT JOIN ros_common.biometric_information b ON ((spc.biometric_information_id = b.id)))
             LEFT JOIN refs_biology.sex x ON ((b.sex_code = x.code)))
             LEFT JOIN refs_biology.measurements lt ON ((b.measured_length_measured_length_type_code = lt.code)))
             LEFT JOIN refs_biology.measurements alt ON ((b.alternative_measured_length_measured_length_type_code = alt.code)))
             LEFT JOIN refs_fishery.fish_processing_types wp ON ((b.estimated_weight_method_code = wp.code)))
          WHERE ((b.measured_length_value IS NOT NULL) OR (b.alternative_measured_length_value IS NOT NULL) OR (b.estimated_weight_value IS NOT NULL))
        )
 SELECT c.code AS flag_code,
    c.name_en AS flag,
    date_part('year'::text, so.start_setting_date_and_time) AS year,
    date_part('month'::text, so.start_setting_date_and_time) AS month,
    so.start_setting_latitude AS lat,
    so.start_setting_longitude AS lon,
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
   FROM (((((((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     JOIN ros_common.trip_vessel gvt ON ((t.id = gvt.trip_id)))
     LEFT JOIN ros_meta.vessel vi ON ((gvt.vessel_id = vi.id)))
     LEFT JOIN refs_admin.countries c ON ((vi.flag_code = c.code)))
     JOIN ros_ps.fishing_events fe ON ((fe.trip_id = t.id)))
     JOIN ros_ps.setting_operations so ON ((fe.setting_operation_id = so.id)))
     JOIN ps_length_weight lw ON ((lw.set_id = so.id)))
  WHERE (od.vessel_type_code = 'SP'::bpchar);


--
-- Name: v_ps_sf; Type: VIEW; Schema: ros_meta; Owner: -
--

CREATE VIEW ros_meta.v_ps_sf AS
 SELECT 'PS'::text AS operation_type,
    date_part('year'::text, so.start_setting_date_and_time) AS year,
    date_part('month'::text, so.start_setting_date_and_time) AS month,
    ros_meta.to_grid_1(so.start_setting_latitude, so.start_setting_longitude) AS grid_1,
    ros_meta.to_grid_5(so.start_setting_latitude, so.start_setting_longitude) AS grid_5,
        CASE
            WHEN (f.code ~~ 'R%'::text) THEN 'RC'::text
            ELSE 'DI'::text
        END AS "TYPE",
    s.code AS species_code,
    COALESCE(x.code, 'UNK'::bpchar) AS sex_code,
    COALESCE(lt.code, 'UNK'::bpchar) AS length_type,
    b.measured_length_value AS length,
    count(*) AS num
   FROM ((((((((ros_ps.fishing_events fe
     JOIN ros_ps.setting_operations so ON ((fe.setting_operation_id = so.id)))
     JOIN ros_ps.catch_details c ON ((c.fishing_event_id = fe.id)))
     JOIN refs_biology.species s ON (((c.species_code)::text = (s.code)::text)))
     JOIN refs_biology.fates f ON ((c.fates_code = f.code)))
     JOIN ros_ps.specimens sp ON ((sp.catch_detail_id = c.id)))
     JOIN ros_common.biometric_information b ON ((sp.biometric_information_id = b.id)))
     LEFT JOIN refs_biology.measurements lt ON ((b.measured_length_measured_length_type_code = lt.code)))
     LEFT JOIN refs_biology.sex x ON ((b.sex_code = x.code)))
  GROUP BY (date_part('year'::text, so.start_setting_date_and_time)), (date_part('month'::text, so.start_setting_date_and_time)), (ros_meta.to_grid_1(so.start_setting_latitude, so.start_setting_longitude)), (ros_meta.to_grid_5(so.start_setting_latitude, so.start_setting_longitude)),
        CASE
            WHEN (f.code ~~ 'R%'::text) THEN 'RC'::text
            ELSE 'DI'::text
        END, s.code, x.code, lt.code, b.measured_length_value;


--
-- Name: v_sets_by_flag_and_gear; Type: VIEW; Schema: ros_meta; Owner: -
--

CREATE VIEW ros_meta.v_sets_by_flag_and_gear AS
 SELECT
        CASE
            WHEN (t.vessel_flag = ANY (ARRAY['FRA'::bpchar, 'ESP'::bpchar])) THEN (concat('EU.', t.vessel_flag))::bpchar
            ELSE t.vessel_flag
        END AS flag,
    t.fishing_operation_type AS gear,
    count(*) AS num_sets
   FROM (ros_meta.v_sets s
     JOIN ros_meta.v_trips t ON (((s.trip_uid)::text = (t.trip_uid)::text)))
  GROUP BY
        CASE
            WHEN (t.vessel_flag = ANY (ARRAY['FRA'::bpchar, 'ESP'::bpchar])) THEN (concat('EU.', t.vessel_flag))::bpchar
            ELSE t.vessel_flag
        END, t.fishing_operation_type;


--
-- Name: v_sets_by_year_and_gear; Type: VIEW; Schema: ros_meta; Owner: -
--

CREATE VIEW ros_meta.v_sets_by_year_and_gear AS
 SELECT date_part('year'::text, COALESCE(start_time, end_time)) AS year,
    sum(
        CASE
            WHEN (fishing_operation_type = 'PS'::text) THEN 1
            ELSE 0
        END) AS ps,
    sum(
        CASE
            WHEN (fishing_operation_type = 'LL'::text) THEN 1
            ELSE 0
        END) AS ll
   FROM ros_meta.v_sets s
  GROUP BY (date_part('year'::text, COALESCE(start_time, end_time)));


--
-- Name: vessel_licensed_target_species; Type: TABLE; Schema: ros_meta; Owner: -
--

CREATE TABLE ros_meta.vessel_licensed_target_species (
    vessel_id integer NOT NULL,
    licensed_target_species_code character varying(16)
);


--
-- Name: v_target_species_by_trip; Type: VIEW; Schema: ros_meta; Owner: -
--

CREATE VIEW ros_meta.v_target_species_by_trip AS
 SELECT t.trip_id,
    t.trip_uid,
    t.trip_number,
    t.vessel_flag,
    t.fishing_operation_type,
    t.main_gear,
    s_t.code AS target_species_code,
    s_t.name_en AS target_species
   FROM (((ros_meta.v_trips t
     LEFT JOIN ros_meta.vessel vi ON ((t.vessel_info_id = vi.id)))
     LEFT JOIN ros_meta.vessel_licensed_target_species vi2lts ON ((vi2lts.vessel_id = vi.id)))
     LEFT JOIN refs_biology.species s_t ON (((vi2lts.licensed_target_species_code)::text = (s_t.code)::text)));


--
-- Name: v_trips_by_flag_and_gear; Type: VIEW; Schema: ros_meta; Owner: -
--

CREATE VIEW ros_meta.v_trips_by_flag_and_gear AS
 SELECT
        CASE
            WHEN (reporting_flag = ANY (ARRAY['FRA'::bpchar, 'ESP'::bpchar])) THEN (concat('EU.', reporting_flag))::bpchar
            ELSE reporting_flag
        END AS flag,
    fishing_operation_type AS gear,
    count(*) AS num_trips
   FROM ros_meta.v_trips t
  GROUP BY reporting_flag, fishing_operation_type;


--
-- Name: v_trips_by_year_and_gear; Type: VIEW; Schema: ros_meta; Owner: -
--

CREATE VIEW ros_meta.v_trips_by_year_and_gear AS
 SELECT date_part('year'::text, COALESCE(vessel_departure_date, vessel_return_date)) AS year,
    sum(
        CASE
            WHEN (fishing_operation_type = 'PS'::text) THEN 1
            ELSE 0
        END) AS ps,
    sum(
        CASE
            WHEN (fishing_operation_type = 'LL'::text) THEN 1
            ELSE 0
        END) AS ll
   FROM ros_meta.v_trips t
  GROUP BY (date_part('year'::text, COALESCE(vessel_departure_date, vessel_return_date)));


--
-- Name: vessel_seq; Type: SEQUENCE; Schema: ros_meta; Owner: -
--

ALTER TABLE ros_meta.vessel ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_meta.vessel_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: additional_catch_details_on_ssi; Type: TABLE; Schema: ros_pl; Owner: -
--

CREATE TABLE ros_pl.additional_catch_details_on_ssi (
    id integer NOT NULL,
    photo_id character varying(255),
    gear_interaction_code character(2),
    handling_method_code character(2),
    brought_on_board character varying(5),
    revival character varying(5)
);


--
-- Name: additional_catch_details_on_ssi_id_seq; Type: SEQUENCE; Schema: ros_pl; Owner: -
--

ALTER TABLE ros_pl.additional_catch_details_on_ssi ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_pl.additional_catch_details_on_ssi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: bait_fishing_event_pl_catch_detail; Type: TABLE; Schema: ros_pl; Owner: -
--

CREATE TABLE ros_pl.bait_fishing_event_pl_catch_detail (
    bait_fishing_event_id integer NOT NULL
);


--
-- Name: bait_fishing_events; Type: TABLE; Schema: ros_pl; Owner: -
--

CREATE TABLE ros_pl.bait_fishing_events (
    id integer NOT NULL,
    comments text,
    event_original_id character varying(255),
    bait_fishing_operation_id integer,
    trip_id integer NOT NULL
);


--
-- Name: bait_fishing_events_id_seq; Type: SEQUENCE; Schema: ros_pl; Owner: -
--

ALTER TABLE ros_pl.bait_fishing_events ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_pl.bait_fishing_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: bait_fishing_operations; Type: TABLE; Schema: ros_pl; Owner: -
--

CREATE TABLE ros_pl.bait_fishing_operations (
    id integer NOT NULL,
    end_event_date_and_time timestamp(6) without time zone,
    number_of_fishers integer,
    start_event_date_and_time timestamp(6) without time zone,
    start_event_latitude double precision,
    start_event_longitude double precision,
    bait_fishing_method_code character(2),
    sampling_protocol_code character(2),
    event_depth_value double precision,
    event_depth_unit character varying(3),
    CONSTRAINT ros_pl_bait_fishing_operations_event_depth_unit_check CHECK (((event_depth_unit)::text = 'm'::text))
);


--
-- Name: bait_fishing_operations_id_seq; Type: SEQUENCE; Schema: ros_pl; Owner: -
--

ALTER TABLE ros_pl.bait_fishing_operations ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_pl.bait_fishing_operations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: baits_and_conditions; Type: TABLE; Schema: ros_pl; Owner: -
--

CREATE TABLE ros_pl.baits_and_conditions (
    id integer NOT NULL,
    bait_condition_code character(2),
    species_code character varying(16)
);


--
-- Name: baits_and_conditions_id_seq; Type: SEQUENCE; Schema: ros_pl; Owner: -
--

ALTER TABLE ros_pl.baits_and_conditions ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_pl.baits_and_conditions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: catch_details; Type: TABLE; Schema: ros_pl; Owner: -
--

CREATE TABLE ros_pl.catch_details (
    id integer NOT NULL,
    comments text,
    estimated_catch_in_numbers integer,
    type_of_fate_code character(2) NOT NULL,
    estimated_weight_sampling_method_code character(2),
    fates_code character(2),
    species_code character varying(16),
    estimated_weight_value double precision,
    estimated_weight_unit character varying(3),
    estimated_weight_type_of_measurement_code character(2),
    estimated_weight_processing_type_code character(2),
    estimated_weight_method_code character(2),
    CONSTRAINT ros_pl_catch_details_estimated_weight_unit_check CHECK (((estimated_weight_unit)::text = ANY ((ARRAY['kg'::character varying, 't'::character varying])::text[])))
);


--
-- Name: catch_details_id_seq; Type: SEQUENCE; Schema: ros_pl; Owner: -
--

ALTER TABLE ros_pl.catch_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_pl.catch_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: gear_specifications; Type: TABLE; Schema: ros_pl; Owner: -
--

CREATE TABLE ros_pl.gear_specifications (
    id integer NOT NULL,
    trip_id integer NOT NULL,
    live_bait_tanks_capacity double precision,
    number_of_automatic_poles integer,
    number_of_anglers integer,
    pole_material character varying(255),
    pole_material_description text,
    hook_type_code character(3)
);


--
-- Name: gear_specifications_id_seq; Type: SEQUENCE; Schema: ros_pl; Owner: -
--

ALTER TABLE ros_pl.gear_specifications ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_pl.gear_specifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: lures_or_jiggers_by_type; Type: TABLE; Schema: ros_pl; Owner: -
--

CREATE TABLE ros_pl.lures_or_jiggers_by_type (
    id integer NOT NULL,
    lure_type character varying(255),
    make character varying(255),
    hook_type_code character(3),
    gear_specification_id integer NOT NULL
);


--
-- Name: lures_or_jiggers_by_type_id_seq; Type: SEQUENCE; Schema: ros_pl; Owner: -
--

ALTER TABLE ros_pl.lures_or_jiggers_by_type ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_pl.lures_or_jiggers_by_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: object_details; Type: TABLE; Schema: ros_pl; Owner: -
--

CREATE TABLE ros_pl.object_details (
    id integer NOT NULL,
    buoy_identifier character varying(255)
);


--
-- Name: object_details_id_seq; Type: SEQUENCE; Schema: ros_pl; Owner: -
--

ALTER TABLE ros_pl.object_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_pl.object_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: specimens; Type: TABLE; Schema: ros_pl; Owner: -
--

CREATE TABLE ros_pl.specimens (
    id integer NOT NULL,
    specimen_original_id character varying(255) NOT NULL,
    additional_catch_details_on_ssis_id integer,
    additional_specimen_details_non_target_species_id integer,
    biometric_information_id integer,
    depredation_detail_id integer,
    tag_detail_id integer,
    catch_detail_id integer NOT NULL
);


--
-- Name: specimens_id_seq; Type: SEQUENCE; Schema: ros_pl; Owner: -
--

ALTER TABLE ros_pl.specimens ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_pl.specimens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: tag_details; Type: TABLE; Schema: ros_pl; Owner: -
--

CREATE TABLE ros_pl.tag_details (
    id integer NOT NULL,
    alternate_tag_original_id character varying(255),
    tag_original_id character varying(255),
    tag_type_code character(2),
    tag_finder_id integer,
    tag_recovery character varying(5),
    tag_release character varying(5)
);


--
-- Name: tag_details_id_seq; Type: SEQUENCE; Schema: ros_pl; Owner: -
--

ALTER TABLE ros_pl.tag_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_pl.tag_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: tuna_fishing_event_pl_catch_detail; Type: TABLE; Schema: ros_pl; Owner: -
--

CREATE TABLE ros_pl.tuna_fishing_event_pl_catch_detail (
    tuna_fishing_event_id integer NOT NULL,
    catch_detail_id integer NOT NULL
);


--
-- Name: tuna_fishing_events; Type: TABLE; Schema: ros_pl; Owner: -
--

CREATE TABLE ros_pl.tuna_fishing_events (
    id integer NOT NULL,
    comments text,
    event_original_id character varying(255),
    object_detail_id integer,
    tuna_fishing_operation_id integer,
    trip_id integer NOT NULL
);


--
-- Name: tuna_fishing_events_id_seq; Type: SEQUENCE; Schema: ros_pl; Owner: -
--

ALTER TABLE ros_pl.tuna_fishing_events ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_pl.tuna_fishing_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: tuna_fishing_operations; Type: TABLE; Schema: ros_pl; Owner: -
--

CREATE TABLE ros_pl.tuna_fishing_operations (
    id integer NOT NULL,
    end_event_date_and_time timestamp(6) without time zone,
    maximum_lines_fishing_at_the_same_time integer,
    number_of_hooks_lost integer,
    start_event_date_and_time timestamp(6) without time zone,
    weight_of_bait_used double precision,
    start_event_latitude double precision,
    start_event_longitude double precision,
    bait_and_condition_id integer,
    bait_used character varying(5)
);


--
-- Name: tuna_fishing_operations_cl_school_sighting_cues; Type: TABLE; Schema: ros_pl; Owner: -
--

CREATE TABLE ros_pl.tuna_fishing_operations_cl_school_sighting_cues (
    fishing_operation_id integer NOT NULL,
    school_sighting_cue_code character(2) NOT NULL
);


--
-- Name: tuna_fishing_operations_id_seq; Type: SEQUENCE; Schema: ros_pl; Owner: -
--

ALTER TABLE ros_pl.tuna_fishing_operations ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_pl.tuna_fishing_operations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: tuna_fishing_operations_target_species; Type: TABLE; Schema: ros_pl; Owner: -
--

CREATE TABLE ros_pl.tuna_fishing_operations_target_species (
    tuna_fishing_operation_id integer NOT NULL,
    target_species_code character varying(16) NOT NULL
);


--
-- Name: additional_catch_details_on_ssi; Type: TABLE; Schema: ros_ps; Owner: -
--

CREATE TABLE ros_ps.additional_catch_details_on_ssi (
    id integer NOT NULL,
    photo_id character varying(255),
    gear_interaction_code character(2),
    handling_method_code character(2),
    brought_on_board character varying(5),
    revival character varying(5)
);


--
-- Name: catch_details_id_seq; Type: SEQUENCE; Schema: ros_ps; Owner: -
--

ALTER TABLE ros_ps.catch_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ps.catch_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: cetaceans_whale_shark_sightings; Type: TABLE; Schema: ros_ps; Owner: -
--

CREATE TABLE ros_ps.cetaceans_whale_shark_sightings (
    id integer NOT NULL,
    number_sighted integer,
    setting_operation_id integer NOT NULL,
    species_code character varying(16),
    caught_inside_the_net character varying(5),
    sighting_occurred_before_setting character varying(5)
);


--
-- Name: cetaceans_whale_shark_sightings_id_seq; Type: SEQUENCE; Schema: ros_ps; Owner: -
--

ALTER TABLE ros_ps.cetaceans_whale_shark_sightings ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ps.cetaceans_whale_shark_sightings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: fishing_events_id_seq; Type: SEQUENCE; Schema: ros_ps; Owner: -
--

ALTER TABLE ros_ps.fishing_events ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ps.fishing_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: gear_specifications; Type: TABLE; Schema: ros_ps; Owner: -
--

CREATE TABLE ros_ps.gear_specifications (
    id integer NOT NULL,
    trip_id integer NOT NULL,
    maximum_brail_capacity double precision,
    maximum_net_depth_value double precision,
    maximum_net_depth_unit character varying(3),
    maximum_net_length_value double precision,
    maximum_net_length_unit character varying(3),
    bunt_stretched_mesh_size_value double precision,
    bunt_stretched_mesh_size_unit character varying(3),
    mid_net_stretched_mesh_size_value double precision,
    mid_net_stretched_mesh_size_unit character varying(3),
    power_block character varying(5),
    purse_winch character varying(5),
    CONSTRAINT ros_ps_gear_spec_mid_net_stretched_mesh_size_unit_check CHECK (((mid_net_stretched_mesh_size_unit)::text = 'mm'::text)),
    CONSTRAINT ros_ps_gear_specifications_bunt_stretched_mesh_size_unit_check CHECK (((bunt_stretched_mesh_size_unit)::text = 'mm'::text)),
    CONSTRAINT ros_ps_gear_specifications_maximum_net_depth_unit_check CHECK (((maximum_net_depth_unit)::text = 'm'::text)),
    CONSTRAINT ros_ps_gear_specifications_maximum_net_length_unit_check CHECK (((maximum_net_length_unit)::text = ANY ((ARRAY['km'::character varying, 'm'::character varying])::text[])))
);


--
-- Name: gear_specifications_id_seq; Type: SEQUENCE; Schema: ros_ps; Owner: -
--

ALTER TABLE ros_ps.gear_specifications ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ps.gear_specifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: object_details; Type: TABLE; Schema: ros_ps; Owner: -
--

CREATE TABLE ros_ps.object_details (
    id integer NOT NULL,
    buoy_identifier character varying(255),
    fad_raft_design_code character(2),
    fad_tail_design_code character(2),
    equipped_with_artificial_lights_at_deploy character varying(5),
    equipped_with_artificial_lights_on_retrieval character varying(5)
);


--
-- Name: object_details_id_seq; Type: SEQUENCE; Schema: ros_ps; Owner: -
--

ALTER TABLE ros_ps.object_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ps.object_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ps_additional_catch_details_on_ssi_id_seq; Type: SEQUENCE; Schema: ros_ps; Owner: -
--

ALTER TABLE ros_ps.additional_catch_details_on_ssi ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ps.ps_additional_catch_details_on_ssi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: setting_operations_cl_school_sighting_cues; Type: TABLE; Schema: ros_ps; Owner: -
--

CREATE TABLE ros_ps.setting_operations_cl_school_sighting_cues (
    setting_operation_id integer NOT NULL,
    school_sighting_cue_code character(2) NOT NULL
);


--
-- Name: setting_operations_id_seq; Type: SEQUENCE; Schema: ros_ps; Owner: -
--

ALTER TABLE ros_ps.setting_operations ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ps.setting_operations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: specimens_id_seq; Type: SEQUENCE; Schema: ros_ps; Owner: -
--

ALTER TABLE ros_ps.specimens ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ps.specimens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: tag_details; Type: TABLE; Schema: ros_ps; Owner: -
--

CREATE TABLE ros_ps.tag_details (
    id integer NOT NULL,
    alternate_tag_original_id character varying(255),
    tag_original_id character varying(255),
    well integer,
    tag_type_code character(2),
    tag_finder_id integer,
    tag_recovery character varying(5),
    tag_release character varying(5)
);


--
-- Name: tag_details_id_seq; Type: SEQUENCE; Schema: ros_ps; Owner: -
--

ALTER TABLE ros_ps.tag_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ps.tag_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: v_ca; Type: VIEW; Schema: ros_rlibs; Owner: -
--

CREATE VIEW ros_rlibs.v_ca AS
 WITH ca AS (
         SELECT v_ca.year,
            v_ca.month,
            v_ca.flag,
            v_ca.gear,
                CASE
                    WHEN (v_ca.gear = 'PS'::text) THEN v_ca.grid_1
                    ELSE v_ca.grid_5
                END AS grid,
            v_ca.species,
            v_ca.fate,
            sum(((
                CASE
                    WHEN (v_ca.catch_unit = 'KG'::text) THEN 0.001
                    ELSE (1)::numeric
                END)::double precision * v_ca.observed_catch)) AS observed_catch,
                CASE
                    WHEN (v_ca.catch_unit = 'KG'::text) THEN 'MT'::text
                    ELSE v_ca.catch_unit
                END AS catch_unit
           FROM ros_analysis.v_ca
          GROUP BY v_ca.year, v_ca.month, v_ca.flag, v_ca.gear,
                CASE
                    WHEN (v_ca.gear = 'PS'::text) THEN v_ca.grid_1
                    ELSE v_ca.grid_5
                END, v_ca.species, v_ca.fate,
                CASE
                    WHEN (v_ca.catch_unit = 'KG'::text) THEN 'MT'::text
                    ELSE v_ca.catch_unit
                END
        )
 SELECT c.year,
    c.month AS month_start,
    c.month AS month_end,
    COALESCE(f.flag_code, c.flag) AS flag_code,
    COALESCE(f.fleet_code, c.flag) AS fleet_code,
    c.gear AS gear_code,
        CASE
            WHEN (c.gear = 'LL'::text) THEN 'LLO'::text
            WHEN (c.gear = 'PS'::text) THEN 'PSOT'::text
            ELSE c.gear
        END AS fishery_code,
    c.gear AS fishery_group_code,
    'IND'::text AS fishery_type_code,
    NULL::text AS catch_school_type_code,
    c.grid AS fishing_ground_code,
    s.code AS species_code,
    s.species_category_code,
    s.species_group_code,
    'WP_CODE'::text AS species_wp_code,
    s.is_iotc AS is_iotc_species,
    s.is_aggregate AS is_species_aggregate,
    s.is_ssi,
    c.observed_catch AS catch,
    c.catch_unit AS catch_unit_code,
    c.fate AS fate_code
   FROM ((ca c
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries f ON (((f.fleet_code)::text = (c.flag)::text)))
     LEFT JOIN refs_biology.species s ON (((c.species)::text = (s.code)::text)));


--
-- Name: v_ef; Type: VIEW; Schema: ros_rlibs; Owner: -
--

CREATE VIEW ros_rlibs.v_ef AS
 WITH ef AS (
         SELECT v_ef.year,
            v_ef.month,
            v_ef.flag,
            v_ef.gear,
                CASE
                    WHEN (v_ef.gear = 'PS'::text) THEN v_ef.grid_1
                    ELSE v_ef.grid_5
                END AS grid,
            sum(v_ef.observed_effort) AS effort,
            v_ef.effort_unit
           FROM ros_analysis.v_ef
          GROUP BY v_ef.year, v_ef.month, v_ef.flag, v_ef.gear,
                CASE
                    WHEN (v_ef.gear = 'PS'::text) THEN v_ef.grid_1
                    ELSE v_ef.grid_5
                END, v_ef.effort_unit
        )
 SELECT e.year,
    e.month AS month_start,
    e.month AS month_end,
    COALESCE(f.flag_code, e.flag) AS flag_code,
    COALESCE(f.fleet_code, e.flag) AS fleet_code,
    e.gear AS gear_code,
        CASE
            WHEN (e.gear = 'LL'::text) THEN 'LLO'::text
            WHEN (e.gear = 'PS'::text) THEN 'PSOT'::text
            ELSE e.gear
        END AS fishery_code,
    e.gear AS fishery_group_code,
    'IND'::text AS fishery_type_code,
    NULL::text AS effort_school_type_code,
    e.grid AS fishing_ground_code,
    e.effort,
    e.effort_unit AS effort_unit_code
   FROM (ef e
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries f ON (((f.fleet_code)::text = (e.flag)::text)));


--
-- Name: v_ce; Type: VIEW; Schema: ros_rlibs; Owner: -
--

CREATE VIEW ros_rlibs.v_ce AS
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
   FROM (ros_rlibs.v_ef e
     LEFT JOIN ros_rlibs.v_ca c ON (((e.year = c.year) AND (e.month_start = c.month_start) AND ((e.flag_code)::text = (c.flag_code)::text) AND (e.gear_code = c.gear_code) AND (e.fishing_ground_code = c.fishing_ground_code))));


--
-- Name: v_in; Type: VIEW; Schema: ros_rlibs; Owner: -
--

CREATE VIEW ros_rlibs.v_in AS
 SELECT c.year,
    c.month AS month_start,
    c.month AS month_end,
    COALESCE(f.flag_code, c.flag) AS flag_code,
    COALESCE(f.fleet_code, c.flag) AS fleet_code,
    c.gear AS gear_code,
        CASE
            WHEN (c.gear = 'LL'::text) THEN 'LLO'::text
            WHEN (c.gear = 'PS'::text) THEN 'PSOT'::text
            ELSE c.gear
        END AS fishery_code,
    c.gear AS fishery_group_code,
    'IND'::text AS fishery_type_code,
    NULL::text AS catch_school_type_code,
        CASE
            WHEN (c.gear = 'PS'::text) THEN c.grid_1
            ELSE c.grid_5
        END AS fishing_ground_code,
    s.code AS species_code,
    s.species_category_code,
    s.species_group_code,
    'WP_CODE'::text AS species_wp_code,
    s.is_iotc AS is_iotc_species,
    s.is_aggregate AS is_species_aggregate,
    s.is_ssi,
    c.num_interactions,
    c.fate_code,
    c.condition_code
   FROM ((ros_analysis.v_in c
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries f ON (((f.fleet_code)::text = (c.flag)::text)))
     LEFT JOIN refs_biology.species s ON (((c.species)::text = (s.code)::text)));


--
-- Name: v_sf; Type: VIEW; Schema: ros_rlibs; Owner: -
--

CREATE VIEW ros_rlibs.v_sf AS
 WITH sf AS (
         SELECT c_1.year,
            c_1.month AS month_start,
            c_1.month AS month_end,
            COALESCE(f.flag_code, c_1.flag) AS flag_code,
            COALESCE(f.fleet_code, c_1.flag) AS fleet_code,
            c_1.gear AS gear_code,
                CASE
                    WHEN (c_1.gear = 'LL'::text) THEN 'LLO'::text
                    WHEN (c_1.gear = 'PS'::text) THEN 'PSOT'::text
                    ELSE c_1.gear
                END AS fishery_code,
            c_1.gear AS fishery_group_code,
            'IND'::text AS fishery_type_code,
            NULL::text AS school_type_code,
                CASE
                    WHEN (c_1.gear = 'PS'::text) THEN c_1.grid_1
                    ELSE c_1.grid_5
                END AS fishing_ground_code,
            c_1.species AS species_code,
            c_1.sex AS sex_code,
            c_1.length_code AS measure_type_code,
            c_1.length_unit AS measure_unit_code,
            c_1.fate AS fate_code,
            c_1.size_bin AS class_low,
            (c_1.size_bin + (1)::double precision) AS class_high,
            c_1.num_fish AS fish_count
           FROM (ros_analysis.v_sf c_1
             LEFT JOIN refs_admin.fleet_to_flags_and_fisheries f ON (((f.fleet_code)::text = (c_1.flag)::text)))
        )
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
    s.code AS species_code,
    s.species_category_code,
    s.species_group_code,
    'WP_CODE'::text AS species_wp_code,
    s.is_iotc AS is_iotc_species,
    s.is_aggregate AS is_species_aggregate,
    s.is_ssi,
    c.sex_code,
    c.measure_type_code,
    c.measure_unit_code,
    c.fate_code,
    c.class_low,
    c.class_high,
    sum(c.fish_count) AS fish_count
   FROM (sf c
     LEFT JOIN refs_biology.species s ON (((c.species_code)::text = (s.code)::text)))
  GROUP BY c.year, c.month_start, c.month_end, c.flag_code, c.fleet_code, c.gear_code, c.fishery_code, c.fishery_group_code, c.fishery_type_code, c.school_type_code, c.fishing_ground_code, s.code, s.species_category_code, s.species_group_code, s.is_iotc, s.is_aggregate, s.is_ssi, c.sex_code, c.measure_type_code, c.measure_unit_code, c.fate_code, c.class_low, c.class_high;


--
-- Name: v_alternate_ll_effort_fdays; Type: VIEW; Schema: ros_views; Owner: -
--

CREATE VIEW ros_views.v_alternate_ll_effort_fdays AS
 SELECT 'LL'::text AS gear_code,
    date_part('year'::text, s.start_setting_date_and_time) AS year,
    date_part('month'::text, s.start_setting_date_and_time) AS month,
    s.start_setting_latitude AS lat,
    s.start_setting_longitude AS lon,
    count(DISTINCT concat(t.uid, '_', date_part('day'::text, s.start_setting_date_and_time))) AS observed_effort,
    'FDAYS'::text AS effort_unit
   FROM (((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     JOIN ros_ll.fishing_events fe ON ((fe.trip_id = t.id)))
     JOIN ros_ll.setting_operations s ON ((fe.setting_operation_id = s.id)))
  WHERE (od.vessel_type_code = 'LL'::bpchar)
  GROUP BY (date_part('year'::text, s.start_setting_date_and_time)), (date_part('month'::text, s.start_setting_date_and_time)), s.start_setting_latitude, s.start_setting_longitude;


--
-- Name: v_alternate_ll_effort_set; Type: VIEW; Schema: ros_views; Owner: -
--

CREATE VIEW ros_views.v_alternate_ll_effort_set AS
 SELECT 'LL'::text AS gear_code,
    date_part('year'::text, s.start_setting_date_and_time) AS year,
    date_part('month'::text, s.start_setting_date_and_time) AS month,
    s.start_setting_latitude AS lat,
    s.start_setting_longitude AS lon,
    count(t.*) AS observed_effort,
    'SET'::text AS effort_unit
   FROM (((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     JOIN ros_ll.fishing_events fe ON ((fe.trip_id = t.id)))
     JOIN ros_ll.setting_operations s ON ((fe.setting_operation_id = s.id)))
  WHERE (od.vessel_type_code = 'LL'::bpchar)
  GROUP BY (date_part('year'::text, s.start_setting_date_and_time)), (date_part('month'::text, s.start_setting_date_and_time)), s.start_setting_latitude, s.start_setting_longitude;


--
-- Name: v_alternate_ps_effort_fdays; Type: VIEW; Schema: ros_views; Owner: -
--

CREATE VIEW ros_views.v_alternate_ps_effort_fdays AS
 SELECT 'PS'::text AS gear_code,
    date_part('year'::text, s.start_setting_date_and_time) AS year,
    date_part('month'::text, s.start_setting_date_and_time) AS month,
    s.start_setting_latitude AS lat,
    s.start_setting_longitude AS lon,
    count(DISTINCT concat(t.uid, '_', date_part('day'::text, s.start_setting_date_and_time))) AS observed_effort,
    'FDAYS'::text AS effort_unit
   FROM (((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     JOIN ros_ps.fishing_events fe ON ((fe.trip_id = t.id)))
     JOIN ros_ps.setting_operations s ON ((fe.setting_operation_id = s.id)))
  WHERE (od.vessel_type_code = 'SP'::bpchar)
  GROUP BY (date_part('year'::text, s.start_setting_date_and_time)), (date_part('month'::text, s.start_setting_date_and_time)), s.start_setting_latitude, s.start_setting_longitude;


--
-- Name: v_alternate_ps_effort_set; Type: VIEW; Schema: ros_views; Owner: -
--

CREATE VIEW ros_views.v_alternate_ps_effort_set AS
 SELECT 'PS'::text AS gear_code,
    date_part('year'::text, s.start_setting_date_and_time) AS year,
    date_part('month'::text, s.start_setting_date_and_time) AS month,
    s.start_setting_latitude AS lat,
    s.start_setting_longitude AS lon,
    count(t.*) AS observed_effort,
    'SET'::text AS effort_unit
   FROM (((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     JOIN ros_ps.fishing_events fe ON ((fe.trip_id = t.id)))
     JOIN ros_ps.setting_operations s ON ((fe.setting_operation_id = s.id)))
  WHERE (od.vessel_type_code = 'SP'::bpchar)
  GROUP BY (date_part('year'::text, s.start_setting_date_and_time)), (date_part('month'::text, s.start_setting_date_and_time)), s.start_setting_latitude, s.start_setting_longitude;


--
-- Name: v_alternate_effort; Type: VIEW; Schema: ros_views; Owner: -
--

CREATE VIEW ros_views.v_alternate_effort AS
 SELECT v_alternate_ll_effort_set.year,
    v_alternate_ll_effort_set.month,
    v_alternate_ll_effort_set.gear_code AS gear,
    v_alternate_ll_effort_set.lat,
    v_alternate_ll_effort_set.lon,
    sum(v_alternate_ll_effort_set.observed_effort) AS observed_effort,
    v_alternate_ll_effort_set.effort_unit
   FROM ros_views.v_alternate_ll_effort_set
  GROUP BY v_alternate_ll_effort_set.year, v_alternate_ll_effort_set.month, v_alternate_ll_effort_set.gear_code, v_alternate_ll_effort_set.lat, v_alternate_ll_effort_set.lon, v_alternate_ll_effort_set.effort_unit
UNION ALL
 SELECT v_alternate_ll_effort_fdays.year,
    v_alternate_ll_effort_fdays.month,
    v_alternate_ll_effort_fdays.gear_code AS gear,
    v_alternate_ll_effort_fdays.lat,
    v_alternate_ll_effort_fdays.lon,
    sum(v_alternate_ll_effort_fdays.observed_effort) AS observed_effort,
    v_alternate_ll_effort_fdays.effort_unit
   FROM ros_views.v_alternate_ll_effort_fdays
  GROUP BY v_alternate_ll_effort_fdays.year, v_alternate_ll_effort_fdays.month, v_alternate_ll_effort_fdays.gear_code, v_alternate_ll_effort_fdays.lat, v_alternate_ll_effort_fdays.lon, v_alternate_ll_effort_fdays.effort_unit
UNION ALL
 SELECT v_alternate_ps_effort_set.year,
    v_alternate_ps_effort_set.month,
    v_alternate_ps_effort_set.gear_code AS gear,
    v_alternate_ps_effort_set.lat,
    v_alternate_ps_effort_set.lon,
    sum(v_alternate_ps_effort_set.observed_effort) AS observed_effort,
    v_alternate_ps_effort_set.effort_unit
   FROM ros_views.v_alternate_ps_effort_set
  GROUP BY v_alternate_ps_effort_set.year, v_alternate_ps_effort_set.month, v_alternate_ps_effort_set.gear_code, v_alternate_ps_effort_set.lat, v_alternate_ps_effort_set.lon, v_alternate_ps_effort_set.effort_unit
UNION ALL
 SELECT v_alternate_ps_effort_fdays.year,
    v_alternate_ps_effort_fdays.month,
    v_alternate_ps_effort_fdays.gear_code AS gear,
    v_alternate_ps_effort_fdays.lat,
    v_alternate_ps_effort_fdays.lon,
    sum(v_alternate_ps_effort_fdays.observed_effort) AS observed_effort,
    v_alternate_ps_effort_fdays.effort_unit
   FROM ros_views.v_alternate_ps_effort_fdays
  GROUP BY v_alternate_ps_effort_fdays.year, v_alternate_ps_effort_fdays.month, v_alternate_ps_effort_fdays.gear_code, v_alternate_ps_effort_fdays.lat, v_alternate_ps_effort_fdays.lon, v_alternate_ps_effort_fdays.effort_unit;


--
-- Name: v_ll_sets; Type: VIEW; Schema: ros_views; Owner: -
--

CREATE VIEW ros_views.v_ll_sets AS
 SELECT t.id AS trip_id,
    t.uid AS trip_uid,
    so.id AS set_id,
    'LL'::text AS fishing_operation_type,
    COALESCE(ho.start_hauling_date_and_time, so.start_setting_date_and_time) AS start_time,
    COALESCE(ho.end_hauling_date_and_time, so.end_setting_date_and_time) AS end_time,
        CASE
            WHEN ((ho.start_hauling_latitude IS NOT NULL) AND (ho.start_hauling_longitude IS NOT NULL)) THEN ros_meta.to_grid_1(ho.start_hauling_latitude, ho.start_hauling_longitude)
            WHEN ((ho.end_hauling_latitude IS NOT NULL) AND (ho.end_hauling_longitude IS NOT NULL)) THEN ros_meta.to_grid_1(ho.end_hauling_latitude, ho.end_hauling_longitude)
            WHEN ((so.start_setting_latitude IS NOT NULL) AND (so.start_setting_longitude IS NOT NULL)) THEN ros_meta.to_grid_1(so.start_setting_latitude, so.start_setting_longitude)
            WHEN ((so.end_setting_latitude IS NOT NULL) AND (so.end_setting_longitude IS NOT NULL)) THEN ros_meta.to_grid_1(so.end_setting_latitude, so.end_setting_longitude)
            ELSE NULL::bpchar
        END AS grid_1,
        CASE
            WHEN ((ho.start_hauling_latitude IS NOT NULL) AND (ho.start_hauling_longitude IS NOT NULL)) THEN ros_meta.to_grid_5(ho.start_hauling_latitude, ho.start_hauling_longitude)
            WHEN ((ho.end_hauling_latitude IS NOT NULL) AND (ho.end_hauling_longitude IS NOT NULL)) THEN ros_meta.to_grid_5(ho.end_hauling_latitude, ho.end_hauling_longitude)
            WHEN ((so.start_setting_latitude IS NOT NULL) AND (so.start_setting_longitude IS NOT NULL)) THEN ros_meta.to_grid_5(so.start_setting_latitude, so.start_setting_longitude)
            WHEN ((so.end_setting_latitude IS NOT NULL) AND (so.end_setting_longitude IS NOT NULL)) THEN ros_meta.to_grid_5(so.end_setting_latitude, so.end_setting_longitude)
            ELSE NULL::bpchar
        END AS grid_5,
        CASE
            WHEN ((ho.start_hauling_latitude IS NOT NULL) AND (ho.start_hauling_longitude IS NOT NULL)) THEN ho.start_hauling_latitude
            WHEN ((ho.end_hauling_latitude IS NOT NULL) AND (ho.end_hauling_longitude IS NOT NULL)) THEN ho.end_hauling_latitude
            WHEN ((so.start_setting_latitude IS NOT NULL) AND (so.start_setting_longitude IS NOT NULL)) THEN so.start_setting_latitude
            WHEN ((so.end_setting_latitude IS NOT NULL) AND (so.end_setting_longitude IS NOT NULL)) THEN so.end_setting_latitude
            ELSE NULL::double precision
        END AS latitude,
        CASE
            WHEN ((ho.start_hauling_latitude IS NOT NULL) AND (ho.start_hauling_longitude IS NOT NULL)) THEN ho.start_hauling_longitude
            WHEN ((ho.end_hauling_latitude IS NOT NULL) AND (ho.end_hauling_longitude IS NOT NULL)) THEN ho.end_hauling_longitude
            WHEN ((so.start_setting_latitude IS NOT NULL) AND (so.start_setting_longitude IS NOT NULL)) THEN so.start_setting_longitude
            WHEN ((so.end_setting_latitude IS NOT NULL) AND (so.end_setting_longitude IS NOT NULL)) THEN so.end_setting_longitude
            ELSE NULL::double precision
        END AS longitude,
    COALESCE(ho.number_of_hooks_observed, so.total_number_of_hooks_set) AS effort,
    COALESCE(so.total_number_of_hooks_set, ho.number_of_hooks_observed) AS total_effort,
    'HK'::text AS effort_unit
   FROM ((((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     JOIN ros_ll.fishing_events fed ON ((fed.trip_id = t.id)))
     JOIN ros_ll.setting_operations so ON ((fed.setting_operation_id = so.id)))
     LEFT JOIN ros_ll.hauling_operations ho ON ((fed.hauling_operation_id = ho.id)))
  WHERE (od.vessel_type_code = 'LL'::bpchar);


--
-- Name: v_ps_lw_raw; Type: VIEW; Schema: ros_views; Owner: -
--

CREATE VIEW ros_views.v_ps_lw_raw AS
 SELECT 'PS'::text AS operation_type,
        CASE
            WHEN (fa.code ~~ 'R%'::text) THEN 'RC'::text
            WHEN (fa.code ~~ 'D%'::text) THEN 'DI'::text
            ELSE 'UN'::text
        END AS "TYPE",
    s.id AS set_id,
    sp.code AS species_code,
    sp.name_en AS species_name,
    COALESCE(x.code, 'UNK'::bpchar) AS sex_code,
    COALESCE(x.name_en, 'Unknown'::character varying) AS sex,
        CASE
            WHEN ((lt.code IS NULL) AND (bs.measured_length_value IS NOT NULL)) THEN 'UNK'::bpchar
            ELSE lt.code
        END AS length_type_code,
        CASE
            WHEN ((lt.name_en IS NULL) AND (bs.measured_length_value IS NOT NULL)) THEN 'Unknown'::character varying
            ELSE lt.name_en
        END AS length_type,
    bs.measured_length_value AS length,
    NULL::text AS additional_length_type_code,
    NULL::text AS additional_length_type,
    NULL::text AS additional_length,
        CASE
            WHEN ((wp.code IS NULL) AND (bs.estimated_weight_value IS NOT NULL)) THEN 'UNK'::bpchar
            ELSE wp.code
        END AS weight_type_code,
        CASE
            WHEN ((wp.name_en IS NULL) AND (bs.estimated_weight_value IS NOT NULL)) THEN 'Unknown'::character varying
            ELSE wp.name_en
        END AS weight_type,
    bs.estimated_weight_value AS weight_value,
    bs.estimated_weight_unit AS weight_unit
   FROM (((((((((((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     JOIN ros_ll.fishing_events fe ON ((fe.trip_id = t.id)))
     JOIN ros_ps.setting_operations s ON ((fe.setting_operation_id = s.id)))
     JOIN ros_ps.catch_details c ON ((c.fishing_event_id = fe.id)))
     JOIN refs_biology.species sp ON (((c.species_code)::text = (sp.code)::text)))
     LEFT JOIN refs_biology.fates fa ON ((c.fates_code = fa.code)))
     JOIN ros_ps.specimens spc ON ((spc.catch_detail_id = c.id)))
     JOIN ros_common.biometric_information bs ON ((spc.biometric_information_id = bs.id)))
     LEFT JOIN refs_biology.sex x ON ((bs.sex_code = x.code)))
     LEFT JOIN refs_biology.measurements lt ON ((bs.measured_length_measured_length_type_code = lt.code)))
     LEFT JOIN refs_fishery.fish_processing_types wp ON ((bs.estimated_weight_method_code = wp.code)))
  WHERE ((od.vessel_type_code = 'SP'::bpchar) AND ((bs.measured_length_value IS NOT NULL) OR (bs.estimated_weight_value IS NOT NULL)));


--
-- Name: v_ps_lw; Type: VIEW; Schema: ros_views; Owner: -
--

CREATE VIEW ros_views.v_ps_lw AS
 SELECT date_part('year'::text, s.start_setting_date_and_time) AS year,
    date_part('month'::text, s.start_setting_date_and_time) AS month,
    lw.operation_type AS gear,
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
    lw.weight_value AS weight,
    lw.weight_unit
   FROM (ros_views.v_ps_lw_raw lw
     JOIN ros_ps.setting_operations s ON ((lw.set_id = s.id)));


--
-- Name: v_ps_sets; Type: VIEW; Schema: ros_views; Owner: -
--

CREATE VIEW ros_views.v_ps_sets AS
 SELECT t.id AS trip_id,
    t.uid AS trip_uid,
    so.id AS set_id,
    'PS'::text AS fishing_operation_type,
    COALESCE(so.start_setting_date_and_time, so.time_start_brailing) AS start_time,
    COALESCE(so.time_start_brailing, so.time_net_pursed) AS end_time,
    ros_meta.to_grid_1(so.start_setting_latitude, so.start_setting_longitude) AS grid_1,
    ros_meta.to_grid_5(so.start_setting_latitude, so.start_setting_longitude) AS grid_5,
    so.start_setting_latitude AS latitude,
    so.start_setting_longitude AS longitude,
    1 AS effort,
    1 AS total_effort,
    'SETS'::text AS effort_unit
   FROM (((ros_common.observation_dataset od
     JOIN ros_common.trip t ON ((od.id = t.observation_dataset_id)))
     JOIN ros_ps.fishing_events fed ON ((fed.trip_id = t.id)))
     LEFT JOIN ros_ps.setting_operations so ON ((fed.setting_operation_id = so.id)))
  WHERE (od.vessel_type_code = 'SP'::bpchar);


--
-- Name: v_ps_sf; Type: VIEW; Schema: ros_views; Owner: -
--

CREATE VIEW ros_views.v_ps_sf AS
 SELECT 'PS'::text AS operation_type,
    date_part('year'::text, so.start_setting_date_and_time) AS year,
    date_part('month'::text, so.start_setting_date_and_time) AS month,
    ros_meta.to_grid_1(so.start_setting_latitude, so.start_setting_longitude) AS grid_1,
    ros_meta.to_grid_5(so.start_setting_latitude, so.start_setting_longitude) AS grid_5,
        CASE
            WHEN (f.code ~~ 'R%'::text) THEN 'RC'::text
            ELSE 'DI'::text
        END AS "TYPE",
    s.code AS species_code,
    COALESCE(x.code, 'UNK'::bpchar) AS sex_code,
    COALESCE(lt.code, 'UNK'::bpchar) AS length_type,
    b.measured_length_value AS length,
    count(*) AS num
   FROM ((((((((ros_ps.fishing_events fe
     JOIN ros_ps.setting_operations so ON ((fe.setting_operation_id = so.id)))
     JOIN ros_ps.catch_details c ON ((c.fishing_event_id = fe.id)))
     JOIN refs_biology.species s ON (((c.species_code)::text = (s.code)::text)))
     JOIN refs_biology.fates f ON ((c.fates_code = f.code)))
     JOIN ros_ps.specimens sp ON ((sp.catch_detail_id = c.id)))
     JOIN ros_common.biometric_information b ON ((sp.biometric_information_id = b.id)))
     LEFT JOIN refs_biology.measurements lt ON ((b.measured_length_measured_length_type_code = lt.code)))
     LEFT JOIN refs_biology.sex x ON ((b.sex_code = x.code)))
  GROUP BY (date_part('year'::text, so.start_setting_date_and_time)), (date_part('month'::text, so.start_setting_date_and_time)), (ros_meta.to_grid_1(so.start_setting_latitude, so.start_setting_longitude)), (ros_meta.to_grid_5(so.start_setting_latitude, so.start_setting_longitude)),
        CASE
            WHEN (f.code ~~ 'R%'::text) THEN 'RC'::text
            ELSE 'DI'::text
        END, s.code, x.code, lt.code, b.measured_length_value;


--
-- Name: v_sets; Type: VIEW; Schema: ros_views; Owner: -
--

CREATE VIEW ros_views.v_sets AS
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


--
-- Name: additional_details_on_non_target_species additional_details_on_non_target_species_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.additional_details_on_non_target_species
    ADD CONSTRAINT additional_details_on_non_target_species_pkey PRIMARY KEY (id);


--
-- Name: biometric_information biometric_information_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.biometric_information
    ADD CONSTRAINT biometric_information_pkey PRIMARY KEY (id);


--
-- Name: trip_daily_activities common_trip_daily_activities_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_daily_activities
    ADD CONSTRAINT common_trip_daily_activities_pkey PRIMARY KEY (id);


--
-- Name: depredation_details depredation_details_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.depredation_details
    ADD CONSTRAINT depredation_details_pkey PRIMARY KEY (id);


--
-- Name: trip pk_ros_common_trip; Type: CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip
    ADD CONSTRAINT pk_ros_common_trip PRIMARY KEY (id);


--
-- Name: trip_observer pk_ros_common_trip_observer; Type: CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_observer
    ADD CONSTRAINT pk_ros_common_trip_observer PRIMARY KEY (trip_id);


--
-- Name: trip_vessel pk_ros_common_trip_vessel; Type: CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_vessel
    ADD CONSTRAINT pk_ros_common_trip_vessel PRIMARY KEY (trip_id);


--
-- Name: trip_vessel_fish_preservation_method pk_ros_common_trip_vessel_fish_preservation_method; Type: CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_vessel_fish_preservation_method
    ADD CONSTRAINT pk_ros_common_trip_vessel_fish_preservation_method PRIMARY KEY (trip_id, fish_preservation_method_code);


--
-- Name: trip_vessel_fish_storage_type pk_ros_common_trip_vessel_fish_storage_type; Type: CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_vessel_fish_storage_type
    ADD CONSTRAINT pk_ros_common_trip_vessel_fish_storage_type PRIMARY KEY (trip_id, fish_storage_type_code);


--
-- Name: trip_reasons_for_days_lost reasons_for_days_lost_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_reasons_for_days_lost
    ADD CONSTRAINT reasons_for_days_lost_pkey PRIMARY KEY (id);


--
-- Name: observation_dataset ros_common_observer_data_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.observation_dataset
    ADD CONSTRAINT ros_common_observer_data_pkey PRIMARY KEY (id);


--
-- Name: trip_daily_activity_details trip_daily_activity_details_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_daily_activity_details
    ADD CONSTRAINT trip_daily_activity_details_pkey PRIMARY KEY (id);


--
-- Name: trip_waste_managements waste_managements_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_waste_managements
    ADD CONSTRAINT waste_managements_pkey PRIMARY KEY (id);


--
-- Name: gillnet_configuration gillnet_configuration_pkey; Type: CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.gillnet_configuration
    ADD CONSTRAINT gillnet_configuration_pkey PRIMARY KEY (id);


--
-- Name: additional_catch_details_on_ssi gn_additional_catch_details_on_ssi_pkey; Type: CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.additional_catch_details_on_ssi
    ADD CONSTRAINT gn_additional_catch_details_on_ssi_pkey PRIMARY KEY (id);


--
-- Name: catch_details gn_catch_details_pkey; Type: CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.catch_details
    ADD CONSTRAINT gn_catch_details_pkey PRIMARY KEY (id);


--
-- Name: fishing_events gn_fishing_events_pkey; Type: CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.fishing_events
    ADD CONSTRAINT gn_fishing_events_pkey PRIMARY KEY (id);


--
-- Name: gear_specifications gn_gear_specifications_pkey; Type: CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.gear_specifications
    ADD CONSTRAINT gn_gear_specifications_pkey PRIMARY KEY (id);


--
-- Name: hauling_operations gn_hauling_operations_pkey; Type: CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.hauling_operations
    ADD CONSTRAINT gn_hauling_operations_pkey PRIMARY KEY (id);


--
-- Name: mitigation_measures gn_mitigation_measures_pkey; Type: CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.mitigation_measures
    ADD CONSTRAINT gn_mitigation_measures_pkey PRIMARY KEY (id);


--
-- Name: setting_operations gn_setting_operations_pkey; Type: CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.setting_operations
    ADD CONSTRAINT gn_setting_operations_pkey PRIMARY KEY (id);


--
-- Name: specimens gn_specimens_pkey; Type: CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.specimens
    ADD CONSTRAINT gn_specimens_pkey PRIMARY KEY (id);


--
-- Name: tag_details gn_tag_details_pkey; Type: CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.tag_details
    ADD CONSTRAINT gn_tag_details_pkey PRIMARY KEY (id);


--
-- Name: sinkers_by_type sinkers_by_type_pkey; Type: CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.sinkers_by_type
    ADD CONSTRAINT sinkers_by_type_pkey PRIMARY KEY (id);


--
-- Name: baits_by_conditions baits_by_conditions_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.baits_by_conditions
    ADD CONSTRAINT baits_by_conditions_pkey PRIMARY KEY (id);


--
-- Name: biteoffs_by_branchlines_set biteoffs_by_branchlines_set_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.biteoffs_by_branchlines_set
    ADD CONSTRAINT biteoffs_by_branchlines_set_pkey PRIMARY KEY (id);


--
-- Name: branchline_configurations branchline_configurations_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.branchline_configurations
    ADD CONSTRAINT branchline_configurations_pkey PRIMARY KEY (id);


--
-- Name: branchline_sections branchline_sections_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.branchline_sections
    ADD CONSTRAINT branchline_sections_pkey PRIMARY KEY (id);


--
-- Name: branchlines_set branchlines_set_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.branchlines_set
    ADD CONSTRAINT branchlines_set_pkey PRIMARY KEY (id);


--
-- Name: floatlines floatlines_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.floatlines
    ADD CONSTRAINT floatlines_pkey PRIMARY KEY (id);


--
-- Name: hooks_by_type hooks_by_type_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.hooks_by_type
    ADD CONSTRAINT hooks_by_type_pkey PRIMARY KEY (id);


--
-- Name: lights_by_type_and_colour lights_by_type_and_colour_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.lights_by_type_and_colour
    ADD CONSTRAINT lights_by_type_and_colour_pkey PRIMARY KEY (id);


--
-- Name: additional_catch_details_on_ssi ll_additional_catch_details_on_ssi_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.additional_catch_details_on_ssi
    ADD CONSTRAINT ll_additional_catch_details_on_ssi_pkey PRIMARY KEY (id);


--
-- Name: branchline_configurations_storage ll_branchline_configurations_storage_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.branchline_configurations_storage
    ADD CONSTRAINT ll_branchline_configurations_storage_pkey PRIMARY KEY (branchline_configuration_id, branchline_storage_code);


--
-- Name: catch_details ll_catch_details_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.catch_details
    ADD CONSTRAINT ll_catch_details_pkey PRIMARY KEY (id);


--
-- Name: fishing_events ll_fishing_events_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.fishing_events
    ADD CONSTRAINT ll_fishing_events_pkey PRIMARY KEY (id);


--
-- Name: gear_specifications ll_gear_specifications_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.gear_specifications
    ADD CONSTRAINT ll_gear_specifications_pkey PRIMARY KEY (id);


--
-- Name: hauling_operations ll_hauling_operations_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.hauling_operations
    ADD CONSTRAINT ll_hauling_operations_pkey PRIMARY KEY (id);


--
-- Name: leader_set ll_leader_set_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.leader_set
    ADD CONSTRAINT ll_leader_set_pkey PRIMARY KEY (id);


--
-- Name: mitigation_measures ll_mitigation_measures_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.mitigation_measures
    ADD CONSTRAINT ll_mitigation_measures_pkey PRIMARY KEY (id);


--
-- Name: setting_operations ll_setting_operations_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.setting_operations
    ADD CONSTRAINT ll_setting_operations_pkey PRIMARY KEY (id);


--
-- Name: specimens ll_specimens_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.specimens
    ADD CONSTRAINT ll_specimens_pkey PRIMARY KEY (id);


--
-- Name: tag_details ll_tag_details_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.tag_details
    ADD CONSTRAINT ll_tag_details_pkey PRIMARY KEY (id);


--
-- Name: tori_line_details tori_line_details_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.tori_line_details
    ADD CONSTRAINT tori_line_details_pkey PRIMARY KEY (id);


--
-- Name: contact pk_ros_meta_contact; Type: CONSTRAINT; Schema: ros_meta; Owner: -
--

ALTER TABLE ONLY ros_meta.contact
    ADD CONSTRAINT pk_ros_meta_contact PRIMARY KEY (id);


--
-- Name: focal_point pk_ros_meta_focal_point; Type: CONSTRAINT; Schema: ros_meta; Owner: -
--

ALTER TABLE ONLY ros_meta.focal_point
    ADD CONSTRAINT pk_ros_meta_focal_point PRIMARY KEY (contact_id);


--
-- Name: observer pk_ros_meta_observer; Type: CONSTRAINT; Schema: ros_meta; Owner: -
--

ALTER TABLE ONLY ros_meta.observer
    ADD CONSTRAINT pk_ros_meta_observer PRIMARY KEY (contact_id);


--
-- Name: vessel pk_ros_meta_vessel_pkey; Type: CONSTRAINT; Schema: ros_meta; Owner: -
--

ALTER TABLE ONLY ros_meta.vessel
    ADD CONSTRAINT pk_ros_meta_vessel_pkey PRIMARY KEY (id);


--
-- Name: observer_identifier_mapping ros_meta_observer_identifier_mapping_pkey; Type: CONSTRAINT; Schema: ros_meta; Owner: -
--

ALTER TABLE ONLY ros_meta.observer_identifier_mapping
    ADD CONSTRAINT ros_meta_observer_identifier_mapping_pkey PRIMARY KEY (legacy_iotc_observer_identifier);


--
-- Name: observer_identifier_mapping ros_meta_observer_identifier_mapping_uk; Type: CONSTRAINT; Schema: ros_meta; Owner: -
--

ALTER TABLE ONLY ros_meta.observer_identifier_mapping
    ADD CONSTRAINT ros_meta_observer_identifier_mapping_uk UNIQUE (legacy_iotc_observer_identifier, iotc_observer_identifier);


--
-- Name: focal_point uk_ros_meta_focal_point_email; Type: CONSTRAINT; Schema: ros_meta; Owner: -
--

ALTER TABLE ONLY ros_meta.focal_point
    ADD CONSTRAINT uk_ros_meta_focal_point_email UNIQUE (email);


--
-- Name: contact uk_ros_meta_full_name_contact; Type: CONSTRAINT; Schema: ros_meta; Owner: -
--

ALTER TABLE ONLY ros_meta.contact
    ADD CONSTRAINT uk_ros_meta_full_name_contact UNIQUE (full_name);


--
-- Name: observer uk_ros_meta_iotc_observer_identifier_observer; Type: CONSTRAINT; Schema: ros_meta; Owner: -
--

ALTER TABLE ONLY ros_meta.observer
    ADD CONSTRAINT uk_ros_meta_iotc_observer_identifier_observer UNIQUE (iotc_observer_identifier);


--
-- Name: observer_accreditation uk_ros_meta_observer_accreditation; Type: CONSTRAINT; Schema: ros_meta; Owner: -
--

ALTER TABLE ONLY ros_meta.observer_accreditation
    ADD CONSTRAINT uk_ros_meta_observer_accreditation UNIQUE (observer_id, accreditation_year, accredited_by);


--
-- Name: vessel uk_ros_meta_vessel_imo_identifier; Type: CONSTRAINT; Schema: ros_meta; Owner: -
--

ALTER TABLE ONLY ros_meta.vessel
    ADD CONSTRAINT uk_ros_meta_vessel_imo_identifier UNIQUE (imo_identifier);


--
-- Name: vessel uk_ros_meta_vessel_iotc_observer_identifier; Type: CONSTRAINT; Schema: ros_meta; Owner: -
--

ALTER TABLE ONLY ros_meta.vessel
    ADD CONSTRAINT uk_ros_meta_vessel_iotc_observer_identifier UNIQUE (iotc_vessel_identifier);


--
-- Name: vessel uk_ros_meta_vessel_ircs_identifier; Type: CONSTRAINT; Schema: ros_meta; Owner: -
--

ALTER TABLE ONLY ros_meta.vessel
    ADD CONSTRAINT uk_ros_meta_vessel_ircs_identifier UNIQUE (ircs_identifier);


--
-- Name: vessel uk_ros_meta_vessel_registration_identifier; Type: CONSTRAINT; Schema: ros_meta; Owner: -
--

ALTER TABLE ONLY ros_meta.vessel
    ADD CONSTRAINT uk_ros_meta_vessel_registration_identifier UNIQUE (registration_identifier);


--
-- Name: vessel vessel_vessel_name_key; Type: CONSTRAINT; Schema: ros_meta; Owner: -
--

ALTER TABLE ONLY ros_meta.vessel
    ADD CONSTRAINT vessel_vessel_name_key UNIQUE (vessel_name);


--
-- Name: bait_fishing_events bait_fishing_events_pkey; Type: CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.bait_fishing_events
    ADD CONSTRAINT bait_fishing_events_pkey PRIMARY KEY (id);


--
-- Name: bait_fishing_operations bait_fishing_operations_pkey; Type: CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.bait_fishing_operations
    ADD CONSTRAINT bait_fishing_operations_pkey PRIMARY KEY (id);


--
-- Name: baits_and_conditions baits_and_conditions_pkey; Type: CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.baits_and_conditions
    ADD CONSTRAINT baits_and_conditions_pkey PRIMARY KEY (id);


--
-- Name: lures_or_jiggers_by_type lures_or_jiggers_by_type_pkey; Type: CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.lures_or_jiggers_by_type
    ADD CONSTRAINT lures_or_jiggers_by_type_pkey PRIMARY KEY (id);


--
-- Name: additional_catch_details_on_ssi pl_additional_catch_details_on_ssi_pkey; Type: CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.additional_catch_details_on_ssi
    ADD CONSTRAINT pl_additional_catch_details_on_ssi_pkey PRIMARY KEY (id);


--
-- Name: catch_details pl_catch_details_pkey; Type: CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.catch_details
    ADD CONSTRAINT pl_catch_details_pkey PRIMARY KEY (id);


--
-- Name: gear_specifications pl_gear_specifications_pkey; Type: CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.gear_specifications
    ADD CONSTRAINT pl_gear_specifications_pkey PRIMARY KEY (id);


--
-- Name: object_details pl_object_details_pkey; Type: CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.object_details
    ADD CONSTRAINT pl_object_details_pkey PRIMARY KEY (id);


--
-- Name: specimens pl_specimens_pkey; Type: CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.specimens
    ADD CONSTRAINT pl_specimens_pkey PRIMARY KEY (id);


--
-- Name: tag_details pl_tag_details_pkey; Type: CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.tag_details
    ADD CONSTRAINT pl_tag_details_pkey PRIMARY KEY (id);


--
-- Name: tuna_fishing_event_pl_catch_detail pl_tuna_fishing_event_pl_catch_detail_pkey; Type: CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.tuna_fishing_event_pl_catch_detail
    ADD CONSTRAINT pl_tuna_fishing_event_pl_catch_detail_pkey PRIMARY KEY (tuna_fishing_event_id, catch_detail_id);


--
-- Name: tuna_fishing_operations pl_tuna_fishing_operations_pkey; Type: CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.tuna_fishing_operations
    ADD CONSTRAINT pl_tuna_fishing_operations_pkey PRIMARY KEY (id);


--
-- Name: tuna_fishing_events tuna_fishing_events_pkey; Type: CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.tuna_fishing_events
    ADD CONSTRAINT tuna_fishing_events_pkey PRIMARY KEY (id);


--
-- Name: cetaceans_whale_shark_sightings cetaceans_whale_shark_sightings_pkey; Type: CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.cetaceans_whale_shark_sightings
    ADD CONSTRAINT cetaceans_whale_shark_sightings_pkey PRIMARY KEY (id);


--
-- Name: additional_catch_details_on_ssi ps_additional_catch_details_on_ssi_pkey; Type: CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.additional_catch_details_on_ssi
    ADD CONSTRAINT ps_additional_catch_details_on_ssi_pkey PRIMARY KEY (id);


--
-- Name: catch_details ps_catch_details_pkey; Type: CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.catch_details
    ADD CONSTRAINT ps_catch_details_pkey PRIMARY KEY (id);


--
-- Name: fishing_events ps_fishing_events_pkey; Type: CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.fishing_events
    ADD CONSTRAINT ps_fishing_events_pkey PRIMARY KEY (id);


--
-- Name: gear_specifications ps_gear_specifications_pkey; Type: CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.gear_specifications
    ADD CONSTRAINT ps_gear_specifications_pkey PRIMARY KEY (id);


--
-- Name: object_details ps_object_details_pkey; Type: CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.object_details
    ADD CONSTRAINT ps_object_details_pkey PRIMARY KEY (id);


--
-- Name: setting_operations ps_setting_operations_pkey; Type: CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.setting_operations
    ADD CONSTRAINT ps_setting_operations_pkey PRIMARY KEY (id);


--
-- Name: specimens ps_specimens_pkey; Type: CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.specimens
    ADD CONSTRAINT ps_specimens_pkey PRIMARY KEY (id);


--
-- Name: tag_details ps_tag_details_pkey; Type: CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.tag_details
    ADD CONSTRAINT ps_tag_details_pkey PRIMARY KEY (id);


--
-- Name: idx_ros_common_trip_id; Type: INDEX; Schema: ros_common; Owner: -
--

CREATE INDEX idx_ros_common_trip_id ON ros_common.trip USING btree (id);


--
-- Name: idx_ros_common_trip_observer_data; Type: INDEX; Schema: ros_common; Owner: -
--

CREATE INDEX idx_ros_common_trip_observer_data ON ros_common.trip USING btree (observation_dataset_id);


--
-- Name: idx_ros_common_waste_managements_trip_id; Type: INDEX; Schema: ros_common; Owner: -
--

CREATE INDEX idx_ros_common_waste_managements_trip_id ON ros_common.trip_waste_managements USING btree (trip_id);


--
-- Name: idx_ros_gn_fishing_events_trip; Type: INDEX; Schema: ros_common; Owner: -
--

CREATE INDEX idx_ros_gn_fishing_events_trip ON ros_common.trip USING btree (id);


--
-- Name: idx_ros_gn_gear_specifications_trip; Type: INDEX; Schema: ros_common; Owner: -
--

CREATE INDEX idx_ros_gn_gear_specifications_trip ON ros_common.trip USING btree (id);


--
-- Name: idx_ros_ll_fishing_events_trip; Type: INDEX; Schema: ros_common; Owner: -
--

CREATE INDEX idx_ros_ll_fishing_events_trip ON ros_common.trip USING btree (id);


--
-- Name: idx_ros_ll_gear_specifications_trip; Type: INDEX; Schema: ros_common; Owner: -
--

CREATE INDEX idx_ros_ll_gear_specifications_trip ON ros_common.trip USING btree (id);


--
-- Name: idx_ros_pl_bait_fishing_events_trip; Type: INDEX; Schema: ros_common; Owner: -
--

CREATE INDEX idx_ros_pl_bait_fishing_events_trip ON ros_common.trip USING btree (id);


--
-- Name: idx_ros_pl_gear_specifications_trip; Type: INDEX; Schema: ros_common; Owner: -
--

CREATE INDEX idx_ros_pl_gear_specifications_trip ON ros_common.trip USING btree (id);


--
-- Name: idx_ros_pl_tuna_fishing_events_trip; Type: INDEX; Schema: ros_common; Owner: -
--

CREATE INDEX idx_ros_pl_tuna_fishing_events_trip ON ros_common.trip USING btree (id);


--
-- Name: idx_ros_ps_fishing_events_trip; Type: INDEX; Schema: ros_common; Owner: -
--

CREATE INDEX idx_ros_ps_fishing_events_trip ON ros_common.trip USING btree (id);


--
-- Name: idx_ros_ps_gear_specifications_trip; Type: INDEX; Schema: ros_common; Owner: -
--

CREATE INDEX idx_ros_ps_gear_specifications_trip ON ros_common.trip USING btree (id);


--
-- Name: index_common_observation_dataset_reporting_entity_code; Type: INDEX; Schema: ros_common; Owner: -
--

CREATE INDEX index_common_observation_dataset_reporting_entity_code ON ros_common.observation_dataset USING btree (reporting_country_code);


--
-- Name: index_common_observation_dataset_reporting_source; Type: INDEX; Schema: ros_common; Owner: -
--

CREATE INDEX index_common_observation_dataset_reporting_source ON ros_common.observation_dataset USING btree (reporting_source_dataset_code, reporting_source_code);


--
-- Name: index_common_observer_data_reporting_country_code; Type: INDEX; Schema: ros_common; Owner: -
--

CREATE INDEX index_common_observer_data_reporting_country_code ON ros_common.observation_dataset USING btree (reporting_country_code);


--
-- Name: index_common_observer_data_vessel_type_code; Type: INDEX; Schema: ros_common; Owner: -
--

CREATE INDEX index_common_observer_data_vessel_type_code ON ros_common.observation_dataset USING btree (vessel_type_code);


--
-- Name: index_common_trip_daily_activities_trip_id; Type: INDEX; Schema: ros_common; Owner: -
--

CREATE INDEX index_common_trip_daily_activities_trip_id ON ros_common.trip_daily_activities USING btree (trip_id);


--
-- Name: index_observer_data_submitter_id; Type: INDEX; Schema: ros_common; Owner: -
--

CREATE INDEX index_observer_data_submitter_id ON ros_common.observation_dataset USING btree (submitter_id);


--
-- Name: index_trip_observer_observer_id; Type: INDEX; Schema: ros_common; Owner: -
--

CREATE INDEX index_trip_observer_observer_id ON ros_common.trip_observer USING btree (observer_id);


--
-- Name: index_trip_vessel_fish_preservation_method; Type: INDEX; Schema: ros_common; Owner: -
--

CREATE INDEX index_trip_vessel_fish_preservation_method ON ros_common.trip_vessel_fish_preservation_method USING btree (trip_id, fish_preservation_method_code);


--
-- Name: index_trip_vessel_fish_storage_type; Type: INDEX; Schema: ros_common; Owner: -
--

CREATE INDEX index_trip_vessel_fish_storage_type ON ros_common.trip_vessel_fish_storage_type USING btree (trip_id, fish_storage_type_code);


--
-- Name: index_trip_vessel_fishing_master_id; Type: INDEX; Schema: ros_common; Owner: -
--

CREATE INDEX index_trip_vessel_fishing_master_id ON ros_common.trip_vessel USING btree (fishing_master_id);


--
-- Name: index_trip_vessel_hull_material_code; Type: INDEX; Schema: ros_common; Owner: -
--

CREATE INDEX index_trip_vessel_hull_material_code ON ros_common.trip_vessel USING btree (hull_material_code);


--
-- Name: index_trip_vessel_skipper_id; Type: INDEX; Schema: ros_common; Owner: -
--

CREATE INDEX index_trip_vessel_skipper_id ON ros_common.trip_vessel USING btree (skipper_id);


--
-- Name: index_trip_vessel_vessel_id; Type: INDEX; Schema: ros_common; Owner: -
--

CREATE INDEX index_trip_vessel_vessel_id ON ros_common.trip_vessel USING btree (vessel_id);


--
-- Name: index_gillnet_configuration_gillnet_configuration_id; Type: INDEX; Schema: ros_gn; Owner: -
--

CREATE INDEX index_gillnet_configuration_gillnet_configuration_id ON ros_gn.gillnet_configuration USING btree (gillnet_configuration_id);


--
-- Name: index_gn_catch_details_gn_fishing_event_id; Type: INDEX; Schema: ros_gn; Owner: -
--

CREATE INDEX index_gn_catch_details_gn_fishing_event_id ON ros_gn.catch_details USING btree (fishing_event_id);


--
-- Name: index_gn_fishing_events_gn_hauling_operation_id; Type: INDEX; Schema: ros_gn; Owner: -
--

CREATE INDEX index_gn_fishing_events_gn_hauling_operation_id ON ros_gn.fishing_events USING btree (hauling_operation_id);


--
-- Name: index_gn_fishing_events_gn_mitigation_measure_id; Type: INDEX; Schema: ros_gn; Owner: -
--

CREATE INDEX index_gn_fishing_events_gn_mitigation_measure_id ON ros_gn.fishing_events USING btree (mitigation_measure_id);


--
-- Name: index_gn_fishing_events_gn_setting_operation_id; Type: INDEX; Schema: ros_gn; Owner: -
--

CREATE INDEX index_gn_fishing_events_gn_setting_operation_id ON ros_gn.fishing_events USING btree (setting_operation_id);


--
-- Name: index_gn_specimens_additional_non_target_species_id; Type: INDEX; Schema: ros_gn; Owner: -
--

CREATE INDEX index_gn_specimens_additional_non_target_species_id ON ros_gn.specimens USING btree (additional_specimen_details_non_target_species_id);


--
-- Name: index_gn_specimens_biometric_information_id; Type: INDEX; Schema: ros_gn; Owner: -
--

CREATE INDEX index_gn_specimens_biometric_information_id ON ros_gn.specimens USING btree (biometric_information_id);


--
-- Name: index_gn_specimens_gn_additional_catch_details_on_ssis_id; Type: INDEX; Schema: ros_gn; Owner: -
--

CREATE INDEX index_gn_specimens_gn_additional_catch_details_on_ssis_id ON ros_gn.specimens USING btree (additional_catch_details_on_ssis_id);


--
-- Name: index_gn_specimens_gn_depredation_detail_id; Type: INDEX; Schema: ros_gn; Owner: -
--

CREATE INDEX index_gn_specimens_gn_depredation_detail_id ON ros_gn.specimens USING btree (depredation_detail_id);


--
-- Name: index_gn_specimens_gn_tag_detail_id; Type: INDEX; Schema: ros_gn; Owner: -
--

CREATE INDEX index_gn_specimens_gn_tag_detail_id ON ros_gn.specimens USING btree (tag_detail_id);


--
-- Name: index_sinkers_by_type_gn_gillnet_configuration_id; Type: INDEX; Schema: ros_gn; Owner: -
--

CREATE INDEX index_sinkers_by_type_gn_gillnet_configuration_id ON ros_gn.sinkers_by_type USING btree (gillnet_configuration_id);


--
-- Name: index_tag_details_tag_finder_id; Type: INDEX; Schema: ros_gn; Owner: -
--

CREATE INDEX index_tag_details_tag_finder_id ON ros_gn.tag_details USING btree (tag_finder_id);


--
-- Name: index_biteoffs_by_branchlines_set_ll_hauling_operation_id; Type: INDEX; Schema: ros_ll; Owner: -
--

CREATE INDEX index_biteoffs_by_branchlines_set_ll_hauling_operation_id ON ros_ll.biteoffs_by_branchlines_set USING btree (hauling_operation_id);


--
-- Name: index_branchline_configurations_ll_gear_specifications_id; Type: INDEX; Schema: ros_ll; Owner: -
--

CREATE INDEX index_branchline_configurations_ll_gear_specifications_id ON ros_ll.branchline_configurations USING btree (gear_specification_id);


--
-- Name: index_branchline_sections_branchline_configuration_id; Type: INDEX; Schema: ros_ll; Owner: -
--

CREATE INDEX index_branchline_sections_branchline_configuration_id ON ros_ll.branchline_sections USING btree (branchline_configuration_id);


--
-- Name: index_floatlines_ll_setting_operation_id; Type: INDEX; Schema: ros_ll; Owner: -
--

CREATE INDEX index_floatlines_ll_setting_operation_id ON ros_ll.floatlines USING btree (setting_operation_id);


--
-- Name: index_lights_by_type_and_colour_ll_setting_operation_id; Type: INDEX; Schema: ros_ll; Owner: -
--

CREATE INDEX index_lights_by_type_and_colour_ll_setting_operation_id ON ros_ll.lights_by_type_and_colour USING btree (setting_operation_id);


--
-- Name: index_ll_additional_catch_details_on_ssi_bait_type_id; Type: INDEX; Schema: ros_ll; Owner: -
--

CREATE INDEX index_ll_additional_catch_details_on_ssi_bait_type_id ON ros_ll.additional_catch_details_on_ssi USING btree (bait_type);


--
-- Name: index_ll_catch_details_ll_fishing_event_id; Type: INDEX; Schema: ros_ll; Owner: -
--

CREATE INDEX index_ll_catch_details_ll_fishing_event_id ON ros_ll.catch_details USING btree (fishing_event_id);


--
-- Name: index_ll_fishing_events_ll_hauling_operation_id; Type: INDEX; Schema: ros_ll; Owner: -
--

CREATE INDEX index_ll_fishing_events_ll_hauling_operation_id ON ros_ll.fishing_events USING btree (hauling_operation_id);


--
-- Name: index_ll_fishing_events_ll_mitigation_measure_id; Type: INDEX; Schema: ros_ll; Owner: -
--

CREATE INDEX index_ll_fishing_events_ll_mitigation_measure_id ON ros_ll.fishing_events USING btree (mitigation_measure_id);


--
-- Name: index_ll_fishing_events_ll_setting_operation_id; Type: INDEX; Schema: ros_ll; Owner: -
--

CREATE INDEX index_ll_fishing_events_ll_setting_operation_id ON ros_ll.fishing_events USING btree (setting_operation_id);


--
-- Name: index_ll_gear_specifications_tori_line_detail_id; Type: INDEX; Schema: ros_ll; Owner: -
--

CREATE INDEX index_ll_gear_specifications_tori_line_detail_id ON ros_ll.gear_specifications USING btree (tori_line_detail_id);


--
-- Name: index_ll_specimens_additional_specimen_d_non_target_species_id; Type: INDEX; Schema: ros_ll; Owner: -
--

CREATE INDEX index_ll_specimens_additional_specimen_d_non_target_species_id ON ros_ll.specimens USING btree (additional_specimen_details_non_target_species_id);


--
-- Name: index_ll_specimens_biometric_information_id; Type: INDEX; Schema: ros_ll; Owner: -
--

CREATE INDEX index_ll_specimens_biometric_information_id ON ros_ll.specimens USING btree (biometric_information_id);


--
-- Name: index_ll_specimens_ll_additional_catch_details_on_ssis_id; Type: INDEX; Schema: ros_ll; Owner: -
--

CREATE INDEX index_ll_specimens_ll_additional_catch_details_on_ssis_id ON ros_ll.specimens USING btree (additional_catch_details_on_ssis_id);


--
-- Name: index_ll_specimens_ll_depredation_detail_id; Type: INDEX; Schema: ros_ll; Owner: -
--

CREATE INDEX index_ll_specimens_ll_depredation_detail_id ON ros_ll.specimens USING btree (depredation_detail_id);


--
-- Name: index_ll_specimens_ll_tag_detail_id; Type: INDEX; Schema: ros_ll; Owner: -
--

CREATE INDEX index_ll_specimens_ll_tag_detail_id ON ros_ll.specimens USING btree (tag_detail_id);


--
-- Name: index_tag_details_tag_finder_id; Type: INDEX; Schema: ros_ll; Owner: -
--

CREATE INDEX index_tag_details_tag_finder_id ON ros_ll.tag_details USING btree (tag_finder_id);


--
-- Name: idx_iotc_observer_identifier_observer_identifier_mapping; Type: INDEX; Schema: ros_meta; Owner: -
--

CREATE INDEX idx_iotc_observer_identifier_observer_identifier_mapping ON ros_meta.observer_identifier_mapping USING btree (iotc_observer_identifier);


--
-- Name: idx_legacy_iotc_observer_identifier_observer_identifier_mapping; Type: INDEX; Schema: ros_meta; Owner: -
--

CREATE INDEX idx_legacy_iotc_observer_identifier_observer_identifier_mapping ON ros_meta.observer_identifier_mapping USING btree (legacy_iotc_observer_identifier);


--
-- Name: idx_ros_meta_contact_id_focal_point; Type: INDEX; Schema: ros_meta; Owner: -
--

CREATE INDEX idx_ros_meta_contact_id_focal_point ON ros_meta.focal_point USING btree (contact_id);


--
-- Name: idx_ros_meta_contact_id_observer; Type: INDEX; Schema: ros_meta; Owner: -
--

CREATE INDEX idx_ros_meta_contact_id_observer ON ros_meta.observer USING btree (contact_id);


--
-- Name: idx_ros_meta_email_focal_point; Type: INDEX; Schema: ros_meta; Owner: -
--

CREATE INDEX idx_ros_meta_email_focal_point ON ros_meta.focal_point USING btree (email);


--
-- Name: idx_ros_meta_full_name_contact; Type: INDEX; Schema: ros_meta; Owner: -
--

CREATE INDEX idx_ros_meta_full_name_contact ON ros_meta.contact USING btree (full_name);


--
-- Name: idx_ros_meta_iotc_observer_identifier_observer; Type: INDEX; Schema: ros_meta; Owner: -
--

CREATE INDEX idx_ros_meta_iotc_observer_identifier_observer ON ros_meta.observer USING btree (iotc_observer_identifier);


--
-- Name: idx_ros_meta_nationality_code_contact; Type: INDEX; Schema: ros_meta; Owner: -
--

CREATE INDEX idx_ros_meta_nationality_code_contact ON ros_meta.contact USING btree (nationality_code);


--
-- Name: index_bait_fishing_events_pl_bait_fishing_operation_id; Type: INDEX; Schema: ros_pl; Owner: -
--

CREATE INDEX index_bait_fishing_events_pl_bait_fishing_operation_id ON ros_pl.bait_fishing_events USING btree (bait_fishing_operation_id);


--
-- Name: index_pl_general_specifications_hook_type_code; Type: INDEX; Schema: ros_pl; Owner: -
--

CREATE INDEX index_pl_general_specifications_hook_type_code ON ros_pl.gear_specifications USING btree (hook_type_code);


--
-- Name: index_pl_lures_or_jiggers_by_type_gear_specifications_id; Type: INDEX; Schema: ros_pl; Owner: -
--

CREATE INDEX index_pl_lures_or_jiggers_by_type_gear_specifications_id ON ros_pl.lures_or_jiggers_by_type USING btree (gear_specification_id);


--
-- Name: index_pl_specimens_pl_additional_catch_details_on_ssis_id; Type: INDEX; Schema: ros_pl; Owner: -
--

CREATE INDEX index_pl_specimens_pl_additional_catch_details_on_ssis_id ON ros_pl.specimens USING btree (additional_catch_details_on_ssis_id);


--
-- Name: index_pl_specimens_pl_catch_detail_id; Type: INDEX; Schema: ros_pl; Owner: -
--

CREATE INDEX index_pl_specimens_pl_catch_detail_id ON ros_pl.specimens USING btree (catch_detail_id);


--
-- Name: index_pl_specimens_pl_tag_detail_id; Type: INDEX; Schema: ros_pl; Owner: -
--

CREATE INDEX index_pl_specimens_pl_tag_detail_id ON ros_pl.specimens USING btree (tag_detail_id);


--
-- Name: index_pl_tfe_pl_catch_detail_pl_tf_id_pl_catch_detail_id; Type: INDEX; Schema: ros_pl; Owner: -
--

CREATE INDEX index_pl_tfe_pl_catch_detail_pl_tf_id_pl_catch_detail_id ON ros_pl.tuna_fishing_event_pl_catch_detail USING btree (tuna_fishing_event_id, catch_detail_id);


--
-- Name: index_tag_details_tag_finder_id; Type: INDEX; Schema: ros_pl; Owner: -
--

CREATE INDEX index_tag_details_tag_finder_id ON ros_pl.tag_details USING btree (tag_finder_id);


--
-- Name: index_tuna_fishing_events_pl_object_detail_id; Type: INDEX; Schema: ros_pl; Owner: -
--

CREATE INDEX index_tuna_fishing_events_pl_object_detail_id ON ros_pl.tuna_fishing_events USING btree (object_detail_id);


--
-- Name: index_tuna_fishing_events_pl_tuna_fishing_operation_id; Type: INDEX; Schema: ros_pl; Owner: -
--

CREATE INDEX index_tuna_fishing_events_pl_tuna_fishing_operation_id ON ros_pl.tuna_fishing_events USING btree (tuna_fishing_operation_id);


--
-- Name: index_cetaceans_whale_shark_sightings_ps_setting_operation_id; Type: INDEX; Schema: ros_ps; Owner: -
--

CREATE INDEX index_cetaceans_whale_shark_sightings_ps_setting_operation_id ON ros_ps.cetaceans_whale_shark_sightings USING btree (setting_operation_id);


--
-- Name: index_ps_catch_details_ps_fishing_event_id; Type: INDEX; Schema: ros_ps; Owner: -
--

CREATE INDEX index_ps_catch_details_ps_fishing_event_id ON ros_ps.catch_details USING btree (fishing_event_id);


--
-- Name: index_ps_fishing_events_ps_setting_operation_id; Type: INDEX; Schema: ros_ps; Owner: -
--

CREATE INDEX index_ps_fishing_events_ps_setting_operation_id ON ros_ps.fishing_events USING btree (setting_operation_id);


--
-- Name: index_ps_spe_additional_specimen_details_non_target_species_id; Type: INDEX; Schema: ros_ps; Owner: -
--

CREATE INDEX index_ps_spe_additional_specimen_details_non_target_species_id ON ros_ps.specimens USING btree (additional_specimen_details_non_target_species_id);


--
-- Name: index_ps_specimens_biometric_information_id; Type: INDEX; Schema: ros_ps; Owner: -
--

CREATE INDEX index_ps_specimens_biometric_information_id ON ros_ps.specimens USING btree (biometric_information_id);


--
-- Name: index_ps_specimens_ps_additional_catch_details_on_ssis_id; Type: INDEX; Schema: ros_ps; Owner: -
--

CREATE INDEX index_ps_specimens_ps_additional_catch_details_on_ssis_id ON ros_ps.specimens USING btree (additional_catch_details_on_ssis_id);


--
-- Name: index_ps_specimens_ps_catch_detail_id; Type: INDEX; Schema: ros_ps; Owner: -
--

CREATE INDEX index_ps_specimens_ps_catch_detail_id ON ros_ps.specimens USING btree (catch_detail_id);


--
-- Name: index_ps_specimens_ps_tag_detail_id; Type: INDEX; Schema: ros_ps; Owner: -
--

CREATE INDEX index_ps_specimens_ps_tag_detail_id ON ros_ps.specimens USING btree (tag_detail_id);


--
-- Name: index_tag_details_tag_finder_id; Type: INDEX; Schema: ros_ps; Owner: -
--

CREATE INDEX index_tag_details_tag_finder_id ON ros_ps.tag_details USING btree (tag_finder_id);


--
-- Name: trip_daily_activities fk_common_trip_daily_activities_trip; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_daily_activities
    ADD CONSTRAINT fk_common_trip_daily_activities_trip FOREIGN KEY (trip_id) REFERENCES ros_common.trip(id);


--
-- Name: trip_daily_activity_details fk_common_trip_daily_activity_details_trip_daily_activity_id; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_daily_activity_details
    ADD CONSTRAINT fk_common_trip_daily_activity_details_trip_daily_activity_id FOREIGN KEY (trip_daily_activity_id) REFERENCES ros_common.trip_daily_activities(id);


--
-- Name: observation_dataset fk_observer_data_submitter_id; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.observation_dataset
    ADD CONSTRAINT fk_observer_data_submitter_id FOREIGN KEY (submitter_id) REFERENCES ros_meta.focal_point(contact_id);


--
-- Name: trip_reasons_for_days_lost fk_reasons_for_days_lost_inoperativity_reason; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_reasons_for_days_lost
    ADD CONSTRAINT fk_reasons_for_days_lost_inoperativity_reason FOREIGN KEY (inoperativity_reason) REFERENCES refs_fishery.reasons_days_lost(code);


--
-- Name: biometric_information fk_ros_c_biometric_i_alternative_measured_length_measuring_tool; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.biometric_information
    ADD CONSTRAINT fk_ros_c_biometric_i_alternative_measured_length_measuring_tool FOREIGN KEY (alternative_measured_length_length_measuring_tool_code, alternative_measured_length_type_of_measurement_code) REFERENCES refs_biology.measurement_tools(code, type_of_measurement_code);


--
-- Name: biometric_information fk_ros_c_biometric_information_alternative_measured_length_type; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.biometric_information
    ADD CONSTRAINT fk_ros_c_biometric_information_alternative_measured_length_type FOREIGN KEY (alternative_measured_length_measured_length_type_code, alternative_measured_length_type_of_measurement_code) REFERENCES refs_biology.measurements(code, type_of_measurement_code);


--
-- Name: biometric_information fk_ros_c_biometric_information_measured_length_measuring_tool; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.biometric_information
    ADD CONSTRAINT fk_ros_c_biometric_information_measured_length_measuring_tool FOREIGN KEY (measured_length_length_measuring_tool_code, measured_length_type_of_measurement_code) REFERENCES refs_biology.measurement_tools(code, type_of_measurement_code);


--
-- Name: biometric_information fk_ros_c_biometric_information_measured_length_type; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.biometric_information
    ADD CONSTRAINT fk_ros_c_biometric_information_measured_length_type FOREIGN KEY (measured_length_measured_length_type_code, measured_length_type_of_measurement_code) REFERENCES refs_biology.measurements(code, type_of_measurement_code);


--
-- Name: biometric_information fk_ros_common_bio_collection_sampling_method_code_biometric_inf; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.biometric_information
    ADD CONSTRAINT fk_ros_common_bio_collection_sampling_method_code_biometric_inf FOREIGN KEY (bio_collection_sampling_method_code) REFERENCES refs_biology.sampling_methods_for_sampling_collections(code);


--
-- Name: biometric_information fk_ros_common_biometric_information_alternative_measured_length; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.biometric_information
    ADD CONSTRAINT fk_ros_common_biometric_information_alternative_measured_length FOREIGN KEY (alternative_measured_length_straight) REFERENCES refs_data.logical_responses(code);


--
-- Name: biometric_information fk_ros_common_biometric_information_measured_length_straight; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.biometric_information
    ADD CONSTRAINT fk_ros_common_biometric_information_measured_length_straight FOREIGN KEY (measured_length_straight) REFERENCES refs_data.logical_responses(code);


--
-- Name: additional_details_on_non_target_species fk_ros_common_condition_at_capture_code_additional_details_on_n; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.additional_details_on_non_target_species
    ADD CONSTRAINT fk_ros_common_condition_at_capture_code_additional_details_on_n FOREIGN KEY (condition_at_capture_code) REFERENCES refs_biology.incidental_captures_conditions(code);


--
-- Name: additional_details_on_non_target_species fk_ros_common_condition_at_release_code_additional_details_on_n; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.additional_details_on_non_target_species
    ADD CONSTRAINT fk_ros_common_condition_at_release_code_additional_details_on_n FOREIGN KEY (condition_at_release_code) REFERENCES refs_biology.incidental_captures_conditions(code);


--
-- Name: depredation_details fk_ros_common_depredation_source_code_depredation_details; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.depredation_details
    ADD CONSTRAINT fk_ros_common_depredation_source_code_depredation_details FOREIGN KEY (depredation_source_code) REFERENCES refs_biology.scars(code);


--
-- Name: observation_dataset fk_ros_common_observation_dataset_reporting_entity_code; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.observation_dataset
    ADD CONSTRAINT fk_ros_common_observation_dataset_reporting_entity_code FOREIGN KEY (reporting_country_code) REFERENCES refs_admin.entities(code);


--
-- Name: observation_dataset fk_ros_common_observation_dataset_source; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.observation_dataset
    ADD CONSTRAINT fk_ros_common_observation_dataset_source FOREIGN KEY (reporting_source_dataset_code, reporting_source_code) REFERENCES refs_data.sources(dataset_code, code);


--
-- Name: observation_dataset fk_ros_common_observer_data_reporting_country_code; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.observation_dataset
    ADD CONSTRAINT fk_ros_common_observer_data_reporting_country_code FOREIGN KEY (reporting_country_code) REFERENCES refs_admin.countries(code);


--
-- Name: observation_dataset fk_ros_common_observer_data_vessel_type_code; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.observation_dataset
    ADD CONSTRAINT fk_ros_common_observer_data_vessel_type_code FOREIGN KEY (vessel_type_code) REFERENCES refs_fishery.vessel_types(code);


--
-- Name: depredation_details fk_ros_common_predator_observed_code_depredation_details; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.depredation_details
    ADD CONSTRAINT fk_ros_common_predator_observed_code_depredation_details FOREIGN KEY (predator_observed_code) REFERENCES refs_biology.species(code);


--
-- Name: trip_reasons_for_days_lost fk_ros_common_reasons_for_days_lost_trip_id; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_reasons_for_days_lost
    ADD CONSTRAINT fk_ros_common_reasons_for_days_lost_trip_id FOREIGN KEY (trip_id) REFERENCES ros_common.trip(id);


--
-- Name: biometric_information fk_ros_common_sex_code_biometric_information; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.biometric_information
    ADD CONSTRAINT fk_ros_common_sex_code_biometric_information FOREIGN KEY (sex_code) REFERENCES refs_biology.sex(code);


--
-- Name: trip_daily_activity_details fk_ros_common_trip_daily_activity_details_activity_code; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_daily_activity_details
    ADD CONSTRAINT fk_ros_common_trip_daily_activity_details_activity_code FOREIGN KEY (activity_code) REFERENCES refs_fishery.surface_fishery_activities(code);


--
-- Name: trip fk_ros_common_trip_observer_data; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip
    ADD CONSTRAINT fk_ros_common_trip_observer_data FOREIGN KEY (observation_dataset_id) REFERENCES ros_common.observation_dataset(id);


--
-- Name: trip_observer fk_ros_common_trip_observer_disembarkation_country_code; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_observer
    ADD CONSTRAINT fk_ros_common_trip_observer_disembarkation_country_code FOREIGN KEY (disembarkation_country_code) REFERENCES refs_admin.countries(code);


--
-- Name: trip_observer fk_ros_common_trip_observer_disembarkation_port_code; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_observer
    ADD CONSTRAINT fk_ros_common_trip_observer_disembarkation_port_code FOREIGN KEY (disembarkation_port_code) REFERENCES refs_admin.ports(code);


--
-- Name: trip_observer fk_ros_common_trip_observer_embarkation_country_code; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_observer
    ADD CONSTRAINT fk_ros_common_trip_observer_embarkation_country_code FOREIGN KEY (embarkation_country_code) REFERENCES refs_admin.countries(code);


--
-- Name: trip_observer fk_ros_common_trip_observer_embarkation_port_code; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_observer
    ADD CONSTRAINT fk_ros_common_trip_observer_embarkation_port_code FOREIGN KEY (embarkation_port_code) REFERENCES refs_admin.ports(code);


--
-- Name: trip_vessel fk_ros_common_trip_vessel_ais; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_vessel
    ADD CONSTRAINT fk_ros_common_trip_vessel_ais FOREIGN KEY (ais) REFERENCES refs_data.logical_responses(code);


--
-- Name: trip_vessel fk_ros_common_trip_vessel_departure_country_code; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_vessel
    ADD CONSTRAINT fk_ros_common_trip_vessel_departure_country_code FOREIGN KEY (departure_country_code) REFERENCES refs_admin.countries(code);


--
-- Name: trip_vessel fk_ros_common_trip_vessel_departure_port_code; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_vessel
    ADD CONSTRAINT fk_ros_common_trip_vessel_departure_port_code FOREIGN KEY (departure_port_code) REFERENCES refs_admin.ports(code);


--
-- Name: trip_vessel fk_ros_common_trip_vessel_depth_sounder; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_vessel
    ADD CONSTRAINT fk_ros_common_trip_vessel_depth_sounder FOREIGN KEY (depth_sounder) REFERENCES refs_data.logical_responses(code);


--
-- Name: trip_vessel fk_ros_common_trip_vessel_doppler_current_meter; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_vessel
    ADD CONSTRAINT fk_ros_common_trip_vessel_doppler_current_meter FOREIGN KEY (doppler_current_meter) REFERENCES refs_data.logical_responses(code);


--
-- Name: trip_vessel fk_ros_common_trip_vessel_expendable_bathythermographs; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_vessel
    ADD CONSTRAINT fk_ros_common_trip_vessel_expendable_bathythermographs FOREIGN KEY (expendable_bathythermographs) REFERENCES refs_data.logical_responses(code);


--
-- Name: trip_vessel_fish_preservation_method fk_ros_common_trip_vessel_fish_preservation_method_method_code; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_vessel_fish_preservation_method
    ADD CONSTRAINT fk_ros_common_trip_vessel_fish_preservation_method_method_code FOREIGN KEY (fish_preservation_method_code) REFERENCES refs_fishery.fish_preservation_methods(code);


--
-- Name: trip_vessel_fish_preservation_method fk_ros_common_trip_vessel_fish_preservation_method_trip_id; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_vessel_fish_preservation_method
    ADD CONSTRAINT fk_ros_common_trip_vessel_fish_preservation_method_trip_id FOREIGN KEY (trip_id) REFERENCES ros_common.trip(id);


--
-- Name: trip_vessel_fish_storage_type fk_ros_common_trip_vessel_fish_storage_type_code; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_vessel_fish_storage_type
    ADD CONSTRAINT fk_ros_common_trip_vessel_fish_storage_type_code FOREIGN KEY (fish_storage_type_code) REFERENCES refs_fishery.fish_storage_types(code);


--
-- Name: trip_vessel_fish_storage_type fk_ros_common_trip_vessel_fish_storage_type_trip_id; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_vessel_fish_storage_type
    ADD CONSTRAINT fk_ros_common_trip_vessel_fish_storage_type_trip_id FOREIGN KEY (trip_id) REFERENCES ros_common.trip(id);


--
-- Name: trip_vessel fk_ros_common_trip_vessel_fisheries_information_services; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_vessel
    ADD CONSTRAINT fk_ros_common_trip_vessel_fisheries_information_services FOREIGN KEY (fisheries_information_services) REFERENCES refs_data.logical_responses(code);


--
-- Name: trip_vessel fk_ros_common_trip_vessel_gps; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_vessel
    ADD CONSTRAINT fk_ros_common_trip_vessel_gps FOREIGN KEY (gps) REFERENCES refs_data.logical_responses(code);


--
-- Name: trip_vessel fk_ros_common_trip_vessel_hf_radios; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_vessel
    ADD CONSTRAINT fk_ros_common_trip_vessel_hf_radios FOREIGN KEY (hf_radios) REFERENCES refs_data.logical_responses(code);


--
-- Name: trip_vessel_main_engines fk_ros_common_trip_vessel_main_engines_trip_id; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_vessel_main_engines
    ADD CONSTRAINT fk_ros_common_trip_vessel_main_engines_trip_id FOREIGN KEY (trip_id) REFERENCES ros_common.trip(id);


--
-- Name: trip_vessel fk_ros_common_trip_vessel_radars; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_vessel
    ADD CONSTRAINT fk_ros_common_trip_vessel_radars FOREIGN KEY (radars) REFERENCES refs_data.logical_responses(code);


--
-- Name: trip_vessel fk_ros_common_trip_vessel_return_country_code; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_vessel
    ADD CONSTRAINT fk_ros_common_trip_vessel_return_country_code FOREIGN KEY (return_country_code) REFERENCES refs_admin.countries(code);


--
-- Name: trip_vessel fk_ros_common_trip_vessel_return_port_code; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_vessel
    ADD CONSTRAINT fk_ros_common_trip_vessel_return_port_code FOREIGN KEY (return_port_code) REFERENCES refs_admin.ports(code);


--
-- Name: trip_vessel fk_ros_common_trip_vessel_satellite_communication_systems; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_vessel
    ADD CONSTRAINT fk_ros_common_trip_vessel_satellite_communication_systems FOREIGN KEY (satellite_communication_systems) REFERENCES refs_data.logical_responses(code);


--
-- Name: trip_vessel fk_ros_common_trip_vessel_sonar; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_vessel
    ADD CONSTRAINT fk_ros_common_trip_vessel_sonar FOREIGN KEY (sonar) REFERENCES refs_data.logical_responses(code);


--
-- Name: trip_vessel fk_ros_common_trip_vessel_track_plotter; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_vessel
    ADD CONSTRAINT fk_ros_common_trip_vessel_track_plotter FOREIGN KEY (track_plotter) REFERENCES refs_data.logical_responses(code);


--
-- Name: trip_vessel fk_ros_common_trip_vessel_vessel_id; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_vessel
    ADD CONSTRAINT fk_ros_common_trip_vessel_vessel_id FOREIGN KEY (vessel_id) REFERENCES ros_meta.vessel(id);


--
-- Name: trip_vessel fk_ros_common_trip_vessel_vhf_radios; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_vessel
    ADD CONSTRAINT fk_ros_common_trip_vessel_vhf_radios FOREIGN KEY (vhf_radios) REFERENCES refs_data.logical_responses(code);


--
-- Name: trip_vessel fk_ros_common_trip_vessel_vms; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_vessel
    ADD CONSTRAINT fk_ros_common_trip_vessel_vms FOREIGN KEY (vms) REFERENCES refs_data.logical_responses(code);


--
-- Name: trip_waste_managements fk_ros_common_waste_managements_storage_or_disposal_method_code; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_waste_managements
    ADD CONSTRAINT fk_ros_common_waste_managements_storage_or_disposal_method_code FOREIGN KEY (waste_storage_or_disposal_method_code) REFERENCES refs_fishery.waste_disposal_methods(code);


--
-- Name: trip_waste_managements fk_ros_common_waste_managements_trip_id; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_waste_managements
    ADD CONSTRAINT fk_ros_common_waste_managements_trip_id FOREIGN KEY (trip_id) REFERENCES ros_common.trip(id);


--
-- Name: trip_waste_managements fk_ros_common_waste_managements_waste_category_code; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_waste_managements
    ADD CONSTRAINT fk_ros_common_waste_managements_waste_category_code FOREIGN KEY (waste_category_code) REFERENCES refs_fishery.waste_categories(code);


--
-- Name: trip_observer fk_trip_observer_observer_id; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_observer
    ADD CONSTRAINT fk_trip_observer_observer_id FOREIGN KEY (observer_id) REFERENCES ros_meta.observer(contact_id);


--
-- Name: trip_observer fk_trip_observer_trip_id; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_observer
    ADD CONSTRAINT fk_trip_observer_trip_id FOREIGN KEY (trip_id) REFERENCES ros_common.trip(id);


--
-- Name: trip_vessel fk_trip_vessel_fishing_master_id; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_vessel
    ADD CONSTRAINT fk_trip_vessel_fishing_master_id FOREIGN KEY (fishing_master_id) REFERENCES ros_meta.contact(id);


--
-- Name: trip_vessel fk_trip_vessel_hull_material_code; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_vessel
    ADD CONSTRAINT fk_trip_vessel_hull_material_code FOREIGN KEY (hull_material_code) REFERENCES refs_fishery.hull_material_types(code);


--
-- Name: trip_vessel fk_trip_vessel_skipper_id; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_vessel
    ADD CONSTRAINT fk_trip_vessel_skipper_id FOREIGN KEY (skipper_id) REFERENCES ros_meta.contact(id);


--
-- Name: trip_vessel fk_trip_vessel_trip_id; Type: FK CONSTRAINT; Schema: ros_common; Owner: -
--

ALTER TABLE ONLY ros_common.trip_vessel
    ADD CONSTRAINT fk_trip_vessel_trip_id FOREIGN KEY (trip_id) REFERENCES ros_common.trip(id);


--
-- Name: specimens ddtnlspcmndtlsnntrgtsp; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.specimens
    ADD CONSTRAINT ddtnlspcmndtlsnntrgtsp FOREIGN KEY (additional_specimen_details_non_target_species_id) REFERENCES ros_common.additional_details_on_non_target_species(id);


--
-- Name: additional_catch_details_on_ssi fk_ros_gn_additional_catch_details_on_ssi_brought_on_board; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.additional_catch_details_on_ssi
    ADD CONSTRAINT fk_ros_gn_additional_catch_details_on_ssi_brought_on_board FOREIGN KEY (brought_on_board) REFERENCES refs_data.logical_responses(code);


--
-- Name: additional_catch_details_on_ssi fk_ros_gn_additional_catch_details_on_ssi_revival; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.additional_catch_details_on_ssi
    ADD CONSTRAINT fk_ros_gn_additional_catch_details_on_ssi_revival FOREIGN KEY (revival) REFERENCES refs_data.logical_responses(code);


--
-- Name: catch_details fk_ros_gn_estimated_weight_sampling_method_code_gn_catch_detail; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.catch_details
    ADD CONSTRAINT fk_ros_gn_estimated_weight_sampling_method_code_gn_catch_detail FOREIGN KEY (estimated_weight_sampling_method_code) REFERENCES refs_biology.sampling_methods_for_catch_estimation(code);


--
-- Name: catch_details fk_ros_gn_fates_code_gn_catch_details; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.catch_details
    ADD CONSTRAINT fk_ros_gn_fates_code_gn_catch_details FOREIGN KEY (fates_code, type_of_fate_code) REFERENCES refs_biology.fates(code, type_of_fate_code);


--
-- Name: fishing_events fk_ros_gn_fishing_events_trip; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.fishing_events
    ADD CONSTRAINT fk_ros_gn_fishing_events_trip FOREIGN KEY (trip_id) REFERENCES ros_common.trip(id);


--
-- Name: gillnet_configuration fk_ros_gn_float_type_code_gillnet_configuration; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.gillnet_configuration
    ADD CONSTRAINT fk_ros_gn_float_type_code_gillnet_configuration FOREIGN KEY (float_type_code) REFERENCES refs_fishery.float_types(code);


--
-- Name: additional_catch_details_on_ssi fk_ros_gn_gear_interaction_code_gn_additional_catch_details_on_; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.additional_catch_details_on_ssi
    ADD CONSTRAINT fk_ros_gn_gear_interaction_code_gn_additional_catch_details_on_ FOREIGN KEY (gear_interaction_code) REFERENCES refs_biology.gear_interactions(code);


--
-- Name: gear_specifications fk_ros_gn_gear_specifications_net_drum_hauler; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.gear_specifications
    ADD CONSTRAINT fk_ros_gn_gear_specifications_net_drum_hauler FOREIGN KEY (net_drum_hauler) REFERENCES refs_data.logical_responses(code);


--
-- Name: gear_specifications fk_ros_gn_gear_specifications_trip; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.gear_specifications
    ADD CONSTRAINT fk_ros_gn_gear_specifications_trip FOREIGN KEY (trip_id) REFERENCES ros_common.trip(id);


--
-- Name: gillnet_configuration fk_ros_gn_gillnet_configuration_droplines_used; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.gillnet_configuration
    ADD CONSTRAINT fk_ros_gn_gillnet_configuration_droplines_used FOREIGN KEY (droplines_used) REFERENCES refs_data.logical_responses(code);


--
-- Name: gillnet_configuration fk_ros_gn_gillnet_configuration_panels_stacked; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.gillnet_configuration
    ADD CONSTRAINT fk_ros_gn_gillnet_configuration_panels_stacked FOREIGN KEY (panels_stacked) REFERENCES refs_data.logical_responses(code);


--
-- Name: gillnet_configuration fk_ros_gn_gillnet_material_type_code_gillnet_configuration; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.gillnet_configuration
    ADD CONSTRAINT fk_ros_gn_gillnet_material_type_code_gillnet_configuration FOREIGN KEY (gillnet_material_type_code) REFERENCES refs_fishery.line_material_types(code);


--
-- Name: additional_catch_details_on_ssi fk_ros_gn_handling_method_code_gn_additional_catch_details_on_s; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.additional_catch_details_on_ssi
    ADD CONSTRAINT fk_ros_gn_handling_method_code_gn_additional_catch_details_on_s FOREIGN KEY (handling_method_code) REFERENCES refs_biology.handling_methods(code);


--
-- Name: mitigation_measures_mitigation_devices fk_ros_gn_mitigation_device_code_gn_mitigation_measures_mitigat; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.mitigation_measures_mitigation_devices
    ADD CONSTRAINT fk_ros_gn_mitigation_device_code_gn_mitigation_measures_mitigat FOREIGN KEY (mitigation_device_code) REFERENCES refs_fishery.mitigation_devices(code);


--
-- Name: mitigation_measures fk_ros_gn_mitigation_measures_mitigation_measures; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.mitigation_measures
    ADD CONSTRAINT fk_ros_gn_mitigation_measures_mitigation_measures FOREIGN KEY (mitigation_measures) REFERENCES refs_data.logical_responses(code);


--
-- Name: gillnet_configuration_net_web_colours fk_ros_gn_net_colour_code_gn_gillnet_configuration_net_web_colo; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.gillnet_configuration_net_web_colours
    ADD CONSTRAINT fk_ros_gn_net_colour_code_gn_gillnet_configuration_net_web_colo FOREIGN KEY (net_colour_code) REFERENCES refs_fishery.net_colours(code);


--
-- Name: hauling_operations fk_ros_gn_net_condition_code_gn_hauling_operations; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.hauling_operations
    ADD CONSTRAINT fk_ros_gn_net_condition_code_gn_hauling_operations FOREIGN KEY (net_condition_code) REFERENCES refs_fishery.net_conditions(code);


--
-- Name: setting_operations fk_ros_gn_net_configuration_code_gn_setting_operations; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.setting_operations
    ADD CONSTRAINT fk_ros_gn_net_configuration_code_gn_setting_operations FOREIGN KEY (net_configuration_code) REFERENCES refs_fishery.net_configurations(code);


--
-- Name: setting_operations fk_ros_gn_net_deploy_depth_code_gn_setting_operations; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.setting_operations
    ADD CONSTRAINT fk_ros_gn_net_deploy_depth_code_gn_setting_operations FOREIGN KEY (net_deploy_depth_code) REFERENCES refs_fishery.net_deploy_depths(code);


--
-- Name: setting_operations fk_ros_gn_net_setting_strategy_code_gn_setting_operations; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.setting_operations
    ADD CONSTRAINT fk_ros_gn_net_setting_strategy_code_gn_setting_operations FOREIGN KEY (net_setting_strategy_code) REFERENCES refs_fishery.net_setting_strategies(code);


--
-- Name: hauling_operations fk_ros_gn_sampling_protocol_code_gn_hauling_operations; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.hauling_operations
    ADD CONSTRAINT fk_ros_gn_sampling_protocol_code_gn_hauling_operations FOREIGN KEY (sampling_protocol_code) REFERENCES refs_biology.sampling_protocols(code);


--
-- Name: sinkers_by_type fk_ros_gn_sinker_material_type_code_sinkers_by_type; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.sinkers_by_type
    ADD CONSTRAINT fk_ros_gn_sinker_material_type_code_sinkers_by_type FOREIGN KEY (sinker_material_type_code) REFERENCES refs_fishery.sinker_material_types(code);


--
-- Name: catch_details fk_ros_gn_species_code_gn_catch_details; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.catch_details
    ADD CONSTRAINT fk_ros_gn_species_code_gn_catch_details FOREIGN KEY (species_code) REFERENCES refs_biology.species(code);


--
-- Name: tag_details fk_ros_gn_tag_details_tag_recovery; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.tag_details
    ADD CONSTRAINT fk_ros_gn_tag_details_tag_recovery FOREIGN KEY (tag_recovery) REFERENCES refs_data.logical_responses(code);


--
-- Name: tag_details fk_ros_gn_tag_details_tag_release; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.tag_details
    ADD CONSTRAINT fk_ros_gn_tag_details_tag_release FOREIGN KEY (tag_release) REFERENCES refs_data.logical_responses(code);


--
-- Name: tag_details fk_ros_gn_tag_type_code_gn_tag_details; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.tag_details
    ADD CONSTRAINT fk_ros_gn_tag_type_code_gn_tag_details FOREIGN KEY (tag_type_code) REFERENCES refs_biology.tag_types(code);


--
-- Name: tag_details fk_tag_details_tag_finder_id; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.tag_details
    ADD CONSTRAINT fk_tag_details_tag_finder_id FOREIGN KEY (tag_finder_id) REFERENCES ros_meta.contact(id);


--
-- Name: gillnet_configuration gllntcnfggllntcnfgrtnd; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.gillnet_configuration
    ADD CONSTRAINT gllntcnfggllntcnfgrtnd FOREIGN KEY (gillnet_configuration_id) REFERENCES ros_gn.gear_specifications(id);


--
-- Name: catch_details gnctchdtlsgnfshngvntid; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.catch_details
    ADD CONSTRAINT gnctchdtlsgnfshngvntid FOREIGN KEY (fishing_event_id) REFERENCES ros_gn.fishing_events(id);


--
-- Name: fishing_events gnfshngvntgnsttngprtnd; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.fishing_events
    ADD CONSTRAINT gnfshngvntgnsttngprtnd FOREIGN KEY (setting_operation_id) REFERENCES ros_gn.setting_operations(id);


--
-- Name: fishing_events gnfshngvntsgnhlngprtnd; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.fishing_events
    ADD CONSTRAINT gnfshngvntsgnhlngprtnd FOREIGN KEY (hauling_operation_id) REFERENCES ros_gn.hauling_operations(id);


--
-- Name: fishing_events gnfshngvntsgnmtgtnmsrd; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.fishing_events
    ADD CONSTRAINT gnfshngvntsgnmtgtnmsrd FOREIGN KEY (mitigation_measure_id) REFERENCES ros_gn.mitigation_measures(id);


--
-- Name: gillnet_configuration_net_web_colours gnglgngllntcnfgrtndnwc; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.gillnet_configuration_net_web_colours
    ADD CONSTRAINT gnglgngllntcnfgrtndnwc FOREIGN KEY (gillnet_configuration_id_nwc) REFERENCES ros_gn.gillnet_configuration(id);


--
-- Name: gillnet_configuration_stretched_mesh_sizes gnglgngllntcnfgrtndsms; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.gillnet_configuration_stretched_mesh_sizes
    ADD CONSTRAINT gnglgngllntcnfgrtndsms FOREIGN KEY (gillnet_configuration_id_sms) REFERENCES ros_gn.gillnet_configuration(id);


--
-- Name: specimens gngnddtnlctchdtlsnsssd; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.specimens
    ADD CONSTRAINT gngnddtnlctchdtlsnsssd FOREIGN KEY (additional_catch_details_on_ssis_id) REFERENCES ros_gn.additional_catch_details_on_ssi(id);


--
-- Name: mitigation_measures_mitigation_devices gnmtgtnmsrsmtmtgtnmsrd; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.mitigation_measures_mitigation_devices
    ADD CONSTRAINT gnmtgtnmsrsmtmtgtnmsrd FOREIGN KEY (mitigation_measure_id) REFERENCES ros_gn.mitigation_measures(id);


--
-- Name: specimens gnspcimensgntgdetailid; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.specimens
    ADD CONSTRAINT gnspcimensgntgdetailid FOREIGN KEY (tag_detail_id) REFERENCES ros_gn.tag_details(id);


--
-- Name: specimens gnspcmnsbmtrcnfrmtonid; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.specimens
    ADD CONSTRAINT gnspcmnsbmtrcnfrmtonid FOREIGN KEY (biometric_information_id) REFERENCES ros_common.biometric_information(id);


--
-- Name: specimens gnspcmnsgnctchdetailid; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.specimens
    ADD CONSTRAINT gnspcmnsgnctchdetailid FOREIGN KEY (catch_detail_id) REFERENCES ros_gn.catch_details(id);


--
-- Name: specimens gnspcmnsgndprdtndtilid; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.specimens
    ADD CONSTRAINT gnspcmnsgndprdtndtilid FOREIGN KEY (depredation_detail_id) REFERENCES ros_common.depredation_details(id);


--
-- Name: sinkers_by_type snkrsbygngllntcnfgrtnd; Type: FK CONSTRAINT; Schema: ros_gn; Owner: -
--

ALTER TABLE ONLY ros_gn.sinkers_by_type
    ADD CONSTRAINT snkrsbygngllntcnfgrtnd FOREIGN KEY (gillnet_configuration_id) REFERENCES ros_gn.gillnet_configuration(id);


--
-- Name: branchline_sections brnchlnbrnchlncnfgrtnd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.branchline_sections
    ADD CONSTRAINT brnchlnbrnchlncnfgrtnd FOREIGN KEY (branchline_configuration_id) REFERENCES ros_ll.branchline_configurations(id);


--
-- Name: branchline_configurations brnchlncnllgrspcfctnsd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.branchline_configurations
    ADD CONSTRAINT brnchlncnllgrspcfctnsd FOREIGN KEY (gear_specification_id) REFERENCES ros_ll.gear_specifications(id);


--
-- Name: branchlines_set brnchlnssllsttngprtnsd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.branchlines_set
    ADD CONSTRAINT brnchlnssllsttngprtnsd FOREIGN KEY (setting_operation_id) REFERENCES ros_ll.setting_operations(id);


--
-- Name: biteoffs_by_branchlines_set btffsbybrncllhlngprtnd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.biteoffs_by_branchlines_set
    ADD CONSTRAINT btffsbybrncllhlngprtnd FOREIGN KEY (hauling_operation_id) REFERENCES ros_ll.hauling_operations(id);


--
-- Name: baits_by_conditions btsbycndtllsttngprtnsd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.baits_by_conditions
    ADD CONSTRAINT btsbycndtllsttngprtnsd FOREIGN KEY (setting_operation_id) REFERENCES ros_ll.setting_operations(id);


--
-- Name: specimens ddtnlspcmndtlsnntrgtsp; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.specimens
    ADD CONSTRAINT ddtnlspcmndtlsnntrgtsp FOREIGN KEY (additional_specimen_details_non_target_species_id) REFERENCES ros_common.additional_details_on_non_target_species(id);


--
-- Name: additional_catch_details_on_ssi fk_ros_ll_additional_catch_details_on_ssi_brought_on_board; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.additional_catch_details_on_ssi
    ADD CONSTRAINT fk_ros_ll_additional_catch_details_on_ssi_brought_on_board FOREIGN KEY (brought_on_board) REFERENCES refs_data.logical_responses(code);


--
-- Name: additional_catch_details_on_ssi fk_ros_ll_additional_catch_details_on_ssi_hook_type_code; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.additional_catch_details_on_ssi
    ADD CONSTRAINT fk_ros_ll_additional_catch_details_on_ssi_hook_type_code FOREIGN KEY (hook_type_code) REFERENCES refs_fishery.hook_and_terminal_devices(code);


--
-- Name: additional_catch_details_on_ssi fk_ros_ll_additional_catch_details_on_ssi_light_attached_to_bra; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.additional_catch_details_on_ssi
    ADD CONSTRAINT fk_ros_ll_additional_catch_details_on_ssi_light_attached_to_bra FOREIGN KEY (light_attached_to_branchline) REFERENCES refs_data.logical_responses(code);


--
-- Name: additional_catch_details_on_ssi fk_ros_ll_additional_catch_details_on_ssi_revival; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.additional_catch_details_on_ssi
    ADD CONSTRAINT fk_ros_ll_additional_catch_details_on_ssi_revival FOREIGN KEY (revival) REFERENCES refs_data.logical_responses(code);


--
-- Name: baits_by_conditions fk_ros_ll_bait_condition_code_baits_by_conditions; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.baits_by_conditions
    ADD CONSTRAINT fk_ros_ll_bait_condition_code_baits_by_conditions FOREIGN KEY (bait_condition_code) REFERENCES refs_biology.bait_conditions(code);


--
-- Name: additional_catch_details_on_ssi fk_ros_ll_bait_condition_code_ll_additional_catch_details_on_ss; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.additional_catch_details_on_ssi
    ADD CONSTRAINT fk_ros_ll_bait_condition_code_ll_additional_catch_details_on_ss FOREIGN KEY (bait_condition_code) REFERENCES refs_biology.bait_conditions(code);


--
-- Name: branchline_configurations_storage fk_ros_ll_branchline_configurations_storage_code; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.branchline_configurations_storage
    ADD CONSTRAINT fk_ros_ll_branchline_configurations_storage_code FOREIGN KEY (branchline_storage_code) REFERENCES refs_fishery.branchline_storages(code);


--
-- Name: branchline_configurations_storage fk_ros_ll_branchline_configurations_storage_configuration; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.branchline_configurations_storage
    ADD CONSTRAINT fk_ros_ll_branchline_configurations_storage_configuration FOREIGN KEY (branchline_configuration_id) REFERENCES ros_ll.branchline_configurations(id);


--
-- Name: branchline_sections fk_ros_ll_branchline_material_type_code_branchline_sections; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.branchline_sections
    ADD CONSTRAINT fk_ros_ll_branchline_material_type_code_branchline_sections FOREIGN KEY (branchline_material_type_code) REFERENCES refs_fishery.line_material_types(code);


--
-- Name: additional_catch_details_on_ssi fk_ros_ll_dehooker_device_code_ll_additional_catch_details_on_s; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.additional_catch_details_on_ssi
    ADD CONSTRAINT fk_ros_ll_dehooker_device_code_ll_additional_catch_details_on_s FOREIGN KEY (dehooker_device_code) REFERENCES refs_fishery.dehooker_types(code);


--
-- Name: catch_details fk_ros_ll_estimated_weight_sampling_method_code_ll_catch_detail; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.catch_details
    ADD CONSTRAINT fk_ros_ll_estimated_weight_sampling_method_code_ll_catch_detail FOREIGN KEY (estimated_weight_sampling_method_code) REFERENCES refs_biology.sampling_methods_for_catch_estimation(code);


--
-- Name: catch_details fk_ros_ll_fates_code_ll_catch_details; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.catch_details
    ADD CONSTRAINT fk_ros_ll_fates_code_ll_catch_details FOREIGN KEY (fates_code, type_of_fate_code) REFERENCES refs_biology.fates(code, type_of_fate_code);


--
-- Name: fishing_events fk_ros_ll_fishing_events_trip; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.fishing_events
    ADD CONSTRAINT fk_ros_ll_fishing_events_trip FOREIGN KEY (trip_id) REFERENCES ros_common.trip(id);


--
-- Name: additional_catch_details_on_ssi fk_ros_ll_gear_interaction_code_ll_additional_catch_details_on_; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.additional_catch_details_on_ssi
    ADD CONSTRAINT fk_ros_ll_gear_interaction_code_ll_additional_catch_details_on_ FOREIGN KEY (gear_interaction_code) REFERENCES refs_biology.gear_interactions(code);


--
-- Name: gear_specifications fk_ros_ll_gear_specifications_bait_casting_machine; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.gear_specifications
    ADD CONSTRAINT fk_ros_ll_gear_specifications_bait_casting_machine FOREIGN KEY (bait_casting_machine) REFERENCES refs_data.logical_responses(code);


--
-- Name: gear_specifications fk_ros_ll_gear_specifications_line_hauler; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.gear_specifications
    ADD CONSTRAINT fk_ros_ll_gear_specifications_line_hauler FOREIGN KEY (line_hauler) REFERENCES refs_data.logical_responses(code);


--
-- Name: gear_specifications fk_ros_ll_gear_specifications_line_setter; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.gear_specifications
    ADD CONSTRAINT fk_ros_ll_gear_specifications_line_setter FOREIGN KEY (line_setter) REFERENCES refs_data.logical_responses(code);


--
-- Name: gear_specifications fk_ros_ll_gear_specifications_trip; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.gear_specifications
    ADD CONSTRAINT fk_ros_ll_gear_specifications_trip FOREIGN KEY (trip_id) REFERENCES ros_common.trip(id);


--
-- Name: additional_catch_details_on_ssi fk_ros_ll_handling_method_code_ll_additional_catch_details_on_s; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.additional_catch_details_on_ssi
    ADD CONSTRAINT fk_ros_ll_handling_method_code_ll_additional_catch_details_on_s FOREIGN KEY (handling_method_code) REFERENCES refs_biology.handling_methods(code);


--
-- Name: hauling_operations fk_ros_ll_hauling_operations_bird_scaring_device_at_hauler; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.hauling_operations
    ADD CONSTRAINT fk_ros_ll_hauling_operations_bird_scaring_device_at_hauler FOREIGN KEY (bird_scaring_device_at_hauler) REFERENCES refs_data.logical_responses(code);


--
-- Name: hooks_by_type fk_ros_ll_hook_type_code_hooks_by_type; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.hooks_by_type
    ADD CONSTRAINT fk_ros_ll_hook_type_code_hooks_by_type FOREIGN KEY (hook_type_code) REFERENCES refs_fishery.hook_and_terminal_devices(code);


--
-- Name: additional_catch_details_on_ssi fk_ros_ll_leader_material_type_code_ll_additional_catch_details; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.additional_catch_details_on_ssi
    ADD CONSTRAINT fk_ros_ll_leader_material_type_code_ll_additional_catch_details FOREIGN KEY (leader_material_type_code) REFERENCES refs_fishery.line_material_types(code);


--
-- Name: leader_set fk_ros_ll_leader_set_leader_material_type_code; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.leader_set
    ADD CONSTRAINT fk_ros_ll_leader_set_leader_material_type_code FOREIGN KEY (leader_material_type_code) REFERENCES refs_fishery.line_material_types(code);


--
-- Name: leader_set fk_ros_ll_leader_set_setting_operation_id; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.leader_set
    ADD CONSTRAINT fk_ros_ll_leader_set_setting_operation_id FOREIGN KEY (setting_operation_id) REFERENCES ros_ll.setting_operations(id);


--
-- Name: lights_by_type_and_colour fk_ros_ll_light_colour_code_lights_by_type_and_colour; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.lights_by_type_and_colour
    ADD CONSTRAINT fk_ros_ll_light_colour_code_lights_by_type_and_colour FOREIGN KEY (light_colour_code) REFERENCES refs_fishery.light_colours(code);


--
-- Name: lights_by_type_and_colour fk_ros_ll_light_type_code_lights_by_type_and_colour; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.lights_by_type_and_colour
    ADD CONSTRAINT fk_ros_ll_light_type_code_lights_by_type_and_colour FOREIGN KEY (light_type_code) REFERENCES refs_fishery.light_types(code);


--
-- Name: gear_specifications_mitigation_device fk_ros_ll_mitigation_device_code_ll_gear_specifications_mitigat; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.gear_specifications_mitigation_device
    ADD CONSTRAINT fk_ros_ll_mitigation_device_code_ll_gear_specifications_mitigat FOREIGN KEY (mitigation_device_code) REFERENCES refs_fishery.mitigation_devices(code);


--
-- Name: mitigation_measures_mitigation_devices fk_ros_ll_mitigation_device_code_ll_mitigation_measures_mitigat; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.mitigation_measures_mitigation_devices
    ADD CONSTRAINT fk_ros_ll_mitigation_device_code_ll_mitigation_measures_mitigat FOREIGN KEY (mitigation_device_code) REFERENCES refs_fishery.mitigation_devices(code);


--
-- Name: mitigation_measures fk_ros_ll_mitigation_measures_branchline_weighted; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.mitigation_measures
    ADD CONSTRAINT fk_ros_ll_mitigation_measures_branchline_weighted FOREIGN KEY (branchline_weighted) REFERENCES refs_data.logical_responses(code);


--
-- Name: mitigation_measures fk_ros_ll_mitigation_measures_hooks_pods; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.mitigation_measures
    ADD CONSTRAINT fk_ros_ll_mitigation_measures_hooks_pods FOREIGN KEY (hooks_pods) REFERENCES refs_data.logical_responses(code);


--
-- Name: mitigation_measures fk_ros_ll_mitigation_measures_hooks_set_between_dusk_and_dawn; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.mitigation_measures
    ADD CONSTRAINT fk_ros_ll_mitigation_measures_hooks_set_between_dusk_and_dawn FOREIGN KEY (hooks_set_between_dusk_and_dawn) REFERENCES refs_data.logical_responses(code);


--
-- Name: mitigation_measures fk_ros_ll_mitigation_measures_minimum_deck_lighting_used; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.mitigation_measures
    ADD CONSTRAINT fk_ros_ll_mitigation_measures_minimum_deck_lighting_used FOREIGN KEY (minimum_deck_lighting_used) REFERENCES refs_data.logical_responses(code);


--
-- Name: hauling_operations fk_ros_ll_sampling_protocol_code_ll_hauling_operations; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.hauling_operations
    ADD CONSTRAINT fk_ros_ll_sampling_protocol_code_ll_hauling_operations FOREIGN KEY (sampling_protocol_code) REFERENCES refs_biology.sampling_protocols(code);


--
-- Name: setting_operations fk_ros_ll_setting_operations_shark_lines_set; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.setting_operations
    ADD CONSTRAINT fk_ros_ll_setting_operations_shark_lines_set FOREIGN KEY (shark_lines_set) REFERENCES refs_data.logical_responses(code);


--
-- Name: baits_by_conditions fk_ros_ll_species_code_baits_by_conditions; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.baits_by_conditions
    ADD CONSTRAINT fk_ros_ll_species_code_baits_by_conditions FOREIGN KEY (species_code) REFERENCES refs_biology.species(code);


--
-- Name: catch_details fk_ros_ll_species_code_ll_catch_details; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.catch_details
    ADD CONSTRAINT fk_ros_ll_species_code_ll_catch_details FOREIGN KEY (species_code) REFERENCES refs_biology.species(code);


--
-- Name: tag_details fk_ros_ll_tag_details_tag_recovery; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.tag_details
    ADD CONSTRAINT fk_ros_ll_tag_details_tag_recovery FOREIGN KEY (tag_recovery) REFERENCES refs_data.logical_responses(code);


--
-- Name: tag_details fk_ros_ll_tag_details_tag_release; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.tag_details
    ADD CONSTRAINT fk_ros_ll_tag_details_tag_release FOREIGN KEY (tag_release) REFERENCES refs_data.logical_responses(code);


--
-- Name: tag_details fk_ros_ll_tag_type_code_ll_tag_details; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.tag_details
    ADD CONSTRAINT fk_ros_ll_tag_type_code_ll_tag_details FOREIGN KEY (tag_type_code) REFERENCES refs_biology.tag_types(code);


--
-- Name: setting_operations_target_species fk_ros_ll_target_species_code_ll_setting_operations_target_spec; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.setting_operations_target_species
    ADD CONSTRAINT fk_ros_ll_target_species_code_ll_setting_operations_target_spec FOREIGN KEY (target_species_code) REFERENCES refs_biology.species(code);


--
-- Name: tori_line_details fk_ros_ll_tori_line_details_streamers_reach_surface; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.tori_line_details
    ADD CONSTRAINT fk_ros_ll_tori_line_details_streamers_reach_surface FOREIGN KEY (streamers_reach_surface) REFERENCES refs_data.logical_responses(code);


--
-- Name: tag_details fk_tag_details_tag_finder_id; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.tag_details
    ADD CONSTRAINT fk_tag_details_tag_finder_id FOREIGN KEY (tag_finder_id) REFERENCES ros_meta.contact(id);


--
-- Name: floatlines fltlnsllsttngprationid; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.floatlines
    ADD CONSTRAINT fltlnsllsttngprationid FOREIGN KEY (setting_operation_id) REFERENCES ros_ll.setting_operations(id);


--
-- Name: hooks_by_type hksbytypllsttngprtnsid; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.hooks_by_type
    ADD CONSTRAINT hksbytypllsttngprtnsid FOREIGN KEY (setting_operation_id) REFERENCES ros_ll.setting_operations(id);


--
-- Name: lights_by_type_and_colour lghtsbytypllsttngprtnd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.lights_by_type_and_colour
    ADD CONSTRAINT lghtsbytypllsttngprtnd FOREIGN KEY (setting_operation_id) REFERENCES ros_ll.setting_operations(id);


--
-- Name: catch_details llctchdtlsllfshngvntid; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.catch_details
    ADD CONSTRAINT llctchdtlsllfshngvntid FOREIGN KEY (fishing_event_id) REFERENCES ros_ll.fishing_events(id);


--
-- Name: fishing_events llfshngvntllsttngprtnd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.fishing_events
    ADD CONSTRAINT llfshngvntllsttngprtnd FOREIGN KEY (setting_operation_id) REFERENCES ros_ll.setting_operations(id);


--
-- Name: fishing_events llfshngvntsllhlngprtnd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.fishing_events
    ADD CONSTRAINT llfshngvntsllhlngprtnd FOREIGN KEY (hauling_operation_id) REFERENCES ros_ll.hauling_operations(id);


--
-- Name: fishing_events llfshngvntsllmtgtnmsrd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.fishing_events
    ADD CONSTRAINT llfshngvntsllmtgtnmsrd FOREIGN KEY (mitigation_measure_id) REFERENCES ros_ll.mitigation_measures(id);


--
-- Name: gear_specifications llgrspcfctionstrlndtld; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.gear_specifications
    ADD CONSTRAINT llgrspcfctionstrlndtld FOREIGN KEY (tori_line_detail_id) REFERENCES ros_ll.tori_line_details(id);


--
-- Name: gear_specifications_mitigation_device llgrspcfctllgrspcfctnd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.gear_specifications_mitigation_device
    ADD CONSTRAINT llgrspcfctllgrspcfctnd FOREIGN KEY (gear_specification_id) REFERENCES ros_ll.gear_specifications(id);


--
-- Name: hauling_offal_disposal_positions llhlngffldsllhlngprtnd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.hauling_offal_disposal_positions
    ADD CONSTRAINT llhlngffldsllhlngprtnd FOREIGN KEY (hauling_operation_id) REFERENCES ros_ll.hauling_operations(id);


--
-- Name: specimens llllddtnlctchdtlsnsssd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.specimens
    ADD CONSTRAINT llllddtnlctchdtlsnsssd FOREIGN KEY (additional_catch_details_on_ssis_id) REFERENCES ros_ll.additional_catch_details_on_ssi(id);


--
-- Name: mitigation_measures_mitigation_devices llmtgtnmsrsllmtgtnmsrd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.mitigation_measures_mitigation_devices
    ADD CONSTRAINT llmtgtnmsrsllmtgtnmsrd FOREIGN KEY (mitigation_measure_id) REFERENCES ros_ll.mitigation_measures(id);


--
-- Name: specimens llspcimenslltgdetailid; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.specimens
    ADD CONSTRAINT llspcimenslltgdetailid FOREIGN KEY (tag_detail_id) REFERENCES ros_ll.tag_details(id);


--
-- Name: specimens llspcmnsbmtrcnfrmtonid; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.specimens
    ADD CONSTRAINT llspcmnsbmtrcnfrmtonid FOREIGN KEY (biometric_information_id) REFERENCES ros_common.biometric_information(id);


--
-- Name: specimens llspcmnsllctchdetailid; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.specimens
    ADD CONSTRAINT llspcmnsllctchdetailid FOREIGN KEY (catch_detail_id) REFERENCES ros_ll.catch_details(id);


--
-- Name: specimens llspcmnslldprdtndtilid; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.specimens
    ADD CONSTRAINT llspcmnslldprdtndtilid FOREIGN KEY (depredation_detail_id) REFERENCES ros_common.depredation_details(id);


--
-- Name: setting_operations_target_species llsttngprllsttngprtnsd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: -
--

ALTER TABLE ONLY ros_ll.setting_operations_target_species
    ADD CONSTRAINT llsttngprllsttngprtnsd FOREIGN KEY (setting_operation_id) REFERENCES ros_ll.setting_operations(id);


--
-- Name: focal_point fk_ros_meta_contact_id_focal_point; Type: FK CONSTRAINT; Schema: ros_meta; Owner: -
--

ALTER TABLE ONLY ros_meta.focal_point
    ADD CONSTRAINT fk_ros_meta_contact_id_focal_point FOREIGN KEY (contact_id) REFERENCES ros_meta.contact(id);


--
-- Name: observer fk_ros_meta_contact_id_observer; Type: FK CONSTRAINT; Schema: ros_meta; Owner: -
--

ALTER TABLE ONLY ros_meta.observer
    ADD CONSTRAINT fk_ros_meta_contact_id_observer FOREIGN KEY (contact_id) REFERENCES ros_meta.contact(id);


--
-- Name: vessel fk_ros_meta_flag_code_vessel; Type: FK CONSTRAINT; Schema: ros_meta; Owner: -
--

ALTER TABLE ONLY ros_meta.vessel
    ADD CONSTRAINT fk_ros_meta_flag_code_vessel FOREIGN KEY (flag_code) REFERENCES refs_admin.countries(code);


--
-- Name: vessel fk_ros_meta_main_fishing_gear_code_vessel; Type: FK CONSTRAINT; Schema: ros_meta; Owner: -
--

ALTER TABLE ONLY ros_meta.vessel
    ADD CONSTRAINT fk_ros_meta_main_fishing_gear_code_vessel FOREIGN KEY (main_fishing_gear_code) REFERENCES refs_fishery_config.gears(code);


--
-- Name: contact fk_ros_meta_nationality_code_contact; Type: FK CONSTRAINT; Schema: ros_meta; Owner: -
--

ALTER TABLE ONLY ros_meta.contact
    ADD CONSTRAINT fk_ros_meta_nationality_code_contact FOREIGN KEY (nationality_code) REFERENCES refs_admin.countries(code);


--
-- Name: observer_accreditation fk_ros_meta_observer_accreditation_accredited; Type: FK CONSTRAINT; Schema: ros_meta; Owner: -
--

ALTER TABLE ONLY ros_meta.observer_accreditation
    ADD CONSTRAINT fk_ros_meta_observer_accreditation_accredited FOREIGN KEY (accredited_by) REFERENCES refs_admin.countries(code);


--
-- Name: observer_accreditation fk_ros_meta_observer_accreditation_observer_id; Type: FK CONSTRAINT; Schema: ros_meta; Owner: -
--

ALTER TABLE ONLY ros_meta.observer_accreditation
    ADD CONSTRAINT fk_ros_meta_observer_accreditation_observer_id FOREIGN KEY (observer_id) REFERENCES ros_meta.observer(contact_id);


--
-- Name: observer_identifier_mapping fk_ros_meta_observer_identifier_mapping; Type: FK CONSTRAINT; Schema: ros_meta; Owner: -
--

ALTER TABLE ONLY ros_meta.observer_identifier_mapping
    ADD CONSTRAINT fk_ros_meta_observer_identifier_mapping FOREIGN KEY (iotc_observer_identifier) REFERENCES ros_meta.observer(iotc_observer_identifier);


--
-- Name: vessel fk_ros_meta_port_code_vessel; Type: FK CONSTRAINT; Schema: ros_meta; Owner: -
--

ALTER TABLE ONLY ros_meta.vessel
    ADD CONSTRAINT fk_ros_meta_port_code_vessel FOREIGN KEY (port_code) REFERENCES refs_admin.ports(code);


--
-- Name: vessel_licensed_target_species fk_ros_meta_vessel_licensed_target_species_species_code; Type: FK CONSTRAINT; Schema: ros_meta; Owner: -
--

ALTER TABLE ONLY ros_meta.vessel_licensed_target_species
    ADD CONSTRAINT fk_ros_meta_vessel_licensed_target_species_species_code FOREIGN KEY (licensed_target_species_code) REFERENCES refs_biology.species(code);


--
-- Name: vessel_licensed_target_species fk_ros_meta_vessel_licensed_target_species_vessel_id; Type: FK CONSTRAINT; Schema: ros_meta; Owner: -
--

ALTER TABLE ONLY ros_meta.vessel_licensed_target_species
    ADD CONSTRAINT fk_ros_meta_vessel_licensed_target_species_vessel_id FOREIGN KEY (vessel_id) REFERENCES ros_meta.vessel(id);


--
-- Name: bait_fishing_events btfshngvplbtfshngprtnd; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.bait_fishing_events
    ADD CONSTRAINT btfshngvplbtfshngprtnd FOREIGN KEY (bait_fishing_operation_id) REFERENCES ros_pl.bait_fishing_operations(id);


--
-- Name: specimens ddtnlspcmndtlsnntrgtsp; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.specimens
    ADD CONSTRAINT ddtnlspcmndtlsnntrgtsp FOREIGN KEY (additional_specimen_details_non_target_species_id) REFERENCES ros_common.additional_details_on_non_target_species(id);


--
-- Name: additional_catch_details_on_ssi fk_ros_pl_additional_catch_details_on_ssi_brought_on_board; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.additional_catch_details_on_ssi
    ADD CONSTRAINT fk_ros_pl_additional_catch_details_on_ssi_brought_on_board FOREIGN KEY (brought_on_board) REFERENCES refs_data.logical_responses(code);


--
-- Name: additional_catch_details_on_ssi fk_ros_pl_additional_catch_details_on_ssi_revival; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.additional_catch_details_on_ssi
    ADD CONSTRAINT fk_ros_pl_additional_catch_details_on_ssi_revival FOREIGN KEY (revival) REFERENCES refs_data.logical_responses(code);


--
-- Name: baits_and_conditions fk_ros_pl_bait_condition_code_baits_and_conditions; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.baits_and_conditions
    ADD CONSTRAINT fk_ros_pl_bait_condition_code_baits_and_conditions FOREIGN KEY (bait_condition_code) REFERENCES refs_biology.bait_conditions(code);


--
-- Name: bait_fishing_events fk_ros_pl_bait_fishing_events_trip; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.bait_fishing_events
    ADD CONSTRAINT fk_ros_pl_bait_fishing_events_trip FOREIGN KEY (trip_id) REFERENCES ros_common.trip(id);


--
-- Name: bait_fishing_operations fk_ros_pl_bait_fishing_method_code_bait_fishing_operations; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.bait_fishing_operations
    ADD CONSTRAINT fk_ros_pl_bait_fishing_method_code_bait_fishing_operations FOREIGN KEY (bait_fishing_method_code) REFERENCES refs_fishery.bait_fishing_methods(code);


--
-- Name: catch_details fk_ros_pl_estimated_weight_sampling_method_code_pl_catch_detail; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.catch_details
    ADD CONSTRAINT fk_ros_pl_estimated_weight_sampling_method_code_pl_catch_detail FOREIGN KEY (estimated_weight_sampling_method_code) REFERENCES refs_biology.sampling_methods_for_catch_estimation(code);


--
-- Name: catch_details fk_ros_pl_fates_code_pl_catch_details; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.catch_details
    ADD CONSTRAINT fk_ros_pl_fates_code_pl_catch_details FOREIGN KEY (fates_code, type_of_fate_code) REFERENCES refs_biology.fates(code, type_of_fate_code);


--
-- Name: additional_catch_details_on_ssi fk_ros_pl_gear_interaction_code_pl_additional_catch_details_on_; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.additional_catch_details_on_ssi
    ADD CONSTRAINT fk_ros_pl_gear_interaction_code_pl_additional_catch_details_on_ FOREIGN KEY (gear_interaction_code) REFERENCES refs_biology.gear_interactions(code);


--
-- Name: gear_specifications fk_ros_pl_gear_specifications_hook_type_code; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.gear_specifications
    ADD CONSTRAINT fk_ros_pl_gear_specifications_hook_type_code FOREIGN KEY (hook_type_code) REFERENCES refs_fishery.hook_and_terminal_devices(code);


--
-- Name: gear_specifications fk_ros_pl_gear_specifications_trip; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.gear_specifications
    ADD CONSTRAINT fk_ros_pl_gear_specifications_trip FOREIGN KEY (trip_id) REFERENCES ros_common.trip(id);


--
-- Name: additional_catch_details_on_ssi fk_ros_pl_handling_method_code_pl_additional_catch_details_on_s; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.additional_catch_details_on_ssi
    ADD CONSTRAINT fk_ros_pl_handling_method_code_pl_additional_catch_details_on_s FOREIGN KEY (handling_method_code) REFERENCES refs_biology.handling_methods(code);


--
-- Name: lures_or_jiggers_by_type fk_ros_pl_hook_type_code_lures_or_jiggers_by_type; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.lures_or_jiggers_by_type
    ADD CONSTRAINT fk_ros_pl_hook_type_code_lures_or_jiggers_by_type FOREIGN KEY (hook_type_code) REFERENCES refs_fishery.hook_and_terminal_devices(code);


--
-- Name: lures_or_jiggers_by_type fk_ros_pl_lures_or_jiggers_by_type_gear_specifications_id; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.lures_or_jiggers_by_type
    ADD CONSTRAINT fk_ros_pl_lures_or_jiggers_by_type_gear_specifications_id FOREIGN KEY (gear_specification_id) REFERENCES ros_pl.gear_specifications(id);


--
-- Name: bait_fishing_operations fk_ros_pl_sampling_protocol_code_bait_fishing_operations; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.bait_fishing_operations
    ADD CONSTRAINT fk_ros_pl_sampling_protocol_code_bait_fishing_operations FOREIGN KEY (sampling_protocol_code) REFERENCES refs_biology.sampling_protocols(code);


--
-- Name: tuna_fishing_operations_cl_school_sighting_cues fk_ros_pl_school_sighting_cue_code_pl_tuna_fishing_operations_c; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.tuna_fishing_operations_cl_school_sighting_cues
    ADD CONSTRAINT fk_ros_pl_school_sighting_cue_code_pl_tuna_fishing_operations_c FOREIGN KEY (school_sighting_cue_code) REFERENCES refs_fishery.school_sighting_cues(code);


--
-- Name: baits_and_conditions fk_ros_pl_species_code_baits_and_conditions; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.baits_and_conditions
    ADD CONSTRAINT fk_ros_pl_species_code_baits_and_conditions FOREIGN KEY (species_code) REFERENCES refs_biology.species(code);


--
-- Name: catch_details fk_ros_pl_species_code_pl_catch_details; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.catch_details
    ADD CONSTRAINT fk_ros_pl_species_code_pl_catch_details FOREIGN KEY (species_code) REFERENCES refs_biology.species(code);


--
-- Name: tag_details fk_ros_pl_tag_details_tag_recovery; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.tag_details
    ADD CONSTRAINT fk_ros_pl_tag_details_tag_recovery FOREIGN KEY (tag_recovery) REFERENCES refs_data.logical_responses(code);


--
-- Name: tag_details fk_ros_pl_tag_details_tag_release; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.tag_details
    ADD CONSTRAINT fk_ros_pl_tag_details_tag_release FOREIGN KEY (tag_release) REFERENCES refs_data.logical_responses(code);


--
-- Name: tag_details fk_ros_pl_tag_type_code_pl_tag_details; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.tag_details
    ADD CONSTRAINT fk_ros_pl_tag_type_code_pl_tag_details FOREIGN KEY (tag_type_code) REFERENCES refs_biology.tag_types(code);


--
-- Name: tuna_fishing_operations_target_species fk_ros_pl_target_species_code_pl_tuna_fishing_operations_target; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.tuna_fishing_operations_target_species
    ADD CONSTRAINT fk_ros_pl_target_species_code_pl_tuna_fishing_operations_target FOREIGN KEY (target_species_code) REFERENCES refs_biology.species(code);


--
-- Name: tuna_fishing_events fk_ros_pl_tuna_fishing_events_trip; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.tuna_fishing_events
    ADD CONSTRAINT fk_ros_pl_tuna_fishing_events_trip FOREIGN KEY (trip_id) REFERENCES ros_common.trip(id);


--
-- Name: tuna_fishing_operations fk_ros_pl_tuna_fishing_operations_bait_used; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.tuna_fishing_operations
    ADD CONSTRAINT fk_ros_pl_tuna_fishing_operations_bait_used FOREIGN KEY (bait_used) REFERENCES refs_data.logical_responses(code);


--
-- Name: tag_details fk_tag_details_tag_finder_id; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.tag_details
    ADD CONSTRAINT fk_tag_details_tag_finder_id FOREIGN KEY (tag_finder_id) REFERENCES ros_meta.contact(id);


--
-- Name: bait_fishing_event_pl_catch_detail plbtfshngplbtfshngvntd; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.bait_fishing_event_pl_catch_detail
    ADD CONSTRAINT plbtfshngplbtfshngvntd FOREIGN KEY (bait_fishing_event_id) REFERENCES ros_pl.bait_fishing_events(id);


--
-- Name: specimens plplddtnlctchdtlsnsssd; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.specimens
    ADD CONSTRAINT plplddtnlctchdtlsnsssd FOREIGN KEY (additional_catch_details_on_ssis_id) REFERENCES ros_pl.additional_catch_details_on_ssi(id);


--
-- Name: specimens plspcimenspltgdetailid; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.specimens
    ADD CONSTRAINT plspcimenspltgdetailid FOREIGN KEY (tag_detail_id) REFERENCES ros_pl.tag_details(id);


--
-- Name: specimens plspcmnsbmtrcnfrmtonid; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.specimens
    ADD CONSTRAINT plspcmnsbmtrcnfrmtonid FOREIGN KEY (biometric_information_id) REFERENCES ros_common.biometric_information(id);


--
-- Name: specimens plspcmnsplctchdetailid; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.specimens
    ADD CONSTRAINT plspcmnsplctchdetailid FOREIGN KEY (catch_detail_id) REFERENCES ros_pl.catch_details(id);


--
-- Name: specimens plspcmnspldprdtndtilid; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.specimens
    ADD CONSTRAINT plspcmnspldprdtndtilid FOREIGN KEY (depredation_detail_id) REFERENCES ros_common.depredation_details(id);


--
-- Name: tuna_fishing_event_pl_catch_detail pltnfshngpltnfshngvntd; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.tuna_fishing_event_pl_catch_detail
    ADD CONSTRAINT pltnfshngpltnfshngvntd FOREIGN KEY (tuna_fishing_event_id) REFERENCES ros_pl.tuna_fishing_events(id);


--
-- Name: tuna_fishing_operations_cl_school_sighting_cues pltnfshngpplfshngprtnd; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.tuna_fishing_operations_cl_school_sighting_cues
    ADD CONSTRAINT pltnfshngpplfshngprtnd FOREIGN KEY (fishing_operation_id) REFERENCES ros_pl.tuna_fishing_operations(id);


--
-- Name: tuna_fishing_operations pltnfshngprtbtndcndtnd; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.tuna_fishing_operations
    ADD CONSTRAINT pltnfshngprtbtndcndtnd FOREIGN KEY (bait_and_condition_id) REFERENCES ros_pl.baits_and_conditions(id);


--
-- Name: tuna_fishing_event_pl_catch_detail pltnfshngvntplctchdtld; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.tuna_fishing_event_pl_catch_detail
    ADD CONSTRAINT pltnfshngvntplctchdtld FOREIGN KEY (catch_detail_id) REFERENCES ros_pl.catch_details(id);


--
-- Name: tuna_fishing_operations_target_species pltnfshpltnfshngprtnd2; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.tuna_fishing_operations_target_species
    ADD CONSTRAINT pltnfshpltnfshngprtnd2 FOREIGN KEY (tuna_fishing_operation_id) REFERENCES ros_pl.tuna_fishing_operations(id);


--
-- Name: tuna_fishing_events tnfshngvntsplbjctdtlid; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.tuna_fishing_events
    ADD CONSTRAINT tnfshngvntsplbjctdtlid FOREIGN KEY (object_detail_id) REFERENCES ros_pl.object_details(id);


--
-- Name: tuna_fishing_events tnfshngvpltnfshngprtnd; Type: FK CONSTRAINT; Schema: ros_pl; Owner: -
--

ALTER TABLE ONLY ros_pl.tuna_fishing_events
    ADD CONSTRAINT tnfshngvpltnfshngprtnd FOREIGN KEY (tuna_fishing_operation_id) REFERENCES ros_pl.tuna_fishing_operations(id);


--
-- Name: cetaceans_whale_shark_sightings ctcnswhlshpssttngprtnd; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.cetaceans_whale_shark_sightings
    ADD CONSTRAINT ctcnswhlshpssttngprtnd FOREIGN KEY (setting_operation_id) REFERENCES ros_ps.setting_operations(id);


--
-- Name: specimens ddtnlspcmndtlsnntrgtsp; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.specimens
    ADD CONSTRAINT ddtnlspcmndtlsnntrgtsp FOREIGN KEY (additional_specimen_details_non_target_species_id) REFERENCES ros_common.additional_details_on_non_target_species(id);


--
-- Name: additional_catch_details_on_ssi fk_ros_ps_additional_catch_details_on_ssi_brought_on_board; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.additional_catch_details_on_ssi
    ADD CONSTRAINT fk_ros_ps_additional_catch_details_on_ssi_brought_on_board FOREIGN KEY (brought_on_board) REFERENCES refs_data.logical_responses(code);


--
-- Name: additional_catch_details_on_ssi fk_ros_ps_additional_catch_details_on_ssi_revival; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.additional_catch_details_on_ssi
    ADD CONSTRAINT fk_ros_ps_additional_catch_details_on_ssi_revival FOREIGN KEY (revival) REFERENCES refs_data.logical_responses(code);


--
-- Name: cetaceans_whale_shark_sightings fk_ros_ps_cetaceans_whale_shark_sightings_caught_inside_the_net; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.cetaceans_whale_shark_sightings
    ADD CONSTRAINT fk_ros_ps_cetaceans_whale_shark_sightings_caught_inside_the_net FOREIGN KEY (caught_inside_the_net) REFERENCES refs_data.logical_responses(code);


--
-- Name: cetaceans_whale_shark_sightings fk_ros_ps_cetaceans_whale_shark_sightings_sighting_occurred_bef; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.cetaceans_whale_shark_sightings
    ADD CONSTRAINT fk_ros_ps_cetaceans_whale_shark_sightings_sighting_occurred_bef FOREIGN KEY (sighting_occurred_before_setting) REFERENCES refs_data.logical_responses(code);


--
-- Name: catch_details fk_ros_ps_estimated_weight_sampling_method_code_ps_catch_detail; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.catch_details
    ADD CONSTRAINT fk_ros_ps_estimated_weight_sampling_method_code_ps_catch_detail FOREIGN KEY (estimated_weight_sampling_method_code) REFERENCES refs_biology.sampling_methods_for_catch_estimation(code);


--
-- Name: object_details fk_ros_ps_fad_raft_design_code_ps_object_details; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.object_details
    ADD CONSTRAINT fk_ros_ps_fad_raft_design_code_ps_object_details FOREIGN KEY (fad_raft_design_code) REFERENCES refs_fishery.fad_raft_designs(code);


--
-- Name: object_details fk_ros_ps_fad_tail_design_code_ps_object_details; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.object_details
    ADD CONSTRAINT fk_ros_ps_fad_tail_design_code_ps_object_details FOREIGN KEY (fad_tail_design_code) REFERENCES refs_fishery.fad_tail_designs(code);


--
-- Name: catch_details fk_ros_ps_fates_code_ps_catch_details; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.catch_details
    ADD CONSTRAINT fk_ros_ps_fates_code_ps_catch_details FOREIGN KEY (fates_code, type_of_fate_code) REFERENCES refs_biology.fates(code, type_of_fate_code);


--
-- Name: setting_operations fk_ros_ps_first_school_detection_method_code_ps_setting_operati; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.setting_operations
    ADD CONSTRAINT fk_ros_ps_first_school_detection_method_code_ps_setting_operati FOREIGN KEY (first_school_detection_method_code) REFERENCES refs_fishery.school_detection_methods(code);


--
-- Name: fishing_events fk_ros_ps_fishing_events_trip; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.fishing_events
    ADD CONSTRAINT fk_ros_ps_fishing_events_trip FOREIGN KEY (trip_id) REFERENCES ros_common.trip(id);


--
-- Name: additional_catch_details_on_ssi fk_ros_ps_gear_interaction_code_ps_additional_catch_details_on_; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.additional_catch_details_on_ssi
    ADD CONSTRAINT fk_ros_ps_gear_interaction_code_ps_additional_catch_details_on_ FOREIGN KEY (gear_interaction_code) REFERENCES refs_biology.gear_interactions(code);


--
-- Name: gear_specifications fk_ros_ps_gear_specifications_power_block; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.gear_specifications
    ADD CONSTRAINT fk_ros_ps_gear_specifications_power_block FOREIGN KEY (power_block) REFERENCES refs_data.logical_responses(code);


--
-- Name: gear_specifications fk_ros_ps_gear_specifications_purse_winch; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.gear_specifications
    ADD CONSTRAINT fk_ros_ps_gear_specifications_purse_winch FOREIGN KEY (purse_winch) REFERENCES refs_data.logical_responses(code);


--
-- Name: gear_specifications fk_ros_ps_gear_specifications_trip; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.gear_specifications
    ADD CONSTRAINT fk_ros_ps_gear_specifications_trip FOREIGN KEY (trip_id) REFERENCES ros_common.trip(id);


--
-- Name: additional_catch_details_on_ssi fk_ros_ps_handling_method_code_ps_additional_catch_details_on_s; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.additional_catch_details_on_ssi
    ADD CONSTRAINT fk_ros_ps_handling_method_code_ps_additional_catch_details_on_s FOREIGN KEY (handling_method_code) REFERENCES refs_biology.handling_methods(code);


--
-- Name: object_details fk_ros_ps_object_details_equipped_with_artificial_lights_at_dep; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.object_details
    ADD CONSTRAINT fk_ros_ps_object_details_equipped_with_artificial_lights_at_dep FOREIGN KEY (equipped_with_artificial_lights_at_deploy) REFERENCES refs_data.logical_responses(code);


--
-- Name: object_details fk_ros_ps_object_details_equipped_with_artificial_lights_on_ret; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.object_details
    ADD CONSTRAINT fk_ros_ps_object_details_equipped_with_artificial_lights_on_ret FOREIGN KEY (equipped_with_artificial_lights_on_retrieval) REFERENCES refs_data.logical_responses(code);


--
-- Name: setting_operations_cl_school_sighting_cues fk_ros_ps_school_sighting_cue_code_ps_setting_operations_cl_sch; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.setting_operations_cl_school_sighting_cues
    ADD CONSTRAINT fk_ros_ps_school_sighting_cue_code_ps_setting_operations_cl_sch FOREIGN KEY (school_sighting_cue_code) REFERENCES refs_fishery.school_sighting_cues(code);


--
-- Name: cetaceans_whale_shark_sightings fk_ros_ps_species_code_cetaceans_whale_shark_sightings; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.cetaceans_whale_shark_sightings
    ADD CONSTRAINT fk_ros_ps_species_code_cetaceans_whale_shark_sightings FOREIGN KEY (species_code) REFERENCES refs_biology.species(code);


--
-- Name: catch_details fk_ros_ps_species_code_ps_catch_details; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.catch_details
    ADD CONSTRAINT fk_ros_ps_species_code_ps_catch_details FOREIGN KEY (species_code) REFERENCES refs_biology.species(code);


--
-- Name: tag_details fk_ros_ps_tag_details_tag_recovery; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.tag_details
    ADD CONSTRAINT fk_ros_ps_tag_details_tag_recovery FOREIGN KEY (tag_recovery) REFERENCES refs_data.logical_responses(code);


--
-- Name: tag_details fk_ros_ps_tag_details_tag_release; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.tag_details
    ADD CONSTRAINT fk_ros_ps_tag_details_tag_release FOREIGN KEY (tag_release) REFERENCES refs_data.logical_responses(code);


--
-- Name: tag_details fk_ros_ps_tag_type_code_ps_tag_details; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.tag_details
    ADD CONSTRAINT fk_ros_ps_tag_type_code_ps_tag_details FOREIGN KEY (tag_type_code) REFERENCES refs_biology.tag_types(code);


--
-- Name: tag_details fk_tag_details_tag_finder_id; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.tag_details
    ADD CONSTRAINT fk_tag_details_tag_finder_id FOREIGN KEY (tag_finder_id) REFERENCES ros_meta.contact(id);


--
-- Name: catch_details psctchdtlspsfshngvntid; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.catch_details
    ADD CONSTRAINT psctchdtlspsfshngvntid FOREIGN KEY (fishing_event_id) REFERENCES ros_ps.fishing_events(id);


--
-- Name: fishing_events psfshngvntpssttngprtnd; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.fishing_events
    ADD CONSTRAINT psfshngvntpssttngprtnd FOREIGN KEY (setting_operation_id) REFERENCES ros_ps.setting_operations(id);


--
-- Name: specimens pspsddtnlctchdtlsnsssd; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.specimens
    ADD CONSTRAINT pspsddtnlctchdtlsnsssd FOREIGN KEY (additional_catch_details_on_ssis_id) REFERENCES ros_ps.additional_catch_details_on_ssi(id);


--
-- Name: specimens psspcimenspstgdetailid; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.specimens
    ADD CONSTRAINT psspcimenspstgdetailid FOREIGN KEY (tag_detail_id) REFERENCES ros_ps.tag_details(id);


--
-- Name: specimens psspcmnsbmtrcnfrmtonid; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.specimens
    ADD CONSTRAINT psspcmnsbmtrcnfrmtonid FOREIGN KEY (biometric_information_id) REFERENCES ros_common.biometric_information(id);


--
-- Name: specimens psspcmnspsctchdetailid; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.specimens
    ADD CONSTRAINT psspcmnspsctchdetailid FOREIGN KEY (catch_detail_id) REFERENCES ros_ps.catch_details(id);


--
-- Name: setting_operations pssttngprtnspsbjctdtld; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.setting_operations
    ADD CONSTRAINT pssttngprtnspsbjctdtld FOREIGN KEY (ps_object_detail_id) REFERENCES ros_ps.object_details(id);


--
-- Name: setting_operations_cl_school_sighting_cues pssttngprtpssttngprtnd; Type: FK CONSTRAINT; Schema: ros_ps; Owner: -
--

ALTER TABLE ONLY ros_ps.setting_operations_cl_school_sighting_cues
    ADD CONSTRAINT pssttngprtpssttngprtnd FOREIGN KEY (setting_operation_id) REFERENCES ros_ps.setting_operations(id);


--
-- PostgreSQL database dump complete
--

\unrestrict ylDCc8nv5Tl3KZKiQcohXITG23SJjQlLdQj95mdML0kOGDi20ZXghXfOhIbDAQk

