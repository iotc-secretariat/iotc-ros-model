-- Generated ROS refs_* missing tables script
-- Generated at: 2026-06-23 13:55:18 +0200

-- ================================================================
-- CREATE SCHEMA / CREATE TABLE
-- ================================================================

-- ----------------------------------------------------------------
-- refs_meta.codelists_versions
-- ----------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS "refs_meta";

CREATE TABLE "refs_meta"."codelists_versions" (
  "cl_schema" varchar(255) NOT NULL,
  "cl_name" varchar(255) NOT NULL,
  "version" integer NOT NULL,
  "last_update" timestamp without time zone NOT NULL,
  "url" text,
  "current_doi" text NOT NULL
);

-- ----------------------------------------------------------------
-- refs_biology.biological_materials
-- ----------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS "refs_biology";

CREATE TABLE "refs_biology"."biological_materials" (
  "code" varchar( 10) NOT NULL,
  "name_en" varchar(100) NOT NULL,
  "name_fr" varchar(100) NOT NULL
);

-- ----------------------------------------------------------------
-- refs_biology.fish_status
-- ----------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS "refs_biology";

CREATE TABLE "refs_biology"."fish_status" (
  "code" varchar(  3) NOT NULL,
  "name_en" varchar(255) NOT NULL,
  "name_fr" varchar(255) NOT NULL,
  "description_en" varchar(255) NOT NULL,
  "description_fr" varchar(255) NOT NULL
);

-- ----------------------------------------------------------------
-- refs_biology.maturity_stages
-- ----------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS "refs_biology";

CREATE TABLE "refs_biology"."maturity_stages" (
  "code" varchar(  4) NOT NULL,
  "name_en" varchar(100) NOT NULL,
  "name_fr" varchar(100) NOT NULL,
  "description_male_en" varchar(255) NOT NULL,
  "description_male_fr" varchar(255) NOT NULL,
  "description_female_en" varchar(255) NOT NULL,
  "description_female_fr" varchar(300) NOT NULL
);

-- ----------------------------------------------------------------
-- refs_biology.recommended_measurements
-- ----------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS "refs_biology";

CREATE TABLE "refs_biology"."recommended_measurements" (
  "species_code" varchar(16) NOT NULL,
  "type_of_measurement_code" char( 2) NOT NULL,
  "measurement_code" char( 2) NOT NULL,
  "default_measurement_interval" smallint NOT NULL,
  "max_measurement_interval" smallint NOT NULL,
  "min_measurement" smallint NOT NULL,
  "max_measurement" smallint NOT NULL
);

-- ----------------------------------------------------------------
-- refs_biology.sample_preservation_methods
-- ----------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS "refs_biology";

CREATE TABLE "refs_biology"."sample_preservation_methods" (
  "code" varchar(  4) NOT NULL,
  "name_en" varchar(100) NOT NULL,
  "name_fr" varchar(100) NOT NULL,
  "description_en" varchar(255) NOT NULL,
  "description_fr" varchar(255) NOT NULL
);

-- ----------------------------------------------------------------
-- refs_data.logical_responses
-- ----------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS "refs_data";

CREATE TABLE "refs_data"."logical_responses" (
  "code" varchar(  5) NOT NULL,
  "name_en" varchar(255) NOT NULL,
  "name_fr" varchar(255) NOT NULL,
  "description_en" varchar(255) NOT NULL,
  "description_fr" varchar(255) NOT NULL
);

-- ----------------------------------------------------------------
-- refs_fishery.buoy_models
-- ----------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS "refs_fishery";

CREATE TABLE "refs_fishery"."buoy_models" (
  "code" varchar( 10) NOT NULL,
  "name_en" varchar( 50) NOT NULL,
  "is_echo_sounder" boolean NOT NULL,
  "brand" varchar( 20) NOT NULL,
  "start_year" integer,
  "comment" varchar(255),
  "active" boolean DEFAULT true NOT NULL
);

-- ----------------------------------------------------------------
-- refs_fishery.dfad_biodegradability_categories
-- ----------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS "refs_fishery";

CREATE TABLE "refs_fishery"."dfad_biodegradability_categories" (
  "code" varchar(  4) NOT NULL,
  "name_en" varchar( 15) NOT NULL,
  "name_fr" varchar( 15) NOT NULL,
  "description_en" varchar(300) NOT NULL,
  "description_fr" varchar(300) NOT NULL,
  "state" varchar( 10) NOT NULL
);

-- ----------------------------------------------------------------
-- refs_fishery.gear_types_deprecated
-- ----------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS "refs_fishery";

CREATE TABLE "refs_fishery"."gear_types_deprecated" (
  "code" char(  3) NOT NULL,
  "name_en" varchar(255) NOT NULL,
  "name_fr" varchar(255) NOT NULL
);

-- ----------------------------------------------------------------
-- refs_fishery.hook_and_terminal_devices
-- ----------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS "refs_fishery";

CREATE TABLE "refs_fishery"."hook_and_terminal_devices" (
  "code" char(   3) NOT NULL,
  "name_en" varchar( 255) NOT NULL,
  "name_fr" varchar( 255) NOT NULL,
  "description_en" varchar(4096) NOT NULL,
  "description_fr" varchar(4096) NOT NULL
);

-- ----------------------------------------------------------------
-- refs_fishery.mechanisation_types
-- ----------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS "refs_fishery";

CREATE TABLE "refs_fishery"."mechanisation_types" (
  "code" char(   2) NOT NULL,
  "name_en" varchar( 255) NOT NULL,
  "name_fr" varchar( 255) NOT NULL,
  "is_mechanized" smallint NOT NULL,
  "description_en" varchar(4096) NOT NULL,
  "description_fr" varchar(4096) NOT NULL
);

-- ----------------------------------------------------------------
-- refs_fishery.net_material_types
-- ----------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS "refs_fishery";

CREATE TABLE "refs_fishery"."net_material_types" (
  "code" char(   2) NOT NULL,
  "code_orig" varchar(   3) NOT NULL,
  "name_en" varchar( 255) NOT NULL,
  "name_fr" varchar( 255) NOT NULL,
  "description_en" varchar(4096) NOT NULL,
  "description_fr" varchar(4096) NOT NULL
);

-- ----------------------------------------------------------------
-- refs_fishery.vessel_measurement_types
-- ----------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS "refs_fishery";

CREATE TABLE "refs_fishery"."vessel_measurement_types" (
  "code" char(   2) NOT NULL,
  "name_en" varchar( 255) NOT NULL,
  "name_fr" varchar( 255) NOT NULL,
  "description_en" varchar(4096) NOT NULL,
  "description_fr" varchar(4096) NOT NULL
);

-- ----------------------------------------------------------------
-- refs_fishery_config.fishery_purposes
-- ----------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS "refs_fishery_config";

CREATE TABLE "refs_fishery_config"."fishery_purposes" (
  "code" char(  3) NOT NULL,
  "name_en" varchar( 64) NOT NULL,
  "name_fr" varchar( 64) NOT NULL,
  "description_en" varchar(512) NOT NULL,
  "description_fr" varchar(512) NOT NULL
);

-- ================================================================
-- PRIMARY KEYS / UNIQUE CONSTRAINTS
-- ================================================================

-- refs_meta.codelists_versions
ALTER TABLE "refs_meta"."codelists_versions" ADD CONSTRAINT "codelists_versions_pkey" PRIMARY KEY (cl_schema, cl_name);

-- refs_biology.biological_materials
ALTER TABLE "refs_biology"."biological_materials" ADD CONSTRAINT "sample_types_pkey" PRIMARY KEY (code);

-- refs_biology.fish_status
ALTER TABLE "refs_biology"."fish_status" ADD CONSTRAINT "fish_status_pkey" PRIMARY KEY (code);

-- refs_biology.maturity_stages
ALTER TABLE "refs_biology"."maturity_stages" ADD CONSTRAINT "maturity_stages_pkey" PRIMARY KEY (code);

-- refs_biology.recommended_measurements
ALTER TABLE "refs_biology"."recommended_measurements" ADD CONSTRAINT "pk_recommended_measurements" PRIMARY KEY (species_code, type_of_measurement_code, measurement_code);

