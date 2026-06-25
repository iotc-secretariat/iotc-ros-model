-- Generated add missing audit tables script
-- Generated at: 2026-06-25 11:07:42 +0200

-- -------------------------------------------------------------------
-- refs_legacy.areas
-- -------------------------------------------------------------------


create trigger audit_trigger_row
    after insert or update or delete
    on refs_legacy.areas
    for each row
execute procedure public.if_modified_func('true', '{code}', '{}');

create trigger audit_trigger_stm
    after truncate
    on refs_legacy.areas
execute procedure public.if_modified_func('true', '{code}');

-- -------------------------------------------------------------------
-- refs_legacy.boat_size_class
-- -------------------------------------------------------------------


create trigger audit_trigger_row
    after insert or update or delete
    on refs_legacy.boat_size_class
    for each row
execute procedure public.if_modified_func('true', '{code}', '{}');

create trigger audit_trigger_stm
    after truncate
    on refs_legacy.boat_size_class
execute procedure public.if_modified_func('true', '{code}');

-- -------------------------------------------------------------------
-- refs_legacy.condition_types
-- -------------------------------------------------------------------


create trigger audit_trigger_row
    after insert or update or delete
    on refs_legacy.condition_types
    for each row
execute procedure public.if_modified_func('true', '{code}', '{}');

create trigger audit_trigger_stm
    after truncate
    on refs_legacy.condition_types
execute procedure public.if_modified_func('true', '{code}');

-- -------------------------------------------------------------------
-- refs_legacy.effort_units
-- -------------------------------------------------------------------


create trigger audit_trigger_row
    after insert or update or delete
    on refs_legacy.effort_units
    for each row
execute procedure public.if_modified_func('true', '{code}', '{}');

create trigger audit_trigger_stm
    after truncate
    on refs_legacy.effort_units
execute procedure public.if_modified_func('true', '{code}');

-- -------------------------------------------------------------------
-- refs_legacy.fad_activity_types
-- -------------------------------------------------------------------


create trigger audit_trigger_row
    after insert or update or delete
    on refs_legacy.fad_activity_types
    for each row
execute procedure public.if_modified_func('true', '{code}', '{}');

create trigger audit_trigger_stm
    after truncate
    on refs_legacy.fad_activity_types
execute procedure public.if_modified_func('true', '{code}');

-- -------------------------------------------------------------------
-- refs_legacy.fad_ownerships
-- -------------------------------------------------------------------


create trigger audit_trigger_row
    after insert or update or delete
    on refs_legacy.fad_ownerships
    for each row
execute procedure public.if_modified_func('true', '{code}', '{}');

create trigger audit_trigger_stm
    after truncate
    on refs_legacy.fad_ownerships
execute procedure public.if_modified_func('true', '{code}');

-- -------------------------------------------------------------------
-- refs_legacy.fad_types
-- -------------------------------------------------------------------


create trigger audit_trigger_row
    after insert or update or delete
    on refs_legacy.fad_types
    for each row
execute procedure public.if_modified_func('true', '{code}', '{}');

create trigger audit_trigger_stm
    after truncate
    on refs_legacy.fad_types
execute procedure public.if_modified_func('true', '{code}');

-- -------------------------------------------------------------------
-- refs_legacy.fate_types
-- -------------------------------------------------------------------


create trigger audit_trigger_row
    after insert or update or delete
    on refs_legacy.fate_types
    for each row
execute procedure public.if_modified_func('true', '{code}', '{}');

create trigger audit_trigger_stm
    after truncate
    on refs_legacy.fate_types
execute procedure public.if_modified_func('true', '{code}');

-- -------------------------------------------------------------------
-- refs_legacy.fisheries
-- -------------------------------------------------------------------


create trigger audit_trigger_row
    after insert or update or delete
    on refs_legacy.fisheries
    for each row
execute procedure public.if_modified_func('true', '{code}', '{}');

create trigger audit_trigger_stm
    after truncate
    on refs_legacy.fisheries
execute procedure public.if_modified_func('true', '{code}');

-- -------------------------------------------------------------------
-- refs_legacy.fishery_groups
-- -------------------------------------------------------------------


