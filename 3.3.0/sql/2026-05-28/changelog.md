# Abstract

Changelog of the version **2026-06-28**

## Add missing foreign key

1. `ros_ll.leader_set.setting_operation_id → ros_ll.setting_operations`

## Improve ros_meta.focal_point

1. `ros_common.observer_data.submitter_id` was pointing to `ros_meta.contact.id`, change it to `ros_meta.focal_point.contact_id` 
2. fill before changing that all missing focal points from `ros_meta.contact` table

## Remove any measurement tables

1. `ros_common.capacities`
   1. `ros_common.trip_vessel.fish_storage_capacity_value`\
      `ros_common.trip_vessel.fish_storage_capacity_unit` (restricted to `m"/mt`)
2. `ros_common.depths`
   1. `ros_ps.gear_specifications.maximum_net_depth_value`\
      `ros_ps.gear_specifications.maximum_net_depth_unit` (restricted to `m`)
   2. `ros_pl.bait_fishing_operations.event_depth_value`\
      `ros_pl.bait_fishing_operations.event_depth_unit` (restricted to `m`)
   3. `ros_gn.gillnet_configuration.net_depth_value`\
      `ros_gn.gillnet_configuration.net_depth_unit` (restricted to `m`)
  
3. `ros_common.diameters`
   1. `ros_ll.branchline_sections.diameter_value`\
      `ros_ll.branchline_sections.diameter_unit` (restricted to `mm`)
4. `ros_common.distances`
    1. `ros_ll.mitigation_measures.hook_sinker_distance_value`\
      `ros_ll.mitigation_measures.hook_sinker_distance_unit` (restricted to `?`)
    2. `ros_ll.tori_line_details.streamer_distance_value`\
       `ros_ll.tori_line_details.streamer_distance_unit` (restricted to `?`)
    3. `ros_gn.gillnet_configuration.distance_between_floats_value`\
       `ros_gn.gillnet_configuration.distance_between_floats_unit` (restricted to `?`)
5. `ros_common.engines`
    1. `ros_common.trip_vessel_main_engines.main_engines_make`\
      `ros_common.trip_vessel_main_engines.main_engines_value`\
      `ros_common.trip_vessel_main_engines.main_engines_unit` (restricted to `bhp/hp`)
6. `ros_common.estimated_weights`
    1. `ros_common.biometric_information.estimated_weight_value`\
       `ros_common.biometric_information.estimated_weight_unit` (restricted to `kg/t`)\
       `ros_common.biometric_information.estimated_weight_type_of_measurement_code`\
       `ros_common.biometric_information.estimated_weight_processing_type_code`\
       `ros_common.biometric_information.estimated_weight_method_code`
    2. `ros_ps.catch_details.estimated_weight_value`\
       `ros_ps.catch_details.estimated_weight_unit` (restricted to `kg/t`)\
       `ros_ps.catch_details.estimated_weight_type_of_measurement_code`\
       `ros_ps.catch_details.estimated_weight_processing_type_code`\
       `ros_ps.catch_details.estimated_weight_method_code`
    3. `ros_ll.catch_details.estimated_weight_value`\
       `ros_ll.catch_details.estimated_weight_unit` (restricted to `kg/t`)\
       `ros_ll.catch_details.estimated_weight_type_of_measurement_code`\
       `ros_ll.catch_details.estimated_weight_processing_type_code`\
       `ros_ll.catch_details.estimated_weight_method_code`
    4. `ros_pl.catch_details.estimated_weight_value`\
       `ros_pl.catch_details.estimated_weight_unit` (restricted to `kg/t`)\
       `ros_pl.catch_details.estimated_weight_type_of_measurement_code`\
       `ros_pl.catch_details.estimated_weight_processing_type_code`\
       `ros_pl.catch_details.estimated_weight_method_code`
    5. `ros_gn.catch_details.estimated_weight_value`\
       `ros_gn.catch_details.estimated_weight_unit` (restricted to `kg/t`)\
       `ros_gn.catch_details.estimated_weight_type_of_measurement_code`\
       `ros_gn.catch_details.estimated_weight_processing_type_code`\
       `ros_gn.catch_details.estimated_weight_method_code`
7. `ros_common.heights`
    1. `ros_ll.tori_line_details.attached_height_value`\
       `ros_ll.tori_line_details.attached_height_unit` (restricted to `?`)
