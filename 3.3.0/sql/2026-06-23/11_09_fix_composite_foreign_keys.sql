alter table ros_common.biometric_information add constraint fk_rc_b_information_alternative_measured_length_type_of_measure foreign key (alternative_measured_length_type_of_measurement_code) references refs_biology.types_of_measurement ( code);
alter table ros_common.biometric_information add constraint fk_rc_b_information_measured_length_type_of_measure foreign key (measured_length_type_of_measurement_code) references refs_biology.types_of_measurement ( code);

alter table ros_ll.catch_details add constraint fk_ros_ll_catch_details_type_of_fate_code foreign key (type_of_fate_code) references refs_biology.types_of_fate ( code);
alter table ros_ps.catch_details add constraint fk_ros_ps_catch_details_type_of_fate_code foreign key (type_of_fate_code) references refs_biology.types_of_fate ( code);
alter table ros_gn.catch_details add constraint fk_ros_gn_catch_details_type_of_fate_code foreign key (type_of_fate_code) references refs_biology.types_of_fate ( code);
alter table ros_pl.catch_details add constraint fk_ros_pl_catch_details_type_of_fate_code foreign key (type_of_fate_code) references refs_biology.types_of_fate ( code);
alter table refs_biology.recommended_measurements add constraint fk_biology_recommended_measurements_type_of_measurement_code foreign key (type_of_measurement_code) references refs_biology.types_of_measurement( code);