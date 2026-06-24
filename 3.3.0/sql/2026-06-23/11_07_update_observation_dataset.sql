ALTER TABLE ros_common.observation_dataset ADD COLUMN reporting_year integer;
ALTER TABLE ros_common.observation_dataset ADD COLUMN reporting_entity_code VARCHAR(4);
ALTER TABLE ros_common.observation_dataset ADD COLUMN reporting_source_dataset_code CHAR(2) CHECK ( reporting_source_dataset_code = 'RO' );
ALTER TABLE ros_common.observation_dataset ADD COLUMN reporting_source_code CHAR(2);

create index if not exists index_common_observation_dataset_reporting_entity_code on ros_common.observation_dataset (reporting_country_code);
create index if not exists index_common_observation_dataset_reporting_source on ros_common.observation_dataset (reporting_source_dataset_code, reporting_source_code);

alter table ros_common.observation_dataset add constraint fk_ros_common_observation_dataset_reporting_entity_code foreign key (reporting_country_code) references refs_admin.entities(code);
alter table ros_common.observation_dataset add constraint fk_ros_common_observation_dataset_source foreign key (reporting_source_dataset_code,reporting_source_code) references refs_data.sources(dataset_code, code);
