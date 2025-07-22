--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9 (Ubuntu 16.9-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.9 (Ubuntu 16.9-0ubuntu0.24.04.1)

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
-- Name: refs_admin; Type: SCHEMA; Schema: -; Owner: ros-admin
--

CREATE SCHEMA refs_admin;


ALTER SCHEMA refs_admin OWNER TO "ros-admin";

--
-- Name: refs_biological; Type: SCHEMA; Schema: -; Owner: ros-admin
--

CREATE SCHEMA refs_biological;


ALTER SCHEMA refs_biological OWNER TO "ros-admin";

--
-- Name: refs_biological_config; Type: SCHEMA; Schema: -; Owner: ros-admin
--

CREATE SCHEMA refs_biological_config;


ALTER SCHEMA refs_biological_config OWNER TO "ros-admin";

--
-- Name: refs_data; Type: SCHEMA; Schema: -; Owner: ros-admin
--

CREATE SCHEMA refs_data;


ALTER SCHEMA refs_data OWNER TO "ros-admin";

--
-- Name: refs_fishery; Type: SCHEMA; Schema: -; Owner: ros-admin
--

CREATE SCHEMA refs_fishery;


ALTER SCHEMA refs_fishery OWNER TO "ros-admin";

--
-- Name: refs_fishery_config; Type: SCHEMA; Schema: -; Owner: ros-admin
--

CREATE SCHEMA refs_fishery_config;


ALTER SCHEMA refs_fishery_config OWNER TO "ros-admin";

--
-- Name: refs_gis; Type: SCHEMA; Schema: -; Owner: ros-admin
--

CREATE SCHEMA refs_gis;


ALTER SCHEMA refs_gis OWNER TO "ros-admin";

--
-- Name: refs_legacy; Type: SCHEMA; Schema: -; Owner: ros-admin
--

CREATE SCHEMA refs_legacy;


ALTER SCHEMA refs_legacy OWNER TO "ros-admin";

--
-- Name: refs_socio_economics; Type: SCHEMA; Schema: -; Owner: ros-admin
--

CREATE SCHEMA refs_socio_economics;


ALTER SCHEMA refs_socio_economics OWNER TO "ros-admin";

--
-- Name: ros_analysis; Type: SCHEMA; Schema: -; Owner: ros-admin
--

CREATE SCHEMA ros_analysis;


ALTER SCHEMA ros_analysis OWNER TO "ros-admin";

--
-- Name: ros_common; Type: SCHEMA; Schema: -; Owner: ros-admin
--

CREATE SCHEMA ros_common;


ALTER SCHEMA ros_common OWNER TO "ros-admin";

--
-- Name: ros_gn; Type: SCHEMA; Schema: -; Owner: ros-admin
--

CREATE SCHEMA ros_gn;


ALTER SCHEMA ros_gn OWNER TO "ros-admin";

--
-- Name: ros_ll; Type: SCHEMA; Schema: -; Owner: ros-admin
--

CREATE SCHEMA ros_ll;


ALTER SCHEMA ros_ll OWNER TO "ros-admin";

--
-- Name: ros_meta; Type: SCHEMA; Schema: -; Owner: ros-admin
--

CREATE SCHEMA ros_meta;


ALTER SCHEMA ros_meta OWNER TO "ros-admin";

--
-- Name: ros_pl; Type: SCHEMA; Schema: -; Owner: ros-admin
--

CREATE SCHEMA ros_pl;


ALTER SCHEMA ros_pl OWNER TO "ros-admin";

--
-- Name: ros_ps; Type: SCHEMA; Schema: -; Owner: ros-admin
--

CREATE SCHEMA ros_ps;


ALTER SCHEMA ros_ps OWNER TO "ros-admin";

--
-- Name: ros_rlibs; Type: SCHEMA; Schema: -; Owner: ros-admin
--

CREATE SCHEMA ros_rlibs;


ALTER SCHEMA ros_rlibs OWNER TO "ros-admin";

--
-- Name: ros_views; Type: SCHEMA; Schema: -; Owner: ros-admin
--

CREATE SCHEMA ros_views;


ALTER SCHEMA ros_views OWNER TO "ros-admin";

--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- Name: add_audit(); Type: PROCEDURE; Schema: public; Owner: ros-admin
--

CREATE PROCEDURE public.add_audit()
    LANGUAGE plpgsql
    AS $$
BEGIN
PERFORM public.audit_table( 'refs_admin.countries', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_admin.cpc_history', 't', 't', 't', '{cpc_code, contracting_party, acceptance_date}', '{}');
PERFORM public.audit_table( 'refs_admin.cpc_to_flags', 't', 't', 't', '{cpc_code, flag_code}', '{}');
PERFORM public.audit_table( 'refs_admin.cpcs', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_admin.entities', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_admin.fleets', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_admin.io_main_areas', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_admin.fleet_to_flags_and_fisheries', 't', 't', 't', '{flag_code, reporting_entity_code, iotc_main_area_code}', '{}');
PERFORM public.audit_table( 'refs_admin.ports', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_admin.species_reporting_requirements', 't', 't', 't', '{gear_group_code, species_code}', '{}');
PERFORM public.audit_table( 'refs_biological.bait_conditions', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_biological.bait_types', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_biological.depredation_sources', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_biological.fates', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_biological.gear_interactions', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_biological.handling_methods', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_biological.incidental_captures_conditions', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_biological.individual_conditions', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_biological.measurement_tools', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_biological.measurements', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_biological.sampling_methods_for_catch_estimation', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_biological.sampling_methods_for_sampling_collections', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_biological.sampling_periods', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_biological.sampling_protocols', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_biological.scars', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_biological.sex', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_biological.species', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_biological.species_aggregates', 't', 't', 't', '{species_aggregate_code, species_code}', '{}');
PERFORM public.audit_table( 'refs_biological.species_categories', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_biological.species_groups', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_biological.tag_types', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_biological.types_of_fate', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_biological.types_of_measurement', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_biological_config.recommended_measurements', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.activities', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.bait_fishing_methods', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.bait_school_detection_methods', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.branchline_storages', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.buoy_activity_types', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.cardinal_points', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.catch_units', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.dehooker_types', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.effort_units', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.fad_raft_designs', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.fad_tail_designs', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.fish_preservation_methods', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.fish_processing_types', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.fish_storage_types', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.fisheries', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.float_types', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.fob_activity_types', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.fob_types', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.gear_types', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.gillnet_material_types', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.hook_types', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.hull_material_types', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.light_colours', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.light_types', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.line_material_types', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.mechanization_types', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.mitigation_devices', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.net_colours', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.net_conditions', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.net_configurations', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.net_deploy_depths', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.net_setting_strategies', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.offal_management_types', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.pole_material_types', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.reasons_days_lost', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.school_detection_methods', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.school_sighting_cues', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.school_type_categories', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.sinker_material_types', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.streamer_types', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.stunning_methods', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.surface_fishery_activities', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.transhipment_categories', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.vessel_architectures', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.vessel_sections', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.vessel_size_types', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.vessel_types', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.waste_categories', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.waste_disposal_methods', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery.wind_scales', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery_config.areas_of_operation', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery_config.fishery_categories', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery_config.fishery_types', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery_config.fishery_types_bkp', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery_config.fishery_types_new', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery_config.fishing_modes', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery_config.gear_configurations', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery_config.gear_fishery_type_to_configuration', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery_config.gear_fishery_type_to_configuration_bkp', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery_config.gear_fishery_type_to_fishing_mode', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery_config.gear_fishery_type_to_fishing_mode_bkp', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery_config.gear_groups', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery_config.gear_to_fishery_type', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery_config.gear_to_fishery_type_bkp', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery_config.gear_to_fishery_type_new', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery_config.gear_to_target_species', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery_config.gears', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery_config.loa_classes', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery_config.purposes', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_fishery_config.target_species', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_gis.area_intersections', 't', 't', 't', '{source_code,target_code}', '{intersection_area}');
PERFORM public.audit_table( 'refs_gis.area_intersections_iotc', 't', 't', 't', '{source_code,target_code}','{intersection_area}');
PERFORM public.audit_table( 'refs_gis.area_types', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_gis.areas', 't', 't', 't',  '{code}', '{area_geometry, area_geometry_old}');
PERFORM public.audit_table( 'refs_socio_economics.currencies', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_socio_economics.destination_markets', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_socio_economics.pricing_locations', 't', 't', 't', '{code}', '{}');
PERFORM public.audit_table( 'refs_socio_economics.product_types', 't', 't', 't', '{code}', '{}');
END;
$$;


ALTER PROCEDURE public.add_audit() OWNER TO "ros-admin";

--
-- Name: PROCEDURE add_audit(); Type: COMMENT; Schema: public; Owner: ros-admin
--

COMMENT ON PROCEDURE public.add_audit() IS ' Add auditing support for all code-lists.';


--
-- Name: audit_table(regclass, boolean, boolean, boolean, text[], text[]); Type: FUNCTION; Schema: public; Owner: ros-admin
--

CREATE FUNCTION public.audit_table(target_table regclass, audit_rows boolean, audit_query_text boolean, audit_inserts boolean, pk_cols text[], ignored_cols text[]) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE stm_targets text = 'INSERT OR UPDATE OR DELETE OR TRUNCATE';
_q_txt text;
_ignored_cols_snip text = '';
_pk_cols text = '';
BEGIN PERFORM public.deaudit_table(target_table);
IF array_length(pk_cols, 1) > 0 THEN _pk_cols = quote_literal(pk_cols); ELSE _pk_cols= quote_literal('{code}'); END IF;

IF audit_rows THEN IF array_length(ignored_cols, 1) > 0 THEN _ignored_cols_snip = ', ' || quote_literal(ignored_cols); ELSE _ignored_cols_snip = ',' || quote_literal('{}');
END IF;
_q_txt = 'CREATE TRIGGER audit_trigger_row AFTER ' || CASE
    WHEN audit_inserts THEN 'INSERT OR '
    ELSE ''
END || 'UPDATE OR DELETE ON ' || target_table || ' FOR EACH ROW EXECUTE PROCEDURE public.if_modified_func(' || quote_literal(audit_query_text) || ',' || _pk_cols || _ignored_cols_snip  || ');';
RAISE NOTICE '%',
_q_txt;
EXECUTE _q_txt;
stm_targets = 'TRUNCATE';
ELSE
END IF;
_q_txt = 'CREATE TRIGGER audit_trigger_stm AFTER ' || stm_targets || ' ON ' || target_table || ' FOR EACH STATEMENT EXECUTE PROCEDURE public.if_modified_func(' || quote_literal(audit_query_text) || ',' || _pk_cols || ');';
RAISE NOTICE '%',
_q_txt;
EXECUTE _q_txt;
END;
$$;


ALTER FUNCTION public.audit_table(target_table regclass, audit_rows boolean, audit_query_text boolean, audit_inserts boolean, pk_cols text[], ignored_cols text[]) OWNER TO "ros-admin";

--
-- Name: FUNCTION audit_table(target_table regclass, audit_rows boolean, audit_query_text boolean, audit_inserts boolean, pk_cols text[], ignored_cols text[]); Type: COMMENT; Schema: public; Owner: ros-admin
--

COMMENT ON FUNCTION public.audit_table(target_table regclass, audit_rows boolean, audit_query_text boolean, audit_inserts boolean, pk_cols text[], ignored_cols text[]) IS '
Add auditing support to a table.Arguments: target_table: Table name,
    schema qualified if not on search_path audit_rows: Record each row change,
    or only audit at a statement level audit_query_text: Record the text of the client query that triggered the audit event ? audit_inserts: Audit
insert statements
    or only updates / deletes / truncates ? ignored_cols: Columns to exclude
from
update diffs,
    ignore updates that change only ignored cols.';


--
-- Name: deaudit_table(regclass); Type: FUNCTION; Schema: public; Owner: ros-admin
--

CREATE FUNCTION public.deaudit_table(target_table regclass) RETURNS void
    LANGUAGE plpgsql
    AS $$ BEGIN EXECUTE 'DROP TRIGGER IF EXISTS audit_trigger_row ON ' || target_table;
EXECUTE 'DROP TRIGGER IF EXISTS audit_trigger_stm ON ' || target_table;
END;
$$;


ALTER FUNCTION public.deaudit_table(target_table regclass) OWNER TO "ros-admin";

--
-- Name: FUNCTION deaudit_table(target_table regclass); Type: COMMENT; Schema: public; Owner: ros-admin
--

COMMENT ON FUNCTION public.deaudit_table(target_table regclass) IS ' Remove auditing support to the given table.';


--
-- Name: hash(character varying); Type: FUNCTION; Schema: public; Owner: ros-admin
--

CREATE FUNCTION public.hash(v_to_hash character varying) RETURNS character
    LANGUAGE plpgsql
    AS $$

BEGIN
    RETURN TO_CHAR(HashBytes('MD5', V_TO_HASH), 'YY.MM.DD');
END;
$$;


ALTER FUNCTION public.hash(v_to_hash character varying) OWNER TO "ros-admin";

--
-- Name: if_modified_func(); Type: FUNCTION; Schema: public; Owner: ros-admin
--

CREATE FUNCTION public.if_modified_func() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pg_catalog', 'public'
    AS $_$
DECLARE
    audit_row public.history;
    include_values boolean;
    log_diffs boolean;
    h_old jsonb;
    h_new jsonb;
    excluded_cols text [] = ARRAY []::text [];
    pk_columns text [] = ARRAY []::text [];
    pk_values text ;
    _col_value text ;
    a text ;
    BEGIN IF TG_WHEN <> 'AFTER' THEN RAISE EXCEPTION 'history.if_modified_func() may only run as an AFTER trigger';
END IF;
pk_values ='';
IF TG_ARGV [1] IS NOT NULL THEN pk_columns = TG_ARGV [1]::text []; ELSE pk_columns = ARRAY ['code']::text [];
END IF;
    RAISE NOTICE 'pk_columns: %', pk_columns;
    FOREACH a IN ARRAY pk_columns LOOP
        EXECUTE format('SELECT ($1).%s::text', a) USING OLD INTO _col_value;
        pk_values = pk_values || ',' || COALESCE(_col_value, NULL) ;
        end loop;
pk_values = substring(pk_values, 2);
    RAISE NOTICE 'pk_values: %', pk_values;
audit_row = ROW(
    nextval('public.history_event_id_seq'),
    -- event_id
    TG_TABLE_SCHEMA::text,
    -- schema_name
    TG_TABLE_NAME::text,
    -- table_name
    TG_RELID,
    -- relation OID for much quicker searches
    session_user::text,
    -- session_user_name
    current_timestamp,
    -- action_tstamp_tx
    statement_timestamp(),
    -- action_tstamp_stm
    clock_timestamp(),
    -- action_tstamp_clk
    txid_current(),
    -- transaction ID
    current_setting('application_name'),
    -- client application
    inet_client_addr(),
    -- client_addr
    inet_client_port(),
    -- client_port
    current_query(),
    -- top-level query or queries (if multistatement) from client
    substring(TG_OP, 1, 1),
    -- action
    NULL,
    NULL,
    -- row_data, changed_fields
    'f', -- statement_only,
    pk_values -- pk ID of the row
);
IF NOT TG_ARGV [0]::boolean IS DISTINCT
FROM 'f'::boolean THEN audit_row.client_query = NULL;
END IF;
IF TG_ARGV [2] IS NOT NULL THEN excluded_cols = TG_ARGV [2]::text [];
END IF;

IF (
    TG_OP = 'UPDATE'
    AND TG_LEVEL = 'ROW'
) THEN audit_row.row_data = row_to_json(OLD)::JSONB - excluded_cols;
--Computing differences
SELECT jsonb_object_agg(tmp_new_row.key, tmp_new_row.value) AS new_data INTO audit_row.changed_fields
FROM jsonb_each_text(row_to_json(NEW)::JSONB) AS tmp_new_row
    JOIN jsonb_each_text(audit_row.row_data) AS tmp_old_row ON (
        tmp_new_row.key = tmp_old_row.key
        AND tmp_new_row.value IS DISTINCT
        FROM tmp_old_row.value
    );
IF audit_row.changed_fields = '{}'::JSONB THEN -- All changed fields are ignored. Skip this update.
RETURN NULL;
END IF;
ELSIF (
    TG_OP = 'DELETE'
    AND TG_LEVEL = 'ROW'
) THEN audit_row.row_data = row_to_json(OLD)::JSONB - excluded_cols;
ELSIF (
    TG_OP = 'INSERT'
    AND TG_LEVEL = 'ROW'
) THEN audit_row.row_data = row_to_json(NEW)::JSONB - excluded_cols;
ELSIF (
    TG_LEVEL = 'STATEMENT'
    AND TG_OP IN ('INSERT', 'UPDATE', 'DELETE', 'TRUNCATE')
) THEN audit_row.statement_only = 't';
ELSE RAISE EXCEPTION '[history.if_modified_func] - Trigger func added as trigger for unhandled case: %, %',
TG_OP,
TG_LEVEL;
RETURN NULL;
END IF;
INSERT INTO public.history(event_id, schema_name, table_name, relid, session_user_name, action_tstamp_tx, action_tstamp_stm, action_tstamp_clk, transaction_id, application_name, client_addr, client_port, client_query, action, row_data, changed_fields, statement_only, row_id)
VALUES (audit_row.event_id, audit_row.schema_name, audit_row.table_name, audit_row.relid, audit_row.session_user_name, audit_row.action_tstamp_tx, audit_row.action_tstamp_stm, audit_row.action_tstamp_clk, audit_row.transaction_id, audit_row.application_name, audit_row.client_addr, audit_row.client_port, audit_row.client_query, audit_row.action, audit_row.row_data, audit_row.changed_fields, audit_row.statement_only, audit_row.row_id);
RETURN NULL;
END;
$_$;


ALTER FUNCTION public.if_modified_func() OWNER TO "ros-admin";

--
-- Name: FUNCTION if_modified_func(); Type: COMMENT; Schema: public; Owner: ros-admin
--

COMMENT ON FUNCTION public.if_modified_func() IS ' Track changes to a table at the statement
and /
or row level.Optional parameters to trigger in CREATE TRIGGER call: param 0: boolean,
whether to log the query text.Default ''t''.param 1: text [],
columns to ignore in updates.Default [].Updates to ignored cols are omitted
from changed_fields.Updates with only ignored cols changed are not inserted into the audit log.Almost all the processing work is still done for updates that ignored.If you need to save the load,
    you need to use
    WHEN clause on the trigger instead.No warning
    or error is issued if ignored_cols contains columns that do not exist in the target table.This lets you specify a standard
set of ignored columns.There is no parameter to disable logging of
values.
Add this trigger as a ''FOR EACH STATEMENT'' rather than ''FOR EACH ROW'' trigger if you do not want to log row
values.Note that the user name logged is the login role for the session.The audit trigger cannot obtain the active role because it is reset by the SECURITY DEFINER invocation of the audit trigger its self.';


--
-- Name: md5(character varying); Type: FUNCTION; Schema: public; Owner: ros-admin
--

CREATE FUNCTION public.md5(v_in character varying) RETURNS character
    LANGUAGE plpgsql
    AS $$

BEGIN
    RETURN TO_CHAR(HashBytes('MD5', V_IN), 'YY.MM.DD');
END;
$$;


ALTER FUNCTION public.md5(v_in character varying) OWNER TO "ros-admin";

--
-- Name: remove_audit(); Type: PROCEDURE; Schema: public; Owner: ros-admin
--

CREATE PROCEDURE public.remove_audit()
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM pg_catalog.pg_trigger where tgname='audit_trigger_stm' OR tgname='audit_trigger_row';
    COMMIT ;
    END;
$$;


ALTER PROCEDURE public.remove_audit() OWNER TO "ros-admin";

--
-- Name: PROCEDURE remove_audit(); Type: COMMENT; Schema: public; Owner: ros-admin
--

COMMENT ON PROCEDURE public.remove_audit() IS ' Remove auditing support for all code-lists.';


--
-- Name: validate_io_main_area(character varying); Type: FUNCTION; Schema: refs_admin; Owner: ros-admin
--

CREATE FUNCTION refs_admin.validate_io_main_area(v_code character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$

DECLARE
  V_retval int;

BEGIN
   SELECT CASE WHEN V_CODE IS NULL OR V_CODE IN ('IO_EAST', 'IO_WEST') THEN 1 ELSE 0 END INTO V_retval;
   RETURN 1; --@retval
END; $$;


ALTER FUNCTION refs_admin.validate_io_main_area(v_code character varying) OWNER TO "ros-admin";

--
-- Name: validate_iotc_main_area(character varying); Type: FUNCTION; Schema: refs_admin; Owner: ros-admin
--

CREATE FUNCTION refs_admin.validate_iotc_main_area(v_code character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$

DECLARE
  V_retval int;

BEGIN
   SELECT CASE WHEN V_CODE IS NULL OR V_CODE IN ('IOTC_EAST', 'IOTC_WEST') THEN 1 ELSE 0 END INTO V_retval;
   RETURN 1; --@retval
END; $$;


ALTER FUNCTION refs_admin.validate_iotc_main_area(v_code character varying) OWNER TO "ros-admin";

--
-- Name: coords_to_grid_1(integer, integer, character, integer, integer, character); Type: FUNCTION; Schema: ros_meta; Owner: ros-admin
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


ALTER FUNCTION ros_meta.coords_to_grid_1(v_lat_deg integer, v_lat_min integer, v_lat_emi character, v_lon_deg integer, v_lon_min integer, v_lon_emi character) OWNER TO "ros-admin";

--
-- Name: coords_to_grid_5(integer, integer, character, integer, integer, character); Type: FUNCTION; Schema: ros_meta; Owner: ros-admin
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


ALTER FUNCTION ros_meta.coords_to_grid_5(v_lat_deg integer, v_lat_min integer, v_lat_emi character, v_lon_deg integer, v_lon_min integer, v_lon_emi character) OWNER TO "ros-admin";

--
-- Name: latlon_to_grid_1(double precision, double precision); Type: FUNCTION; Schema: ros_meta; Owner: ros-admin
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


ALTER FUNCTION ros_meta.latlon_to_grid_1(v_lat double precision, v_lon double precision) OWNER TO "ros-admin";

--
-- Name: latlon_to_grid_5(double precision, double precision); Type: FUNCTION; Schema: ros_meta; Owner: ros-admin
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


ALTER FUNCTION ros_meta.latlon_to_grid_5(v_lat double precision, v_lon double precision) OWNER TO "ros-admin";

--
-- Name: password_hash(character varying, character varying); Type: FUNCTION; Schema: ros_meta; Owner: ros-admin
--

CREATE FUNCTION ros_meta.password_hash(v_username character varying, v_password character varying) RETURNS character
    LANGUAGE plpgsql
    AS $$

BEGIN
    RETURN HASH(CONCAT('ROS_', V_password, '_', V_username));
END;
$$;


ALTER FUNCTION ros_meta.password_hash(v_username character varying, v_password character varying) OWNER TO "ros-admin";

--
-- Name: to_grid_1(double precision, double precision); Type: FUNCTION; Schema: ros_meta; Owner: ros-admin
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


ALTER FUNCTION ros_meta.to_grid_1(v_lat double precision, v_lon double precision) OWNER TO "ros-admin";

--
-- Name: to_grid_5(double precision, double precision); Type: FUNCTION; Schema: ros_meta; Owner: ros-admin
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


ALTER FUNCTION ros_meta.to_grid_5(v_lat double precision, v_lon double precision) OWNER TO "ros-admin";

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: history; Type: TABLE; Schema: public; Owner: ros-admin
--

CREATE TABLE public.history (
    event_id bigint,
    schema_name text,
    table_name text,
    relid oid,
    session_user_name text,
    action_tstamp_tx timestamp with time zone,
    action_tstamp_stm timestamp with time zone,
    action_tstamp_clk timestamp with time zone,
    transaction_id bigint,
    application_name text,
    client_addr inet,
    client_port integer,
    client_query text,
    action text,
    row_data jsonb,
    changed_fields jsonb,
    statement_only boolean,
    row_id character varying(50),
    doi character varying(512),
    doi_version character varying(512)
);


ALTER TABLE public.history OWNER TO "ros-admin";

--
-- Name: TABLE history; Type: COMMENT; Schema: public; Owner: ros-admin
--

COMMENT ON TABLE public.history IS 'History of auditable actions on audited tables, from public.if_modified_func()';


--
-- Name: COLUMN history.event_id; Type: COMMENT; Schema: public; Owner: ros-admin
--

COMMENT ON COLUMN public.history.event_id IS 'Unique identifier for each auditable event';


--
-- Name: COLUMN history.schema_name; Type: COMMENT; Schema: public; Owner: ros-admin
--

COMMENT ON COLUMN public.history.schema_name IS 'Database schema audited table for this event is in';


--
-- Name: COLUMN history.table_name; Type: COMMENT; Schema: public; Owner: ros-admin
--

COMMENT ON COLUMN public.history.table_name IS 'Non-schema-qualified table name of table event occured in';


--
-- Name: COLUMN history.relid; Type: COMMENT; Schema: public; Owner: ros-admin
--

COMMENT ON COLUMN public.history.relid IS 'Table OID. Changes with drop/create. Get with ''tablename''::regclass';


--
-- Name: COLUMN history.session_user_name; Type: COMMENT; Schema: public; Owner: ros-admin
--

COMMENT ON COLUMN public.history.session_user_name IS 'Login / session user whose statement caused the audited event';


--
-- Name: COLUMN history.action_tstamp_tx; Type: COMMENT; Schema: public; Owner: ros-admin
--

COMMENT ON COLUMN public.history.action_tstamp_tx IS 'Transaction start timestamp for tx in which audited event occurred';


--
-- Name: COLUMN history.action_tstamp_stm; Type: COMMENT; Schema: public; Owner: ros-admin
--

COMMENT ON COLUMN public.history.action_tstamp_stm IS 'Statement start timestamp for tx in which audited event occurred';


--
-- Name: COLUMN history.action_tstamp_clk; Type: COMMENT; Schema: public; Owner: ros-admin
--

COMMENT ON COLUMN public.history.action_tstamp_clk IS 'Wall clock time at which audited event''s trigger call occurred';


--
-- Name: COLUMN history.transaction_id; Type: COMMENT; Schema: public; Owner: ros-admin
--

COMMENT ON COLUMN public.history.transaction_id IS 'Identifier of transaction that made the change. May wrap, but unique paired with action_tstamp_tx.';


--
-- Name: COLUMN history.application_name; Type: COMMENT; Schema: public; Owner: ros-admin
--

COMMENT ON COLUMN public.history.application_name IS 'Application name set when this audit event occurred. Can be changed in-session by client.';


--
-- Name: COLUMN history.client_addr; Type: COMMENT; Schema: public; Owner: ros-admin
--

COMMENT ON COLUMN public.history.client_addr IS 'IP address of client that issued query. Null for unix domain socket.';


--
-- Name: COLUMN history.client_port; Type: COMMENT; Schema: public; Owner: ros-admin
--

COMMENT ON COLUMN public.history.client_port IS 'Remote peer IP port address of client that issued query. Undefined for unix socket.';


--
-- Name: COLUMN history.client_query; Type: COMMENT; Schema: public; Owner: ros-admin
--

COMMENT ON COLUMN public.history.client_query IS 'Top-level query that caused this auditable event. May be more than one statement.';


--
-- Name: COLUMN history.action; Type: COMMENT; Schema: public; Owner: ros-admin
--

COMMENT ON COLUMN public.history.action IS 'Action type; I = insert, D = delete, U = update, T = truncate';


--
-- Name: COLUMN history.row_data; Type: COMMENT; Schema: public; Owner: ros-admin
--

COMMENT ON COLUMN public.history.row_data IS 'Record value. Null for statement-level trigger. For INSERT this is the new tuple. For DELETE and UPDATE it is the old tuple.';


--
-- Name: COLUMN history.changed_fields; Type: COMMENT; Schema: public; Owner: ros-admin
--

COMMENT ON COLUMN public.history.changed_fields IS 'New values of fields changed by UPDATE. Null except for row-level UPDATE events.';


--
-- Name: COLUMN history.statement_only; Type: COMMENT; Schema: public; Owner: ros-admin
--

COMMENT ON COLUMN public.history.statement_only IS '''t'' if audit event is from an FOR EACH STATEMENT trigger, ''f'' for FOR EACH ROW';


--
-- Name: COLUMN history.doi; Type: COMMENT; Schema: public; Owner: ros-admin
--

COMMENT ON COLUMN public.history.doi IS 'The ''DOI'' linked to this modification';


--
-- Name: COLUMN history.doi_version; Type: COMMENT; Schema: public; Owner: ros-admin
--

COMMENT ON COLUMN public.history.doi_version IS 'The version of the ''DOI'' linked to this modification';


--
-- Name: history_event_id_seq; Type: SEQUENCE; Schema: public; Owner: ros-admin
--

CREATE SEQUENCE public.history_event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.history_event_id_seq OWNER TO "ros-admin";

--
-- Name: history_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ros-admin
--

ALTER SEQUENCE public.history_event_id_seq OWNED BY public.history.event_id;


--
-- Name: tableslist; Type: VIEW; Schema: public; Owner: ros-admin
--

CREATE VIEW public.tableslist AS
 SELECT DISTINCT trigger_schema AS schema,
    event_object_table AS auditedtable
   FROM information_schema.triggers
  WHERE ((trigger_name)::text = ANY (ARRAY['audit_trigger_row'::text, 'audit_trigger_stm'::text]))
  ORDER BY trigger_schema, event_object_table;


ALTER VIEW public.tableslist OWNER TO "ros-admin";

--
-- Name: VIEW tableslist; Type: COMMENT; Schema: public; Owner: ros-admin
--

COMMENT ON VIEW public.tableslist IS ' View showing all tables with auditing
set up.Ordered by schema,
    then table.';


--
-- Name: countries; Type: TABLE; Schema: refs_admin; Owner: ros-admin
--

CREATE TABLE refs_admin.countries (
    code character(3) NOT NULL,
    code_iso2 character(2) NOT NULL,
    code_iso3 character(3) NOT NULL,
    nocs_category character varying(255) NOT NULL,
    name_en character varying(255) DEFAULT 'TBD'::character varying NOT NULL,
    name_fr character varying(255) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_admin.countries OWNER TO "ros-admin";

--
-- Name: cpc_history; Type: TABLE; Schema: refs_admin; Owner: ros-admin
--

CREATE TABLE refs_admin.cpc_history (
    cpc_code character varying(4) NOT NULL,
    contracting_party smallint NOT NULL,
    acceptance_date date NOT NULL,
    withdrawal_date date
);


ALTER TABLE refs_admin.cpc_history OWNER TO "ros-admin";

--
-- Name: cpc_to_flags; Type: TABLE; Schema: refs_admin; Owner: ros-admin
--

CREATE TABLE refs_admin.cpc_to_flags (
    cpc_code character varying(4) NOT NULL,
    flag_code character(3) NOT NULL
);


ALTER TABLE refs_admin.cpc_to_flags OWNER TO "ros-admin";

--
-- Name: cpcs; Type: TABLE; Schema: refs_admin; Owner: ros-admin
--

CREATE TABLE refs_admin.cpcs (
    code character varying(4) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    is_coastal smallint NOT NULL,
    is_sids smallint NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_admin.cpcs OWNER TO "ros-admin";

--
-- Name: entities; Type: TABLE; Schema: refs_admin; Owner: ros-admin
--

CREATE TABLE refs_admin.entities (
    code character varying(4) NOT NULL,
    code_iso2 character(2),
    code_iso3 character(3),
    nocs_category character varying(255) NOT NULL,
    name_en character varying(255) DEFAULT 'TBD'::character varying NOT NULL,
    name_fr character varying(255) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_admin.entities OWNER TO "ros-admin";

--
-- Name: fleet_to_flags_and_fisheries; Type: TABLE; Schema: refs_admin; Owner: ros-admin
--

CREATE TABLE refs_admin.fleet_to_flags_and_fisheries (
    fleet_code character varying(7) NOT NULL,
    reporting_entity_code character varying(4) NOT NULL,
    flag_code character varying(4) NOT NULL,
    iotc_main_area_code character varying(32),
    fishery_type_code character(2),
    gear_category_code character(2),
    gear_code character varying(16),
    gear_configuration_code character(2),
    fishing_mode_code character(2),
    target_species_code character(2),
    from_year integer,
    to_year integer,
    CONSTRAINT validateiotcmainarea CHECK ((refs_admin.validate_iotc_main_area(iotc_main_area_code) = 1))
);


ALTER TABLE refs_admin.fleet_to_flags_and_fisheries OWNER TO "ros-admin";

--
-- Name: fleets; Type: TABLE; Schema: refs_admin; Owner: ros-admin
--

CREATE TABLE refs_admin.fleets (
    code character varying(7) NOT NULL,
    name_en character varying(100) NOT NULL,
    name_fr character varying(100),
    cpc_code character varying(4),
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_admin.fleets OWNER TO "ros-admin";

--
-- Name: io_main_areas; Type: TABLE; Schema: refs_admin; Owner: ros-admin
--

CREATE TABLE refs_admin.io_main_areas (
    code character(7) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    ocean_area_km2 double precision NOT NULL,
    center_lat double precision NOT NULL,
    center_lon double precision NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_admin.io_main_areas OWNER TO "ros-admin";

--
-- Name: ports; Type: TABLE; Schema: refs_admin; Owner: ros-admin
--

CREATE TABLE refs_admin.ports (
    id integer NOT NULL,
    code character varying(16) NOT NULL,
    country_code character varying(16) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255),
    lat double precision,
    lon double precision,
    point public.geography,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_admin.ports OWNER TO "ros-admin";

--
-- Name: ports_id_seq; Type: SEQUENCE; Schema: refs_admin; Owner: ros-admin
--

ALTER TABLE refs_admin.ports ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME refs_admin.ports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: species_reporting_requirements; Type: TABLE; Schema: refs_admin; Owner: ros-admin
--

CREATE TABLE refs_admin.species_reporting_requirements (
    gear_group_code character(2) NOT NULL,
    species_code character varying(16) NOT NULL,
    rav_retention_ban smallint NOT NULL
);


ALTER TABLE refs_admin.species_reporting_requirements OWNER TO "ros-admin";

--
-- Name: v_current_cpcs; Type: VIEW; Schema: refs_admin; Owner: ros-admin
--

CREATE VIEW refs_admin.v_current_cpcs AS
 SELECT c.code,
    c.name_en,
    c.name_fr,
    c.is_coastal,
    c.is_sids,
        CASE
            WHEN (h.contracting_party = 1) THEN 'CP'::text
            ELSE 'CNPC'::text
        END AS status_code,
    h.acceptance_date
   FROM (refs_admin.cpcs c
     LEFT JOIN refs_admin.cpc_history h ON (((c.code)::text = (h.cpc_code)::text)))
  WHERE (h.withdrawal_date IS NULL);


ALTER VIEW refs_admin.v_current_cpcs OWNER TO "ros-admin";

--
-- Name: nocs_codes; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.nocs_codes (
    id integer NOT NULL,
    iso2 character(10),
    iso3 character(10),
    agrovoc bigint,
    "CURRENCY ISO3" character varying(255),
    faostat integer,
    m49 integer,
    undp character(10),
    gaulcode integer,
    "MEMBERSHIP DATE" date,
    category character varying(255),
    "LIST NAME" character varying(255),
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.nocs_codes OWNER TO "ros-admin";

--
-- Name: nocs_names_en; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.nocs_names_en (
    id integer NOT NULL,
    "SHORT NAME" character varying(255),
    "LIST NAME" character varying(255),
    "FULL NAME" character varying(255),
    "ADJECTIVE/INHABITANT" character varying(255),
    capital_city character varying(255),
    "CURRENCY NAME" character varying(255),
    "CURRENCY SYMBOL" character varying(255),
    notes character varying(255),
    "ENGLISH_LIST NAME" character varying(255),
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.nocs_names_en OWNER TO "ros-admin";

--
-- Name: nocs_names_fr; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.nocs_names_fr (
    id integer NOT NULL,
    "SHORT NAME" character varying(255),
    "LIST NAME" character varying(255),
    "FULL NAME" character varying(255),
    "ADJECTIVE/INHABITANT" character varying(255),
    capital_city character varying(255),
    "CURRENCY NAME" character varying(255),
    "CURRENCY SYMBOL" character varying(255),
    notes character varying(255),
    "ENGLISH_LIST NAME" character varying(255),
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.nocs_names_fr OWNER TO "ros-admin";

--
-- Name: v_entities; Type: VIEW; Schema: refs_admin; Owner: ros-admin
--

CREATE VIEW refs_admin.v_entities AS
 WITH nocs AS (
         SELECT c.iso3 AS code,
            c.iso2 AS code_iso2,
            c.iso3 AS code_iso3,
            e."LIST NAME" AS list_name_en,
            f."LIST NAME" AS list_name_fr,
            e."FULL NAME" AS full_name_en,
            f."FULL NAME" AS full_name_fr,
            e."SHORT NAME" AS short_name_en,
            f."SHORT NAME" AS short_name_fr,
            c.category AS nocs_category
           FROM ((refs_legacy.nocs_codes c
             JOIN refs_legacy.nocs_names_en e ON ((c.id = e.id)))
             JOIN refs_legacy.nocs_names_fr f ON ((c.id = f.id)))
        UNION
         SELECT 'ANT'::bpchar AS bpchar,
            'AN'::bpchar AS bpchar,
            'ANT'::bpchar AS bpchar,
            'Netherlands Antilles'::character varying AS "varchar",
            'Antilles néerlandaises'::character varying AS "varchar",
            'Netherlands Antilles'::character varying AS "varchar",
            'Antilles néerlandaises'::character varying AS "varchar",
            'Netherlands Antilles'::character varying AS "varchar",
            'Antilles néerlandaises'::character varying AS "varchar",
            'DISSOLVED NATION'::character varying AS "varchar"
        UNION
         SELECT 'SUN'::bpchar AS bpchar,
            'SU'::bpchar AS bpchar,
            'SUN'::bpchar AS bpchar,
            'Union of Soviet Socialist Republics'::character varying AS "varchar",
            'Union des républiques socialistes soviétiques'::character varying AS "varchar",
            'Soviet Union'::character varying AS "varchar",
            'Union soviétique'::character varying AS "varchar",
            'Soviet Union'::character varying AS "varchar",
            'Union soviétique'::character varying AS "varchar",
            'DISSOLVED NATION'::character varying AS "varchar"
        UNION
         SELECT 'NEI'::bpchar AS bpchar,
            NULL::bpchar AS bpchar,
            NULL::bpchar AS bpchar,
            'Countries not elsewhere identified (NEI)'::character varying AS "varchar",
            'Pays non compris alleurs (NCA)'::character varying AS "varchar",
            'Countries not elsewhere identified (NEI)'::character varying AS "varchar",
            'Pays non compris alleurs (NCA)'::character varying AS "varchar",
            'Not elsewhere identified (NEI)'::character varying AS "varchar",
            'Non compris alleurs (NCA)'::character varying AS "varchar",
            'GROUP OF NATIONS'::character varying AS "varchar"
        UNION
         SELECT 'IOTC'::bpchar AS bpchar,
            NULL::bpchar AS bpchar,
            NULL::bpchar AS bpchar,
            'Group of IOTC countries (NEI)'::character varying AS "varchar",
            'Groupe de pays CTOI (NCA)'::character varying AS "varchar",
            'Group of IOTC countries  (NEI)'::character varying AS "varchar",
            'Groupe de pays CTOI (NCA)'::character varying AS "varchar",
            'IOTC'::character varying AS "varchar",
            'CTOI'::character varying AS "varchar",
            'GROUP OF NATIONS'::character varying AS "varchar"
        UNION
         SELECT 'IPTP'::bpchar AS bpchar,
            NULL::bpchar AS bpchar,
            NULL::bpchar AS bpchar,
            'Group of IPTP countries (NEI)'::character varying AS "varchar",
            'Groupe de pays CTOI (NCA)'::character varying AS "varchar",
            'Group of IPTP countries (NEI)'::character varying AS "varchar",
            'Groupe de pays CTOI (NCA)'::character varying AS "varchar",
            'IPTP'::character varying AS "varchar",
            'IPTP'::character varying AS "varchar",
            'GROUP OF NATIONS'::character varying AS "varchar"
        )
 SELECT code,
    code_iso2,
    code_iso3,
    list_name_en,
    list_name_fr,
    full_name_en,
    full_name_fr,
    short_name_en,
    short_name_fr,
    nocs_category
   FROM nocs
  WHERE ((code_iso3 IS NOT NULL) OR (code = ANY (ARRAY['IOTC'::bpchar, 'IPTP'::bpchar, 'NEI'::bpchar])));


ALTER VIEW refs_admin.v_entities OWNER TO "ros-admin";

--
-- Name: v_fleets_out; Type: VIEW; Schema: refs_admin; Owner: ros-admin
--

CREATE VIEW refs_admin.v_fleets_out AS
 WITH single_flags AS (
         SELECT f_1.code
           FROM (refs_admin.fleets f_1
             JOIN refs_admin.fleet_to_flags_and_fisheries ff_1 ON (((f_1.code)::text = (ff_1.fleet_code)::text)))
          GROUP BY f_1.code
         HAVING (count(DISTINCT ff_1.flag_code) = 1)
        )
 SELECT DISTINCT f.code,
    f.name_en,
    f.name_fr,
    c.code AS cpc_code,
    ff.flag_code
   FROM (((refs_admin.fleets f
     LEFT JOIN single_flags sf ON (((f.code)::text = (sf.code)::text)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries ff ON (((sf.code)::text = (ff.fleet_code)::text)))
     LEFT JOIN refs_admin.v_current_cpcs c ON (((f.cpc_code)::text = (c.code)::text)));


ALTER VIEW refs_admin.v_fleets_out OWNER TO "ros-admin";

--
-- Name: bait_conditions; Type: TABLE; Schema: refs_biological; Owner: ros-admin
--

CREATE TABLE refs_biological.bait_conditions (
    code character(2) NOT NULL,
    code_orig character(3) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_biological.bait_conditions OWNER TO "ros-admin";

--
-- Name: bait_types; Type: TABLE; Schema: refs_biological; Owner: ros-admin
--

CREATE TABLE refs_biological.bait_types (
    code character(2) NOT NULL,
    code_orig character(3) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_biological.bait_types OWNER TO "ros-admin";

--
-- Name: depredation_sources; Type: TABLE; Schema: refs_biological; Owner: ros-admin
--

CREATE TABLE refs_biological.depredation_sources (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_biological.depredation_sources OWNER TO "ros-admin";

--
-- Name: fates; Type: TABLE; Schema: refs_biological; Owner: ros-admin
--

CREATE TABLE refs_biological.fates (
    type_of_fate_code character(2) NOT NULL,
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    code_orig character(3) NOT NULL
);


ALTER TABLE refs_biological.fates OWNER TO "ros-admin";

--
-- Name: gear_interactions; Type: TABLE; Schema: refs_biological; Owner: ros-admin
--

CREATE TABLE refs_biological.gear_interactions (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_biological.gear_interactions OWNER TO "ros-admin";

--
-- Name: handling_methods; Type: TABLE; Schema: refs_biological; Owner: ros-admin
--

CREATE TABLE refs_biological.handling_methods (
    code character(2) NOT NULL,
    code_orig character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_biological.handling_methods OWNER TO "ros-admin";

--
-- Name: incidental_captures_conditions; Type: TABLE; Schema: refs_biological; Owner: ros-admin
--

CREATE TABLE refs_biological.incidental_captures_conditions (
    code character varying(3) NOT NULL,
    name_en character varying(512),
    name_fr character varying(512),
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_biological.incidental_captures_conditions OWNER TO "ros-admin";

--
-- Name: individual_conditions; Type: TABLE; Schema: refs_biological; Owner: ros-admin
--

CREATE TABLE refs_biological.individual_conditions (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    is_alive smallint NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_biological.individual_conditions OWNER TO "ros-admin";

--
-- Name: measurement_tools; Type: TABLE; Schema: refs_biological; Owner: ros-admin
--

CREATE TABLE refs_biological.measurement_tools (
    type_of_measurement_code character(2) NOT NULL,
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_biological.measurement_tools OWNER TO "ros-admin";

--
-- Name: measurements; Type: TABLE; Schema: refs_biological; Owner: ros-admin
--

CREATE TABLE refs_biological.measurements (
    type_of_measurement_code character(2) NOT NULL,
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    description_en character varying(255),
    name_fr character varying(255) NOT NULL,
    description_fr character varying(255),
    code_orig character(3) NOT NULL
);


ALTER TABLE refs_biological.measurements OWNER TO "ros-admin";

--
-- Name: sampling_methods_for_catch_estimation; Type: TABLE; Schema: refs_biological; Owner: ros-admin
--

CREATE TABLE refs_biological.sampling_methods_for_catch_estimation (
    code character(2) NOT NULL,
    code_orig character(3) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_biological.sampling_methods_for_catch_estimation OWNER TO "ros-admin";

--
-- Name: sampling_methods_for_sampling_collections; Type: TABLE; Schema: refs_biological; Owner: ros-admin
--

CREATE TABLE refs_biological.sampling_methods_for_sampling_collections (
    code character(2) NOT NULL,
    code_orig character(3) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_biological.sampling_methods_for_sampling_collections OWNER TO "ros-admin";

--
-- Name: sampling_periods; Type: TABLE; Schema: refs_biological; Owner: ros-admin
--

CREATE TABLE refs_biological.sampling_periods (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_biological.sampling_periods OWNER TO "ros-admin";

--
-- Name: sampling_protocols; Type: TABLE; Schema: refs_biological; Owner: ros-admin
--

CREATE TABLE refs_biological.sampling_protocols (
    code character(2) NOT NULL,
    code_orig character varying(3) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_biological.sampling_protocols OWNER TO "ros-admin";

--
-- Name: scars; Type: TABLE; Schema: refs_biological; Owner: ros-admin
--

CREATE TABLE refs_biological.scars (
    code character varying(3) NOT NULL,
    name_en character varying(512),
    name_fr character varying(512),
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_biological.scars OWNER TO "ros-admin";

--
-- Name: sex; Type: TABLE; Schema: refs_biological; Owner: ros-admin
--

CREATE TABLE refs_biological.sex (
    code character(1) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    is_determined smallint NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    code_orig character(3) NOT NULL
);


ALTER TABLE refs_biological.sex OWNER TO "ros-admin";

--
-- Name: species; Type: TABLE; Schema: refs_biological; Owner: ros-admin
--

CREATE TABLE refs_biological.species (
    code character varying(16) NOT NULL,
    name_en character varying(255),
    name_fr character varying(255),
    name_scientific character varying(255),
    species_group_code character varying(16) NOT NULL,
    species_category_code character varying(16) NOT NULL,
    family character varying(64),
    "ORDER" character varying(64),
    iucn_status_code character(2),
    is_iotc smallint NOT NULL,
    is_target smallint,
    is_ssi smallint NOT NULL,
    is_predator smallint,
    is_bait smallint NOT NULL,
    is_aggregate smallint NOT NULL,
    is_asfis smallint,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_biological.species OWNER TO "ros-admin";

--
-- Name: species_aggregates; Type: TABLE; Schema: refs_biological; Owner: ros-admin
--

CREATE TABLE refs_biological.species_aggregates (
    species_aggregate_code character varying(16) NOT NULL,
    species_code character varying(16) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_biological.species_aggregates OWNER TO "ros-admin";

--
-- Name: species_categories; Type: TABLE; Schema: refs_biological; Owner: ros-admin
--

CREATE TABLE refs_biological.species_categories (
    code character varying(16) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_biological.species_categories OWNER TO "ros-admin";

--
-- Name: species_groups; Type: TABLE; Schema: refs_biological; Owner: ros-admin
--

CREATE TABLE refs_biological.species_groups (
    code character varying(16) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_biological.species_groups OWNER TO "ros-admin";

--
-- Name: tag_types; Type: TABLE; Schema: refs_biological; Owner: ros-admin
--

CREATE TABLE refs_biological.tag_types (
    code character(2) NOT NULL,
    code_orig character varying(16) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_biological.tag_types OWNER TO "ros-admin";

--
-- Name: types_of_fate; Type: TABLE; Schema: refs_biological; Owner: ros-admin
--

CREATE TABLE refs_biological.types_of_fate (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_biological.types_of_fate OWNER TO "ros-admin";

--
-- Name: types_of_measurement; Type: TABLE; Schema: refs_biological; Owner: ros-admin
--

CREATE TABLE refs_biological.types_of_measurement (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    default_unit character(2) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_biological.types_of_measurement OWNER TO "ros-admin";

--
-- Name: v_discard_reasons; Type: VIEW; Schema: refs_biological; Owner: ros-admin
--

CREATE VIEW refs_biological.v_discard_reasons AS
 SELECT code,
    name_en,
    name_fr
   FROM refs_biological.fates
  WHERE (type_of_fate_code = 'DI'::bpchar);


ALTER VIEW refs_biological.v_discard_reasons OWNER TO "ros-admin";

--
-- Name: v_length_measurement_tools; Type: VIEW; Schema: refs_biological; Owner: ros-admin
--

CREATE VIEW refs_biological.v_length_measurement_tools AS
 SELECT code,
    name_en,
    name_fr
   FROM refs_biological.measurement_tools
  WHERE (type_of_measurement_code = 'LN'::bpchar);


ALTER VIEW refs_biological.v_length_measurement_tools OWNER TO "ros-admin";

--
-- Name: v_length_measurements; Type: VIEW; Schema: refs_biological; Owner: ros-admin
--

CREATE VIEW refs_biological.v_length_measurements AS
 SELECT code,
    name_en,
    description_en,
    name_fr,
    description_fr
   FROM refs_biological.measurements
  WHERE (type_of_measurement_code = 'LN'::bpchar);


ALTER VIEW refs_biological.v_length_measurements OWNER TO "ros-admin";

--
-- Name: recommended_measurements; Type: TABLE; Schema: refs_biological_config; Owner: ros-admin
--

CREATE TABLE refs_biological_config.recommended_measurements (
    species_code character varying(16) NOT NULL,
    type_of_measurement_code character(2) NOT NULL,
    measurement_code character(2) NOT NULL,
    default_measurement_interval smallint NOT NULL,
    max_measurement_interval smallint NOT NULL,
    min_measurement smallint NOT NULL,
    max_measurement smallint NOT NULL
);


ALTER TABLE refs_biological_config.recommended_measurements OWNER TO "ros-admin";

--
-- Name: v_recommended_length_measurements; Type: VIEW; Schema: refs_biological; Owner: ros-admin
--

CREATE VIEW refs_biological.v_recommended_length_measurements AS
 SELECT species_code,
    measurement_code AS length_measurement_code,
    default_measurement_interval AS default_length_measurement_interval,
    max_measurement_interval AS max_length_measurement_interval,
    min_measurement AS min_length_measurement,
    max_measurement AS max_length_measurement
   FROM refs_biological_config.recommended_measurements m
  WHERE (type_of_measurement_code = 'LN'::bpchar);


ALTER VIEW refs_biological.v_recommended_length_measurements OWNER TO "ros-admin";

--
-- Name: v_recommended_measurements; Type: VIEW; Schema: refs_biological; Owner: ros-admin
--

CREATE VIEW refs_biological.v_recommended_measurements AS
 SELECT s.species_category_code,
    rm.species_code,
    s.name_scientific AS species_scientific_name,
    mt.name_en AS type_of_measurement,
    m.name_en AS measurement,
    m.code AS measurement_code,
    mt.default_unit AS measurement_unit,
    rm.default_measurement_interval,
    rm.max_measurement_interval,
    rm.min_measurement,
    rm.max_measurement
   FROM (((refs_biological_config.recommended_measurements rm
     LEFT JOIN refs_biological.species s ON (((rm.species_code)::text = (s.code)::text)))
     LEFT JOIN refs_biological.types_of_measurement mt ON ((rm.type_of_measurement_code = mt.code)))
     LEFT JOIN refs_biological.measurements m ON (((rm.type_of_measurement_code = m.type_of_measurement_code) AND (rm.measurement_code = m.code))));


ALTER VIEW refs_biological.v_recommended_measurements OWNER TO "ros-admin";

--
-- Name: v_recommended_weight_measurements; Type: VIEW; Schema: refs_biological; Owner: ros-admin
--

CREATE VIEW refs_biological.v_recommended_weight_measurements AS
 SELECT species_code,
    measurement_code AS weight_measurement_code,
    default_measurement_interval AS default_weight_measurement_interval,
    max_measurement_interval AS max_weight_measurement_interval,
    min_measurement AS min_weight_measurement,
    max_measurement AS max_weight_measurement
   FROM refs_biological_config.recommended_measurements m
  WHERE (type_of_measurement_code = 'WG'::bpchar);


ALTER VIEW refs_biological.v_recommended_weight_measurements OWNER TO "ros-admin";

--
-- Name: v_retain_reasons; Type: VIEW; Schema: refs_biological; Owner: ros-admin
--

CREATE VIEW refs_biological.v_retain_reasons AS
 SELECT code,
    name_en,
    name_fr
   FROM refs_biological.fates
  WHERE (type_of_fate_code = 'RE'::bpchar);


ALTER VIEW refs_biological.v_retain_reasons OWNER TO "ros-admin";

--
-- Name: v_species; Type: VIEW; Schema: refs_biological; Owner: ros-admin
--

CREATE VIEW refs_biological.v_species AS
 SELECT s.code,
    s.name_en,
    s.name_fr,
    s.name_scientific,
    s.species_group_code,
    sg.name_en AS species_group_name_en,
    sg.name_fr AS species_group_name_fr,
    s.species_category_code,
    sc.name_en AS species_category_name_en,
    sc.name_fr AS species_category_name_fr,
    s.family,
    s."ORDER",
    s.iucn_status_code,
    s.is_iotc,
    s.is_target,
    s.is_ssi,
    s.is_predator,
    s.is_bait,
    s.is_aggregate,
    s.is_asfis
   FROM ((refs_biological.species s
     LEFT JOIN refs_biological.species_groups sg ON (((s.species_group_code)::text = (sg.code)::text)))
     LEFT JOIN refs_biological.species_categories sc ON (((s.species_category_code)::text = (sc.code)::text)));


ALTER VIEW refs_biological.v_species OWNER TO "ros-admin";

--
-- Name: v_species_baits; Type: VIEW; Schema: refs_biological; Owner: ros-admin
--

CREATE VIEW refs_biological.v_species_baits AS
 SELECT code,
    name_en,
    name_fr,
    name_scientific,
    species_group_code,
    species_group_name_en,
    species_group_name_fr,
    species_category_code,
    species_category_name_en,
    species_category_name_fr,
    family,
    "ORDER",
    iucn_status_code,
    is_iotc,
    is_target,
    is_ssi,
    is_predator,
    is_bait,
    is_aggregate,
    is_asfis
   FROM refs_biological.v_species
  WHERE (is_bait = 1);


ALTER VIEW refs_biological.v_species_baits OWNER TO "ros-admin";

--
-- Name: v_species_cetaceans; Type: VIEW; Schema: refs_biological; Owner: ros-admin
--

CREATE VIEW refs_biological.v_species_cetaceans AS
 SELECT code,
    name_en,
    name_fr,
    name_scientific,
    species_group_code,
    species_group_name_en,
    species_group_name_fr,
    species_category_code,
    species_category_name_en,
    species_category_name_fr,
    family,
    "ORDER",
    iucn_status_code,
    is_iotc,
    is_target,
    is_ssi,
    is_predator,
    is_bait,
    is_aggregate,
    is_asfis
   FROM refs_biological.v_species
  WHERE ((species_category_code)::text = 'CETACEANS'::text);


ALTER VIEW refs_biological.v_species_cetaceans OWNER TO "ros-admin";

--
-- Name: v_species_cetaceans_and_whale_sharks; Type: VIEW; Schema: refs_biological; Owner: ros-admin
--

CREATE VIEW refs_biological.v_species_cetaceans_and_whale_sharks AS
 SELECT code,
    name_en,
    name_fr,
    name_scientific,
    species_group_code,
    species_group_name_en,
    species_group_name_fr,
    species_category_code,
    species_category_name_en,
    species_category_name_fr,
    family,
    "ORDER",
    iucn_status_code,
    is_iotc,
    is_target,
    is_ssi,
    is_predator,
    is_bait,
    is_aggregate,
    is_asfis
   FROM refs_biological.v_species
  WHERE (((species_category_code)::text = 'CETACEANS'::text) OR ((code)::text = 'RHN'::text));


ALTER VIEW refs_biological.v_species_cetaceans_and_whale_sharks OWNER TO "ros-admin";

--
-- Name: v_species_iotc; Type: VIEW; Schema: refs_biological; Owner: ros-admin
--

CREATE VIEW refs_biological.v_species_iotc AS
 SELECT code,
    name_en,
    name_fr,
    name_scientific,
    species_group_code,
    species_group_name_en,
    species_group_name_fr,
    species_category_code,
    species_category_name_en,
    species_category_name_fr,
    family,
    "ORDER",
    iucn_status_code,
    is_iotc,
    is_target,
    is_ssi,
    is_predator,
    is_bait,
    is_aggregate,
    is_asfis
   FROM refs_biological.v_species
  WHERE (is_iotc = 1);


ALTER VIEW refs_biological.v_species_iotc OWNER TO "ros-admin";

--
-- Name: v_species_others; Type: VIEW; Schema: refs_biological; Owner: ros-admin
--

CREATE VIEW refs_biological.v_species_others AS
 SELECT code,
    name_en,
    name_fr,
    name_scientific,
    species_group_code,
    species_group_name_en,
    species_group_name_fr,
    species_category_code,
    species_category_name_en,
    species_category_name_fr,
    family,
    "ORDER",
    iucn_status_code,
    is_iotc,
    is_target,
    is_ssi,
    is_predator,
    is_bait,
    is_aggregate,
    is_asfis
   FROM refs_biological.v_species
  WHERE ((species_category_code)::text = 'OTHERS'::text);


ALTER VIEW refs_biological.v_species_others OWNER TO "ros-admin";

--
-- Name: v_species_predators; Type: VIEW; Schema: refs_biological; Owner: ros-admin
--

CREATE VIEW refs_biological.v_species_predators AS
 SELECT code,
    name_en,
    name_fr,
    name_scientific,
    species_group_code,
    species_group_name_en,
    species_group_name_fr,
    species_category_code,
    species_category_name_en,
    species_category_name_fr,
    family,
    "ORDER",
    iucn_status_code,
    is_iotc,
    is_target,
    is_ssi,
    is_predator,
    is_bait,
    is_aggregate,
    is_asfis
   FROM refs_biological.v_species
  WHERE (is_predator = 1);


ALTER VIEW refs_biological.v_species_predators OWNER TO "ros-admin";

--
-- Name: v_species_seabirds; Type: VIEW; Schema: refs_biological; Owner: ros-admin
--

CREATE VIEW refs_biological.v_species_seabirds AS
 SELECT code,
    name_en,
    name_fr,
    name_scientific,
    species_group_code,
    species_group_name_en,
    species_group_name_fr,
    species_category_code,
    species_category_name_en,
    species_category_name_fr,
    family,
    "ORDER",
    iucn_status_code,
    is_iotc,
    is_target,
    is_ssi,
    is_predator,
    is_bait,
    is_aggregate,
    is_asfis
   FROM refs_biological.v_species
  WHERE ((species_category_code)::text = 'SEABIRDS'::text);


ALTER VIEW refs_biological.v_species_seabirds OWNER TO "ros-admin";

--
-- Name: v_species_sharks_and_rays; Type: VIEW; Schema: refs_biological; Owner: ros-admin
--

CREATE VIEW refs_biological.v_species_sharks_and_rays AS
 SELECT code,
    name_en,
    name_fr,
    name_scientific,
    species_group_code,
    species_group_name_en,
    species_group_name_fr,
    species_category_code,
    species_category_name_en,
    species_category_name_fr,
    family,
    "ORDER",
    iucn_status_code,
    is_iotc,
    is_target,
    is_ssi,
    is_predator,
    is_bait,
    is_aggregate,
    is_asfis
   FROM refs_biological.v_species
  WHERE ((species_category_code)::text = ANY (ARRAY[('SHARKS'::character varying)::text, ('RAYS'::character varying)::text]));


ALTER VIEW refs_biological.v_species_sharks_and_rays OWNER TO "ros-admin";

--
-- Name: v_species_ssi; Type: VIEW; Schema: refs_biological; Owner: ros-admin
--

CREATE VIEW refs_biological.v_species_ssi AS
 SELECT code,
    name_en,
    name_fr,
    name_scientific,
    species_group_code,
    species_group_name_en,
    species_group_name_fr,
    species_category_code,
    species_category_name_en,
    species_category_name_fr,
    family,
    "ORDER",
    iucn_status_code,
    is_iotc,
    is_target,
    is_ssi,
    is_predator,
    is_bait,
    is_aggregate,
    is_asfis
   FROM refs_biological.v_species
  WHERE (is_ssi = 1);


ALTER VIEW refs_biological.v_species_ssi OWNER TO "ros-admin";

--
-- Name: v_species_target; Type: VIEW; Schema: refs_biological; Owner: ros-admin
--

CREATE VIEW refs_biological.v_species_target AS
 SELECT code,
    name_en,
    name_fr,
    name_scientific,
    species_group_code,
    species_group_name_en,
    species_group_name_fr,
    species_category_code,
    species_category_name_en,
    species_category_name_fr,
    family,
    "ORDER",
    iucn_status_code,
    is_iotc,
    is_target,
    is_ssi,
    is_predator,
    is_bait,
    is_aggregate,
    is_asfis
   FROM refs_biological.v_species
  WHERE (is_target = 1);


ALTER VIEW refs_biological.v_species_target OWNER TO "ros-admin";

--
-- Name: v_species_turtles; Type: VIEW; Schema: refs_biological; Owner: ros-admin
--

CREATE VIEW refs_biological.v_species_turtles AS
 SELECT code,
    name_en,
    name_fr,
    name_scientific,
    species_group_code,
    species_group_name_en,
    species_group_name_fr,
    species_category_code,
    species_category_name_en,
    species_category_name_fr,
    family,
    "ORDER",
    iucn_status_code,
    is_iotc,
    is_target,
    is_ssi,
    is_predator,
    is_bait,
    is_aggregate,
    is_asfis
   FROM refs_biological.v_species
  WHERE ((species_category_code)::text = 'TURTLES'::text);


ALTER VIEW refs_biological.v_species_turtles OWNER TO "ros-admin";

--
-- Name: v_weight_measurement_tools; Type: VIEW; Schema: refs_biological; Owner: ros-admin
--

CREATE VIEW refs_biological.v_weight_measurement_tools AS
 SELECT code,
    name_en,
    name_fr
   FROM refs_biological.measurement_tools
  WHERE (type_of_measurement_code = 'WG'::bpchar);


ALTER VIEW refs_biological.v_weight_measurement_tools OWNER TO "ros-admin";

--
-- Name: v_weight_measurements; Type: VIEW; Schema: refs_biological; Owner: ros-admin
--

CREATE VIEW refs_biological.v_weight_measurements AS
 SELECT code,
    name_en,
    description_en,
    name_fr,
    description_fr
   FROM refs_biological.measurements
  WHERE (type_of_measurement_code = 'WG'::bpchar);


ALTER VIEW refs_biological.v_weight_measurements OWNER TO "ros-admin";

--
-- Name: coverage_types; Type: TABLE; Schema: refs_data; Owner: ros-admin
--

CREATE TABLE refs_data.coverage_types (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_data.coverage_types OWNER TO "ros-admin";

--
-- Name: datasets; Type: TABLE; Schema: refs_data; Owner: ros-admin
--

CREATE TABLE refs_data.datasets (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_data.datasets OWNER TO "ros-admin";

--
-- Name: estimations; Type: TABLE; Schema: refs_data; Owner: ros-admin
--

CREATE TABLE refs_data.estimations (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_data.estimations OWNER TO "ros-admin";

--
-- Name: processings; Type: TABLE; Schema: refs_data; Owner: ros-admin
--

CREATE TABLE refs_data.processings (
    dataset_code character(2) NOT NULL,
    code character(2) NOT NULL,
    name_en text NOT NULL,
    name_fr text NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_data.processings OWNER TO "ros-admin";

--
-- Name: raisings; Type: TABLE; Schema: refs_data; Owner: ros-admin
--

CREATE TABLE refs_data.raisings (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_data.raisings OWNER TO "ros-admin";

--
-- Name: sources; Type: TABLE; Schema: refs_data; Owner: ros-admin
--

CREATE TABLE refs_data.sources (
    dataset_code character(2) NOT NULL,
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_data.sources OWNER TO "ros-admin";

--
-- Name: types; Type: TABLE; Schema: refs_data; Owner: ros-admin
--

CREATE TABLE refs_data.types (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_data.types OWNER TO "ros-admin";

--
-- Name: v_processings_ce; Type: VIEW; Schema: refs_data; Owner: ros-admin
--

CREATE VIEW refs_data.v_processings_ce AS
 SELECT dataset_code,
    code,
    name_en,
    name_fr
   FROM refs_data.processings
  WHERE (dataset_code = 'CE'::bpchar);


ALTER VIEW refs_data.v_processings_ce OWNER TO "ros-admin";

--
-- Name: v_processings_di; Type: VIEW; Schema: refs_data; Owner: ros-admin
--

CREATE VIEW refs_data.v_processings_di AS
 SELECT dataset_code,
    code,
    name_en,
    name_fr
   FROM refs_data.processings
  WHERE (dataset_code = 'DI'::bpchar);


ALTER VIEW refs_data.v_processings_di OWNER TO "ros-admin";

--
-- Name: v_processings_fa; Type: VIEW; Schema: refs_data; Owner: ros-admin
--

CREATE VIEW refs_data.v_processings_fa AS
 SELECT dataset_code,
    code,
    name_en,
    name_fr
   FROM refs_data.processings
  WHERE (dataset_code = 'FA'::bpchar);


ALTER VIEW refs_data.v_processings_fa OWNER TO "ros-admin";

--
-- Name: v_processings_fc; Type: VIEW; Schema: refs_data; Owner: ros-admin
--

CREATE VIEW refs_data.v_processings_fc AS
 SELECT dataset_code,
    code,
    name_en,
    name_fr
   FROM refs_data.processings
  WHERE (dataset_code = 'FC'::bpchar);


ALTER VIEW refs_data.v_processings_fc OWNER TO "ros-admin";

--
-- Name: v_processings_rc; Type: VIEW; Schema: refs_data; Owner: ros-admin
--

CREATE VIEW refs_data.v_processings_rc AS
 SELECT dataset_code,
    code,
    name_en,
    name_fr
   FROM refs_data.processings
  WHERE (dataset_code = 'RC'::bpchar);


ALTER VIEW refs_data.v_processings_rc OWNER TO "ros-admin";

--
-- Name: v_processings_sf; Type: VIEW; Schema: refs_data; Owner: ros-admin
--

CREATE VIEW refs_data.v_processings_sf AS
 SELECT dataset_code,
    code,
    name_en,
    name_fr
   FROM refs_data.processings
  WHERE (dataset_code = 'SF'::bpchar);


ALTER VIEW refs_data.v_processings_sf OWNER TO "ros-admin";

--
-- Name: v_sources_ce; Type: VIEW; Schema: refs_data; Owner: ros-admin
--

CREATE VIEW refs_data.v_sources_ce AS
 SELECT dataset_code,
    code,
    name_en,
    name_fr
   FROM refs_data.sources
  WHERE (dataset_code = 'CE'::bpchar);


ALTER VIEW refs_data.v_sources_ce OWNER TO "ros-admin";

--
-- Name: v_sources_di; Type: VIEW; Schema: refs_data; Owner: ros-admin
--

CREATE VIEW refs_data.v_sources_di AS
 SELECT dataset_code,
    code,
    name_en,
    name_fr
   FROM refs_data.sources
  WHERE (dataset_code = 'DI'::bpchar);


ALTER VIEW refs_data.v_sources_di OWNER TO "ros-admin";

--
-- Name: v_sources_fa; Type: VIEW; Schema: refs_data; Owner: ros-admin
--

CREATE VIEW refs_data.v_sources_fa AS
 SELECT dataset_code,
    code,
    name_en,
    name_fr
   FROM refs_data.sources
  WHERE (dataset_code = 'FA'::bpchar);


ALTER VIEW refs_data.v_sources_fa OWNER TO "ros-admin";

--
-- Name: v_sources_fc; Type: VIEW; Schema: refs_data; Owner: ros-admin
--

CREATE VIEW refs_data.v_sources_fc AS
 SELECT dataset_code,
    code,
    name_en,
    name_fr
   FROM refs_data.sources
  WHERE (dataset_code = 'FC'::bpchar);


ALTER VIEW refs_data.v_sources_fc OWNER TO "ros-admin";

--
-- Name: v_sources_rc; Type: VIEW; Schema: refs_data; Owner: ros-admin
--

CREATE VIEW refs_data.v_sources_rc AS
 SELECT dataset_code,
    code,
    name_en,
    name_fr
   FROM refs_data.sources
  WHERE (dataset_code = 'RC'::bpchar);


ALTER VIEW refs_data.v_sources_rc OWNER TO "ros-admin";

--
-- Name: v_sources_sf; Type: VIEW; Schema: refs_data; Owner: ros-admin
--

CREATE VIEW refs_data.v_sources_sf AS
 SELECT dataset_code,
    code,
    name_en,
    name_fr
   FROM refs_data.sources
  WHERE (dataset_code = 'SF'::bpchar);


ALTER VIEW refs_data.v_sources_sf OWNER TO "ros-admin";

--
-- Name: activities; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.activities (
    code character varying(3) NOT NULL,
    name_en character varying(512),
    name_fr character varying(512),
    ps smallint DEFAULT 1 NOT NULL,
    pl smallint DEFAULT 1 NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.activities OWNER TO "ros-admin";

--
-- Name: bait_fishing_methods; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.bait_fishing_methods (
    code character(2) NOT NULL,
    code_orig character varying(3) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.bait_fishing_methods OWNER TO "ros-admin";

--
-- Name: bait_school_detection_methods; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.bait_school_detection_methods (
    code character(2) NOT NULL,
    code_orig character varying(3) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.bait_school_detection_methods OWNER TO "ros-admin";

--
-- Name: branchline_storages; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.branchline_storages (
    code character(2) NOT NULL,
    code_orig character varying(16) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.branchline_storages OWNER TO "ros-admin";

--
-- Name: buoy_activity_types; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.buoy_activity_types (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.buoy_activity_types OWNER TO "ros-admin";

--
-- Name: cardinal_points; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.cardinal_points (
    code character varying(3) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.cardinal_points OWNER TO "ros-admin";

--
-- Name: catch_units; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.catch_units (
    code character varying(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.catch_units OWNER TO "ros-admin";

--
-- Name: dehooker_types; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.dehooker_types (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.dehooker_types OWNER TO "ros-admin";

--
-- Name: effort_units; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.effort_units (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.effort_units OWNER TO "ros-admin";

--
-- Name: fad_raft_designs; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.fad_raft_designs (
    code character(2) NOT NULL,
    code_orig character varying(3) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.fad_raft_designs OWNER TO "ros-admin";

--
-- Name: fad_tail_designs; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.fad_tail_designs (
    code character(2) NOT NULL,
    code_orig character varying(3) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.fad_tail_designs OWNER TO "ros-admin";

--
-- Name: fish_preservation_methods; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.fish_preservation_methods (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    code_orig character(3) NOT NULL
);


ALTER TABLE refs_fishery.fish_preservation_methods OWNER TO "ros-admin";

--
-- Name: fish_processing_types; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.fish_processing_types (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.fish_processing_types OWNER TO "ros-admin";

--
-- Name: fish_storage_types; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.fish_storage_types (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.fish_storage_types OWNER TO "ros-admin";

--
-- Name: fisheries; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.fisheries (
    code character varying(64) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    fishery_category_code character varying(16) NOT NULL,
    fishery_type_code character(2) NOT NULL,
    gear_code character varying(16) NOT NULL,
    gear_configuration_code character(2),
    fishing_mode_code character(2),
    target_species_code character(2),
    iotdb_gear_code character varying(6),
    iotc_fishery_code character varying(16),
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.fisheries OWNER TO "ros-admin";

--
-- Name: float_types; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.float_types (
    code character(2) NOT NULL,
    code_orig character(3) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.float_types OWNER TO "ros-admin";

--
-- Name: fob_activity_types; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.fob_activity_types (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    dfob smallint NOT NULL,
    afob smallint NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.fob_activity_types OWNER TO "ros-admin";

--
-- Name: fob_types; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.fob_types (
    code character varying(5) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    dfob smallint NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.fob_types OWNER TO "ros-admin";

--
-- Name: gear_types; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.gear_types (
    code character(3) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.gear_types OWNER TO "ros-admin";

--
-- Name: gillnet_material_types; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.gillnet_material_types (
    code character(2) NOT NULL,
    code_orig character varying(3) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.gillnet_material_types OWNER TO "ros-admin";

--
-- Name: hook_types; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.hook_types (
    code character(3) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.hook_types OWNER TO "ros-admin";

--
-- Name: hull_material_types; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.hull_material_types (
    code character(2) NOT NULL,
    code_orig character(3) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.hull_material_types OWNER TO "ros-admin";

--
-- Name: light_colours; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.light_colours (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.light_colours OWNER TO "ros-admin";

--
-- Name: light_types; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.light_types (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.light_types OWNER TO "ros-admin";

--
-- Name: line_material_types; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.line_material_types (
    code character(2) NOT NULL,
    code_orig character(3) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.line_material_types OWNER TO "ros-admin";

--
-- Name: mechanization_types; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.mechanization_types (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    is_mechanized smallint NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.mechanization_types OWNER TO "ros-admin";

--
-- Name: mitigation_devices; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.mitigation_devices (
    code character(2) NOT NULL,
    code_orig character(3) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.mitigation_devices OWNER TO "ros-admin";

--
-- Name: net_colours; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.net_colours (
    code character(2) NOT NULL,
    code_orig character(3) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.net_colours OWNER TO "ros-admin";

--
-- Name: net_conditions; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.net_conditions (
    code character(2) NOT NULL,
    code_orig character(3) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.net_conditions OWNER TO "ros-admin";

--
-- Name: net_configurations; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.net_configurations (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.net_configurations OWNER TO "ros-admin";

--
-- Name: net_deploy_depths; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.net_deploy_depths (
    code character(2) NOT NULL,
    code_orig character(3) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.net_deploy_depths OWNER TO "ros-admin";

--
-- Name: net_setting_strategies; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.net_setting_strategies (
    code character(2) NOT NULL,
    code_orig character(3) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.net_setting_strategies OWNER TO "ros-admin";

--
-- Name: offal_management_types; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.offal_management_types (
    code character(2) NOT NULL,
    code_orig character varying(16) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.offal_management_types OWNER TO "ros-admin";

--
-- Name: pole_material_types; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.pole_material_types (
    code character(2) NOT NULL,
    code_orig character varying(16) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.pole_material_types OWNER TO "ros-admin";

--
-- Name: reasons_days_lost; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.reasons_days_lost (
    code character(2) NOT NULL,
    code_orig character(3) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.reasons_days_lost OWNER TO "ros-admin";

--
-- Name: school_detection_methods; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.school_detection_methods (
    code character(2) NOT NULL,
    code_orig character varying(3) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.school_detection_methods OWNER TO "ros-admin";

--
-- Name: school_sighting_cues; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.school_sighting_cues (
    code character(2) NOT NULL,
    code_orig character varying(4) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    school_type_category_code character(2),
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.school_sighting_cues OWNER TO "ros-admin";

--
-- Name: school_type_categories; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.school_type_categories (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.school_type_categories OWNER TO "ros-admin";

--
-- Name: sinker_material_types; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.sinker_material_types (
    code character(2) NOT NULL,
    code_orig character(3) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.sinker_material_types OWNER TO "ros-admin";

--
-- Name: streamer_types; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.streamer_types (
    code character(2) NOT NULL,
    code_orig character varying(16) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.streamer_types OWNER TO "ros-admin";

--
-- Name: stunning_methods; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.stunning_methods (
    code character(2) NOT NULL,
    code_orig character varying(3) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.stunning_methods OWNER TO "ros-admin";

--
-- Name: surface_fishery_activities; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.surface_fishery_activities (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    pl smallint NOT NULL,
    ps smallint NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.surface_fishery_activities OWNER TO "ros-admin";

--
-- Name: transhipment_categories; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.transhipment_categories (
    code character(2) NOT NULL,
    code_orig character varying(16) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.transhipment_categories OWNER TO "ros-admin";

--
-- Name: v_afob_activity_types; Type: VIEW; Schema: refs_fishery; Owner: ros-admin
--

CREATE VIEW refs_fishery.v_afob_activity_types AS
 SELECT code,
    name_en,
    name_fr
   FROM refs_fishery.fob_activity_types
  WHERE (afob = 1);


ALTER VIEW refs_fishery.v_afob_activity_types OWNER TO "ros-admin";

--
-- Name: v_afob_types; Type: VIEW; Schema: refs_fishery; Owner: ros-admin
--

CREATE VIEW refs_fishery.v_afob_types AS
 SELECT code,
    name_en,
    name_fr
   FROM refs_fishery.fob_types
  WHERE (dfob = 0);


ALTER VIEW refs_fishery.v_afob_types OWNER TO "ros-admin";

--
-- Name: v_dfob_activity_types; Type: VIEW; Schema: refs_fishery; Owner: ros-admin
--

CREATE VIEW refs_fishery.v_dfob_activity_types AS
 SELECT code,
    name_en,
    name_fr
   FROM refs_fishery.fob_activity_types
  WHERE (dfob = 1);


ALTER VIEW refs_fishery.v_dfob_activity_types OWNER TO "ros-admin";

--
-- Name: v_dfob_types; Type: VIEW; Schema: refs_fishery; Owner: ros-admin
--

CREATE VIEW refs_fishery.v_dfob_types AS
 SELECT code,
    name_en,
    name_fr
   FROM refs_fishery.fob_types
  WHERE (dfob = 1);


ALTER VIEW refs_fishery.v_dfob_types OWNER TO "ros-admin";

--
-- Name: fishery_categories; Type: TABLE; Schema: refs_fishery_config; Owner: ros-admin
--

CREATE TABLE refs_fishery_config.fishery_categories (
    code character varying(16) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_en character varying(512) NOT NULL,
    description_fr character varying(512) NOT NULL,
    rav_vessels smallint NOT NULL,
    minimum_grid_size character(9)
);


ALTER TABLE refs_fishery_config.fishery_categories OWNER TO "ros-admin";

--
-- Name: fishery_types; Type: TABLE; Schema: refs_fishery_config; Owner: ros-admin
--

CREATE TABLE refs_fishery_config.fishery_types (
    code character(2) NOT NULL,
    purpose_code character(3) NOT NULL,
    area_of_operation_code character varying(16) NOT NULL,
    loa_class_code character varying(16) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_en character varying(512) NOT NULL,
    description_fr character varying(512) NOT NULL
);


ALTER TABLE refs_fishery_config.fishery_types OWNER TO "ros-admin";

--
-- Name: fishing_modes; Type: TABLE; Schema: refs_fishery_config; Owner: ros-admin
--

CREATE TABLE refs_fishery_config.fishing_modes (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_en character varying(512) NOT NULL,
    description_fr character varying(512) NOT NULL
);


ALTER TABLE refs_fishery_config.fishing_modes OWNER TO "ros-admin";

--
-- Name: gear_configurations; Type: TABLE; Schema: refs_fishery_config; Owner: ros-admin
--

CREATE TABLE refs_fishery_config.gear_configurations (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_en character varying(512) NOT NULL,
    description_fr character varying(512) NOT NULL
);


ALTER TABLE refs_fishery_config.gear_configurations OWNER TO "ros-admin";

--
-- Name: gear_groups; Type: TABLE; Schema: refs_fishery_config; Owner: ros-admin
--

CREATE TABLE refs_fishery_config.gear_groups (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_en character varying(512) NOT NULL,
    description_fr character varying(512) NOT NULL
);


ALTER TABLE refs_fishery_config.gear_groups OWNER TO "ros-admin";

--
-- Name: gears; Type: TABLE; Schema: refs_fishery_config; Owner: ros-admin
--

CREATE TABLE refs_fishery_config.gears (
    code character varying(16) NOT NULL,
    gear_group_code character(2) NOT NULL,
    isscfg_code character varying(5) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_en text NOT NULL,
    description_fr text NOT NULL,
    code_orig character(3) NOT NULL
);


ALTER TABLE refs_fishery_config.gears OWNER TO "ros-admin";

--
-- Name: target_species; Type: TABLE; Schema: refs_fishery_config; Owner: ros-admin
--

CREATE TABLE refs_fishery_config.target_species (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_en character varying(294) NOT NULL,
    description_fr character varying(512) NOT NULL
);


ALTER TABLE refs_fishery_config.target_species OWNER TO "ros-admin";

--
-- Name: fisheries; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.fisheries (
    code character varying(16) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    fishery_group_code character varying(16) NOT NULL,
    fishery_group_name_en character varying(255) NOT NULL,
    fishery_group_name_fr character varying(255) NOT NULL,
    fishery_type_code character(2) NOT NULL,
    fishery_type_name_en character varying(255) NOT NULL,
    fishery_type_name_fr character varying(255) NOT NULL,
    selectivity_group_code character(1) NOT NULL,
    selectivity_group_name_en character varying(255) NOT NULL,
    selectivity_group_name_fr character varying(255) NOT NULL,
    is_aggregate integer NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.fisheries OWNER TO "ros-admin";

--
-- Name: gears; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.gears (
    code character varying(6) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    gear_group_code character varying(5) NOT NULL,
    gear_group_name_en character varying(255) NOT NULL,
    gear_group_name_fr character varying(255) NOT NULL,
    is_aggregate smallint NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.gears OWNER TO "ros-admin";

--
-- Name: isscfg_gear_groups; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.isscfg_gear_groups (
    id smallint NOT NULL,
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.isscfg_gear_groups OWNER TO "ros-admin";

--
-- Name: isscfg_gears; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.isscfg_gears (
    id smallint,
    code character varying(5) NOT NULL,
    isscfg_group_code character(2),
    abbreviation character varying(7),
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.isscfg_gears OWNER TO "ros-admin";

--
-- Name: v_fisheries_details; Type: VIEW; Schema: refs_fishery; Owner: ros-admin
--

CREATE VIEW refs_fishery.v_fisheries_details AS
 SELECT f.code,
    f.name_en,
    f.name_fr,
    c.code AS fishery_category_code,
    c.name_en AS fishery_category_name_en,
    c.name_fr AS fishery_category_name_fr,
    t.code AS fishery_type_code,
    t.name_en AS fishery_type_name_en,
    t.name_fr AS fishery_type_name_fr,
    igg.code AS isscfg_gear_group_code,
    igg.name_en AS isscfg_gear_group_name_en,
    igg.name_fr AS isscfg_gear_group_name_fr,
    ig.code AS isscfg_gear_code,
    ig.name_en AS isscfg_gear_name_en,
    ig.name_fr AS isscfg_gear_name_fr,
    lg.code AS iotdb_gear_code,
    lg.name_en AS iotdb_gear_name_en,
    lg.name_fr AS iotdb_gear_name_fr,
    lf.code AS iotc_fishery_code,
    lf.name_en AS iotc_fishery_name_en,
    lf.name_fr AS iotc_fishery_name_fr,
    gg.code AS gear_group_code,
    gg.name_en AS gear_group_name_en,
    gg.name_fr AS gear_group_name_fr,
    g.code AS gear_code,
    g.name_en AS gea_namer_en,
    g.name_fr AS gear_name_fr,
    gc.code AS gear_configuration_code,
    gc.name_en AS gear_configuration_name_en,
    gc.name_fr AS gear_configuration_name_fr,
    fm.code AS fishing_mode_code,
    fm.name_en AS fishing_mode_name_en,
    fm.name_fr AS fishing_mode_name_fr,
    ts.code AS target_species_code,
    ts.name_en AS target_species_name_en,
    ts.name_fr AS target_species_name_fr
   FROM (((((((((((refs_fishery.fisheries f
     JOIN refs_fishery_config.fishery_categories c ON (((f.fishery_category_code)::text = (c.code)::text)))
     JOIN refs_fishery_config.fishery_types t ON ((f.fishery_type_code = t.code)))
     JOIN refs_fishery_config.gears g ON (((f.gear_code)::text = (g.code)::text)))
     JOIN refs_fishery_config.gear_groups gg ON ((g.gear_group_code = gg.code)))
     JOIN refs_legacy.isscfg_gears ig ON (((g.isscfg_code)::text = (ig.code)::text)))
     JOIN refs_legacy.isscfg_gear_groups igg ON ((ig.isscfg_group_code = igg.code)))
     LEFT JOIN refs_legacy.gears lg ON (((f.iotdb_gear_code)::text = (lg.code)::text)))
     LEFT JOIN refs_legacy.fisheries lf ON (((f.iotc_fishery_code)::text = (lf.code)::text)))
     LEFT JOIN refs_fishery_config.gear_configurations gc ON ((f.gear_configuration_code = gc.code)))
     LEFT JOIN refs_fishery_config.fishing_modes fm ON ((f.fishing_mode_code = fm.code)))
     LEFT JOIN refs_fishery_config.target_species ts ON ((f.target_species_code = ts.code)));


ALTER VIEW refs_fishery.v_fisheries_details OWNER TO "ros-admin";

--
-- Name: v_fisheries_out; Type: VIEW; Schema: refs_fishery; Owner: ros-admin
--

CREATE VIEW refs_fishery.v_fisheries_out AS
 SELECT f.code,
    f.name_en,
    f.name_fr,
    c.code AS fishery_category_code,
    c.name_en AS fishery_category_name_en,
    c.name_fr AS fishery_category_name_fr
   FROM (refs_fishery.fisheries f
     JOIN refs_fishery_config.fishery_categories c ON (((f.fishery_category_code)::text = (c.code)::text)));


ALTER VIEW refs_fishery.v_fisheries_out OWNER TO "ros-admin";

--
-- Name: vessel_architectures; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.vessel_architectures (
    code character(4) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.vessel_architectures OWNER TO "ros-admin";

--
-- Name: vessel_sections; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.vessel_sections (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.vessel_sections OWNER TO "ros-admin";

--
-- Name: vessel_size_types; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.vessel_size_types (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.vessel_size_types OWNER TO "ros-admin";

--
-- Name: vessel_types; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.vessel_types (
    code character(3) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_en text NOT NULL,
    description_fr text NOT NULL
);


ALTER TABLE refs_fishery.vessel_types OWNER TO "ros-admin";

--
-- Name: waste_categories; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.waste_categories (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.waste_categories OWNER TO "ros-admin";

--
-- Name: waste_disposal_methods; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.waste_disposal_methods (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.waste_disposal_methods OWNER TO "ros-admin";

--
-- Name: wind_scales; Type: TABLE; Schema: refs_fishery; Owner: ros-admin
--

CREATE TABLE refs_fishery.wind_scales (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_fishery.wind_scales OWNER TO "ros-admin";

--
-- Name: areas_of_operation; Type: TABLE; Schema: refs_fishery_config; Owner: ros-admin
--

CREATE TABLE refs_fishery_config.areas_of_operation (
    code character varying(16) NOT NULL,
    name_en character varying(64) NOT NULL,
    name_fr character varying(64),
    description_en character varying(512) NOT NULL,
    description_fr character varying(512)
);


ALTER TABLE refs_fishery_config.areas_of_operation OWNER TO "ros-admin";

--
-- Name: fishery_types_bkp; Type: TABLE; Schema: refs_fishery_config; Owner: ros-admin
--

CREATE TABLE refs_fishery_config.fishery_types_bkp (
    code character(2) NOT NULL,
    purpose_code character(3) NOT NULL,
    area_of_operation_code character varying(16) NOT NULL,
    loa_class_code character varying(16) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_en character varying(512) NOT NULL,
    description_fr character varying(512) NOT NULL
);


ALTER TABLE refs_fishery_config.fishery_types_bkp OWNER TO "ros-admin";

--
-- Name: fishery_types_new; Type: TABLE; Schema: refs_fishery_config; Owner: ros-admin
--

CREATE TABLE refs_fishery_config.fishery_types_new (
    code character(3) NOT NULL,
    purpose_code character(3) NOT NULL,
    area_of_operation_code character varying(16) NOT NULL,
    loa_class_code character varying(16) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_en character varying(512) NOT NULL,
    description_fr character varying(512) NOT NULL
);


ALTER TABLE refs_fishery_config.fishery_types_new OWNER TO "ros-admin";

--
-- Name: gear_fishery_type_to_configuration; Type: TABLE; Schema: refs_fishery_config; Owner: ros-admin
--

CREATE TABLE refs_fishery_config.gear_fishery_type_to_configuration (
    gear_code character varying(16) NOT NULL,
    fishery_type_code character(2) NOT NULL,
    gear_configuration_code character(2) NOT NULL
);


ALTER TABLE refs_fishery_config.gear_fishery_type_to_configuration OWNER TO "ros-admin";

--
-- Name: gear_fishery_type_to_configuration_bkp; Type: TABLE; Schema: refs_fishery_config; Owner: ros-admin
--

CREATE TABLE refs_fishery_config.gear_fishery_type_to_configuration_bkp (
    gear_code character varying(16) NOT NULL,
    fishery_type_code character(2) NOT NULL,
    gear_configuration_code character(2) NOT NULL
);


ALTER TABLE refs_fishery_config.gear_fishery_type_to_configuration_bkp OWNER TO "ros-admin";

--
-- Name: gear_fishery_type_to_fishing_mode; Type: TABLE; Schema: refs_fishery_config; Owner: ros-admin
--

CREATE TABLE refs_fishery_config.gear_fishery_type_to_fishing_mode (
    gear_code character varying(16) NOT NULL,
    fishery_type_code character(2) NOT NULL,
    fishing_mode_code character(2) NOT NULL
);


ALTER TABLE refs_fishery_config.gear_fishery_type_to_fishing_mode OWNER TO "ros-admin";

--
-- Name: gear_fishery_type_to_fishing_mode_bkp; Type: TABLE; Schema: refs_fishery_config; Owner: ros-admin
--

CREATE TABLE refs_fishery_config.gear_fishery_type_to_fishing_mode_bkp (
    gear_code character varying(16) NOT NULL,
    fishery_type_code character(2) NOT NULL,
    fishing_mode_code character(2) NOT NULL
);


ALTER TABLE refs_fishery_config.gear_fishery_type_to_fishing_mode_bkp OWNER TO "ros-admin";

--
-- Name: gear_to_fishery_type; Type: TABLE; Schema: refs_fishery_config; Owner: ros-admin
--

CREATE TABLE refs_fishery_config.gear_to_fishery_type (
    gear_code character varying(16) NOT NULL,
    fishery_type_code character(2) NOT NULL
);


ALTER TABLE refs_fishery_config.gear_to_fishery_type OWNER TO "ros-admin";

--
-- Name: gear_to_fishery_type_bkp; Type: TABLE; Schema: refs_fishery_config; Owner: ros-admin
--

CREATE TABLE refs_fishery_config.gear_to_fishery_type_bkp (
    gear_code character varying(16) NOT NULL,
    fishery_type_code character(2) NOT NULL
);


ALTER TABLE refs_fishery_config.gear_to_fishery_type_bkp OWNER TO "ros-admin";

--
-- Name: gear_to_fishery_type_new; Type: TABLE; Schema: refs_fishery_config; Owner: ros-admin
--

CREATE TABLE refs_fishery_config.gear_to_fishery_type_new (
    gear_code character varying(16) NOT NULL,
    fishery_type_code character(3) NOT NULL
);


ALTER TABLE refs_fishery_config.gear_to_fishery_type_new OWNER TO "ros-admin";

--
-- Name: gear_to_target_species; Type: TABLE; Schema: refs_fishery_config; Owner: ros-admin
--

CREATE TABLE refs_fishery_config.gear_to_target_species (
    gear_code character varying(16) NOT NULL,
    target_species_code character(2) NOT NULL
);


ALTER TABLE refs_fishery_config.gear_to_target_species OWNER TO "ros-admin";

--
-- Name: loa_classes; Type: TABLE; Schema: refs_fishery_config; Owner: ros-admin
--

CREATE TABLE refs_fishery_config.loa_classes (
    code character varying(16) NOT NULL,
    name_en character varying(64),
    name_fr character varying(64),
    description_en character varying(512),
    description_fr character varying(512)
);


ALTER TABLE refs_fishery_config.loa_classes OWNER TO "ros-admin";

--
-- Name: purposes; Type: TABLE; Schema: refs_fishery_config; Owner: ros-admin
--

CREATE TABLE refs_fishery_config.purposes (
    code character(3) NOT NULL,
    name_en character varying(64),
    name_fr character varying(64),
    description_en character varying(512),
    description_fr character varying(512)
);


ALTER TABLE refs_fishery_config.purposes OWNER TO "ros-admin";

--
-- Name: area_intersections; Type: TABLE; Schema: refs_gis; Owner: ros-admin
--

CREATE TABLE refs_gis.area_intersections (
    source_code character varying(32) NOT NULL,
    target_code character varying(32) NOT NULL,
    source_area_km2 bigint NOT NULL,
    target_area_km2 bigint NOT NULL,
    intersection_area_km2 bigint NOT NULL,
    source_rel_intersection numeric(10,9) NOT NULL,
    target_rel_intersection numeric(10,9) NOT NULL,
    intersection_area public.geography,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_gis.area_intersections OWNER TO "ros-admin";

--
-- Name: area_intersections_iotc; Type: TABLE; Schema: refs_gis; Owner: ros-admin
--

CREATE TABLE refs_gis.area_intersections_iotc (
    source_code character varying(32) NOT NULL,
    target_code character varying(32) NOT NULL,
    source_area_km2 bigint NOT NULL,
    target_area_km2 bigint NOT NULL,
    intersection_area_km2 bigint NOT NULL,
    source_rel_intersection numeric(10,9) NOT NULL,
    target_rel_intersection numeric(10,9) NOT NULL,
    intersection_area public.geography,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_gis.area_intersections_iotc OWNER TO "ros-admin";

--
-- Name: area_types; Type: TABLE; Schema: refs_gis; Owner: ros-admin
--

CREATE TABLE refs_gis.area_types (
    code character(9) NOT NULL,
    name_en character varying(512) NOT NULL,
    name_fr character varying(512) NOT NULL,
    fishing_ground_prefix character(1),
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_gis.area_types OWNER TO "ros-admin";

--
-- Name: areas; Type: TABLE; Schema: refs_gis; Owner: ros-admin
--

CREATE TABLE refs_gis.areas (
    code character varying(32) NOT NULL,
    area_type_code character(9) NOT NULL,
    label_en character varying(512) NOT NULL,
    label_fr character varying(512) NOT NULL,
    name_en character varying(512) NOT NULL,
    name_fr character varying(512) NOT NULL,
    land_area_km2 double precision NOT NULL,
    ocean_area_km2 bigint NOT NULL,
    ocean_area_io_km2 bigint NOT NULL,
    ocean_area_iotc_km2 bigint NOT NULL,
    area_geometry public.geometry NOT NULL,
    center_lat double precision NOT NULL,
    center_lon double precision NOT NULL,
    area_geometry_old public.geometry,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_gis.areas OWNER TO "ros-admin";

--
-- Name: v_iotc_ar_areas_01_05_grids_intersections; Type: VIEW; Schema: refs_gis; Owner: ros-admin
--

CREATE VIEW refs_gis.v_iotc_ar_areas_01_05_grids_intersections AS
 SELECT s.code AS source_area_code,
    s.area_type_code AS source_area_type_code,
    ai.source_area_km2,
    s.name_en AS source_area_name_en,
    s.name_fr AS source_area_name_fr,
    t.code AS target_area_code,
    t.area_type_code AS target_area_type_code,
    ai.target_area_km2,
    t.name_en AS target_area_name_en,
    t.name_fr AS target_area_name_fr,
    ai.intersection_area_km2,
    ai.source_rel_intersection AS source_area_intersection_rel,
    ai.target_rel_intersection AS target_area_intersection_rel
   FROM ((refs_gis.areas s
     JOIN refs_gis.area_intersections ai ON (((ai.source_code)::text = (s.code)::text)))
     JOIN refs_gis.areas t ON (((ai.target_code)::text = (t.code)::text)))
  WHERE ((((s.code)::text ~~ 'AR_%'::text) AND (((t.code)::text ~~ '5%'::text) OR ((t.code)::text ~~ '6%'::text))) OR (((t.code)::text ~~ 'AR_%'::text) AND (((s.code)::text ~~ '5%'::text) OR ((s.code)::text ~~ '6%'::text))));


ALTER VIEW refs_gis.v_iotc_ar_areas_01_05_grids_intersections OWNER TO "ros-admin";

--
-- Name: v_iotc_ar_areas_01_grids_intersections; Type: VIEW; Schema: refs_gis; Owner: ros-admin
--

CREATE VIEW refs_gis.v_iotc_ar_areas_01_grids_intersections AS
 SELECT s.code AS source_area_code,
    s.area_type_code AS source_area_type_code,
    ai.source_area_km2,
    s.name_en AS source_area_name_en,
    s.name_fr AS source_area_name_fr,
    t.code AS target_area_code,
    t.area_type_code AS target_area_type_code,
    ai.target_area_km2,
    t.name_en AS target_area_name_en,
    t.name_fr AS target_area_name_fr,
    ai.intersection_area_km2,
    ai.source_rel_intersection AS source_area_intersection_rel,
    ai.target_rel_intersection AS target_area_intersection_rel
   FROM ((refs_gis.areas s
     JOIN refs_gis.area_intersections ai ON (((ai.source_code)::text = (s.code)::text)))
     JOIN refs_gis.areas t ON (((ai.target_code)::text = (t.code)::text)))
  WHERE ((((s.code)::text ~~ 'AR_%'::text) AND ((t.code)::text ~~ '5%'::text)) OR (((t.code)::text ~~ 'AR_%'::text) AND ((s.code)::text ~~ '5%'::text)));


ALTER VIEW refs_gis.v_iotc_ar_areas_01_grids_intersections OWNER TO "ros-admin";

--
-- Name: v_iotc_ar_areas_05_grids_intersections; Type: VIEW; Schema: refs_gis; Owner: ros-admin
--

CREATE VIEW refs_gis.v_iotc_ar_areas_05_grids_intersections AS
 SELECT s.code AS source_area_code,
    s.area_type_code AS source_area_type_code,
    ai.source_area_km2,
    s.name_en AS source_area_name_en,
    s.name_fr AS source_area_name_fr,
    t.code AS target_area_code,
    t.area_type_code AS target_area_type_code,
    ai.target_area_km2,
    t.name_en AS target_area_name_en,
    t.name_fr AS target_area_name_fr,
    ai.intersection_area_km2,
    ai.source_rel_intersection AS source_area_intersection_rel,
    ai.target_rel_intersection AS target_area_intersection_rel
   FROM ((refs_gis.areas s
     JOIN refs_gis.area_intersections ai ON (((ai.source_code)::text = (s.code)::text)))
     JOIN refs_gis.areas t ON (((ai.target_code)::text = (t.code)::text)))
  WHERE ((((s.code)::text ~~ 'AR_%'::text) AND ((t.code)::text ~~ '6%'::text)) OR (((t.code)::text ~~ 'AR_%'::text) AND ((s.code)::text ~~ '6%'::text)));


ALTER VIEW refs_gis.v_iotc_ar_areas_05_grids_intersections OWNER TO "ros-admin";

--
-- Name: boat_size_class; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.boat_size_class (
    code character varying(16) NOT NULL,
    name_en character varying(512),
    name_fr character varying(512),
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.boat_size_class OWNER TO "ros-admin";

--
-- Name: boat_types; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.boat_types (
    code character(4) NOT NULL,
    name_en character varying(512) NOT NULL,
    name_fr character varying(512),
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.boat_types OWNER TO "ros-admin";

--
-- Name: catch_units; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.catch_units (
    code character(2) NOT NULL,
    name_en character varying(512) NOT NULL,
    name_fr character varying(512),
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.catch_units OWNER TO "ros-admin";

--
-- Name: coverage_types; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.coverage_types (
    code character(2) NOT NULL,
    name_en character varying(512) NOT NULL,
    name_fr character varying(512),
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.coverage_types OWNER TO "ros-admin";

--
-- Name: data_processings; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.data_processings (
    dataset_code character(2) NOT NULL,
    code character(4) NOT NULL,
    name_en character varying(512) NOT NULL,
    name_fr character varying(512),
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.data_processings OWNER TO "ros-admin";

--
-- Name: data_sources; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.data_sources (
    dataset_code character(2) NOT NULL,
    code character(4) NOT NULL,
    name_en character varying(512),
    name_fr character varying(512),
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.data_sources OWNER TO "ros-admin";

--
-- Name: data_types; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.data_types (
    code character varying(3) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.data_types OWNER TO "ros-admin";

--
-- Name: effort_units; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.effort_units (
    code character(2) NOT NULL,
    name_en character varying(512) NOT NULL,
    name_fr character varying(512),
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.effort_units OWNER TO "ros-admin";

--
-- Name: estimation_types; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.estimation_types (
    unit_type_code character(2) NOT NULL,
    code character varying(4) NOT NULL,
    name_en character varying(512) NOT NULL,
    name_fr character varying(512),
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.estimation_types OWNER TO "ros-admin";

--
-- Name: fad_activity_types; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.fad_activity_types (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    is_on_dfad smallint NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.fad_activity_types OWNER TO "ros-admin";

--
-- Name: fad_ownerships; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.fad_ownerships (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.fad_ownerships OWNER TO "ros-admin";

--
-- Name: fad_types; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.fad_types (
    code character(3) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    is_dfad smallint NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.fad_types OWNER TO "ros-admin";

--
-- Name: fates; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.fates (
    dataset_code character(2) NOT NULL,
    code character(3) NOT NULL,
    name_en character varying(512) NOT NULL,
    name_fr character varying(512),
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.fates OWNER TO "ros-admin";

--
-- Name: fleets; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.fleets (
    flag_code character varying(10),
    reporting_entity_code character varying(10),
    fleet_code character varying(7),
    name_en character varying(100),
    name_fr character varying(100),
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.fleets OWNER TO "ros-admin";

--
-- Name: gear_types; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.gear_types (
    gear_code character varying(5) NOT NULL,
    gear_name_en character varying(255) NOT NULL,
    gear_name_fr character varying(255) NOT NULL,
    country_code character varying(4) NOT NULL,
    country_name_en character varying(255) NOT NULL,
    country_name_fr character varying(255) NOT NULL,
    gear_type_code character(3) NOT NULL,
    type_operation_name_en character varying(255) NOT NULL,
    type_operation_name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.gear_types OWNER TO "ros-admin";

--
-- Name: iucn_status; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.iucn_status (
    code character(2) NOT NULL,
    name_en character varying(255),
    name_fr character varying(255),
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.iucn_status OWNER TO "ros-admin";

--
-- Name: main_areas; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.main_areas (
    code character varying(7) NOT NULL,
    name_en character varying(512),
    name_fr character varying(512),
    land_area_km2 integer NOT NULL,
    ocean_area_km2 double precision NOT NULL,
    ocean_area_io_km2 double precision NOT NULL,
    ocean_area_iotc_km2 double precision NOT NULL,
    center_lat double precision,
    center_lon double precision,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.main_areas OWNER TO "ros-admin";

--
-- Name: measurement_tools; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.measurement_tools (
    unit_type_code character(2) NOT NULL,
    code character(2) NOT NULL,
    name_en character varying(512) NOT NULL,
    name_fr character varying(512),
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.measurement_tools OWNER TO "ros-admin";

--
-- Name: measurement_types; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.measurement_types (
    unit_type_code character(2) NOT NULL,
    code character(2) NOT NULL,
    name_en character varying(512) NOT NULL,
    name_fr character varying(512),
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.measurement_types OWNER TO "ros-admin";

--
-- Name: raisings; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.raisings (
    code character varying(4) NOT NULL,
    name_en character varying(512) NOT NULL,
    name_fr character varying(512),
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.raisings OWNER TO "ros-admin";

--
-- Name: sampled_catch_types; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.sampled_catch_types (
    code character varying(4) NOT NULL,
    name_en character varying(512) NOT NULL,
    name_fr character varying(512),
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.sampled_catch_types OWNER TO "ros-admin";

--
-- Name: school_types; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.school_types (
    code character varying(4) NOT NULL,
    name_en character varying(512) NOT NULL,
    name_fr character varying(512),
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.school_types OWNER TO "ros-admin";

--
-- Name: species; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.species (
    code character varying(4) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    name_scientific character varying(255),
    is_aggregate smallint NOT NULL,
    is_iotc smallint NOT NULL,
    species_group_code character varying(16) NOT NULL,
    species_large_group_name_en character varying(255) NOT NULL,
    species_large_group_name_fr character varying(255),
    species_catalog_group_code character varying(16) NOT NULL,
    species_working_party_code character varying(16) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.species OWNER TO "ros-admin";

--
-- Name: species_con; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.species_con (
    code character(3) NOT NULL,
    name_en character varying(512),
    name_fr character varying(512),
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.species_con OWNER TO "ros-admin";

--
-- Name: species_conditions; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.species_conditions (
    code character(3) NOT NULL,
    name_en character varying(512),
    name_fr character varying(512),
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.species_conditions OWNER TO "ros-admin";

--
-- Name: species_to_grsf; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.species_to_grsf (
    species_code character varying(16) NOT NULL,
    uuid character varying(40) NOT NULL,
    semantic_id character varying(64) NOT NULL,
    firms_id integer NOT NULL,
    short_name_en character varying(255) NOT NULL,
    short_name_fr character varying(255),
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.species_to_grsf OWNER TO "ros-admin";

--
-- Name: un_locode_ports; Type: TABLE; Schema: refs_legacy; Owner: ros-admin
--

CREATE TABLE refs_legacy.un_locode_ports (
    code character(6) NOT NULL,
    country_code character(3) NOT NULL,
    port_code character(3) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255),
    latitude double precision,
    longitude double precision,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_legacy.un_locode_ports OWNER TO "ros-admin";

--
-- Name: v_fishery_groups; Type: VIEW; Schema: refs_legacy; Owner: ros-admin
--

CREATE VIEW refs_legacy.v_fishery_groups AS
 SELECT DISTINCT fishery_group_code AS code,
    fishery_group_name_en AS name_en,
    fishery_group_name_fr AS name_fr
   FROM refs_legacy.fisheries;


ALTER VIEW refs_legacy.v_fishery_groups OWNER TO "ros-admin";

--
-- Name: v_fishery_types; Type: VIEW; Schema: refs_legacy; Owner: ros-admin
--

CREATE VIEW refs_legacy.v_fishery_types AS
 SELECT DISTINCT fishery_type_code AS code,
    fishery_type_name_en AS name_en,
    fishery_type_name_fr AS name_fr
   FROM refs_legacy.fisheries;


ALTER VIEW refs_legacy.v_fishery_types OWNER TO "ros-admin";

--
-- Name: v_gear_types; Type: VIEW; Schema: refs_legacy; Owner: ros-admin
--

CREATE VIEW refs_legacy.v_gear_types AS
 SELECT DISTINCT gear_type_code AS code,
    type_operation_name_en AS name_en,
    type_operation_name_fr AS name_fr
   FROM refs_legacy.gear_types;


ALTER VIEW refs_legacy.v_gear_types OWNER TO "ros-admin";

--
-- Name: currencies; Type: TABLE; Schema: refs_socio_economics; Owner: ros-admin
--

CREATE TABLE refs_socio_economics.currencies (
    country_code character(3) NOT NULL,
    currency_code character(3) NOT NULL,
    currency_name character varying(255) NOT NULL
);


ALTER TABLE refs_socio_economics.currencies OWNER TO "ros-admin";

--
-- Name: destination_markets; Type: TABLE; Schema: refs_socio_economics; Owner: ros-admin
--

CREATE TABLE refs_socio_economics.destination_markets (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_socio_economics.destination_markets OWNER TO "ros-admin";

--
-- Name: pricing_locations; Type: TABLE; Schema: refs_socio_economics; Owner: ros-admin
--

CREATE TABLE refs_socio_economics.pricing_locations (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_socio_economics.pricing_locations OWNER TO "ros-admin";

--
-- Name: product_types; Type: TABLE; Schema: refs_socio_economics; Owner: ros-admin
--

CREATE TABLE refs_socio_economics.product_types (
    code character(2) NOT NULL,
    name_en character varying(255) NOT NULL,
    name_fr character varying(255) NOT NULL,
    description_fr character varying(4096) DEFAULT 'TBD'::character varying NOT NULL,
    description_en character varying(4096) DEFAULT 'TBD'::character varying NOT NULL
);


ALTER TABLE refs_socio_economics.product_types OWNER TO "ros-admin";

--
-- Name: v_countries_currencies; Type: VIEW; Schema: refs_socio_economics; Owner: ros-admin
--

CREATE VIEW refs_socio_economics.v_countries_currencies AS
 SELECT currencies.country_code,
    countries.name_en AS country_name,
    currencies.currency_code,
    currencies.currency_name
   FROM (refs_socio_economics.currencies
     JOIN refs_admin.countries ON ((currencies.country_code = countries.code_iso3)));


ALTER VIEW refs_socio_economics.v_countries_currencies OWNER TO "ros-admin";

--
-- Name: general_vessel_and_trip_information; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.general_vessel_and_trip_information (
    id integer NOT NULL,
    trip_number character varying(255) NOT NULL,
    observer_identification_id integer,
    observed_trip_summary_id integer,
    observer_trip_detail_id integer,
    vessel_attributes_id integer,
    vessel_electronics_id integer,
    vessel_identification_id integer,
    vessel_owner_and_personnel_id integer,
    vessel_trip_details_id integer
);


ALTER TABLE ros_common.general_vessel_and_trip_information OWNER TO "ros-admin";

--
-- Name: vessel_identification; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.vessel_identification (
    id integer NOT NULL,
    imo_number character varying(255),
    iotc_number character varying(255),
    ircs character varying(255),
    "NAME" character varying(255),
    registration_number character varying(255),
    main_fishing_gear_code character varying(16),
    flag_code character(3),
    port_code character varying(16)
);


ALTER TABLE ros_common.vessel_identification OWNER TO "ros-admin";

--
-- Name: ll_catch_details; Type: TABLE; Schema: ros_ll; Owner: ros-admin
--

CREATE TABLE ros_ll.ll_catch_details (
    id integer NOT NULL,
    catch_detail_number character varying(255) NOT NULL,
    comments text,
    estimated_catch_in_numbers integer,
    estimated_weight_id integer,
    ll_fishing_event_id integer,
    type_of_fate_code character(2),
    estimated_weight_sampling_method_code character(2),
    fates_code character(2),
    species_code character varying(16)
);


ALTER TABLE ros_ll.ll_catch_details OWNER TO "ros-admin";

--
-- Name: ll_fishing_events; Type: TABLE; Schema: ros_ll; Owner: ros-admin
--

CREATE TABLE ros_ll.ll_fishing_events (
    id integer NOT NULL,
    comments text,
    event_number character varying(255),
    ll_hauling_operation_id integer,
    ll_mitigation_measure_id integer,
    ll_setting_operation_id integer,
    ll_observer_data_id integer
);


ALTER TABLE ros_ll.ll_fishing_events OWNER TO "ros-admin";

--
-- Name: ll_observer_data; Type: TABLE; Schema: ros_ll; Owner: ros-admin
--

CREATE TABLE ros_ll.ll_observer_data (
    id integer NOT NULL,
    complete smallint DEFAULT 0 NOT NULL,
    creation_time timestamp(6) without time zone NOT NULL,
    finalization_time timestamp(6) without time zone,
    originator character varying(255) NOT NULL,
    originator_version character varying(255) NOT NULL,
    ros_codelists_version character varying(255) NOT NULL,
    ros_model_version character varying(255) NOT NULL,
    source character varying(255) NOT NULL,
    status character varying(255) NOT NULL,
    submission_time timestamp(6) without time zone,
    uid character varying(255) NOT NULL,
    creator_id integer NOT NULL,
    submitter_id integer,
    ll_gear_specifications_id integer,
    vessel_and_trip_information_id integer,
    reporting_country_code character(3) NOT NULL
);


ALTER TABLE ros_ll.ll_observer_data OWNER TO "ros-admin";

--
-- Name: ll_setting_operations; Type: TABLE; Schema: ros_ll; Owner: ros-admin
--

CREATE TABLE ros_ll.ll_setting_operations (
    id integer NOT NULL,
    branchline_clip_on_time double precision,
    buoys_clip_on_time double precision,
    distance_between_branchlines double precision,
    end_setting_date_and_time timestamp(6) without time zone,
    line_setter_speed double precision,
    number_of_hooks_set_between_floats integer,
    number_of_shark_lines_set integer,
    shark_lines_set smallint DEFAULT 0,
    start_setting_date_and_time timestamp(6) without time zone,
    total_number_of_floats_set integer,
    total_number_of_hooks_set integer,
    total_radio_dhan_buoys_set integer,
    vessel_speed double precision,
    vms_on smallint DEFAULT 0,
    end_setting_latitude double precision,
    end_setting_longitude double precision,
    start_setting_latitude double precision,
    start_setting_longitude double precision,
    mainline_set_length_id integer
);


ALTER TABLE ros_ll.ll_setting_operations OWNER TO "ros-admin";

--
-- Name: ll_specimens; Type: TABLE; Schema: ros_ll; Owner: ros-admin
--

CREATE TABLE ros_ll.ll_specimens (
    id integer NOT NULL,
    sampling_period character varying(255),
    specimen_number character varying(255) NOT NULL,
    ll_additional_catch_details_on_ssis_id integer,
    additional_specimen_details_non_target_species_id integer,
    biometric_information_id integer,
    ll_depredation_detail_id integer,
    ll_tag_detail_id integer,
    ll_catch_detail_id integer
);


ALTER TABLE ros_ll.ll_specimens OWNER TO "ros-admin";

--
-- Name: v_ll_ca; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
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
    'CL_SP.SPECIES_OFFICIAL???'::text AS "?column?",
    cl_fa.code AS fate,
    count(DISTINCT sp.id) AS observed_catch,
    'NO'::text AS catch_unit
   FROM ((((((((((ros_ll.ll_observer_data od
     JOIN ros_common.general_vessel_and_trip_information gvti ON ((od.vessel_and_trip_information_id = gvti.id)))
     JOIN ros_common.vessel_identification vi ON ((gvti.vessel_identification_id = vi.id)))
     JOIN refs_admin.countries cl_co ON ((vi.flag_code = cl_co.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON ((cl_co.code = (fl.flag_code)::bpchar)))
     JOIN ros_ll.ll_fishing_events fe ON ((fe.ll_observer_data_id = od.id)))
     LEFT JOIN ros_ll.ll_setting_operations se ON ((fe.ll_setting_operation_id = se.id)))
     JOIN ros_ll.ll_catch_details ca ON ((ca.ll_fishing_event_id = fe.id)))
     JOIN refs_biological.species cl_sp ON (((ca.species_code)::text = (cl_sp.code)::text)))
     LEFT JOIN refs_biological.fates cl_fa ON ((ca.fates_code = cl_fa.code)))
     JOIN ros_ll.ll_specimens sp ON ((sp.ll_catch_detail_id = ca.id)))
  WHERE (se.start_setting_date_and_time IS NOT NULL)
  GROUP BY COALESCE(fl.fleet_code, (cl_co.code)::character varying), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)), (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude)), cl_sp.code, cl_sp.species_group_code, cl_fa.code;


ALTER VIEW ros_analysis.v_ll_ca OWNER TO "ros-admin";

--
-- Name: estimated_weights; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.estimated_weights (
    id integer NOT NULL,
    unit character varying(3),
    value double precision,
    type_of_measurement_code character(2) NOT NULL,
    processing_type_code character(2),
    weight_estimation_method_code character(2)
);


ALTER TABLE ros_common.estimated_weights OWNER TO "ros-admin";

--
-- Name: ps_catch_details; Type: TABLE; Schema: ros_ps; Owner: ros-admin
--

CREATE TABLE ros_ps.ps_catch_details (
    id integer NOT NULL,
    catch_detail_number character varying(255) NOT NULL,
    comments text,
    estimated_catch_in_numbers integer,
    ps_additional_catch_details_non_target_species_id integer,
    estimated_weight_id integer,
    ps_fishing_event_id integer,
    type_of_fate_code character(2) NOT NULL,
    estimated_weight_sampling_method_code character(2),
    fates_code character(2),
    species_code character varying(16)
);


ALTER TABLE ros_ps.ps_catch_details OWNER TO "ros-admin";

--
-- Name: ps_fishing_events; Type: TABLE; Schema: ros_ps; Owner: ros-admin
--

CREATE TABLE ros_ps.ps_fishing_events (
    id integer NOT NULL,
    comments text,
    event_number character varying(255),
    ps_setting_operation_id integer,
    ps_observer_data_id integer
);


ALTER TABLE ros_ps.ps_fishing_events OWNER TO "ros-admin";

--
-- Name: ps_observer_data; Type: TABLE; Schema: ros_ps; Owner: ros-admin
--

CREATE TABLE ros_ps.ps_observer_data (
    id integer NOT NULL,
    complete smallint DEFAULT 0 NOT NULL,
    creation_time timestamp(6) without time zone NOT NULL,
    finalization_time timestamp(6) without time zone,
    originator character varying(255) NOT NULL,
    originator_version character varying(255) NOT NULL,
    ros_codelists_version character varying(255) NOT NULL,
    ros_model_version character varying(255) NOT NULL,
    source character varying(255) NOT NULL,
    status character varying(255) NOT NULL,
    submission_time timestamp(6) without time zone,
    uid character varying(255) NOT NULL,
    creator_id integer NOT NULL,
    submitter_id integer,
    ps_gear_specifications_id integer,
    vessel_and_trip_information_id integer,
    reporting_country_code character(3) NOT NULL
);


ALTER TABLE ros_ps.ps_observer_data OWNER TO "ros-admin";

--
-- Name: ps_setting_operations; Type: TABLE; Schema: ros_ps; Owner: ros-admin
--

CREATE TABLE ros_ps.ps_setting_operations (
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
    first_school_detection_method_code character(2),
    wind_scale_code character(2)
);


ALTER TABLE ros_ps.ps_setting_operations OWNER TO "ros-admin";

--
-- Name: v_ps_ca; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
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
    'CL_SP.SPECIES_OFFICIAL???'::text AS "?column?",
    cl_fa.code AS fate,
    sum(((
        CASE
            WHEN ((w.unit)::text = 'MT'::text) THEN 1000
            ELSE 1
        END)::double precision * w.value)) AS observed_catch,
    'KG'::text AS catch_unit
   FROM (((((((((((ros_ps.ps_observer_data od
     JOIN ros_common.general_vessel_and_trip_information gvti ON ((od.vessel_and_trip_information_id = gvti.id)))
     JOIN ros_common.vessel_identification vi ON ((gvti.vessel_identification_id = vi.id)))
     JOIN refs_admin.countries cl_co ON ((vi.flag_code = cl_co.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON ((cl_co.code = (fl.flag_code)::bpchar)))
     JOIN ros_ps.ps_fishing_events fe ON ((fe.ps_observer_data_id = od.id)))
     LEFT JOIN ros_ps.ps_setting_operations se ON ((fe.ps_setting_operation_id = se.id)))
     JOIN ros_ps.ps_catch_details ca ON ((ca.ps_fishing_event_id = fe.id)))
     JOIN refs_biological.species cl_sp ON (((ca.species_code)::text = (cl_sp.code)::text)))
     LEFT JOIN refs_biological.fates cl_fa ON ((ca.fates_code = cl_fa.code)))
     JOIN ros_common.estimated_weights w ON ((ca.estimated_weight_id = w.id)))
     LEFT JOIN refs_fishery.fish_processing_types cl_pt ON ((w.processing_type_code = cl_pt.code)))
  GROUP BY COALESCE(fl.fleet_code, (cl_co.code)::character varying), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)), (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude)), cl_sp.code, cl_sp.species_group_code, cl_fa.code, w.unit;


ALTER VIEW ros_analysis.v_ps_ca OWNER TO "ros-admin";

--
-- Name: v_ca; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
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
    v_ll_ca."?column?",
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
    v_ps_ca."?column?",
    v_ps_ca.fate,
    v_ps_ca.observed_catch,
    v_ps_ca.catch_unit
   FROM ros_analysis.v_ps_ca;


ALTER VIEW ros_analysis.v_ca OWNER TO "ros-admin";

--
-- Name: ll_hauling_operations; Type: TABLE; Schema: ros_ll; Owner: ros-admin
--

CREATE TABLE ros_ll.ll_hauling_operations (
    id integer NOT NULL,
    bird_scaring_device_at_hauler smallint DEFAULT 0,
    end_hauling_date_and_time timestamp(6) without time zone,
    number_of_hooks_observed integer,
    offal_management character varying(255),
    start_hauling_date_and_time timestamp(6) without time zone,
    end_hauling_latitude double precision,
    end_hauling_longitude double precision,
    start_hauling_latitude double precision,
    start_hauling_longitude double precision,
    sampling_protocol_code character(2)
);


ALTER TABLE ros_ll.ll_hauling_operations OWNER TO "ros-admin";

--
-- Name: v_ll_ef_fd; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
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
   FROM (((((((ros_ll.ll_observer_data od
     JOIN ros_common.general_vessel_and_trip_information gvti ON ((od.vessel_and_trip_information_id = gvti.id)))
     JOIN ros_common.vessel_identification vi ON ((gvti.vessel_identification_id = vi.id)))
     JOIN refs_admin.countries cl_co ON ((vi.flag_code = cl_co.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON ((cl_co.code = (fl.flag_code)::bpchar)))
     JOIN ros_ll.ll_fishing_events fe ON ((fe.ll_observer_data_id = od.id)))
     LEFT JOIN ros_ll.ll_setting_operations se ON ((fe.ll_setting_operation_id = se.id)))
     LEFT JOIN ros_ll.ll_hauling_operations ha ON ((fe.ll_hauling_operation_id = ha.id)))
  WHERE (se.start_setting_date_and_time IS NOT NULL)
  GROUP BY COALESCE(fl.fleet_code, (cl_co.code)::character varying), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)), (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude));


ALTER VIEW ros_analysis.v_ll_ef_fd OWNER TO "ros-admin";

--
-- Name: v_ll_ef_raw; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
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
   FROM (((((((ros_ll.ll_observer_data od
     JOIN ros_common.general_vessel_and_trip_information gvti ON ((od.vessel_and_trip_information_id = gvti.id)))
     JOIN ros_common.vessel_identification vi ON ((gvti.vessel_identification_id = vi.id)))
     JOIN refs_admin.countries cl_co ON ((vi.flag_code = cl_co.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON ((cl_co.code = (fl.flag_code)::bpchar)))
     JOIN ros_ll.ll_fishing_events fe ON ((fe.ll_observer_data_id = od.id)))
     LEFT JOIN ros_ll.ll_setting_operations se ON ((fe.ll_setting_operation_id = se.id)))
     LEFT JOIN ros_ll.ll_hauling_operations ha ON ((fe.ll_hauling_operation_id = ha.id)))
  WHERE (se.start_setting_date_and_time IS NOT NULL)
  GROUP BY COALESCE(fl.fleet_code, (cl_co.code)::character varying), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)), (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude));


ALTER VIEW ros_analysis.v_ll_ef_raw OWNER TO "ros-admin";

--
-- Name: v_ll_ef_sets; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
--

CREATE VIEW ros_analysis.v_ll_ef_sets AS
 SELECT 'LL'::text AS gear,
    COALESCE(fl.fleet_code, (cl_co.code)::character varying) AS flag,
    date_part('year'::text, se.start_setting_date_and_time) AS year,
    date_part('month'::text, se.start_setting_date_and_time) AS month,
    ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude) AS grid_1,
    ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude) AS grid_5,
    count(DISTINCT fe.event_number) AS effort,
    'SETS'::text AS effort_unit
   FROM (((((((ros_ll.ll_observer_data od
     JOIN ros_common.general_vessel_and_trip_information gvti ON ((od.vessel_and_trip_information_id = gvti.id)))
     JOIN ros_common.vessel_identification vi ON ((gvti.vessel_identification_id = vi.id)))
     JOIN refs_admin.countries cl_co ON ((vi.flag_code = cl_co.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON ((cl_co.code = (fl.flag_code)::bpchar)))
     JOIN ros_ll.ll_fishing_events fe ON ((fe.ll_observer_data_id = od.id)))
     LEFT JOIN ros_ll.ll_setting_operations se ON ((fe.ll_setting_operation_id = se.id)))
     LEFT JOIN ros_ll.ll_hauling_operations ha ON ((fe.ll_hauling_operation_id = ha.id)))
  WHERE (se.start_setting_date_and_time IS NOT NULL)
  GROUP BY COALESCE(fl.fleet_code, (cl_co.code)::character varying), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)), (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude));


ALTER VIEW ros_analysis.v_ll_ef_sets OWNER TO "ros-admin";

--
-- Name: v_ll_ef; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
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


ALTER VIEW ros_analysis.v_ll_ef OWNER TO "ros-admin";

--
-- Name: v_ps_ef_fd; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
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
   FROM ((((((ros_ps.ps_observer_data od
     JOIN ros_common.general_vessel_and_trip_information gvti ON ((od.vessel_and_trip_information_id = gvti.id)))
     JOIN ros_common.vessel_identification vi ON ((gvti.vessel_identification_id = vi.id)))
     JOIN refs_admin.countries cl_co ON ((vi.flag_code = cl_co.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON ((cl_co.code = (fl.flag_code)::bpchar)))
     JOIN ros_ps.ps_fishing_events fe ON ((fe.ps_observer_data_id = od.id)))
     LEFT JOIN ros_ps.ps_setting_operations se ON ((fe.ps_setting_operation_id = se.id)))
  GROUP BY COALESCE(fl.fleet_code, (cl_co.code)::character varying), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)), (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude));


ALTER VIEW ros_analysis.v_ps_ef_fd OWNER TO "ros-admin";

--
-- Name: v_ps_ef_raw; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
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
   FROM ((((((ros_ps.ps_observer_data od
     JOIN ros_common.general_vessel_and_trip_information gvti ON ((od.vessel_and_trip_information_id = gvti.id)))
     JOIN ros_common.vessel_identification vi ON ((gvti.vessel_identification_id = vi.id)))
     JOIN refs_admin.countries cl_co ON ((vi.flag_code = cl_co.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON ((cl_co.code = (fl.flag_code)::bpchar)))
     JOIN ros_ps.ps_fishing_events fe ON ((fe.ps_observer_data_id = od.id)))
     LEFT JOIN ros_ps.ps_setting_operations se ON ((fe.ps_setting_operation_id = se.id)))
  GROUP BY COALESCE(fl.fleet_code, (cl_co.code)::character varying), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)), (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude));


ALTER VIEW ros_analysis.v_ps_ef_raw OWNER TO "ros-admin";

--
-- Name: v_ps_ef; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
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


ALTER VIEW ros_analysis.v_ps_ef OWNER TO "ros-admin";

--
-- Name: v_ef; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
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


ALTER VIEW ros_analysis.v_ef OWNER TO "ros-admin";

--
-- Name: v_ce; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
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
    'C.SPECIES_OFFICIAL???'::text AS "?column?",
    c.fate,
    c.observed_catch,
    c.catch_unit
   FROM (ros_analysis.v_ef e
     LEFT JOIN ros_analysis.v_ca c ON (((e.gear = c.gear) AND ((e.flag)::text = (c.flag)::text) AND (e.year = c.year) AND (e.month = c.month) AND (e.grid_1 = c.grid_1) AND (e.grid_5 = c.grid_5))));


ALTER VIEW ros_analysis.v_ce OWNER TO "ros-admin";

--
-- Name: v_ef_fd; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
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


ALTER VIEW ros_analysis.v_ef_fd OWNER TO "ros-admin";

--
-- Name: v_ef_raw; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
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


ALTER VIEW ros_analysis.v_ef_raw OWNER TO "ros-admin";

--
-- Name: v_efforts_by_year_flag_and_gear; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
--

CREATE VIEW ros_analysis.v_efforts_by_year_flag_and_gear AS
 SELECT 'LL'::text AS gear,
    COALESCE(fl.fleet_code, (cl_co.code)::character varying) AS flag,
    date_part('year'::text, se.start_setting_date_and_time) AS year,
    sum(se.total_number_of_hooks_set) AS observed_effort,
    'HOOK'::text AS effort_unit
   FROM (((((((ros_ll.ll_observer_data od
     JOIN ros_common.general_vessel_and_trip_information gvti ON ((od.vessel_and_trip_information_id = gvti.id)))
     JOIN ros_common.vessel_identification vi ON ((gvti.vessel_identification_id = vi.id)))
     JOIN refs_admin.countries cl_co ON ((vi.flag_code = cl_co.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON ((cl_co.code = (fl.flag_code)::bpchar)))
     JOIN ros_ll.ll_fishing_events fe ON ((fe.ll_observer_data_id = od.id)))
     LEFT JOIN ros_ll.ll_setting_operations se ON ((fe.ll_setting_operation_id = se.id)))
     LEFT JOIN ros_ll.ll_hauling_operations ha ON ((fe.ll_hauling_operation_id = ha.id)))
  GROUP BY COALESCE(fl.fleet_code, (cl_co.code)::character varying), (date_part('year'::text, se.start_setting_date_and_time))
UNION ALL
 SELECT 'PS'::text AS gear,
    COALESCE(fl.fleet_code, (cl_co.code)::character varying) AS flag,
    date_part('year'::text, se.start_setting_date_and_time) AS year,
    count(DISTINCT se.id) AS observed_effort,
    'SET'::text AS effort_unit
   FROM ((((((ros_ps.ps_observer_data od
     JOIN ros_common.general_vessel_and_trip_information gvti ON ((od.vessel_and_trip_information_id = gvti.id)))
     JOIN ros_common.vessel_identification vi ON ((gvti.vessel_identification_id = vi.id)))
     JOIN refs_admin.countries cl_co ON ((vi.flag_code = cl_co.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON ((cl_co.code = (fl.flag_code)::bpchar)))
     JOIN ros_ps.ps_fishing_events fe ON ((fe.ps_observer_data_id = od.id)))
     LEFT JOIN ros_ps.ps_setting_operations se ON ((fe.ps_setting_operation_id = se.id)))
  GROUP BY COALESCE(fl.fleet_code, (cl_co.code)::character varying), (date_part('year'::text, se.start_setting_date_and_time));


ALTER VIEW ros_analysis.v_efforts_by_year_flag_and_gear OWNER TO "ros-admin";

--
-- Name: additional_details_on_non_target_species; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.additional_details_on_non_target_species (
    id integer NOT NULL,
    condition_at_capture_code character varying(3),
    condition_at_release_code character varying(3)
);


ALTER TABLE ros_common.additional_details_on_non_target_species OWNER TO "ros-admin";

--
-- Name: v_ll_in; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
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
    'CL_SP.SPECIES_OFFICIAL???'::text AS "?column?",
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
   FROM ((((((((((((ros_ll.ll_observer_data od
     JOIN ros_common.general_vessel_and_trip_information gvti ON ((od.vessel_and_trip_information_id = gvti.id)))
     JOIN ros_common.vessel_identification vi ON ((gvti.vessel_identification_id = vi.id)))
     JOIN refs_admin.countries cl_co ON ((vi.flag_code = cl_co.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON ((cl_co.code = (fl.flag_code)::bpchar)))
     JOIN ros_ll.ll_fishing_events fe ON ((fe.ll_observer_data_id = od.id)))
     LEFT JOIN ros_ll.ll_setting_operations se ON ((fe.ll_setting_operation_id = se.id)))
     JOIN ros_ll.ll_catch_details ca ON ((ca.ll_fishing_event_id = fe.id)))
     JOIN refs_biological.species cl_sp ON (((ca.species_code)::text = (cl_sp.code)::text)))
     LEFT JOIN refs_biological.fates cl_fa ON ((ca.fates_code = cl_fa.code)))
     LEFT JOIN ros_ll.ll_specimens sp ON ((sp.ll_catch_detail_id = ca.id)))
     LEFT JOIN ros_common.additional_details_on_non_target_species adnt ON ((sp.additional_specimen_details_non_target_species_id = adnt.id)))
     LEFT JOIN refs_biological.incidental_captures_conditions cl_cn ON (((COALESCE(adnt.condition_at_capture_code, adnt.condition_at_release_code))::text = (cl_cn.code)::text)))
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


ALTER VIEW ros_analysis.v_ll_in OWNER TO "ros-admin";

--
-- Name: ps_specimens; Type: TABLE; Schema: ros_ps; Owner: ros-admin
--

CREATE TABLE ros_ps.ps_specimens (
    id integer NOT NULL,
    specimen_number character varying(255) NOT NULL,
    ps_additional_catch_details_on_ssis_id integer,
    additional_specimen_details_non_target_species_id integer,
    biometric_information_id integer,
    ps_tag_detail_id integer,
    ps_catch_detail_id integer
);


ALTER TABLE ros_ps.ps_specimens OWNER TO "ros-admin";

--
-- Name: v_ps_in; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
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
    'CL_SP.SPECIES_OFFICIAL???'::text AS "?column?",
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
   FROM ((((((((((((ros_ps.ps_observer_data od
     JOIN ros_common.general_vessel_and_trip_information gvti ON ((od.vessel_and_trip_information_id = gvti.id)))
     JOIN ros_common.vessel_identification vi ON ((gvti.vessel_identification_id = vi.id)))
     JOIN refs_admin.countries cl_co ON ((vi.flag_code = cl_co.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON ((cl_co.code = (fl.flag_code)::bpchar)))
     JOIN ros_ps.ps_fishing_events fe ON ((fe.ps_observer_data_id = od.id)))
     LEFT JOIN ros_ps.ps_setting_operations se ON ((fe.ps_setting_operation_id = se.id)))
     JOIN ros_ps.ps_catch_details ca ON ((ca.ps_fishing_event_id = fe.id)))
     JOIN refs_biological.species cl_sp ON (((ca.species_code)::text = (cl_sp.code)::text)))
     LEFT JOIN refs_biological.fates cl_fa ON ((ca.fates_code = cl_fa.code)))
     JOIN ros_ps.ps_specimens sp ON ((sp.ps_catch_detail_id = ca.id)))
     LEFT JOIN ros_common.additional_details_on_non_target_species adnt ON ((sp.additional_specimen_details_non_target_species_id = adnt.id)))
     LEFT JOIN refs_biological.incidental_captures_conditions cl_cn ON (((COALESCE(adnt.condition_at_capture_code, adnt.condition_at_release_code))::text = (cl_cn.code)::text)))
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


ALTER VIEW ros_analysis.v_ps_in OWNER TO "ros-admin";

--
-- Name: v_in; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
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
    v_ll_in."?column?",
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
    v_ps_in."?column?",
    v_ps_in.num_interactions,
    v_ps_in.fate,
    v_ps_in.fate_code,
    v_ps_in.condition,
    v_ps_in.condition_code
   FROM ros_analysis.v_ps_in;


ALTER VIEW ros_analysis.v_in OWNER TO "ros-admin";

--
-- Name: v_ll_ce; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
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
    'C.SPECIES_OFFICIAL???'::text AS "?column?",
    c.fate,
    c.observed_catch,
    c.catch_unit
   FROM (ros_analysis.v_ll_ef e
     LEFT JOIN ros_analysis.v_ll_ca c ON (((e.gear = c.gear) AND ((e.flag)::text = (c.flag)::text) AND (e.year = c.year) AND (e.month = c.month) AND (e.grid_1 = c.grid_1) AND (e.grid_5 = c.grid_5))));


ALTER VIEW ros_analysis.v_ll_ce OWNER TO "ros-admin";

--
-- Name: v_ll_sets_raw; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
--

CREATE VIEW ros_analysis.v_ll_sets_raw AS
 SELECT COALESCE(f2f.flag_code, (c.code)::character varying) AS flag_code,
    COALESCE(f2f.fleet_code, (c.code)::character varying) AS fleet_code,
    'LL'::text AS gear_code,
    'LLO'::text AS fishery_code,
    'LL'::text AS fishery_group_code,
    'IND'::text AS fishery_type_code,
    o.id AS trip_id,
    o.uid AS trip_uid,
    fed.ll_setting_operation_id AS set_id,
    fed.event_number AS set_uid,
    'SETTING'::text AS event_type_code,
    so.start_setting_date_and_time AS start_time,
    so.start_setting_longitude AS start_lon,
    so.start_setting_latitude AS start_lat,
    so.end_setting_date_and_time AS end_time,
    so.end_setting_longitude AS end_lon,
    so.end_setting_latitude AS end_lat,
    so.total_number_of_hooks_set AS effort,
    'HK'::text AS effort_unit_code
   FROM ((((((ros_ll.ll_observer_data o
     JOIN ros_common.general_vessel_and_trip_information gvt ON ((o.vessel_and_trip_information_id = gvt.id)))
     JOIN ros_common.vessel_identification vi ON ((gvt.vessel_identification_id = vi.id)))
     LEFT JOIN refs_admin.countries c ON ((vi.flag_code = c.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries f2f ON ((c.code = (f2f.flag_code)::bpchar)))
     JOIN ros_ll.ll_fishing_events fed ON ((fed.ll_observer_data_id = o.id)))
     JOIN ros_ll.ll_setting_operations so ON ((fed.ll_setting_operation_id = so.id)))
UNION ALL
 SELECT COALESCE(f2f.flag_code, (c.code)::character varying) AS flag_code,
    COALESCE(f2f.fleet_code, (c.code)::character varying) AS fleet_code,
    'LL'::text AS gear_code,
    'LLO'::text AS fishery_code,
    'LL'::text AS fishery_group_code,
    'IND'::text AS fishery_type_code,
    o.id AS trip_id,
    o.uid AS trip_uid,
    fed.ll_setting_operation_id AS set_id,
    fed.event_number AS set_uid,
    'HAULING'::text AS event_type_code,
    ho.start_hauling_date_and_time AS start_time,
    ho.start_hauling_longitude AS start_lon,
    ho.start_hauling_latitude AS start_lat,
    ho.end_hauling_date_and_time AS end_time,
    ho.end_hauling_longitude AS end_lon,
    ho.end_hauling_latitude AS end_lat,
    ho.number_of_hooks_observed AS effort,
    'HK'::text AS effort_unit_code
   FROM ((((((ros_ll.ll_observer_data o
     JOIN ros_common.general_vessel_and_trip_information gvt ON ((o.vessel_and_trip_information_id = gvt.id)))
     JOIN ros_common.vessel_identification vi ON ((gvt.vessel_identification_id = vi.id)))
     LEFT JOIN refs_admin.countries c ON ((vi.flag_code = c.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries f2f ON ((c.code = (f2f.flag_code)::bpchar)))
     JOIN ros_ll.ll_fishing_events fed ON ((fed.ll_observer_data_id = o.id)))
     JOIN ros_ll.ll_hauling_operations ho ON ((fed.ll_hauling_operation_id = ho.id)));


ALTER VIEW ros_analysis.v_ll_sets_raw OWNER TO "ros-admin";

--
-- Name: biometric_information; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.biometric_information (
    id integer NOT NULL,
    alternative_measured_length_id integer,
    estimated_weight_id integer,
    maturity_stage_id integer,
    measured_length_id integer,
    sample_collection_detail_id integer,
    bio_collection_sampling_method_code character(2),
    sex_code character(1)
);


ALTER TABLE ros_common.biometric_information OWNER TO "ros-admin";

--
-- Name: measured_lengths; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.measured_lengths (
    id integer NOT NULL,
    curved smallint DEFAULT 0,
    unit character varying(3),
    value double precision,
    type_of_measurement_code character(2) NOT NULL,
    measured_length_type_code character(2),
    length_measuring_tool_code character(2)
);


ALTER TABLE ros_common.measured_lengths OWNER TO "ros-admin";

--
-- Name: v_ll_sf_l; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
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
    'CL_SP.SPECIES_OFFICIAL???'::text AS "?column?",
    cl_fa.code AS fate,
    cl_sx.code AS sex,
    cl_le.code AS length_code,
    ln.unit AS length_unit,
    floor(ln.value) AS size_bin,
    count(DISTINCT sp.id) AS num_fish
   FROM ((((((((((((((ros_ll.ll_observer_data od
     JOIN ros_common.general_vessel_and_trip_information gvti ON ((od.vessel_and_trip_information_id = gvti.id)))
     JOIN ros_common.vessel_identification vi ON ((gvti.vessel_identification_id = vi.id)))
     JOIN refs_admin.countries cl_co ON ((vi.flag_code = cl_co.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON ((cl_co.code = (fl.flag_code)::bpchar)))
     JOIN ros_ll.ll_fishing_events fe ON ((fe.ll_observer_data_id = od.id)))
     LEFT JOIN ros_ll.ll_setting_operations se ON ((fe.ll_setting_operation_id = se.id)))
     JOIN ros_ll.ll_catch_details ca ON ((ca.ll_fishing_event_id = fe.id)))
     JOIN refs_biological.species cl_sp ON (((ca.species_code)::text = (cl_sp.code)::text)))
     LEFT JOIN refs_biological.fates cl_fa ON ((ca.fates_code = cl_fa.code)))
     JOIN ros_ll.ll_specimens sp ON ((sp.ll_catch_detail_id = ca.id)))
     JOIN ros_common.biometric_information bi ON ((sp.biometric_information_id = bi.id)))
     LEFT JOIN refs_biological.sex cl_sx ON ((bi.sex_code = cl_sx.code)))
     JOIN ros_common.measured_lengths ln ON (((bi.measured_length_id = ln.id) OR (bi.alternative_measured_length_id = ln.id))))
     LEFT JOIN refs_biological.measurements cl_le ON ((ln.measured_length_type_code = cl_le.code)))
  GROUP BY COALESCE(fl.fleet_code, (cl_co.code)::character varying), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)), (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude)), cl_sp.code, cl_sp.species_group_code, cl_fa.code, cl_sx.code, cl_le.code, (floor(ln.value)), ln.unit;


ALTER VIEW ros_analysis.v_ll_sf_l OWNER TO "ros-admin";

--
-- Name: v_ll_sf_w; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
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
    'CL_SP.SPECIES_OFFICIAL???'::text AS "?column?",
    cl_fa.code AS fate,
    cl_sx.code AS sex,
    cl_pt.code AS weight_code,
    we.unit AS weight_unit,
    floor(we.value) AS size_bin,
    count(DISTINCT sp.id) AS num_fish
   FROM ((((((((((((((ros_ll.ll_observer_data od
     JOIN ros_common.general_vessel_and_trip_information gvti ON ((od.vessel_and_trip_information_id = gvti.id)))
     JOIN ros_common.vessel_identification vi ON ((gvti.vessel_identification_id = vi.id)))
     JOIN refs_admin.countries cl_co ON ((vi.flag_code = cl_co.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON ((cl_co.code = (fl.flag_code)::bpchar)))
     JOIN ros_ll.ll_fishing_events fe ON ((fe.ll_observer_data_id = od.id)))
     LEFT JOIN ros_ll.ll_setting_operations se ON ((fe.ll_setting_operation_id = se.id)))
     JOIN ros_ll.ll_catch_details ca ON ((ca.ll_fishing_event_id = fe.id)))
     JOIN refs_biological.species cl_sp ON (((ca.species_code)::text = (cl_sp.code)::text)))
     LEFT JOIN refs_biological.fates cl_fa ON ((ca.fates_code = cl_fa.code)))
     JOIN ros_ll.ll_specimens sp ON ((sp.ll_catch_detail_id = ca.id)))
     JOIN ros_common.biometric_information bi ON ((sp.biometric_information_id = bi.id)))
     LEFT JOIN refs_biological.sex cl_sx ON ((bi.sex_code = cl_sx.code)))
     JOIN ros_common.estimated_weights we ON ((bi.estimated_weight_id = we.id)))
     LEFT JOIN refs_fishery.fish_processing_types cl_pt ON ((we.processing_type_code = cl_pt.code)))
  GROUP BY COALESCE(fl.fleet_code, (cl_co.code)::character varying), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)), (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude)), cl_sp.code, cl_sp.species_group_code, cl_fa.code, cl_sx.code, cl_pt.code, (floor(we.value)), we.unit;


ALTER VIEW ros_analysis.v_ll_sf_w OWNER TO "ros-admin";

--
-- Name: ros_observers; Type: TABLE; Schema: ros_meta; Owner: ros-admin
--

CREATE TABLE ros_meta.ros_observers (
    iotc_number character(10) NOT NULL,
    first_name character varying(255),
    last_name character varying(255) NOT NULL,
    basic_training smallint DEFAULT 0,
    medical_certificate smallint DEFAULT 0,
    national_number character varying(255),
    active smallint DEFAULT 0 NOT NULL,
    login_id integer,
    nationality_code character(3) NOT NULL
);


ALTER TABLE ros_meta.ros_observers OWNER TO "ros-admin";

--
-- Name: ros_observers_2_flags; Type: TABLE; Schema: ros_meta; Owner: ros-admin
--

CREATE TABLE ros_meta.ros_observers_2_flags (
    iotc_number character(10) NOT NULL,
    date_from timestamp(6) without time zone,
    date_to timestamp(6) without time zone,
    flag_code character(3) NOT NULL
);


ALTER TABLE ros_meta.ros_observers_2_flags OWNER TO "ros-admin";

--
-- Name: v_observers; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
--

CREATE VIEW ros_analysis.v_observers AS
 WITH obs AS (
         SELECT ob.iotc_number,
            f.code AS flag_code,
            ob.last_name,
            ob.first_name,
            n.code AS nationality_code,
            ob.active
           FROM (((ros_meta.ros_observers ob
             JOIN ros_meta.ros_observers_2_flags o2f ON ((ob.iotc_number = o2f.iotc_number)))
             JOIN refs_admin.countries f ON ((o2f.flag_code = f.code)))
             JOIN refs_admin.countries n ON ((ob.nationality_code = n.code)))
        )
 SELECT DISTINCT iotc_number,
        CASE
            WHEN (iotc_number ~~ '%EUR%'::text) THEN 'EUR'::bpchar
            ELSE flag_code
        END AS flag_code,
    last_name,
    first_name,
    nationality_code,
    active
   FROM obs
  WHERE ((iotc_number !~~ '%DUM%'::text) AND ((last_name)::text !~~ '%DUMMY%'::text) AND ((last_name)::text !~~ '%KEN ROS%'::text));


ALTER VIEW ros_analysis.v_observers OWNER TO "ros-admin";

--
-- Name: v_observers_summary; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
--

CREATE VIEW ros_analysis.v_observers_summary AS
 SELECT
        CASE
            WHEN (iotc_number ~~ '%EUR%'::text) THEN 'EUR'::bpchar
            ELSE flag_code
        END AS flag_code,
    sum(
        CASE
            WHEN (active = 1) THEN 1
            ELSE 0
        END) AS num_active,
    sum(
        CASE
            WHEN (active = 0) THEN 1
            ELSE 0
        END) AS num_inactive
   FROM ros_analysis.v_observers v
  GROUP BY
        CASE
            WHEN (iotc_number ~~ '%EUR%'::text) THEN 'EUR'::bpchar
            ELSE flag_code
        END;


ALTER VIEW ros_analysis.v_observers_summary OWNER TO "ros-admin";

--
-- Name: v_ps_ce; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
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
    'C.SPECIES_OFFICIAL???'::text AS "?column?",
    c.fate,
    c.observed_catch,
    c.catch_unit
   FROM (ros_analysis.v_ps_ef e
     LEFT JOIN ros_analysis.v_ps_ca c ON (((e.gear = c.gear) AND ((e.flag)::text = (c.flag)::text) AND (e.year = c.year) AND (e.month = c.month) AND (e.grid_1 = c.grid_1) AND (e.grid_5 = c.grid_5))));


ALTER VIEW ros_analysis.v_ps_ce OWNER TO "ros-admin";

--
-- Name: v_ps_lw; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
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
    'CL_SP.SPECIES_OFFICIAL???'::text AS "?column?",
    cl_fa.code AS fate,
    cl_sx.code AS sex,
    cl_le.code AS length_code,
    ln.value AS length,
    ln.unit AS length_unit,
    cl_pt.code AS weight_type,
    ew.value AS weight,
    ew.unit AS weight_unit
   FROM ((((((((((((((((ros_ps.ps_observer_data od
     JOIN ros_common.general_vessel_and_trip_information gvti ON ((od.vessel_and_trip_information_id = gvti.id)))
     JOIN ros_common.vessel_identification vi ON ((gvti.vessel_identification_id = vi.id)))
     JOIN refs_admin.countries cl_co ON ((vi.flag_code = cl_co.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON ((cl_co.code = (fl.flag_code)::bpchar)))
     JOIN ros_ps.ps_fishing_events fe ON ((fe.ps_observer_data_id = od.id)))
     LEFT JOIN ros_ps.ps_setting_operations se ON ((fe.ps_setting_operation_id = se.id)))
     JOIN ros_ps.ps_catch_details ca ON ((ca.ps_fishing_event_id = fe.id)))
     JOIN refs_biological.species cl_sp ON (((ca.species_code)::text = (cl_sp.code)::text)))
     LEFT JOIN refs_biological.fates cl_fa ON ((ca.fates_code = cl_fa.code)))
     JOIN ros_ps.ps_specimens sp ON ((sp.ps_catch_detail_id = ca.id)))
     JOIN ros_common.biometric_information bi ON ((sp.biometric_information_id = bi.id)))
     LEFT JOIN refs_biological.sex cl_sx ON ((bi.sex_code = cl_sx.code)))
     JOIN ros_common.measured_lengths ln ON ((bi.measured_length_id = ln.id)))
     LEFT JOIN refs_biological.measurements cl_le ON ((ln.measured_length_type_code = cl_le.code)))
     JOIN ros_common.estimated_weights ew ON ((bi.estimated_weight_id = ew.id)))
     LEFT JOIN refs_fishery.fish_processing_types cl_pt ON ((ew.processing_type_code = cl_pt.code)));


ALTER VIEW ros_analysis.v_ps_lw OWNER TO "ros-admin";

--
-- Name: v_ps_sets_raw; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
--

CREATE VIEW ros_analysis.v_ps_sets_raw AS
 SELECT COALESCE(f2f.flag_code, (c.code)::character varying) AS flag_code,
    COALESCE(f2f.fleet_code, (c.code)::character varying) AS fleet_code,
    'PS'::text AS gear_code,
    'PSOT'::text AS fishery_code,
    'PS'::text AS fishery_group_code,
    'IND'::text AS fishery_type_code,
    o.id AS trip_id,
    o.uid AS trip_uid,
    fed.ps_setting_operation_id AS set_id,
    fed.event_number AS set_uid,
    'SETTING'::text AS event_type_code,
    so.start_setting_date_and_time AS start_time,
    so.start_setting_longitude AS start_lon,
    so.start_setting_latitude AS start_lat,
    COALESCE(so.time_end_brailing, so.time_skiff_onboard, so.time_net_pursed, so.start_setting_date_and_time) AS end_time,
    so.start_setting_longitude AS end_lon,
    so.start_setting_latitude AS end_lat,
    1 AS effort,
    'SET'::text AS effort_unit_code
   FROM ((((((ros_ps.ps_observer_data o
     JOIN ros_common.general_vessel_and_trip_information gvt ON ((o.vessel_and_trip_information_id = gvt.id)))
     JOIN ros_common.vessel_identification vi ON ((gvt.vessel_identification_id = vi.id)))
     LEFT JOIN refs_admin.countries c ON ((vi.flag_code = c.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries f2f ON ((c.code = (f2f.flag_code)::bpchar)))
     JOIN ros_ps.ps_fishing_events fed ON ((fed.ps_observer_data_id = o.id)))
     JOIN ros_ps.ps_setting_operations so ON ((fed.ps_setting_operation_id = so.id)));


ALTER VIEW ros_analysis.v_ps_sets_raw OWNER TO "ros-admin";

--
-- Name: v_ps_sf_l; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
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
    'CL_SP.SPECIES_OFFICIAL???'::text AS "?column?",
    cl_fa.code AS fate,
    cl_sx.code AS sex,
    cl_le.code AS length_code,
    ln.unit AS length_unit,
    floor(ln.value) AS size_bin,
    count(DISTINCT sp.id) AS num_fish
   FROM ((((((((((((((ros_ps.ps_observer_data od
     JOIN ros_common.general_vessel_and_trip_information gvti ON ((od.vessel_and_trip_information_id = gvti.id)))
     JOIN ros_common.vessel_identification vi ON ((gvti.vessel_identification_id = vi.id)))
     JOIN refs_admin.countries cl_co ON ((vi.flag_code = cl_co.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON ((cl_co.code = (fl.flag_code)::bpchar)))
     JOIN ros_ps.ps_fishing_events fe ON ((fe.ps_observer_data_id = od.id)))
     LEFT JOIN ros_ps.ps_setting_operations se ON ((fe.ps_setting_operation_id = se.id)))
     JOIN ros_ps.ps_catch_details ca ON ((ca.ps_fishing_event_id = fe.id)))
     JOIN refs_biological.species cl_sp ON (((ca.species_code)::text = (cl_sp.code)::text)))
     LEFT JOIN refs_biological.fates cl_fa ON ((ca.fates_code = cl_fa.code)))
     JOIN ros_ps.ps_specimens sp ON ((sp.ps_catch_detail_id = ca.id)))
     JOIN ros_common.biometric_information bi ON ((sp.biometric_information_id = bi.id)))
     LEFT JOIN refs_biological.sex cl_sx ON ((bi.sex_code = cl_sx.code)))
     LEFT JOIN ros_common.measured_lengths ln ON (((bi.measured_length_id = ln.id) OR (bi.alternative_measured_length_id = ln.id))))
     JOIN refs_biological.measurements cl_le ON ((ln.measured_length_type_code = cl_le.code)))
  GROUP BY COALESCE(fl.fleet_code, (cl_co.code)::character varying), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)), (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude)), cl_sp.code, cl_sp.species_group_code, cl_fa.code, cl_sx.code, cl_le.code, (floor(ln.value)), ln.unit;


ALTER VIEW ros_analysis.v_ps_sf_l OWNER TO "ros-admin";

--
-- Name: v_ps_sf_w; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
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
    'CL_SP.SPECIES_OFFICIAL???'::text AS "?column?",
    cl_fa.code AS fate,
    cl_sx.code AS sex,
    cl_pt.code AS weight_code,
    we.unit AS length_unit,
    floor(we.value) AS size_bin,
    count(DISTINCT sp.id) AS num_fish
   FROM ((((((((((((((ros_ps.ps_observer_data od
     JOIN ros_common.general_vessel_and_trip_information gvti ON ((od.vessel_and_trip_information_id = gvti.id)))
     JOIN ros_common.vessel_identification vi ON ((gvti.vessel_identification_id = vi.id)))
     JOIN refs_admin.countries cl_co ON ((vi.flag_code = cl_co.code)))
     LEFT JOIN refs_admin.fleet_to_flags_and_fisheries fl ON ((cl_co.code = (fl.flag_code)::bpchar)))
     JOIN ros_ps.ps_fishing_events fe ON ((fe.ps_observer_data_id = od.id)))
     LEFT JOIN ros_ps.ps_setting_operations se ON ((fe.ps_setting_operation_id = se.id)))
     JOIN ros_ps.ps_catch_details ca ON ((ca.ps_fishing_event_id = fe.id)))
     JOIN refs_biological.species cl_sp ON (((ca.species_code)::text = (cl_sp.code)::text)))
     LEFT JOIN refs_biological.fates cl_fa ON ((ca.fates_code = cl_fa.code)))
     JOIN ros_ps.ps_specimens sp ON ((sp.ps_catch_detail_id = ca.id)))
     JOIN ros_common.biometric_information bi ON ((sp.biometric_information_id = bi.id)))
     LEFT JOIN refs_biological.sex cl_sx ON ((bi.sex_code = cl_sx.code)))
     JOIN ros_common.estimated_weights we ON ((bi.estimated_weight_id = we.id)))
     LEFT JOIN refs_fishery.fish_processing_types cl_pt ON ((we.processing_type_code = cl_pt.code)))
  GROUP BY COALESCE(fl.fleet_code, (cl_co.code)::character varying), (date_part('year'::text, se.start_setting_date_and_time)), (date_part('month'::text, se.start_setting_date_and_time)), (ros_meta.to_grid_1(se.start_setting_latitude, se.start_setting_longitude)), (ros_meta.to_grid_5(se.start_setting_latitude, se.start_setting_longitude)), cl_sp.code, cl_sp.species_group_code, cl_fa.code, cl_sx.code, cl_pt.code, (floor(we.value)), we.unit;


ALTER VIEW ros_analysis.v_ps_sf_w OWNER TO "ros-admin";

--
-- Name: observer_identification; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.observer_identification (
    id integer NOT NULL,
    full_name character varying(255),
    iotc_number character varying(255),
    role character varying(255),
    uid character varying(32) NOT NULL,
    nationality_code character(3)
);


ALTER TABLE ros_common.observer_identification OWNER TO "ros-admin";

--
-- Name: observer_trip_details; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.observer_trip_details (
    id integer NOT NULL,
    date_time_disembarkation timestamp(6) without time zone,
    date_time_embarkation timestamp(6) without time zone,
    disembarkation_location_id integer,
    embarkation_location_id integer
);


ALTER TABLE ros_common.observer_trip_details OWNER TO "ros-admin";

--
-- Name: vessel_trip_details; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.vessel_trip_details (
    id integer NOT NULL,
    date_time_vessel_returned_to_port timestamp(6) without time zone,
    date_time_vessel_sailed timestamp(6) without time zone,
    departure_port_code character varying(16),
    return_port_code character varying(16)
);


ALTER TABLE ros_common.vessel_trip_details OWNER TO "ros-admin";

--
-- Name: gn_observer_data; Type: TABLE; Schema: ros_gn; Owner: ros-admin
--

CREATE TABLE ros_gn.gn_observer_data (
    id integer NOT NULL,
    complete smallint DEFAULT 0 NOT NULL,
    creation_time timestamp(6) without time zone NOT NULL,
    finalization_time timestamp(6) without time zone,
    originator character varying(255) NOT NULL,
    originator_version character varying(255) NOT NULL,
    ros_codelists_version character varying(255) NOT NULL,
    ros_model_version character varying(255) NOT NULL,
    source character varying(255) NOT NULL,
    status character varying(255) NOT NULL,
    submission_time timestamp(6) without time zone,
    uid character varying(255) NOT NULL,
    creator_id integer NOT NULL,
    submitter_id integer,
    gn_gear_specifications_id integer,
    vessel_and_trip_information_id integer,
    reporting_country_code character(3) NOT NULL
);


ALTER TABLE ros_gn.gn_observer_data OWNER TO "ros-admin";

--
-- Name: v_gn_trips; Type: VIEW; Schema: ros_meta; Owner: ros-admin
--

CREATE VIEW ros_meta.v_gn_trips AS
 SELECT gn_o_d.source,
    gn_o_d.id AS trip_id,
    gn_o_d.uid AS trip_uid,
    gvt.trip_number,
    gn_o_d.creation_time AS creation_date,
    gn_o_d.finalization_time AS finalization_date,
    gn_o_d.submission_time AS submission_date,
        CASE
            WHEN (otd.id IS NULL) THEN 0
            ELSE 1
        END AS has_observer_trip_info,
    'GN'::text AS fishing_operation_type,
    oi.iotc_number AS observer_iotc_number,
    n.code AS observer_nationality,
    otd.date_time_embarkation AS observer_imbarcation_date,
    otd.date_time_disembarkation AS observer_disembarcation_date,
    vi.id AS vessel_info_id,
    vi.iotc_number AS vessel_iotc_number,
    g.code AS main_gear,
    r.code AS reporting_flag,
    f.code AS vessel_flag,
    vtd.date_time_vessel_sailed AS vessel_departure_date,
    pd.name_en AS vessel_departure_port,
    cd.code AS vessel_departure_country,
    vtd.date_time_vessel_returned_to_port AS vessel_return_date,
    pr.name_en AS vessel_return_port,
    cr.code AS vessel_return_country
   FROM (((((((((((((ros_gn.gn_observer_data gn_o_d
     JOIN ros_common.general_vessel_and_trip_information gvt ON ((gn_o_d.vessel_and_trip_information_id = gvt.id)))
     LEFT JOIN ros_common.observer_identification oi ON ((gvt.observer_identification_id = oi.id)))
     LEFT JOIN refs_admin.countries n ON ((oi.nationality_code = n.code)))
     LEFT JOIN ros_common.observer_trip_details otd ON ((gvt.observer_trip_detail_id = otd.id)))
     LEFT JOIN ros_common.vessel_identification vi ON ((gvt.vessel_identification_id = vi.id)))
     LEFT JOIN ros_common.vessel_trip_details vtd ON ((gvt.vessel_trip_details_id = vtd.id)))
     LEFT JOIN refs_fishery_config.gears g ON (((vi.main_fishing_gear_code)::text = (g.code)::text)))
     LEFT JOIN refs_admin.countries f ON ((vi.flag_code = f.code)))
     LEFT JOIN refs_admin.countries r ON ((gn_o_d.reporting_country_code = r.code)))
     LEFT JOIN refs_admin.ports pd ON (((vtd.departure_port_code)::text = (pd.code)::text)))
     LEFT JOIN refs_admin.countries cd ON (((pd.country_code)::bpchar = cd.code)))
     LEFT JOIN refs_admin.ports pr ON (((vtd.return_port_code)::text = (pr.code)::text)))
     LEFT JOIN refs_admin.countries cr ON (((pr.country_code)::bpchar = cr.code)));


ALTER VIEW ros_meta.v_gn_trips OWNER TO "ros-admin";

--
-- Name: v_ll_sets; Type: VIEW; Schema: ros_meta; Owner: ros-admin
--

CREATE VIEW ros_meta.v_ll_sets AS
 SELECT o.id AS trip_id,
    o.uid AS trip_uid,
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
   FROM ((((ros_ll.ll_observer_data o
     JOIN ros_common.general_vessel_and_trip_information gvt ON ((o.vessel_and_trip_information_id = gvt.id)))
     JOIN ros_ll.ll_fishing_events fed ON ((fed.ll_observer_data_id = o.id)))
     JOIN ros_ll.ll_setting_operations so ON ((fed.ll_setting_operation_id = so.id)))
     LEFT JOIN ros_ll.ll_hauling_operations ho ON ((fed.ll_hauling_operation_id = ho.id)));


ALTER VIEW ros_meta.v_ll_sets OWNER TO "ros-admin";

--
-- Name: v_ll_trips; Type: VIEW; Schema: ros_meta; Owner: ros-admin
--

CREATE VIEW ros_meta.v_ll_trips AS
 SELECT ll_o_d.source,
    ll_o_d.id AS trip_id,
    ll_o_d.uid AS trip_uid,
    gvt.trip_number,
    ll_o_d.creation_time AS creation_date,
    ll_o_d.finalization_time AS finalization_date,
    ll_o_d.submission_time AS submission_date,
        CASE
            WHEN (otd.id IS NULL) THEN 0
            ELSE 1
        END AS has_observer_trip_info,
    'LL'::text AS fishing_operation_type,
    oi.iotc_number AS observer_iotc_number,
    n.code AS observer_nationality,
    otd.date_time_embarkation AS observer_imbarcation_date,
    otd.date_time_disembarkation AS observer_disembarcation_date,
    vi.id AS vessel_info_id,
    vi.iotc_number AS vessel_iotc_number,
    g.code AS main_gear,
    r.code AS reporting_flag,
    f.code AS vessel_flag,
    vtd.date_time_vessel_sailed AS vessel_departure_date,
    pd.name_en AS vessel_departure_port,
    cd.code AS vessel_departure_country,
    vtd.date_time_vessel_returned_to_port AS vessel_return_date,
    pr.name_en AS vessel_return_port,
    cr.code AS vessel_return_country
   FROM (((((((((((((ros_ll.ll_observer_data ll_o_d
     JOIN ros_common.general_vessel_and_trip_information gvt ON ((ll_o_d.vessel_and_trip_information_id = gvt.id)))
     LEFT JOIN ros_common.observer_identification oi ON ((gvt.observer_identification_id = oi.id)))
     LEFT JOIN refs_admin.countries n ON ((oi.nationality_code = n.code)))
     LEFT JOIN ros_common.observer_trip_details otd ON ((gvt.observer_trip_detail_id = otd.id)))
     LEFT JOIN ros_common.vessel_identification vi ON ((gvt.vessel_identification_id = vi.id)))
     LEFT JOIN ros_common.vessel_trip_details vtd ON ((gvt.vessel_trip_details_id = vtd.id)))
     LEFT JOIN refs_fishery_config.gears g ON (((vi.main_fishing_gear_code)::text = (g.code)::text)))
     LEFT JOIN refs_admin.countries f ON ((vi.flag_code = f.code)))
     LEFT JOIN refs_admin.countries r ON ((ll_o_d.reporting_country_code = r.code)))
     LEFT JOIN refs_admin.ports pd ON (((vtd.departure_port_code)::text = (pd.code)::text)))
     LEFT JOIN refs_admin.countries cd ON (((pd.country_code)::bpchar = cd.code)))
     LEFT JOIN refs_admin.ports pr ON (((vtd.return_port_code)::text = (pr.code)::text)))
     LEFT JOIN refs_admin.countries cr ON (((pr.country_code)::bpchar = cr.code)));


ALTER VIEW ros_meta.v_ll_trips OWNER TO "ros-admin";

--
-- Name: pl_observer_data; Type: TABLE; Schema: ros_pl; Owner: ros-admin
--

CREATE TABLE ros_pl.pl_observer_data (
    id integer NOT NULL,
    complete smallint DEFAULT 0 NOT NULL,
    creation_time timestamp(6) without time zone NOT NULL,
    finalization_time timestamp(6) without time zone,
    originator character varying(255) NOT NULL,
    originator_version character varying(255) NOT NULL,
    ros_codelists_version character varying(255) NOT NULL,
    ros_model_version character varying(255) NOT NULL,
    source character varying(255) NOT NULL,
    status character varying(255) NOT NULL,
    submission_time timestamp(6) without time zone,
    uid character varying(255) NOT NULL,
    creator_id integer NOT NULL,
    submitter_id integer,
    pl_gear_specifications_id integer,
    vessel_and_trip_information_id integer,
    reporting_country_code character(3) NOT NULL
);


ALTER TABLE ros_pl.pl_observer_data OWNER TO "ros-admin";

--
-- Name: v_pl_trips; Type: VIEW; Schema: ros_meta; Owner: ros-admin
--

CREATE VIEW ros_meta.v_pl_trips AS
 SELECT pl_o_d.source,
    pl_o_d.id AS trip_id,
    pl_o_d.uid AS trip_uid,
    gvt.trip_number,
    pl_o_d.creation_time AS creation_date,
    pl_o_d.finalization_time AS finalization_date,
    pl_o_d.submission_time AS submission_date,
        CASE
            WHEN (otd.id IS NULL) THEN 0
            ELSE 1
        END AS has_observer_trip_info,
    'PL'::text AS fishing_operation_type,
    oi.iotc_number AS observer_iotc_number,
    n.code AS observer_nationality,
    otd.date_time_embarkation AS observer_imbarcation_date,
    otd.date_time_disembarkation AS observer_disembarcation_date,
    vi.id AS vessel_info_id,
    vi.iotc_number AS vessel_iotc_number,
    g.code AS main_gear,
    r.code AS reporting_flag,
    f.code AS vessel_flag,
    vtd.date_time_vessel_sailed AS vessel_departure_date,
    pd.name_en AS vessel_departure_port,
    cd.code AS vessel_departure_country,
    vtd.date_time_vessel_returned_to_port AS vessel_return_date,
    pr.name_en AS vessel_return_port,
    cr.code AS vessel_return_country
   FROM (((((((((((((ros_pl.pl_observer_data pl_o_d
     JOIN ros_common.general_vessel_and_trip_information gvt ON ((pl_o_d.vessel_and_trip_information_id = gvt.id)))
     LEFT JOIN ros_common.observer_identification oi ON ((gvt.observer_identification_id = oi.id)))
     LEFT JOIN refs_admin.countries n ON ((oi.nationality_code = n.code)))
     LEFT JOIN ros_common.observer_trip_details otd ON ((gvt.observer_trip_detail_id = otd.id)))
     LEFT JOIN ros_common.vessel_identification vi ON ((gvt.vessel_identification_id = vi.id)))
     LEFT JOIN ros_common.vessel_trip_details vtd ON ((gvt.vessel_trip_details_id = vtd.id)))
     LEFT JOIN refs_fishery_config.gears g ON (((vi.main_fishing_gear_code)::text = (g.code)::text)))
     LEFT JOIN refs_admin.countries f ON ((vi.flag_code = f.code)))
     LEFT JOIN refs_admin.countries r ON ((pl_o_d.reporting_country_code = r.code)))
     LEFT JOIN refs_admin.ports pd ON (((vtd.departure_port_code)::text = (pd.code)::text)))
     LEFT JOIN refs_admin.countries cd ON (((pd.country_code)::bpchar = cd.code)))
     LEFT JOIN refs_admin.ports pr ON (((vtd.return_port_code)::text = (pr.code)::text)))
     LEFT JOIN refs_admin.countries cr ON (((pr.country_code)::bpchar = cr.code)));


ALTER VIEW ros_meta.v_pl_trips OWNER TO "ros-admin";

--
-- Name: v_ps_sets; Type: VIEW; Schema: ros_meta; Owner: ros-admin
--

CREATE VIEW ros_meta.v_ps_sets AS
 SELECT o.id AS trip_id,
    o.uid AS trip_uid,
    so.id AS set_id,
    'PS'::text AS fishing_operation_type,
    COALESCE(so.start_setting_date_and_time, so.time_start_brailing) AS start_time,
    COALESCE(so.time_start_brailing, so.time_net_pursed) AS end_time,
    ros_meta.to_grid_1(so.start_setting_latitude, so.start_setting_longitude) AS grid_1,
    ros_meta.to_grid_5(so.start_setting_latitude, so.start_setting_longitude) AS grid_5,
    1 AS effort,
    1 AS total_effort,
    'SETS'::text AS effort_unit
   FROM (((ros_ps.ps_observer_data o
     JOIN ros_common.general_vessel_and_trip_information gvt ON ((o.vessel_and_trip_information_id = gvt.id)))
     JOIN ros_ps.ps_fishing_events fed ON ((fed.ps_observer_data_id = o.id)))
     LEFT JOIN ros_ps.ps_setting_operations so ON ((fed.ps_setting_operation_id = so.id)));


ALTER VIEW ros_meta.v_ps_sets OWNER TO "ros-admin";

--
-- Name: v_ps_trips; Type: VIEW; Schema: ros_meta; Owner: ros-admin
--

CREATE VIEW ros_meta.v_ps_trips AS
 SELECT ps_o_d.source,
    ps_o_d.id AS trip_id,
    ps_o_d.uid AS trip_uid,
    gvt.trip_number,
    ps_o_d.creation_time AS creation_date,
    ps_o_d.finalization_time AS finalization_date,
    ps_o_d.submission_time AS submission_date,
        CASE
            WHEN (otd.id IS NULL) THEN 0
            ELSE 1
        END AS has_observer_trip_info,
    'PS'::text AS fishing_operation_type,
    oi.iotc_number AS observer_iotc_number,
    n.code AS observer_nationality,
    otd.date_time_embarkation AS observer_imbarcation_date,
    otd.date_time_disembarkation AS observer_disembarcation_date,
    vi.id AS vessel_info_id,
    vi.iotc_number AS vessel_iotc_number,
    g.code AS main_gear,
    r.code AS reporting_flag,
    f.code AS vessel_flag,
    vtd.date_time_vessel_sailed AS vessel_departure_date,
    pd.name_en AS vessel_departure_port,
    cd.code AS vessel_departure_country,
    vtd.date_time_vessel_returned_to_port AS vessel_return_date,
    pr.name_en AS vessel_return_port,
    cr.code AS vessel_return_country
   FROM (((((((((((((ros_ps.ps_observer_data ps_o_d
     JOIN ros_common.general_vessel_and_trip_information gvt ON ((ps_o_d.vessel_and_trip_information_id = gvt.id)))
     LEFT JOIN ros_common.observer_identification oi ON ((gvt.observer_identification_id = oi.id)))
     LEFT JOIN refs_admin.countries n ON ((oi.nationality_code = n.code)))
     LEFT JOIN ros_common.observer_trip_details otd ON ((gvt.observer_trip_detail_id = otd.id)))
     LEFT JOIN ros_common.vessel_identification vi ON ((gvt.vessel_identification_id = vi.id)))
     LEFT JOIN ros_common.vessel_trip_details vtd ON ((gvt.vessel_trip_details_id = vtd.id)))
     LEFT JOIN refs_fishery_config.gears g ON (((vi.main_fishing_gear_code)::text = (g.code)::text)))
     LEFT JOIN refs_admin.countries f ON ((vi.flag_code = f.code)))
     LEFT JOIN refs_admin.countries r ON ((ps_o_d.reporting_country_code = r.code)))
     LEFT JOIN refs_admin.ports pd ON (((vtd.departure_port_code)::text = (pd.code)::text)))
     LEFT JOIN refs_admin.countries cd ON (((pd.country_code)::bpchar = cd.code)))
     LEFT JOIN refs_admin.ports pr ON (((vtd.return_port_code)::text = (pr.code)::text)))
     LEFT JOIN refs_admin.countries cr ON (((pr.country_code)::bpchar = cr.code)));


ALTER VIEW ros_meta.v_ps_trips OWNER TO "ros-admin";

--
-- Name: v_sets; Type: VIEW; Schema: ros_meta; Owner: ros-admin
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


ALTER VIEW ros_meta.v_sets OWNER TO "ros-admin";

--
-- Name: v_trips; Type: VIEW; Schema: ros_meta; Owner: ros-admin
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


ALTER VIEW ros_meta.v_trips OWNER TO "ros-admin";

--
-- Name: v_sets_by_year_flag_and_gear; Type: VIEW; Schema: ros_meta; Owner: ros-admin
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


ALTER VIEW ros_meta.v_sets_by_year_flag_and_gear OWNER TO "ros-admin";

--
-- Name: v_sets_by_year_flag_and_gear; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
--

CREATE VIEW ros_analysis.v_sets_by_year_flag_and_gear AS
 SELECT year,
    flag,
    gear,
    num_sets
   FROM ros_meta.v_sets_by_year_flag_and_gear;


ALTER VIEW ros_analysis.v_sets_by_year_flag_and_gear OWNER TO "ros-admin";

--
-- Name: v_sets_raw; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
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


ALTER VIEW ros_analysis.v_sets_raw OWNER TO "ros-admin";

--
-- Name: v_sf_l; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
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
    v_ps_sf_l."?column?",
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
    v_ll_sf_l."?column?",
    v_ll_sf_l.fate,
    v_ll_sf_l.sex,
    v_ll_sf_l.length_code,
    v_ll_sf_l.length_unit,
    v_ll_sf_l.size_bin,
    v_ll_sf_l.num_fish
   FROM ros_analysis.v_ll_sf_l
  WHERE (v_ll_sf_l.year IS NOT NULL);


ALTER VIEW ros_analysis.v_sf_l OWNER TO "ros-admin";

--
-- Name: v_sf_w; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
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
    v_ps_sf_w."?column?",
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
    v_ll_sf_w."?column?",
    v_ll_sf_w.fate,
    v_ll_sf_w.sex,
    v_ll_sf_w.weight_code,
    v_ll_sf_w.weight_unit AS length_unit,
    v_ll_sf_w.size_bin,
    v_ll_sf_w.num_fish
   FROM ros_analysis.v_ll_sf_w
  WHERE (v_ll_sf_w.year IS NOT NULL);


ALTER VIEW ros_analysis.v_sf_w OWNER TO "ros-admin";

--
-- Name: v_sf; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
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
    v_sf_l."?column?",
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
    v_sf_w."?column?",
    v_sf_w.fate,
    v_sf_w.sex,
    v_sf_w.weight_code AS length_code,
    v_sf_w.length_unit,
    v_sf_w.size_bin,
    v_sf_w.num_fish
   FROM ros_analysis.v_sf_w;


ALTER VIEW ros_analysis.v_sf OWNER TO "ros-admin";

--
-- Name: v_trips_by_year_flag_and_gear; Type: VIEW; Schema: ros_meta; Owner: ros-admin
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


ALTER VIEW ros_meta.v_trips_by_year_flag_and_gear OWNER TO "ros-admin";

--
-- Name: v_trips_by_year_flag_and_gear; Type: VIEW; Schema: ros_analysis; Owner: ros-admin
--

CREATE VIEW ros_analysis.v_trips_by_year_flag_and_gear AS
 SELECT year,
    flag,
    gear,
    sum(num_trips) AS num_trips
   FROM ros_meta.v_trips_by_year_flag_and_gear
  GROUP BY year, flag, gear;


ALTER VIEW ros_analysis.v_trips_by_year_flag_and_gear OWNER TO "ros-admin";

--
-- Name: activity_details; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.activity_details (
    id integer NOT NULL,
    comments text,
    time_of_day timestamp(3) without time zone,
    latitude double precision,
    longitude double precision,
    daily_activity_id integer,
    activity_code character(2)
);


ALTER TABLE ros_common.activity_details OWNER TO "ros-admin";

--
-- Name: activity_details_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.activity_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.activity_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: additional_details_on_non_target_species_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
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
-- Name: biometric_information_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
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
-- Name: capacities; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.capacities (
    id integer NOT NULL,
    unit character varying(3),
    value double precision
);


ALTER TABLE ros_common.capacities OWNER TO "ros-admin";

--
-- Name: capacities_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.capacities ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.capacities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: carrier_vessel_identification; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.carrier_vessel_identification (
    id integer NOT NULL,
    vessel_ircs character varying(255),
    vessel_registration_number character varying(255),
    vessel_name character varying(255),
    vessel_flag_code character(3),
    vessel_registration_port_code character varying(16)
);


ALTER TABLE ros_common.carrier_vessel_identification OWNER TO "ros-admin";

--
-- Name: carrier_vessel_identification_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.carrier_vessel_identification ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.carrier_vessel_identification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: daily_activities; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.daily_activities (
    id integer NOT NULL,
    date timestamp(3) without time zone
);


ALTER TABLE ros_common.daily_activities OWNER TO "ros-admin";

--
-- Name: daily_activities_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.daily_activities ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.daily_activities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: depredation_details; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.depredation_details (
    id integer NOT NULL,
    depredation_source_code character varying(3),
    predator_observed_code character varying(16)
);


ALTER TABLE ros_common.depredation_details OWNER TO "ros-admin";

--
-- Name: depredation_details_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
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
-- Name: depths; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.depths (
    id integer NOT NULL,
    unit character varying(3),
    value double precision
);


ALTER TABLE ros_common.depths OWNER TO "ros-admin";

--
-- Name: depths_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.depths ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.depths_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: diameters; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.diameters (
    id integer NOT NULL,
    unit character varying(3),
    value double precision
);


ALTER TABLE ros_common.diameters OWNER TO "ros-admin";

--
-- Name: diameters_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.diameters ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.diameters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: distances; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.distances (
    id integer NOT NULL,
    unit character varying(3),
    value double precision
);


ALTER TABLE ros_common.distances OWNER TO "ros-admin";

--
-- Name: distances_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.distances ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.distances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: engines; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.engines (
    id integer NOT NULL,
    make character varying(255),
    unit character varying(3),
    value double precision
);


ALTER TABLE ros_common.engines OWNER TO "ros-admin";

--
-- Name: engines_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.engines ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.engines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: estimated_weights_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.estimated_weights ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.estimated_weights_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: general_vessel_and_trip_information_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.general_vessel_and_trip_information ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.general_vessel_and_trip_information_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: gn_observer_data_properties; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.gn_observer_data_properties (
    observer_data_id integer NOT NULL,
    property_id integer NOT NULL
);


ALTER TABLE ros_common.gn_observer_data_properties OWNER TO "ros-admin";

--
-- Name: gn_observer_data_transhipment_details; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.gn_observer_data_transhipment_details (
    observer_data_id integer NOT NULL,
    transhipment_detail_id integer NOT NULL
);


ALTER TABLE ros_common.gn_observer_data_transhipment_details OWNER TO "ros-admin";

--
-- Name: heights; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.heights (
    id integer NOT NULL,
    unit character varying(3),
    value double precision
);


ALTER TABLE ros_common.heights OWNER TO "ros-admin";

--
-- Name: heights_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.heights ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.heights_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: iotc_person_contact_details; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.iotc_person_contact_details (
    id integer NOT NULL,
    contact_details character varying(255),
    email character varying(255),
    fax character varying(255),
    full_name character varying(255),
    iotc_number character varying(255),
    phone character varying(255),
    role character varying(255),
    uid character varying(32) NOT NULL,
    nationality_code character(3)
);


ALTER TABLE ros_common.iotc_person_contact_details OWNER TO "ros-admin";

--
-- Name: iotc_person_contact_details_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.iotc_person_contact_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.iotc_person_contact_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: iotc_person_details; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.iotc_person_details (
    id integer NOT NULL,
    full_name character varying(255),
    iotc_number character varying(255),
    role character varying(255),
    uid character varying(32) NOT NULL,
    nationality_code character(3)
);


ALTER TABLE ros_common.iotc_person_details OWNER TO "ros-admin";

--
-- Name: iotc_person_details_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.iotc_person_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.iotc_person_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: lengths; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.lengths (
    id integer NOT NULL,
    unit character varying(3),
    value double precision
);


ALTER TABLE ros_common.lengths OWNER TO "ros-admin";

--
-- Name: lengths_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.lengths ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.lengths_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ll_observer_data_properties; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.ll_observer_data_properties (
    observer_data_id integer NOT NULL,
    property_id integer NOT NULL
);


ALTER TABLE ros_common.ll_observer_data_properties OWNER TO "ros-admin";

--
-- Name: ll_observer_data_transhipment_details; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.ll_observer_data_transhipment_details (
    observer_data_id integer NOT NULL,
    transhipment_detail_id integer NOT NULL
);


ALTER TABLE ros_common.ll_observer_data_transhipment_details OWNER TO "ros-admin";

--
-- Name: locations; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.locations (
    id integer NOT NULL,
    "NAME" character varying(255),
    latitude double precision,
    longitude double precision,
    country_code character(3)
);


ALTER TABLE ros_common.locations OWNER TO "ros-admin";

--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.locations ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: maturity_stages; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.maturity_stages (
    id integer NOT NULL,
    maturity_level integer,
    scale character varying(255)
);


ALTER TABLE ros_common.maturity_stages OWNER TO "ros-admin";

--
-- Name: maturity_stages_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.maturity_stages ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.maturity_stages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: measured_lengths_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.measured_lengths ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.measured_lengths_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: measured_weights; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.measured_weights (
    id integer NOT NULL,
    unit character varying(3),
    value double precision,
    processing_type_code character(2)
);


ALTER TABLE ros_common.measured_weights OWNER TO "ros-admin";

--
-- Name: measured_weights_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.measured_weights ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.measured_weights_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: observed_trip_summary; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.observed_trip_summary (
    id integer NOT NULL,
    number_of_active_fishing_days integer,
    number_of_conducted_fishing_events_with_observer_onboard integer,
    number_of_days_in_fishing_area integer,
    number_of_days_lost integer,
    number_of_days_searching integer,
    number_of_days_transiting integer,
    number_of_observed_fishing_events integer
);


ALTER TABLE ros_common.observed_trip_summary OWNER TO "ros-admin";

--
-- Name: observed_trip_summary_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.observed_trip_summary ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.observed_trip_summary_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: observer_identification_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.observer_identification ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.observer_identification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: observer_trip_details_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.observer_trip_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.observer_trip_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: person_contact_details; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.person_contact_details (
    id integer NOT NULL,
    contact_details character varying(255),
    email character varying(255),
    fax character varying(255),
    full_name character varying(255),
    phone character varying(255),
    nationality_code character(3)
);


ALTER TABLE ros_common.person_contact_details OWNER TO "ros-admin";

--
-- Name: person_contact_details_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.person_contact_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.person_contact_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: person_details; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.person_details (
    id integer NOT NULL,
    full_name character varying(255),
    nationality_code character(3)
);


ALTER TABLE ros_common.person_details OWNER TO "ros-admin";

--
-- Name: person_details_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.person_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.person_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: pl_observer_data_daily_activities; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.pl_observer_data_daily_activities (
    observer_data_id integer NOT NULL,
    daily_activity_id integer NOT NULL
);


ALTER TABLE ros_common.pl_observer_data_daily_activities OWNER TO "ros-admin";

--
-- Name: pl_observer_data_properties; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.pl_observer_data_properties (
    observer_data_id integer NOT NULL,
    property_id integer NOT NULL
);


ALTER TABLE ros_common.pl_observer_data_properties OWNER TO "ros-admin";

--
-- Name: pl_observer_data_transhipment_details; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.pl_observer_data_transhipment_details (
    observer_data_id integer NOT NULL,
    transhipment_detail_id integer NOT NULL
);


ALTER TABLE ros_common.pl_observer_data_transhipment_details OWNER TO "ros-admin";

--
-- Name: powers; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.powers (
    id integer NOT NULL,
    unit character varying(3),
    value double precision
);


ALTER TABLE ros_common.powers OWNER TO "ros-admin";

--
-- Name: powers_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.powers ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.powers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: properties; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.properties (
    id integer NOT NULL,
    "NAME" character varying(255),
    value text
);


ALTER TABLE ros_common.properties OWNER TO "ros-admin";

--
-- Name: properties_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.properties ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.properties_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ps_observer_data_daily_activities; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.ps_observer_data_daily_activities (
    observer_data_id integer NOT NULL,
    daily_activity_id integer NOT NULL
);


ALTER TABLE ros_common.ps_observer_data_daily_activities OWNER TO "ros-admin";

--
-- Name: ps_observer_data_properties; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.ps_observer_data_properties (
    observer_data_id integer NOT NULL,
    property_id integer NOT NULL
);


ALTER TABLE ros_common.ps_observer_data_properties OWNER TO "ros-admin";

--
-- Name: ps_observer_data_transhipment_details; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.ps_observer_data_transhipment_details (
    observer_data_id integer NOT NULL,
    transhipment_detail_id integer NOT NULL
);


ALTER TABLE ros_common.ps_observer_data_transhipment_details OWNER TO "ros-admin";

--
-- Name: ranges; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.ranges (
    id integer NOT NULL,
    unit character varying(3),
    value double precision
);


ALTER TABLE ros_common.ranges OWNER TO "ros-admin";

--
-- Name: ranges_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.ranges ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.ranges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: reasons_for_days_lost; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.reasons_for_days_lost (
    id integer NOT NULL,
    reason text,
    inoperativity_reason character varying(255),
    observed_trip_summary_id integer
);


ALTER TABLE ros_common.reasons_for_days_lost OWNER TO "ros-admin";

--
-- Name: reasons_for_days_lost_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.reasons_for_days_lost ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.reasons_for_days_lost_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: sample_collection_details; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.sample_collection_details (
    id integer NOT NULL,
    destination character varying(255),
    preservation_method text,
    sample_type character varying(255)
);


ALTER TABLE ros_common.sample_collection_details OWNER TO "ros-admin";

--
-- Name: sample_collection_details_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.sample_collection_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.sample_collection_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: sampling_details; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.sampling_details (
    id integer NOT NULL
);


ALTER TABLE ros_common.sampling_details OWNER TO "ros-admin";

--
-- Name: sampling_details_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.sampling_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.sampling_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: sizes; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.sizes (
    id integer NOT NULL,
    unit character varying(3),
    value double precision
);


ALTER TABLE ros_common.sizes OWNER TO "ros-admin";

--
-- Name: sizes_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.sizes ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.sizes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: species_by_product_type; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.species_by_product_type (
    id integer NOT NULL,
    comments text,
    unit character varying(3),
    value double precision,
    processing_type_code character(2),
    species_code character varying(16)
);


ALTER TABLE ros_common.species_by_product_type OWNER TO "ros-admin";

--
-- Name: species_by_product_type_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.species_by_product_type ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.species_by_product_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: texts; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.texts (
    id integer NOT NULL,
    value text
);


ALTER TABLE ros_common.texts OWNER TO "ros-admin";

--
-- Name: texts_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.texts ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.texts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: thicknesses; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.thicknesses (
    id integer NOT NULL,
    unit character varying(3),
    value double precision
);


ALTER TABLE ros_common.thicknesses OWNER TO "ros-admin";

--
-- Name: thicknesses_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.thicknesses ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.thicknesses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: tonnages; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.tonnages (
    id integer NOT NULL,
    unit character varying(3),
    value double precision
);


ALTER TABLE ros_common.tonnages OWNER TO "ros-admin";

--
-- Name: tonnages_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.tonnages ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.tonnages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: transhipment_details; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.transhipment_details (
    id integer NOT NULL,
    category character varying(255),
    transhipment_end_date_time timestamp(3) without time zone,
    transhipment_start_date_time timestamp(3) without time zone,
    latitude double precision,
    longitude double precision,
    carrier_vessel_identification_id integer
);


ALTER TABLE ros_common.transhipment_details OWNER TO "ros-admin";

--
-- Name: transhipment_details_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.transhipment_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.transhipment_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: transhipment_details_product_transhipped; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.transhipment_details_product_transhipped (
    transhipment_detail_id integer NOT NULL,
    species_by_product_id integer NOT NULL
);


ALTER TABLE ros_common.transhipment_details_product_transhipped OWNER TO "ros-admin";

--
-- Name: vessel_attributes; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.vessel_attributes (
    id integer NOT NULL,
    loa_id integer,
    autonomy_range_id integer,
    fish_storage_capacity_id integer,
    tonnage_id integer,
    hull_material_code character(2)
);


ALTER TABLE ros_common.vessel_attributes OWNER TO "ros-admin";

--
-- Name: vessel_attributes_fish_preservation_method; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.vessel_attributes_fish_preservation_method (
    vessel_attributes_id_fpm integer NOT NULL,
    fish_preservation_method_code character(2) NOT NULL
);


ALTER TABLE ros_common.vessel_attributes_fish_preservation_method OWNER TO "ros-admin";

--
-- Name: vessel_attributes_fish_storage_type; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.vessel_attributes_fish_storage_type (
    vessel_attributes_id_fst integer NOT NULL,
    fish_storage_type_code character(2) NOT NULL
);


ALTER TABLE ros_common.vessel_attributes_fish_storage_type OWNER TO "ros-admin";

--
-- Name: vessel_attributes_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.vessel_attributes ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.vessel_attributes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: vessel_attributes_main_engines; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.vessel_attributes_main_engines (
    vessel_attributes_id_me integer NOT NULL,
    main_engine_id integer NOT NULL
);


ALTER TABLE ros_common.vessel_attributes_main_engines OWNER TO "ros-admin";

--
-- Name: vessel_electronics; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.vessel_electronics (
    id integer NOT NULL,
    ais smallint DEFAULT 0,
    gps smallint DEFAULT 0,
    vms smallint DEFAULT 0,
    depth_sounder smallint DEFAULT 0,
    doppler_current_meter smallint DEFAULT 0,
    expendable_bathythermographs smallint DEFAULT 0,
    fisheries_information_services smallint DEFAULT 0,
    hf_radios smallint DEFAULT 0,
    radars smallint DEFAULT 0,
    satellite_communication_systems smallint DEFAULT 0,
    sea_surface_temperature_gauge smallint DEFAULT 0,
    sonar smallint DEFAULT 0,
    track_plotter smallint DEFAULT 0,
    vhf_radios smallint DEFAULT 0,
    weather_facsimile smallint DEFAULT 0
);


ALTER TABLE ros_common.vessel_electronics OWNER TO "ros-admin";

--
-- Name: vessel_electronics_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.vessel_electronics ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.vessel_electronics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: vessel_identification_email; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.vessel_identification_email (
    vessel_identification_id_em integer NOT NULL,
    email_id integer NOT NULL
);


ALTER TABLE ros_common.vessel_identification_email OWNER TO "ros-admin";

--
-- Name: vessel_identification_fax; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.vessel_identification_fax (
    vessel_identification_id_fa integer NOT NULL,
    fax_id integer NOT NULL
);


ALTER TABLE ros_common.vessel_identification_fax OWNER TO "ros-admin";

--
-- Name: vessel_identification_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.vessel_identification ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.vessel_identification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: vessel_identification_licensed_target_species; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.vessel_identification_licensed_target_species (
    vessel_identification_id integer NOT NULL,
    licensed_target_species_code character varying(16)
);


ALTER TABLE ros_common.vessel_identification_licensed_target_species OWNER TO "ros-admin";

--
-- Name: vessel_identification_phone; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.vessel_identification_phone (
    vessel_identification_id_ph integer NOT NULL,
    phone_id integer NOT NULL
);


ALTER TABLE ros_common.vessel_identification_phone OWNER TO "ros-admin";

--
-- Name: vessel_owner_and_personnel; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.vessel_owner_and_personnel (
    id integer NOT NULL,
    number_of_crew integer,
    charter_or_operator_id integer,
    fishing_master_id integer,
    registered_vessel_owner_id integer,
    skipper_id integer
);


ALTER TABLE ros_common.vessel_owner_and_personnel OWNER TO "ros-admin";

--
-- Name: vessel_owner_and_personnel_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.vessel_owner_and_personnel ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.vessel_owner_and_personnel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: vessel_trip_details_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.vessel_trip_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.vessel_trip_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: waste_managements; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.waste_managements (
    id integer NOT NULL,
    general_vessel_and_trip_information_id integer,
    waste_storage_or_disposal_method_code character(2),
    waste_category_code character(2)
);


ALTER TABLE ros_common.waste_managements OWNER TO "ros-admin";

--
-- Name: waste_managements_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.waste_managements ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.waste_managements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: weights; Type: TABLE; Schema: ros_common; Owner: ros-admin
--

CREATE TABLE ros_common.weights (
    id integer NOT NULL,
    unit character varying(3),
    value double precision
);


ALTER TABLE ros_common.weights OWNER TO "ros-admin";

--
-- Name: weights_id_seq; Type: SEQUENCE; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ros_common.weights ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_common.weights_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: gillnet_configuration; Type: TABLE; Schema: ros_gn; Owner: ros-admin
--

CREATE TABLE ros_gn.gillnet_configuration (
    id integer NOT NULL,
    droplines_used smallint DEFAULT 0,
    gillnet_sequential_number character varying(255),
    hanging_ratio double precision,
    number_of_floats integer,
    panels_stacked smallint DEFAULT 0,
    total_number_of_panels integer,
    vertical_mesh_count integer,
    distance_between_floats_id integer,
    droplines_length_id integer,
    net_depth_id integer,
    net_length_id integer,
    gillnet_configuration_id integer,
    float_type_code character(2),
    gillnet_material_type_code character(2)
);


ALTER TABLE ros_gn.gillnet_configuration OWNER TO "ros-admin";

--
-- Name: gillnet_configuration_id_seq; Type: SEQUENCE; Schema: ros_gn; Owner: ros-admin
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
-- Name: gn_additional_catch_details_on_ssi; Type: TABLE; Schema: ros_gn; Owner: ros-admin
--

CREATE TABLE ros_gn.gn_additional_catch_details_on_ssi (
    id integer NOT NULL,
    brought_on_board smallint DEFAULT 0,
    photo_id character varying(255),
    revival smallint DEFAULT 0,
    gear_interaction_code character(2),
    handling_method_code character(2)
);


ALTER TABLE ros_gn.gn_additional_catch_details_on_ssi OWNER TO "ros-admin";

--
-- Name: gn_additional_catch_details_on_ssi_id_seq; Type: SEQUENCE; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ros_gn.gn_additional_catch_details_on_ssi ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_gn.gn_additional_catch_details_on_ssi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: gn_catch_details; Type: TABLE; Schema: ros_gn; Owner: ros-admin
--

CREATE TABLE ros_gn.gn_catch_details (
    id integer NOT NULL,
    catch_detail_number character varying(255) NOT NULL,
    comments text,
    estimated_catch_in_numbers integer,
    estimated_weight_id integer,
    gn_fishing_event_id integer,
    type_of_fate_code character(2) NOT NULL,
    estimated_weight_sampling_method_code character(2),
    fates_code character(2),
    species_code character varying(16)
);


ALTER TABLE ros_gn.gn_catch_details OWNER TO "ros-admin";

--
-- Name: gn_catch_details_id_seq; Type: SEQUENCE; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ros_gn.gn_catch_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_gn.gn_catch_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: gn_fishing_events; Type: TABLE; Schema: ros_gn; Owner: ros-admin
--

CREATE TABLE ros_gn.gn_fishing_events (
    id integer NOT NULL,
    comments text,
    event_number character varying(255),
    gn_hauling_operation_id integer,
    gn_mitigation_measure_id integer,
    gn_setting_operation_id integer,
    gn_observer_data_id integer
);


ALTER TABLE ros_gn.gn_fishing_events OWNER TO "ros-admin";

--
-- Name: gn_fishing_events_id_seq; Type: SEQUENCE; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ros_gn.gn_fishing_events ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_gn.gn_fishing_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: gn_gear_specifications; Type: TABLE; Schema: ros_gn; Owner: ros-admin
--

CREATE TABLE ros_gn.gn_gear_specifications (
    id integer NOT NULL,
    gn_special_equipment_id integer
);


ALTER TABLE ros_gn.gn_gear_specifications OWNER TO "ros-admin";

--
-- Name: gn_gear_specifications_id_seq; Type: SEQUENCE; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ros_gn.gn_gear_specifications ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_gn.gn_gear_specifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: gn_gillnet_configuration_net_web_colours; Type: TABLE; Schema: ros_gn; Owner: ros-admin
--

CREATE TABLE ros_gn.gn_gillnet_configuration_net_web_colours (
    gn_gillnet_configuration_id_nwc integer NOT NULL,
    net_colour_code character(2) NOT NULL
);


ALTER TABLE ros_gn.gn_gillnet_configuration_net_web_colours OWNER TO "ros-admin";

--
-- Name: gn_gillnet_configuration_stretched_mesh_sizes; Type: TABLE; Schema: ros_gn; Owner: ros-admin
--

CREATE TABLE ros_gn.gn_gillnet_configuration_stretched_mesh_sizes (
    gn_gillnet_configuration_id_sms integer NOT NULL,
    stretched_mesh_size_id integer NOT NULL
);


ALTER TABLE ros_gn.gn_gillnet_configuration_stretched_mesh_sizes OWNER TO "ros-admin";

--
-- Name: gn_hauling_operations; Type: TABLE; Schema: ros_gn; Owner: ros-admin
--

CREATE TABLE ros_gn.gn_hauling_operations (
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


ALTER TABLE ros_gn.gn_hauling_operations OWNER TO "ros-admin";

--
-- Name: gn_hauling_operations_id_seq; Type: SEQUENCE; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ros_gn.gn_hauling_operations ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_gn.gn_hauling_operations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: gn_mitigation_measures; Type: TABLE; Schema: ros_gn; Owner: ros-admin
--

CREATE TABLE ros_gn.gn_mitigation_measures (
    id integer NOT NULL,
    mitigation_measures smallint DEFAULT 0
);


ALTER TABLE ros_gn.gn_mitigation_measures OWNER TO "ros-admin";

--
-- Name: gn_mitigation_measures_id_seq; Type: SEQUENCE; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ros_gn.gn_mitigation_measures ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_gn.gn_mitigation_measures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: gn_mitigation_measures_mitigation_devices; Type: TABLE; Schema: ros_gn; Owner: ros-admin
--

CREATE TABLE ros_gn.gn_mitigation_measures_mitigation_devices (
    mitigation_measure_id integer NOT NULL,
    mitigation_device_code character(2) NOT NULL
);


ALTER TABLE ros_gn.gn_mitigation_measures_mitigation_devices OWNER TO "ros-admin";

--
-- Name: gn_observer_data_id_seq; Type: SEQUENCE; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ros_gn.gn_observer_data ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_gn.gn_observer_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: gn_setting_operations; Type: TABLE; Schema: ros_gn; Owner: ros-admin
--

CREATE TABLE ros_gn.gn_setting_operations (
    id integer NOT NULL,
    end_setting_date_and_time timestamp(6) without time zone,
    gillnet_sequential_number integer,
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


ALTER TABLE ros_gn.gn_setting_operations OWNER TO "ros-admin";

--
-- Name: gn_setting_operations_id_seq; Type: SEQUENCE; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ros_gn.gn_setting_operations ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_gn.gn_setting_operations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: gn_special_equipment; Type: TABLE; Schema: ros_gn; Owner: ros-admin
--

CREATE TABLE ros_gn.gn_special_equipment (
    id integer NOT NULL,
    net_drum_hauler smallint DEFAULT 0
);


ALTER TABLE ros_gn.gn_special_equipment OWNER TO "ros-admin";

--
-- Name: gn_special_equipment_id_seq; Type: SEQUENCE; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ros_gn.gn_special_equipment ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_gn.gn_special_equipment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: gn_specimens; Type: TABLE; Schema: ros_gn; Owner: ros-admin
--

CREATE TABLE ros_gn.gn_specimens (
    id integer NOT NULL,
    specimen_number character varying(255) NOT NULL,
    gn_additional_catch_details_on_ssis_id integer,
    additional_specimen_details_non_target_species_id integer,
    biometric_information_id integer,
    gn_depredation_detail_id integer,
    gn_tag_detail_id integer,
    gn_catch_detail_id integer
);


ALTER TABLE ros_gn.gn_specimens OWNER TO "ros-admin";

--
-- Name: gn_specimens_id_seq; Type: SEQUENCE; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ros_gn.gn_specimens ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_gn.gn_specimens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: gn_tag_details; Type: TABLE; Schema: ros_gn; Owner: ros-admin
--

CREATE TABLE ros_gn.gn_tag_details (
    id integer NOT NULL,
    alternate_tag_number character varying(255),
    tag_number character varying(255),
    tag_recovery smallint DEFAULT 0,
    tag_release smallint DEFAULT 0,
    tag_finder_id integer,
    tag_type_code character(2)
);


ALTER TABLE ros_gn.gn_tag_details OWNER TO "ros-admin";

--
-- Name: gn_tag_details_id_seq; Type: SEQUENCE; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ros_gn.gn_tag_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_gn.gn_tag_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: sinkers_by_type; Type: TABLE; Schema: ros_gn; Owner: ros-admin
--

CREATE TABLE ros_gn.sinkers_by_type (
    id integer NOT NULL,
    number integer,
    average_sinker_weight_id integer,
    gn_gillnet_configuration_id integer,
    sinker_material_type_code character(2)
);


ALTER TABLE ros_gn.sinkers_by_type OWNER TO "ros-admin";

--
-- Name: sinkers_by_type_id_seq; Type: SEQUENCE; Schema: ros_gn; Owner: ros-admin
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
-- Name: baits_by_conditions; Type: TABLE; Schema: ros_ll; Owner: ros-admin
--

CREATE TABLE ros_ll.baits_by_conditions (
    id integer NOT NULL,
    dye_colour character varying(255),
    ratio double precision,
    ll_setting_operations_id integer,
    bait_condition_code character(2),
    species_code character varying(16)
);


ALTER TABLE ros_ll.baits_by_conditions OWNER TO "ros-admin";

--
-- Name: baits_by_conditions_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: ros-admin
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
-- Name: biteoffs_by_branchlines_set; Type: TABLE; Schema: ros_ll; Owner: ros-admin
--

CREATE TABLE ros_ll.biteoffs_by_branchlines_set (
    id integer NOT NULL,
    branchline_configuration_number integer,
    number_of_biteoffs integer,
    ll_hauling_operation_id integer
);


ALTER TABLE ros_ll.biteoffs_by_branchlines_set OWNER TO "ros-admin";

--
-- Name: biteoffs_by_branchlines_set_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: ros-admin
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
-- Name: branchline_configurations; Type: TABLE; Schema: ros_ll; Owner: ros-admin
--

CREATE TABLE ros_ll.branchline_configurations (
    id integer NOT NULL,
    configuration_number integer,
    ll_gear_specifications_id integer
);


ALTER TABLE ros_ll.branchline_configurations OWNER TO "ros-admin";

--
-- Name: branchline_configurations_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: ros-admin
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
-- Name: branchline_sections; Type: TABLE; Schema: ros_ll; Owner: ros-admin
--

CREATE TABLE ros_ll.branchline_sections (
    id integer NOT NULL,
    section_number integer,
    diameter_id integer,
    length_id integer,
    branchline_configuration_id integer,
    branchline_material_type_code character(2)
);


ALTER TABLE ros_ll.branchline_sections OWNER TO "ros-admin";

--
-- Name: branchline_sections_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: ros-admin
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
-- Name: branchlines_set; Type: TABLE; Schema: ros_ll; Owner: ros-admin
--

CREATE TABLE ros_ll.branchlines_set (
    id integer NOT NULL,
    branchline_configuration_number integer,
    number_of_branchlines integer,
    ll_setting_operations_id integer
);


ALTER TABLE ros_ll.branchlines_set OWNER TO "ros-admin";

--
-- Name: branchlines_set_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: ros-admin
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
-- Name: floatlines; Type: TABLE; Schema: ros_ll; Owner: ros-admin
--

CREATE TABLE ros_ll.floatlines (
    id integer NOT NULL,
    floatline_number integer,
    floatline_length_id integer,
    ll_setting_operation_id integer
);


ALTER TABLE ros_ll.floatlines OWNER TO "ros-admin";

--
-- Name: floatlines_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: ros-admin
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
-- Name: hooks_by_type; Type: TABLE; Schema: ros_ll; Owner: ros-admin
--

CREATE TABLE ros_ll.hooks_by_type (
    id integer NOT NULL,
    percentage_of_set double precision,
    variations character varying(255),
    ll_setting_operations_id integer,
    hook_type_code character(3)
);


ALTER TABLE ros_ll.hooks_by_type OWNER TO "ros-admin";

--
-- Name: hooks_by_type_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: ros-admin
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
-- Name: lights_by_type_and_colour; Type: TABLE; Schema: ros_ll; Owner: ros-admin
--

CREATE TABLE ros_ll.lights_by_type_and_colour (
    id integer NOT NULL,
    number_of_lights_by_type_and_colour integer,
    ll_setting_operation_id integer,
    light_colour_code character(2),
    light_type_code character(2)
);


ALTER TABLE ros_ll.lights_by_type_and_colour OWNER TO "ros-admin";

--
-- Name: lights_by_type_and_colour_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: ros-admin
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
-- Name: ll_additional_catch_details_on_ssi; Type: TABLE; Schema: ros_ll; Owner: ros-admin
--

CREATE TABLE ros_ll.ll_additional_catch_details_on_ssi (
    id integer NOT NULL,
    bait_type character varying(255),
    brought_on_board smallint DEFAULT 0,
    light_attached_to_branchline smallint DEFAULT 0,
    photo_id character varying(255),
    revival smallint DEFAULT 0,
    leader_thickness_id integer,
    bait_condition_code character(2),
    dehooker_device_code character(2),
    gear_interaction_code character(2),
    handling_method_code character(2),
    leader_material_type_code character(2)
);


ALTER TABLE ros_ll.ll_additional_catch_details_on_ssi OWNER TO "ros-admin";

--
-- Name: ll_additional_catch_details_on_ssi_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ros_ll.ll_additional_catch_details_on_ssi ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ll.ll_additional_catch_details_on_ssi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ll_catch_details_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ros_ll.ll_catch_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ll.ll_catch_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ll_fishing_events_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ros_ll.ll_fishing_events ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ll.ll_fishing_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ll_gear_specifications; Type: TABLE; Schema: ros_ll; Owner: ros-admin
--

CREATE TABLE ros_ll.ll_gear_specifications (
    id integer NOT NULL,
    storage character varying(255),
    ll_general_gear_attributes_id integer,
    ll_special_equipment_id integer,
    tori_line_detail_id integer
);


ALTER TABLE ros_ll.ll_gear_specifications OWNER TO "ros-admin";

--
-- Name: ll_gear_specifications_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ros_ll.ll_gear_specifications ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ll.ll_gear_specifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ll_gear_specifications_mitigation_device; Type: TABLE; Schema: ros_ll; Owner: ros-admin
--

CREATE TABLE ros_ll.ll_gear_specifications_mitigation_device (
    ll_gear_specification_id integer NOT NULL,
    mitigation_device_code character(2) NOT NULL
);


ALTER TABLE ros_ll.ll_gear_specifications_mitigation_device OWNER TO "ros-admin";

--
-- Name: ll_general_gear_attributes; Type: TABLE; Schema: ros_ll; Owner: ros-admin
--

CREATE TABLE ros_ll.ll_general_gear_attributes (
    id integer NOT NULL,
    mainline_diameter_id integer,
    mainline_length_id integer,
    line_material_type_code character(2)
);


ALTER TABLE ros_ll.ll_general_gear_attributes OWNER TO "ros-admin";

--
-- Name: ll_general_gear_attributes_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ros_ll.ll_general_gear_attributes ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ll.ll_general_gear_attributes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ll_hauling_offal_disposal_positions; Type: TABLE; Schema: ros_ll; Owner: ros-admin
--

CREATE TABLE ros_ll.ll_hauling_offal_disposal_positions (
    ll_hauling_operation_id integer NOT NULL,
    offal_disposal_position character varying(255) NOT NULL
);


ALTER TABLE ros_ll.ll_hauling_offal_disposal_positions OWNER TO "ros-admin";

--
-- Name: ll_hauling_operations_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ros_ll.ll_hauling_operations ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ll.ll_hauling_operations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ll_hauling_operations_stunning_methods; Type: TABLE; Schema: ros_ll; Owner: ros-admin
--

CREATE TABLE ros_ll.ll_hauling_operations_stunning_methods (
    ll_hauling_operation_id integer NOT NULL,
    stunning_method_code character(2) NOT NULL
);


ALTER TABLE ros_ll.ll_hauling_operations_stunning_methods OWNER TO "ros-admin";

--
-- Name: ll_mitigation_measures; Type: TABLE; Schema: ros_ll; Owner: ros-admin
--

CREATE TABLE ros_ll.ll_mitigation_measures (
    id integer NOT NULL,
    branchline_weighted smallint DEFAULT 0,
    hooks_set_between_dusk_and_dawn smallint DEFAULT 0,
    minimum_deck_lighting_used smallint DEFAULT 0,
    number_of_tori_lines_deployed integer,
    percentage_of_branchlines_weighted double precision,
    underwater_setting smallint DEFAULT 0,
    branchline_average_weight_id integer,
    hook_sinker_distance_id integer
);


ALTER TABLE ros_ll.ll_mitigation_measures OWNER TO "ros-admin";

--
-- Name: ll_mitigation_measures_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ros_ll.ll_mitigation_measures ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ll.ll_mitigation_measures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ll_mitigation_measures_mitigation_devices; Type: TABLE; Schema: ros_ll; Owner: ros-admin
--

CREATE TABLE ros_ll.ll_mitigation_measures_mitigation_devices (
    ll_mitigation_measure_id integer NOT NULL,
    mitigation_device_code character(2) NOT NULL
);


ALTER TABLE ros_ll.ll_mitigation_measures_mitigation_devices OWNER TO "ros-admin";

--
-- Name: ll_observer_data_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ros_ll.ll_observer_data ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ll.ll_observer_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ll_setting_operations_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ros_ll.ll_setting_operations ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ll.ll_setting_operations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ll_setting_operations_target_species; Type: TABLE; Schema: ros_ll; Owner: ros-admin
--

CREATE TABLE ros_ll.ll_setting_operations_target_species (
    ll_setting_operations_id integer NOT NULL,
    target_species_code character varying(16)
);


ALTER TABLE ros_ll.ll_setting_operations_target_species OWNER TO "ros-admin";

--
-- Name: ll_special_equipment; Type: TABLE; Schema: ros_ll; Owner: ros-admin
--

CREATE TABLE ros_ll.ll_special_equipment (
    id integer NOT NULL,
    bait_casting_machine smallint DEFAULT 0,
    line_hauler smallint DEFAULT 0,
    line_setter smallint DEFAULT 0
);


ALTER TABLE ros_ll.ll_special_equipment OWNER TO "ros-admin";

--
-- Name: ll_special_equipment_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ros_ll.ll_special_equipment ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ll.ll_special_equipment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ll_specimens_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ros_ll.ll_specimens ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ll.ll_specimens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ll_tag_details; Type: TABLE; Schema: ros_ll; Owner: ros-admin
--

CREATE TABLE ros_ll.ll_tag_details (
    id integer NOT NULL,
    alternate_tag_number character varying(255),
    tag_number character varying(255),
    tag_recovery smallint DEFAULT 0,
    tag_release smallint DEFAULT 0,
    tag_finder_id integer,
    tag_type_code character(2)
);


ALTER TABLE ros_ll.ll_tag_details OWNER TO "ros-admin";

--
-- Name: ll_tag_details_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ros_ll.ll_tag_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ll.ll_tag_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: tori_line_details; Type: TABLE; Schema: ros_ll; Owner: ros-admin
--

CREATE TABLE ros_ll.tori_line_details (
    id integer NOT NULL,
    number_of_streamers_per_line integer,
    streamer_type character varying(255),
    streamers_reach_surface smallint DEFAULT 0,
    towed_objects_number integer,
    towed_objects_type character varying(255),
    attached_height_id integer,
    streamer_distance_id integer,
    tori_line_length_id integer,
    streamer_line_length_max_id integer,
    streamer_line_length_min_id integer
);


ALTER TABLE ros_ll.tori_line_details OWNER TO "ros-admin";

--
-- Name: tori_line_details_id_seq; Type: SEQUENCE; Schema: ros_ll; Owner: ros-admin
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
-- Name: db_meta; Type: TABLE; Schema: ros_meta; Owner: ros-admin
--

CREATE TABLE ros_meta.db_meta (
    version_number character varying(32) NOT NULL,
    release_date timestamp(6) without time zone NOT NULL,
    comments text
);


ALTER TABLE ros_meta.db_meta OWNER TO "ros-admin";

--
-- Name: ros_focal_points; Type: TABLE; Schema: ros_meta; Owner: ros-admin
--

CREATE TABLE ros_meta.ros_focal_points (
    iotc_username character varying(16) NOT NULL,
    first_name character varying(255),
    last_name character varying(255) NOT NULL,
    full_address character varying(255) NOT NULL,
    e_mail character varying(255) NOT NULL,
    phone character varying(255),
    active smallint DEFAULT 1 NOT NULL,
    login_id integer NOT NULL,
    responsible_flag_code character(3) NOT NULL
);


ALTER TABLE ros_meta.ros_focal_points OWNER TO "ros-admin";

--
-- Name: ros_focal_points_logins; Type: TABLE; Schema: ros_meta; Owner: ros-admin
--

CREATE TABLE ros_meta.ros_focal_points_logins (
    id integer NOT NULL,
    password_hash character(32) NOT NULL,
    last_login timestamp(6) without time zone
);


ALTER TABLE ros_meta.ros_focal_points_logins OWNER TO "ros-admin";

--
-- Name: ros_focal_points_logins_id_seq; Type: SEQUENCE; Schema: ros_meta; Owner: ros-admin
--

ALTER TABLE ros_meta.ros_focal_points_logins ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_meta.ros_focal_points_logins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ros_observers_logins; Type: TABLE; Schema: ros_meta; Owner: ros-admin
--

CREATE TABLE ros_meta.ros_observers_logins (
    id integer NOT NULL,
    password_hash character(32) NOT NULL,
    last_login timestamp(6) without time zone
);


ALTER TABLE ros_meta.ros_observers_logins OWNER TO "ros-admin";

--
-- Name: ros_observers_logins_id_seq; Type: SEQUENCE; Schema: ros_meta; Owner: ros-admin
--

ALTER TABLE ros_meta.ros_observers_logins ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_meta.ros_observers_logins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ros_user_requests; Type: TABLE; Schema: ros_meta; Owner: ros-admin
--

CREATE TABLE ros_meta.ros_user_requests (
    id integer NOT NULL,
    encoded_credentials character varying(1024),
    username character varying(16),
    "PASSWORD" character varying(256),
    ip_address character varying(64) NOT NULL,
    country character varying(16),
    user_agent character varying(512),
    referer character varying(512),
    target character varying(512) NOT NULL,
    method character varying(16) NOT NULL,
    url character varying(512) NOT NULL,
    accept_mime_type character varying(512),
    content_mime_type character varying(512),
    request_date timestamp(6) without time zone NOT NULL,
    elapsed integer,
    response_code integer,
    response_phrase text
);


ALTER TABLE ros_meta.ros_user_requests OWNER TO "ros-admin";

--
-- Name: ros_user_requests_id_seq; Type: SEQUENCE; Schema: ros_meta; Owner: ros-admin
--

ALTER TABLE ros_meta.ros_user_requests ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_meta.ros_user_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: v_ll_fdays; Type: VIEW; Schema: ros_meta; Owner: ros-admin
--

CREATE VIEW ros_meta.v_ll_fdays AS
 SELECT od.id AS trip_id,
    od.uid AS trip_uid,
    'LL'::text AS fishing_operation_type,
    date_part('year'::text, s.start_setting_date_and_time) AS year,
    date_part('month'::text, s.start_setting_date_and_time) AS month,
    ros_meta.to_grid_1(s.start_setting_latitude, s.end_setting_latitude) AS grid_1,
    ros_meta.to_grid_5(s.start_setting_latitude, s.end_setting_latitude) AS grid_5,
    count(DISTINCT concat(date_part('month'::text, s.start_setting_date_and_time), '/', date_part('day'::text, s.start_setting_date_and_time))) AS effort,
    'FDAYS'::text AS effort_unit
   FROM ((ros_ll.ll_observer_data od
     JOIN ros_ll.ll_fishing_events fe ON ((fe.ll_observer_data_id = od.id)))
     JOIN ros_ll.ll_setting_operations s ON ((fe.ll_setting_operation_id = s.id)))
  GROUP BY od.id, od.uid, (date_part('year'::text, s.start_setting_date_and_time)), (date_part('month'::text, s.start_setting_date_and_time)), (ros_meta.to_grid_1(s.start_setting_latitude, s.end_setting_latitude)), (ros_meta.to_grid_5(s.start_setting_latitude, s.end_setting_latitude));


ALTER VIEW ros_meta.v_ll_fdays OWNER TO "ros-admin";

--
-- Name: v_ps_fdays; Type: VIEW; Schema: ros_meta; Owner: ros-admin
--

CREATE VIEW ros_meta.v_ps_fdays AS
 SELECT od.id AS trip_id,
    od.uid AS trip_uid,
    'PS'::text AS fishing_operation_type,
    date_part('year'::text, s.start_setting_date_and_time) AS year,
    date_part('month'::text, s.start_setting_date_and_time) AS month,
    ros_meta.to_grid_1(s.start_setting_latitude, s.start_setting_longitude) AS grid_1,
    ros_meta.to_grid_5(s.start_setting_latitude, s.start_setting_longitude) AS grid_5,
    count(DISTINCT concat(date_part('month'::text, s.start_setting_date_and_time), '/', date_part('day'::text, s.start_setting_date_and_time))) AS effort,
    'FDAYS'::text AS effort_unit
   FROM ((ros_ps.ps_observer_data od
     JOIN ros_ps.ps_fishing_events fe ON ((fe.ps_observer_data_id = od.id)))
     JOIN ros_ps.ps_setting_operations s ON ((fe.ps_setting_operation_id = s.id)))
  GROUP BY od.id, od.uid, (date_part('year'::text, s.start_setting_date_and_time)), (date_part('month'::text, s.start_setting_date_and_time)), (ros_meta.to_grid_1(s.start_setting_latitude, s.start_setting_longitude)), (ros_meta.to_grid_5(s.start_setting_latitude, s.start_setting_longitude));


ALTER VIEW ros_meta.v_ps_fdays OWNER TO "ros-admin";

--
-- Name: v_fdays; Type: VIEW; Schema: ros_meta; Owner: ros-admin
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


ALTER VIEW ros_meta.v_fdays OWNER TO "ros-admin";

--
-- Name: v_ll_hooks; Type: VIEW; Schema: ros_meta; Owner: ros-admin
--

CREATE VIEW ros_meta.v_ll_hooks AS
 SELECT o.id AS trip_id,
    o.uid AS trip_uid,
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
   FROM ((((ros_ll.ll_observer_data o
     JOIN ros_common.general_vessel_and_trip_information gvt ON ((o.vessel_and_trip_information_id = gvt.id)))
     JOIN ros_ll.ll_fishing_events fed ON ((fed.ll_observer_data_id = o.id)))
     JOIN ros_ll.ll_setting_operations so ON ((fed.ll_setting_operation_id = so.id)))
     LEFT JOIN ros_ll.ll_hauling_operations ho ON ((fed.ll_hauling_operation_id = ho.id)));


ALTER VIEW ros_meta.v_ll_hooks OWNER TO "ros-admin";

--
-- Name: v_efforts_m; Type: VIEW; Schema: ros_meta; Owner: ros-admin
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


ALTER VIEW ros_meta.v_efforts_m OWNER TO "ros-admin";

--
-- Name: v_fishing_days_by_year_flag_and_gear; Type: VIEW; Schema: ros_meta; Owner: ros-admin
--

CREATE VIEW ros_meta.v_fishing_days_by_year_flag_and_gear AS
 WITH ps AS (
         SELECT date_part('year'::text, s.start_setting_date_and_time) AS year,
            c.code AS flag,
            'PS'::text AS gear,
            count(DISTINCT concat(date_part('month'::text, s.start_setting_date_and_time), '-', date_part('day'::text, s.start_setting_date_and_time))) AS fishing_days
           FROM (((((ros_ps.ps_observer_data od
             JOIN ros_common.general_vessel_and_trip_information gvt ON ((od.vessel_and_trip_information_id = gvt.id)))
             JOIN ros_ps.ps_fishing_events fe ON ((fe.ps_observer_data_id = od.id)))
             JOIN ros_ps.ps_setting_operations s ON ((fe.ps_setting_operation_id = s.id)))
             JOIN ros_common.vessel_identification vi ON ((gvt.vessel_identification_id = vi.id)))
             JOIN refs_admin.countries c ON ((vi.flag_code = c.code)))
          GROUP BY c.code, (date_part('year'::text, s.start_setting_date_and_time))
        ), ll AS (
         SELECT date_part('year'::text, s.start_setting_date_and_time) AS year,
            c.code AS flag,
            'LL'::text AS gear,
            count(DISTINCT concat(date_part('month'::text, s.start_setting_date_and_time), '-', date_part('day'::text, s.start_setting_date_and_time))) AS fishing_days
           FROM (((((ros_ll.ll_observer_data od
             JOIN ros_common.general_vessel_and_trip_information gvt ON ((od.vessel_and_trip_information_id = gvt.id)))
             JOIN ros_ll.ll_fishing_events fe ON ((fe.ll_observer_data_id = od.id)))
             JOIN ros_ll.ll_setting_operations s ON ((fe.ll_setting_operation_id = s.id)))
             JOIN ros_common.vessel_identification vi ON ((gvt.vessel_identification_id = vi.id)))
             JOIN refs_admin.countries c ON ((vi.flag_code = c.code)))
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


ALTER VIEW ros_meta.v_fishing_days_by_year_flag_and_gear OWNER TO "ros-admin";

--
-- Name: v_ll_catches; Type: VIEW; Schema: ros_meta; Owner: ros-admin
--

CREATE VIEW ros_meta.v_ll_catches AS
 SELECT o.id AS trip_id,
    o.uid AS trip_uid,
    fe.id AS set_id,
    fe.event_number AS set_number,
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
   FROM (((((ros_ll.ll_observer_data o
     JOIN ros_ll.ll_fishing_events fe ON ((fe.ll_observer_data_id = o.id)))
     JOIN ros_ll.ll_setting_operations s ON ((fe.ll_setting_operation_id = s.id)))
     JOIN ros_ll.ll_catch_details cd ON ((cd.ll_fishing_event_id = fe.id)))
     JOIN refs_biological.species sp ON (((cd.species_code)::text = (sp.code)::text)))
     LEFT JOIN refs_biological.fates f ON ((cd.fates_code = f.code)))
  WHERE (f.code ~~ 'R%'::text)
  GROUP BY o.id, o.uid, fe.id, fe.event_number, sp.code,
        CASE
            WHEN (f.code IS NULL) THEN NULL::text
            ELSE concat(f.code, ' - ', f.name_en)
        END;


ALTER VIEW ros_meta.v_ll_catches OWNER TO "ros-admin";

--
-- Name: v_ll_effort_summary; Type: VIEW; Schema: ros_meta; Owner: ros-admin
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


ALTER VIEW ros_meta.v_ll_effort_summary OWNER TO "ros-admin";

--
-- Name: v_ps_effort_summary; Type: VIEW; Schema: ros_meta; Owner: ros-admin
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


ALTER VIEW ros_meta.v_ps_effort_summary OWNER TO "ros-admin";

--
-- Name: v_ps_length_weight; Type: VIEW; Schema: ros_meta; Owner: ros-admin
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
                    WHEN ((lt.code IS NULL) AND (l.value IS NOT NULL)) THEN 'UNK'::bpchar
                    ELSE lt.code
                END AS length_type_code,
                CASE
                    WHEN ((lt.name_en IS NULL) AND (l.value IS NOT NULL)) THEN 'Unknown'::character varying
                    ELSE lt.name_en
                END AS length_type,
            l.value AS length,
            (
                CASE
                    WHEN ((alt.code IS NULL) AND (al.value IS NOT NULL)) THEN 'UNK'::bpchar
                    ELSE alt.code
                END)::character varying(16) AS additional_length_type_code,
            (
                CASE
                    WHEN ((alt.name_en IS NULL) AND (al.value IS NOT NULL)) THEN 'Unknown'::character varying
                    ELSE alt.name_en
                END)::character varying(255) AS additional_length_type,
            al.value AS additional_length,
                CASE
                    WHEN ((wp.code IS NULL) AND (w.value IS NOT NULL)) THEN 'UNK'::bpchar
                    ELSE wp.code
                END AS weight_type_code,
                CASE
                    WHEN ((wp.name_en IS NULL) AND (w.value IS NOT NULL)) THEN 'Unknown'::character varying
                    ELSE wp.name_en
                END AS weight_type,
            w.value AS weight_value,
            w.unit AS weight_unit
           FROM (((((((((((((ros_ps.ps_fishing_events fe_1
             JOIN ros_ps.ps_setting_operations s ON ((fe_1.ps_setting_operation_id = s.id)))
             JOIN ros_ps.ps_catch_details c_1 ON ((c_1.ps_fishing_event_id = s.id)))
             JOIN refs_biological.species sp ON (((c_1.species_code)::text = (sp.code)::text)))
             JOIN refs_biological.fates f ON ((c_1.fates_code = f.code)))
             JOIN ros_ps.ps_specimens spc ON ((spc.ps_catch_detail_id = c_1.id)))
             LEFT JOIN ros_common.biometric_information b ON ((spc.biometric_information_id = b.id)))
             LEFT JOIN refs_biological.sex x ON ((b.sex_code = x.code)))
             LEFT JOIN ros_common.measured_lengths l ON ((b.measured_length_id = l.id)))
             LEFT JOIN refs_biological.measurements lt ON ((l.measured_length_type_code = lt.code)))
             LEFT JOIN ros_common.measured_lengths al ON ((b.alternative_measured_length_id = al.id)))
             LEFT JOIN refs_biological.measurements alt ON ((al.measured_length_type_code = alt.code)))
             LEFT JOIN ros_common.estimated_weights w ON ((b.estimated_weight_id = w.id)))
             LEFT JOIN refs_fishery.fish_processing_types wp ON ((w.weight_estimation_method_code = wp.code)))
          WHERE ((l.value IS NOT NULL) OR (al.value IS NOT NULL) OR (w.value IS NOT NULL))
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
   FROM ((((((ros_ps.ps_observer_data od
     JOIN ros_common.general_vessel_and_trip_information gvt ON ((od.vessel_and_trip_information_id = gvt.id)))
     LEFT JOIN ros_common.vessel_identification vi ON ((gvt.vessel_identification_id = vi.id)))
     LEFT JOIN refs_admin.countries c ON ((vi.flag_code = c.code)))
     JOIN ros_ps.ps_fishing_events fe ON ((fe.ps_observer_data_id = od.id)))
     JOIN ros_ps.ps_setting_operations so ON ((fe.ps_setting_operation_id = so.id)))
     JOIN ps_length_weight lw ON ((lw.set_id = so.id)));


ALTER VIEW ros_meta.v_ps_length_weight OWNER TO "ros-admin";

--
-- Name: v_ps_sf; Type: VIEW; Schema: ros_meta; Owner: ros-admin
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
    l.value AS length,
    count(*) AS num
   FROM (((((((((ros_ps.ps_fishing_events fe
     JOIN ros_ps.ps_setting_operations so ON ((fe.ps_setting_operation_id = so.id)))
     JOIN ros_ps.ps_catch_details c ON ((c.ps_fishing_event_id = fe.id)))
     JOIN refs_biological.species s ON (((c.species_code)::text = (s.code)::text)))
     JOIN refs_biological.fates f ON ((c.fates_code = f.code)))
     JOIN ros_ps.ps_specimens sp ON ((sp.ps_catch_detail_id = c.id)))
     JOIN ros_common.biometric_information b ON ((sp.biometric_information_id = b.id)))
     JOIN ros_common.measured_lengths l ON ((b.measured_length_id = l.id)))
     LEFT JOIN refs_biological.measurements lt ON ((l.measured_length_type_code = lt.code)))
     LEFT JOIN refs_biological.sex x ON ((b.sex_code = x.code)))
  GROUP BY (date_part('year'::text, so.start_setting_date_and_time)), (date_part('month'::text, so.start_setting_date_and_time)), (ros_meta.to_grid_1(so.start_setting_latitude, so.start_setting_longitude)), (ros_meta.to_grid_5(so.start_setting_latitude, so.start_setting_longitude)),
        CASE
            WHEN (f.code ~~ 'R%'::text) THEN 'RC'::text
            ELSE 'DI'::text
        END, s.code, x.code, lt.code, l.value;


ALTER VIEW ros_meta.v_ps_sf OWNER TO "ros-admin";

--
-- Name: v_sets_by_flag_and_gear; Type: VIEW; Schema: ros_meta; Owner: ros-admin
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


ALTER VIEW ros_meta.v_sets_by_flag_and_gear OWNER TO "ros-admin";

--
-- Name: v_sets_by_year_and_gear; Type: VIEW; Schema: ros_meta; Owner: ros-admin
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


ALTER VIEW ros_meta.v_sets_by_year_and_gear OWNER TO "ros-admin";

--
-- Name: v_target_species_by_trip; Type: VIEW; Schema: ros_meta; Owner: ros-admin
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
     LEFT JOIN ros_common.vessel_identification vi ON ((t.vessel_info_id = vi.id)))
     LEFT JOIN ros_common.vessel_identification_licensed_target_species vi2lts ON ((vi2lts.vessel_identification_id = vi.id)))
     LEFT JOIN refs_biological.species s_t ON (((vi2lts.licensed_target_species_code)::text = (s_t.code)::text)));


ALTER VIEW ros_meta.v_target_species_by_trip OWNER TO "ros-admin";

--
-- Name: v_trips_by_flag_and_gear; Type: VIEW; Schema: ros_meta; Owner: ros-admin
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


ALTER VIEW ros_meta.v_trips_by_flag_and_gear OWNER TO "ros-admin";

--
-- Name: v_trips_by_year_and_gear; Type: VIEW; Schema: ros_meta; Owner: ros-admin
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


ALTER VIEW ros_meta.v_trips_by_year_and_gear OWNER TO "ros-admin";

--
-- Name: bait_fishing_events; Type: TABLE; Schema: ros_pl; Owner: ros-admin
--

CREATE TABLE ros_pl.bait_fishing_events (
    id integer NOT NULL,
    comments text,
    event_number character varying(255),
    pl_bait_fishing_operation_id integer,
    pl_object_detail_id integer,
    pl_observer_data_id integer
);


ALTER TABLE ros_pl.bait_fishing_events OWNER TO "ros-admin";

--
-- Name: bait_fishing_events_id_seq; Type: SEQUENCE; Schema: ros_pl; Owner: ros-admin
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
-- Name: bait_fishing_operations; Type: TABLE; Schema: ros_pl; Owner: ros-admin
--

CREATE TABLE ros_pl.bait_fishing_operations (
    id integer NOT NULL,
    end_event_date_and_time timestamp(6) without time zone,
    number_of_fishers integer,
    start_event_date_and_time timestamp(6) without time zone,
    start_event_latitude double precision,
    start_event_longitude double precision,
    distance_from_the_coast_id integer,
    event_depth_id integer,
    bait_fishing_method_code character(2),
    bait_school_detection_method_code character(2),
    sampling_protocol_code character(2),
    wind_scale_code character(2)
);


ALTER TABLE ros_pl.bait_fishing_operations OWNER TO "ros-admin";

--
-- Name: bait_fishing_operations_cl_school_sighting_cues; Type: TABLE; Schema: ros_pl; Owner: ros-admin
--

CREATE TABLE ros_pl.bait_fishing_operations_cl_school_sighting_cues (
    pl_fishing_operation_id integer NOT NULL,
    school_sighting_cue_code character(2) NOT NULL
);


ALTER TABLE ros_pl.bait_fishing_operations_cl_school_sighting_cues OWNER TO "ros-admin";

--
-- Name: bait_fishing_operations_id_seq; Type: SEQUENCE; Schema: ros_pl; Owner: ros-admin
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
-- Name: baits_and_conditions; Type: TABLE; Schema: ros_pl; Owner: ros-admin
--

CREATE TABLE ros_pl.baits_and_conditions (
    id integer NOT NULL,
    bait_condition_code character(2),
    species_code character varying(16)
);


ALTER TABLE ros_pl.baits_and_conditions OWNER TO "ros-admin";

--
-- Name: baits_and_conditions_id_seq; Type: SEQUENCE; Schema: ros_pl; Owner: ros-admin
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
-- Name: lures_or_jiggers_by_type; Type: TABLE; Schema: ros_pl; Owner: ros-admin
--

CREATE TABLE ros_pl.lures_or_jiggers_by_type (
    id integer NOT NULL,
    lure_type character varying(255),
    make character varying(255),
    pl_general_gear_attributes_id integer,
    hook_type_code character(3)
);


ALTER TABLE ros_pl.lures_or_jiggers_by_type OWNER TO "ros-admin";

--
-- Name: lures_or_jiggers_by_type_id_seq; Type: SEQUENCE; Schema: ros_pl; Owner: ros-admin
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
-- Name: pl_additional_catch_details_on_ssi; Type: TABLE; Schema: ros_pl; Owner: ros-admin
--

CREATE TABLE ros_pl.pl_additional_catch_details_on_ssi (
    id integer NOT NULL,
    brought_on_board smallint DEFAULT 0,
    photo_id character varying(255),
    revival smallint DEFAULT 0,
    gear_interaction_code character(2),
    handling_method_code character(2)
);


ALTER TABLE ros_pl.pl_additional_catch_details_on_ssi OWNER TO "ros-admin";

--
-- Name: pl_additional_catch_details_on_ssi_id_seq; Type: SEQUENCE; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ros_pl.pl_additional_catch_details_on_ssi ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_pl.pl_additional_catch_details_on_ssi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: pl_bait_fishing_event_pl_catch_detail; Type: TABLE; Schema: ros_pl; Owner: ros-admin
--

CREATE TABLE ros_pl.pl_bait_fishing_event_pl_catch_detail (
    pl_bait_fishing_event_id integer NOT NULL,
    pl_catch_detail_id integer NOT NULL
);


ALTER TABLE ros_pl.pl_bait_fishing_event_pl_catch_detail OWNER TO "ros-admin";

--
-- Name: pl_catch_details; Type: TABLE; Schema: ros_pl; Owner: ros-admin
--

CREATE TABLE ros_pl.pl_catch_details (
    id integer NOT NULL,
    catch_detail_number character varying(255) NOT NULL,
    comments text,
    estimated_catch_in_numbers integer,
    estimated_weight_id integer,
    type_of_fate_code character(2) NOT NULL,
    estimated_weight_sampling_method_code character(2),
    fates_code character(2),
    species_code character varying(16)
);


ALTER TABLE ros_pl.pl_catch_details OWNER TO "ros-admin";

--
-- Name: pl_catch_details_id_seq; Type: SEQUENCE; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ros_pl.pl_catch_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_pl.pl_catch_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: pl_gear_specifications; Type: TABLE; Schema: ros_pl; Owner: ros-admin
--

CREATE TABLE ros_pl.pl_gear_specifications (
    id integer NOT NULL,
    pl_general_gear_attributes_id integer,
    pl_special_equipment_id integer
);


ALTER TABLE ros_pl.pl_gear_specifications OWNER TO "ros-admin";

--
-- Name: pl_gear_specifications_id_seq; Type: SEQUENCE; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ros_pl.pl_gear_specifications ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_pl.pl_gear_specifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: pl_general_gear_attributes; Type: TABLE; Schema: ros_pl; Owner: ros-admin
--

CREATE TABLE ros_pl.pl_general_gear_attributes (
    id integer NOT NULL,
    number_of_anglers integer,
    pole_material character varying(255),
    pole_material_description text,
    vessel_uses_lures_or_jiggers smallint DEFAULT 0,
    hook_type_code character(3)
);


ALTER TABLE ros_pl.pl_general_gear_attributes OWNER TO "ros-admin";

--
-- Name: pl_general_gear_attributes_id_seq; Type: SEQUENCE; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ros_pl.pl_general_gear_attributes ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_pl.pl_general_gear_attributes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: pl_object_details; Type: TABLE; Schema: ros_pl; Owner: ros-admin
--

CREATE TABLE ros_pl.pl_object_details (
    id integer NOT NULL,
    equipped_with_artificial_lights smallint DEFAULT 0,
    buoy_identifier character varying(255)
);


ALTER TABLE ros_pl.pl_object_details OWNER TO "ros-admin";

--
-- Name: pl_object_details_id_seq; Type: SEQUENCE; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ros_pl.pl_object_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_pl.pl_object_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: pl_observer_data_id_seq; Type: SEQUENCE; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ros_pl.pl_observer_data ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_pl.pl_observer_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: pl_special_equipment; Type: TABLE; Schema: ros_pl; Owner: ros-admin
--

CREATE TABLE ros_pl.pl_special_equipment (
    id integer NOT NULL,
    live_bait_tanks_capacity double precision,
    number_of_automatic_poles integer
);


ALTER TABLE ros_pl.pl_special_equipment OWNER TO "ros-admin";

--
-- Name: pl_special_equipment_id_seq; Type: SEQUENCE; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ros_pl.pl_special_equipment ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_pl.pl_special_equipment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: pl_specimens; Type: TABLE; Schema: ros_pl; Owner: ros-admin
--

CREATE TABLE ros_pl.pl_specimens (
    id integer NOT NULL,
    specimen_number character varying(255) NOT NULL,
    pl_additional_catch_details_on_ssis_id integer,
    additional_specimen_details_non_target_species_id integer,
    biometric_information_id integer,
    pl_depredation_detail_id integer,
    pl_tag_detail_id integer,
    pl_catch_detail_id integer
);


ALTER TABLE ros_pl.pl_specimens OWNER TO "ros-admin";

--
-- Name: pl_specimens_id_seq; Type: SEQUENCE; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ros_pl.pl_specimens ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_pl.pl_specimens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: pl_tag_details; Type: TABLE; Schema: ros_pl; Owner: ros-admin
--

CREATE TABLE ros_pl.pl_tag_details (
    id integer NOT NULL,
    alternate_tag_number character varying(255),
    tag_number character varying(255),
    tag_recovery smallint DEFAULT 0,
    tag_release smallint DEFAULT 0,
    tag_finder_id integer,
    tag_type_code character(2)
);


ALTER TABLE ros_pl.pl_tag_details OWNER TO "ros-admin";

--
-- Name: pl_tag_details_id_seq; Type: SEQUENCE; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ros_pl.pl_tag_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_pl.pl_tag_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: pl_tuna_fishing_event_pl_catch_detail; Type: TABLE; Schema: ros_pl; Owner: ros-admin
--

CREATE TABLE ros_pl.pl_tuna_fishing_event_pl_catch_detail (
    pl_tuna_fishing_event_id integer NOT NULL,
    pl_catch_detail_id integer NOT NULL
);


ALTER TABLE ros_pl.pl_tuna_fishing_event_pl_catch_detail OWNER TO "ros-admin";

--
-- Name: pl_tuna_fishing_operations; Type: TABLE; Schema: ros_pl; Owner: ros-admin
--

CREATE TABLE ros_pl.pl_tuna_fishing_operations (
    id integer NOT NULL,
    bait_used smallint DEFAULT 0,
    end_event_date_and_time timestamp(6) without time zone,
    maximum_lines_fishing_at_the_same_time integer,
    number_of_hooks_lost integer,
    start_event_date_and_time timestamp(6) without time zone,
    weight_of_bait_used double precision,
    start_event_latitude double precision,
    start_event_longitude double precision,
    bait_and_condition_id integer,
    sampling_protocol_code character(2),
    wind_scale_code character(2)
);


ALTER TABLE ros_pl.pl_tuna_fishing_operations OWNER TO "ros-admin";

--
-- Name: pl_tuna_fishing_operations_cl_school_sighting_cues; Type: TABLE; Schema: ros_pl; Owner: ros-admin
--

CREATE TABLE ros_pl.pl_tuna_fishing_operations_cl_school_sighting_cues (
    pl_fishing_operation_id integer NOT NULL,
    school_sighting_cue_code character(2) NOT NULL
);


ALTER TABLE ros_pl.pl_tuna_fishing_operations_cl_school_sighting_cues OWNER TO "ros-admin";

--
-- Name: pl_tuna_fishing_operations_id_seq; Type: SEQUENCE; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ros_pl.pl_tuna_fishing_operations ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_pl.pl_tuna_fishing_operations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: pl_tuna_fishing_operations_target_species; Type: TABLE; Schema: ros_pl; Owner: ros-admin
--

CREATE TABLE ros_pl.pl_tuna_fishing_operations_target_species (
    pl_tuna_fishing_operation_id2 integer NOT NULL,
    target_species_code character varying(16)
);


ALTER TABLE ros_pl.pl_tuna_fishing_operations_target_species OWNER TO "ros-admin";

--
-- Name: tuna_fishing_events; Type: TABLE; Schema: ros_pl; Owner: ros-admin
--

CREATE TABLE ros_pl.tuna_fishing_events (
    id integer NOT NULL,
    comments text,
    event_number character varying(255),
    pl_object_detail_id integer,
    pl_tuna_fishing_operation_id integer,
    pl_observer_data_id integer
);


ALTER TABLE ros_pl.tuna_fishing_events OWNER TO "ros-admin";

--
-- Name: tuna_fishing_events_id_seq; Type: SEQUENCE; Schema: ros_pl; Owner: ros-admin
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
-- Name: cetaceans_whale_shark_sightings; Type: TABLE; Schema: ros_ps; Owner: ros-admin
--

CREATE TABLE ros_ps.cetaceans_whale_shark_sightings (
    id integer NOT NULL,
    caught_inside_the_net smallint DEFAULT 0,
    number_sighted integer,
    sighting_occurred_before_setting smallint DEFAULT 0,
    ps_setting_operation_id integer,
    species_code character varying(16)
);


ALTER TABLE ros_ps.cetaceans_whale_shark_sightings OWNER TO "ros-admin";

--
-- Name: cetaceans_whale_shark_sightings_id_seq; Type: SEQUENCE; Schema: ros_ps; Owner: ros-admin
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
-- Name: current_details; Type: TABLE; Schema: ros_ps; Owner: ros-admin
--

CREATE TABLE ros_ps.current_details (
    id integer NOT NULL,
    current_depth double precision,
    current_direction character varying(255),
    current_speed double precision,
    ps_setting_operation_id integer
);


ALTER TABLE ros_ps.current_details OWNER TO "ros-admin";

--
-- Name: current_details_id_seq; Type: SEQUENCE; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ros_ps.current_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ps.current_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ps_additional_catch_details_on_ssi; Type: TABLE; Schema: ros_ps; Owner: ros-admin
--

CREATE TABLE ros_ps.ps_additional_catch_details_on_ssi (
    id integer NOT NULL,
    brought_on_board smallint DEFAULT 0,
    photo_id character varying(255),
    revival smallint DEFAULT 0,
    gear_interaction_code character(2),
    handling_method_code character(2)
);


ALTER TABLE ros_ps.ps_additional_catch_details_on_ssi OWNER TO "ros-admin";

--
-- Name: ps_additional_catch_details_on_ssi_id_seq; Type: SEQUENCE; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ros_ps.ps_additional_catch_details_on_ssi ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ps.ps_additional_catch_details_on_ssi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ps_catch_details_id_seq; Type: SEQUENCE; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ros_ps.ps_catch_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ps.ps_catch_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ps_fishing_events_id_seq; Type: SEQUENCE; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ros_ps.ps_fishing_events ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ps.ps_fishing_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ps_gear_specifications; Type: TABLE; Schema: ros_ps; Owner: ros-admin
--

CREATE TABLE ros_ps.ps_gear_specifications (
    id integer NOT NULL,
    ps_general_gear_attributes_id integer,
    ps_special_equipment_id integer
);


ALTER TABLE ros_ps.ps_gear_specifications OWNER TO "ros-admin";

--
-- Name: ps_gear_specifications_id_seq; Type: SEQUENCE; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ros_ps.ps_gear_specifications ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ps.ps_gear_specifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ps_general_gear_attributes; Type: TABLE; Schema: ros_ps; Owner: ros-admin
--

CREATE TABLE ros_ps.ps_general_gear_attributes (
    id integer NOT NULL,
    maximum_brail_capacity double precision,
    bunt_stretched_mesh_size_id integer,
    maximum_net_depth_id integer,
    maximum_net_length_id integer,
    mid_net_stretched_mesh_size_id integer,
    skiff_power_id integer
);


ALTER TABLE ros_ps.ps_general_gear_attributes OWNER TO "ros-admin";

--
-- Name: ps_general_gear_attributes_id_seq; Type: SEQUENCE; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ros_ps.ps_general_gear_attributes ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ps.ps_general_gear_attributes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ps_object_details; Type: TABLE; Schema: ros_ps; Owner: ros-admin
--

CREATE TABLE ros_ps.ps_object_details (
    id integer NOT NULL,
    equipped_with_artificial_lights_at_deploy smallint DEFAULT 0,
    equipped_with_artificial_lights_on_retrieval smallint DEFAULT 0,
    buoy_identifier character varying(255),
    fad_raft_design_code character(2),
    fad_tail_design_code character(2)
);


ALTER TABLE ros_ps.ps_object_details OWNER TO "ros-admin";

--
-- Name: ps_object_details_id_seq; Type: SEQUENCE; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ros_ps.ps_object_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ps.ps_object_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ps_observer_data_id_seq; Type: SEQUENCE; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ros_ps.ps_observer_data ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ps.ps_observer_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ps_setting_operations_cl_school_sighting_cues; Type: TABLE; Schema: ros_ps; Owner: ros-admin
--

CREATE TABLE ros_ps.ps_setting_operations_cl_school_sighting_cues (
    ps_setting_operation_id integer NOT NULL,
    school_sighting_cue_code character(2) NOT NULL
);


ALTER TABLE ros_ps.ps_setting_operations_cl_school_sighting_cues OWNER TO "ros-admin";

--
-- Name: ps_setting_operations_id_seq; Type: SEQUENCE; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ros_ps.ps_setting_operations ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ps.ps_setting_operations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ps_special_equipment; Type: TABLE; Schema: ros_ps; Owner: ros-admin
--

CREATE TABLE ros_ps.ps_special_equipment (
    id integer NOT NULL,
    power_block smallint DEFAULT 0,
    purse_winch smallint DEFAULT 0
);


ALTER TABLE ros_ps.ps_special_equipment OWNER TO "ros-admin";

--
-- Name: ps_special_equipment_id_seq; Type: SEQUENCE; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ros_ps.ps_special_equipment ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ps.ps_special_equipment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ps_specimens_id_seq; Type: SEQUENCE; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ros_ps.ps_specimens ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ps.ps_specimens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ps_tag_details; Type: TABLE; Schema: ros_ps; Owner: ros-admin
--

CREATE TABLE ros_ps.ps_tag_details (
    id integer NOT NULL,
    alternate_tag_number character varying(255),
    tag_number character varying(255),
    tag_recovery smallint DEFAULT 0,
    tag_release smallint DEFAULT 0,
    well integer,
    tag_finder_id integer,
    tag_type_code character(2)
);


ALTER TABLE ros_ps.ps_tag_details OWNER TO "ros-admin";

--
-- Name: ps_tag_details_id_seq; Type: SEQUENCE; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ros_ps.ps_tag_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ps.ps_tag_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: support_vessel_details; Type: TABLE; Schema: ros_ps; Owner: ros-admin
--

CREATE TABLE ros_ps.support_vessel_details (
    id integer NOT NULL,
    support_vessel_name character varying(255),
    support_vessel_participation smallint DEFAULT 0,
    support_vessel_participation_description character varying(255),
    support_vessel_presence smallint DEFAULT 0,
    ps_setting_operation_id integer
);


ALTER TABLE ros_ps.support_vessel_details OWNER TO "ros-admin";

--
-- Name: support_vessel_details_id_seq; Type: SEQUENCE; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ros_ps.support_vessel_details ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ps.support_vessel_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: v_ca; Type: VIEW; Schema: ros_rlibs; Owner: ros-admin
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
     LEFT JOIN refs_biological.species s ON (((c.species)::text = (s.code)::text)));


ALTER VIEW ros_rlibs.v_ca OWNER TO "ros-admin";

--
-- Name: v_ef; Type: VIEW; Schema: ros_rlibs; Owner: ros-admin
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


ALTER VIEW ros_rlibs.v_ef OWNER TO "ros-admin";

--
-- Name: v_ce; Type: VIEW; Schema: ros_rlibs; Owner: ros-admin
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


ALTER VIEW ros_rlibs.v_ce OWNER TO "ros-admin";

--
-- Name: v_in; Type: VIEW; Schema: ros_rlibs; Owner: ros-admin
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
     LEFT JOIN refs_biological.species s ON (((c.species)::text = (s.code)::text)));


ALTER VIEW ros_rlibs.v_in OWNER TO "ros-admin";

--
-- Name: v_sf; Type: VIEW; Schema: ros_rlibs; Owner: ros-admin
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
     LEFT JOIN refs_biological.species s ON (((c.species_code)::text = (s.code)::text)))
  GROUP BY c.year, c.month_start, c.month_end, c.flag_code, c.fleet_code, c.gear_code, c.fishery_code, c.fishery_group_code, c.fishery_type_code, c.school_type_code, c.fishing_ground_code, s.code, s.species_category_code, s.species_group_code, s.is_iotc, s.is_aggregate, s.is_ssi, c.sex_code, c.measure_type_code, c.measure_unit_code, c.fate_code, c.class_low, c.class_high;


ALTER VIEW ros_rlibs.v_sf OWNER TO "ros-admin";

--
-- Name: v_alternate_ll_effort_fdays; Type: VIEW; Schema: ros_views; Owner: ros-admin
--

CREATE VIEW ros_views.v_alternate_ll_effort_fdays AS
 SELECT 'LL'::text AS gear_code,
    date_part('year'::text, s.start_setting_date_and_time) AS year,
    date_part('month'::text, s.start_setting_date_and_time) AS month,
    s.start_setting_latitude AS lat,
    s.start_setting_longitude AS lon,
    count(DISTINCT concat(o.uid, '_', date_part('day'::text, s.start_setting_date_and_time))) AS observed_effort,
    'FDAYS'::text AS effort_unit
   FROM ((ros_ll.ll_observer_data o
     JOIN ros_ll.ll_fishing_events fe ON ((fe.ll_observer_data_id = o.id)))
     JOIN ros_ll.ll_setting_operations s ON ((fe.ll_setting_operation_id = s.id)))
  GROUP BY (date_part('year'::text, s.start_setting_date_and_time)), (date_part('month'::text, s.start_setting_date_and_time)), s.start_setting_latitude, s.start_setting_longitude;


ALTER VIEW ros_views.v_alternate_ll_effort_fdays OWNER TO "ros-admin";

--
-- Name: v_alternate_ll_effort_set; Type: VIEW; Schema: ros_views; Owner: ros-admin
--

CREATE VIEW ros_views.v_alternate_ll_effort_set AS
 SELECT 'LL'::text AS gear_code,
    date_part('year'::text, s.start_setting_date_and_time) AS year,
    date_part('month'::text, s.start_setting_date_and_time) AS month,
    s.start_setting_latitude AS lat,
    s.start_setting_longitude AS lon,
    count(*) AS observed_effort,
    'SET'::text AS effort_unit
   FROM ((ros_ll.ll_observer_data o
     JOIN ros_ll.ll_fishing_events fe ON ((fe.ll_observer_data_id = o.id)))
     JOIN ros_ll.ll_setting_operations s ON ((fe.ll_setting_operation_id = s.id)))
  GROUP BY (date_part('year'::text, s.start_setting_date_and_time)), (date_part('month'::text, s.start_setting_date_and_time)), s.start_setting_latitude, s.start_setting_longitude;


ALTER VIEW ros_views.v_alternate_ll_effort_set OWNER TO "ros-admin";

--
-- Name: v_alternate_ps_effort_fdays; Type: VIEW; Schema: ros_views; Owner: ros-admin
--

CREATE VIEW ros_views.v_alternate_ps_effort_fdays AS
 SELECT 'PS'::text AS gear_code,
    date_part('year'::text, s.start_setting_date_and_time) AS year,
    date_part('month'::text, s.start_setting_date_and_time) AS month,
    s.start_setting_latitude AS lat,
    s.start_setting_longitude AS lon,
    count(DISTINCT concat(o.uid, '_', date_part('day'::text, s.start_setting_date_and_time))) AS observed_effort,
    'FDAYS'::text AS effort_unit
   FROM ((ros_ps.ps_observer_data o
     JOIN ros_ps.ps_fishing_events fe ON ((fe.ps_observer_data_id = o.id)))
     JOIN ros_ll.ll_setting_operations s ON ((fe.ps_setting_operation_id = s.id)))
  GROUP BY (date_part('year'::text, s.start_setting_date_and_time)), (date_part('month'::text, s.start_setting_date_and_time)), s.start_setting_latitude, s.start_setting_longitude;


ALTER VIEW ros_views.v_alternate_ps_effort_fdays OWNER TO "ros-admin";

--
-- Name: v_alternate_ps_effort_set; Type: VIEW; Schema: ros_views; Owner: ros-admin
--

CREATE VIEW ros_views.v_alternate_ps_effort_set AS
 SELECT 'PS'::text AS gear_code,
    date_part('year'::text, s.start_setting_date_and_time) AS year,
    date_part('month'::text, s.start_setting_date_and_time) AS month,
    s.start_setting_latitude AS lat,
    s.start_setting_longitude AS lon,
    count(*) AS observed_effort,
    'SET'::text AS effort_unit
   FROM ((ros_ps.ps_observer_data o
     JOIN ros_ps.ps_fishing_events fe ON ((fe.ps_observer_data_id = o.id)))
     JOIN ros_ll.ll_setting_operations s ON ((fe.ps_setting_operation_id = s.id)))
  GROUP BY (date_part('year'::text, s.start_setting_date_and_time)), (date_part('month'::text, s.start_setting_date_and_time)), s.start_setting_latitude, s.start_setting_longitude;


ALTER VIEW ros_views.v_alternate_ps_effort_set OWNER TO "ros-admin";

--
-- Name: v_alternate_effort; Type: VIEW; Schema: ros_views; Owner: ros-admin
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


ALTER VIEW ros_views.v_alternate_effort OWNER TO "ros-admin";

--
-- Name: v_ll_sets; Type: VIEW; Schema: ros_views; Owner: ros-admin
--

CREATE VIEW ros_views.v_ll_sets AS
 SELECT o.id AS trip_id,
    o.uid AS trip_uid,
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
   FROM ((((ros_ll.ll_observer_data o
     JOIN ros_common.general_vessel_and_trip_information gvt ON ((o.vessel_and_trip_information_id = gvt.id)))
     JOIN ros_ll.ll_fishing_events fed ON ((fed.ll_observer_data_id = o.id)))
     JOIN ros_ll.ll_setting_operations so ON ((fed.ll_setting_operation_id = so.id)))
     LEFT JOIN ros_ll.ll_hauling_operations ho ON ((fed.ll_hauling_operation_id = ho.id)));


ALTER VIEW ros_views.v_ll_sets OWNER TO "ros-admin";

--
-- Name: v_ps_lw_raw; Type: VIEW; Schema: ros_views; Owner: ros-admin
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
            WHEN ((lt.code IS NULL) AND (l.value IS NOT NULL)) THEN 'UNK'::bpchar
            ELSE lt.code
        END AS length_type_code,
        CASE
            WHEN ((lt.name_en IS NULL) AND (l.value IS NOT NULL)) THEN 'Unknown'::character varying
            ELSE lt.name_en
        END AS length_type,
    l.value AS length,
    NULL::text AS additional_length_type_code,
    NULL::text AS additional_length_type,
    NULL::text AS additional_length,
        CASE
            WHEN ((wp.code IS NULL) AND (w.value IS NOT NULL)) THEN 'UNK'::bpchar
            ELSE wp.code
        END AS weight_type_code,
        CASE
            WHEN ((wp.name_en IS NULL) AND (w.value IS NOT NULL)) THEN 'Unknown'::character varying
            ELSE wp.name_en
        END AS weight_type,
    w.value AS weight_value,
    w.unit AS weight_unit
   FROM ((((((((((((ros_ps.ps_observer_data o
     JOIN ros_ps.ps_fishing_events fe ON ((fe.ps_observer_data_id = o.id)))
     JOIN ros_ps.ps_setting_operations s ON ((fe.ps_setting_operation_id = s.id)))
     JOIN ros_ps.ps_catch_details c ON ((c.ps_fishing_event_id = fe.id)))
     JOIN refs_biological.species sp ON (((c.species_code)::text = (sp.code)::text)))
     LEFT JOIN refs_biological.fates fa ON ((c.fates_code = fa.code)))
     JOIN ros_ps.ps_specimens spc ON ((spc.ps_catch_detail_id = c.id)))
     JOIN ros_common.biometric_information bs ON ((spc.biometric_information_id = bs.id)))
     LEFT JOIN refs_biological.sex x ON ((bs.sex_code = x.code)))
     LEFT JOIN ros_common.measured_lengths l ON ((bs.measured_length_id = l.id)))
     LEFT JOIN refs_biological.measurements lt ON ((l.measured_length_type_code = lt.code)))
     LEFT JOIN ros_common.estimated_weights w ON ((bs.estimated_weight_id = w.id)))
     LEFT JOIN refs_fishery.fish_processing_types wp ON ((w.weight_estimation_method_code = wp.code)))
  WHERE ((l.value IS NOT NULL) OR (w.value IS NOT NULL));


ALTER VIEW ros_views.v_ps_lw_raw OWNER TO "ros-admin";

--
-- Name: v_ps_lw; Type: VIEW; Schema: ros_views; Owner: ros-admin
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
     JOIN ros_ps.ps_setting_operations s ON ((lw.set_id = s.id)));


ALTER VIEW ros_views.v_ps_lw OWNER TO "ros-admin";

--
-- Name: v_ps_sets; Type: VIEW; Schema: ros_views; Owner: ros-admin
--

CREATE VIEW ros_views.v_ps_sets AS
 SELECT o.id AS trip_id,
    o.uid AS trip_uid,
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
   FROM (((ros_ps.ps_observer_data o
     JOIN ros_common.general_vessel_and_trip_information gvt ON ((o.vessel_and_trip_information_id = gvt.id)))
     JOIN ros_ps.ps_fishing_events fed ON ((fed.ps_observer_data_id = o.id)))
     LEFT JOIN ros_ps.ps_setting_operations so ON ((fed.ps_setting_operation_id = so.id)));


ALTER VIEW ros_views.v_ps_sets OWNER TO "ros-admin";

--
-- Name: v_ps_sf; Type: VIEW; Schema: ros_views; Owner: ros-admin
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
    l.value AS length,
    count(*) AS num
   FROM (((((((((ros_ps.ps_fishing_events fe
     JOIN ros_ps.ps_setting_operations so ON ((fe.ps_setting_operation_id = so.id)))
     JOIN ros_ps.ps_catch_details c ON ((c.ps_fishing_event_id = fe.id)))
     JOIN refs_biological.species s ON (((c.species_code)::text = (s.code)::text)))
     JOIN refs_biological.fates f ON ((c.fates_code = f.code)))
     JOIN ros_ps.ps_specimens sp ON ((sp.ps_catch_detail_id = c.id)))
     JOIN ros_common.biometric_information b ON ((sp.biometric_information_id = b.id)))
     JOIN ros_common.measured_lengths l ON ((b.measured_length_id = l.id)))
     LEFT JOIN refs_biological.measurements lt ON ((l.measured_length_type_code = lt.code)))
     LEFT JOIN refs_biological.sex x ON ((b.sex_code = x.code)))
  GROUP BY (date_part('year'::text, so.start_setting_date_and_time)), (date_part('month'::text, so.start_setting_date_and_time)), (ros_meta.to_grid_1(so.start_setting_latitude, so.start_setting_longitude)), (ros_meta.to_grid_5(so.start_setting_latitude, so.start_setting_longitude)),
        CASE
            WHEN (f.code ~~ 'R%'::text) THEN 'RC'::text
            ELSE 'DI'::text
        END, s.code, x.code, lt.code, l.value;


ALTER VIEW ros_views.v_ps_sf OWNER TO "ros-admin";

--
-- Name: v_sets; Type: VIEW; Schema: ros_views; Owner: ros-admin
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


ALTER VIEW ros_views.v_sets OWNER TO "ros-admin";

--
-- Name: countries countries_code_iso3_key; Type: CONSTRAINT; Schema: refs_admin; Owner: ros-admin
--

ALTER TABLE ONLY refs_admin.countries
    ADD CONSTRAINT countries_code_iso3_key UNIQUE (code_iso3);


--
-- Name: ports pk_cl_ports; Type: CONSTRAINT; Schema: refs_admin; Owner: ros-admin
--

ALTER TABLE ONLY refs_admin.ports
    ADD CONSTRAINT pk_cl_ports PRIMARY KEY (id);


--
-- Name: countries pk_countries; Type: CONSTRAINT; Schema: refs_admin; Owner: ros-admin
--

ALTER TABLE ONLY refs_admin.countries
    ADD CONSTRAINT pk_countries PRIMARY KEY (code);


--
-- Name: entities pk_countries_ext; Type: CONSTRAINT; Schema: refs_admin; Owner: ros-admin
--

ALTER TABLE ONLY refs_admin.entities
    ADD CONSTRAINT pk_countries_ext PRIMARY KEY (code);


--
-- Name: cpc_history pk_cpc_history; Type: CONSTRAINT; Schema: refs_admin; Owner: ros-admin
--

ALTER TABLE ONLY refs_admin.cpc_history
    ADD CONSTRAINT pk_cpc_history PRIMARY KEY (cpc_code, contracting_party, acceptance_date);


--
-- Name: cpc_to_flags pk_cpc_to_flags; Type: CONSTRAINT; Schema: refs_admin; Owner: ros-admin
--

ALTER TABLE ONLY refs_admin.cpc_to_flags
    ADD CONSTRAINT pk_cpc_to_flags PRIMARY KEY (cpc_code, flag_code);


--
-- Name: cpcs pk_cpcs; Type: CONSTRAINT; Schema: refs_admin; Owner: ros-admin
--

ALTER TABLE ONLY refs_admin.cpcs
    ADD CONSTRAINT pk_cpcs PRIMARY KEY (code);


--
-- Name: fleets pk_fleets; Type: CONSTRAINT; Schema: refs_admin; Owner: ros-admin
--

ALTER TABLE ONLY refs_admin.fleets
    ADD CONSTRAINT pk_fleets PRIMARY KEY (code);


--
-- Name: io_main_areas pk_io_main_areas; Type: CONSTRAINT; Schema: refs_admin; Owner: ros-admin
--

ALTER TABLE ONLY refs_admin.io_main_areas
    ADD CONSTRAINT pk_io_main_areas PRIMARY KEY (code);


--
-- Name: species_reporting_requirements pk_reporting_requirements; Type: CONSTRAINT; Schema: refs_admin; Owner: ros-admin
--

ALTER TABLE ONLY refs_admin.species_reporting_requirements
    ADD CONSTRAINT pk_reporting_requirements PRIMARY KEY (gear_group_code, species_code);


--
-- Name: ports uk_code; Type: CONSTRAINT; Schema: refs_admin; Owner: ros-admin
--

ALTER TABLE ONLY refs_admin.ports
    ADD CONSTRAINT uk_code UNIQUE (code);


--
-- Name: bait_conditions pk_bait_conditions; Type: CONSTRAINT; Schema: refs_biological; Owner: ros-admin
--

ALTER TABLE ONLY refs_biological.bait_conditions
    ADD CONSTRAINT pk_bait_conditions PRIMARY KEY (code);


--
-- Name: bait_types pk_bait_types; Type: CONSTRAINT; Schema: refs_biological; Owner: ros-admin
--

ALTER TABLE ONLY refs_biological.bait_types
    ADD CONSTRAINT pk_bait_types PRIMARY KEY (code);


--
-- Name: depredation_sources pk_depredation_sources; Type: CONSTRAINT; Schema: refs_biological; Owner: ros-admin
--

ALTER TABLE ONLY refs_biological.depredation_sources
    ADD CONSTRAINT pk_depredation_sources PRIMARY KEY (code);


--
-- Name: fates pk_fates; Type: CONSTRAINT; Schema: refs_biological; Owner: ros-admin
--

ALTER TABLE ONLY refs_biological.fates
    ADD CONSTRAINT pk_fates PRIMARY KEY (type_of_fate_code, code);


--
-- Name: gear_interactions pk_gear_interactions; Type: CONSTRAINT; Schema: refs_biological; Owner: ros-admin
--

ALTER TABLE ONLY refs_biological.gear_interactions
    ADD CONSTRAINT pk_gear_interactions PRIMARY KEY (code);


--
-- Name: handling_methods pk_handling_methods; Type: CONSTRAINT; Schema: refs_biological; Owner: ros-admin
--

ALTER TABLE ONLY refs_biological.handling_methods
    ADD CONSTRAINT pk_handling_methods PRIMARY KEY (code);


--
-- Name: individual_conditions pk_individual_conditions; Type: CONSTRAINT; Schema: refs_biological; Owner: ros-admin
--

ALTER TABLE ONLY refs_biological.individual_conditions
    ADD CONSTRAINT pk_individual_conditions PRIMARY KEY (code);


--
-- Name: measurement_tools pk_measurement_tools; Type: CONSTRAINT; Schema: refs_biological; Owner: ros-admin
--

ALTER TABLE ONLY refs_biological.measurement_tools
    ADD CONSTRAINT pk_measurement_tools PRIMARY KEY (type_of_measurement_code, code);


--
-- Name: measurements pk_measurement_types; Type: CONSTRAINT; Schema: refs_biological; Owner: ros-admin
--

ALTER TABLE ONLY refs_biological.measurements
    ADD CONSTRAINT pk_measurement_types PRIMARY KEY (type_of_measurement_code, code);


--
-- Name: incidental_captures_conditions pk_refs_biological_incidental_captures_conditions; Type: CONSTRAINT; Schema: refs_biological; Owner: ros-admin
--

ALTER TABLE ONLY refs_biological.incidental_captures_conditions
    ADD CONSTRAINT pk_refs_biological_incidental_captures_conditions PRIMARY KEY (code);


--
-- Name: scars pk_refs_biological_scars; Type: CONSTRAINT; Schema: refs_biological; Owner: ros-admin
--

ALTER TABLE ONLY refs_biological.scars
    ADD CONSTRAINT pk_refs_biological_scars PRIMARY KEY (code);


--
-- Name: sampling_methods_for_catch_estimation pk_sampling_methods_for_catch_estimation; Type: CONSTRAINT; Schema: refs_biological; Owner: ros-admin
--

ALTER TABLE ONLY refs_biological.sampling_methods_for_catch_estimation
    ADD CONSTRAINT pk_sampling_methods_for_catch_estimation PRIMARY KEY (code);


--
-- Name: sampling_methods_for_sampling_collections pk_sampling_methods_for_sampling_collections; Type: CONSTRAINT; Schema: refs_biological; Owner: ros-admin
--

ALTER TABLE ONLY refs_biological.sampling_methods_for_sampling_collections
    ADD CONSTRAINT pk_sampling_methods_for_sampling_collections PRIMARY KEY (code);


--
-- Name: sampling_periods pk_sampling_periods; Type: CONSTRAINT; Schema: refs_biological; Owner: ros-admin
--

ALTER TABLE ONLY refs_biological.sampling_periods
    ADD CONSTRAINT pk_sampling_periods PRIMARY KEY (code);


--
-- Name: sampling_protocols pk_sampling_protocols; Type: CONSTRAINT; Schema: refs_biological; Owner: ros-admin
--

ALTER TABLE ONLY refs_biological.sampling_protocols
    ADD CONSTRAINT pk_sampling_protocols PRIMARY KEY (code);


--
-- Name: sex pk_sex; Type: CONSTRAINT; Schema: refs_biological; Owner: ros-admin
--

ALTER TABLE ONLY refs_biological.sex
    ADD CONSTRAINT pk_sex PRIMARY KEY (code);


--
-- Name: species pk_species_1; Type: CONSTRAINT; Schema: refs_biological; Owner: ros-admin
--

ALTER TABLE ONLY refs_biological.species
    ADD CONSTRAINT pk_species_1 PRIMARY KEY (code);


--
-- Name: species_aggregates pk_species_aggregates; Type: CONSTRAINT; Schema: refs_biological; Owner: ros-admin
--

ALTER TABLE ONLY refs_biological.species_aggregates
    ADD CONSTRAINT pk_species_aggregates PRIMARY KEY (species_aggregate_code, species_code);


--
-- Name: species_categories pk_species_categories; Type: CONSTRAINT; Schema: refs_biological; Owner: ros-admin
--

ALTER TABLE ONLY refs_biological.species_categories
    ADD CONSTRAINT pk_species_categories PRIMARY KEY (code);


--
-- Name: species_groups pk_species_groups; Type: CONSTRAINT; Schema: refs_biological; Owner: ros-admin
--

ALTER TABLE ONLY refs_biological.species_groups
    ADD CONSTRAINT pk_species_groups PRIMARY KEY (code);


--
-- Name: tag_types pk_tag_types; Type: CONSTRAINT; Schema: refs_biological; Owner: ros-admin
--

ALTER TABLE ONLY refs_biological.tag_types
    ADD CONSTRAINT pk_tag_types PRIMARY KEY (code);


--
-- Name: types_of_fate pk_types_of_fate; Type: CONSTRAINT; Schema: refs_biological; Owner: ros-admin
--

ALTER TABLE ONLY refs_biological.types_of_fate
    ADD CONSTRAINT pk_types_of_fate PRIMARY KEY (code);


--
-- Name: types_of_measurement pk_types_of_measurement; Type: CONSTRAINT; Schema: refs_biological; Owner: ros-admin
--

ALTER TABLE ONLY refs_biological.types_of_measurement
    ADD CONSTRAINT pk_types_of_measurement PRIMARY KEY (code);


--
-- Name: recommended_measurements pk_recommended_measurements; Type: CONSTRAINT; Schema: refs_biological_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_biological_config.recommended_measurements
    ADD CONSTRAINT pk_recommended_measurements PRIMARY KEY (species_code, type_of_measurement_code, measurement_code);


--
-- Name: coverage_types pk_coverage_types; Type: CONSTRAINT; Schema: refs_data; Owner: ros-admin
--

ALTER TABLE ONLY refs_data.coverage_types
    ADD CONSTRAINT pk_coverage_types PRIMARY KEY (code);


--
-- Name: estimations pk_data_estimations; Type: CONSTRAINT; Schema: refs_data; Owner: ros-admin
--

ALTER TABLE ONLY refs_data.estimations
    ADD CONSTRAINT pk_data_estimations PRIMARY KEY (code);


--
-- Name: processings pk_data_processings; Type: CONSTRAINT; Schema: refs_data; Owner: ros-admin
--

ALTER TABLE ONLY refs_data.processings
    ADD CONSTRAINT pk_data_processings PRIMARY KEY (dataset_code, code);


--
-- Name: raisings pk_data_raisings; Type: CONSTRAINT; Schema: refs_data; Owner: ros-admin
--

ALTER TABLE ONLY refs_data.raisings
    ADD CONSTRAINT pk_data_raisings PRIMARY KEY (code);


--
-- Name: sources pk_data_sources; Type: CONSTRAINT; Schema: refs_data; Owner: ros-admin
--

ALTER TABLE ONLY refs_data.sources
    ADD CONSTRAINT pk_data_sources PRIMARY KEY (dataset_code, code);


--
-- Name: types pk_data_types; Type: CONSTRAINT; Schema: refs_data; Owner: ros-admin
--

ALTER TABLE ONLY refs_data.types
    ADD CONSTRAINT pk_data_types PRIMARY KEY (code);


--
-- Name: datasets pk_dataset_types; Type: CONSTRAINT; Schema: refs_data; Owner: ros-admin
--

ALTER TABLE ONLY refs_data.datasets
    ADD CONSTRAINT pk_dataset_types PRIMARY KEY (code);


--
-- Name: bait_fishing_methods pk_bait_fishing_methods; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.bait_fishing_methods
    ADD CONSTRAINT pk_bait_fishing_methods PRIMARY KEY (code);


--
-- Name: bait_school_detection_methods pk_bait_school_detection_methods; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.bait_school_detection_methods
    ADD CONSTRAINT pk_bait_school_detection_methods PRIMARY KEY (code);


--
-- Name: branchline_storages pk_branchline_storages; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.branchline_storages
    ADD CONSTRAINT pk_branchline_storages PRIMARY KEY (code);


--
-- Name: buoy_activity_types pk_buoy_activity_types; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.buoy_activity_types
    ADD CONSTRAINT pk_buoy_activity_types PRIMARY KEY (code);


--
-- Name: cardinal_points pk_cardinal_points; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.cardinal_points
    ADD CONSTRAINT pk_cardinal_points PRIMARY KEY (code);


--
-- Name: catch_units pk_catch_units; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.catch_units
    ADD CONSTRAINT pk_catch_units PRIMARY KEY (code);


--
-- Name: dehooker_types pk_dehooker_devices; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.dehooker_types
    ADD CONSTRAINT pk_dehooker_devices PRIMARY KEY (code);


--
-- Name: effort_units pk_effort_units; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.effort_units
    ADD CONSTRAINT pk_effort_units PRIMARY KEY (code);


--
-- Name: fad_raft_designs pk_fad_raft_designs; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.fad_raft_designs
    ADD CONSTRAINT pk_fad_raft_designs PRIMARY KEY (code);


--
-- Name: fad_tail_designs pk_fad_tail_designs; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.fad_tail_designs
    ADD CONSTRAINT pk_fad_tail_designs PRIMARY KEY (code);


--
-- Name: fish_preservation_methods pk_fish_preservation_methods; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.fish_preservation_methods
    ADD CONSTRAINT pk_fish_preservation_methods PRIMARY KEY (code);


--
-- Name: fish_processing_types pk_fish_processing_types; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.fish_processing_types
    ADD CONSTRAINT pk_fish_processing_types PRIMARY KEY (code);


--
-- Name: fish_storage_types pk_fish_storage_types; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.fish_storage_types
    ADD CONSTRAINT pk_fish_storage_types PRIMARY KEY (code);


--
-- Name: fisheries pk_fisheries_1; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.fisheries
    ADD CONSTRAINT pk_fisheries_1 PRIMARY KEY (code);


--
-- Name: float_types pk_float_types; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.float_types
    ADD CONSTRAINT pk_float_types PRIMARY KEY (code);


--
-- Name: fob_activity_types pk_fob_activity_types; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.fob_activity_types
    ADD CONSTRAINT pk_fob_activity_types PRIMARY KEY (code);


--
-- Name: fob_types pk_fob_types; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.fob_types
    ADD CONSTRAINT pk_fob_types PRIMARY KEY (code);


--
-- Name: gear_types pk_gear_types; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.gear_types
    ADD CONSTRAINT pk_gear_types PRIMARY KEY (code);


--
-- Name: gillnet_material_types pk_gillnet_material_types; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.gillnet_material_types
    ADD CONSTRAINT pk_gillnet_material_types PRIMARY KEY (code);


--
-- Name: hook_types pk_hook_types; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.hook_types
    ADD CONSTRAINT pk_hook_types PRIMARY KEY (code);


--
-- Name: hull_material_types pk_hull_materials; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.hull_material_types
    ADD CONSTRAINT pk_hull_materials PRIMARY KEY (code);


--
-- Name: light_colours pk_light_colours; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.light_colours
    ADD CONSTRAINT pk_light_colours PRIMARY KEY (code);


--
-- Name: light_types pk_light_types; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.light_types
    ADD CONSTRAINT pk_light_types PRIMARY KEY (code);


--
-- Name: line_material_types pk_line_material_types; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.line_material_types
    ADD CONSTRAINT pk_line_material_types PRIMARY KEY (code);


--
-- Name: mechanization_types pk_mechanization_types; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.mechanization_types
    ADD CONSTRAINT pk_mechanization_types PRIMARY KEY (code);


--
-- Name: mitigation_devices pk_mitigation_devices; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.mitigation_devices
    ADD CONSTRAINT pk_mitigation_devices PRIMARY KEY (code);


--
-- Name: net_colours pk_net_colours; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.net_colours
    ADD CONSTRAINT pk_net_colours PRIMARY KEY (code);


--
-- Name: net_conditions pk_net_conditions; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.net_conditions
    ADD CONSTRAINT pk_net_conditions PRIMARY KEY (code);


--
-- Name: net_configurations pk_net_configurations; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.net_configurations
    ADD CONSTRAINT pk_net_configurations PRIMARY KEY (code);


--
-- Name: net_deploy_depths pk_net_deploy_depths; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.net_deploy_depths
    ADD CONSTRAINT pk_net_deploy_depths PRIMARY KEY (code);


--
-- Name: net_setting_strategies pk_net_setting_strategies; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.net_setting_strategies
    ADD CONSTRAINT pk_net_setting_strategies PRIMARY KEY (code);


--
-- Name: offal_management_types pk_offal_managements; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.offal_management_types
    ADD CONSTRAINT pk_offal_managements PRIMARY KEY (code);


--
-- Name: pole_material_types pk_pole_materials; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.pole_material_types
    ADD CONSTRAINT pk_pole_materials PRIMARY KEY (code);


--
-- Name: reasons_days_lost pk_reasons_days_lost; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.reasons_days_lost
    ADD CONSTRAINT pk_reasons_days_lost PRIMARY KEY (code);


--
-- Name: activities pk_refs_fishery_activities; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.activities
    ADD CONSTRAINT pk_refs_fishery_activities PRIMARY KEY (code);


--
-- Name: school_detection_methods pk_school_detection_methods; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.school_detection_methods
    ADD CONSTRAINT pk_school_detection_methods PRIMARY KEY (code);


--
-- Name: school_sighting_cues pk_school_sighting_cues; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.school_sighting_cues
    ADD CONSTRAINT pk_school_sighting_cues PRIMARY KEY (code);


--
-- Name: school_type_categories pk_school_type_categories; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.school_type_categories
    ADD CONSTRAINT pk_school_type_categories PRIMARY KEY (code);


--
-- Name: sinker_material_types pk_sinker_material_types; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.sinker_material_types
    ADD CONSTRAINT pk_sinker_material_types PRIMARY KEY (code);


--
-- Name: streamer_types pk_streamer_types; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.streamer_types
    ADD CONSTRAINT pk_streamer_types PRIMARY KEY (code);


--
-- Name: stunning_methods pk_stunning_methods; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.stunning_methods
    ADD CONSTRAINT pk_stunning_methods PRIMARY KEY (code);


--
-- Name: surface_fishery_activities pk_surface_fishery_activities; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.surface_fishery_activities
    ADD CONSTRAINT pk_surface_fishery_activities PRIMARY KEY (code);


--
-- Name: transhipment_categories pk_transhipment_categories; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.transhipment_categories
    ADD CONSTRAINT pk_transhipment_categories PRIMARY KEY (code);


--
-- Name: vessel_architectures pk_vessel_architectures; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.vessel_architectures
    ADD CONSTRAINT pk_vessel_architectures PRIMARY KEY (code);


--
-- Name: vessel_sections pk_vessel_sections; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.vessel_sections
    ADD CONSTRAINT pk_vessel_sections PRIMARY KEY (code);


--
-- Name: vessel_size_types pk_vessel_size_types; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.vessel_size_types
    ADD CONSTRAINT pk_vessel_size_types PRIMARY KEY (code);


--
-- Name: waste_categories pk_waste_categories; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.waste_categories
    ADD CONSTRAINT pk_waste_categories PRIMARY KEY (code);


--
-- Name: waste_disposal_methods pk_waste_disposal_methods; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.waste_disposal_methods
    ADD CONSTRAINT pk_waste_disposal_methods PRIMARY KEY (code);


--
-- Name: wind_scales pk_wind_scales; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.wind_scales
    ADD CONSTRAINT pk_wind_scales PRIMARY KEY (code);


--
-- Name: vessel_types vessel_types_pkey; Type: CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.vessel_types
    ADD CONSTRAINT vessel_types_pkey PRIMARY KEY (code);


--
-- Name: areas_of_operation pk_areas_of_operation; Type: CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.areas_of_operation
    ADD CONSTRAINT pk_areas_of_operation PRIMARY KEY (code);


--
-- Name: fishery_categories pk_fishery_categories; Type: CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.fishery_categories
    ADD CONSTRAINT pk_fishery_categories PRIMARY KEY (code);


--
-- Name: fishery_types pk_fishery_types; Type: CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.fishery_types
    ADD CONSTRAINT pk_fishery_types PRIMARY KEY (code);


--
-- Name: fishery_types_new pk_fishery_types_new; Type: CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.fishery_types_new
    ADD CONSTRAINT pk_fishery_types_new PRIMARY KEY (code);


--
-- Name: fishing_modes pk_fishing_modes; Type: CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.fishing_modes
    ADD CONSTRAINT pk_fishing_modes PRIMARY KEY (code);


--
-- Name: gear_configurations pk_gear_configurations; Type: CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.gear_configurations
    ADD CONSTRAINT pk_gear_configurations PRIMARY KEY (code);


--
-- Name: gear_fishery_type_to_configuration pk_gear_fishery_type_to_configuration; Type: CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.gear_fishery_type_to_configuration
    ADD CONSTRAINT pk_gear_fishery_type_to_configuration PRIMARY KEY (gear_code, fishery_type_code, gear_configuration_code);


--
-- Name: gear_fishery_type_to_fishing_mode pk_gear_fishery_type_to_fishing_mode; Type: CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.gear_fishery_type_to_fishing_mode
    ADD CONSTRAINT pk_gear_fishery_type_to_fishing_mode PRIMARY KEY (gear_code, fishery_type_code, fishing_mode_code);


--
-- Name: gear_groups pk_gear_groups; Type: CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.gear_groups
    ADD CONSTRAINT pk_gear_groups PRIMARY KEY (code);


--
-- Name: gear_to_fishery_type pk_gear_to_fishery_type; Type: CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.gear_to_fishery_type
    ADD CONSTRAINT pk_gear_to_fishery_type PRIMARY KEY (gear_code, fishery_type_code);


--
-- Name: gear_to_fishery_type_new pk_gear_to_fishery_type_new; Type: CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.gear_to_fishery_type_new
    ADD CONSTRAINT pk_gear_to_fishery_type_new PRIMARY KEY (gear_code, fishery_type_code);


--
-- Name: gear_to_target_species pk_gear_to_target_species; Type: CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.gear_to_target_species
    ADD CONSTRAINT pk_gear_to_target_species PRIMARY KEY (gear_code, target_species_code);


--
-- Name: gears pk_gears; Type: CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.gears
    ADD CONSTRAINT pk_gears PRIMARY KEY (code);


--
-- Name: loa_classes pk_loa_classes; Type: CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.loa_classes
    ADD CONSTRAINT pk_loa_classes PRIMARY KEY (code);


--
-- Name: purposes pk_purposes; Type: CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.purposes
    ADD CONSTRAINT pk_purposes PRIMARY KEY (code);


--
-- Name: target_species pk_target_species; Type: CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.target_species
    ADD CONSTRAINT pk_target_species PRIMARY KEY (code);


--
-- Name: area_types pk_area_types; Type: CONSTRAINT; Schema: refs_gis; Owner: ros-admin
--

ALTER TABLE ONLY refs_gis.area_types
    ADD CONSTRAINT pk_area_types PRIMARY KEY (code);


--
-- Name: areas pk_areas; Type: CONSTRAINT; Schema: refs_gis; Owner: ros-admin
--

ALTER TABLE ONLY refs_gis.areas
    ADD CONSTRAINT pk_areas PRIMARY KEY (code);


--
-- Name: area_intersections pk_fishing_ground_intersections; Type: CONSTRAINT; Schema: refs_gis; Owner: ros-admin
--

ALTER TABLE ONLY refs_gis.area_intersections
    ADD CONSTRAINT pk_fishing_ground_intersections PRIMARY KEY (source_code, target_code);


--
-- Name: fad_activity_types pk_fad_activity_types; Type: CONSTRAINT; Schema: refs_legacy; Owner: ros-admin
--

ALTER TABLE ONLY refs_legacy.fad_activity_types
    ADD CONSTRAINT pk_fad_activity_types PRIMARY KEY (code);


--
-- Name: fad_ownerships pk_fad_ownerships; Type: CONSTRAINT; Schema: refs_legacy; Owner: ros-admin
--

ALTER TABLE ONLY refs_legacy.fad_ownerships
    ADD CONSTRAINT pk_fad_ownerships PRIMARY KEY (code);


--
-- Name: fad_types pk_fad_types; Type: CONSTRAINT; Schema: refs_legacy; Owner: ros-admin
--

ALTER TABLE ONLY refs_legacy.fad_types
    ADD CONSTRAINT pk_fad_types PRIMARY KEY (code);


--
-- Name: isscfg_gear_groups pk_isscfg_gear_groups; Type: CONSTRAINT; Schema: refs_legacy; Owner: ros-admin
--

ALTER TABLE ONLY refs_legacy.isscfg_gear_groups
    ADD CONSTRAINT pk_isscfg_gear_groups PRIMARY KEY (code);


--
-- Name: isscfg_gears pk_isscfg_gears; Type: CONSTRAINT; Schema: refs_legacy; Owner: ros-admin
--

ALTER TABLE ONLY refs_legacy.isscfg_gears
    ADD CONSTRAINT pk_isscfg_gears PRIMARY KEY (code);


--
-- Name: iucn_status pk_iucn_status; Type: CONSTRAINT; Schema: refs_legacy; Owner: ros-admin
--

ALTER TABLE ONLY refs_legacy.iucn_status
    ADD CONSTRAINT pk_iucn_status PRIMARY KEY (code);


--
-- Name: boat_size_class pk_legacy_boat_size_class; Type: CONSTRAINT; Schema: refs_legacy; Owner: ros-admin
--

ALTER TABLE ONLY refs_legacy.boat_size_class
    ADD CONSTRAINT pk_legacy_boat_size_class PRIMARY KEY (code);


--
-- Name: fisheries pk_legacy_fisheries; Type: CONSTRAINT; Schema: refs_legacy; Owner: ros-admin
--

ALTER TABLE ONLY refs_legacy.fisheries
    ADD CONSTRAINT pk_legacy_fisheries PRIMARY KEY (code);


--
-- Name: gear_types pk_legacy_gear_types; Type: CONSTRAINT; Schema: refs_legacy; Owner: ros-admin
--

ALTER TABLE ONLY refs_legacy.gear_types
    ADD CONSTRAINT pk_legacy_gear_types PRIMARY KEY (gear_code, country_code, gear_type_code);


--
-- Name: gears pk_legacy_gears; Type: CONSTRAINT; Schema: refs_legacy; Owner: ros-admin
--

ALTER TABLE ONLY refs_legacy.gears
    ADD CONSTRAINT pk_legacy_gears PRIMARY KEY (code);


--
-- Name: nocs_codes pk_nocs_codes; Type: CONSTRAINT; Schema: refs_legacy; Owner: ros-admin
--

ALTER TABLE ONLY refs_legacy.nocs_codes
    ADD CONSTRAINT pk_nocs_codes PRIMARY KEY (id);


--
-- Name: nocs_names_en pk_nocs_names_en; Type: CONSTRAINT; Schema: refs_legacy; Owner: ros-admin
--

ALTER TABLE ONLY refs_legacy.nocs_names_en
    ADD CONSTRAINT pk_nocs_names_en PRIMARY KEY (id);


--
-- Name: nocs_names_fr pk_nocs_names_fr; Type: CONSTRAINT; Schema: refs_legacy; Owner: ros-admin
--

ALTER TABLE ONLY refs_legacy.nocs_names_fr
    ADD CONSTRAINT pk_nocs_names_fr PRIMARY KEY (id);


--
-- Name: species_to_grsf pk_species_to_grsf; Type: CONSTRAINT; Schema: refs_legacy; Owner: ros-admin
--

ALTER TABLE ONLY refs_legacy.species_to_grsf
    ADD CONSTRAINT pk_species_to_grsf PRIMARY KEY (species_code);


--
-- Name: un_locode_ports pk_un_locode_ports; Type: CONSTRAINT; Schema: refs_legacy; Owner: ros-admin
--

ALTER TABLE ONLY refs_legacy.un_locode_ports
    ADD CONSTRAINT pk_un_locode_ports PRIMARY KEY (code);


--
-- Name: activity_details activity_details_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.activity_details
    ADD CONSTRAINT activity_details_pkey PRIMARY KEY (id);


--
-- Name: additional_details_on_non_target_species additional_details_on_non_target_species_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.additional_details_on_non_target_species
    ADD CONSTRAINT additional_details_on_non_target_species_pkey PRIMARY KEY (id);


--
-- Name: biometric_information biometric_information_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.biometric_information
    ADD CONSTRAINT biometric_information_pkey PRIMARY KEY (id);


--
-- Name: capacities capacities_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.capacities
    ADD CONSTRAINT capacities_pkey PRIMARY KEY (id);


--
-- Name: carrier_vessel_identification carrier_vessel_identification_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.carrier_vessel_identification
    ADD CONSTRAINT carrier_vessel_identification_pkey PRIMARY KEY (id);


--
-- Name: daily_activities daily_activities_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.daily_activities
    ADD CONSTRAINT daily_activities_pkey PRIMARY KEY (id);


--
-- Name: depredation_details depredation_details_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.depredation_details
    ADD CONSTRAINT depredation_details_pkey PRIMARY KEY (id);


--
-- Name: depths depths_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.depths
    ADD CONSTRAINT depths_pkey PRIMARY KEY (id);


--
-- Name: diameters diameters_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.diameters
    ADD CONSTRAINT diameters_pkey PRIMARY KEY (id);


--
-- Name: distances distances_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.distances
    ADD CONSTRAINT distances_pkey PRIMARY KEY (id);


--
-- Name: engines engines_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.engines
    ADD CONSTRAINT engines_pkey PRIMARY KEY (id);


--
-- Name: estimated_weights estimated_weights_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.estimated_weights
    ADD CONSTRAINT estimated_weights_pkey PRIMARY KEY (id);


--
-- Name: general_vessel_and_trip_information general_vessel_and_trip_information_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.general_vessel_and_trip_information
    ADD CONSTRAINT general_vessel_and_trip_information_pkey PRIMARY KEY (id);


--
-- Name: gn_observer_data_properties gn_observer_data_properties_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.gn_observer_data_properties
    ADD CONSTRAINT gn_observer_data_properties_pkey PRIMARY KEY (observer_data_id, property_id);


--
-- Name: gn_observer_data_transhipment_details gn_observer_data_transhipment_details_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.gn_observer_data_transhipment_details
    ADD CONSTRAINT gn_observer_data_transhipment_details_pkey PRIMARY KEY (observer_data_id, transhipment_detail_id);


--
-- Name: heights heights_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.heights
    ADD CONSTRAINT heights_pkey PRIMARY KEY (id);


--
-- Name: iotc_person_contact_details iotc_person_contact_details_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.iotc_person_contact_details
    ADD CONSTRAINT iotc_person_contact_details_pkey PRIMARY KEY (id);


--
-- Name: iotc_person_contact_details iotc_person_contact_details_uid_key; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.iotc_person_contact_details
    ADD CONSTRAINT iotc_person_contact_details_uid_key UNIQUE (uid);


--
-- Name: iotc_person_details iotc_person_details_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.iotc_person_details
    ADD CONSTRAINT iotc_person_details_pkey PRIMARY KEY (id);


--
-- Name: iotc_person_details iotc_person_details_uid_key; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.iotc_person_details
    ADD CONSTRAINT iotc_person_details_uid_key UNIQUE (uid);


--
-- Name: lengths lengths_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.lengths
    ADD CONSTRAINT lengths_pkey PRIMARY KEY (id);


--
-- Name: ll_observer_data_properties ll_observer_data_properties_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.ll_observer_data_properties
    ADD CONSTRAINT ll_observer_data_properties_pkey PRIMARY KEY (observer_data_id, property_id);


--
-- Name: ll_observer_data_transhipment_details ll_observer_data_transhipment_details_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.ll_observer_data_transhipment_details
    ADD CONSTRAINT ll_observer_data_transhipment_details_pkey PRIMARY KEY (observer_data_id, transhipment_detail_id);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: maturity_stages maturity_stages_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.maturity_stages
    ADD CONSTRAINT maturity_stages_pkey PRIMARY KEY (id);


--
-- Name: measured_lengths measured_lengths_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.measured_lengths
    ADD CONSTRAINT measured_lengths_pkey PRIMARY KEY (id);


--
-- Name: measured_weights measured_weights_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.measured_weights
    ADD CONSTRAINT measured_weights_pkey PRIMARY KEY (id);


--
-- Name: observed_trip_summary observed_trip_summary_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.observed_trip_summary
    ADD CONSTRAINT observed_trip_summary_pkey PRIMARY KEY (id);


--
-- Name: observer_identification observer_identification_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.observer_identification
    ADD CONSTRAINT observer_identification_pkey PRIMARY KEY (id);


--
-- Name: observer_identification observer_identification_uid_key; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.observer_identification
    ADD CONSTRAINT observer_identification_uid_key UNIQUE (uid);


--
-- Name: observer_trip_details observer_trip_details_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.observer_trip_details
    ADD CONSTRAINT observer_trip_details_pkey PRIMARY KEY (id);


--
-- Name: person_contact_details person_contact_details_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.person_contact_details
    ADD CONSTRAINT person_contact_details_pkey PRIMARY KEY (id);


--
-- Name: person_details person_details_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.person_details
    ADD CONSTRAINT person_details_pkey PRIMARY KEY (id);


--
-- Name: pl_observer_data_daily_activities pl_observer_data_daily_activities_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.pl_observer_data_daily_activities
    ADD CONSTRAINT pl_observer_data_daily_activities_pkey PRIMARY KEY (observer_data_id, daily_activity_id);


--
-- Name: pl_observer_data_properties pl_observer_data_properties_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.pl_observer_data_properties
    ADD CONSTRAINT pl_observer_data_properties_pkey PRIMARY KEY (observer_data_id, property_id);


--
-- Name: pl_observer_data_transhipment_details pl_observer_data_transhipment_details_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.pl_observer_data_transhipment_details
    ADD CONSTRAINT pl_observer_data_transhipment_details_pkey PRIMARY KEY (observer_data_id, transhipment_detail_id);


--
-- Name: powers powers_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.powers
    ADD CONSTRAINT powers_pkey PRIMARY KEY (id);


--
-- Name: properties properties_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.properties
    ADD CONSTRAINT properties_pkey PRIMARY KEY (id);


--
-- Name: ps_observer_data_daily_activities ps_observer_data_daily_activities_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.ps_observer_data_daily_activities
    ADD CONSTRAINT ps_observer_data_daily_activities_pkey PRIMARY KEY (observer_data_id, daily_activity_id);


--
-- Name: ps_observer_data_properties ps_observer_data_properties_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.ps_observer_data_properties
    ADD CONSTRAINT ps_observer_data_properties_pkey PRIMARY KEY (observer_data_id, property_id);


--
-- Name: ps_observer_data_transhipment_details ps_observer_data_transhipment_details_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.ps_observer_data_transhipment_details
    ADD CONSTRAINT ps_observer_data_transhipment_details_pkey PRIMARY KEY (observer_data_id, transhipment_detail_id);


--
-- Name: ranges ranges_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.ranges
    ADD CONSTRAINT ranges_pkey PRIMARY KEY (id);


--
-- Name: reasons_for_days_lost reasons_for_days_lost_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.reasons_for_days_lost
    ADD CONSTRAINT reasons_for_days_lost_pkey PRIMARY KEY (id);


--
-- Name: sample_collection_details sample_collection_details_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.sample_collection_details
    ADD CONSTRAINT sample_collection_details_pkey PRIMARY KEY (id);


--
-- Name: sampling_details sampling_details_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.sampling_details
    ADD CONSTRAINT sampling_details_pkey PRIMARY KEY (id);


--
-- Name: sizes sizes_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.sizes
    ADD CONSTRAINT sizes_pkey PRIMARY KEY (id);


--
-- Name: species_by_product_type species_by_product_type_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.species_by_product_type
    ADD CONSTRAINT species_by_product_type_pkey PRIMARY KEY (id);


--
-- Name: texts texts_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.texts
    ADD CONSTRAINT texts_pkey PRIMARY KEY (id);


--
-- Name: thicknesses thicknesses_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.thicknesses
    ADD CONSTRAINT thicknesses_pkey PRIMARY KEY (id);


--
-- Name: tonnages tonnages_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.tonnages
    ADD CONSTRAINT tonnages_pkey PRIMARY KEY (id);


--
-- Name: transhipment_details transhipment_details_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.transhipment_details
    ADD CONSTRAINT transhipment_details_pkey PRIMARY KEY (id);


--
-- Name: transhipment_details_product_transhipped transhipment_details_product_transhipped_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.transhipment_details_product_transhipped
    ADD CONSTRAINT transhipment_details_product_transhipped_pkey PRIMARY KEY (transhipment_detail_id, species_by_product_id);


--
-- Name: vessel_attributes_main_engines vessel_attributes_main_engines_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_attributes_main_engines
    ADD CONSTRAINT vessel_attributes_main_engines_pkey PRIMARY KEY (vessel_attributes_id_me, main_engine_id);


--
-- Name: vessel_attributes vessel_attributes_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_attributes
    ADD CONSTRAINT vessel_attributes_pkey PRIMARY KEY (id);


--
-- Name: vessel_electronics vessel_electronics_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_electronics
    ADD CONSTRAINT vessel_electronics_pkey PRIMARY KEY (id);


--
-- Name: vessel_identification_email vessel_identification_email_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_identification_email
    ADD CONSTRAINT vessel_identification_email_pkey PRIMARY KEY (vessel_identification_id_em, email_id);


--
-- Name: vessel_identification_fax vessel_identification_fax_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_identification_fax
    ADD CONSTRAINT vessel_identification_fax_pkey PRIMARY KEY (vessel_identification_id_fa, fax_id);


--
-- Name: vessel_identification_phone vessel_identification_phone_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_identification_phone
    ADD CONSTRAINT vessel_identification_phone_pkey PRIMARY KEY (vessel_identification_id_ph, phone_id);


--
-- Name: vessel_identification vessel_identification_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_identification
    ADD CONSTRAINT vessel_identification_pkey PRIMARY KEY (id);


--
-- Name: vessel_owner_and_personnel vessel_owner_and_personnel_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_owner_and_personnel
    ADD CONSTRAINT vessel_owner_and_personnel_pkey PRIMARY KEY (id);


--
-- Name: vessel_trip_details vessel_trip_details_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_trip_details
    ADD CONSTRAINT vessel_trip_details_pkey PRIMARY KEY (id);


--
-- Name: waste_managements waste_managements_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.waste_managements
    ADD CONSTRAINT waste_managements_pkey PRIMARY KEY (id);


--
-- Name: weights weights_pkey; Type: CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.weights
    ADD CONSTRAINT weights_pkey PRIMARY KEY (id);


--
-- Name: gillnet_configuration gillnet_configuration_pkey; Type: CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gillnet_configuration
    ADD CONSTRAINT gillnet_configuration_pkey PRIMARY KEY (id);


--
-- Name: gn_additional_catch_details_on_ssi gn_additional_catch_details_on_ssi_pkey; Type: CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_additional_catch_details_on_ssi
    ADD CONSTRAINT gn_additional_catch_details_on_ssi_pkey PRIMARY KEY (id);


--
-- Name: gn_catch_details gn_catch_details_pkey; Type: CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_catch_details
    ADD CONSTRAINT gn_catch_details_pkey PRIMARY KEY (id);


--
-- Name: gn_fishing_events gn_fishing_events_pkey; Type: CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_fishing_events
    ADD CONSTRAINT gn_fishing_events_pkey PRIMARY KEY (id);


--
-- Name: gn_gear_specifications gn_gear_specifications_pkey; Type: CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_gear_specifications
    ADD CONSTRAINT gn_gear_specifications_pkey PRIMARY KEY (id);


--
-- Name: gn_gillnet_configuration_stretched_mesh_sizes gn_gillnet_configuration_stretched_mesh_sizes_pkey; Type: CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_gillnet_configuration_stretched_mesh_sizes
    ADD CONSTRAINT gn_gillnet_configuration_stretched_mesh_sizes_pkey PRIMARY KEY (gn_gillnet_configuration_id_sms, stretched_mesh_size_id);


--
-- Name: gn_hauling_operations gn_hauling_operations_pkey; Type: CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_hauling_operations
    ADD CONSTRAINT gn_hauling_operations_pkey PRIMARY KEY (id);


--
-- Name: gn_mitigation_measures gn_mitigation_measures_pkey; Type: CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_mitigation_measures
    ADD CONSTRAINT gn_mitigation_measures_pkey PRIMARY KEY (id);


--
-- Name: gn_observer_data gn_observer_data_pkey; Type: CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_observer_data
    ADD CONSTRAINT gn_observer_data_pkey PRIMARY KEY (id);


--
-- Name: gn_observer_data gn_observer_data_uid_key; Type: CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_observer_data
    ADD CONSTRAINT gn_observer_data_uid_key UNIQUE (uid);


--
-- Name: gn_setting_operations gn_setting_operations_pkey; Type: CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_setting_operations
    ADD CONSTRAINT gn_setting_operations_pkey PRIMARY KEY (id);


--
-- Name: gn_special_equipment gn_special_equipment_pkey; Type: CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_special_equipment
    ADD CONSTRAINT gn_special_equipment_pkey PRIMARY KEY (id);


--
-- Name: gn_specimens gn_specimens_pkey; Type: CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_specimens
    ADD CONSTRAINT gn_specimens_pkey PRIMARY KEY (id);


--
-- Name: gn_tag_details gn_tag_details_pkey; Type: CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_tag_details
    ADD CONSTRAINT gn_tag_details_pkey PRIMARY KEY (id);


--
-- Name: sinkers_by_type sinkers_by_type_pkey; Type: CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.sinkers_by_type
    ADD CONSTRAINT sinkers_by_type_pkey PRIMARY KEY (id);


--
-- Name: baits_by_conditions baits_by_conditions_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.baits_by_conditions
    ADD CONSTRAINT baits_by_conditions_pkey PRIMARY KEY (id);


--
-- Name: biteoffs_by_branchlines_set biteoffs_by_branchlines_set_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.biteoffs_by_branchlines_set
    ADD CONSTRAINT biteoffs_by_branchlines_set_pkey PRIMARY KEY (id);


--
-- Name: branchline_configurations branchline_configurations_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.branchline_configurations
    ADD CONSTRAINT branchline_configurations_pkey PRIMARY KEY (id);


--
-- Name: branchline_sections branchline_sections_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.branchline_sections
    ADD CONSTRAINT branchline_sections_pkey PRIMARY KEY (id);


--
-- Name: branchlines_set branchlines_set_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.branchlines_set
    ADD CONSTRAINT branchlines_set_pkey PRIMARY KEY (id);


--
-- Name: floatlines floatlines_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.floatlines
    ADD CONSTRAINT floatlines_pkey PRIMARY KEY (id);


--
-- Name: hooks_by_type hooks_by_type_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.hooks_by_type
    ADD CONSTRAINT hooks_by_type_pkey PRIMARY KEY (id);


--
-- Name: lights_by_type_and_colour lights_by_type_and_colour_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.lights_by_type_and_colour
    ADD CONSTRAINT lights_by_type_and_colour_pkey PRIMARY KEY (id);


--
-- Name: ll_additional_catch_details_on_ssi ll_additional_catch_details_on_ssi_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_additional_catch_details_on_ssi
    ADD CONSTRAINT ll_additional_catch_details_on_ssi_pkey PRIMARY KEY (id);


--
-- Name: ll_catch_details ll_catch_details_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_catch_details
    ADD CONSTRAINT ll_catch_details_pkey PRIMARY KEY (id);


--
-- Name: ll_fishing_events ll_fishing_events_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_fishing_events
    ADD CONSTRAINT ll_fishing_events_pkey PRIMARY KEY (id);


--
-- Name: ll_gear_specifications ll_gear_specifications_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_gear_specifications
    ADD CONSTRAINT ll_gear_specifications_pkey PRIMARY KEY (id);


--
-- Name: ll_general_gear_attributes ll_general_gear_attributes_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_general_gear_attributes
    ADD CONSTRAINT ll_general_gear_attributes_pkey PRIMARY KEY (id);


--
-- Name: ll_hauling_operations ll_hauling_operations_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_hauling_operations
    ADD CONSTRAINT ll_hauling_operations_pkey PRIMARY KEY (id);


--
-- Name: ll_mitigation_measures ll_mitigation_measures_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_mitigation_measures
    ADD CONSTRAINT ll_mitigation_measures_pkey PRIMARY KEY (id);


--
-- Name: ll_observer_data ll_observer_data_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_observer_data
    ADD CONSTRAINT ll_observer_data_pkey PRIMARY KEY (id);


--
-- Name: ll_observer_data ll_observer_data_uid_key; Type: CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_observer_data
    ADD CONSTRAINT ll_observer_data_uid_key UNIQUE (uid);


--
-- Name: ll_setting_operations ll_setting_operations_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_setting_operations
    ADD CONSTRAINT ll_setting_operations_pkey PRIMARY KEY (id);


--
-- Name: ll_special_equipment ll_special_equipment_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_special_equipment
    ADD CONSTRAINT ll_special_equipment_pkey PRIMARY KEY (id);


--
-- Name: ll_specimens ll_specimens_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_specimens
    ADD CONSTRAINT ll_specimens_pkey PRIMARY KEY (id);


--
-- Name: ll_tag_details ll_tag_details_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_tag_details
    ADD CONSTRAINT ll_tag_details_pkey PRIMARY KEY (id);


--
-- Name: tori_line_details tori_line_details_pkey; Type: CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.tori_line_details
    ADD CONSTRAINT tori_line_details_pkey PRIMARY KEY (id);


--
-- Name: ros_focal_points pk_ros_focal_points_1; Type: CONSTRAINT; Schema: ros_meta; Owner: ros-admin
--

ALTER TABLE ONLY ros_meta.ros_focal_points
    ADD CONSTRAINT pk_ros_focal_points_1 PRIMARY KEY (iotc_username);


--
-- Name: ros_focal_points_logins pk_ros_focal_points_logins; Type: CONSTRAINT; Schema: ros_meta; Owner: ros-admin
--

ALTER TABLE ONLY ros_meta.ros_focal_points_logins
    ADD CONSTRAINT pk_ros_focal_points_logins PRIMARY KEY (id);


--
-- Name: ros_observers pk_ros_observers_1; Type: CONSTRAINT; Schema: ros_meta; Owner: ros-admin
--

ALTER TABLE ONLY ros_meta.ros_observers
    ADD CONSTRAINT pk_ros_observers_1 PRIMARY KEY (iotc_number);


--
-- Name: ros_observers_logins pk_ros_observers_logins; Type: CONSTRAINT; Schema: ros_meta; Owner: ros-admin
--

ALTER TABLE ONLY ros_meta.ros_observers_logins
    ADD CONSTRAINT pk_ros_observers_logins PRIMARY KEY (id);


--
-- Name: ros_user_requests pk_ros_user_requests; Type: CONSTRAINT; Schema: ros_meta; Owner: ros-admin
--

ALTER TABLE ONLY ros_meta.ros_user_requests
    ADD CONSTRAINT pk_ros_user_requests PRIMARY KEY (id);


--
-- Name: bait_fishing_events bait_fishing_events_pkey; Type: CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.bait_fishing_events
    ADD CONSTRAINT bait_fishing_events_pkey PRIMARY KEY (id);


--
-- Name: bait_fishing_operations bait_fishing_operations_pkey; Type: CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.bait_fishing_operations
    ADD CONSTRAINT bait_fishing_operations_pkey PRIMARY KEY (id);


--
-- Name: baits_and_conditions baits_and_conditions_pkey; Type: CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.baits_and_conditions
    ADD CONSTRAINT baits_and_conditions_pkey PRIMARY KEY (id);


--
-- Name: lures_or_jiggers_by_type lures_or_jiggers_by_type_pkey; Type: CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.lures_or_jiggers_by_type
    ADD CONSTRAINT lures_or_jiggers_by_type_pkey PRIMARY KEY (id);


--
-- Name: pl_additional_catch_details_on_ssi pl_additional_catch_details_on_ssi_pkey; Type: CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_additional_catch_details_on_ssi
    ADD CONSTRAINT pl_additional_catch_details_on_ssi_pkey PRIMARY KEY (id);


--
-- Name: pl_bait_fishing_event_pl_catch_detail pl_bait_fishing_event_pl_catch_detail_pkey; Type: CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_bait_fishing_event_pl_catch_detail
    ADD CONSTRAINT pl_bait_fishing_event_pl_catch_detail_pkey PRIMARY KEY (pl_bait_fishing_event_id, pl_catch_detail_id);


--
-- Name: pl_catch_details pl_catch_details_pkey; Type: CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_catch_details
    ADD CONSTRAINT pl_catch_details_pkey PRIMARY KEY (id);


--
-- Name: pl_gear_specifications pl_gear_specifications_pkey; Type: CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_gear_specifications
    ADD CONSTRAINT pl_gear_specifications_pkey PRIMARY KEY (id);


--
-- Name: pl_general_gear_attributes pl_general_gear_attributes_pkey; Type: CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_general_gear_attributes
    ADD CONSTRAINT pl_general_gear_attributes_pkey PRIMARY KEY (id);


--
-- Name: pl_object_details pl_object_details_pkey; Type: CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_object_details
    ADD CONSTRAINT pl_object_details_pkey PRIMARY KEY (id);


--
-- Name: pl_observer_data pl_observer_data_pkey; Type: CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_observer_data
    ADD CONSTRAINT pl_observer_data_pkey PRIMARY KEY (id);


--
-- Name: pl_observer_data pl_observer_data_uid_key; Type: CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_observer_data
    ADD CONSTRAINT pl_observer_data_uid_key UNIQUE (uid);


--
-- Name: pl_special_equipment pl_special_equipment_pkey; Type: CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_special_equipment
    ADD CONSTRAINT pl_special_equipment_pkey PRIMARY KEY (id);


--
-- Name: pl_specimens pl_specimens_pkey; Type: CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_specimens
    ADD CONSTRAINT pl_specimens_pkey PRIMARY KEY (id);


--
-- Name: pl_tag_details pl_tag_details_pkey; Type: CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_tag_details
    ADD CONSTRAINT pl_tag_details_pkey PRIMARY KEY (id);


--
-- Name: pl_tuna_fishing_event_pl_catch_detail pl_tuna_fishing_event_pl_catch_detail_pkey; Type: CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_tuna_fishing_event_pl_catch_detail
    ADD CONSTRAINT pl_tuna_fishing_event_pl_catch_detail_pkey PRIMARY KEY (pl_tuna_fishing_event_id, pl_catch_detail_id);


--
-- Name: pl_tuna_fishing_operations pl_tuna_fishing_operations_pkey; Type: CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_tuna_fishing_operations
    ADD CONSTRAINT pl_tuna_fishing_operations_pkey PRIMARY KEY (id);


--
-- Name: tuna_fishing_events tuna_fishing_events_pkey; Type: CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.tuna_fishing_events
    ADD CONSTRAINT tuna_fishing_events_pkey PRIMARY KEY (id);


--
-- Name: cetaceans_whale_shark_sightings cetaceans_whale_shark_sightings_pkey; Type: CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.cetaceans_whale_shark_sightings
    ADD CONSTRAINT cetaceans_whale_shark_sightings_pkey PRIMARY KEY (id);


--
-- Name: current_details current_details_pkey; Type: CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.current_details
    ADD CONSTRAINT current_details_pkey PRIMARY KEY (id);


--
-- Name: ps_additional_catch_details_on_ssi ps_additional_catch_details_on_ssi_pkey; Type: CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_additional_catch_details_on_ssi
    ADD CONSTRAINT ps_additional_catch_details_on_ssi_pkey PRIMARY KEY (id);


--
-- Name: ps_catch_details ps_catch_details_pkey; Type: CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_catch_details
    ADD CONSTRAINT ps_catch_details_pkey PRIMARY KEY (id);


--
-- Name: ps_fishing_events ps_fishing_events_pkey; Type: CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_fishing_events
    ADD CONSTRAINT ps_fishing_events_pkey PRIMARY KEY (id);


--
-- Name: ps_gear_specifications ps_gear_specifications_pkey; Type: CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_gear_specifications
    ADD CONSTRAINT ps_gear_specifications_pkey PRIMARY KEY (id);


--
-- Name: ps_general_gear_attributes ps_general_gear_attributes_pkey; Type: CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_general_gear_attributes
    ADD CONSTRAINT ps_general_gear_attributes_pkey PRIMARY KEY (id);


--
-- Name: ps_object_details ps_object_details_pkey; Type: CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_object_details
    ADD CONSTRAINT ps_object_details_pkey PRIMARY KEY (id);


--
-- Name: ps_observer_data ps_observer_data_pkey; Type: CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_observer_data
    ADD CONSTRAINT ps_observer_data_pkey PRIMARY KEY (id);


--
-- Name: ps_observer_data ps_observer_data_uid_key; Type: CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_observer_data
    ADD CONSTRAINT ps_observer_data_uid_key UNIQUE (uid);


--
-- Name: ps_setting_operations ps_setting_operations_pkey; Type: CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_setting_operations
    ADD CONSTRAINT ps_setting_operations_pkey PRIMARY KEY (id);


--
-- Name: ps_special_equipment ps_special_equipment_pkey; Type: CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_special_equipment
    ADD CONSTRAINT ps_special_equipment_pkey PRIMARY KEY (id);


--
-- Name: ps_specimens ps_specimens_pkey; Type: CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_specimens
    ADD CONSTRAINT ps_specimens_pkey PRIMARY KEY (id);


--
-- Name: ps_tag_details ps_tag_details_pkey; Type: CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_tag_details
    ADD CONSTRAINT ps_tag_details_pkey PRIMARY KEY (id);


--
-- Name: support_vessel_details support_vessel_details_pkey; Type: CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.support_vessel_details
    ADD CONSTRAINT support_vessel_details_pkey PRIMARY KEY (id);


--
-- Name: ix_countries_iso2; Type: INDEX; Schema: refs_admin; Owner: ros-admin
--

CREATE INDEX ix_countries_iso2 ON refs_admin.countries USING btree (code_iso2);


--
-- Name: ix_countries_iso3; Type: INDEX; Schema: refs_admin; Owner: ros-admin
--

CREATE INDEX ix_countries_iso3 ON refs_admin.countries USING btree (code_iso3);


--
-- Name: ix_cpc_history_uq; Type: INDEX; Schema: refs_admin; Owner: ros-admin
--

CREATE INDEX ix_cpc_history_uq ON refs_admin.cpc_history USING btree (cpc_code, contracting_party, acceptance_date);


--
-- Name: ix_cpc_history_uq2; Type: INDEX; Schema: refs_admin; Owner: ros-admin
--

CREATE INDEX ix_cpc_history_uq2 ON refs_admin.cpc_history USING btree (cpc_code, acceptance_date);


--
-- Name: ix_fleet_to_flags_and_fisheries; Type: INDEX; Schema: refs_admin; Owner: ros-admin
--

CREATE INDEX ix_fleet_to_flags_and_fisheries ON refs_admin.fleet_to_flags_and_fisheries USING btree (flag_code, reporting_entity_code, iotc_main_area_code, fishery_type_code, gear_category_code, gear_code, gear_configuration_code, fishing_mode_code, target_species_code, from_year, to_year);


--
-- Name: refs_admin_ports_point_idx; Type: INDEX; Schema: refs_admin; Owner: ros-admin
--

CREATE INDEX refs_admin_ports_point_idx ON refs_admin.ports USING gist (point);


--
-- Name: ix_fisheries_uq; Type: INDEX; Schema: refs_fishery; Owner: ros-admin
--

CREATE INDEX ix_fisheries_uq ON refs_fishery.fisheries USING btree (fishery_category_code, fishery_type_code, gear_code, gear_configuration_code, fishing_mode_code, target_species_code);


--
-- Name: nc_idx_code; Type: INDEX; Schema: refs_gis; Owner: ros-admin
--

CREATE INDEX nc_idx_code ON refs_gis.areas USING btree (code);


--
-- Name: nc_idx_code_fishing_ground_type_code; Type: INDEX; Schema: refs_gis; Owner: ros-admin
--

CREATE INDEX nc_idx_code_fishing_ground_type_code ON refs_gis.areas USING btree (code, area_type_code);


--
-- Name: nc_idx_fishing_ground_type_code; Type: INDEX; Schema: refs_gis; Owner: ros-admin
--

CREATE INDEX nc_idx_fishing_ground_type_code ON refs_gis.areas USING btree (area_type_code);


--
-- Name: nc_idx_land_area; Type: INDEX; Schema: refs_gis; Owner: ros-admin
--

CREATE INDEX nc_idx_land_area ON refs_gis.areas USING btree (land_area_km2);


--
-- Name: nc_idx_ocean_area; Type: INDEX; Schema: refs_gis; Owner: ros-admin
--

CREATE INDEX nc_idx_ocean_area ON refs_gis.areas USING btree (ocean_area_km2);


--
-- Name: nc_idx_ocean_area_io; Type: INDEX; Schema: refs_gis; Owner: ros-admin
--

CREATE INDEX nc_idx_ocean_area_io ON refs_gis.areas USING btree (ocean_area_io_km2);


--
-- Name: nc_idx_ocean_area_iotc; Type: INDEX; Schema: refs_gis; Owner: ros-admin
--

CREATE INDEX nc_idx_ocean_area_iotc ON refs_gis.areas USING btree (ocean_area_iotc_km2);


--
-- Name: nc_idx_source_code; Type: INDEX; Schema: refs_gis; Owner: ros-admin
--

CREATE INDEX nc_idx_source_code ON refs_gis.area_intersections USING btree (source_code);


--
-- Name: nc_idx_source_target_code; Type: INDEX; Schema: refs_gis; Owner: ros-admin
--

CREATE INDEX nc_idx_source_target_code ON refs_gis.area_intersections USING btree (source_code, target_code);


--
-- Name: nc_idx_target_code; Type: INDEX; Schema: refs_gis; Owner: ros-admin
--

CREATE INDEX nc_idx_target_code ON refs_gis.area_intersections USING btree (target_code);


--
-- Name: refs_gis_areas_area_geometry_idx; Type: INDEX; Schema: refs_gis; Owner: ros-admin
--

CREATE INDEX refs_gis_areas_area_geometry_idx ON refs_gis.areas USING gist (area_geometry);


--
-- Name: refs_gis_areas_area_geometry_old_idx; Type: INDEX; Schema: refs_gis; Owner: ros-admin
--

CREATE INDEX refs_gis_areas_area_geometry_old_idx ON refs_gis.areas USING gist (area_geometry_old);


--
-- Name: ix_species_to_grsf_firms_id; Type: INDEX; Schema: refs_legacy; Owner: ros-admin
--

CREATE INDEX ix_species_to_grsf_firms_id ON refs_legacy.species_to_grsf USING btree (species_code);


--
-- Name: ix_species_to_grsf_semantic_id; Type: INDEX; Schema: refs_legacy; Owner: ros-admin
--

CREATE INDEX ix_species_to_grsf_semantic_id ON refs_legacy.species_to_grsf USING btree (species_code);


--
-- Name: ix_species_to_grsf_uuid; Type: INDEX; Schema: refs_legacy; Owner: ros-admin
--

CREATE INDEX ix_species_to_grsf_uuid ON refs_legacy.species_to_grsf USING btree (species_code);


--
-- Name: ix_uq_country_port_codes; Type: INDEX; Schema: refs_legacy; Owner: ros-admin
--

CREATE INDEX ix_uq_country_port_codes ON refs_legacy.un_locode_ports USING btree (country_code, port_code);


--
-- Name: index_activity_details_daily_activity_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_activity_details_daily_activity_id ON ros_common.activity_details USING btree (daily_activity_id);


--
-- Name: index_biometric_information_alternative_measured_length_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_biometric_information_alternative_measured_length_id ON ros_common.biometric_information USING btree (alternative_measured_length_id);


--
-- Name: index_biometric_information_estimated_weight_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_biometric_information_estimated_weight_id ON ros_common.biometric_information USING btree (estimated_weight_id);


--
-- Name: index_biometric_information_maturity_stage_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_biometric_information_maturity_stage_id ON ros_common.biometric_information USING btree (maturity_stage_id);


--
-- Name: index_biometric_information_measured_length_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_biometric_information_measured_length_id ON ros_common.biometric_information USING btree (measured_length_id);


--
-- Name: index_biometric_information_sample_collection_detail_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_biometric_information_sample_collection_detail_id ON ros_common.biometric_information USING btree (sample_collection_detail_id);


--
-- Name: index_general_vessel_and_trip_information_vessel_attributes_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_general_vessel_and_trip_information_vessel_attributes_id ON ros_common.general_vessel_and_trip_information USING btree (vessel_attributes_id);


--
-- Name: index_general_vessel_and_trip_information_vessel_electronics_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_general_vessel_and_trip_information_vessel_electronics_id ON ros_common.general_vessel_and_trip_information USING btree (vessel_electronics_id);


--
-- Name: index_general_vessel_and_trip_information_vessel_trip_detail_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_general_vessel_and_trip_information_vessel_trip_detail_id ON ros_common.general_vessel_and_trip_information USING btree (vessel_trip_details_id);


--
-- Name: index_gn_observer_data_transhipment_details_observer_data_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_gn_observer_data_transhipment_details_observer_data_id ON ros_common.gn_observer_data_transhipment_details USING btree (observer_data_id);


--
-- Name: index_gn_odt_details_transhipment_detail_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_gn_odt_details_transhipment_detail_id ON ros_common.gn_observer_data_transhipment_details USING btree (transhipment_detail_id);


--
-- Name: index_gvat_information_observed_trip_summary_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_gvat_information_observed_trip_summary_id ON ros_common.general_vessel_and_trip_information USING btree (observed_trip_summary_id);


--
-- Name: index_gvat_information_observer_identification_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_gvat_information_observer_identification_id ON ros_common.general_vessel_and_trip_information USING btree (observer_identification_id);


--
-- Name: index_gvat_information_observer_trip_detail_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_gvat_information_observer_trip_detail_id ON ros_common.general_vessel_and_trip_information USING btree (observer_trip_detail_id);


--
-- Name: index_gvat_information_vessel_identification_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_gvat_information_vessel_identification_id ON ros_common.general_vessel_and_trip_information USING btree (vessel_identification_id);


--
-- Name: index_gvat_information_vessel_owner_and_personnel_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_gvat_information_vessel_owner_and_personnel_id ON ros_common.general_vessel_and_trip_information USING btree (vessel_owner_and_personnel_id);


--
-- Name: index_ll_observer_data_transhipment_details_observer_data_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_ll_observer_data_transhipment_details_observer_data_id ON ros_common.ll_observer_data_transhipment_details USING btree (observer_data_id);


--
-- Name: index_ll_odt_details_transhipment_detail_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_ll_odt_details_transhipment_detail_id ON ros_common.ll_observer_data_transhipment_details USING btree (transhipment_detail_id);


--
-- Name: index_observer_trip_details_disembarkation_location_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_observer_trip_details_disembarkation_location_id ON ros_common.observer_trip_details USING btree (disembarkation_location_id);


--
-- Name: index_observer_trip_details_embarkation_location_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_observer_trip_details_embarkation_location_id ON ros_common.observer_trip_details USING btree (embarkation_location_id);


--
-- Name: index_pl_observer_data_transhipment_details_observer_data_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_pl_observer_data_transhipment_details_observer_data_id ON ros_common.pl_observer_data_transhipment_details USING btree (observer_data_id);


--
-- Name: index_pl_observer_data_transhipment_pl_transhipment_detail_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_pl_observer_data_transhipment_pl_transhipment_detail_id ON ros_common.pl_observer_data_transhipment_details USING btree (transhipment_detail_id);


--
-- Name: index_ps_observer_data_transhipment_details_observer_data_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_ps_observer_data_transhipment_details_observer_data_id ON ros_common.ps_observer_data_transhipment_details USING btree (observer_data_id);


--
-- Name: index_ps_observer_data_transhipment_ps_transhipment_detail_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_ps_observer_data_transhipment_ps_transhipment_detail_id ON ros_common.ps_observer_data_transhipment_details USING btree (transhipment_detail_id);


--
-- Name: index_reasons_for_days_lost_observed_trip_summary_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_reasons_for_days_lost_observed_trip_summary_id ON ros_common.reasons_for_days_lost USING btree (observed_trip_summary_id);


--
-- Name: index_transhipment_details_carrier_vessel_identification_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_transhipment_details_carrier_vessel_identification_id ON ros_common.transhipment_details USING btree (carrier_vessel_identification_id);


--
-- Name: index_transhipment_details_product_detail_id_sby_product_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_transhipment_details_product_detail_id_sby_product_id ON ros_common.transhipment_details_product_transhipped USING btree (transhipment_detail_id, species_by_product_id);


--
-- Name: index_vessel_attributes_autonomy_range_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_vessel_attributes_autonomy_range_id ON ros_common.vessel_attributes USING btree (autonomy_range_id);


--
-- Name: index_vessel_attributes_fish_storage_capacity_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_vessel_attributes_fish_storage_capacity_id ON ros_common.vessel_attributes USING btree (fish_storage_capacity_id);


--
-- Name: index_vessel_attributes_loa_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_vessel_attributes_loa_id ON ros_common.vessel_attributes USING btree (loa_id);


--
-- Name: index_vessel_attributes_tonnage_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_vessel_attributes_tonnage_id ON ros_common.vessel_attributes USING btree (tonnage_id);


--
-- Name: index_vessel_owner_and_personnel_charter_or_operator_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_vessel_owner_and_personnel_charter_or_operator_id ON ros_common.vessel_owner_and_personnel USING btree (charter_or_operator_id);


--
-- Name: index_vessel_owner_and_personnel_fishing_master_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_vessel_owner_and_personnel_fishing_master_id ON ros_common.vessel_owner_and_personnel USING btree (fishing_master_id);


--
-- Name: index_vessel_owner_and_personnel_registered_vessel_owner_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_vessel_owner_and_personnel_registered_vessel_owner_id ON ros_common.vessel_owner_and_personnel USING btree (registered_vessel_owner_id);


--
-- Name: index_vessel_owner_and_personnel_skipper_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_vessel_owner_and_personnel_skipper_id ON ros_common.vessel_owner_and_personnel USING btree (skipper_id);


--
-- Name: index_waste_managements_general_vessel_and_trip_information_id; Type: INDEX; Schema: ros_common; Owner: ros-admin
--

CREATE INDEX index_waste_managements_general_vessel_and_trip_information_id ON ros_common.waste_managements USING btree (general_vessel_and_trip_information_id);


--
-- Name: index_gillnet_configuration_distance_between_floats_id; Type: INDEX; Schema: ros_gn; Owner: ros-admin
--

CREATE INDEX index_gillnet_configuration_distance_between_floats_id ON ros_gn.gillnet_configuration USING btree (distance_between_floats_id);


--
-- Name: index_gillnet_configuration_droplines_length_id; Type: INDEX; Schema: ros_gn; Owner: ros-admin
--

CREATE INDEX index_gillnet_configuration_droplines_length_id ON ros_gn.gillnet_configuration USING btree (droplines_length_id);


--
-- Name: index_gillnet_configuration_gillnet_configuration_id; Type: INDEX; Schema: ros_gn; Owner: ros-admin
--

CREATE INDEX index_gillnet_configuration_gillnet_configuration_id ON ros_gn.gillnet_configuration USING btree (gillnet_configuration_id);


--
-- Name: index_gillnet_configuration_net_depth_id; Type: INDEX; Schema: ros_gn; Owner: ros-admin
--

CREATE INDEX index_gillnet_configuration_net_depth_id ON ros_gn.gillnet_configuration USING btree (net_depth_id);


--
-- Name: index_gillnet_configuration_net_length_id; Type: INDEX; Schema: ros_gn; Owner: ros-admin
--

CREATE INDEX index_gillnet_configuration_net_length_id ON ros_gn.gillnet_configuration USING btree (net_length_id);


--
-- Name: index_gn_catch_details_gn_fishing_event_id; Type: INDEX; Schema: ros_gn; Owner: ros-admin
--

CREATE INDEX index_gn_catch_details_gn_fishing_event_id ON ros_gn.gn_catch_details USING btree (gn_fishing_event_id);


--
-- Name: index_gn_catch_details_identified_estimated_weight_id; Type: INDEX; Schema: ros_gn; Owner: ros-admin
--

CREATE INDEX index_gn_catch_details_identified_estimated_weight_id ON ros_gn.gn_catch_details USING btree (estimated_weight_id);


--
-- Name: index_gn_fishing_events_gn_hauling_operation_id; Type: INDEX; Schema: ros_gn; Owner: ros-admin
--

CREATE INDEX index_gn_fishing_events_gn_hauling_operation_id ON ros_gn.gn_fishing_events USING btree (gn_hauling_operation_id);


--
-- Name: index_gn_fishing_events_gn_mitigation_measure_id; Type: INDEX; Schema: ros_gn; Owner: ros-admin
--

CREATE INDEX index_gn_fishing_events_gn_mitigation_measure_id ON ros_gn.gn_fishing_events USING btree (gn_mitigation_measure_id);


--
-- Name: index_gn_fishing_events_gn_observer_data_id; Type: INDEX; Schema: ros_gn; Owner: ros-admin
--

CREATE INDEX index_gn_fishing_events_gn_observer_data_id ON ros_gn.gn_fishing_events USING btree (gn_observer_data_id);


--
-- Name: index_gn_fishing_events_gn_setting_operation_id; Type: INDEX; Schema: ros_gn; Owner: ros-admin
--

CREATE INDEX index_gn_fishing_events_gn_setting_operation_id ON ros_gn.gn_fishing_events USING btree (gn_setting_operation_id);


--
-- Name: index_gn_gear_specifications_gn_special_equipment_id; Type: INDEX; Schema: ros_gn; Owner: ros-admin
--

CREATE INDEX index_gn_gear_specifications_gn_special_equipment_id ON ros_gn.gn_gear_specifications USING btree (gn_special_equipment_id);


--
-- Name: index_gn_gillnet_configuration_stretched_mesh_sizes_id; Type: INDEX; Schema: ros_gn; Owner: ros-admin
--

CREATE INDEX index_gn_gillnet_configuration_stretched_mesh_sizes_id ON ros_gn.gn_gillnet_configuration_stretched_mesh_sizes USING btree (gn_gillnet_configuration_id_sms, stretched_mesh_size_id);


--
-- Name: index_gn_observer_data_creator_id; Type: INDEX; Schema: ros_gn; Owner: ros-admin
--

CREATE INDEX index_gn_observer_data_creator_id ON ros_gn.gn_observer_data USING btree (creator_id);


--
-- Name: index_gn_observer_data_gn_gear_specifications_id; Type: INDEX; Schema: ros_gn; Owner: ros-admin
--

CREATE INDEX index_gn_observer_data_gn_gear_specifications_id ON ros_gn.gn_observer_data USING btree (gn_gear_specifications_id);


--
-- Name: index_gn_observer_data_submitter_id; Type: INDEX; Schema: ros_gn; Owner: ros-admin
--

CREATE INDEX index_gn_observer_data_submitter_id ON ros_gn.gn_observer_data USING btree (submitter_id);


--
-- Name: index_gn_observer_data_vessel_and_trip_information_id; Type: INDEX; Schema: ros_gn; Owner: ros-admin
--

CREATE INDEX index_gn_observer_data_vessel_and_trip_information_id ON ros_gn.gn_observer_data USING btree (vessel_and_trip_information_id);


--
-- Name: index_gn_specimens_additional_non_target_species_id; Type: INDEX; Schema: ros_gn; Owner: ros-admin
--

CREATE INDEX index_gn_specimens_additional_non_target_species_id ON ros_gn.gn_specimens USING btree (additional_specimen_details_non_target_species_id);


--
-- Name: index_gn_specimens_biometric_information_id; Type: INDEX; Schema: ros_gn; Owner: ros-admin
--

CREATE INDEX index_gn_specimens_biometric_information_id ON ros_gn.gn_specimens USING btree (biometric_information_id);


--
-- Name: index_gn_specimens_gn_additional_catch_details_on_ssis_id; Type: INDEX; Schema: ros_gn; Owner: ros-admin
--

CREATE INDEX index_gn_specimens_gn_additional_catch_details_on_ssis_id ON ros_gn.gn_specimens USING btree (gn_additional_catch_details_on_ssis_id);


--
-- Name: index_gn_specimens_gn_depredation_detail_id; Type: INDEX; Schema: ros_gn; Owner: ros-admin
--

CREATE INDEX index_gn_specimens_gn_depredation_detail_id ON ros_gn.gn_specimens USING btree (gn_depredation_detail_id);


--
-- Name: index_gn_specimens_gn_tag_detail_id; Type: INDEX; Schema: ros_gn; Owner: ros-admin
--

CREATE INDEX index_gn_specimens_gn_tag_detail_id ON ros_gn.gn_specimens USING btree (gn_tag_detail_id);


--
-- Name: index_gn_tag_details_tag_finder_id; Type: INDEX; Schema: ros_gn; Owner: ros-admin
--

CREATE INDEX index_gn_tag_details_tag_finder_id ON ros_gn.gn_tag_details USING btree (tag_finder_id);


--
-- Name: index_sinkers_by_type_average_sinker_weight_id; Type: INDEX; Schema: ros_gn; Owner: ros-admin
--

CREATE INDEX index_sinkers_by_type_average_sinker_weight_id ON ros_gn.sinkers_by_type USING btree (average_sinker_weight_id);


--
-- Name: index_sinkers_by_type_gn_gillnet_configuration_id; Type: INDEX; Schema: ros_gn; Owner: ros-admin
--

CREATE INDEX index_sinkers_by_type_gn_gillnet_configuration_id ON ros_gn.sinkers_by_type USING btree (gn_gillnet_configuration_id);


--
-- Name: index_biteoffs_by_branchlines_set_ll_hauling_operation_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_biteoffs_by_branchlines_set_ll_hauling_operation_id ON ros_ll.biteoffs_by_branchlines_set USING btree (ll_hauling_operation_id);


--
-- Name: index_branchline_configurations_ll_gear_specifications_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_branchline_configurations_ll_gear_specifications_id ON ros_ll.branchline_configurations USING btree (ll_gear_specifications_id);


--
-- Name: index_branchline_sections_branchline_configuration_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_branchline_sections_branchline_configuration_id ON ros_ll.branchline_sections USING btree (branchline_configuration_id);


--
-- Name: index_branchline_sections_diameter_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_branchline_sections_diameter_id ON ros_ll.branchline_sections USING btree (diameter_id);


--
-- Name: index_branchline_sections_length_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_branchline_sections_length_id ON ros_ll.branchline_sections USING btree (length_id);


--
-- Name: index_floatlines_floatline_length_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_floatlines_floatline_length_id ON ros_ll.floatlines USING btree (floatline_length_id);


--
-- Name: index_floatlines_ll_setting_operation_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_floatlines_ll_setting_operation_id ON ros_ll.floatlines USING btree (ll_setting_operation_id);


--
-- Name: index_lights_by_type_and_colour_ll_setting_operation_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_lights_by_type_and_colour_ll_setting_operation_id ON ros_ll.lights_by_type_and_colour USING btree (ll_setting_operation_id);


--
-- Name: index_ll_additional_catch_details_on_ssi_bait_type_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_ll_additional_catch_details_on_ssi_bait_type_id ON ros_ll.ll_additional_catch_details_on_ssi USING btree (bait_type);


--
-- Name: index_ll_additional_catch_details_on_ssi_leader_thickness_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_ll_additional_catch_details_on_ssi_leader_thickness_id ON ros_ll.ll_additional_catch_details_on_ssi USING btree (leader_thickness_id);


--
-- Name: index_ll_catch_details_ll_fishing_event_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_ll_catch_details_ll_fishing_event_id ON ros_ll.ll_catch_details USING btree (ll_fishing_event_id);


--
-- Name: index_ll_fishing_events_ll_hauling_operation_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_ll_fishing_events_ll_hauling_operation_id ON ros_ll.ll_fishing_events USING btree (ll_hauling_operation_id);


--
-- Name: index_ll_fishing_events_ll_mitigation_measure_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_ll_fishing_events_ll_mitigation_measure_id ON ros_ll.ll_fishing_events USING btree (ll_mitigation_measure_id);


--
-- Name: index_ll_fishing_events_ll_observer_data_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_ll_fishing_events_ll_observer_data_id ON ros_ll.ll_fishing_events USING btree (ll_observer_data_id);


--
-- Name: index_ll_fishing_events_ll_setting_operation_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_ll_fishing_events_ll_setting_operation_id ON ros_ll.ll_fishing_events USING btree (ll_setting_operation_id);


--
-- Name: index_ll_gear_specifications_ll_general_gear_attributes_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_ll_gear_specifications_ll_general_gear_attributes_id ON ros_ll.ll_gear_specifications USING btree (ll_general_gear_attributes_id);


--
-- Name: index_ll_gear_specifications_ll_special_equipment_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_ll_gear_specifications_ll_special_equipment_id ON ros_ll.ll_gear_specifications USING btree (ll_special_equipment_id);


--
-- Name: index_ll_gear_specifications_tori_line_detail_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_ll_gear_specifications_tori_line_detail_id ON ros_ll.ll_gear_specifications USING btree (tori_line_detail_id);


--
-- Name: index_ll_general_gear_attributes_mainline_diameter_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_ll_general_gear_attributes_mainline_diameter_id ON ros_ll.ll_general_gear_attributes USING btree (mainline_diameter_id);


--
-- Name: index_ll_general_gear_attributes_mainline_length_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_ll_general_gear_attributes_mainline_length_id ON ros_ll.ll_general_gear_attributes USING btree (mainline_length_id);


--
-- Name: index_ll_mitigation_measures_hook_sinker_distance_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_ll_mitigation_measures_hook_sinker_distance_id ON ros_ll.ll_mitigation_measures USING btree (hook_sinker_distance_id);


--
-- Name: index_ll_mitigation_measures_sinker_average_weight_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_ll_mitigation_measures_sinker_average_weight_id ON ros_ll.ll_mitigation_measures USING btree (branchline_average_weight_id);


--
-- Name: index_ll_observer_data_creator_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_ll_observer_data_creator_id ON ros_ll.ll_observer_data USING btree (creator_id);


--
-- Name: index_ll_observer_data_ll_gear_specifications_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_ll_observer_data_ll_gear_specifications_id ON ros_ll.ll_observer_data USING btree (ll_gear_specifications_id);


--
-- Name: index_ll_observer_data_submitter_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_ll_observer_data_submitter_id ON ros_ll.ll_observer_data USING btree (submitter_id);


--
-- Name: index_ll_observer_data_vessel_and_trip_information_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_ll_observer_data_vessel_and_trip_information_id ON ros_ll.ll_observer_data USING btree (vessel_and_trip_information_id);


--
-- Name: index_ll_setting_operations_mainline_set_length_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_ll_setting_operations_mainline_set_length_id ON ros_ll.ll_setting_operations USING btree (mainline_set_length_id);


--
-- Name: index_ll_specimens_additional_specimen_d_non_target_species_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_ll_specimens_additional_specimen_d_non_target_species_id ON ros_ll.ll_specimens USING btree (additional_specimen_details_non_target_species_id);


--
-- Name: index_ll_specimens_biometric_information_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_ll_specimens_biometric_information_id ON ros_ll.ll_specimens USING btree (biometric_information_id);


--
-- Name: index_ll_specimens_ll_additional_catch_details_on_ssis_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_ll_specimens_ll_additional_catch_details_on_ssis_id ON ros_ll.ll_specimens USING btree (ll_additional_catch_details_on_ssis_id);


--
-- Name: index_ll_specimens_ll_depredation_detail_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_ll_specimens_ll_depredation_detail_id ON ros_ll.ll_specimens USING btree (ll_depredation_detail_id);


--
-- Name: index_ll_specimens_ll_tag_detail_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_ll_specimens_ll_tag_detail_id ON ros_ll.ll_specimens USING btree (ll_tag_detail_id);


--
-- Name: index_ll_tag_details_tag_finder_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_ll_tag_details_tag_finder_id ON ros_ll.ll_tag_details USING btree (tag_finder_id);


--
-- Name: index_tori_line_details_attached_height_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_tori_line_details_attached_height_id ON ros_ll.tori_line_details USING btree (attached_height_id);


--
-- Name: index_tori_line_details_streamer_distance_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_tori_line_details_streamer_distance_id ON ros_ll.tori_line_details USING btree (streamer_distance_id);


--
-- Name: index_tori_line_details_streamer_line_length_max_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_tori_line_details_streamer_line_length_max_id ON ros_ll.tori_line_details USING btree (streamer_line_length_max_id);


--
-- Name: index_tori_line_details_streamer_line_length_min_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_tori_line_details_streamer_line_length_min_id ON ros_ll.tori_line_details USING btree (streamer_line_length_min_id);


--
-- Name: index_tori_line_details_tori_line_length_id; Type: INDEX; Schema: ros_ll; Owner: ros-admin
--

CREATE INDEX index_tori_line_details_tori_line_length_id ON ros_ll.tori_line_details USING btree (tori_line_length_id);


--
-- Name: index_bait_fishing_events_pl_bait_fishing_operation_id; Type: INDEX; Schema: ros_pl; Owner: ros-admin
--

CREATE INDEX index_bait_fishing_events_pl_bait_fishing_operation_id ON ros_pl.bait_fishing_events USING btree (pl_bait_fishing_operation_id);


--
-- Name: index_bait_fishing_events_pl_object_detail_id; Type: INDEX; Schema: ros_pl; Owner: ros-admin
--

CREATE INDEX index_bait_fishing_events_pl_object_detail_id ON ros_pl.bait_fishing_events USING btree (pl_object_detail_id);


--
-- Name: index_bait_fishing_events_pl_observer_data_id; Type: INDEX; Schema: ros_pl; Owner: ros-admin
--

CREATE INDEX index_bait_fishing_events_pl_observer_data_id ON ros_pl.bait_fishing_events USING btree (pl_observer_data_id);


--
-- Name: index_bait_fishing_operations_distance_from_the_coast_id; Type: INDEX; Schema: ros_pl; Owner: ros-admin
--

CREATE INDEX index_bait_fishing_operations_distance_from_the_coast_id ON ros_pl.bait_fishing_operations USING btree (distance_from_the_coast_id);


--
-- Name: index_bait_fishing_operations_event_depth_id; Type: INDEX; Schema: ros_pl; Owner: ros-admin
--

CREATE INDEX index_bait_fishing_operations_event_depth_id ON ros_pl.bait_fishing_operations USING btree (event_depth_id);


--
-- Name: index_lures_or_jiggers_by_type_pl_general_gear_attributes_id; Type: INDEX; Schema: ros_pl; Owner: ros-admin
--

CREATE INDEX index_lures_or_jiggers_by_type_pl_general_gear_attributes_id ON ros_pl.lures_or_jiggers_by_type USING btree (pl_general_gear_attributes_id);


--
-- Name: index_pl_bfe_pl_catch_detail_pl_bfe_id_pl_catch_detail_id; Type: INDEX; Schema: ros_pl; Owner: ros-admin
--

CREATE INDEX index_pl_bfe_pl_catch_detail_pl_bfe_id_pl_catch_detail_id ON ros_pl.pl_bait_fishing_event_pl_catch_detail USING btree (pl_bait_fishing_event_id, pl_catch_detail_id);


--
-- Name: index_pl_gear_specifications_pl_general_gear_attributes_id; Type: INDEX; Schema: ros_pl; Owner: ros-admin
--

CREATE INDEX index_pl_gear_specifications_pl_general_gear_attributes_id ON ros_pl.pl_gear_specifications USING btree (pl_general_gear_attributes_id);


--
-- Name: index_pl_gear_specifications_pl_special_equipment_id; Type: INDEX; Schema: ros_pl; Owner: ros-admin
--

CREATE INDEX index_pl_gear_specifications_pl_special_equipment_id ON ros_pl.pl_gear_specifications USING btree (pl_special_equipment_id);


--
-- Name: index_pl_observer_data_creator_id; Type: INDEX; Schema: ros_pl; Owner: ros-admin
--

CREATE INDEX index_pl_observer_data_creator_id ON ros_pl.pl_observer_data USING btree (creator_id);


--
-- Name: index_pl_observer_data_pl_gear_specifications_id; Type: INDEX; Schema: ros_pl; Owner: ros-admin
--

CREATE INDEX index_pl_observer_data_pl_gear_specifications_id ON ros_pl.pl_observer_data USING btree (pl_gear_specifications_id);


--
-- Name: index_pl_observer_data_submitter_id; Type: INDEX; Schema: ros_pl; Owner: ros-admin
--

CREATE INDEX index_pl_observer_data_submitter_id ON ros_pl.pl_observer_data USING btree (submitter_id);


--
-- Name: index_pl_observer_data_vessel_and_trip_information_id; Type: INDEX; Schema: ros_pl; Owner: ros-admin
--

CREATE INDEX index_pl_observer_data_vessel_and_trip_information_id ON ros_pl.pl_observer_data USING btree (vessel_and_trip_information_id);


--
-- Name: index_pl_specimens_pl_additional_catch_details_on_ssis_id; Type: INDEX; Schema: ros_pl; Owner: ros-admin
--

CREATE INDEX index_pl_specimens_pl_additional_catch_details_on_ssis_id ON ros_pl.pl_specimens USING btree (pl_additional_catch_details_on_ssis_id);


--
-- Name: index_pl_specimens_pl_catch_detail_id; Type: INDEX; Schema: ros_pl; Owner: ros-admin
--

CREATE INDEX index_pl_specimens_pl_catch_detail_id ON ros_pl.pl_specimens USING btree (pl_catch_detail_id);


--
-- Name: index_pl_specimens_pl_tag_detail_id; Type: INDEX; Schema: ros_pl; Owner: ros-admin
--

CREATE INDEX index_pl_specimens_pl_tag_detail_id ON ros_pl.pl_specimens USING btree (pl_tag_detail_id);


--
-- Name: index_pl_tag_details_tag_finder_id; Type: INDEX; Schema: ros_pl; Owner: ros-admin
--

CREATE INDEX index_pl_tag_details_tag_finder_id ON ros_pl.pl_tag_details USING btree (tag_finder_id);


--
-- Name: index_pl_tfe_pl_catch_detail_pl_tf_id_pl_catch_detail_id; Type: INDEX; Schema: ros_pl; Owner: ros-admin
--

CREATE INDEX index_pl_tfe_pl_catch_detail_pl_tf_id_pl_catch_detail_id ON ros_pl.pl_tuna_fishing_event_pl_catch_detail USING btree (pl_tuna_fishing_event_id, pl_catch_detail_id);


--
-- Name: index_tuna_fishing_events_pl_object_detail_id; Type: INDEX; Schema: ros_pl; Owner: ros-admin
--

CREATE INDEX index_tuna_fishing_events_pl_object_detail_id ON ros_pl.tuna_fishing_events USING btree (pl_object_detail_id);


--
-- Name: index_tuna_fishing_events_pl_observer_data_id; Type: INDEX; Schema: ros_pl; Owner: ros-admin
--

CREATE INDEX index_tuna_fishing_events_pl_observer_data_id ON ros_pl.tuna_fishing_events USING btree (pl_observer_data_id);


--
-- Name: index_tuna_fishing_events_pl_tuna_fishing_operation_id; Type: INDEX; Schema: ros_pl; Owner: ros-admin
--

CREATE INDEX index_tuna_fishing_events_pl_tuna_fishing_operation_id ON ros_pl.tuna_fishing_events USING btree (pl_tuna_fishing_operation_id);


--
-- Name: index_cetaceans_whale_shark_sightings_ps_setting_operation_id; Type: INDEX; Schema: ros_ps; Owner: ros-admin
--

CREATE INDEX index_cetaceans_whale_shark_sightings_ps_setting_operation_id ON ros_ps.cetaceans_whale_shark_sightings USING btree (ps_setting_operation_id);


--
-- Name: index_current_details_ps_setting_operation_id; Type: INDEX; Schema: ros_ps; Owner: ros-admin
--

CREATE INDEX index_current_details_ps_setting_operation_id ON ros_ps.current_details USING btree (ps_setting_operation_id);


--
-- Name: index_ps_catch_details_ps_fishing_event_id; Type: INDEX; Schema: ros_ps; Owner: ros-admin
--

CREATE INDEX index_ps_catch_details_ps_fishing_event_id ON ros_ps.ps_catch_details USING btree (ps_fishing_event_id);


--
-- Name: index_ps_cd_ps_additional_catch_details_non_target_species_id; Type: INDEX; Schema: ros_ps; Owner: ros-admin
--

CREATE INDEX index_ps_cd_ps_additional_catch_details_non_target_species_id ON ros_ps.ps_catch_details USING btree (ps_additional_catch_details_non_target_species_id);


--
-- Name: index_ps_fishing_events_ps_observer_data_id; Type: INDEX; Schema: ros_ps; Owner: ros-admin
--

CREATE INDEX index_ps_fishing_events_ps_observer_data_id ON ros_ps.ps_fishing_events USING btree (ps_observer_data_id);


--
-- Name: index_ps_fishing_events_ps_setting_operation_id; Type: INDEX; Schema: ros_ps; Owner: ros-admin
--

CREATE INDEX index_ps_fishing_events_ps_setting_operation_id ON ros_ps.ps_fishing_events USING btree (ps_setting_operation_id);


--
-- Name: index_ps_gear_specifications_ps_general_gear_attributes_id; Type: INDEX; Schema: ros_ps; Owner: ros-admin
--

CREATE INDEX index_ps_gear_specifications_ps_general_gear_attributes_id ON ros_ps.ps_gear_specifications USING btree (ps_general_gear_attributes_id);


--
-- Name: index_ps_gear_specifications_ps_special_equipment_id; Type: INDEX; Schema: ros_ps; Owner: ros-admin
--

CREATE INDEX index_ps_gear_specifications_ps_special_equipment_id ON ros_ps.ps_gear_specifications USING btree (ps_special_equipment_id);


--
-- Name: index_ps_general_gear_attributes_bunt_stretched_mesh_size_id; Type: INDEX; Schema: ros_ps; Owner: ros-admin
--

CREATE INDEX index_ps_general_gear_attributes_bunt_stretched_mesh_size_id ON ros_ps.ps_general_gear_attributes USING btree (bunt_stretched_mesh_size_id);


--
-- Name: index_ps_general_gear_attributes_maximum_net_depth_id; Type: INDEX; Schema: ros_ps; Owner: ros-admin
--

CREATE INDEX index_ps_general_gear_attributes_maximum_net_depth_id ON ros_ps.ps_general_gear_attributes USING btree (maximum_net_depth_id);


--
-- Name: index_ps_general_gear_attributes_maximum_net_length_id; Type: INDEX; Schema: ros_ps; Owner: ros-admin
--

CREATE INDEX index_ps_general_gear_attributes_maximum_net_length_id ON ros_ps.ps_general_gear_attributes USING btree (maximum_net_length_id);


--
-- Name: index_ps_general_gear_attributes_mid_net_stretched_mesh_size_id; Type: INDEX; Schema: ros_ps; Owner: ros-admin
--

CREATE INDEX index_ps_general_gear_attributes_mid_net_stretched_mesh_size_id ON ros_ps.ps_general_gear_attributes USING btree (mid_net_stretched_mesh_size_id);


--
-- Name: index_ps_general_gear_attributes_skiff_power_id; Type: INDEX; Schema: ros_ps; Owner: ros-admin
--

CREATE INDEX index_ps_general_gear_attributes_skiff_power_id ON ros_ps.ps_general_gear_attributes USING btree (skiff_power_id);


--
-- Name: index_ps_observer_data_creator_id; Type: INDEX; Schema: ros_ps; Owner: ros-admin
--

CREATE INDEX index_ps_observer_data_creator_id ON ros_ps.ps_observer_data USING btree (creator_id);


--
-- Name: index_ps_observer_data_ps_gear_specifications_id; Type: INDEX; Schema: ros_ps; Owner: ros-admin
--

CREATE INDEX index_ps_observer_data_ps_gear_specifications_id ON ros_ps.ps_observer_data USING btree (ps_gear_specifications_id);


--
-- Name: index_ps_observer_data_submitter_id; Type: INDEX; Schema: ros_ps; Owner: ros-admin
--

CREATE INDEX index_ps_observer_data_submitter_id ON ros_ps.ps_observer_data USING btree (submitter_id);


--
-- Name: index_ps_observer_data_vessel_and_trip_information_id; Type: INDEX; Schema: ros_ps; Owner: ros-admin
--

CREATE INDEX index_ps_observer_data_vessel_and_trip_information_id ON ros_ps.ps_observer_data USING btree (vessel_and_trip_information_id);


--
-- Name: index_ps_spe_additional_specimen_details_non_target_species_id; Type: INDEX; Schema: ros_ps; Owner: ros-admin
--

CREATE INDEX index_ps_spe_additional_specimen_details_non_target_species_id ON ros_ps.ps_specimens USING btree (additional_specimen_details_non_target_species_id);


--
-- Name: index_ps_specimens_biometric_information_id; Type: INDEX; Schema: ros_ps; Owner: ros-admin
--

CREATE INDEX index_ps_specimens_biometric_information_id ON ros_ps.ps_specimens USING btree (biometric_information_id);


--
-- Name: index_ps_specimens_ps_additional_catch_details_on_ssis_id; Type: INDEX; Schema: ros_ps; Owner: ros-admin
--

CREATE INDEX index_ps_specimens_ps_additional_catch_details_on_ssis_id ON ros_ps.ps_specimens USING btree (ps_additional_catch_details_on_ssis_id);


--
-- Name: index_ps_specimens_ps_catch_detail_id; Type: INDEX; Schema: ros_ps; Owner: ros-admin
--

CREATE INDEX index_ps_specimens_ps_catch_detail_id ON ros_ps.ps_specimens USING btree (ps_catch_detail_id);


--
-- Name: index_ps_specimens_ps_tag_detail_id; Type: INDEX; Schema: ros_ps; Owner: ros-admin
--

CREATE INDEX index_ps_specimens_ps_tag_detail_id ON ros_ps.ps_specimens USING btree (ps_tag_detail_id);


--
-- Name: index_ps_tag_details_tag_finder_id; Type: INDEX; Schema: ros_ps; Owner: ros-admin
--

CREATE INDEX index_ps_tag_details_tag_finder_id ON ros_ps.ps_tag_details USING btree (tag_finder_id);


--
-- Name: index_support_vessel_details_ps_setting_operation_id; Type: INDEX; Schema: ros_ps; Owner: ros-admin
--

CREATE INDEX index_support_vessel_details_ps_setting_operation_id ON ros_ps.support_vessel_details USING btree (ps_setting_operation_id);


--
-- Name: cpc_history fk_cpc_history_cpcs; Type: FK CONSTRAINT; Schema: refs_admin; Owner: ros-admin
--

ALTER TABLE ONLY refs_admin.cpc_history
    ADD CONSTRAINT fk_cpc_history_cpcs FOREIGN KEY (cpc_code) REFERENCES refs_admin.cpcs(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cpc_to_flags fk_cpc_to_flags_cpc_to_cpc; Type: FK CONSTRAINT; Schema: refs_admin; Owner: ros-admin
--

ALTER TABLE ONLY refs_admin.cpc_to_flags
    ADD CONSTRAINT fk_cpc_to_flags_cpc_to_cpc FOREIGN KEY (cpc_code) REFERENCES refs_admin.cpcs(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cpc_to_flags fk_cpc_to_flags_cpc_to_flag; Type: FK CONSTRAINT; Schema: refs_admin; Owner: ros-admin
--

ALTER TABLE ONLY refs_admin.cpc_to_flags
    ADD CONSTRAINT fk_cpc_to_flags_cpc_to_flag FOREIGN KEY (flag_code) REFERENCES refs_admin.countries(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fleet_to_flags_and_fisheries fk_fleet_to_flags_and_fisheries_countries_ext; Type: FK CONSTRAINT; Schema: refs_admin; Owner: ros-admin
--

ALTER TABLE ONLY refs_admin.fleet_to_flags_and_fisheries
    ADD CONSTRAINT fk_fleet_to_flags_and_fisheries_countries_ext FOREIGN KEY (flag_code) REFERENCES refs_admin.entities(code);


--
-- Name: fleet_to_flags_and_fisheries fk_fleet_to_flags_and_fisheries_countries_ext_reporting; Type: FK CONSTRAINT; Schema: refs_admin; Owner: ros-admin
--

ALTER TABLE ONLY refs_admin.fleet_to_flags_and_fisheries
    ADD CONSTRAINT fk_fleet_to_flags_and_fisheries_countries_ext_reporting FOREIGN KEY (reporting_entity_code) REFERENCES refs_admin.entities(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fleet_to_flags_and_fisheries fk_fleet_to_flags_and_fisheries_fishery_types; Type: FK CONSTRAINT; Schema: refs_admin; Owner: ros-admin
--

ALTER TABLE ONLY refs_admin.fleet_to_flags_and_fisheries
    ADD CONSTRAINT fk_fleet_to_flags_and_fisheries_fishery_types FOREIGN KEY (fishery_type_code) REFERENCES refs_fishery_config.fishery_types(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fleet_to_flags_and_fisheries fk_fleet_to_flags_and_fisheries_fishing_modes; Type: FK CONSTRAINT; Schema: refs_admin; Owner: ros-admin
--

ALTER TABLE ONLY refs_admin.fleet_to_flags_and_fisheries
    ADD CONSTRAINT fk_fleet_to_flags_and_fisheries_fishing_modes FOREIGN KEY (fishing_mode_code) REFERENCES refs_fishery_config.fishing_modes(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fleet_to_flags_and_fisheries fk_fleet_to_flags_and_fisheries_fleets; Type: FK CONSTRAINT; Schema: refs_admin; Owner: ros-admin
--

ALTER TABLE ONLY refs_admin.fleet_to_flags_and_fisheries
    ADD CONSTRAINT fk_fleet_to_flags_and_fisheries_fleets FOREIGN KEY (fleet_code) REFERENCES refs_admin.fleets(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fleet_to_flags_and_fisheries fk_fleet_to_flags_and_fisheries_gear_categories; Type: FK CONSTRAINT; Schema: refs_admin; Owner: ros-admin
--

ALTER TABLE ONLY refs_admin.fleet_to_flags_and_fisheries
    ADD CONSTRAINT fk_fleet_to_flags_and_fisheries_gear_categories FOREIGN KEY (gear_category_code) REFERENCES refs_fishery_config.gear_groups(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fleet_to_flags_and_fisheries fk_fleet_to_flags_and_fisheries_gear_configurations; Type: FK CONSTRAINT; Schema: refs_admin; Owner: ros-admin
--

ALTER TABLE ONLY refs_admin.fleet_to_flags_and_fisheries
    ADD CONSTRAINT fk_fleet_to_flags_and_fisheries_gear_configurations FOREIGN KEY (gear_configuration_code) REFERENCES refs_fishery_config.gear_configurations(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fleet_to_flags_and_fisheries fk_fleet_to_flags_and_fisheries_io_main_areas; Type: FK CONSTRAINT; Schema: refs_admin; Owner: ros-admin
--

ALTER TABLE ONLY refs_admin.fleet_to_flags_and_fisheries
    ADD CONSTRAINT fk_fleet_to_flags_and_fisheries_io_main_areas FOREIGN KEY (iotc_main_area_code) REFERENCES refs_gis.areas(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fleet_to_flags_and_fisheries fk_fleet_to_flags_and_fisheries_target_species; Type: FK CONSTRAINT; Schema: refs_admin; Owner: ros-admin
--

ALTER TABLE ONLY refs_admin.fleet_to_flags_and_fisheries
    ADD CONSTRAINT fk_fleet_to_flags_and_fisheries_target_species FOREIGN KEY (target_species_code) REFERENCES refs_fishery_config.target_species(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fleets fk_fleets_cpcs; Type: FK CONSTRAINT; Schema: refs_admin; Owner: ros-admin
--

ALTER TABLE ONLY refs_admin.fleets
    ADD CONSTRAINT fk_fleets_cpcs FOREIGN KEY (cpc_code) REFERENCES refs_admin.cpcs(code) ON DELETE CASCADE;


--
-- Name: ports fk_ports_countries; Type: FK CONSTRAINT; Schema: refs_admin; Owner: ros-admin
--

ALTER TABLE ONLY refs_admin.ports
    ADD CONSTRAINT fk_ports_countries FOREIGN KEY (country_code) REFERENCES refs_admin.countries(code_iso3) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: species_reporting_requirements fk_reporting_requirements_gear_groups; Type: FK CONSTRAINT; Schema: refs_admin; Owner: ros-admin
--

ALTER TABLE ONLY refs_admin.species_reporting_requirements
    ADD CONSTRAINT fk_reporting_requirements_gear_groups FOREIGN KEY (gear_group_code) REFERENCES refs_fishery_config.gear_groups(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: species_reporting_requirements fk_reporting_requirements_species; Type: FK CONSTRAINT; Schema: refs_admin; Owner: ros-admin
--

ALTER TABLE ONLY refs_admin.species_reporting_requirements
    ADD CONSTRAINT fk_reporting_requirements_species FOREIGN KEY (species_code) REFERENCES refs_biological.species(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fates fk_fates_types_of_fate; Type: FK CONSTRAINT; Schema: refs_biological; Owner: ros-admin
--

ALTER TABLE ONLY refs_biological.fates
    ADD CONSTRAINT fk_fates_types_of_fate FOREIGN KEY (type_of_fate_code) REFERENCES refs_biological.types_of_fate(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: measurement_tools fk_measurement_tools_types_of_measurement; Type: FK CONSTRAINT; Schema: refs_biological; Owner: ros-admin
--

ALTER TABLE ONLY refs_biological.measurement_tools
    ADD CONSTRAINT fk_measurement_tools_types_of_measurement FOREIGN KEY (type_of_measurement_code) REFERENCES refs_biological.types_of_measurement(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: measurements fk_measurement_types_types_of_measurement; Type: FK CONSTRAINT; Schema: refs_biological; Owner: ros-admin
--

ALTER TABLE ONLY refs_biological.measurements
    ADD CONSTRAINT fk_measurement_types_types_of_measurement FOREIGN KEY (type_of_measurement_code) REFERENCES refs_biological.types_of_measurement(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: species_aggregates fk_species_aggregates_species; Type: FK CONSTRAINT; Schema: refs_biological; Owner: ros-admin
--

ALTER TABLE ONLY refs_biological.species_aggregates
    ADD CONSTRAINT fk_species_aggregates_species FOREIGN KEY (species_aggregate_code) REFERENCES refs_biological.species(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: species_aggregates fk_species_aggregates_species_component; Type: FK CONSTRAINT; Schema: refs_biological; Owner: ros-admin
--

ALTER TABLE ONLY refs_biological.species_aggregates
    ADD CONSTRAINT fk_species_aggregates_species_component FOREIGN KEY (species_code) REFERENCES refs_biological.species(code);


--
-- Name: species fk_species_species_categories; Type: FK CONSTRAINT; Schema: refs_biological; Owner: ros-admin
--

ALTER TABLE ONLY refs_biological.species
    ADD CONSTRAINT fk_species_species_categories FOREIGN KEY (species_category_code) REFERENCES refs_biological.species_categories(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: species fk_species_species_groups; Type: FK CONSTRAINT; Schema: refs_biological; Owner: ros-admin
--

ALTER TABLE ONLY refs_biological.species
    ADD CONSTRAINT fk_species_species_groups FOREIGN KEY (species_group_code) REFERENCES refs_biological.species_groups(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: recommended_measurements fk_recommended_measurements_measurements; Type: FK CONSTRAINT; Schema: refs_biological_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_biological_config.recommended_measurements
    ADD CONSTRAINT fk_recommended_measurements_measurements FOREIGN KEY (type_of_measurement_code, measurement_code) REFERENCES refs_biological.measurements(type_of_measurement_code, code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: recommended_measurements fk_recommended_measurements_species; Type: FK CONSTRAINT; Schema: refs_biological_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_biological_config.recommended_measurements
    ADD CONSTRAINT fk_recommended_measurements_species FOREIGN KEY (species_code) REFERENCES refs_biological.species(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: processings fk_processings_datasets; Type: FK CONSTRAINT; Schema: refs_data; Owner: ros-admin
--

ALTER TABLE ONLY refs_data.processings
    ADD CONSTRAINT fk_processings_datasets FOREIGN KEY (dataset_code) REFERENCES refs_data.datasets(code);


--
-- Name: sources fk_sources_datasets; Type: FK CONSTRAINT; Schema: refs_data; Owner: ros-admin
--

ALTER TABLE ONLY refs_data.sources
    ADD CONSTRAINT fk_sources_datasets FOREIGN KEY (dataset_code) REFERENCES refs_data.datasets(code);


--
-- Name: fisheries fk_fisheries_fishery_categories; Type: FK CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.fisheries
    ADD CONSTRAINT fk_fisheries_fishery_categories FOREIGN KEY (fishery_category_code) REFERENCES refs_fishery_config.fishery_categories(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fisheries fk_fisheries_fishery_types; Type: FK CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.fisheries
    ADD CONSTRAINT fk_fisheries_fishery_types FOREIGN KEY (fishery_type_code) REFERENCES refs_fishery_config.fishery_types(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fisheries fk_fisheries_fishing_modes; Type: FK CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.fisheries
    ADD CONSTRAINT fk_fisheries_fishing_modes FOREIGN KEY (fishing_mode_code) REFERENCES refs_fishery_config.fishing_modes(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fisheries fk_fisheries_gear_configurations; Type: FK CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.fisheries
    ADD CONSTRAINT fk_fisheries_gear_configurations FOREIGN KEY (gear_configuration_code) REFERENCES refs_fishery_config.gear_configurations(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fisheries fk_fisheries_gears; Type: FK CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.fisheries
    ADD CONSTRAINT fk_fisheries_gears FOREIGN KEY (gear_code) REFERENCES refs_fishery_config.gears(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fisheries fk_fisheries_legacy_fisheries; Type: FK CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.fisheries
    ADD CONSTRAINT fk_fisheries_legacy_fisheries FOREIGN KEY (iotc_fishery_code) REFERENCES refs_legacy.fisheries(code) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fisheries fk_fisheries_legacy_gears; Type: FK CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.fisheries
    ADD CONSTRAINT fk_fisheries_legacy_gears FOREIGN KEY (iotdb_gear_code) REFERENCES refs_legacy.gears(code) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fisheries fk_fisheries_target_species; Type: FK CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.fisheries
    ADD CONSTRAINT fk_fisheries_target_species FOREIGN KEY (target_species_code) REFERENCES refs_fishery_config.target_species(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: school_sighting_cues fk_school_sighting_cues_school_type_categories; Type: FK CONSTRAINT; Schema: refs_fishery; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery.school_sighting_cues
    ADD CONSTRAINT fk_school_sighting_cues_school_type_categories FOREIGN KEY (school_type_category_code) REFERENCES refs_fishery.school_type_categories(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fishery_types fk_fishery_types_areas_of_operation; Type: FK CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.fishery_types
    ADD CONSTRAINT fk_fishery_types_areas_of_operation FOREIGN KEY (area_of_operation_code) REFERENCES refs_fishery_config.areas_of_operation(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fishery_types fk_fishery_types_fishery_types; Type: FK CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.fishery_types
    ADD CONSTRAINT fk_fishery_types_fishery_types FOREIGN KEY (code) REFERENCES refs_fishery_config.fishery_types(code);


--
-- Name: fishery_types fk_fishery_types_loa_classes; Type: FK CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.fishery_types
    ADD CONSTRAINT fk_fishery_types_loa_classes FOREIGN KEY (loa_class_code) REFERENCES refs_fishery_config.loa_classes(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fishery_types_new fk_fishery_types_new_areas_of_operation; Type: FK CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.fishery_types_new
    ADD CONSTRAINT fk_fishery_types_new_areas_of_operation FOREIGN KEY (area_of_operation_code) REFERENCES refs_fishery_config.areas_of_operation(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fishery_types_new fk_fishery_types_new_loa_classes; Type: FK CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.fishery_types_new
    ADD CONSTRAINT fk_fishery_types_new_loa_classes FOREIGN KEY (loa_class_code) REFERENCES refs_fishery_config.loa_classes(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fishery_types_new fk_fishery_types_new_purposes; Type: FK CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.fishery_types_new
    ADD CONSTRAINT fk_fishery_types_new_purposes FOREIGN KEY (purpose_code) REFERENCES refs_fishery_config.purposes(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fishery_types fk_fishery_types_purposes; Type: FK CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.fishery_types
    ADD CONSTRAINT fk_fishery_types_purposes FOREIGN KEY (purpose_code) REFERENCES refs_fishery_config.purposes(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gear_fishery_type_to_configuration fk_gear_fishery_type_to_configuration_fishery_types; Type: FK CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.gear_fishery_type_to_configuration
    ADD CONSTRAINT fk_gear_fishery_type_to_configuration_fishery_types FOREIGN KEY (fishery_type_code) REFERENCES refs_fishery_config.fishery_types(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gear_fishery_type_to_configuration fk_gear_fishery_type_to_configuration_gear_configurations; Type: FK CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.gear_fishery_type_to_configuration
    ADD CONSTRAINT fk_gear_fishery_type_to_configuration_gear_configurations FOREIGN KEY (gear_configuration_code) REFERENCES refs_fishery_config.gear_configurations(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gear_fishery_type_to_configuration fk_gear_fishery_type_to_configuration_gears; Type: FK CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.gear_fishery_type_to_configuration
    ADD CONSTRAINT fk_gear_fishery_type_to_configuration_gears FOREIGN KEY (gear_code) REFERENCES refs_fishery_config.gears(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gear_fishery_type_to_fishing_mode fk_gear_fishery_type_to_fishing_mode_fishery_types; Type: FK CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.gear_fishery_type_to_fishing_mode
    ADD CONSTRAINT fk_gear_fishery_type_to_fishing_mode_fishery_types FOREIGN KEY (fishery_type_code) REFERENCES refs_fishery_config.fishery_types(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gear_fishery_type_to_fishing_mode fk_gear_fishery_type_to_fishing_mode_fishing_modes; Type: FK CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.gear_fishery_type_to_fishing_mode
    ADD CONSTRAINT fk_gear_fishery_type_to_fishing_mode_fishing_modes FOREIGN KEY (fishing_mode_code) REFERENCES refs_fishery_config.fishing_modes(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gear_fishery_type_to_fishing_mode fk_gear_fishery_type_to_fishing_mode_gear_code; Type: FK CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.gear_fishery_type_to_fishing_mode
    ADD CONSTRAINT fk_gear_fishery_type_to_fishing_mode_gear_code FOREIGN KEY (gear_code) REFERENCES refs_fishery_config.gears(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gear_groups fk_gear_groups_gear_groups; Type: FK CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.gear_groups
    ADD CONSTRAINT fk_gear_groups_gear_groups FOREIGN KEY (code) REFERENCES refs_fishery_config.gear_groups(code);


--
-- Name: gear_to_fishery_type fk_gear_to_fishery_type_fishery_types; Type: FK CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.gear_to_fishery_type
    ADD CONSTRAINT fk_gear_to_fishery_type_fishery_types FOREIGN KEY (fishery_type_code) REFERENCES refs_fishery_config.fishery_types(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gear_to_fishery_type fk_gear_to_fishery_type_gears; Type: FK CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.gear_to_fishery_type
    ADD CONSTRAINT fk_gear_to_fishery_type_gears FOREIGN KEY (gear_code) REFERENCES refs_fishery_config.gears(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gear_to_fishery_type_new fk_gear_to_fishery_type_new_fishery_types; Type: FK CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.gear_to_fishery_type_new
    ADD CONSTRAINT fk_gear_to_fishery_type_new_fishery_types FOREIGN KEY (fishery_type_code) REFERENCES refs_fishery_config.fishery_types_new(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gear_to_fishery_type_new fk_gear_to_fishery_type_new_gears; Type: FK CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.gear_to_fishery_type_new
    ADD CONSTRAINT fk_gear_to_fishery_type_new_gears FOREIGN KEY (gear_code) REFERENCES refs_fishery_config.gears(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gear_to_target_species fk_gear_to_target_species_gears; Type: FK CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.gear_to_target_species
    ADD CONSTRAINT fk_gear_to_target_species_gears FOREIGN KEY (gear_code) REFERENCES refs_fishery_config.gears(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gear_to_target_species fk_gear_to_target_species_target_species; Type: FK CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.gear_to_target_species
    ADD CONSTRAINT fk_gear_to_target_species_target_species FOREIGN KEY (target_species_code) REFERENCES refs_fishery_config.target_species(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gears fk_gears_gear_groups; Type: FK CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.gears
    ADD CONSTRAINT fk_gears_gear_groups FOREIGN KEY (gear_group_code) REFERENCES refs_fishery_config.gear_groups(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gears fk_gears_isscfg_gears; Type: FK CONSTRAINT; Schema: refs_fishery_config; Owner: ros-admin
--

ALTER TABLE ONLY refs_fishery_config.gears
    ADD CONSTRAINT fk_gears_isscfg_gears FOREIGN KEY (isscfg_code) REFERENCES refs_legacy.isscfg_gears(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: areas fk_areas_area_types; Type: FK CONSTRAINT; Schema: refs_gis; Owner: ros-admin
--

ALTER TABLE ONLY refs_gis.areas
    ADD CONSTRAINT fk_areas_area_types FOREIGN KEY (area_type_code) REFERENCES refs_gis.area_types(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: area_intersections fk_source_to_areas; Type: FK CONSTRAINT; Schema: refs_gis; Owner: ros-admin
--

ALTER TABLE ONLY refs_gis.area_intersections
    ADD CONSTRAINT fk_source_to_areas FOREIGN KEY (source_code) REFERENCES refs_gis.areas(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: area_intersections fk_target_to_areas; Type: FK CONSTRAINT; Schema: refs_gis; Owner: ros-admin
--

ALTER TABLE ONLY refs_gis.area_intersections
    ADD CONSTRAINT fk_target_to_areas FOREIGN KEY (target_code) REFERENCES refs_gis.areas(code);


--
-- Name: isscfg_gears fk_isscfg_gears_isscfg_gear_groups; Type: FK CONSTRAINT; Schema: refs_legacy; Owner: ros-admin
--

ALTER TABLE ONLY refs_legacy.isscfg_gears
    ADD CONSTRAINT fk_isscfg_gears_isscfg_gear_groups FOREIGN KEY (isscfg_group_code) REFERENCES refs_legacy.isscfg_gear_groups(code);


--
-- Name: nocs_names_en fk_nocs_names_en_nocs_codes; Type: FK CONSTRAINT; Schema: refs_legacy; Owner: ros-admin
--

ALTER TABLE ONLY refs_legacy.nocs_names_en
    ADD CONSTRAINT fk_nocs_names_en_nocs_codes FOREIGN KEY (id) REFERENCES refs_legacy.nocs_codes(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: nocs_names_fr fk_nocs_names_fr_nocs_codes; Type: FK CONSTRAINT; Schema: refs_legacy; Owner: ros-admin
--

ALTER TABLE ONLY refs_legacy.nocs_names_fr
    ADD CONSTRAINT fk_nocs_names_fr_nocs_codes FOREIGN KEY (id) REFERENCES refs_legacy.nocs_codes(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: species_to_grsf fk_species_to_grsf_species; Type: FK CONSTRAINT; Schema: refs_legacy; Owner: ros-admin
--

ALTER TABLE ONLY refs_legacy.species_to_grsf
    ADD CONSTRAINT fk_species_to_grsf_species FOREIGN KEY (species_code) REFERENCES refs_biological.species(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: un_locode_ports fk_un_locode_ports_countries; Type: FK CONSTRAINT; Schema: refs_legacy; Owner: ros-admin
--

ALTER TABLE ONLY refs_legacy.un_locode_ports
    ADD CONSTRAINT fk_un_locode_ports_countries FOREIGN KEY (country_code) REFERENCES refs_admin.countries(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: currencies fk_countries; Type: FK CONSTRAINT; Schema: refs_socio_economics; Owner: ros-admin
--

ALTER TABLE ONLY refs_socio_economics.currencies
    ADD CONSTRAINT fk_countries FOREIGN KEY (country_code) REFERENCES refs_admin.countries(code_iso3);


--
-- Name: biometric_information bmtrcnfrmtionmtrtystgd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.biometric_information
    ADD CONSTRAINT bmtrcnfrmtionmtrtystgd FOREIGN KEY (maturity_stage_id) REFERENCES ros_common.maturity_stages(id);


--
-- Name: biometric_information bmtrcnfrmtonmsrdlngthd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.biometric_information
    ADD CONSTRAINT bmtrcnfrmtonmsrdlngthd FOREIGN KEY (measured_length_id) REFERENCES ros_common.measured_lengths(id);


--
-- Name: biometric_information bmtrcnfrmtonstmtdwghtd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.biometric_information
    ADD CONSTRAINT bmtrcnfrmtonstmtdwghtd FOREIGN KEY (estimated_weight_id) REFERENCES ros_common.estimated_weights(id);


--
-- Name: biometric_information bmtrcnfrsmplcllctndtld; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.biometric_information
    ADD CONSTRAINT bmtrcnfrsmplcllctndtld FOREIGN KEY (sample_collection_detail_id) REFERENCES ros_common.sample_collection_details(id);


--
-- Name: biometric_information bmtrcnltrntvmsrdlngthd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.biometric_information
    ADD CONSTRAINT bmtrcnltrntvmsrdlngthd FOREIGN KEY (alternative_measured_length_id) REFERENCES ros_common.measured_lengths(id);


--
-- Name: observer_trip_details bsrvrtrpddsmbrktnlctnd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.observer_trip_details
    ADD CONSTRAINT bsrvrtrpddsmbrktnlctnd FOREIGN KEY (disembarkation_location_id) REFERENCES ros_common.locations(id);


--
-- Name: observer_trip_details bsrvrtrpdtlmbrktnlctnd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.observer_trip_details
    ADD CONSTRAINT bsrvrtrpdtlmbrktnlctnd FOREIGN KEY (embarkation_location_id) REFERENCES ros_common.locations(id);


--
-- Name: activity_details ctvtydtailsdlyctvityid; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.activity_details
    ADD CONSTRAINT ctvtydtailsdlyctvityid FOREIGN KEY (daily_activity_id) REFERENCES ros_common.daily_activities(id);


--
-- Name: activity_details fk_ros_common_activity_code_activity_details; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.activity_details
    ADD CONSTRAINT fk_ros_common_activity_code_activity_details FOREIGN KEY (activity_code) REFERENCES refs_biological.bait_conditions(code);


--
-- Name: biometric_information fk_ros_common_bio_collection_sampling_method_code_biometric_inf; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.biometric_information
    ADD CONSTRAINT fk_ros_common_bio_collection_sampling_method_code_biometric_inf FOREIGN KEY (bio_collection_sampling_method_code) REFERENCES refs_biological.sampling_methods_for_sampling_collections(code);


--
-- Name: additional_details_on_non_target_species fk_ros_common_condition_at_capture_code_additional_details_on_n; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.additional_details_on_non_target_species
    ADD CONSTRAINT fk_ros_common_condition_at_capture_code_additional_details_on_n FOREIGN KEY (condition_at_capture_code) REFERENCES refs_biological.incidental_captures_conditions(code);


--
-- Name: additional_details_on_non_target_species fk_ros_common_condition_at_release_code_additional_details_on_n; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.additional_details_on_non_target_species
    ADD CONSTRAINT fk_ros_common_condition_at_release_code_additional_details_on_n FOREIGN KEY (condition_at_release_code) REFERENCES refs_biological.incidental_captures_conditions(code);


--
-- Name: locations fk_ros_common_country_code_locations; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.locations
    ADD CONSTRAINT fk_ros_common_country_code_locations FOREIGN KEY (country_code) REFERENCES refs_admin.countries(code);


--
-- Name: vessel_trip_details fk_ros_common_departure_port_code_vessel_trip_details; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_trip_details
    ADD CONSTRAINT fk_ros_common_departure_port_code_vessel_trip_details FOREIGN KEY (departure_port_code) REFERENCES refs_admin.ports(code);


--
-- Name: depredation_details fk_ros_common_depredation_source_code_depredation_details; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.depredation_details
    ADD CONSTRAINT fk_ros_common_depredation_source_code_depredation_details FOREIGN KEY (depredation_source_code) REFERENCES refs_biological.scars(code);


--
-- Name: vessel_attributes_fish_preservation_method fk_ros_common_fish_preservation_method_code_vessel_attributes_f; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_attributes_fish_preservation_method
    ADD CONSTRAINT fk_ros_common_fish_preservation_method_code_vessel_attributes_f FOREIGN KEY (fish_preservation_method_code) REFERENCES refs_fishery.fish_preservation_methods(code);


--
-- Name: vessel_attributes_fish_storage_type fk_ros_common_fish_storage_type_code_vessel_attributes_fish_sto; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_attributes_fish_storage_type
    ADD CONSTRAINT fk_ros_common_fish_storage_type_code_vessel_attributes_fish_sto FOREIGN KEY (fish_storage_type_code) REFERENCES refs_fishery.fish_storage_types(code);


--
-- Name: vessel_identification fk_ros_common_flag_code_vessel_identification; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_identification
    ADD CONSTRAINT fk_ros_common_flag_code_vessel_identification FOREIGN KEY (flag_code) REFERENCES refs_admin.countries(code);


--
-- Name: vessel_attributes fk_ros_common_hull_material_code_vessel_attributes; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_attributes
    ADD CONSTRAINT fk_ros_common_hull_material_code_vessel_attributes FOREIGN KEY (hull_material_code) REFERENCES refs_fishery.hull_material_types(code);


--
-- Name: measured_lengths fk_ros_common_length_measuring_tool_code_measured_lengths; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.measured_lengths
    ADD CONSTRAINT fk_ros_common_length_measuring_tool_code_measured_lengths FOREIGN KEY (length_measuring_tool_code, type_of_measurement_code) REFERENCES refs_biological.measurement_tools(code, type_of_measurement_code);


--
-- Name: vessel_identification_licensed_target_species fk_ros_common_licensed_target_species_code_vessel_identificatio; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_identification_licensed_target_species
    ADD CONSTRAINT fk_ros_common_licensed_target_species_code_vessel_identificatio FOREIGN KEY (licensed_target_species_code) REFERENCES refs_biological.species(code);


--
-- Name: vessel_identification fk_ros_common_main_fishing_gear_code_vessel_identification; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_identification
    ADD CONSTRAINT fk_ros_common_main_fishing_gear_code_vessel_identification FOREIGN KEY (main_fishing_gear_code) REFERENCES refs_fishery_config.gears(code);


--
-- Name: measured_lengths fk_ros_common_measured_length_type_code_measured_lengths; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.measured_lengths
    ADD CONSTRAINT fk_ros_common_measured_length_type_code_measured_lengths FOREIGN KEY (measured_length_type_code, type_of_measurement_code) REFERENCES refs_biological.measurements(code, type_of_measurement_code);


--
-- Name: iotc_person_contact_details fk_ros_common_nationality_code_iotc_person_contact_details; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.iotc_person_contact_details
    ADD CONSTRAINT fk_ros_common_nationality_code_iotc_person_contact_details FOREIGN KEY (nationality_code) REFERENCES refs_admin.countries(code);


--
-- Name: iotc_person_details fk_ros_common_nationality_code_iotc_person_details; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.iotc_person_details
    ADD CONSTRAINT fk_ros_common_nationality_code_iotc_person_details FOREIGN KEY (nationality_code) REFERENCES refs_admin.countries(code);


--
-- Name: observer_identification fk_ros_common_nationality_code_observer_identification; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.observer_identification
    ADD CONSTRAINT fk_ros_common_nationality_code_observer_identification FOREIGN KEY (nationality_code) REFERENCES refs_admin.countries(code);


--
-- Name: person_contact_details fk_ros_common_nationality_code_person_contact_details; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.person_contact_details
    ADD CONSTRAINT fk_ros_common_nationality_code_person_contact_details FOREIGN KEY (nationality_code) REFERENCES refs_admin.countries(code);


--
-- Name: person_details fk_ros_common_nationality_code_person_details; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.person_details
    ADD CONSTRAINT fk_ros_common_nationality_code_person_details FOREIGN KEY (nationality_code) REFERENCES refs_admin.countries(code);


--
-- Name: vessel_identification fk_ros_common_port_code_vessel_identification; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_identification
    ADD CONSTRAINT fk_ros_common_port_code_vessel_identification FOREIGN KEY (port_code) REFERENCES refs_admin.ports(code);


--
-- Name: depredation_details fk_ros_common_predator_observed_code_depredation_details; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.depredation_details
    ADD CONSTRAINT fk_ros_common_predator_observed_code_depredation_details FOREIGN KEY (predator_observed_code) REFERENCES refs_biological.species(code);


--
-- Name: estimated_weights fk_ros_common_processing_type_code_estimated_weights; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.estimated_weights
    ADD CONSTRAINT fk_ros_common_processing_type_code_estimated_weights FOREIGN KEY (processing_type_code) REFERENCES refs_fishery.fish_processing_types(code);


--
-- Name: measured_weights fk_ros_common_processing_type_code_measured_weights; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.measured_weights
    ADD CONSTRAINT fk_ros_common_processing_type_code_measured_weights FOREIGN KEY (processing_type_code) REFERENCES refs_fishery.fish_processing_types(code);


--
-- Name: species_by_product_type fk_ros_common_processing_type_code_species_by_product_type; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.species_by_product_type
    ADD CONSTRAINT fk_ros_common_processing_type_code_species_by_product_type FOREIGN KEY (processing_type_code) REFERENCES refs_fishery.fish_processing_types(code);


--
-- Name: vessel_trip_details fk_ros_common_return_port_code_vessel_trip_details; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_trip_details
    ADD CONSTRAINT fk_ros_common_return_port_code_vessel_trip_details FOREIGN KEY (return_port_code) REFERENCES refs_admin.ports(code);


--
-- Name: biometric_information fk_ros_common_sex_code_biometric_information; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.biometric_information
    ADD CONSTRAINT fk_ros_common_sex_code_biometric_information FOREIGN KEY (sex_code) REFERENCES refs_biological.sex(code);


--
-- Name: species_by_product_type fk_ros_common_species_code_species_by_product_type; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.species_by_product_type
    ADD CONSTRAINT fk_ros_common_species_code_species_by_product_type FOREIGN KEY (species_code) REFERENCES refs_biological.species(code);


--
-- Name: carrier_vessel_identification fk_ros_common_vessel_flag_code_carrier_vessel_identification; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.carrier_vessel_identification
    ADD CONSTRAINT fk_ros_common_vessel_flag_code_carrier_vessel_identification FOREIGN KEY (vessel_flag_code) REFERENCES refs_admin.countries(code);


--
-- Name: carrier_vessel_identification fk_ros_common_vessel_registration_port_code_carrier_vessel_iden; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.carrier_vessel_identification
    ADD CONSTRAINT fk_ros_common_vessel_registration_port_code_carrier_vessel_iden FOREIGN KEY (vessel_registration_port_code) REFERENCES refs_admin.ports(code);


--
-- Name: waste_managements fk_ros_common_waste_category_code_waste_managements; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.waste_managements
    ADD CONSTRAINT fk_ros_common_waste_category_code_waste_managements FOREIGN KEY (waste_category_code) REFERENCES refs_fishery.waste_categories(code);


--
-- Name: waste_managements fk_ros_common_waste_storage_or_disposal_method_code_waste_manag; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.waste_managements
    ADD CONSTRAINT fk_ros_common_waste_storage_or_disposal_method_code_waste_manag FOREIGN KEY (waste_storage_or_disposal_method_code) REFERENCES refs_fishery.waste_disposal_methods(code);


--
-- Name: estimated_weights fk_ros_common_weight_estimation_method_code_estimated_weights; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.estimated_weights
    ADD CONSTRAINT fk_ros_common_weight_estimation_method_code_estimated_weights FOREIGN KEY (weight_estimation_method_code, type_of_measurement_code) REFERENCES refs_biological.measurement_tools(code, type_of_measurement_code);


--
-- Name: gn_observer_data_properties gnbsrvrdtprprtbsrvrdtd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.gn_observer_data_properties
    ADD CONSTRAINT gnbsrvrdtprprtbsrvrdtd FOREIGN KEY (observer_data_id) REFERENCES ros_gn.gn_observer_data(id);


--
-- Name: gn_observer_data_properties gnbsrvrdtprprtsprprtyd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.gn_observer_data_properties
    ADD CONSTRAINT gnbsrvrdtprprtsprprtyd FOREIGN KEY (property_id) REFERENCES ros_common.properties(id);


--
-- Name: gn_observer_data_transhipment_details gnbsrvrdttrnshbsrvrdtd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.gn_observer_data_transhipment_details
    ADD CONSTRAINT gnbsrvrdttrnshbsrvrdtd FOREIGN KEY (observer_data_id) REFERENCES ros_gn.gn_observer_data(id);


--
-- Name: gn_observer_data_transhipment_details gnbsrvrdttrnshpmntdtld; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.gn_observer_data_transhipment_details
    ADD CONSTRAINT gnbsrvrdttrnshpmntdtld FOREIGN KEY (transhipment_detail_id) REFERENCES ros_common.transhipment_details(id);


--
-- Name: general_vessel_and_trip_information gnrlvsslbsrvdtrpsmmryd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.general_vessel_and_trip_information
    ADD CONSTRAINT gnrlvsslbsrvdtrpsmmryd FOREIGN KEY (observed_trip_summary_id) REFERENCES ros_common.observed_trip_summary(id);


--
-- Name: general_vessel_and_trip_information gnrlvsslnbsrvrdntfctnd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.general_vessel_and_trip_information
    ADD CONSTRAINT gnrlvsslnbsrvrdntfctnd FOREIGN KEY (observer_identification_id) REFERENCES ros_common.observer_identification(id);


--
-- Name: general_vessel_and_trip_information gnrlvsslndbsrvrtrpdtld; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.general_vessel_and_trip_information
    ADD CONSTRAINT gnrlvsslndbsrvrtrpdtld FOREIGN KEY (observer_trip_detail_id) REFERENCES ros_common.observer_trip_details(id);


--
-- Name: general_vessel_and_trip_information gnrlvsslndtvsslttrbtsd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.general_vessel_and_trip_information
    ADD CONSTRAINT gnrlvsslndtvsslttrbtsd FOREIGN KEY (vessel_attributes_id) REFERENCES ros_common.vessel_attributes(id);


--
-- Name: general_vessel_and_trip_information gnrlvsslndvssldntfctnd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.general_vessel_and_trip_information
    ADD CONSTRAINT gnrlvsslndvssldntfctnd FOREIGN KEY (vessel_identification_id) REFERENCES ros_common.vessel_identification(id);


--
-- Name: general_vessel_and_trip_information gnrlvsslndvssllctrncsd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.general_vessel_and_trip_information
    ADD CONSTRAINT gnrlvsslndvssllctrncsd FOREIGN KEY (vessel_electronics_id) REFERENCES ros_common.vessel_electronics(id);


--
-- Name: general_vessel_and_trip_information gnrlvsslndvssltrpdtlsd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.general_vessel_and_trip_information
    ADD CONSTRAINT gnrlvsslndvssltrpdtlsd FOREIGN KEY (vessel_trip_details_id) REFERENCES ros_common.vessel_trip_details(id);


--
-- Name: general_vessel_and_trip_information gnrlvsvsslwnrndprsnnld; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.general_vessel_and_trip_information
    ADD CONSTRAINT gnrlvsvsslwnrndprsnnld FOREIGN KEY (vessel_owner_and_personnel_id) REFERENCES ros_common.vessel_owner_and_personnel(id);


--
-- Name: ll_observer_data_properties llbsrvrdtprprtbsrvrdtd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.ll_observer_data_properties
    ADD CONSTRAINT llbsrvrdtprprtbsrvrdtd FOREIGN KEY (observer_data_id) REFERENCES ros_ll.ll_observer_data(id);


--
-- Name: ll_observer_data_properties llbsrvrdtprprtsprprtyd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.ll_observer_data_properties
    ADD CONSTRAINT llbsrvrdtprprtsprprtyd FOREIGN KEY (property_id) REFERENCES ros_common.properties(id);


--
-- Name: ll_observer_data_transhipment_details llbsrvrdttrnshbsrvrdtd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.ll_observer_data_transhipment_details
    ADD CONSTRAINT llbsrvrdttrnshbsrvrdtd FOREIGN KEY (observer_data_id) REFERENCES ros_ll.ll_observer_data(id);


--
-- Name: ll_observer_data_transhipment_details llbsrvrdttrnshpmntdtld; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.ll_observer_data_transhipment_details
    ADD CONSTRAINT llbsrvrdttrnshpmntdtld FOREIGN KEY (transhipment_detail_id) REFERENCES ros_common.transhipment_details(id);


--
-- Name: pl_observer_data_daily_activities plbsrvrdtdlycdlyctvtyd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.pl_observer_data_daily_activities
    ADD CONSTRAINT plbsrvrdtdlycdlyctvtyd FOREIGN KEY (daily_activity_id) REFERENCES ros_common.daily_activities(id);


--
-- Name: pl_observer_data_daily_activities plbsrvrdtdlyctbsrvrdtd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.pl_observer_data_daily_activities
    ADD CONSTRAINT plbsrvrdtdlyctbsrvrdtd FOREIGN KEY (observer_data_id) REFERENCES ros_pl.pl_observer_data(id);


--
-- Name: pl_observer_data_properties plbsrvrdtprprtbsrvrdtd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.pl_observer_data_properties
    ADD CONSTRAINT plbsrvrdtprprtbsrvrdtd FOREIGN KEY (observer_data_id) REFERENCES ros_pl.pl_observer_data(id);


--
-- Name: pl_observer_data_properties plbsrvrdtprprtsprprtyd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.pl_observer_data_properties
    ADD CONSTRAINT plbsrvrdtprprtsprprtyd FOREIGN KEY (property_id) REFERENCES ros_common.properties(id);


--
-- Name: pl_observer_data_transhipment_details plbsrvrdttrnshbsrvrdtd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.pl_observer_data_transhipment_details
    ADD CONSTRAINT plbsrvrdttrnshbsrvrdtd FOREIGN KEY (observer_data_id) REFERENCES ros_pl.pl_observer_data(id);


--
-- Name: pl_observer_data_transhipment_details plbsrvrdttrnshpmntdtld; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.pl_observer_data_transhipment_details
    ADD CONSTRAINT plbsrvrdttrnshpmntdtld FOREIGN KEY (transhipment_detail_id) REFERENCES ros_common.transhipment_details(id);


--
-- Name: ps_observer_data_daily_activities psbsrvrdtdlycdlyctvtyd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.ps_observer_data_daily_activities
    ADD CONSTRAINT psbsrvrdtdlycdlyctvtyd FOREIGN KEY (daily_activity_id) REFERENCES ros_common.daily_activities(id);


--
-- Name: ps_observer_data_daily_activities psbsrvrdtdlyctbsrvrdtd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.ps_observer_data_daily_activities
    ADD CONSTRAINT psbsrvrdtdlyctbsrvrdtd FOREIGN KEY (observer_data_id) REFERENCES ros_ps.ps_observer_data(id);


--
-- Name: ps_observer_data_properties psbsrvrdtprprtbsrvrdtd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.ps_observer_data_properties
    ADD CONSTRAINT psbsrvrdtprprtbsrvrdtd FOREIGN KEY (observer_data_id) REFERENCES ros_ps.ps_observer_data(id);


--
-- Name: ps_observer_data_properties psbsrvrdtprprtsprprtyd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.ps_observer_data_properties
    ADD CONSTRAINT psbsrvrdtprprtsprprtyd FOREIGN KEY (property_id) REFERENCES ros_common.properties(id);


--
-- Name: ps_observer_data_transhipment_details psbsrvrdttrnshbsrvrdtd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.ps_observer_data_transhipment_details
    ADD CONSTRAINT psbsrvrdttrnshbsrvrdtd FOREIGN KEY (observer_data_id) REFERENCES ros_ps.ps_observer_data(id);


--
-- Name: ps_observer_data_transhipment_details psbsrvrdttrnshpmntdtld; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.ps_observer_data_transhipment_details
    ADD CONSTRAINT psbsrvrdttrnshpmntdtld FOREIGN KEY (transhipment_detail_id) REFERENCES ros_common.transhipment_details(id);


--
-- Name: reasons_for_days_lost rsnsfrdybsrvdtrpsmmryd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.reasons_for_days_lost
    ADD CONSTRAINT rsnsfrdybsrvdtrpsmmryd FOREIGN KEY (observed_trip_summary_id) REFERENCES ros_common.observed_trip_summary(id);


--
-- Name: transhipment_details trnshpcrrrvssldntfctnd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.transhipment_details
    ADD CONSTRAINT trnshpcrrrvssldntfctnd FOREIGN KEY (carrier_vessel_identification_id) REFERENCES ros_common.carrier_vessel_identification(id);


--
-- Name: transhipment_details_product_transhipped trnshpmntdspcsbyprdctd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.transhipment_details_product_transhipped
    ADD CONSTRAINT trnshpmntdspcsbyprdctd FOREIGN KEY (species_by_product_id) REFERENCES ros_common.species_by_product_type(id);


--
-- Name: transhipment_details_product_transhipped trnshpmnttrnshpmntdtld; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.transhipment_details_product_transhipped
    ADD CONSTRAINT trnshpmnttrnshpmntdtld FOREIGN KEY (transhipment_detail_id) REFERENCES ros_common.transhipment_details(id);


--
-- Name: vessel_attributes vesselattributesloa_id; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_attributes
    ADD CONSTRAINT vesselattributesloa_id FOREIGN KEY (loa_id) REFERENCES ros_common.lengths(id);


--
-- Name: vessel_attributes vsslattributestnnageid; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_attributes
    ADD CONSTRAINT vsslattributestnnageid FOREIGN KEY (tonnage_id) REFERENCES ros_common.tonnages(id);


--
-- Name: vessel_identification_email vssldntfcationemailmld; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_identification_email
    ADD CONSTRAINT vssldntfcationemailmld FOREIGN KEY (email_id) REFERENCES ros_common.texts(id);


--
-- Name: vessel_identification_phone vssldntfctionphonephnd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_identification_phone
    ADD CONSTRAINT vssldntfctionphonephnd FOREIGN KEY (phone_id) REFERENCES ros_common.texts(id);


--
-- Name: vessel_identification_licensed_target_species vssldntfctvssldntfctnd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_identification_licensed_target_species
    ADD CONSTRAINT vssldntfctvssldntfctnd FOREIGN KEY (vessel_identification_id) REFERENCES ros_common.vessel_identification(id);


--
-- Name: vessel_identification_fax vssldntfcvssldntfctndf; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_identification_fax
    ADD CONSTRAINT vssldntfcvssldntfctndf FOREIGN KEY (vessel_identification_id_fa) REFERENCES ros_common.vessel_identification(id);


--
-- Name: vessel_identification_email vssldntfcvssldntfctndm; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_identification_email
    ADD CONSTRAINT vssldntfcvssldntfctndm FOREIGN KEY (vessel_identification_id_em) REFERENCES ros_common.vessel_identification(id);


--
-- Name: vessel_identification_phone vssldntfvssldntfctndph; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_identification_phone
    ADD CONSTRAINT vssldntfvssldntfctndph FOREIGN KEY (vessel_identification_id_ph) REFERENCES ros_common.vessel_identification(id);


--
-- Name: vessel_identification_fax vssldntificationfaxfxd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_identification_fax
    ADD CONSTRAINT vssldntificationfaxfxd FOREIGN KEY (fax_id) REFERENCES ros_common.texts(id);


--
-- Name: vessel_attributes vsslttrbtfshstrgcpctyd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_attributes
    ADD CONSTRAINT vsslttrbtfshstrgcpctyd FOREIGN KEY (fish_storage_capacity_id) REFERENCES ros_common.capacities(id);


--
-- Name: vessel_attributes_main_engines vsslttrbtsmnngnsmnngnd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_attributes_main_engines
    ADD CONSTRAINT vsslttrbtsmnngnsmnngnd FOREIGN KEY (main_engine_id) REFERENCES ros_common.engines(id);


--
-- Name: vessel_attributes_main_engines vsslttrbtsvsslttrbtsdm; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_attributes_main_engines
    ADD CONSTRAINT vsslttrbtsvsslttrbtsdm FOREIGN KEY (vessel_attributes_id_me) REFERENCES ros_common.vessel_attributes(id);


--
-- Name: vessel_attributes vsslttrbutestnmyrngeid; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_attributes
    ADD CONSTRAINT vsslttrbutestnmyrngeid FOREIGN KEY (autonomy_range_id) REFERENCES ros_common.ranges(id);


--
-- Name: vessel_attributes_fish_preservation_method vsslttrbvsslttrbtsdfpm; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_attributes_fish_preservation_method
    ADD CONSTRAINT vsslttrbvsslttrbtsdfpm FOREIGN KEY (vessel_attributes_id_fpm) REFERENCES ros_common.vessel_attributes(id);


--
-- Name: vessel_attributes_fish_storage_type vsslttrbvsslttrbtsdfst; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_attributes_fish_storage_type
    ADD CONSTRAINT vsslttrbvsslttrbtsdfst FOREIGN KEY (vessel_attributes_id_fst) REFERENCES ros_common.vessel_attributes(id);


--
-- Name: vessel_owner_and_personnel vsslwnrndprchrtrrprtrd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_owner_and_personnel
    ADD CONSTRAINT vsslwnrndprchrtrrprtrd FOREIGN KEY (charter_or_operator_id) REFERENCES ros_common.person_contact_details(id);


--
-- Name: vessel_owner_and_personnel vsslwnrndprsfshngmstrd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_owner_and_personnel
    ADD CONSTRAINT vsslwnrndprsfshngmstrd FOREIGN KEY (fishing_master_id) REFERENCES ros_common.person_details(id);


--
-- Name: vessel_owner_and_personnel vsslwnrndprsnnelskpprd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_owner_and_personnel
    ADD CONSTRAINT vsslwnrndprsnnelskpprd FOREIGN KEY (skipper_id) REFERENCES ros_common.person_details(id);


--
-- Name: vessel_owner_and_personnel vsslwnrnrgstrdvsslwnrd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.vessel_owner_and_personnel
    ADD CONSTRAINT vsslwnrnrgstrdvsslwnrd FOREIGN KEY (registered_vessel_owner_id) REFERENCES ros_common.person_contact_details(id);


--
-- Name: waste_managements wsgnrlvsslndtrpnfrmtnd; Type: FK CONSTRAINT; Schema: ros_common; Owner: ros-admin
--

ALTER TABLE ONLY ros_common.waste_managements
    ADD CONSTRAINT wsgnrlvsslndtrpnfrmtnd FOREIGN KEY (general_vessel_and_trip_information_id) REFERENCES ros_common.general_vessel_and_trip_information(id);


--
-- Name: gn_specimens ddtnlspcmndtlsnntrgtsp; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_specimens
    ADD CONSTRAINT ddtnlspcmndtlsnntrgtsp FOREIGN KEY (additional_specimen_details_non_target_species_id) REFERENCES ros_common.additional_details_on_non_target_species(id);


--
-- Name: gn_catch_details fk_ros_gn_estimated_weight_sampling_method_code_gn_catch_detail; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_catch_details
    ADD CONSTRAINT fk_ros_gn_estimated_weight_sampling_method_code_gn_catch_detail FOREIGN KEY (estimated_weight_sampling_method_code) REFERENCES refs_biological.sampling_methods_for_catch_estimation(code);


--
-- Name: gn_catch_details fk_ros_gn_fates_code_gn_catch_details; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_catch_details
    ADD CONSTRAINT fk_ros_gn_fates_code_gn_catch_details FOREIGN KEY (fates_code, type_of_fate_code) REFERENCES refs_biological.fates(code, type_of_fate_code);


--
-- Name: gillnet_configuration fk_ros_gn_float_type_code_gillnet_configuration; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gillnet_configuration
    ADD CONSTRAINT fk_ros_gn_float_type_code_gillnet_configuration FOREIGN KEY (float_type_code) REFERENCES refs_fishery.float_types(code);


--
-- Name: gn_additional_catch_details_on_ssi fk_ros_gn_gear_interaction_code_gn_additional_catch_details_on_; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_additional_catch_details_on_ssi
    ADD CONSTRAINT fk_ros_gn_gear_interaction_code_gn_additional_catch_details_on_ FOREIGN KEY (gear_interaction_code) REFERENCES refs_biological.gear_interactions(code);


--
-- Name: gillnet_configuration fk_ros_gn_gillnet_material_type_code_gillnet_configuration; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gillnet_configuration
    ADD CONSTRAINT fk_ros_gn_gillnet_material_type_code_gillnet_configuration FOREIGN KEY (gillnet_material_type_code) REFERENCES refs_fishery.gillnet_material_types(code);


--
-- Name: gn_additional_catch_details_on_ssi fk_ros_gn_handling_method_code_gn_additional_catch_details_on_s; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_additional_catch_details_on_ssi
    ADD CONSTRAINT fk_ros_gn_handling_method_code_gn_additional_catch_details_on_s FOREIGN KEY (handling_method_code) REFERENCES refs_biological.handling_methods(code);


--
-- Name: gn_mitigation_measures_mitigation_devices fk_ros_gn_mitigation_device_code_gn_mitigation_measures_mitigat; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_mitigation_measures_mitigation_devices
    ADD CONSTRAINT fk_ros_gn_mitigation_device_code_gn_mitigation_measures_mitigat FOREIGN KEY (mitigation_device_code) REFERENCES refs_fishery.mitigation_devices(code);


--
-- Name: gn_gillnet_configuration_net_web_colours fk_ros_gn_net_colour_code_gn_gillnet_configuration_net_web_colo; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_gillnet_configuration_net_web_colours
    ADD CONSTRAINT fk_ros_gn_net_colour_code_gn_gillnet_configuration_net_web_colo FOREIGN KEY (net_colour_code) REFERENCES refs_fishery.net_colours(code);


--
-- Name: gn_hauling_operations fk_ros_gn_net_condition_code_gn_hauling_operations; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_hauling_operations
    ADD CONSTRAINT fk_ros_gn_net_condition_code_gn_hauling_operations FOREIGN KEY (net_condition_code) REFERENCES refs_fishery.net_conditions(code);


--
-- Name: gn_setting_operations fk_ros_gn_net_configuration_code_gn_setting_operations; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_setting_operations
    ADD CONSTRAINT fk_ros_gn_net_configuration_code_gn_setting_operations FOREIGN KEY (net_configuration_code) REFERENCES refs_fishery.net_configurations(code);


--
-- Name: gn_setting_operations fk_ros_gn_net_deploy_depth_code_gn_setting_operations; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_setting_operations
    ADD CONSTRAINT fk_ros_gn_net_deploy_depth_code_gn_setting_operations FOREIGN KEY (net_deploy_depth_code) REFERENCES refs_fishery.net_deploy_depths(code);


--
-- Name: gn_setting_operations fk_ros_gn_net_setting_strategy_code_gn_setting_operations; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_setting_operations
    ADD CONSTRAINT fk_ros_gn_net_setting_strategy_code_gn_setting_operations FOREIGN KEY (net_setting_strategy_code) REFERENCES refs_fishery.net_setting_strategies(code);


--
-- Name: gn_observer_data fk_ros_gn_reporting_country_code_gn_observer_data; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_observer_data
    ADD CONSTRAINT fk_ros_gn_reporting_country_code_gn_observer_data FOREIGN KEY (reporting_country_code) REFERENCES refs_admin.countries(code);


--
-- Name: gn_hauling_operations fk_ros_gn_sampling_protocol_code_gn_hauling_operations; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_hauling_operations
    ADD CONSTRAINT fk_ros_gn_sampling_protocol_code_gn_hauling_operations FOREIGN KEY (sampling_protocol_code) REFERENCES refs_biological.sampling_protocols(code);


--
-- Name: sinkers_by_type fk_ros_gn_sinker_material_type_code_sinkers_by_type; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.sinkers_by_type
    ADD CONSTRAINT fk_ros_gn_sinker_material_type_code_sinkers_by_type FOREIGN KEY (sinker_material_type_code) REFERENCES refs_fishery.sinker_material_types(code);


--
-- Name: gn_catch_details fk_ros_gn_species_code_gn_catch_details; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_catch_details
    ADD CONSTRAINT fk_ros_gn_species_code_gn_catch_details FOREIGN KEY (species_code) REFERENCES refs_biological.species(code);


--
-- Name: gn_tag_details fk_ros_gn_tag_type_code_gn_tag_details; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_tag_details
    ADD CONSTRAINT fk_ros_gn_tag_type_code_gn_tag_details FOREIGN KEY (tag_type_code) REFERENCES refs_biological.tag_types(code);


--
-- Name: gillnet_configuration gllntcnfdstncbtwnfltsd; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gillnet_configuration
    ADD CONSTRAINT gllntcnfdstncbtwnfltsd FOREIGN KEY (distance_between_floats_id) REFERENCES ros_common.distances(id);


--
-- Name: gillnet_configuration gllntcnfggllntcnfgrtnd; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gillnet_configuration
    ADD CONSTRAINT gllntcnfggllntcnfgrtnd FOREIGN KEY (gillnet_configuration_id) REFERENCES ros_gn.gn_gear_specifications(id);


--
-- Name: gillnet_configuration gllntcnfgrationntdpthd; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gillnet_configuration
    ADD CONSTRAINT gllntcnfgrationntdpthd FOREIGN KEY (net_depth_id) REFERENCES ros_common.depths(id);


--
-- Name: gillnet_configuration gllntcnfgrdrplnslngthd; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gillnet_configuration
    ADD CONSTRAINT gllntcnfgrdrplnslngthd FOREIGN KEY (droplines_length_id) REFERENCES ros_common.lengths(id);


--
-- Name: gillnet_configuration gllntcnfgrtionntlngthd; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gillnet_configuration
    ADD CONSTRAINT gllntcnfgrtionntlngthd FOREIGN KEY (net_length_id) REFERENCES ros_common.lengths(id);


--
-- Name: gn_observer_data gnbserverdatacreatorid; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_observer_data
    ADD CONSTRAINT gnbserverdatacreatorid FOREIGN KEY (creator_id) REFERENCES ros_common.iotc_person_contact_details(id);


--
-- Name: gn_observer_data gnbserverdatasbmtterid; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_observer_data
    ADD CONSTRAINT gnbserverdatasbmtterid FOREIGN KEY (submitter_id) REFERENCES ros_common.iotc_person_contact_details(id);


--
-- Name: gn_observer_data gnbsrvrdtgngrspcfctnsd; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_observer_data
    ADD CONSTRAINT gnbsrvrdtgngrspcfctnsd FOREIGN KEY (gn_gear_specifications_id) REFERENCES ros_gn.gn_gear_specifications(id);


--
-- Name: gn_observer_data gnbsrvvsslndtrpnfrmtnd; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_observer_data
    ADD CONSTRAINT gnbsrvvsslndtrpnfrmtnd FOREIGN KEY (vessel_and_trip_information_id) REFERENCES ros_common.general_vessel_and_trip_information(id);


--
-- Name: gn_catch_details gnctchdtlsgnfshngvntid; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_catch_details
    ADD CONSTRAINT gnctchdtlsgnfshngvntid FOREIGN KEY (gn_fishing_event_id) REFERENCES ros_gn.gn_fishing_events(id);


--
-- Name: gn_catch_details gnctchdtlsstmtdwightid; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_catch_details
    ADD CONSTRAINT gnctchdtlsstmtdwightid FOREIGN KEY (estimated_weight_id) REFERENCES ros_common.estimated_weights(id);


--
-- Name: gn_fishing_events gnfshngvntgnsttngprtnd; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_fishing_events
    ADD CONSTRAINT gnfshngvntgnsttngprtnd FOREIGN KEY (gn_setting_operation_id) REFERENCES ros_gn.gn_setting_operations(id);


--
-- Name: gn_fishing_events gnfshngvntsgnbsrvrdtid; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_fishing_events
    ADD CONSTRAINT gnfshngvntsgnbsrvrdtid FOREIGN KEY (gn_observer_data_id) REFERENCES ros_gn.gn_observer_data(id);


--
-- Name: gn_fishing_events gnfshngvntsgnhlngprtnd; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_fishing_events
    ADD CONSTRAINT gnfshngvntsgnhlngprtnd FOREIGN KEY (gn_hauling_operation_id) REFERENCES ros_gn.gn_hauling_operations(id);


--
-- Name: gn_fishing_events gnfshngvntsgnmtgtnmsrd; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_fishing_events
    ADD CONSTRAINT gnfshngvntsgnmtgtnmsrd FOREIGN KEY (gn_mitigation_measure_id) REFERENCES ros_gn.gn_mitigation_measures(id);


--
-- Name: gn_gillnet_configuration_net_web_colours gnglgngllntcnfgrtndnwc; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_gillnet_configuration_net_web_colours
    ADD CONSTRAINT gnglgngllntcnfgrtndnwc FOREIGN KEY (gn_gillnet_configuration_id_nwc) REFERENCES ros_gn.gillnet_configuration(id);


--
-- Name: gn_gillnet_configuration_stretched_mesh_sizes gnglgngllntcnfgrtndsms; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_gillnet_configuration_stretched_mesh_sizes
    ADD CONSTRAINT gnglgngllntcnfgrtndsms FOREIGN KEY (gn_gillnet_configuration_id_sms) REFERENCES ros_gn.gillnet_configuration(id);


--
-- Name: gn_gillnet_configuration_stretched_mesh_sizes gngllntcnstrtchdmshszd; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_gillnet_configuration_stretched_mesh_sizes
    ADD CONSTRAINT gngllntcnstrtchdmshszd FOREIGN KEY (stretched_mesh_size_id) REFERENCES ros_common.sizes(id);


--
-- Name: gn_specimens gngnddtnlctchdtlsnsssd; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_specimens
    ADD CONSTRAINT gngnddtnlctchdtlsnsssd FOREIGN KEY (gn_additional_catch_details_on_ssis_id) REFERENCES ros_gn.gn_additional_catch_details_on_ssi(id);


--
-- Name: gn_gear_specifications gngrspcfctgnspclqpmntd; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_gear_specifications
    ADD CONSTRAINT gngrspcfctgnspclqpmntd FOREIGN KEY (gn_special_equipment_id) REFERENCES ros_gn.gn_special_equipment(id);


--
-- Name: gn_mitigation_measures_mitigation_devices gnmtgtnmsrsmtmtgtnmsrd; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_mitigation_measures_mitigation_devices
    ADD CONSTRAINT gnmtgtnmsrsmtmtgtnmsrd FOREIGN KEY (mitigation_measure_id) REFERENCES ros_gn.gn_mitigation_measures(id);


--
-- Name: gn_specimens gnspcimensgntgdetailid; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_specimens
    ADD CONSTRAINT gnspcimensgntgdetailid FOREIGN KEY (gn_tag_detail_id) REFERENCES ros_gn.gn_tag_details(id);


--
-- Name: gn_specimens gnspcmnsbmtrcnfrmtonid; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_specimens
    ADD CONSTRAINT gnspcmnsbmtrcnfrmtonid FOREIGN KEY (biometric_information_id) REFERENCES ros_common.biometric_information(id);


--
-- Name: gn_specimens gnspcmnsgnctchdetailid; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_specimens
    ADD CONSTRAINT gnspcmnsgnctchdetailid FOREIGN KEY (gn_catch_detail_id) REFERENCES ros_gn.gn_catch_details(id);


--
-- Name: gn_specimens gnspcmnsgndprdtndtilid; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_specimens
    ADD CONSTRAINT gnspcmnsgndprdtndtilid FOREIGN KEY (gn_depredation_detail_id) REFERENCES ros_common.depredation_details(id);


--
-- Name: gn_tag_details gntagdetailstgfinderid; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.gn_tag_details
    ADD CONSTRAINT gntagdetailstgfinderid FOREIGN KEY (tag_finder_id) REFERENCES ros_common.person_contact_details(id);


--
-- Name: sinkers_by_type snkrsbygngllntcnfgrtnd; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.sinkers_by_type
    ADD CONSTRAINT snkrsbygngllntcnfgrtnd FOREIGN KEY (gn_gillnet_configuration_id) REFERENCES ros_gn.gillnet_configuration(id);


--
-- Name: sinkers_by_type snkrsbytypvrgsnkrwghtd; Type: FK CONSTRAINT; Schema: ros_gn; Owner: ros-admin
--

ALTER TABLE ONLY ros_gn.sinkers_by_type
    ADD CONSTRAINT snkrsbytypvrgsnkrwghtd FOREIGN KEY (average_sinker_weight_id) REFERENCES ros_common.weights(id);


--
-- Name: branchline_sections brnchlnbrnchlncnfgrtnd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.branchline_sections
    ADD CONSTRAINT brnchlnbrnchlncnfgrtnd FOREIGN KEY (branchline_configuration_id) REFERENCES ros_ll.branchline_configurations(id);


--
-- Name: branchline_configurations brnchlncnllgrspcfctnsd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.branchline_configurations
    ADD CONSTRAINT brnchlncnllgrspcfctnsd FOREIGN KEY (ll_gear_specifications_id) REFERENCES ros_ll.ll_gear_specifications(id);


--
-- Name: branchline_sections brnchlnesectionsdmtrid; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.branchline_sections
    ADD CONSTRAINT brnchlnesectionsdmtrid FOREIGN KEY (diameter_id) REFERENCES ros_common.diameters(id);


--
-- Name: branchline_sections brnchlnesectionslngthd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.branchline_sections
    ADD CONSTRAINT brnchlnesectionslngthd FOREIGN KEY (length_id) REFERENCES ros_common.lengths(id);


--
-- Name: branchlines_set brnchlnssllsttngprtnsd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.branchlines_set
    ADD CONSTRAINT brnchlnssllsttngprtnsd FOREIGN KEY (ll_setting_operations_id) REFERENCES ros_ll.ll_setting_operations(id);


--
-- Name: biteoffs_by_branchlines_set btffsbybrncllhlngprtnd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.biteoffs_by_branchlines_set
    ADD CONSTRAINT btffsbybrncllhlngprtnd FOREIGN KEY (ll_hauling_operation_id) REFERENCES ros_ll.ll_hauling_operations(id);


--
-- Name: baits_by_conditions btsbycndtllsttngprtnsd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.baits_by_conditions
    ADD CONSTRAINT btsbycndtllsttngprtnsd FOREIGN KEY (ll_setting_operations_id) REFERENCES ros_ll.ll_setting_operations(id);


--
-- Name: ll_specimens ddtnlspcmndtlsnntrgtsp; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_specimens
    ADD CONSTRAINT ddtnlspcmndtlsnntrgtsp FOREIGN KEY (additional_specimen_details_non_target_species_id) REFERENCES ros_common.additional_details_on_non_target_species(id);


--
-- Name: baits_by_conditions fk_ros_ll_bait_condition_code_baits_by_conditions; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.baits_by_conditions
    ADD CONSTRAINT fk_ros_ll_bait_condition_code_baits_by_conditions FOREIGN KEY (bait_condition_code) REFERENCES refs_biological.bait_conditions(code);


--
-- Name: ll_additional_catch_details_on_ssi fk_ros_ll_bait_condition_code_ll_additional_catch_details_on_ss; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_additional_catch_details_on_ssi
    ADD CONSTRAINT fk_ros_ll_bait_condition_code_ll_additional_catch_details_on_ss FOREIGN KEY (bait_condition_code) REFERENCES refs_biological.bait_conditions(code);


--
-- Name: branchline_sections fk_ros_ll_branchline_material_type_code_branchline_sections; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.branchline_sections
    ADD CONSTRAINT fk_ros_ll_branchline_material_type_code_branchline_sections FOREIGN KEY (branchline_material_type_code) REFERENCES refs_fishery.line_material_types(code);


--
-- Name: ll_additional_catch_details_on_ssi fk_ros_ll_dehooker_device_code_ll_additional_catch_details_on_s; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_additional_catch_details_on_ssi
    ADD CONSTRAINT fk_ros_ll_dehooker_device_code_ll_additional_catch_details_on_s FOREIGN KEY (dehooker_device_code) REFERENCES refs_fishery.dehooker_types(code);


--
-- Name: ll_catch_details fk_ros_ll_estimated_weight_sampling_method_code_ll_catch_detail; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_catch_details
    ADD CONSTRAINT fk_ros_ll_estimated_weight_sampling_method_code_ll_catch_detail FOREIGN KEY (estimated_weight_sampling_method_code) REFERENCES refs_biological.sampling_methods_for_catch_estimation(code);


--
-- Name: ll_catch_details fk_ros_ll_fates_code_ll_catch_details; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_catch_details
    ADD CONSTRAINT fk_ros_ll_fates_code_ll_catch_details FOREIGN KEY (fates_code, type_of_fate_code) REFERENCES refs_biological.fates(code, type_of_fate_code);


--
-- Name: ll_additional_catch_details_on_ssi fk_ros_ll_gear_interaction_code_ll_additional_catch_details_on_; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_additional_catch_details_on_ssi
    ADD CONSTRAINT fk_ros_ll_gear_interaction_code_ll_additional_catch_details_on_ FOREIGN KEY (gear_interaction_code) REFERENCES refs_biological.gear_interactions(code);


--
-- Name: ll_additional_catch_details_on_ssi fk_ros_ll_handling_method_code_ll_additional_catch_details_on_s; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_additional_catch_details_on_ssi
    ADD CONSTRAINT fk_ros_ll_handling_method_code_ll_additional_catch_details_on_s FOREIGN KEY (handling_method_code) REFERENCES refs_biological.handling_methods(code);


--
-- Name: hooks_by_type fk_ros_ll_hook_type_code_hooks_by_type; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.hooks_by_type
    ADD CONSTRAINT fk_ros_ll_hook_type_code_hooks_by_type FOREIGN KEY (hook_type_code) REFERENCES refs_fishery.hook_types(code);


--
-- Name: ll_additional_catch_details_on_ssi fk_ros_ll_leader_material_type_code_ll_additional_catch_details; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_additional_catch_details_on_ssi
    ADD CONSTRAINT fk_ros_ll_leader_material_type_code_ll_additional_catch_details FOREIGN KEY (leader_material_type_code) REFERENCES refs_fishery.line_material_types(code);


--
-- Name: lights_by_type_and_colour fk_ros_ll_light_colour_code_lights_by_type_and_colour; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.lights_by_type_and_colour
    ADD CONSTRAINT fk_ros_ll_light_colour_code_lights_by_type_and_colour FOREIGN KEY (light_colour_code) REFERENCES refs_fishery.light_colours(code);


--
-- Name: lights_by_type_and_colour fk_ros_ll_light_type_code_lights_by_type_and_colour; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.lights_by_type_and_colour
    ADD CONSTRAINT fk_ros_ll_light_type_code_lights_by_type_and_colour FOREIGN KEY (light_type_code) REFERENCES refs_fishery.light_types(code);


--
-- Name: ll_general_gear_attributes fk_ros_ll_line_material_type_code_ll_general_gear_attributes; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_general_gear_attributes
    ADD CONSTRAINT fk_ros_ll_line_material_type_code_ll_general_gear_attributes FOREIGN KEY (line_material_type_code) REFERENCES refs_fishery.line_material_types(code);


--
-- Name: ll_gear_specifications_mitigation_device fk_ros_ll_mitigation_device_code_ll_gear_specifications_mitigat; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_gear_specifications_mitigation_device
    ADD CONSTRAINT fk_ros_ll_mitigation_device_code_ll_gear_specifications_mitigat FOREIGN KEY (mitigation_device_code) REFERENCES refs_fishery.mitigation_devices(code);


--
-- Name: ll_mitigation_measures_mitigation_devices fk_ros_ll_mitigation_device_code_ll_mitigation_measures_mitigat; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_mitigation_measures_mitigation_devices
    ADD CONSTRAINT fk_ros_ll_mitigation_device_code_ll_mitigation_measures_mitigat FOREIGN KEY (mitigation_device_code) REFERENCES refs_fishery.mitigation_devices(code);


--
-- Name: ll_observer_data fk_ros_ll_reporting_country_code_ll_observer_data; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_observer_data
    ADD CONSTRAINT fk_ros_ll_reporting_country_code_ll_observer_data FOREIGN KEY (reporting_country_code) REFERENCES refs_admin.countries(code);


--
-- Name: ll_hauling_operations fk_ros_ll_sampling_protocol_code_ll_hauling_operations; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_hauling_operations
    ADD CONSTRAINT fk_ros_ll_sampling_protocol_code_ll_hauling_operations FOREIGN KEY (sampling_protocol_code) REFERENCES refs_biological.sampling_protocols(code);


--
-- Name: baits_by_conditions fk_ros_ll_species_code_baits_by_conditions; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.baits_by_conditions
    ADD CONSTRAINT fk_ros_ll_species_code_baits_by_conditions FOREIGN KEY (species_code) REFERENCES refs_biological.species(code);


--
-- Name: ll_catch_details fk_ros_ll_species_code_ll_catch_details; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_catch_details
    ADD CONSTRAINT fk_ros_ll_species_code_ll_catch_details FOREIGN KEY (species_code) REFERENCES refs_biological.species(code);


--
-- Name: ll_hauling_operations_stunning_methods fk_ros_ll_stunning_method_code_ll_hauling_operations_stunning_m; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_hauling_operations_stunning_methods
    ADD CONSTRAINT fk_ros_ll_stunning_method_code_ll_hauling_operations_stunning_m FOREIGN KEY (stunning_method_code) REFERENCES refs_fishery.stunning_methods(code);


--
-- Name: ll_tag_details fk_ros_ll_tag_type_code_ll_tag_details; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_tag_details
    ADD CONSTRAINT fk_ros_ll_tag_type_code_ll_tag_details FOREIGN KEY (tag_type_code) REFERENCES refs_biological.tag_types(code);


--
-- Name: ll_setting_operations_target_species fk_ros_ll_target_species_code_ll_setting_operations_target_spec; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_setting_operations_target_species
    ADD CONSTRAINT fk_ros_ll_target_species_code_ll_setting_operations_target_spec FOREIGN KEY (target_species_code) REFERENCES refs_biological.species(code);


--
-- Name: floatlines fltlnesfltlinelengthid; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.floatlines
    ADD CONSTRAINT fltlnesfltlinelengthid FOREIGN KEY (floatline_length_id) REFERENCES ros_common.lengths(id);


--
-- Name: floatlines fltlnsllsttngprationid; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.floatlines
    ADD CONSTRAINT fltlnsllsttngprationid FOREIGN KEY (ll_setting_operation_id) REFERENCES ros_ll.ll_setting_operations(id);


--
-- Name: hooks_by_type hksbytypllsttngprtnsid; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.hooks_by_type
    ADD CONSTRAINT hksbytypllsttngprtnsid FOREIGN KEY (ll_setting_operations_id) REFERENCES ros_ll.ll_setting_operations(id);


--
-- Name: lights_by_type_and_colour lghtsbytypllsttngprtnd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.lights_by_type_and_colour
    ADD CONSTRAINT lghtsbytypllsttngprtnd FOREIGN KEY (ll_setting_operation_id) REFERENCES ros_ll.ll_setting_operations(id);


--
-- Name: ll_observer_data llbserverdatacreatorid; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_observer_data
    ADD CONSTRAINT llbserverdatacreatorid FOREIGN KEY (creator_id) REFERENCES ros_common.iotc_person_contact_details(id);


--
-- Name: ll_observer_data llbserverdatasbmtterid; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_observer_data
    ADD CONSTRAINT llbserverdatasbmtterid FOREIGN KEY (submitter_id) REFERENCES ros_common.iotc_person_contact_details(id);


--
-- Name: ll_observer_data llbsrvrdtllgrspcfctnsd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_observer_data
    ADD CONSTRAINT llbsrvrdtllgrspcfctnsd FOREIGN KEY (ll_gear_specifications_id) REFERENCES ros_ll.ll_gear_specifications(id);


--
-- Name: ll_observer_data llbsrvvsslndtrpnfrmtnd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_observer_data
    ADD CONSTRAINT llbsrvvsslndtrpnfrmtnd FOREIGN KEY (vessel_and_trip_information_id) REFERENCES ros_common.general_vessel_and_trip_information(id);


--
-- Name: ll_catch_details llctchdtlsllfshngvntid; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_catch_details
    ADD CONSTRAINT llctchdtlsllfshngvntid FOREIGN KEY (ll_fishing_event_id) REFERENCES ros_ll.ll_fishing_events(id);


--
-- Name: ll_catch_details llctchdtlsstmtdwightid; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_catch_details
    ADD CONSTRAINT llctchdtlsstmtdwightid FOREIGN KEY (estimated_weight_id) REFERENCES ros_common.estimated_weights(id);


--
-- Name: ll_additional_catch_details_on_ssi llddtnlctchldrthcknssd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_additional_catch_details_on_ssi
    ADD CONSTRAINT llddtnlctchldrthcknssd FOREIGN KEY (leader_thickness_id) REFERENCES ros_common.thicknesses(id);


--
-- Name: ll_fishing_events llfshngvntllsttngprtnd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_fishing_events
    ADD CONSTRAINT llfshngvntllsttngprtnd FOREIGN KEY (ll_setting_operation_id) REFERENCES ros_ll.ll_setting_operations(id);


--
-- Name: ll_fishing_events llfshngvntsllbsrvrdtid; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_fishing_events
    ADD CONSTRAINT llfshngvntsllbsrvrdtid FOREIGN KEY (ll_observer_data_id) REFERENCES ros_ll.ll_observer_data(id);


--
-- Name: ll_fishing_events llfshngvntsllhlngprtnd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_fishing_events
    ADD CONSTRAINT llfshngvntsllhlngprtnd FOREIGN KEY (ll_hauling_operation_id) REFERENCES ros_ll.ll_hauling_operations(id);


--
-- Name: ll_fishing_events llfshngvntsllmtgtnmsrd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_fishing_events
    ADD CONSTRAINT llfshngvntsllmtgtnmsrd FOREIGN KEY (ll_mitigation_measure_id) REFERENCES ros_ll.ll_mitigation_measures(id);


--
-- Name: ll_general_gear_attributes llgnrlgrttrbmnlnlngthd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_general_gear_attributes
    ADD CONSTRAINT llgnrlgrttrbmnlnlngthd FOREIGN KEY (mainline_length_id) REFERENCES ros_common.lengths(id);


--
-- Name: ll_general_gear_attributes llgnrlgrttrbtmnlndmtrd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_general_gear_attributes
    ADD CONSTRAINT llgnrlgrttrbtmnlndmtrd FOREIGN KEY (mainline_diameter_id) REFERENCES ros_common.diameters(id);


--
-- Name: ll_gear_specifications llgrspcfctionstrlndtld; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_gear_specifications
    ADD CONSTRAINT llgrspcfctionstrlndtld FOREIGN KEY (tori_line_detail_id) REFERENCES ros_ll.tori_line_details(id);


--
-- Name: ll_gear_specifications_mitigation_device llgrspcfctllgrspcfctnd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_gear_specifications_mitigation_device
    ADD CONSTRAINT llgrspcfctllgrspcfctnd FOREIGN KEY (ll_gear_specification_id) REFERENCES ros_ll.ll_gear_specifications(id);


--
-- Name: ll_gear_specifications llgrspcfctllspclqpmntd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_gear_specifications
    ADD CONSTRAINT llgrspcfctllspclqpmntd FOREIGN KEY (ll_special_equipment_id) REFERENCES ros_ll.ll_special_equipment(id);


--
-- Name: ll_gear_specifications llgrspcllgnrlgrttrbtsd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_gear_specifications
    ADD CONSTRAINT llgrspcllgnrlgrttrbtsd FOREIGN KEY (ll_general_gear_attributes_id) REFERENCES ros_ll.ll_general_gear_attributes(id);


--
-- Name: ll_hauling_offal_disposal_positions llhlngffldsllhlngprtnd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_hauling_offal_disposal_positions
    ADD CONSTRAINT llhlngffldsllhlngprtnd FOREIGN KEY (ll_hauling_operation_id) REFERENCES ros_ll.ll_hauling_operations(id);


--
-- Name: ll_hauling_operations_stunning_methods llhlngprtnsllhlngprtnd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_hauling_operations_stunning_methods
    ADD CONSTRAINT llhlngprtnsllhlngprtnd FOREIGN KEY (ll_hauling_operation_id) REFERENCES ros_ll.ll_hauling_operations(id);


--
-- Name: ll_specimens llllddtnlctchdtlsnsssd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_specimens
    ADD CONSTRAINT llllddtnlctchdtlsnsssd FOREIGN KEY (ll_additional_catch_details_on_ssis_id) REFERENCES ros_ll.ll_additional_catch_details_on_ssi(id);


--
-- Name: ll_mitigation_measures llmtgtnbrnchlnvrgwghtd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_mitigation_measures
    ADD CONSTRAINT llmtgtnbrnchlnvrgwghtd FOREIGN KEY (branchline_average_weight_id) REFERENCES ros_common.weights(id);


--
-- Name: ll_mitigation_measures llmtgtnmsrhksnkrdstncd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_mitigation_measures
    ADD CONSTRAINT llmtgtnmsrhksnkrdstncd FOREIGN KEY (hook_sinker_distance_id) REFERENCES ros_common.distances(id);


--
-- Name: ll_mitigation_measures_mitigation_devices llmtgtnmsrsllmtgtnmsrd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_mitigation_measures_mitigation_devices
    ADD CONSTRAINT llmtgtnmsrsllmtgtnmsrd FOREIGN KEY (ll_mitigation_measure_id) REFERENCES ros_ll.ll_mitigation_measures(id);


--
-- Name: ll_specimens llspcimenslltgdetailid; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_specimens
    ADD CONSTRAINT llspcimenslltgdetailid FOREIGN KEY (ll_tag_detail_id) REFERENCES ros_ll.ll_tag_details(id);


--
-- Name: ll_specimens llspcmnsbmtrcnfrmtonid; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_specimens
    ADD CONSTRAINT llspcmnsbmtrcnfrmtonid FOREIGN KEY (biometric_information_id) REFERENCES ros_common.biometric_information(id);


--
-- Name: ll_specimens llspcmnsllctchdetailid; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_specimens
    ADD CONSTRAINT llspcmnsllctchdetailid FOREIGN KEY (ll_catch_detail_id) REFERENCES ros_ll.ll_catch_details(id);


--
-- Name: ll_specimens llspcmnslldprdtndtilid; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_specimens
    ADD CONSTRAINT llspcmnslldprdtndtilid FOREIGN KEY (ll_depredation_detail_id) REFERENCES ros_common.depredation_details(id);


--
-- Name: ll_setting_operations_target_species llsttngprllsttngprtnsd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_setting_operations_target_species
    ADD CONSTRAINT llsttngprllsttngprtnsd FOREIGN KEY (ll_setting_operations_id) REFERENCES ros_ll.ll_setting_operations(id);


--
-- Name: ll_setting_operations llsttngprtmnlnstlngthd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_setting_operations
    ADD CONSTRAINT llsttngprtmnlnstlngthd FOREIGN KEY (mainline_set_length_id) REFERENCES ros_common.lengths(id);


--
-- Name: ll_tag_details lltagdetailstgfinderid; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.ll_tag_details
    ADD CONSTRAINT lltagdetailstgfinderid FOREIGN KEY (tag_finder_id) REFERENCES ros_common.person_contact_details(id);


--
-- Name: tori_line_details trlndtailstrlnlengthid; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.tori_line_details
    ADD CONSTRAINT trlndtailstrlnlengthid FOREIGN KEY (tori_line_length_id) REFERENCES ros_common.lengths(id);


--
-- Name: tori_line_details trlndtailsttchdhightid; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.tori_line_details
    ADD CONSTRAINT trlndtailsttchdhightid FOREIGN KEY (attached_height_id) REFERENCES ros_common.heights(id);


--
-- Name: tori_line_details trlndtlsstrmrdstanceid; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.tori_line_details
    ADD CONSTRAINT trlndtlsstrmrdstanceid FOREIGN KEY (streamer_distance_id) REFERENCES ros_common.distances(id);


--
-- Name: tori_line_details trlndtlstrmrlnlngthmnd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.tori_line_details
    ADD CONSTRAINT trlndtlstrmrlnlngthmnd FOREIGN KEY (streamer_line_length_min_id) REFERENCES ros_common.lengths(id);


--
-- Name: tori_line_details trlndtlstrmrlnlngthmxd; Type: FK CONSTRAINT; Schema: ros_ll; Owner: ros-admin
--

ALTER TABLE ONLY ros_ll.tori_line_details
    ADD CONSTRAINT trlndtlstrmrlnlngthmxd FOREIGN KEY (streamer_line_length_max_id) REFERENCES ros_common.lengths(id);


--
-- Name: ros_focal_points fk_ros_focal_points_ros_focal_points_logins; Type: FK CONSTRAINT; Schema: ros_meta; Owner: ros-admin
--

ALTER TABLE ONLY ros_meta.ros_focal_points
    ADD CONSTRAINT fk_ros_focal_points_ros_focal_points_logins FOREIGN KEY (login_id) REFERENCES ros_meta.ros_focal_points_logins(id);


--
-- Name: ros_observers_2_flags fk_ros_meta_flag_code_ros_observers_2_flags; Type: FK CONSTRAINT; Schema: ros_meta; Owner: ros-admin
--

ALTER TABLE ONLY ros_meta.ros_observers_2_flags
    ADD CONSTRAINT fk_ros_meta_flag_code_ros_observers_2_flags FOREIGN KEY (flag_code) REFERENCES refs_admin.countries(code);


--
-- Name: ros_observers fk_ros_meta_nationality_code_ros_observers; Type: FK CONSTRAINT; Schema: ros_meta; Owner: ros-admin
--

ALTER TABLE ONLY ros_meta.ros_observers
    ADD CONSTRAINT fk_ros_meta_nationality_code_ros_observers FOREIGN KEY (nationality_code) REFERENCES refs_admin.countries(code);


--
-- Name: ros_focal_points fk_ros_meta_responsible_flag_code_ros_focal_points; Type: FK CONSTRAINT; Schema: ros_meta; Owner: ros-admin
--

ALTER TABLE ONLY ros_meta.ros_focal_points
    ADD CONSTRAINT fk_ros_meta_responsible_flag_code_ros_focal_points FOREIGN KEY (responsible_flag_code) REFERENCES refs_admin.countries(code);


--
-- Name: ros_observers_2_flags fk_ros_observers_2_flags_ros_observers; Type: FK CONSTRAINT; Schema: ros_meta; Owner: ros-admin
--

ALTER TABLE ONLY ros_meta.ros_observers_2_flags
    ADD CONSTRAINT fk_ros_observers_2_flags_ros_observers FOREIGN KEY (iotc_number) REFERENCES ros_meta.ros_observers(iotc_number) ON DELETE CASCADE;


--
-- Name: ros_observers fk_ros_observers_ros_observers_logins; Type: FK CONSTRAINT; Schema: ros_meta; Owner: ros-admin
--

ALTER TABLE ONLY ros_meta.ros_observers
    ADD CONSTRAINT fk_ros_observers_ros_observers_logins FOREIGN KEY (login_id) REFERENCES ros_meta.ros_observers_logins(id) ON DELETE CASCADE;


--
-- Name: bait_fishing_operations btfshngpdstncfrmthcstd; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.bait_fishing_operations
    ADD CONSTRAINT btfshngpdstncfrmthcstd FOREIGN KEY (distance_from_the_coast_id) REFERENCES ros_common.distances(id);


--
-- Name: bait_fishing_operations btfshngprtionsvntdpthd; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.bait_fishing_operations
    ADD CONSTRAINT btfshngprtionsvntdpthd FOREIGN KEY (event_depth_id) REFERENCES ros_common.depths(id);


--
-- Name: bait_fishing_operations_cl_school_sighting_cues btfshngprtplfshngprtnd; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.bait_fishing_operations_cl_school_sighting_cues
    ADD CONSTRAINT btfshngprtplfshngprtnd FOREIGN KEY (pl_fishing_operation_id) REFERENCES ros_pl.bait_fishing_operations(id);


--
-- Name: bait_fishing_events btfshngvntsplbjctdtlid; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.bait_fishing_events
    ADD CONSTRAINT btfshngvntsplbjctdtlid FOREIGN KEY (pl_object_detail_id) REFERENCES ros_pl.pl_object_details(id);


--
-- Name: bait_fishing_events btfshngvntsplbsrvrdtid; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.bait_fishing_events
    ADD CONSTRAINT btfshngvntsplbsrvrdtid FOREIGN KEY (pl_observer_data_id) REFERENCES ros_pl.pl_observer_data(id);


--
-- Name: bait_fishing_events btfshngvplbtfshngprtnd; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.bait_fishing_events
    ADD CONSTRAINT btfshngvplbtfshngprtnd FOREIGN KEY (pl_bait_fishing_operation_id) REFERENCES ros_pl.bait_fishing_operations(id);


--
-- Name: pl_specimens ddtnlspcmndtlsnntrgtsp; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_specimens
    ADD CONSTRAINT ddtnlspcmndtlsnntrgtsp FOREIGN KEY (additional_specimen_details_non_target_species_id) REFERENCES ros_common.additional_details_on_non_target_species(id);


--
-- Name: baits_and_conditions fk_ros_pl_bait_condition_code_baits_and_conditions; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.baits_and_conditions
    ADD CONSTRAINT fk_ros_pl_bait_condition_code_baits_and_conditions FOREIGN KEY (bait_condition_code) REFERENCES refs_biological.bait_conditions(code);


--
-- Name: bait_fishing_operations fk_ros_pl_bait_fishing_method_code_bait_fishing_operations; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.bait_fishing_operations
    ADD CONSTRAINT fk_ros_pl_bait_fishing_method_code_bait_fishing_operations FOREIGN KEY (bait_fishing_method_code) REFERENCES refs_fishery.bait_fishing_methods(code);


--
-- Name: bait_fishing_operations fk_ros_pl_bait_school_detection_method_code_bait_fishing_operat; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.bait_fishing_operations
    ADD CONSTRAINT fk_ros_pl_bait_school_detection_method_code_bait_fishing_operat FOREIGN KEY (bait_school_detection_method_code) REFERENCES refs_fishery.bait_school_detection_methods(code);


--
-- Name: pl_catch_details fk_ros_pl_estimated_weight_sampling_method_code_pl_catch_detail; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_catch_details
    ADD CONSTRAINT fk_ros_pl_estimated_weight_sampling_method_code_pl_catch_detail FOREIGN KEY (estimated_weight_sampling_method_code) REFERENCES refs_biological.sampling_methods_for_catch_estimation(code);


--
-- Name: pl_catch_details fk_ros_pl_fates_code_pl_catch_details; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_catch_details
    ADD CONSTRAINT fk_ros_pl_fates_code_pl_catch_details FOREIGN KEY (fates_code, type_of_fate_code) REFERENCES refs_biological.fates(code, type_of_fate_code);


--
-- Name: pl_additional_catch_details_on_ssi fk_ros_pl_gear_interaction_code_pl_additional_catch_details_on_; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_additional_catch_details_on_ssi
    ADD CONSTRAINT fk_ros_pl_gear_interaction_code_pl_additional_catch_details_on_ FOREIGN KEY (gear_interaction_code) REFERENCES refs_biological.gear_interactions(code);


--
-- Name: pl_additional_catch_details_on_ssi fk_ros_pl_handling_method_code_pl_additional_catch_details_on_s; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_additional_catch_details_on_ssi
    ADD CONSTRAINT fk_ros_pl_handling_method_code_pl_additional_catch_details_on_s FOREIGN KEY (handling_method_code) REFERENCES refs_biological.handling_methods(code);


--
-- Name: lures_or_jiggers_by_type fk_ros_pl_hook_type_code_lures_or_jiggers_by_type; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.lures_or_jiggers_by_type
    ADD CONSTRAINT fk_ros_pl_hook_type_code_lures_or_jiggers_by_type FOREIGN KEY (hook_type_code) REFERENCES refs_fishery.hook_types(code);


--
-- Name: pl_general_gear_attributes fk_ros_pl_hook_type_code_pl_general_gear_attributes; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_general_gear_attributes
    ADD CONSTRAINT fk_ros_pl_hook_type_code_pl_general_gear_attributes FOREIGN KEY (hook_type_code) REFERENCES refs_fishery.hook_types(code);


--
-- Name: pl_observer_data fk_ros_pl_reporting_country_code_pl_observer_data; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_observer_data
    ADD CONSTRAINT fk_ros_pl_reporting_country_code_pl_observer_data FOREIGN KEY (reporting_country_code) REFERENCES refs_admin.countries(code);


--
-- Name: bait_fishing_operations fk_ros_pl_sampling_protocol_code_bait_fishing_operations; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.bait_fishing_operations
    ADD CONSTRAINT fk_ros_pl_sampling_protocol_code_bait_fishing_operations FOREIGN KEY (sampling_protocol_code) REFERENCES refs_biological.sampling_protocols(code);


--
-- Name: pl_tuna_fishing_operations fk_ros_pl_sampling_protocol_code_pl_tuna_fishing_operations; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_tuna_fishing_operations
    ADD CONSTRAINT fk_ros_pl_sampling_protocol_code_pl_tuna_fishing_operations FOREIGN KEY (sampling_protocol_code) REFERENCES refs_biological.sampling_protocols(code);


--
-- Name: bait_fishing_operations_cl_school_sighting_cues fk_ros_pl_school_sighting_cue_code_bait_fishing_operations_cl_s; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.bait_fishing_operations_cl_school_sighting_cues
    ADD CONSTRAINT fk_ros_pl_school_sighting_cue_code_bait_fishing_operations_cl_s FOREIGN KEY (school_sighting_cue_code) REFERENCES refs_fishery.school_sighting_cues(code);


--
-- Name: pl_tuna_fishing_operations_cl_school_sighting_cues fk_ros_pl_school_sighting_cue_code_pl_tuna_fishing_operations_c; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_tuna_fishing_operations_cl_school_sighting_cues
    ADD CONSTRAINT fk_ros_pl_school_sighting_cue_code_pl_tuna_fishing_operations_c FOREIGN KEY (school_sighting_cue_code) REFERENCES refs_fishery.school_sighting_cues(code);


--
-- Name: baits_and_conditions fk_ros_pl_species_code_baits_and_conditions; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.baits_and_conditions
    ADD CONSTRAINT fk_ros_pl_species_code_baits_and_conditions FOREIGN KEY (species_code) REFERENCES refs_biological.species(code);


--
-- Name: pl_catch_details fk_ros_pl_species_code_pl_catch_details; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_catch_details
    ADD CONSTRAINT fk_ros_pl_species_code_pl_catch_details FOREIGN KEY (species_code) REFERENCES refs_biological.species(code);


--
-- Name: pl_tag_details fk_ros_pl_tag_type_code_pl_tag_details; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_tag_details
    ADD CONSTRAINT fk_ros_pl_tag_type_code_pl_tag_details FOREIGN KEY (tag_type_code) REFERENCES refs_biological.tag_types(code);


--
-- Name: pl_tuna_fishing_operations_target_species fk_ros_pl_target_species_code_pl_tuna_fishing_operations_target; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_tuna_fishing_operations_target_species
    ADD CONSTRAINT fk_ros_pl_target_species_code_pl_tuna_fishing_operations_target FOREIGN KEY (target_species_code) REFERENCES refs_biological.species(code);


--
-- Name: bait_fishing_operations fk_ros_pl_wind_scale_code_bait_fishing_operations; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.bait_fishing_operations
    ADD CONSTRAINT fk_ros_pl_wind_scale_code_bait_fishing_operations FOREIGN KEY (wind_scale_code) REFERENCES refs_fishery.wind_scales(code);


--
-- Name: pl_tuna_fishing_operations fk_ros_pl_wind_scale_code_pl_tuna_fishing_operations; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_tuna_fishing_operations
    ADD CONSTRAINT fk_ros_pl_wind_scale_code_pl_tuna_fishing_operations FOREIGN KEY (wind_scale_code) REFERENCES refs_fishery.wind_scales(code);


--
-- Name: lures_or_jiggers_by_type lrsrjggplgnrlgrttrbtsd; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.lures_or_jiggers_by_type
    ADD CONSTRAINT lrsrjggplgnrlgrttrbtsd FOREIGN KEY (pl_general_gear_attributes_id) REFERENCES ros_pl.pl_general_gear_attributes(id);


--
-- Name: pl_observer_data plbserverdatacreatorid; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_observer_data
    ADD CONSTRAINT plbserverdatacreatorid FOREIGN KEY (creator_id) REFERENCES ros_common.iotc_person_contact_details(id);


--
-- Name: pl_observer_data plbserverdatasbmtterid; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_observer_data
    ADD CONSTRAINT plbserverdatasbmtterid FOREIGN KEY (submitter_id) REFERENCES ros_common.iotc_person_contact_details(id);


--
-- Name: pl_observer_data plbsrvrdtplgrspcfctnsd; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_observer_data
    ADD CONSTRAINT plbsrvrdtplgrspcfctnsd FOREIGN KEY (pl_gear_specifications_id) REFERENCES ros_pl.pl_gear_specifications(id);


--
-- Name: pl_observer_data plbsrvvsslndtrpnfrmtnd; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_observer_data
    ADD CONSTRAINT plbsrvvsslndtrpnfrmtnd FOREIGN KEY (vessel_and_trip_information_id) REFERENCES ros_common.general_vessel_and_trip_information(id);


--
-- Name: pl_bait_fishing_event_pl_catch_detail plbtfshngplbtfshngvntd; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_bait_fishing_event_pl_catch_detail
    ADD CONSTRAINT plbtfshngplbtfshngvntd FOREIGN KEY (pl_bait_fishing_event_id) REFERENCES ros_pl.bait_fishing_events(id);


--
-- Name: pl_bait_fishing_event_pl_catch_detail plbtfshngvntplctchdtld; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_bait_fishing_event_pl_catch_detail
    ADD CONSTRAINT plbtfshngvntplctchdtld FOREIGN KEY (pl_catch_detail_id) REFERENCES ros_pl.pl_catch_details(id);


--
-- Name: pl_catch_details plctchdtlsstmtdwightid; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_catch_details
    ADD CONSTRAINT plctchdtlsstmtdwightid FOREIGN KEY (estimated_weight_id) REFERENCES ros_common.estimated_weights(id);


--
-- Name: pl_gear_specifications plgrspcfctplspclqpmntd; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_gear_specifications
    ADD CONSTRAINT plgrspcfctplspclqpmntd FOREIGN KEY (pl_special_equipment_id) REFERENCES ros_pl.pl_special_equipment(id);


--
-- Name: pl_gear_specifications plgrspcplgnrlgrttrbtsd; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_gear_specifications
    ADD CONSTRAINT plgrspcplgnrlgrttrbtsd FOREIGN KEY (pl_general_gear_attributes_id) REFERENCES ros_pl.pl_general_gear_attributes(id);


--
-- Name: pl_specimens plplddtnlctchdtlsnsssd; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_specimens
    ADD CONSTRAINT plplddtnlctchdtlsnsssd FOREIGN KEY (pl_additional_catch_details_on_ssis_id) REFERENCES ros_pl.pl_additional_catch_details_on_ssi(id);


--
-- Name: pl_specimens plspcimenspltgdetailid; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_specimens
    ADD CONSTRAINT plspcimenspltgdetailid FOREIGN KEY (pl_tag_detail_id) REFERENCES ros_pl.pl_tag_details(id);


--
-- Name: pl_specimens plspcmnsbmtrcnfrmtonid; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_specimens
    ADD CONSTRAINT plspcmnsbmtrcnfrmtonid FOREIGN KEY (biometric_information_id) REFERENCES ros_common.biometric_information(id);


--
-- Name: pl_specimens plspcmnsplctchdetailid; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_specimens
    ADD CONSTRAINT plspcmnsplctchdetailid FOREIGN KEY (pl_catch_detail_id) REFERENCES ros_pl.pl_catch_details(id);


--
-- Name: pl_specimens plspcmnspldprdtndtilid; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_specimens
    ADD CONSTRAINT plspcmnspldprdtndtilid FOREIGN KEY (pl_depredation_detail_id) REFERENCES ros_common.depredation_details(id);


--
-- Name: pl_tag_details pltagdetailstgfinderid; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_tag_details
    ADD CONSTRAINT pltagdetailstgfinderid FOREIGN KEY (tag_finder_id) REFERENCES ros_common.person_contact_details(id);


--
-- Name: pl_tuna_fishing_event_pl_catch_detail pltnfshngpltnfshngvntd; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_tuna_fishing_event_pl_catch_detail
    ADD CONSTRAINT pltnfshngpltnfshngvntd FOREIGN KEY (pl_tuna_fishing_event_id) REFERENCES ros_pl.tuna_fishing_events(id);


--
-- Name: pl_tuna_fishing_operations_cl_school_sighting_cues pltnfshngpplfshngprtnd; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_tuna_fishing_operations_cl_school_sighting_cues
    ADD CONSTRAINT pltnfshngpplfshngprtnd FOREIGN KEY (pl_fishing_operation_id) REFERENCES ros_pl.pl_tuna_fishing_operations(id);


--
-- Name: pl_tuna_fishing_operations pltnfshngprtbtndcndtnd; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_tuna_fishing_operations
    ADD CONSTRAINT pltnfshngprtbtndcndtnd FOREIGN KEY (bait_and_condition_id) REFERENCES ros_pl.baits_and_conditions(id);


--
-- Name: pl_tuna_fishing_event_pl_catch_detail pltnfshngvntplctchdtld; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_tuna_fishing_event_pl_catch_detail
    ADD CONSTRAINT pltnfshngvntplctchdtld FOREIGN KEY (pl_catch_detail_id) REFERENCES ros_pl.pl_catch_details(id);


--
-- Name: pl_tuna_fishing_operations_target_species pltnfshpltnfshngprtnd2; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.pl_tuna_fishing_operations_target_species
    ADD CONSTRAINT pltnfshpltnfshngprtnd2 FOREIGN KEY (pl_tuna_fishing_operation_id2) REFERENCES ros_pl.pl_tuna_fishing_operations(id);


--
-- Name: tuna_fishing_events tnfshngvntsplbjctdtlid; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.tuna_fishing_events
    ADD CONSTRAINT tnfshngvntsplbjctdtlid FOREIGN KEY (pl_object_detail_id) REFERENCES ros_pl.pl_object_details(id);


--
-- Name: tuna_fishing_events tnfshngvntsplbsrvrdtid; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.tuna_fishing_events
    ADD CONSTRAINT tnfshngvntsplbsrvrdtid FOREIGN KEY (pl_observer_data_id) REFERENCES ros_pl.pl_observer_data(id);


--
-- Name: tuna_fishing_events tnfshngvpltnfshngprtnd; Type: FK CONSTRAINT; Schema: ros_pl; Owner: ros-admin
--

ALTER TABLE ONLY ros_pl.tuna_fishing_events
    ADD CONSTRAINT tnfshngvpltnfshngprtnd FOREIGN KEY (pl_tuna_fishing_operation_id) REFERENCES ros_pl.pl_tuna_fishing_operations(id);


--
-- Name: current_details crrntdtlspssttngprtnid; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.current_details
    ADD CONSTRAINT crrntdtlspssttngprtnid FOREIGN KEY (ps_setting_operation_id) REFERENCES ros_ps.ps_setting_operations(id);


--
-- Name: cetaceans_whale_shark_sightings ctcnswhlshpssttngprtnd; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.cetaceans_whale_shark_sightings
    ADD CONSTRAINT ctcnswhlshpssttngprtnd FOREIGN KEY (ps_setting_operation_id) REFERENCES ros_ps.ps_setting_operations(id);


--
-- Name: ps_specimens ddtnlspcmndtlsnntrgtsp; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_specimens
    ADD CONSTRAINT ddtnlspcmndtlsnntrgtsp FOREIGN KEY (additional_specimen_details_non_target_species_id) REFERENCES ros_common.additional_details_on_non_target_species(id);


--
-- Name: ps_catch_details fk_ros_ps_estimated_weight_sampling_method_code_ps_catch_detail; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_catch_details
    ADD CONSTRAINT fk_ros_ps_estimated_weight_sampling_method_code_ps_catch_detail FOREIGN KEY (estimated_weight_sampling_method_code) REFERENCES refs_biological.sampling_methods_for_catch_estimation(code);


--
-- Name: ps_object_details fk_ros_ps_fad_raft_design_code_ps_object_details; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_object_details
    ADD CONSTRAINT fk_ros_ps_fad_raft_design_code_ps_object_details FOREIGN KEY (fad_raft_design_code) REFERENCES refs_fishery.fad_raft_designs(code);


--
-- Name: ps_object_details fk_ros_ps_fad_tail_design_code_ps_object_details; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_object_details
    ADD CONSTRAINT fk_ros_ps_fad_tail_design_code_ps_object_details FOREIGN KEY (fad_tail_design_code) REFERENCES refs_fishery.fad_tail_designs(code);


--
-- Name: ps_catch_details fk_ros_ps_fates_code_ps_catch_details; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_catch_details
    ADD CONSTRAINT fk_ros_ps_fates_code_ps_catch_details FOREIGN KEY (fates_code, type_of_fate_code) REFERENCES refs_biological.fates(code, type_of_fate_code);


--
-- Name: ps_setting_operations fk_ros_ps_first_school_detection_method_code_ps_setting_operati; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_setting_operations
    ADD CONSTRAINT fk_ros_ps_first_school_detection_method_code_ps_setting_operati FOREIGN KEY (first_school_detection_method_code) REFERENCES refs_fishery.school_detection_methods(code);


--
-- Name: ps_additional_catch_details_on_ssi fk_ros_ps_gear_interaction_code_ps_additional_catch_details_on_; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_additional_catch_details_on_ssi
    ADD CONSTRAINT fk_ros_ps_gear_interaction_code_ps_additional_catch_details_on_ FOREIGN KEY (gear_interaction_code) REFERENCES refs_biological.gear_interactions(code);


--
-- Name: ps_additional_catch_details_on_ssi fk_ros_ps_handling_method_code_ps_additional_catch_details_on_s; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_additional_catch_details_on_ssi
    ADD CONSTRAINT fk_ros_ps_handling_method_code_ps_additional_catch_details_on_s FOREIGN KEY (handling_method_code) REFERENCES refs_biological.handling_methods(code);


--
-- Name: ps_observer_data fk_ros_ps_reporting_country_code_ps_observer_data; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_observer_data
    ADD CONSTRAINT fk_ros_ps_reporting_country_code_ps_observer_data FOREIGN KEY (reporting_country_code) REFERENCES refs_admin.countries(code);


--
-- Name: ps_setting_operations_cl_school_sighting_cues fk_ros_ps_school_sighting_cue_code_ps_setting_operations_cl_sch; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_setting_operations_cl_school_sighting_cues
    ADD CONSTRAINT fk_ros_ps_school_sighting_cue_code_ps_setting_operations_cl_sch FOREIGN KEY (school_sighting_cue_code) REFERENCES refs_fishery.school_sighting_cues(code);


--
-- Name: cetaceans_whale_shark_sightings fk_ros_ps_species_code_cetaceans_whale_shark_sightings; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.cetaceans_whale_shark_sightings
    ADD CONSTRAINT fk_ros_ps_species_code_cetaceans_whale_shark_sightings FOREIGN KEY (species_code) REFERENCES refs_biological.species(code);


--
-- Name: ps_catch_details fk_ros_ps_species_code_ps_catch_details; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_catch_details
    ADD CONSTRAINT fk_ros_ps_species_code_ps_catch_details FOREIGN KEY (species_code) REFERENCES refs_biological.species(code);


--
-- Name: ps_tag_details fk_ros_ps_tag_type_code_ps_tag_details; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_tag_details
    ADD CONSTRAINT fk_ros_ps_tag_type_code_ps_tag_details FOREIGN KEY (tag_type_code) REFERENCES refs_biological.tag_types(code);


--
-- Name: ps_setting_operations fk_ros_ps_wind_scale_code_ps_setting_operations; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_setting_operations
    ADD CONSTRAINT fk_ros_ps_wind_scale_code_ps_setting_operations FOREIGN KEY (wind_scale_code) REFERENCES refs_fishery.wind_scales(code);


--
-- Name: ps_observer_data psbserverdatacreatorid; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_observer_data
    ADD CONSTRAINT psbserverdatacreatorid FOREIGN KEY (creator_id) REFERENCES ros_common.iotc_person_contact_details(id);


--
-- Name: ps_observer_data psbserverdatasbmtterid; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_observer_data
    ADD CONSTRAINT psbserverdatasbmtterid FOREIGN KEY (submitter_id) REFERENCES ros_common.iotc_person_contact_details(id);


--
-- Name: ps_observer_data psbsrvrdtpsgrspcfctnsd; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_observer_data
    ADD CONSTRAINT psbsrvrdtpsgrspcfctnsd FOREIGN KEY (ps_gear_specifications_id) REFERENCES ros_ps.ps_gear_specifications(id);


--
-- Name: ps_observer_data psbsrvvsslndtrpnfrmtnd; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_observer_data
    ADD CONSTRAINT psbsrvvsslndtrpnfrmtnd FOREIGN KEY (vessel_and_trip_information_id) REFERENCES ros_common.general_vessel_and_trip_information(id);


--
-- Name: ps_catch_details psctchdtlspsfshngvntid; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_catch_details
    ADD CONSTRAINT psctchdtlspsfshngvntid FOREIGN KEY (ps_fishing_event_id) REFERENCES ros_ps.ps_fishing_events(id);


--
-- Name: ps_catch_details psctchdtlsstmtdwightid; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_catch_details
    ADD CONSTRAINT psctchdtlsstmtdwightid FOREIGN KEY (estimated_weight_id) REFERENCES ros_common.estimated_weights(id);


--
-- Name: ps_catch_details psddtnlctchdtlsnntrgts; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_catch_details
    ADD CONSTRAINT psddtnlctchdtlsnntrgts FOREIGN KEY (ps_additional_catch_details_non_target_species_id) REFERENCES ros_common.additional_details_on_non_target_species(id);


--
-- Name: ps_fishing_events psfshngvntpssttngprtnd; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_fishing_events
    ADD CONSTRAINT psfshngvntpssttngprtnd FOREIGN KEY (ps_setting_operation_id) REFERENCES ros_ps.ps_setting_operations(id);


--
-- Name: ps_fishing_events psfshngvntspsbsrvrdtid; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_fishing_events
    ADD CONSTRAINT psfshngvntspsbsrvrdtid FOREIGN KEY (ps_observer_data_id) REFERENCES ros_ps.ps_observer_data(id);


--
-- Name: ps_general_gear_attributes psgnrlbntstrtchdmshszd; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_general_gear_attributes
    ADD CONSTRAINT psgnrlbntstrtchdmshszd FOREIGN KEY (bunt_stretched_mesh_size_id) REFERENCES ros_common.sizes(id);


--
-- Name: ps_general_gear_attributes psgnrlgrttmxmmntlngthd; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_general_gear_attributes
    ADD CONSTRAINT psgnrlgrttmxmmntlngthd FOREIGN KEY (maximum_net_length_id) REFERENCES ros_common.lengths(id);


--
-- Name: ps_general_gear_attributes psgnrlgrttrbtsskffpwrd; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_general_gear_attributes
    ADD CONSTRAINT psgnrlgrttrbtsskffpwrd FOREIGN KEY (skiff_power_id) REFERENCES ros_common.powers(id);


--
-- Name: ps_general_gear_attributes psgnrlgrttrmxmmntdpthd; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_general_gear_attributes
    ADD CONSTRAINT psgnrlgrttrmxmmntdpthd FOREIGN KEY (maximum_net_depth_id) REFERENCES ros_common.depths(id);


--
-- Name: ps_general_gear_attributes psgnrmdntstrtchdmshszd; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_general_gear_attributes
    ADD CONSTRAINT psgnrmdntstrtchdmshszd FOREIGN KEY (mid_net_stretched_mesh_size_id) REFERENCES ros_common.sizes(id);


--
-- Name: ps_gear_specifications psgrspcfctpsspclqpmntd; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_gear_specifications
    ADD CONSTRAINT psgrspcfctpsspclqpmntd FOREIGN KEY (ps_special_equipment_id) REFERENCES ros_ps.ps_special_equipment(id);


--
-- Name: ps_gear_specifications psgrspcpsgnrlgrttrbtsd; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_gear_specifications
    ADD CONSTRAINT psgrspcpsgnrlgrttrbtsd FOREIGN KEY (ps_general_gear_attributes_id) REFERENCES ros_ps.ps_general_gear_attributes(id);


--
-- Name: ps_specimens pspsddtnlctchdtlsnsssd; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_specimens
    ADD CONSTRAINT pspsddtnlctchdtlsnsssd FOREIGN KEY (ps_additional_catch_details_on_ssis_id) REFERENCES ros_ps.ps_additional_catch_details_on_ssi(id);


--
-- Name: ps_specimens psspcimenspstgdetailid; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_specimens
    ADD CONSTRAINT psspcimenspstgdetailid FOREIGN KEY (ps_tag_detail_id) REFERENCES ros_ps.ps_tag_details(id);


--
-- Name: ps_specimens psspcmnsbmtrcnfrmtonid; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_specimens
    ADD CONSTRAINT psspcmnsbmtrcnfrmtonid FOREIGN KEY (biometric_information_id) REFERENCES ros_common.biometric_information(id);


--
-- Name: ps_specimens psspcmnspsctchdetailid; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_specimens
    ADD CONSTRAINT psspcmnspsctchdetailid FOREIGN KEY (ps_catch_detail_id) REFERENCES ros_ps.ps_catch_details(id);


--
-- Name: ps_setting_operations pssttngprtnspsbjctdtld; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_setting_operations
    ADD CONSTRAINT pssttngprtnspsbjctdtld FOREIGN KEY (ps_object_detail_id) REFERENCES ros_ps.ps_object_details(id);


--
-- Name: ps_setting_operations_cl_school_sighting_cues pssttngprtpssttngprtnd; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_setting_operations_cl_school_sighting_cues
    ADD CONSTRAINT pssttngprtpssttngprtnd FOREIGN KEY (ps_setting_operation_id) REFERENCES ros_ps.ps_setting_operations(id);


--
-- Name: ps_tag_details pstagdetailstgfinderid; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.ps_tag_details
    ADD CONSTRAINT pstagdetailstgfinderid FOREIGN KEY (tag_finder_id) REFERENCES ros_common.person_contact_details(id);


--
-- Name: support_vessel_details spprtvssldpssttngprtnd; Type: FK CONSTRAINT; Schema: ros_ps; Owner: ros-admin
--

ALTER TABLE ONLY ros_ps.support_vessel_details
    ADD CONSTRAINT spprtvssldpssttngprtnd FOREIGN KEY (ps_setting_operation_id) REFERENCES ros_ps.ps_setting_operations(id);


--
-- PostgreSQL database dump complete
--

