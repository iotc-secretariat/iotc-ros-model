-- refs_admin.fleets
ALTER TABLE "refs_admin"."fleets" ALTER COLUMN "name_fr" SET NOT NULL;

-- refs_biology.incidental_captures_conditions
ALTER TABLE "refs_biology"."incidental_captures_conditions" ALTER COLUMN "name_en" SET NOT NULL;
ALTER TABLE "refs_biology"."incidental_captures_conditions" ALTER COLUMN "name_fr" SET NOT NULL;

-- refs_biology.scars
ALTER TABLE "refs_biology"."scars" ALTER COLUMN "name_en" SET NOT NULL;
ALTER TABLE "refs_biology"."scars" ALTER COLUMN "name_fr" SET NOT NULL;

-- refs_fishery_config.areas_of_operation
ALTER TABLE "refs_fishery_config"."areas_of_operation" ALTER COLUMN "name_fr" SET NOT NULL;
ALTER TABLE "refs_fishery_config"."areas_of_operation" ALTER COLUMN "description_fr" SET NOT NULL;

-- refs_fishery_config.loa_classes
ALTER TABLE "refs_fishery_config"."loa_classes" ALTER COLUMN "name_en" SET NOT NULL;
ALTER TABLE "refs_fishery_config"."loa_classes" ALTER COLUMN "name_fr" SET NOT NULL;
ALTER TABLE "refs_fishery_config"."loa_classes" ALTER COLUMN "description_en" SET NOT NULL;
ALTER TABLE "refs_fishery_config"."loa_classes" ALTER COLUMN "description_fr" SET NOT NULL;

-- refs_biology.measurements
ALTER TABLE "refs_biology"."measurements" ALTER COLUMN "description_en" SET NOT NULL;
ALTER TABLE "refs_biology"."measurements" ALTER COLUMN "description_fr" SET NOT NULL;

-- refs_fishery.school_sighting_cues
ALTER TABLE "refs_fishery"."school_sighting_cues" ALTER COLUMN "school_type_category_code" SET NOT NULL;

-- refs_gis.area_intersections
ALTER TABLE "refs_gis"."area_intersections" ALTER COLUMN "intersection_area" SET NOT NULL;