8. `ros_common.lengths`
    1. `ros_common.trip_vessel.loa_value`\
       `ros_common.trip_vessel.loa_unit` (restricted to `km/m`)
    2. `ros_ps.gear_specifications.maximum_net_length_value`\
       `ros_ps.gear_specifications.maximum_net_length_unit` (restricted to `km/m`)
    3. `ros_ll.branchline_sections.length_value`\
       `ros_ll.branchline_sections.length_unit` (restricted to `km/m`)
    4. `ros_ll.floatlines.floatline_length_value`\
        `ros_ll.floatlines.floatline_length_unit` (restricted to `km/m`)
    5. `ros_ll.leader_set.total_branchline_minimum_length_value`\
        `ros_ll.leader_set.total_branchline_minimum_length_unit` (restricted to `km/m`)
    6. `ros_ll.leader_set.total_branchline_maximum_length_value`\
        `ros_ll.leader_set.total_branchline_maximum_length_unit` (restricted to `km/m`)
    7. `ros_ll.setting_operations.mainline_set_length_value`\
       `ros_ll.setting_operations.mainline_set_length_unit` (restricted to `km/m`)
    8. `ros_ll.tori_line_details.tori_line_length_value`\
       `ros_ll.tori_line_details.tori_line_length_unit` (restricted to `km/m`)
    9. `ros_ll.tori_line_details.streamer_line_length_max_value`\
       `ros_ll.tori_line_details.streamer_line_length_max_unit` (restricted to `km/m`)
    10. `ros_ll.tori_line_details.streamer_line_length_min_value`\
        `ros_ll.tori_line_details.streamer_line_length_min_unit` (restricted to `km/m`)
    11. `ros_gn.gillnet_configuration.droplines_length_value`\
        `ros_gn.gillnet_configuration.droplines_length_unit` (restricted to `km/m`)
    12. `ros_gn.gillnet_configuration.net_length_value`\
        `ros_gn.gillnet_configuration.net_length_unit` (restricted to `km/m`)
9. `ros_common.locations`
    1. `ros_common.trip_observer.disembarkation_location_name`\
       `ros_common.trip_observer.disembarkation_latitude`\
       `ros_common.trip_observer.disembarkation_longitude`\
       `ros_common.trip_observer.disembarkation_country_code`\
       `ros_common.trip_observer.disembarkation_port_code`
    2. `ros_common.trip_observer.embarkation_location_name`\
       `ros_common.trip_observer.embarkation_latitude`\
       `ros_common.trip_observer.embarkation_longitude`\
       `ros_common.trip_observer.embarkation_country_code`\
       `ros_common.trip_observer.embarkation_port_code`
    3. `ros_common.trip_vessel.departure_location_name`\
       `ros_common.trip_vessel.departure_latitude`\
       `ros_common.trip_vessel.departure_longitude`\
       `ros_common.trip_vessel.departure_country_code`\
       `ros_common.trip_vessel.departure_port_code`
    4. `ros_common.trip_vessel.return_location_name`\
       `ros_common.trip_vessel.return_latitude`\
       `ros_common.trip_vessel.return_longitude`\
       `ros_common.trip_vessel.return_country_code`\
       `ros_common.trip_vessel.return_port_code`
10. `ros_common.maturity_stages`
     1. `ros_common.biometric_information.maturity_stage_level`\
        `ros_common.biometric_information.maturity_stage_scale`
11. `ros_common.measured_lengths`
    1. `ros_common.biometric_information.alternative_measured_length_value`\
       `ros_common.biometric_information.alternative_measured_length_unit` (restricted to `cm`)\
       `ros_common.biometric_information.alternative_measured_length_straight`\
       `ros_common.biometric_information.alternative_measured_length_type_of_measurement_code`\
       `ros_common.biometric_information.alternative_measured_length_measured_length_type_code`\
       `ros_common.biometric_information.alternative_measured_length_length_measuring_tool_code`
    2. `ros_common.biometric_information.measured_length_value`\
       `ros_common.biometric_information.measured_length_unit` (restricted to `cm`)\
       `ros_common.biometric_information.measured_length_straight`\
       `ros_common.biometric_information.measured_length_type_of_measurement_code`\
       `ros_common.biometric_information.measured_length_measured_length_type_code`\
       `ros_common.biometric_information.measured_length_length_measuring_tool_code`
12. `ros_common.ranges`
    1. `ros_common.trip_vessel.autonomy_range_value`\
       `ros_common.trip_vessel.autonomy_range_unit` (restricted to `?`)
13. `ros_common.sample_collection_details`
    1. `ros_common.biometric_information.sample_collection_detail_destination`\
       `ros_common.biometric_information.sample_collection_detail_preservation_method`\
       `ros_common.biometric_information.sample_collection_detail_sample_type`
