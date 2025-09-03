-- Remove the table "ros_ll.observer_data_transhipment_details"
DROP TABLE ros_ll.observer_data_transhipment_details;

-- Remove the table "ros_ll.hauling_operations_stunning_methods"
DROP TABLE ros_ll.hauling_operations_stunning_methods;

-- Add table "ros_ll.leader_set"
CREATE TABLE ros_ll.leader_set (
    id integer NOT NULL,
    setting_operation_id integer NOT NULL,
    leader_material_type_code char(2) NOT NULL ,
    percentage_of_branchline double precision NOT NULL,
    total_branchline_minimum_length_id integer NOT NULL,
    total_branchline_maximum_length_id integer NOT NULL);

ALTER TABLE ros_ll.leader_set ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ros_ll.leader_set_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY ros_ll.leader_set
    ADD CONSTRAINT ll_leader_set_pkey PRIMARY KEY (id);

ALTER TABLE ONLY ros_ll.leader_set
    ADD CONSTRAINT fk_ros_ll_leader_set_leader_material_type_code FOREIGN KEY (leader_material_type_code) REFERENCES refs_fishery.line_material_types(code);

ALTER TABLE ONLY ros_ll.leader_set
    ADD CONSTRAINT fk_ros_ll_leader_total_branchline_minimum_length_id FOREIGN KEY (total_branchline_minimum_length_id) REFERENCES ros_common.lengths(id);

ALTER TABLE ONLY ros_ll.leader_set
    ADD CONSTRAINT fk_ros_ll_leader_total_branchline_maximum_length_id FOREIGN KEY (total_branchline_maximum_length_id) REFERENCES ros_common.lengths(id);

ALTER TABLE ros_ll.leader_set OWNER TO "ros-admin";

-- Add table "ros_ll.branchline_configurations_storage"
CREATE TABLE ros_ll.branchline_configurations_storage (
    branchline_configuration_id integer NOT NULL,
    branchline_storage_code char(2) NOT NULL);

ALTER TABLE ONLY ros_ll.branchline_configurations_storage
    ADD CONSTRAINT ll_branchline_configurations_storage_pkey PRIMARY KEY (branchline_configuration_id, branchline_storage_code);

ALTER TABLE ONLY ros_ll.branchline_configurations_storage
    ADD CONSTRAINT fk_ros_ll_branchline_configurations_storage_configuration FOREIGN KEY (branchline_configuration_id) REFERENCES ros_ll.branchline_configurations(id);

ALTER TABLE ONLY ros_ll.branchline_configurations_storage
    ADD CONSTRAINT fk_ros_ll_branchline_configurations_storage_code FOREIGN KEY (branchline_storage_code) REFERENCES refs_fishery.branchline_storages(code);

ALTER TABLE ros_ll.branchline_configurations_storage OWNER TO "ros-admin";