create trigger audit_trigger_row
    after insert or update or delete
    on refs_legacy.fishery_groups
    for each row
execute procedure public.if_modified_func('true', '{code}', '{}');

create trigger audit_trigger_stm
    after truncate
    on refs_legacy.fishery_groups
execute procedure public.if_modified_func('true', '{code}');

-- -------------------------------------------------------------------
-- refs_legacy.fishery_types
-- -------------------------------------------------------------------


create trigger audit_trigger_row
    after insert or update or delete
    on refs_legacy.fishery_types
    for each row
execute procedure public.if_modified_func('true', '{code}', '{}');

create trigger audit_trigger_stm
    after truncate
    on refs_legacy.fishery_types
execute procedure public.if_modified_func('true', '{code}');

-- -------------------------------------------------------------------
-- refs_legacy.fishing_grounds
-- -------------------------------------------------------------------


create trigger audit_trigger_row
    after insert or update or delete
    on refs_legacy.fishing_grounds
    for each row
execute procedure public.if_modified_func('true', '{code}', '{}');

create trigger audit_trigger_stm
    after truncate
    on refs_legacy.fishing_grounds
execute procedure public.if_modified_func('true', '{code}');

-- -------------------------------------------------------------------
-- refs_legacy.fleets
-- -------------------------------------------------------------------


create trigger audit_trigger_row
    after insert or update or delete
    on refs_legacy.fleets
    for each row
execute procedure public.if_modified_func('true', '{code}', '{}');

create trigger audit_trigger_stm
    after truncate
    on refs_legacy.fleets
execute procedure public.if_modified_func('true', '{code}');

-- -------------------------------------------------------------------
-- refs_legacy.gear_types
-- -------------------------------------------------------------------


create trigger audit_trigger_row
    after insert or update or delete
    on refs_legacy.gear_types
    for each row
execute procedure public.if_modified_func('true', '{gear_code, country_code, gear_type_code}', '{}');

create trigger audit_trigger_stm
    after truncate
    on refs_legacy.gear_types
execute procedure public.if_modified_func('true', '{gear_code, country_code, gear_type_code}');

-- -------------------------------------------------------------------
-- refs_legacy.gears
-- -------------------------------------------------------------------


create trigger audit_trigger_row
    after insert or update or delete
    on refs_legacy.gears
    for each row
execute procedure public.if_modified_func('true', '{code}', '{}');

create trigger audit_trigger_stm
    after truncate
    on refs_legacy.gears
execute procedure public.if_modified_func('true', '{code}');

-- -------------------------------------------------------------------
-- refs_legacy.isscfg_gear_groups
-- -------------------------------------------------------------------


create trigger audit_trigger_row
    after insert or update or delete
    on refs_legacy.isscfg_gear_groups
    for each row
execute procedure public.if_modified_func('true', '{code}', '{}');

create trigger audit_trigger_stm
    after truncate
    on refs_legacy.isscfg_gear_groups
execute procedure public.if_modified_func('true', '{code}');

-- -------------------------------------------------------------------
-- refs_legacy.isscfg_gears
-- -------------------------------------------------------------------


create trigger audit_trigger_row
    after insert or update or delete
    on refs_legacy.isscfg_gears
    for each row
execute procedure public.if_modified_func('true', '{code}', '{}');

create trigger audit_trigger_stm
    after truncate
    on refs_legacy.isscfg_gears
execute procedure public.if_modified_func('true', '{code}');

-- -------------------------------------------------------------------
-- refs_legacy.iucn_status
-- -------------------------------------------------------------------


create trigger audit_trigger_row
    after insert or update or delete
    on refs_legacy.iucn_status
    for each row
execute procedure public.if_modified_func('true', '{code}', '{}');

create trigger audit_trigger_stm
    after truncate
    on refs_legacy.iucn_status
execute procedure public.if_modified_func('true', '{code}');

-- -------------------------------------------------------------------
-- refs_legacy.measurement_types
-- -------------------------------------------------------------------


create trigger audit_trigger_row
    after insert or update or delete
    on refs_legacy.measurement_types
    for each row
execute procedure public.if_modified_func('true', '{code}', '{}');

