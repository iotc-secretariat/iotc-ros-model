drop view ros_meta.v_trips_by_year_and_gear; -- depends on ros_meta.v_trips
drop view ros_meta.v_trips_by_flag_and_gear; -- depends on ros_meta.v_trips
drop view ros_analysis.v_trips_by_year_flag_and_gear; -- depends on ros_meta.v_trips_by_year_flag_and_gear
drop view ros_meta.v_trips_by_year_flag_and_gear; -- depends on ros_meta.v_trips
drop view ros_analysis.v_sets_by_year_flag_and_gear; -- depends on ros_meta.v_sets_by_year_flag_and_gear
drop view ros_meta.v_sets_by_year_flag_and_gear; -- depends on ros_meta.v_sets and ros_meta.v_trips
drop view ros_meta.v_ll_effort_summary; -- depends on ros_meta.v_sets and ros_meta.v_trips
drop view ros_meta.v_ps_effort_summary; -- depends on ros_meta.v_sets and ros_meta.v_trips
drop view ros_meta.v_target_species_by_trip; -- depends on ros_meta.v_trips
drop view ros_meta.v_fishing_days_by_year_flag_and_gear;
drop view ros_meta.v_sets_by_flag_and_gear; -- depends on ros_meta.v_sets and ros_meta.v_trips
drop view ros_meta.v_sets_by_year_and_gear; -- depends on ros_meta.v_sets
drop view ros_meta.v_trips; -- depends on ros_meta.v_gn_trips, ros_meta.v_ll_trips, ros_meta.v_pl_trips and ros_meta.v_ps_trips
drop view ros_meta.v_gn_trips;
drop view ros_meta.v_ll_trips;
drop view ros_meta.v_pl_trips;
drop view ros_meta.v_ps_trips;
drop view ros_meta.v_ps_sf;
drop view ros_meta.v_ps_length_weight;
drop view ros_meta.v_ll_catches;
drop view ros_meta.v_efforts_m; -- depends on ros_meta.v_sets, ros_meta.v_fdays and ros_meta.v_ll_hooks
drop view ros_meta.v_ll_hooks;
drop view ros_meta.v_fdays; -- depends on ros_meta.v_ll_fdays and ros_meta.v_ps_fdays
drop view ros_meta.v_ll_fdays;
drop view ros_meta.v_ps_fdays;
drop view ros_meta.v_sets; -- depends on ros_meta.v_ll_sets and ros_meta.v_ps_sets
drop view ros_meta.v_ll_sets;
drop view ros_meta.v_ps_sets;
drop view ros_analysis.v_ce; -- depends on ros_analysis.v_ca
drop view ros_analysis.v_ef_fd;
drop view ros_analysis.v_ef_raw;
drop view ros_analysis.v_efforts_by_year_flag_and_gear;
drop view ros_analysis.v_ll_ce;
drop view ros_analysis.v_observers;
drop view ros_analysis.v_ps_ce;
drop view ros_analysis.v_ps_lw;
drop view ros_analysis.v_sets_raw;
drop view ros_rlibs.v_ce; -- depends on ros_rlibs.v_ca
drop view ros_rlibs.v_ca;
drop view ros_rlibs.v_ef;
drop view ros_rlibs.v_in;
drop view ros_rlibs.v_sf;
drop view ros_analysis.v_ca;
drop view ros_analysis.v_ef;
drop view ros_analysis.v_in;
drop view ros_analysis.v_ll_ca;
drop view ros_analysis.v_ll_ef;
drop view ros_analysis.v_ll_ef_fd;
drop view ros_analysis.v_ll_ef_raw;
drop view ros_analysis.v_ll_ef_sets;
drop view ros_analysis.v_ll_in;
drop view ros_analysis.v_ll_sets_raw;
drop view ros_analysis.v_sf;
drop view ros_analysis.v_sf_l;
drop view ros_analysis.v_sf_w;
drop view ros_analysis.v_ll_sf_l;
drop view ros_analysis.v_ll_sf_w;
drop view ros_analysis.v_ps_ca;
drop view ros_analysis.v_ps_ef;
drop view ros_analysis.v_ps_ef_fd;
drop view ros_analysis.v_ps_ef_raw;
drop view ros_analysis.v_ps_in;
drop view ros_analysis.v_ps_sets_raw;
drop view ros_analysis.v_ps_sf_l;
drop view ros_analysis.v_ps_sf_w;
drop view ros_views.v_sets;
drop view ros_views.v_ll_sets;
drop view ros_views.v_ps_sets;