-- refs_biology.sample_preservation_methods
ALTER TABLE "refs_biology"."sample_preservation_methods" ADD CONSTRAINT "sample_preservation_methods_pkey" PRIMARY KEY (code);

-- refs_data.logical_responses
ALTER TABLE "refs_data"."logical_responses" ADD CONSTRAINT "logical_responses_pkey" PRIMARY KEY (code);

-- refs_fishery.buoy_models
ALTER TABLE "refs_fishery"."buoy_models" ADD CONSTRAINT "buoy_models_pkey" PRIMARY KEY (code);

-- refs_fishery.dfad_biodegradability_categories
ALTER TABLE "refs_fishery"."dfad_biodegradability_categories" ADD CONSTRAINT "dfad_biodegradability_categories_pkey" PRIMARY KEY (code);

-- refs_fishery.gear_types_deprecated
ALTER TABLE "refs_fishery"."gear_types_deprecated" ADD CONSTRAINT "pk_gear_types_deprecated" PRIMARY KEY (code);

-- refs_fishery.hook_and_terminal_devices
ALTER TABLE "refs_fishery"."hook_and_terminal_devices" ADD CONSTRAINT "pk_hook_and_terminal_devices" PRIMARY KEY (code);

-- refs_fishery.mechanisation_types
ALTER TABLE "refs_fishery"."mechanisation_types" ADD CONSTRAINT "pk_mechanisation_types" PRIMARY KEY (code);

-- refs_fishery.net_material_types
ALTER TABLE "refs_fishery"."net_material_types" ADD CONSTRAINT "pk_net_material_types" PRIMARY KEY (code);

-- refs_fishery.vessel_measurement_types
ALTER TABLE "refs_fishery"."vessel_measurement_types" ADD CONSTRAINT "pk_vessel_measurement_types" PRIMARY KEY (code);

-- refs_fishery_config.fishery_purposes
ALTER TABLE "refs_fishery_config"."fishery_purposes" ADD CONSTRAINT "pk_fishery_purposes" PRIMARY KEY (code);

-- ================================================================
-- INSERT DATA
-- ================================================================