create trigger audit_trigger_stm
    after truncate
    on refs_legacy.measurement_types
execute procedure public.if_modified_func('true', '{code}');

-- -------------------------------------------------------------------
-- refs_legacy.nocs_codes
-- -------------------------------------------------------------------


create trigger audit_trigger_row
    after insert or update or delete
    on refs_legacy.nocs_codes
    for each row
execute procedure public.if_modified_func('true', '{id}', '{}');

create trigger audit_trigger_stm
    after truncate
    on refs_legacy.nocs_codes
execute procedure public.if_modified_func('true', '{id}');

-- -------------------------------------------------------------------
-- refs_legacy.nocs_names_en
-- -------------------------------------------------------------------


create trigger audit_trigger_row
    after insert or update or delete
    on refs_legacy.nocs_names_en
    for each row
execute procedure public.if_modified_func('true', '{id}', '{}');

create trigger audit_trigger_stm
    after truncate
    on refs_legacy.nocs_names_en
execute procedure public.if_modified_func('true', '{id}');

-- -------------------------------------------------------------------
-- refs_legacy.nocs_names_fr
-- -------------------------------------------------------------------


create trigger audit_trigger_row
    after insert or update or delete
    on refs_legacy.nocs_names_fr
    for each row
execute procedure public.if_modified_func('true', '{id}', '{}');

create trigger audit_trigger_stm
    after truncate
    on refs_legacy.nocs_names_fr
execute procedure public.if_modified_func('true', '{id}');

-- -------------------------------------------------------------------
-- refs_legacy.species_categories
-- -------------------------------------------------------------------


create trigger audit_trigger_row
    after insert or update or delete
    on refs_legacy.species_categories
    for each row
execute procedure public.if_modified_func('true', '{code}', '{}');

create trigger audit_trigger_stm
    after truncate
    on refs_legacy.species_categories
execute procedure public.if_modified_func('true', '{code}');

-- -------------------------------------------------------------------
-- refs_legacy.species_groups
-- -------------------------------------------------------------------


create trigger audit_trigger_row
    after insert or update or delete
    on refs_legacy.species_groups
    for each row
execute procedure public.if_modified_func('true', '{code}', '{}');

create trigger audit_trigger_stm
    after truncate
    on refs_legacy.species_groups
execute procedure public.if_modified_func('true', '{code}');

-- -------------------------------------------------------------------
-- refs_legacy.species_to_grsf
-- -------------------------------------------------------------------


create trigger audit_trigger_row
    after insert or update or delete
    on refs_legacy.species_to_grsf
    for each row
execute procedure public.if_modified_func('true', '{species_code}', '{}');

create trigger audit_trigger_stm
    after truncate
    on refs_legacy.species_to_grsf
execute procedure public.if_modified_func('true', '{species_code}');

-- -------------------------------------------------------------------
-- refs_legacy.un_locode_ports
-- -------------------------------------------------------------------


create trigger audit_trigger_row
    after insert or update or delete
    on refs_legacy.un_locode_ports
    for each row
execute procedure public.if_modified_func('true', '{code}', '{}');

create trigger audit_trigger_stm
    after truncate
    on refs_legacy.un_locode_ports
execute procedure public.if_modified_func('true', '{code}');

-- -------------------------------------------------------------------
-- refs_legacy.working_parties
-- -------------------------------------------------------------------


create trigger audit_trigger_row
    after insert or update or delete
    on refs_legacy.working_parties
    for each row
execute procedure public.if_modified_func('true', '{code}', '{}');

create trigger audit_trigger_stm
    after truncate
    on refs_legacy.working_parties
execute procedure public.if_modified_func('true', '{code}');

-- -------------------------------------------------------------------
-- refs_meta.codelists_versions
-- -------------------------------------------------------------------


create trigger audit_trigger_row
    after insert or update or delete
    on refs_meta.codelists_versions
    for each row
execute procedure public.if_modified_func('true', '{cl_schema, cl_name}', '{}');

create trigger audit_trigger_stm
    after truncate
    on refs_meta.codelists_versions
execute procedure public.if_modified_func('true', '{cl_schema, cl_name}');