14. `ros_common.sizes`
    1. `ros_ps.gear_specifications.bunt_stretched_mesh_size_value`\
       `ros_ps.gear_specifications.bunt_stretched_mesh_size_unit` (restricted to `mm`)
    2. `ros_ps.gear_specifications.mid_net_stretched_mesh_size_value`\
       `ros_ps.gear_specifications.mid_net_stretched_mesh_size_unit` (restricted to `mm`)
    3. `ros_gn.gillnet_configuration_stretched_mesh_sizes.stretched_mesh_size_value`\
       `ros_gn.gillnet_configuration_stretched_mesh_sizes.stretched_mesh_size_unit` (restricted to `mm`)
15. `ros_common.speeds`
    1. `ros_ll.setting_operations.vessel_speed_value`\
       `ros_ll.setting_operations.vessel_speed_unit` (restricted to `kn`)
    2. `ros_ll.setting_operations.line_setter_speed_value`\
       `ros_ll.setting_operations.line_setter_speed_unit` (restricted to `kn`)
16. `ros_common.thicknesses`
    1. `ros_ll.additional_catch_details_on_ssi.leader_thickness_value`\
       `ros_ll.additional_catch_details_on_ssi.leader_thickness_unit` (restricted to `?`)
17. `ros_common.tonnages`
    1. `ros_common.trip_vessel.tonnage_value`\
      `ros_common.trip_vessel.tonnage_unit` (restricted to `grt/gt`)
18. `ros_common.weights`
    1. `ros_ll.mitigation_measures.average_sinker_weight_value`\
       `ros_ll.mitigation_measures.average_sinker_weight_unit` (restricted to `?`)
    2. `ros_gn.sinkers_by_type.average_sinker_weight_value`\
       `ros_gn.sinkers_by_type.average_sinker_weight_unit` (restricted to `?`)

## Remove unused tables

1. `ros_common.carrier_vessel_identification`
2. `ros_common.powers`
3. `ros_common.properties`
4. `ros_common.sampling_details`

## Review `ros_common.trip_daily_activity_details`

Before we had: 

```
trip_daily_activities
  trip_id
  daily_activity_id

daily_activities
  id
  date
  
activity_details
  id
  comments
  time_of_day
  latitude
  longitude
  daily_activity_id
  activity_code
```

Now we have: 
```
trip_daily_activities
  id
  trip_id
  date

trip_daily_activity_details
  id
  comments
  time_of_day
  latitude
  longitude
  activity_code
  trip_daily_activity_id
```

## Rename some tables

1. `ros_common.reasons_for_days_lost` to `ros_common.trip_reasons_for_days_lost`
2. `ros_common.waste_managements` to `ros_common.trip_waste_managements`

## Rename some columns

1. `ros_ll.baits_by_conditions.setting_operations_id` to `setting_operation_id`
2. `ros_ll.branchlines_set.setting_operations_id` to `setting_operation_id`
3. `ros_ll.hooks_by_type.setting_operations_id` to `setting_operation_id`
4. `ros_ll.branchline_configurations.gear_specifications_id` to `gear_specification_id`
5. `ros_ll.setting_operations_target_species.setting_operations_id` to `setting_operation_id`
6. `ros_pl.lures_or_jiggers_by_type.gear_specifications_id` to `gear_specification_id`
7. `ros_pl.tuna_fishing_operations_target_species.tuna_fishing_operation_id2` to `tuna_fishing_operation_id`

## Add missing not null on mandatory foreign keys

1. `ros_ll.branchline_configurations.gear_specification_id`
2. `ros_ll.branchline_sections.branchline_configuration_id`
3. `ros_ll.setting_operations_target_species.target_species_code`
4. `ros_ll.branchlines_set.setting_operation_id`
5. `ros_ll.lights_by_type_and_colour.setting_operation_id`
6. `ros_ll.hooks_by_type.setting_operation_id`
7. `ros_ll.floatlines.setting_operation_id`
8. `ros_ll.baits_by_conditions.setting_operation_id`
9. `ros_ll.biteoffs_by_branchlines_set.hauling_operation_id`
10. `ros_common.trip_waste_managements.trip_id`
11. `ros_ps.cetaceans_whale_shark_sightings.setting_operation_id`
12. `ros_ps.catch_details.fishing_event_id`
13. `ros_pl.lures_or_jiggers_by_type.gear_specification_id`
14. `ros_pl.tuna_fishing_operations_target_species.target_species_code`
15. `ros_pl.specimens.catch_detail_id`
16. `ros_common.observer_data.submitter_id`
17. `ros_ps.fishing_events.setting_operation_id`