-- refs_meta.codelists_versions
INSERT INTO "refs_meta"."codelists_versions" ("cl_schema", "cl_name", "version", "last_update", "url", "current_doi") VALUES
  ('refs_biology', 'SPECIES_BILLFISH', '    0', '2025-06-27 00:00:00', 'https://data.iotc.org/reference/latest/domain/biology/#billfish', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'SPECIES_RAYS', '    0', '2025-06-27 00:00:00', 'https://data.iotc.org/reference/latest/domain/biology/#rays', 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'COVERAGE_TYPES', '    0', '2023-05-12 00:00:00', 'https://data.iotc.org/reference/latest/domain/data/#coverageTypes', 'https://zenodo.org/records/15743875'),
  ('refs_data', 'LOGICAL_RESPONSES', '    0', '2026-06-02 00:00:00', 'https://data.iotc.org/reference/latest/domain/data/#logicalResponses', 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'RAISINGS', '    0', '2023-10-27 00:00:00', 'https://data.iotc.org/reference/latest/domain/data/#raisings', 'https://zenodo.org/records/15743875'),
  ('refs_data', 'SOURCES', '    0', '2025-09-11 14:44:00', 'https://data.iotc.org/reference/latest/domain/data/#Sources', 'https://zenodo.org/records/15743875'),
  ('refs_socio_economics', 'DESTINATION_MARKETS', '    0', '2024-03-14 16:09:58', 'https://data.iotc.org/reference/latest/domain/economics/#destination', 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'HOOK_AND_TERMINAL_DEVICES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'FOB_ACTIVITY_TYPES', '    0', '2023-11-02 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'CONDITION_TYPES', '    1', '2021-03-23 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'GEAR_GROUPS', '    0', '2020-06-15 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'DFAD_BIODEGRADABILITY_CATEGORIES', '    1', '2025-10-27 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'TARGET_SPECIES', '    0', '2024-02-13 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_admin', 'COUNTRIES', '    0', '2023-05-12 00:00:00', 'https://data.iotc.org/reference/latest/domain/admin/#countries', 'https://zenodo.org/records/15743875'),
  ('refs_admin', 'CPCS', '    0', '2023-05-12 00:00:00', 'https://data.iotc.org/reference/latest/domain/admin/#CPCs', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'BIOLOGICAL_MATERIALS', '    1', '2025-10-07 00:00:00', 'https://data.iotc.org/reference/latest/domain/biology/#biologicalMaterials', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'FISH_STATUS', '    0', '2025-11-14 00:00:00', 'https://data.iotc.org/reference/latest/domain/biology/#fishStatus', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'MATURITY_STAGES', '    1', '2025-10-07 00:00:00', 'https://data.iotc.org/reference/latest/domain/biology/#maturityStages', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'SAMPLE_PRESERVATION_METHODS', '    1', '2025-10-07 00:00:00', 'https://data.iotc.org/reference/latest/domain/biology/#samplePreservationMethods', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'SAMPLING_METHODS_FOR_SAMPLING_COLLECTIONS', '    0', '2023-05-12 00:00:00', 'https://data.iotc.org/reference/latest/domain/biology/#samplingMethodsForSamplingCollection', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'SAMPLING_PERIODS', '    0', '2023-05-12 00:00:00', 'https://data.iotc.org/reference/latest/domain/biology/#samplingPeriods', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'SAMPLING_PROTOCOLS', '    0', '2023-05-12 00:00:00', 'https://data.iotc.org/reference/latest/domain/biology/#samplingProtocols', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'SEX', '    2', '2023-06-15 15:27:19', 'https://data.iotc.org/reference/latest/domain/biology/#sex', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'SPECIES_SHARKS', '    0', '2025-06-27 00:00:00', 'https://data.iotc.org/reference/latest/domain/biology/#sharks', 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'DFOB_TYPES', '    0', '2023-11-02 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'EFFORT_UNITS', '    3', '2024-05-30 10:55:01', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'FAD_RAFT_DESIGNS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'FAD_TAIL_DESIGNS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'FISH_PRESERVATION_METHODS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'FISH_PROCESSING_TYPES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'FISH_STORAGE_TYPES', '    3', '2025-05-29 13:49:04', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'FISHERIES', '36925', '2025-06-27 11:42:27', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'FLOAT_TYPES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'FOB_OWNERSHIPS', '    0', '2023-10-26 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'FOB_TYPES', '    0', '2023-10-26 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'GEAR_TYPES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_data', 'ESTIMATIONS', '    0', '2023-05-12 00:00:00', 'https://data.iotc.org/reference/latest/domain/data/#estimations', 'https://zenodo.org/records/15743875'),
  ('refs_data', 'PROCESSINGS', '    0', '2023-05-12 00:00:00', 'https://data.iotc.org/reference/latest/domain/data/#processings', 'https://zenodo.org/records/15743875'),
  ('refs_data', 'TYPES', '    1', '2024-02-14 16:31:36', 'https://data.iotc.org/reference/latest/domain/data/#types', 'https://zenodo.org/records/15743875'),
  ('refs_socio_economics', 'COUNTRY_CURRENCY', '    0', '2026-06-15 00:00:00', 'https://data.iotc.org/reference/latest/domain/economics/#currencies', 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'FATE_TYPES', '    1', '2021-03-23 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'BUOY_MODELS', '    1', '2025-10-08 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'AREAS_IO_NJA_LEGACY', '    0', '2026-01-24 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'AREAS_IO_NJA_TCAC', '    0', '2026-01-24 15:19:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_admin', 'ENTITIES', '    0', '2023-05-12 00:00:00', 'https://data.iotc.org/reference/latest/domain/admin/#entities', 'https://zenodo.org/records/15743875'),
  ('refs_admin', 'FLEETS', '   34', '2024-01-19 10:41:37', 'https://data.iotc.org/reference/latest/domain/admin/#fleets', 'https://zenodo.org/records/15743875'),
  ('refs_admin', 'IO_MAIN_AREAS', '    0', '2023-05-12 00:00:00', 'https://data.iotc.org/reference/latest/domain/admin/#IOareasMain', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'BAIT_CONDITIONS', '    0', '2023-05-12 00:00:00', 'https://data.iotc.org/reference/latest/domain/biology/#baitConditions', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'BAIT_TYPES', '    0', '2023-05-12 00:00:00', 'https://data.iotc.org/reference/latest/domain/biology/#baitTypes', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'DEPREDATION_SOURCES', '    0', '2023-05-12 00:00:00', 'https://data.iotc.org/reference/latest/domain/biology/#depredationSources', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'FATES', '    1', '2024-02-01 08:53:36', 'https://data.iotc.org/reference/latest/domain/biology/#fates', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'GEAR_INTERACTIONS', '    0', '2023-05-12 00:00:00', 'https://data.iotc.org/reference/latest/domain/biology/#gearInteractions', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'HANDLING_METHODS', '    0', '2023-05-12 00:00:00', 'https://data.iotc.org/reference/latest/domain/biology/#handlingMethods', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'INDIVIDUAL_CONDITIONS', '    0', '2023-05-12 00:00:00', 'https://data.iotc.org/reference/latest/domain/biology/#individualConditions', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'MEASUREMENTS', '    6', '2024-09-28 17:18:17', 'https://data.iotc.org/reference/latest/domain/biology/#allMeasurements', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'MEASUREMENT_TOOLS', '    0', '2023-05-12 00:00:00', 'https://data.iotc.org/reference/latest/domain/biology/#allMeasurementTools', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'SPECIES_CATEGORIES', '    0', '2023-05-12 00:00:00', 'https://data.iotc.org/reference/latest/domain/biology/#speciesCategories', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'SPECIES_CETACEANS', '    1', '2025-06-27 22:03:48', 'https://data.iotc.org/reference/latest/domain/biology/#cetaceans', 'https://zenodo.org/records/15743875'),
  ('refs_admin', 'CPC_HISTORY', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_admin', 'CPC_TO_FLAGS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_admin', 'FLEET_TO_FLAGS_AND_FISHERIES', '   34', '2024-01-19 10:58:11', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery_config', 'GEARS', '    2', '2025-01-17 11:57:18', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_data', 'COVERAGE_TYPES', '    0', '2023-05-12 00:00:00', 'https://data.iotc.org/reference/latest/domain/data/#coverageTypes', 'https://zenodo.org/records/15743875'),
  ('refs_data', 'DATASETS', '    0', '2023-05-12 00:00:00', 'https://data.iotc.org/reference/latest/domain/data/#dataSets', 'https://zenodo.org/records/15743875'),
  ('refs_data', 'RAISINGS', '    0', '2023-05-12 00:00:00', 'https://data.iotc.org/reference/latest/domain/data/#raisings', 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'AFOB_ACTIVITY_TYPES', '    0', '2023-11-02 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'AFOB_TYPES', '    0', '2023-11-02 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'BAIT_FISHING_METHODS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'BAIT_SCHOOL_DETECTION_METHODS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'BOAT_CLASS_TYPES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'BRANCHLINE_STORAGES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'BUOY_ACTIVITY_TYPES', '    0', '2023-10-26 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'CARDINAL_POINTS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'CATCH_UNITS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'DEHOOKER_TYPES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'DFOB_ACTIVITY_TYPES', '    0', '2023-11-02 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'AREAS_IO_30', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'AREAS_IOTC', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'HULL_MATERIAL_TYPES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'LIGHT_COLOURS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'LIGHT_TYPES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'LINE_MATERIAL_TYPES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'MITIGATION_DEVICES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'NET_COLOURS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'NET_CONDITIONS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'NET_CONFIGURATIONS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'NET_DEPLOY_DEPTHS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'NET_SETTING_STRATEGIES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'OFFAL_MANAGEMENT_TYPES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'POLE_MATERIAL_TYPES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'REASONS_DAYS_LOST', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'SCHOOL_DETECTION_METHODS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'SCHOOL_SIGHTING_CUES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'SCHOOL_TYPE_CATEGORIES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'SINKER_MATERIAL_TYPES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'STREAMER_TYPES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'STUNNING_METHODS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'SURFACE_FISHERY_ACTIVITIES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'TRANSHIPMENT_CATEGORIES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'VESSEL_ARCHITECTURES', '    0', '2025-06-26 10:34:23', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'VESSEL_SECTIONS', '    0', '2025-06-26 10:35:32', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'VESSEL_SIZE_TYPES', '    0', '2025-06-26 10:33:25', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'VESSEL_TYPES', '    0', '2025-01-17 17:42:49', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'WASTE_CATEGORIES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'WASTE_DISPOSAL_METHODS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'WIND_SCALES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery_config', 'AREAS_OF_OPERATION', '    2', '2024-01-19 11:12:12', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery_config', 'FISHERY_CATEGORIES', '    1', '2025-01-15 14:44:07', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery_config', 'FISHERY_TYPES', '    2', '2025-06-09 08:27:52', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery_config', 'FISHING_MODES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery_config', 'GEAR_CONFIGURATIONS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery_config', 'GEAR_FISHERY_TYPE_TO_CONFIGURATI', '    2', '2025-06-08 17:09:56', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery_config', 'GEAR_FISHERY_TYPE_TO_CONFIGURATION', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery_config', 'GEAR_FISHERY_TYPE_TO_FISHING_MOD', '    2', '2025-06-08 17:12:18', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery_config', 'GEAR_FISHERY_TYPE_TO_FISHING_MODE', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery_config', 'GEAR_GROUPS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery_config', 'GEAR_TO_FISHERY_TYPE', '   41', '2025-06-09 09:04:02', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery_config', 'GEAR_TO_TARGET_SPECIES', '    5', '2025-06-09 09:03:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery_config', 'LOA_CLASSES', '    0', '2023-11-23 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery_config', 'TARGET_SPECIES', '    3', '2025-06-08 18:21:24', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'AREA_INTERSECTIONS', '   45', '2024-04-04 22:13:50', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'AREA_TYPES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'AREAS_IO', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'AREAS_IO_01', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'AREAS_IO_05', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'AREAS_IO_10', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'AREAS_IO_1020', '    1', '2024-02-13 16:18:30', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'AREAS_IO_20', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'MECHANISATION_TYPES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_fishery_config', 'FISHERY_PURPOSES', '    1', '2025-05-20 11:21:45', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'SAMPLING_METHODS_FOR_CATCH_ESTIMATION', '    0', '2023-05-12 00:00:00', 'https://data.iotc.org/reference/latest/domain/biology/#samplingMethodsForCatchEstimation', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'SPECIES', '    1', '2025-06-27 22:03:48', 'https://data.iotc.org/reference/latest/domain/biology/#allSpecies', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'SPECIES_BAITS', '    1', '2025-06-27 22:03:48', 'https://data.iotc.org/reference/latest/domain/biology/#baits', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'SPECIES_CETACEANS_AND_WHALE_SHARKS', '    0', '2023-05-12 00:00:00', 'https://data.iotc.org/reference/latest/domain/biology/#cetaceansAndWhaleSharks', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'SPECIES_GROUPS', '    0', '2023-05-12 00:00:00', 'https://data.iotc.org/reference/latest/domain/biology/#speciesGroups', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'SPECIES_IOTC', '    1', '2025-06-27 22:03:48', 'https://data.iotc.org/reference/latest/domain/biology/#IOTCspecies', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'SPECIES_TURTLES', '    1', '2025-06-27 22:03:48', 'https://data.iotc.org/reference/latest/domain/biology/#marineTurtles', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'TAG_TYPES', '    0', '2023-05-12 00:00:00', 'https://data.iotc.org/reference/latest/domain/biology/#tagTypes', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'TYPES_OF_FATE', '    0', '2023-05-12 00:00:00', 'https://data.iotc.org/reference/latest/domain/biology/#typesOfFate', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'TYPES_OF_MEASUREMENT', '    0', '2023-05-12 00:00:00', 'https://data.iotc.org/reference/latest/domain/biology/#typesOfMeasurement', 'https://zenodo.org/records/15743875'),
  ('refs_fishery', 'NET_MATERIAL_TYPES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'AREAS_IO_AR', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'AREAS_IO_CE_SF', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'AREAS_IO_CE_SF_AR', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'AREAS_IO_MAIN', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'AREAS_IO_SA', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'AREAS_IO_T3', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'AREAS_IOTC_01', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'AREAS_IOTC_05', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'AREAS_IOTC_10', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'AREAS_IOTC_1020', '    1', '2024-02-13 16:18:30', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'AREAS_IOTC_20', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'AREAS_IOTC_30', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'AREAS_IOTC_AR', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'AREAS_IOTC_AR_TO_01_05_GRIDS', '    0', '2024-02-05 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'AREAS_IOTC_AR_TO_01_GRIDS', '    0', '2024-02-05 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'AREAS_IOTC_AR_TO_05_GRIDS', '    0', '2024-02-05 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'AREAS_IOTC_CE_SF', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'AREAS_IOTC_CE_SF_AR', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'AREAS_IOTC_MAIN', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'COUNTRY_AREAS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'FAO_AREAS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'FAO_AREAS_AO', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'FAO_AREAS_IO', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'FAO_AREAS_PO', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'FISHING_GROUNDS', '    1', '2024-02-13 16:18:31', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'LME_AREAS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'RFB_AREAS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'RFB_RFMO_AREAS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'RFMO_AREAS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'BOAT_TYPES', '    0', '2025-06-26 11:21:22', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'CATCH_UNITS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'DATA_PROCESSINGS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'DATA_SOURCES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'DATA_TYPES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'EFFORT_UNITS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'ESTIMATION_TYPES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'FAD_ACTIVITY_TYPES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'FAD_OWNERSHIPS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'FAD_TYPES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'FATES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'FISHERIES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'FISHERY_GROUPS', '    0', '2025-01-15 12:10:33', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'FISHERY_TYPES', '    0', '2025-01-15 12:06:59', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'FLEETS', '    1', '2025-06-17 14:32:27', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'GEAR_TYPES', '    0', '2025-01-15 13:44:14', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'GEARS', '    1', '2025-01-13 10:21:45', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'GRSF_IDENTIFIERS', '    0', '2023-06-16 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'ISSCFG_GEAR_GROUPS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'ISSCFG_GEARS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'IUCN_STATUS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'LEGACY_FISHERIES', '    1', '2023-06-15 13:51:54', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'LEGACY_GEAR_TYPES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'LEGACY_GEARS', '    1', '2025-01-13 10:21:44', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'MAIN_AREAS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'MEASUREMENT_TOOLS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'MEASUREMENT_TYPES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'NOCS_CODES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'NOCS_NAMES_EN', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'NOCS_NAMES_FR', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'SAMPLED_CATCH_TYPES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'SCHOOL_TYPES', '    0', '2023-10-27 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'SPECIES', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'SPECIES_CONDITION', '    0', '2025-01-15 14:27:30', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'SPECIES_TO_GRSF', '    0', '2023-11-23 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'UN_LOCODE_PORTS', '    0', '2023-05-12 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'SPECIES_CATEGORIES', '    1', '2021-03-23 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'SPECIES_GROUPS', '    1', '2021-03-23 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_legacy', 'WORKING_PARTIES', '    1', '2021-03-23 00:00:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_socio_economics', 'PRICING_LOCATIONS', '    0', '2024-03-14 16:09:22', 'https://data.iotc.org/reference/latest/domain/economics/#pricingLocation', 'https://zenodo.org/records/15743875'),
  ('refs_socio_economics', 'PRODUCT_TYPES', '    0', '2024-03-14 17:09:12', 'https://data.iotc.org/reference/latest/domain/economics/#products', 'https://zenodo.org/records/15743875'),
  ('refs_gis', 'AREAS_IO_NJA', '    1', '2026-01-24 12:15:00', NULL, 'https://zenodo.org/records/15743875'),
  ('refs_admin', 'PORTS', '    0', '2025-08-25 11:30:00', 'https://data.iotc.org/reference/latest/domain/admin/#Ports', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'LENGTH_MEASUREMENT_TOOLS', '    0', '2023-05-12 00:00:00', 'https://data.iotc.org/reference/latest/domain/biology/#lengthMeasurementTools', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'RECOMMENDED_MEASUREMENTS', '    0', '2024-02-13 00:00:00', 'https://data.iotc.org/reference/latest/domain/biology/#weightMeasurementTools', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'SCARS', '    0', '2020-06-15 00:00:00', 'https://data.iotc.org/reference/latest/domain/biology/#scars', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'SPECIES_OTHERS', '    1', '2025-06-27 22:03:48', 'https://data.iotc.org/reference/latest/domain/biology/#otherSpecies', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'SPECIES_PREDATORS', '    1', '2025-06-27 22:03:48', 'https://data.iotc.org/reference/latest/domain/biology/#predators', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'SPECIES_SEABIRDS', '    1', '2025-06-27 22:03:48', 'https://data.iotc.org/reference/latest/domain/biology/#seabirds', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'SPECIES_SSI', '    1', '2025-06-27 22:03:48', 'https://data.iotc.org/reference/latest/domain/biology/#SSIspecies', 'https://zenodo.org/records/15743875'),
  ('refs_biology', 'WEIGHT_MEASUREMENT_TOOLS', '    0', '2023-05-12 00:00:00', 'https://data.iotc.org/reference/latest/domain/biology/#weightMeasurementTools', 'https://zenodo.org/records/15743875')
;

-- refs_biology.biological_materials
INSERT INTO "refs_biology"."biological_materials" ("code", "name_en", "name_fr") VALUES
  ('WM', 'White muscle', 'Muscle blanc'),
  ('RE', 'Red muscle', 'Muscle rouge'),
  ('LI', 'Liver', 'Foie'),
  ('OT', 'Otolith', 'Otolithe'),
  ('BL', 'Blood', 'Sang'),
  ('ME', 'Mesenteric fat', 'Mesentère'),
  ('WH', 'Whole body', 'Organisme entier'),
  ('FC', 'Fin clip', 'Morceau de nageoire'),
  ('MA', 'Mantle', 'Manteau'),
  ('ST', 'Stomach', 'Estomac'),
  ('BK', 'Beak', 'Bec'),
  ('DG', 'Digestive gland', 'Glande digestive'),
  ('GO', 'Gonad', 'Gonade'),
  ('SK', 'Skin', 'Peau'),
  ('SC', 'Scales', 'Écailles')
;

-- refs_biology.fish_status
INSERT INTO "refs_biology"."fish_status" ("code", "name_en", "name_fr", "description_en", "description_fr") VALUES
  ('FRE', 'Fresh', 'Frais', 'The specimen is in a fresh, unfrozen state at the time of sampling', 'Le spécimen est dans un état frais, non congelé, au moment de l’échantillonnage'),
  ('FRO', 'Frozen', 'Congelé', 'The specimen has been fully frozen prior to sampling', 'Le spécimen a été entièrement congelé avant l’échantillonnage'),
  ('DEF', 'Defrosted', 'Décongelé', 'The specimen was previously frozen and has since been thawed for sampling', 'Le spécimen a été préalablement congelé puis décongelé pour l’échantillonnage')
;

-- refs_biology.maturity_stages
INSERT INTO "refs_biology"."maturity_stages" ("code", "name_en", "name_fr", "description_male_en", "description_male_fr", "description_female_en", "description_female_fr") VALUES
  ('IMM', 'Immature', 'Immature', 'The fish is in the immature stage. The testes are extremely thin, flattened and ribbon-like, but the sex is determinable by gross examination', 'Le poisson est au stade immature. Les testicules sont extrêmement fins, aplatis et en ruban, mais le sexe peut être déterminé par examen macroscopique', 'The fish is in the immature stage. The gonads are elongated and slender, but the sex can be determined by gross examination', 'Le poisson est au stade immature. Les gonades sont allongées et fines, mais le sexe peut être déterminé par examen macroscopique'),
  ('DEV', 'Early developing', 'Développement précoce', 'The fish is in the early development stage of spawning. The testes are enlarged, triangular in cross section, without any milt in the central canal', 'Le poisson est au stade de développement précoce. Les testicules sont hypertrophiés et triangulaires en coupe transversale, sans laitance dans le canal central', 'The fish is in the early development stage of spawning. The gonads are enlarged, but individual ova are not visible to the naked eye', 'Le poisson est au stade de développement précoce. Les gonades sont hypertrophiées, mais les ovules individuels ne sont pas visibles à l’œil nu'),
  ('DEL', 'Late developing', 'Développement avancé', 'The fish is in the late development stage of spawning. Some milt flows freely if the testes are pinched or pressed', 'Le poisson est au stade de développement avancé. Un peu de laitance s’écoule librement lorsque les testicules sont pincés ou pressés', 'The fish is in the late development stage of spawning. The gonads are enlarged, and individual ova are visible to the naked eye', 'Le poisson est au stade de développement avancé. Les gonades sont hypertrophiées et les ovules individuels sont visibles à l’œil nu'),
  ('SPW', 'Spawning capable', 'Maturité sexuelle', 'The fish is in the spawning stage. The testes are large, and milt flows freely from the testes', 'Le poisson est au stade de frai. Les testicules sont gros et la laitance s’écoule librement', 'The fish is in the spawning stage. The ovary is greatly enlarged; ova are translucent and can be easily dislodged from the follicles or are loose in the lumen of the ovary', 'Le poisson est au stade de frai. L’ovaire est fortement hypertrophié ; les ovules sont translucides et se détachent facilement des follicules ou sont libres dans la lumière de l’ovaire'),
  ('REG', 'Spent / Spawned / Regressing / Regenerating', 'Repos reproducteur', 'The fish has spawned and is now in the regressing or regenerating stage. The testes are flabby, bloodshot, surface dull red, with little or no milt in the central canal', 'Le poisson a frai et est maintenant au stade de régression ou de régénération. Les testicules sont flasques, injectés de sang, avec une surface rouge terne, contenant peu ou pas de laitance dans le canal central', 'The fish has spawned and is now in the regressing or regenerating stage. This includes recently spawned and post-spawning fish, with mature ova remnants in various stages of resorption, including mature ova remnants about 1.0 mm in diameter', 'Le poisson a frai et est maintenant au stade de régression ou de régénération. Cela inclut les poissons récemment fraiés et post-frai, avec des restes d’ovules matures à différents stades de résorption, y compris des restes d’ovules matures d’environ 1,0 mm de diamètre'),
  ('UNK', 'unknown', 'Inconnu', 'The maturity stage is unknown', 'Le stade de maturité est inconnu', 'The maturity stage is unknown', 'Le stade de maturité est inconnu')
;

-- refs_biology.recommended_measurements
INSERT INTO "refs_biology"."recommended_measurements" ("species_code", "type_of_measurement_code", "measurement_code", "default_measurement_interval", "max_measurement_interval", "min_measurement", "max_measurement") VALUES
  ('ALB', 'LN', 'FL', '1', ' 2', '10', '140'),
  ('ALV', 'LN', 'FL', '5', '10', '30', '760'),
  ('BET', 'LN', 'FL', '2', ' 4', '10', '250'),
  ('BLM', 'LN', 'LJ', '3', ' 5', '15', '465'),
  ('BLT', 'LN', 'FL', '1', ' 2', '10', ' 50'),
  ('BSH', 'LN', 'FL', '5', '10', '30', '400'),
  ('BTH', 'LN', 'FL', '5', '10', '30', '760'),
  ('BUM', 'LN', 'LJ', '3', ' 5', '15', '500'),
  ('COM', 'LN', 'FL', '1', ' 3', '10', '240'),
  ('FAL', 'LN', 'FL', '5', '10', '30', '350'),
  ('FRI', 'LN', 'FL', '1', ' 2', '10', ' 65'),
  ('GUT', 'LN', 'FL', '1', ' 3', '10', ' 76'),
  ('KAW', 'LN', 'FL', '1', ' 2', '10', ' 70'),
  ('LMA', 'LN', 'FL', '5', '10', '30', '417'),
  ('LOT', 'LN', 'FL', '1', ' 3', '10', '145'),
  ('MLS', 'LN', 'LJ', '3', ' 5', '15', '420'),
  ('OCS', 'LN', 'FL', '5', '10', '30', '396'),
  ('POR', 'LN', 'FL', '5', '10', '30', '350'),
  ('PSK', 'LN', 'FL', '5', '10', '30', '110'),
  ('SFA', 'LN', 'LJ', '3', ' 5', '15', '300'),
  ('SKJ', 'LN', 'FL', '1', ' 2', '10', '110'),
  ('SMA', 'LN', 'FL', '5', '10', '30', '400'),
  ('SPL', 'LN', 'FL', '5', '10', '30', '430'),
  ('SPZ', 'LN', 'FL', '5', '10', '30', '500'),
  ('SWO', 'LN', 'LJ', '3', ' 5', '15', '450'),
  ('YFT', 'LN', 'FL', '2', ' 4', '10', '239')
;

-- refs_biology.sample_preservation_methods
INSERT INTO "refs_biology"."sample_preservation_methods" ("code", "name_en", "name_fr", "description_en", "description_fr") VALUES
  ('FR20', 'Freezer20', 'Congélateur20', 'Freezer (-20 degrees)', 'Congélateur (-20 degrés)'),
  ('FR80', 'Freezer80', 'Congélateur80', 'Ultra-low temperature freezer (-80 degrees)', 'Stocké au congélateur (-80 degrés)'),
  ('RCL', 'Rcl2', 'Rcl2', 'RCL2''s solution, a formalin-free histological fixative', 'Solution de RCL2, un fixateur histologique sans formol'),
  ('BOI', 'Bouin', 'Bouin', 'Bouin''s solution, a cellular fixative for histological sections containing picric acid, formaldehyde, and acetic acid', 'Solution de Bouin, un fixateur cellulaire pour coupes histologiques contenant de l''acide picrique, du formaldéhyde et de l’acide acétique'),
  ('GIL', 'Gilson', 'Gilson', 'Gilson''s fluid, a general-purpose anatomical fixative containing mercuric chloride, acetic acid, and ethanol', 'Liquide de Gilson, un fixateur anatomique à usage général contenant du chlorure de mercure, de l''acide acétique et de l''éthanol'),
  ('ETH', 'Ethanol', 'Éthanol', 'Ethanol, aquaeous solution 96%', 'Éthanol, solution aqueuse à 96%'),
  ('FOR', 'Formaldehyde', 'Formaldéhyde', 'Formaldehyde, aquaeous solution 4%', 'Formaldéhyde, solution aqueuse à 4%'),
  ('DRY', 'Dry', 'Sec', 'Dry room or dessicator', 'Chambre sèche ou dessicateur'),
  ('NIT', 'Nitrogen', 'Azote', 'Liquid nitrogen', 'Solution d''azote liquide'),
  ('UNK', 'Unknown', 'Inconnu', 'Unknown storage mode', 'Mode de préservation inconnu')
;

-- refs_data.logical_responses
INSERT INTO "refs_data"."logical_responses" ("code", "name_en", "name_fr", "description_en", "description_fr") VALUES
  ('TRUE', 'true', 'Vrai', 'The condition is confirmed to be true based on observed or reported data', 'La condition est confirmée comme vraie sur la base des données observées ou rapportées'),
  ('FALSE', 'false', 'Faux', 'The condition is confirmed to be false based on observed or reported data', 'La condition est confirmée comme fausse sur la base des données observées ou rapportées'),
  ('UNK', 'Unknown', 'Inconnu', 'The information could not be determined or observed at the time of data collection', 'L’information n’a pas pu être déterminée ou observée au moment de la collecte des données'),
  ('NAV', 'Not available', 'Non disponible', 'The information was not collected', 'L’information n’a pas été collectée'),
  ('NAP', 'Not applicable', 'Sans objet', 'The variable does not apply to the specific observation or context', 'La variable ne s’applique pas à l’observation ou au contexte considéré')
;

-- refs_fishery.buoy_models
INSERT INTO "refs_fishery"."buoy_models" ("code", "name_en", "is_echo_sounder", "brand", "start_year", "comment", "active") VALUES
  ('MDP', 'MDP', 'FALSE', 'MARINE INSTRUMENTS', NULL, NULL, 'FALSE'),
  ('MDS', 'MDS', 'FALSE', 'MARINE INSTRUMENTS', NULL, NULL, 'FALSE'),
  ('M2D', 'M2D', 'FALSE', 'MARINE INSTRUMENTS', NULL, NULL, 'FALSE'),
  ('MSI', 'MSI', 'FALSE', 'MARINE INSTRUMENTS', NULL, NULL, 'FALSE'),
  ('M3I', 'M3i', ' TRUE', 'MARINE INSTRUMENTS', '2011', 'Frequency: 50 kHz', ' TRUE'),
  ('M3+', 'M3i+', ' TRUE', 'MARINE INSTRUMENTS', '2012', 'Frequency: 50 and 200 kHz', ' TRUE'),
  ('M4I', 'M4I', ' TRUE', 'MARINE INSTRUMENTS', '2013', 'Multiple frequencies 50, 120, 200', 'FALSE'),
  ('M4+', 'M4i+', ' TRUE', 'MARINE INSTRUMENTS', '2014', 'Multiple frequencies 50, 120, 200', 'FALSE'),
  ('MGO', 'M3iGO', ' TRUE', 'MARINE INSTRUMENTS', '2021', 'Since October 2021', ' TRUE'),
  ('D+', 'D+ battery', 'FALSE', 'SATLINK', NULL, NULL, 'FALSE'),
  ('DS+', 'D+ battery with echosounder', ' TRUE', 'SATLINK', NULL, NULL, 'FALSE'),
  ('DL+', 'D+ solar', 'FALSE', 'SATLINK', NULL, NULL, 'FALSE'),
  ('DSL+', 'D+ solar with echosounder', ' TRUE', 'SATLINK', '2017', NULL, 'FALSE'),
  ('ISL+', 'IDP solar with echosounder', ' TRUE', 'SATLINK', '2017', 'Frequency: 190.5 kHz', ' TRUE'),
  ('ISD+', 'IDP solar discriminant with echosounder', ' TRUE', 'SATLINK', '2017', 'Frequency: 38 kHz and 200 kHz', ' TRUE'),
  ('SLX+', 'SLX solar "ECO"', ' TRUE', 'SATLINK', '2018', 'Frequency: 200 kHz', ' TRUE'),
  ('ORBIT', 'OBT 1', ' TRUE', 'THALOS', '2017', NULL, 'FALSE'),
  ('ORBIT+', 'OBT 2', ' TRUE', 'THALOS', '2019', 'Since June 2019', 'FALSE'),
  ('T07', 'Tunabal-7', ' TRUE', 'ZUNIBAL', NULL, NULL, 'FALSE'),
  ('Te7', 'Tunabal-e7', ' TRUE', 'ZUNIBAL', '2017', 'e stands for “eco-design”', 'FALSE'),
  ('T7+', 'Tunabal-e7+', ' TRUE', 'ZUNIBAL', '2017', 'e stands for “eco-design”', 'FALSE'),
  ('T8E', 'Tuna8 Explorer', ' TRUE', 'ZUNIBAL', '2017', 'Frequency: 120 kHz', ' TRUE'),
  ('T8X', 'Tuna8 Xtreme', ' TRUE', 'ZUNIBAL', '2018', 'Buoy ID with 6 digits instead of 9; https://zunibal.com/en/tuna-fishing/8-tuna-extreme/', ' TRUE'),
  ('F07', 'Tunabal-7 (F series)', ' TRUE', 'ZUNIBAL', NULL, 'Fortuna mode = software setting that allows for an immediate sonar response; Frequency: 120 kHz', 'FALSE'),
  ('Fe7', 'Tunabal-e7 (F series)', ' TRUE', 'ZUNIBAL', NULL, 'Fortuna mode = software setting that allows for an immediate sonar response; Frequency: 120 kHz', 'FALSE'),
  ('F7+', 'Tunabal-e7+ (F series)', ' TRUE', 'ZUNIBAL', NULL, 'Fortuna mode = software setting that allows for an immediate sonar response; Frequency: 120 kHz', 'FALSE'),
  ('F8E', 'Tuna8 Explorer (F series)', ' TRUE', 'ZUNIBAL', '2017', 'Fortuna mode = software setting that allows for an immediate sonar response; Frequency: 120 kHz', 'FALSE'),
  ('Z07', 'Zuni', 'FALSE', 'ZUNIBAL', NULL, NULL, 'FALSE'),
  ('Ze7', 'Zuni with eco-design', 'FALSE', 'ZUNIBAL', NULL, NULL, 'FALSE'),
  ('F8X', 'Tuna8 Xtreme (F series)', ' TRUE', 'ZUNIBAL', '2018', 'Fortuna mode = software setting that allows for an immediate sonar response; Frequency: 120 kHz', ' TRUE')
;

-- refs_fishery.dfad_biodegradability_categories
INSERT INTO "refs_fishery"."dfad_biodegradability_categories" ("code", "name_en", "name_fr", "description_en", "description_fr", "state") VALUES
  ('CAT1', 'Category I', 'Catégorie I', 'The DFAD is made of fully biodegradable materials', 'Le DCPD est entièrement constitué de matériaux biodégradables', 'Active'),
  ('CAT2', 'Category II', 'Catégorie III', 'The DFAD is made of fully biodegradable materials except for flotation components (e.g., buoys, foam, purse-seine corks)', 'Le DCPD est entièrement constitué de matériaux biodégradables, sauf pour les éléments de flottabilité (par exemple, bouées, mousse, bouchons de senne coulissante)', 'Active'),
  ('CAT3', 'Category III', 'Catégorie III', 'The subsurface part of the DFAD is made of fully biodegradable materials, whereas the surface part and any flotation components contain non-biodegradable materials (e.g., synthetic raffia, metallic frame, plastic floats, nylon ropes)', 'La partie immergée du DCPD est entièrement constituée de matériaux biodégradables, tandis que la partie en surface et tous les éléments de flottabilité contiennent des matériaux non biodégradables (p. ex., raphia synthétique, cadre métallique, flotteurs en plastique, cordes en nylon)', 'Active'),
  ('CAT4', 'Category IV', 'Catégorie IV', 'The subsurface part of the DFAD contains non-biodegradable materials, whereas the surface part is made of fully biodegradable materials, except for, possibly, flotation components', 'La partie immergée du DCPD contient des matériaux non biodégradables, tandis que la partie en surface est entièrement constituée de matériaux biodégradables, sauf, éventuellement, pour les éléments de flottabilité', 'Active'),
  ('CAT5', 'Category V', 'Catégorie V', 'The surface and subsurface parts of the DFAD contain non-biodegradable materials', 'Les parties en surface et immergée du DCPD contiennent des matériaux non biodégradables', 'Active'),
  ('UNK', 'Unknown', 'Inconnue', 'The biodegradability category of the DFAD is unknown', 'La catégorie de biodégradabilité du DCPD n''est pas connue', 'Active')
;

-- refs_fishery.gear_types_deprecated
INSERT INTO "refs_fishery"."gear_types_deprecated" ("code", "name_en", "name_fr") VALUES
  ('DLL', 'Drifting longline', 'Palangre dérivante'),
  ('GIL', 'Gillnet ', 'Filet maillant'),
  ('TPL', 'Pole and line', 'Canne'),
  ('TPS', 'Tuna purse seine', 'Senne à thons')
;

-- refs_fishery.hook_and_terminal_devices
INSERT INTO "refs_fishery"."hook_and_terminal_devices" ("code", "name_en", "name_fr", "description_en", "description_fr") VALUES
  ('C11', 'Circle hooks (11/0)', 'Hameçons autoferrants (11/0)', 'Circle hook of size 11/0 characterised by a point curved inward toward the shank', 'Hameçon autoferrant de taille 11/0 caractérisé par une pointe recourbée vers l''intérieur en direction de la hampe'),
  ('C12', 'Circle hooks (12/0)', 'Hameçons autoferrants (12/0)', 'Circle hook of size 12/0 characterised by a point curved inward toward the shank', 'Hameçon autoferrant de taille 12/0 caractérisé par une pointe recourbée vers l''intérieur en direction de la hampe'),
  ('C13', 'Circle hooks (13/0)', 'Hameçons autoferrants (13/0)', 'Circle hook of size 13/0 characterised by a point curved inward toward the shank', 'Hameçon autoferrant de taille 13/0 caractérisé par une pointe recourbée vers l''intérieur en direction de la hampe'),
  ('C14', 'Circle hooks (14/0)', 'Hameçons autoferrants (14/0)', 'Circle hook of size 14/0 characterised by a point curved inward toward the shank', 'Hameçon autoferrant de taille 14/0 caractérisé par une pointe recourbée vers l''intérieur en direction de la hampe'),
  ('C15', 'Circle hooks (15/0)', 'Hameçons autoferrants (15/0)', 'Circle hook of size 15/0 characterised by a point curved inward toward the shank', 'Hameçon autoferrant de taille 15/0 caractérisé par une pointe recourbée vers l''intérieur en direction de la hampe'),
  ('C16', 'Circle hooks (16/0)', 'Hameçons autoferrants (16/0)', 'Circle hook of size 16/0 characterised by a point curved inward toward the shank', 'Hameçon autoferrant de taille 16/0 caractérisé par une pointe recourbée vers l''intérieur en direction de la hampe'),
  ('C18', 'Circle hooks (18/0)', 'Hameçons autoferrants (18/0)', 'Circle hook of size 18/0 characterised by a point curved inward toward the shank', 'Hameçon autoferrant de taille 18/0 caractérisé par une pointe recourbée vers l''intérieur en direction de la hampe'),
  ('H32', 'Japanese tuna hooks (3.2)', 'Hameçons à thons japonais (3.2)', 'Japanese tuna hook of size 3.2 commonly used in tuna longline fisheries', 'Hameçon à thon japonais de taille 3.2 couramment utilisé dans les pêcheries palangrières thonières'),
  ('H34', 'Japan tuna hooks (3.4)', 'Hameçons à thons japonais (3.4)', 'Japanese tuna hook of size 3.4 commonly used in tuna longline fisheries', 'Hameçon à thon japonais de taille 3.4 couramment utilisé dans les pêcheries palangrières thonières'),
  ('H36', 'Japan tuna hooks (3.6)', 'Hameçons à thons japonais (3.6)', 'Japanese tuna hook of size 3.6 commonly used in tuna longline fisheries', 'Hameçon à thon japonais de taille 3.6 couramment utilisé dans les pêcheries palangrières thonières'),
  ('H38', 'Japan tuna hooks (3.8)', 'Hameçons à thons japonais (3.8)', 'Japanese tuna hook of size 3.8 commonly used in tuna longline fisheries', 'Hameçon à thon japonais de taille 3.8 couramment utilisé dans les pêcheries palangrières thonières'),
  ('H40', 'Japan tuna hooks (4.0)', 'Hameçons à thons japonais (4.0)', 'Japanese tuna hook of size 4.0 commonly used in tuna longline fisheries', 'Hameçon à thon japonais de taille 4.0 couramment utilisé dans les pêcheries palangrières thonières'),
  ('H42', 'Japan tuna hooks (4.2)', 'Hameçons à thons japonais (4.2)', 'Japanese tuna hook of size 4.2 commonly used in tuna longline fisheries', 'Hameçon à thon japonais de taille 4.2 couramment utilisé dans les pêcheries palangrières thonières'),
  ('TLL', 'Loop-based terminal capture device', 'Dispositif terminal à boucle', 'Loop-based terminal capture device used in combination with fishing gear as an alternative or complement to conventional hooks', 'Dispositif terminal de capture constitué d''une boucle, utilisé avec un engin de pêche comme alternative ou complément aux hameçons conventionnels'),
  ('J08', 'J Hooks (8/0)', 'Hameçons en J (8/0)', 'J-shaped hook of size 8/0', 'Hameçon en J de taille 8/0'),
  ('J09', 'J Hooks (9/0)', 'Hameçons en J (9/0)', 'J-shaped hook of size 9/0', 'Hameçon en J de taille 9/0'),
  ('J10', 'J Hooks (10/0)', 'Hameçons en J (10/0)', 'J-shaped hook of size 10/0', 'Hameçon en J de taille 10/0'),
  ('J12', 'J Hooks (12/0)', 'Hameçons en J (12/0)', 'J-shaped hook of size 12/0', 'Hameçon en J de taille 12/0'),
  ('S01', 'Spanish hooks (1)', 'Hameçons espagnols (1)', 'Spanish hook of size 1', 'Hameçon espagnol de taille 1'),
  ('S02', 'Spanish hooks (2)', 'Hameçons espagnols (2)', 'Spanish hook of size 2', 'Hameçon espagnol de taille 2'),
  ('S03', 'Spanish hooks (3)', 'Hameçons espagnols (3)', 'Spanish hook of size 3', 'Hameçon espagnol de taille 3'),
  ('S04', 'Spanish hooks (4)', 'Hameçons espagnols (4)', 'Spanish hook of size 4', 'Hameçon espagnol de taille 4'),
  ('T32', 'Teracima hooks (3.2 sun)', 'Hameçons Teracima (3.2 sun)', 'Teracima hook of size 3.2 sun', 'Hameçon Teracima de taille 3.2 sun'),
  ('T34', 'Teracima hooks (3.4 sun)', 'Hameçons Teracima (3.4 sun)', 'Teracima hook of size 3.4 sun', 'Hameçon Teracima de taille 3.4 sun'),
  ('T36', 'Teracima hooks (3.6 sun)', 'Hameçons Teracima (3.6 sun)', 'Teracima hook of size 3.6 sun', 'Hameçon Teracima de taille 3.6 sun'),
  ('T38', 'Teracima hooks (3.8 sun)', 'Hameçons Teracima (3.8 sun)', 'Teracima hook of size 3.8 sun', 'Hameçon Teracima de taille 3.8 sun')
;

-- refs_fishery.mechanisation_types
INSERT INTO "refs_fishery"."mechanisation_types" ("code", "name_en", "name_fr", "is_mechanized", "description_en", "description_fr") VALUES
  ('MI', 'Mechanised inboard boat ', 'Bateau à moteur intra-bord', '1', 'Fishing vessel equipped with an inboard engine', 'Navire de pêche équipé d’un moteur intra-bord'),
  ('MO', 'Mechanised outboard boat', 'Bateau à moteur hors-bord', '1', 'Fishing vessel equipped with an outboard engine', 'Navire de pêche équipé d’un moteur hors-bord'),
  ('MU', 'Mechanised boat (unspecific)', 'Bateau mécanisé (non-spécifié)', '1', 'Mechanised fishing vessel for which the engine type is not specified', 'Navire de pêche motorisé dont le type de moteur n’est pas précisé'),
  ('NM', 'Non-mechanised boat', 'Bateau non-mécanisé', '0', 'Fishing vessel without mechanical propulsion', 'Navire de pêche sans propulsion mécanique'),
  ('NS', 'Non-mechanised sailing boat', 'Bateau voilier non-mécanisé', '0', 'Sailing fishing vessel without mechanical propulsion', 'Voilier de pêche sans propulsion mécanique'),
  ('SO', 'Shore operated gears (manned)', 'La pêche côtière (sans bateau)', '0', 'Fishing gear operated directly from shore without the use of a vessel', 'Engin de pêche exploité directement depuis le rivage sans utilisation de navire'),
  ('UN', 'Unknown', 'Inconnu', '0', 'Mechanisation characteristics not known or not reported', 'Caractéristiques de motorisation non connues ou non déclarées')
;

-- refs_fishery.net_material_types
INSERT INTO "refs_fishery"."net_material_types" ("code", "code_orig", "name_en", "name_fr", "description_en", "description_fr") VALUES
  ('BR', 'BR', 'Braided', 'Tressé', 'Braided material used in the construction of fishing nets', 'Matériau tressé utilisé dans la construction des filets de pêche'),
  ('MO', 'MO', 'Monofilament', 'Monofilament', 'Monofilament material used in the construction of fishing nets', 'Matériau monofilament utilisé dans la construction des filets de pêche'),
  ('MU', 'MU', 'Multifilament', 'Multifilament', 'Multifilament material used in the construction of fishing nets', 'Matériau multifilament utilisé dans la construction des filets de pêche'),
  ('OT', 'OTH', 'Other', 'Autre', 'Net material not covered by available categories', 'Matériau de filet non couvert par les catégories disponibles'),
  ('UN', 'UNK', 'Unknown', 'Inconnu', 'Net material not known or not reported', 'Matériau de filet non connu ou non déclaré')
;

-- refs_fishery.vessel_measurement_types
INSERT INTO "refs_fishery"."vessel_measurement_types" ("code", "name_en", "name_fr", "description_en", "description_fr") VALUES
  ('CC', 'Fish carrying capacity (m3)', 'Capacité de stockage de poissons (m3)', 'Vessel fish carrying capacity expressed as storage volume in cubic metres', 'Capacité de stockage de poisson du navire exprimée en volume de stockage en mètres cubes'),
  ('CT', 'Fish carrying capacity (t)', 'Capacité de stockage de poissons (t)', 'Vessel fish carrying capacity expressed as weight in metric tonnes', 'Capacité de stockage de poisson du navire exprimée en poids, en tonnes métriques'),
  ('GR', 'Gross registered tonnage (Oslo IMO Convention)', 'Tonnage de jauge brute (Convention d''Oslo OMI)', 'Gross registered tonnage measured according to the Oslo Convention standard', 'Tonnage de jauge brute mesuré selon la Convention d’Oslo'),
  ('GT', 'Gross tonnage (London IMO Convention)', 'Tonnage brut (Convention de Londres OMI)', 'Gross tonnage measured according to the London Convention standard', 'Tonnage brut mesuré selon la Convention de Londres'),
  ('LO', 'Length overall (m)', 'Longueur hors-tout (m)', 'Vessel length measured from the foremost to the aftermost point of the hull', 'Longueur du navire mesurée entre les points extrêmes avant et arrière de la coque'),
  ('LP', 'Length between perpendiculars (m)', 'Longueur entre perpendiculaires (m)', 'Vessel length measured between the forward and aft perpendiculars', 'Longueur du navire mesurée entre les perpendiculaires avant et arrière')
;

-- refs_fishery_config.fishery_purposes
INSERT INTO "refs_fishery_config"."fishery_purposes" ("code", "name_en", "name_fr", "description_en", "description_fr") VALUES
  ('COM', 'Commercial', 'Commerciale', 'Fish is caught for commercial sale or export, including supply to processing or canning facilities', 'Poisson capturé pour la vente commerciale ou l’exportation, y compris l’approvisionnement des usines de transformation ou de conserverie'),
  ('REC', 'Recreational', 'Récréative', 'Fish is caught for recreational or sport purposes only', 'Poisson capturé uniquement à des fins récréatives ou sportives'),
  ('SAC', 'Subsistence and Commercial', 'Subsistance et Commerciale', 'Fish is used for household consumption and may also be sold locally, exported, or processed', 'Poisson destiné à la consommation des ménages et pouvant également être vendu localement, exporté ou transformé'),
  ('SCI', 'Scientific', 'Scientifique', 'Fishery operates exclusively to collect scientific data or support training activities', 'Pêcherie exploitée exclusivement pour la collecte de données scientifiques ou la formation'),
  ('SUB', 'Subsistence', 'Subsistance', 'Fish is used exclusively for household or fisher consumption', 'Poisson destiné exclusivement à la consommation des ménages ou des pêcheurs')
;

-- ================================================================
-- FOREIGN KEYS
-- ================================================================

-- refs_biology.biological_materials

-- refs_biology.fish_status

-- refs_biology.maturity_stages

-- refs_biology.recommended_measurements
ALTER TABLE "refs_biology"."recommended_measurements" ADD CONSTRAINT "fk_recommended_measurements_measurements" FOREIGN KEY (type_of_measurement_code, measurement_code) REFERENCES refs_biology.measurements(type_of_measurement_code, code) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE "refs_biology"."recommended_measurements" ADD CONSTRAINT "fk_recommended_measurements_species" FOREIGN KEY (species_code) REFERENCES refs_biology.species(code) ON UPDATE CASCADE ON DELETE CASCADE;

-- refs_biology.sample_preservation_methods

-- refs_data.logical_responses

-- refs_fishery.buoy_models

-- refs_fishery.dfad_biodegradability_categories

-- refs_fishery.gear_types_deprecated

-- refs_fishery.hook_and_terminal_devices

-- refs_fishery.mechanisation_types

-- refs_fishery.net_material_types

-- refs_fishery.vessel_measurement_types

-- refs_fishery_config.fishery_purposes

-- ================================================================
-- INDEXES
-- ================================================================

-- refs_biology.biological_materials

-- refs_biology.fish_status

-- refs_biology.maturity_stages

-- refs_biology.recommended_measurements

-- refs_biology.sample_preservation_methods

-- refs_data.logical_responses

-- refs_fishery.buoy_models

-- refs_fishery.dfad_biodegradability_categories

-- refs_fishery.gear_types_deprecated

-- refs_fishery.hook_and_terminal_devices

-- refs_fishery.mechanisation_types

-- refs_fishery.net_material_types

-- refs_fishery.vessel_measurement_types

-- refs_fishery_config.fishery_purposes

-- ================================================================
-- COMMENTS
-- ================================================================

-- refs_biology.biological_materials

-- refs_biology.fish_status

-- refs_biology.maturity_stages

-- refs_biology.recommended_measurements

-- refs_biology.sample_preservation_methods

-- refs_data.logical_responses

-- refs_fishery.buoy_models

-- refs_fishery.dfad_biodegradability_categories

-- refs_fishery.gear_types_deprecated

-- refs_fishery.hook_and_terminal_devices
COMMENT ON TABLE "refs_fishery"."hook_and_terminal_devices" IS '
[EN]
Reference code list describing hook types and other terminal capture devices used in hook-and-line fishing operations.

[FR]
Liste de référence décrivant les types d''hameçons et autres dispositifs terminaux de capture utilisés dans les opérations de pêche à l''hameçon et à la ligne.
';

-- refs_fishery.mechanisation_types
COMMENT ON TABLE "refs_fishery"."mechanisation_types" IS '
[EN]
Reference code list describing the mechanisation and propulsion characteristics of vessels and fishing operations.

[FR]
Liste de référence décrivant les caractéristiques de motorisation et de propulsion des navires et des opérations de pêche.
';

-- refs_fishery.net_material_types
COMMENT ON TABLE "refs_fishery"."net_material_types" IS '
[EN]
Reference code list describing the types of materials used in the construction of fishing nets.

[FR]
Liste de référence décrivant les types de matériaux utilisés dans la construction des filets de pêche.
';

-- refs_fishery.vessel_measurement_types
COMMENT ON TABLE "refs_fishery"."vessel_measurement_types" IS '
[EN]
Reference code list describing the measurement types used to quantify the size, tonnage, or fish carrying capacity of fishing vessels.

[FR]
Liste de référence décrivant les types de mesures utilisés pour quantifier la taille, le tonnage ou la capacité d’emport de poisson des navires de pêche.
';

-- refs_fishery_config.fishery_purposes
COMMENT ON TABLE "refs_fishery_config"."fishery_purposes" IS '
[EN]
Reference code list describing the primary purpose of fishing activities or operations.

[FR]
Liste de référence décrivant l''objectif principal des activités ou opérations de pêche.
';

