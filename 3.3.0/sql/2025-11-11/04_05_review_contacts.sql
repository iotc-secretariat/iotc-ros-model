DROP TABLE IF EXISTS ros_common.contact_role;
DROP TABLE IF EXISTS ros_common.observer;
DROP TABLE IF EXISTS ros_common.contact;
DROP TABLE IF EXISTS refs_admin.contact_role CASCADE;

CREATE TABLE refs_admin.contact_role
(
    code    CHAR(2)      NOT NULL CONSTRAINT pk_contact_role PRIMARY KEY,
    name_en VARCHAR(255) NOT NULL,
    name_fr VARCHAR(255) NOT NULL
);

INSERT INTO refs_admin.contact_role (code, name_en, name_fr)
VALUES ('FP', 'focal point', 'point de contact'),
       ('OB', 'observer', 'observateur'),
       ('FM', 'fishing master', 'capitaine de pêche'),
       ('SK', 'skipper', 'capitaine'),
       ('TF', 'tag finder', 'tag finder?'),
       ('UN', 'unknown', 'inconnu');

CREATE TABLE ros_common.contact
(
    id               INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL CONSTRAINT pk_ros_common_contact PRIMARY KEY,
    full_name        VARCHAR(255)                         NOT NULL CONSTRAINT uk_ros_common_full_name_contact UNIQUE,
    active           BOOLEAN                              NOT NULL DEFAULT TRUE,
    email            VARCHAR(255) CONSTRAINT uk_ros_common_email_contact UNIQUE,
    phone            VARCHAR(255),
    comment          VARCHAR(255),
    nationality_code CHAR(3)
);

ALTER TABLE ros_common.contact ADD CONSTRAINT fk_ros_common_nationality_code_contact FOREIGN KEY (nationality_code) REFERENCES refs_admin.countries;

CREATE TABLE ros_common.contact_role
(
    contact_id INTEGER NOT NULL,
    role_code  CHAR(2) NOT NULL,
    CONSTRAINT pk_ros_common_contact_role PRIMARY KEY (contact_id, role_code)
);
ALTER TABLE ros_common.contact_role ADD CONSTRAINT fk_ros_common_contact_contact_role FOREIGN KEY (contact_id) REFERENCES ros_common.contact;
ALTER TABLE ros_common.contact_role ADD CONSTRAINT fk_ros_common_role_contact_role FOREIGN KEY (role_code) REFERENCES refs_admin.contact_role;

CREATE TABLE ros_common.observer
(
    contact_id               INTEGER      NOT NULL CONSTRAINT pk_ros_common_observer PRIMARY KEY,
    iotc_observer_identifier VARCHAR(255) NOT NULL CONSTRAINT uk_ros_common_iotc_observer_identifier_observer UNIQUE
);

ALTER TABLE ros_common.observer ADD CONSTRAINT fk_ros_common_contact_id_observer FOREIGN KEY (contact_id) REFERENCES ros_common.contact;
