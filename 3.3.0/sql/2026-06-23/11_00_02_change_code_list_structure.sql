ALTER TABLE refs_biology.species RENAME COLUMN "ORDER" TO species_order;
ALTER TABLE refs_biology.species RENAME COLUMN family TO species_family;
ALTER TABLE refs_biology.species DROP COLUMN iucn_status_code;

ALTER TABLE refs_admin.fleet_to_flags_and_fisheries ADD COLUMN id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY;

ALTER TABLE refs_admin.fleet_to_flags_and_fisheries
ADD CONSTRAINT uk_refs_admin_fleet_to_flags_and_fisheries
UNIQUE NULLS NOT DISTINCT (
  fleet_code,
  reporting_entity_code,
  flag_code,
  iotc_main_area_code,
  fishery_type_code,
  gear_category_code,
  gear_code,
  gear_configuration_code,
  fishing_mode_code,
  target_species_code,
  from_year,
  to_year
);

ALTER table refs_admin.ports DROP CONSTRAINT pk_cl_ports;
ALTER TABLE refs_admin.ports ADD CONSTRAINT pk_refs_admin_ports PRIMARY KEY (code);
ALTER TABLE refs_admin.ports DROP COLUMN id;

-- remove any rows of this table, the reference data synchronization will recreate them
DELETE from refs_admin.fleet_to_flags_and_fisheries;

-- refs_admin.cpcs
ALTER TABLE "refs_admin"."cpcs" DROP COLUMN "description_fr";
ALTER TABLE "refs_admin"."cpcs" DROP COLUMN "description_en";

-- refs_biology.bait_conditions
ALTER TABLE "refs_biology"."bait_conditions" DROP COLUMN "description_fr";
ALTER TABLE "refs_biology"."bait_conditions" DROP COLUMN "description_en";

-- refs_biology.sex
ALTER TABLE "refs_biology"."sex" DROP COLUMN "description_fr";
ALTER TABLE "refs_biology"."sex" DROP COLUMN "description_en";

-- refs_biology.species_categories
ALTER TABLE "refs_biology"."species_categories" DROP COLUMN "description_fr";
ALTER TABLE "refs_biology"."species_categories" DROP COLUMN "description_en";

-- refs_biology.species_groups
ALTER TABLE "refs_biology"."species_groups" DROP COLUMN "description_fr";
ALTER TABLE "refs_biology"."species_groups" DROP COLUMN "description_en";

-- refs_biology.types_of_fate
ALTER TABLE "refs_biology"."types_of_fate" DROP COLUMN "description_fr";
ALTER TABLE "refs_biology"."types_of_fate" DROP COLUMN "description_en";

-- refs_fishery.school_detection_methods
ALTER TABLE "refs_fishery"."school_detection_methods" DROP COLUMN "description_fr";
ALTER TABLE "refs_fishery"."school_detection_methods" DROP COLUMN "description_en";

-- refs_fishery.surface_fishery_activities
ALTER TABLE "refs_fishery"."surface_fishery_activities" ALTER COLUMN "code" TYPE character varying(3);
ALTER TABLE "refs_fishery"."surface_fishery_activities" ALTER COLUMN "name_en" TYPE character varying(512);
ALTER TABLE "refs_fishery"."surface_fishery_activities" ALTER COLUMN "name_fr" TYPE character varying(512);

-- refs_fishery_config.target_species
ALTER TABLE "refs_fishery_config"."target_species" ALTER COLUMN "description_en" TYPE character varying(600);
ALTER TABLE "refs_fishery_config"."target_species" ALTER COLUMN "description_fr" TYPE character varying(600);

-- refs_admin.ports
ALTER TABLE "refs_admin"."ports" DROP COLUMN "description_fr";
ALTER TABLE "refs_admin"."ports" DROP COLUMN "description_en";

-- refs_biology.species
ALTER TABLE "refs_biology"."species" DROP COLUMN "description_fr";
ALTER TABLE "refs_biology"."species" DROP COLUMN "description_en";

-- refs_gis.areas
ALTER TABLE "refs_gis"."areas" DROP COLUMN "description_fr";
ALTER TABLE "refs_gis"."areas" DROP COLUMN "description_en";

-- refs_biology.species_aggregates
ALTER TABLE "refs_biology"."species_aggregates" DROP COLUMN "description_fr";
ALTER TABLE "refs_biology"."species_aggregates" DROP COLUMN "description_en";

-- refs_fishery.net_conditions
ALTER TABLE "refs_fishery"."net_conditions" ALTER COLUMN "description_en" TYPE character varying(255);
ALTER TABLE "refs_fishery"."net_conditions" ALTER COLUMN "description_en" DROP NOT NULL;
ALTER TABLE "refs_fishery"."net_conditions" ALTER COLUMN "description_fr" TYPE character varying(255);
ALTER TABLE "refs_fishery"."net_conditions" ALTER COLUMN "description_fr" DROP NOT NULL;

-- refs_fishery.reasons_days_lost
ALTER TABLE "refs_fishery"."reasons_days_lost" ALTER COLUMN "description_en" TYPE character varying(255);
ALTER TABLE "refs_fishery"."reasons_days_lost" ALTER COLUMN "description_en" DROP NOT NULL;
ALTER TABLE "refs_fishery"."reasons_days_lost" ALTER COLUMN "description_fr" TYPE character varying(255);
ALTER TABLE "refs_fishery"."reasons_days_lost" ALTER COLUMN "description_fr" DROP NOT NULL;

-- refs_fishery.waste_categories
ALTER TABLE "refs_fishery"."waste_categories" ALTER COLUMN "description_en" TYPE character varying(255);
ALTER TABLE "refs_fishery"."waste_categories" ALTER COLUMN "description_en" DROP NOT NULL;
ALTER TABLE "refs_fishery"."waste_categories" ALTER COLUMN "description_fr" TYPE character varying(255);
ALTER TABLE "refs_fishery"."waste_categories" ALTER COLUMN "description_fr" DROP NOT NULL;

-- refs_fishery.waste_disposal_methods
ALTER TABLE "refs_fishery"."waste_disposal_methods" ALTER COLUMN "description_en" TYPE character varying(255);
ALTER TABLE "refs_fishery"."waste_disposal_methods" ALTER COLUMN "description_en" DROP NOT NULL;
ALTER TABLE "refs_fishery"."waste_disposal_methods" ALTER COLUMN "description_fr" TYPE character varying(255);
ALTER TABLE "refs_fishery"."waste_disposal_methods" ALTER COLUMN "description_fr" DROP NOT NULL;
