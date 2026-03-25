drop table if exists ros_common.observer_identifier_mapping cascade;
create table if not exists ros_common.observer_identifier_mapping
(
    legacy_iotc_observer_identifier varchar(16)  not null,
    iotc_observer_identifier varchar(16)  not null,
    constraint ros_common_observer_identifier_mapping_pkey
        primary key (legacy_iotc_observer_identifier),
    constraint ros_common_observer_identifier_mapping_uk
        unique (legacy_iotc_observer_identifier ,iotc_observer_identifier)
);
ALTER TABLE ros_common.observer_identifier_mapping ADD CONSTRAINT fk_ros_common_observer_identifier_mapping FOREIGN KEY (iotc_observer_identifier) REFERENCES ros_common.observer (iotc_observer_identifier);

-- fix full_name
UPDATE ros_common.contact SET full_name = 'KLEFFER YVES' WHERE full_name = 'KLEFFER YVES,';

-- remove not observers
DELETE FROM ros_common.observer WHERE contact_id = '125';
DELETE FROM ros_common.observer WHERE contact_id = '123';
DELETE FROM ros_common.observer WHERE contact_id = '35';
DELETE FROM ros_common.observer WHERE contact_id = '121';
DELETE FROM ros_common.observer WHERE contact_id = '122';
DELETE FROM ros_common.observer WHERE contact_id = '50';
-- remove bad OB role
DELETE FROM ros_common.contact_role WHERE contact_id = '125' AND role_code = 'OB';
DELETE FROM ros_common.contact_role WHERE contact_id = '123' AND role_code = 'OB';
DELETE FROM ros_common.contact_role WHERE contact_id = '35' AND role_code = 'OB';
DELETE FROM ros_common.contact_role WHERE contact_id = '121' AND role_code = 'OB';
DELETE FROM ros_common.contact_role WHERE contact_id = '122' AND role_code = 'OB';

-- replace LE GUENEC MORGAN by LE GUERNIC MORGAN
UPDATE ros_common.trip_vessel SET skipper_id = 52 WHERE skipper_id = 50;
DELETE FROM ros_common.contact_role WHERE contact_id = '50';
DELETE FROM ros_common.contact WHERE id = '50';

UPDATE ros_common.contact SET full_name = 'ADELINE GAMAYEL' WHERE full_name = 'ADELINE  GAMAYEL';
UPDATE ros_common.contact SET full_name = 'ADELINE RICKY' WHERE full_name = 'ADELINE  RICKY';
UPDATE ros_common.contact SET full_name = 'ADONIS DANILLA' WHERE full_name = 'ADONIS  DANILLA';
UPDATE ros_common.contact SET full_name = 'ADRIENNE DANIA' WHERE full_name = 'ADRIENNE  DANIA';
UPDATE ros_common.contact SET full_name = 'AGLAE ASHLEY' WHERE full_name = 'AGLAE  ASHLEY';
UPDATE ros_common.contact SET full_name = 'AGUEDA VICTORIA' WHERE full_name = 'AGUEDA  VICTORIA';
UPDATE ros_common.contact SET full_name = 'AGUIAR LILIO' WHERE full_name = 'AGUIAR LÍLIO';
UPDATE ros_common.contact SET full_name = 'AL-ABDULLA SEDDICK FANNY' WHERE full_name = 'AL-ABDULLA  SEDDICK FANNY ';
UPDATE ros_common.contact SET full_name = 'ANDREO IBANEZ JORGE' WHERE full_name = 'ANDREO IBAÑEZ JORGE';
UPDATE ros_common.contact SET full_name = 'ANDRIANSYAH VERY' WHERE full_name = 'ANDRIANSYAH  VERY   ';


-- "IRMA SURYANI","ADE","IOTCROS0995" → already token by SATAMANA (contact_id=81) c'est un observateur'
-- "KRISNA WIGUNA ","HARRI","IOTCROS0987" → already token by KESUMA SRI WENDA  (contact_id=86) ???
-- "PARTO SANJOYO","SANJOYO","IOTCROS0399","IOTCJPN034" → already token by SRIWANTO SRIWANTO (contact_id=91) c'est un observateur
-- "PRIATNA    ","NANA ","IOTCROS0991" → already token by MAHYUDIN ADAM (contact_id=83) c'est un observateur
-- "SUHERLAN                                    ","ANANG  ","IOTCROS0983" → already token by AOYAMA TAKASHI (contact_id=104) ???
-- "TOIP        ","ENCEP","IOTCROS0994" → already token by SAFII MOCHAMAT (contact_id=90) c'est un observateur
