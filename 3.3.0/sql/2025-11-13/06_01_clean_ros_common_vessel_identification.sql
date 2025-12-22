ALTER TABLE ros_common.vessel_identification RENAME COLUMN iotc_number TO iotc_vessel_identifier;
ALTER TABLE ros_common.vessel_identification RENAME COLUMN imo_number TO imo_identifier;
ALTER TABLE ros_common.vessel_identification RENAME COLUMN registration_number TO registration_identifier;
ALTER TABLE ros_common.vessel_identification RENAME COLUMN ircs TO ircs_identifier;
-- For id = 148 (vessel_name: WASANA 381), change iotc_vessel_identifier from NA to IOTC017085
UPDATE ros_common.vessel_identification SET  iotc_vessel_identifier = 'IOTC017085' WHERE id = 148;

UPDATE ros_common.general_vessel_and_trip_information SET vessel_identification_id = 36 WHERE vessel_identification_id = 46;
UPDATE ros_common.vessel_identification_licensed_target_species SET vessel_identification_id = 36 WHERE vessel_identification_id = 46;
DELETE FROM ros_common.vessel_identification WHERE id = 46;

UPDATE ros_common.general_vessel_and_trip_information SET vessel_identification_id = 39 WHERE vessel_identification_id = 69;
UPDATE ros_common.vessel_identification_licensed_target_species SET vessel_identification_id = 39 WHERE vessel_identification_id = 69;
DELETE FROM ros_common.vessel_identification WHERE id = 69;

-- ???
-- UPDATE ros_common.general_vessel_and_trip_information SET vessel_identification_id = 43 WHERE vessel_identification_id = 83;
-- UPDATE ros_common.vessel_identification_licensed_target_species SET vessel_identification_id = 43 WHERE vessel_identification_id = 83;
-- DELETE FROM ros_common.vessel_identification WHERE id = 83;

UPDATE ros_common.general_vessel_and_trip_information SET vessel_identification_id = 53 WHERE vessel_identification_id = 75;
UPDATE ros_common.vessel_identification_licensed_target_species SET vessel_identification_id = 53 WHERE vessel_identification_id = 75;
DELETE FROM ros_common.vessel_identification WHERE id = 75;

UPDATE ros_common.general_vessel_and_trip_information SET vessel_identification_id = 68 WHERE vessel_identification_id = 77;
UPDATE ros_common.vessel_identification_licensed_target_species SET vessel_identification_id = 68 WHERE vessel_identification_id = 77;
DELETE FROM ros_common.vessel_identification WHERE id = 77;

UPDATE ros_common.general_vessel_and_trip_information SET vessel_identification_id = 122 WHERE vessel_identification_id = 127;
UPDATE ros_common.vessel_identification_licensed_target_species SET vessel_identification_id = 122 WHERE vessel_identification_id = 127;
DELETE FROM ros_common.vessel_identification WHERE id = 127;

UPDATE ros_common.general_vessel_and_trip_information SET vessel_identification_id = 130 WHERE vessel_identification_id = 141;
UPDATE ros_common.vessel_identification_licensed_target_species SET vessel_identification_id = 130 WHERE vessel_identification_id = 141;
DELETE FROM ros_common.vessel_identification WHERE id = 141;

UPDATE ros_common.general_vessel_and_trip_information SET vessel_identification_id = 155 WHERE vessel_identification_id = 156;
UPDATE ros_common.vessel_identification_licensed_target_species SET vessel_identification_id = 155 WHERE vessel_identification_id = 156;
DELETE FROM ros_common.vessel_identification WHERE id = 156;

UPDATE ros_common.general_vessel_and_trip_information SET vessel_identification_id = 41 WHERE vessel_identification_id = 71;
UPDATE ros_common.vessel_identification_licensed_target_species SET vessel_identification_id = 41 WHERE vessel_identification_id = 71;
DELETE FROM ros_common.vessel_identification WHERE id = 71;

UPDATE ros_common.general_vessel_and_trip_information SET vessel_identification_id = 56 WHERE vessel_identification_id = 76;
UPDATE ros_common.vessel_identification_licensed_target_species SET vessel_identification_id = 56 WHERE vessel_identification_id = 76;
DELETE FROM ros_common.vessel_identification WHERE id = 76;

UPDATE ros_common.general_vessel_and_trip_information SET vessel_identification_id = 43 WHERE vessel_identification_id = 84;
UPDATE ros_common.vessel_identification_licensed_target_species SET vessel_identification_id = 43 WHERE vessel_identification_id = 84;
DELETE FROM ros_common.vessel_identification WHERE id = 84;

UPDATE ros_common.general_vessel_and_trip_information SET vessel_identification_id = 125 WHERE vessel_identification_id = 132;
UPDATE ros_common.vessel_identification_licensed_target_species SET vessel_identification_id = 125 WHERE vessel_identification_id = 132;
DELETE FROM ros_common.vessel_identification WHERE id = 132;

UPDATE ros_common.general_vessel_and_trip_information SET vessel_identification_id = 26 WHERE vessel_identification_id = 31;
UPDATE ros_common.vessel_identification_licensed_target_species SET vessel_identification_id = 26 WHERE vessel_identification_id = 31;
DELETE FROM ros_common.vessel_identification WHERE id = 31;

UPDATE ros_common.general_vessel_and_trip_information SET vessel_identification_id = 108 WHERE vessel_identification_id = 145;
UPDATE ros_common.vessel_identification_licensed_target_species SET vessel_identification_id = 108 WHERE vessel_identification_id = 145;
DELETE FROM ros_common.vessel_identification WHERE id = 145;
UPDATE ros_common.vessel_identification SET main_fishing_gear_code = 'UN', flag_code = NULL WHERE iotc_vessel_identifier = 'IOTC000000';

-- For id = 1 (vessel_name: BRAHMA), change the value of the column 'registration_identifier' from 'FRA000918276' to '918276'.
UPDATE ros_common.vessel_identification SET  registration_identifier = '918276' WHERE id = 1;
-- For id = 2 (vessel_name: CAP CHARLOTTE), change the value of the column 'registration_identifier' from 'NA' to '909676'.
UPDATE ros_common.vessel_identification SET  registration_identifier = '909676' WHERE id = 2;
-- For id = 4 (vessel_name: MANOHAL), change the value of the column 'ircs_identifier' from 'NA' to 'FMKT'.
-- For id = 4 (vessel_name: MANOHAL), change the value of the column 'registration_identifier' from 'NA' to 'FRA000909673'.
UPDATE ros_common.vessel_identification SET  ircs_identifier = 'FMKT', registration_identifier = 'FRA000909673' WHERE id = 4;
-- For id = 5 (vessel_name: CAP TRISTAN), change the value of the column 'registration_identifier' from 'NA' to '909677'.
UPDATE ros_common.vessel_identification SET  registration_identifier = '909677' WHERE id = 5;
-- For id = 7 (vessel_name: MARINE URSULE), change the value of the column 'registration_identifier' from 'NA' to '909674'.
UPDATE ros_common.vessel_identification SET  registration_identifier = '909674' WHERE id = 7;
-- For id = 13 (vessel_name: VETYVER 8), change the value of the column 'registration_identifier' from 'NA' to 'FRA000899791'.
UPDATE ros_common.vessel_identification SET  registration_identifier = 'FRA000899791' WHERE id = 13;
-- For id = 14 (vessel_name: VETYVER 7), change the value of the column 'registration_identifier' from 'NA' to 'FRA000912534'.
UPDATE ros_common.vessel_identification SET  registration_identifier = 'FRA000912534' WHERE id = 14;
-- For id = 17 (vessel_name: PENN AR BED), change the value of the column 'registration_identifier' from 'NA' to 'FRA000899731'.
UPDATE ros_common.vessel_identification SET  registration_identifier = 'FRA000899731' WHERE id = 17;
-- For id = 18 (vessel_name: KEVIN-MORGANE), change the value of the column 'registration_identifier' from 'NA' to 'FRA000899755'.
UPDATE ros_common.vessel_identification SET  registration_identifier = 'FRA000899755' WHERE id = 18;
-- For id = 19 (vessel_name: REDER MOR), change the value of the column 'registration_identifier' from 'NA' to 'FRA000899788'.
UPDATE ros_common.vessel_identification SET  registration_identifier = 'FRA000899788' WHERE id = 19;
-- For id = 20 (vessel_name: SANT TUDY), change the value of the column 'registration_identifier' from 'NA' to 'FRA000899756'.
UPDATE ros_common.vessel_identification SET  registration_identifier = 'FRA000899756' WHERE id = 20;
-- For id = 21 (vessel_name: LE MARIUS 2), change the value of the column 'registration_identifier' from 'NA' to 'FRA000909611'.
UPDATE ros_common.vessel_identification SET  registration_identifier = 'FRA000909611' WHERE id = 21;
-- For id = 27 (vessel_name: CHARLES 4), change the value of the column 'registration_identifier' from 'FRA000899781' to '899781'.
UPDATE ros_common.vessel_identification SET  registration_identifier = '899781' WHERE id = 27;
-- For id = 28 (vessel_name: MAB-SIYAD), change the value of the column 'registration_identifier' from 'FRA000436219' to 'NULL'.
UPDATE ros_common.vessel_identification SET  registration_identifier = NULL WHERE id = 28;
-- For id = 29 (vessel_name: MAHI-MAHI), change the value of the column 'registration_identifier' from 'FRA000899770' to 'NULL'.
UPDATE ros_common.vessel_identification SET  registration_identifier = NULL WHERE id = 29;
-- For id = 30 (vessel_name: LE BIGOUDEN), change the value of the column 'registration_identifier' from 'NA' to 'FRA000909687'.
UPDATE ros_common.vessel_identification SET  registration_identifier = 'FRA000909687' WHERE id = 30;
-- For id = 32 (vessel_name: LE PUFFIN), change the value of the column 'registration_identifier' from 'NA' to '899818'.
UPDATE ros_common.vessel_identification SET  registration_identifier = '899818' WHERE id = 32;
-- For id = 36 (vessel_name: SUMIYOSHI NO.10), change the value of the column 'imo_identifier' from 'NA' to '9152222'.
-- For id = 36 (vessel_name: SUMIYOSHI NO.10), change the value of the column 'vessel_name' from 'SUMIYOSHI No.10' to 'SUMIYOSHI MARU NO. 10'.
-- For id = 36 (vessel_name: SUMIYOSHI NO.10), change the value of the column 'registration_identifier' from 'NA' to 'KN1-726'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '9152222', vessel_name = 'SUMIYOSHI MARU NO. 10', registration_identifier = 'KN1-726' WHERE id = 36;
-- For id = 37 (vessel_name: HUKUKYU NO.32), change the value of the column 'imo_identifier' from 'NA' to '8803989'.
-- For id = 37 (vessel_name: HUKUKYU NO.32), change the value of the column 'vessel_name' from 'HUKUKYU No.32' to 'FUKUKYU MARU NO.32'.
-- For id = 37 (vessel_name: HUKUKYU NO.32), change the value of the column 'registration_identifier' from 'NA' to 'SO1-1056'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '8803989', vessel_name = 'FUKUKYU MARU NO.32', registration_identifier = 'SO1-1056' WHERE id = 37;
-- For id = 38 (vessel_name: WAKASHIO MARU NO.83), change the value of the column 'imo_identifier' from 'NA' to '9109249'.
-- For id = 38 (vessel_name: WAKASHIO MARU NO.83), change the value of the column 'vessel_name' from 'WAKASHIO MARU No.83' to 'WAKASHIO MARU NO.83'.
-- For id = 38 (vessel_name: WAKASHIO MARU NO.83), change the value of the column 'registration_identifier' from 'NA' to 'KG1-283'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '9109249', vessel_name = 'WAKASHIO MARU NO.83', registration_identifier = 'KG1-283' WHERE id = 38;
-- For id = 39 (vessel_name: SHOUHUKU MARU NO.8), change the value of the column 'imo_identifier' from 'NA' to '9254123'.
-- For id = 39 (vessel_name: SHOUHUKU MARU NO.8), change the value of the column 'vessel_name' from 'SHOUHUKU MARU No.8' to 'SHOFUKU MARU NO.8'.
-- For id = 39 (vessel_name: SHOUHUKU MARU NO.8), change the value of the column 'registration_identifier' from 'NA' to 'MG1-1980'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '9254123', vessel_name = 'SHOFUKU MARU NO.8', registration_identifier = 'MG1-1980' WHERE id = 39;
-- For id = 40 (vessel_name: MATUFUKU MARU NO.68), change the value of the column 'imo_identifier' from 'NA' to '8520161'.
-- For id = 40 (vessel_name: MATUFUKU MARU NO.68), change the value of the column 'vessel_name' from 'MATUFUKU MARU No.68' to 'MATSUFUKU MARU NO.68'.
-- For id = 40 (vessel_name: MATUFUKU MARU NO.68), change the value of the column 'registration_identifier' from 'NA' to 'KG1-668'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '8520161', vessel_name = 'MATSUFUKU MARU NO.68', registration_identifier = 'KG1-668' WHERE id = 40;
-- For id = 41 (vessel_name: SHOUHOUMARU NO.1), change the value of the column 'imo_identifier' from 'NA' to '8603822'.
-- For id = 41 (vessel_name: SHOUHOUMARU NO.1), change the value of the column 'vessel_name' from 'SHOUHOUMARU No.1' to 'SHOHO MARU NO.1'.
-- For id = 41 (vessel_name: SHOUHOUMARU NO.1), change the value of the column 'registration_identifier' from 'NA' to 'MG1-1981'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '8603822', vessel_name = 'SHOHO MARU NO.1', registration_identifier = 'MG1-1981' WHERE id = 41;
-- For id = 42 (vessel_name: SHOUUFUKUMARU NO.78), change the value of the column 'imo_identifier' from 'NA' to '9115145'.
-- For id = 42 (vessel_name: SHOUUFUKUMARU NO.78), change the value of the column 'vessel_name' from 'SHOUUFUKUMARU No.78' to 'SHOFUKU MARU  NO. 78'.
-- For id = 42 (vessel_name: SHOUUFUKUMARU NO.78), change the value of the column 'registration_identifier' from 'NA' to 'MG1-1908'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '9115145', vessel_name = 'SHOFUKU MARU  NO. 78', registration_identifier = 'MG1-1908' WHERE id = 42;
-- For id = 43 (vessel_name: SEIFUKUMARU NO.88), change the value of the column 'imo_identifier' from 'NA' to '9634751'.
-- For id = 43 (vessel_name: SEIFUKUMARU NO.88), change the value of the column 'vessel_name' from 'SEIFUKUMARU No.88' to 'SEIFUKU MARU NO. 88'.
-- For id = 43 (vessel_name: SEIFUKUMARU NO.88), change the value of the column 'registration_identifier' from 'NA' to 'IT1-704'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '9634751', vessel_name = 'SEIFUKU MARU NO. 88', registration_identifier = 'IT1-704' WHERE id = 43;
-- For id = 44 (vessel_name: WAKASIOMARU NO.58), change the value of the column 'imo_identifier' from 'NA' to '8814952'.
-- For id = 44 (vessel_name: WAKASIOMARU NO.58), change the value of the column 'vessel_name' from 'WAKASIOMARU No.58' to 'WAKASHIO MARU NO.58'.
-- For id = 44 (vessel_name: WAKASIOMARU NO.58), change the value of the column 'registration_identifier' from 'NA' to 'KG1-9'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '8814952', vessel_name = 'WAKASHIO MARU NO.58', registration_identifier = 'KG1-9' WHERE id = 44;
-- For id = 45 (vessel_name: MATSUEI MARU NO.11), change the value of the column 'imo_identifier' from 'NA' to '8415914'.
-- For id = 45 (vessel_name: MATSUEI MARU NO.11), change the value of the column 'vessel_name' from 'MATSUEI MARU No.11' to 'MATSUEI MARU NO.11'.
-- For id = 45 (vessel_name: MATSUEI MARU NO.11), change the value of the column 'registration_identifier' from 'NA' to 'KG1-222'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '8415914', vessel_name = 'MATSUEI MARU NO.11', registration_identifier = 'KG1-222' WHERE id = 45;
-- For id = 47 (vessel_name: 8 RYOYOSHI MARU), change the value of the column 'imo_identifier' from 'NA' to '9172911'.
-- For id = 47 (vessel_name: 8 RYOYOSHI MARU), change the value of the column 'vessel_name' from '8 RYOYOSHI MARU' to 'RYOYOSHI MARU NO. 8'.
-- For id = 47 (vessel_name: 8 RYOYOSHI MARU), change the value of the column 'registration_identifier' from 'NA' to 'MG1-2030'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '9172911', vessel_name = 'RYOYOSHI MARU NO. 8', registration_identifier = 'MG1-2030' WHERE id = 47;
-- For id = 48 (vessel_name: TAIYO MARU NO.28), change the value of the column 'imo_identifier' from 'NA' to '8708036'.
-- For id = 48 (vessel_name: TAIYO MARU NO.28), change the value of the column 'vessel_name' from 'TAIYO MARU No.28' to 'TAIYO MARU NO.28'.
-- For id = 48 (vessel_name: TAIYO MARU NO.28), change the value of the column 'registration_identifier' from 'NA' to 'KG1-228'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '8708036', vessel_name = 'TAIYO MARU NO.28', registration_identifier = 'KG1-228' WHERE id = 48;
-- For id = 49 (vessel_name: KOUTOKU MARU NO.3), change the value of the column 'imo_identifier' from 'NA' to '8904109'.
-- For id = 49 (vessel_name: KOUTOKU MARU NO.3), change the value of the column 'vessel_name' from 'KOUTOKU MARU No.3' to 'KOTOKU MARU NO.3'.
-- For id = 49 (vessel_name: KOUTOKU MARU NO.3), change the value of the column 'registration_identifier' from 'NA' to 'KG1-203'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '8904109', vessel_name = 'KOTOKU MARU NO.3', registration_identifier = 'KG1-203' WHERE id = 49;
-- For id = 50 (vessel_name: SHOFUKU MARU NO.38), change the value of the column 'imo_identifier' from 'NA' to '9037549'.
-- For id = 50 (vessel_name: SHOFUKU MARU NO.38), change the value of the column 'vessel_name' from 'SHOFUKU MARU No.38' to 'SHOFUKU MARU NO. 38'.
-- For id = 50 (vessel_name: SHOFUKU MARU NO.38), change the value of the column 'registration_identifier' from 'NA' to 'MG1-1850'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '9037549', vessel_name = 'SHOFUKU MARU NO. 38', registration_identifier = 'MG1-1850' WHERE id = 50;
-- For id = 51 (vessel_name: FUKUTOKU MARU NO.37), change the value of the column 'imo_identifier' from 'NA' to '9066904'.
-- For id = 51 (vessel_name: FUKUTOKU MARU NO.37), change the value of the column 'vessel_name' from 'FUKUTOKU MARU No.37' to 'FUKUTOKU MARU NO. 37'.
-- For id = 51 (vessel_name: FUKUTOKU MARU NO.37), change the value of the column 'registration_identifier' from 'NA' to 'MG1-1880'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '9066904', vessel_name = 'FUKUTOKU MARU NO. 37', registration_identifier = 'MG1-1880' WHERE id = 51;
-- For id = 52 (vessel_name: YAHATA MARU NO.5), change the value of the column 'imo_identifier' from 'NA' to '9658549'.
-- For id = 52 (vessel_name: YAHATA MARU NO.5), change the value of the column 'vessel_name' from 'YAHATA MARU No.5' to 'YAHATA MARU NO.5'.
-- For id = 52 (vessel_name: YAHATA MARU NO.5), change the value of the column 'registration_identifier' from 'NA' to 'MG1-2062'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '9658549', vessel_name = 'YAHATA MARU NO.5', registration_identifier = 'MG1-2062' WHERE id = 52;
-- For id = 53 (vessel_name: MYOJIN MARU NO.3), change the value of the column 'imo_identifier' from 'NA' to '1075363'.
-- For id = 53 (vessel_name: MYOJIN MARU NO.3), change the value of the column 'iotc_vessel_identifier' from 'IOTC001416' to 'IOTC090390'.
-- For id = 53 (vessel_name: MYOJIN MARU NO.3), change the value of the column 'ircs_identifier' from 'JRRF' to '7KQK'.
-- For id = 53 (vessel_name: MYOJIN MARU NO.3), change the value of the column 'vessel_name' from 'MYOJIN MARU No.3' to 'MYOJIN MARU NO.3'.
-- For id = 53 (vessel_name: MYOJIN MARU NO.3), change the value of the column 'registration_identifier' from 'NA' to 'NA'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '1075363', iotc_vessel_identifier = 'IOTC090390', ircs_identifier = '7KQK', vessel_name = 'MYOJIN MARU NO.3', registration_identifier = NULL WHERE id = 53;
-- For id = 54 (vessel_name: TAIYO MARU NO.58), change the value of the column 'imo_identifier' from 'NA' to '8921119'.
-- For id = 54 (vessel_name: TAIYO MARU NO.58), change the value of the column 'vessel_name' from 'TAIYO MARU No.58' to 'TAIYO MARU NO.58'.
-- For id = 54 (vessel_name: TAIYO MARU NO.58), change the value of the column 'registration_identifier' from 'NA' to 'SO1-1278'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '8921119', vessel_name = 'TAIYO MARU NO.58', registration_identifier = 'SO1-1278' WHERE id = 54;
-- For id = 55 (vessel_name: HINODE MARU NO.38), change the value of the column 'imo_identifier' from 'NA' to '9311919'.
-- For id = 55 (vessel_name: HINODE MARU NO.38), change the value of the column 'vessel_name' from 'HINODE MARU No.38' to 'HINODE MARU NO.38'.
-- For id = 55 (vessel_name: HINODE MARU NO.38), change the value of the column 'registration_identifier' from 'NA' to 'SO1-1216'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '9311919', vessel_name = 'HINODE MARU NO.38', registration_identifier = 'SO1-1216' WHERE id = 55;
-- For id = 56 (vessel_name: MATSUEI MARU NO.2), change the value of the column 'imo_identifier' from 'NA' to '8614998'.
-- For id = 56 (vessel_name: MATSUEI MARU NO.2), change the value of the column 'vessel_name' from 'MATSUEI MARU No.2' to 'MATSUEI MARU NO.2'.
-- For id = 56 (vessel_name: MATSUEI MARU NO.2), change the value of the column 'registration_identifier' from 'NA' to 'KG1-202'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '8614998', vessel_name = 'MATSUEI MARU NO.2', registration_identifier = 'KG1-202' WHERE id = 56;
-- For id = 57 (vessel_name: 18 SYOFUKU MARU), change the value of the column 'imo_identifier' from 'NA' to '9709843'.
-- For id = 57 (vessel_name: 18 SYOFUKU MARU), change the value of the column 'vessel_name' from '18 SYOFUKU MARU' to 'SHOFUKU MARU NO.18'.
-- For id = 57 (vessel_name: 18 SYOFUKU MARU), change the value of the column 'registration_identifier' from 'NA' to 'MG1-2078'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '9709843', vessel_name = 'SHOFUKU MARU NO.18', registration_identifier = 'MG1-2078' WHERE id = 57;
-- For id = 58 (vessel_name: TAIYO MARU NO.21), change the value of the column 'imo_identifier' from 'NA' to '9042776'.
-- For id = 58 (vessel_name: TAIYO MARU NO.21), change the value of the column 'vessel_name' from 'TAIYO MARU No.21' to 'TAIYOU MARU NO.21'.
-- For id = 58 (vessel_name: TAIYO MARU NO.21), change the value of the column 'registration_identifier' from 'NA' to 'FS1-5'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '9042776', vessel_name = 'TAIYOU MARU NO.21', registration_identifier = 'FS1-5' WHERE id = 58;
-- For id = 59 (vessel_name: KYOSHIN MARU NO.31), change the value of the column 'imo_identifier' from 'NA' to '9167760'.
-- For id = 59 (vessel_name: KYOSHIN MARU NO.31), change the value of the column 'vessel_name' from 'KYOSHIN MARU No.31' to 'KYOSHIN MARU NO.31'.
-- For id = 59 (vessel_name: KYOSHIN MARU NO.31), change the value of the column 'registration_identifier' from 'NA' to 'KG1-267'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '9167760', vessel_name = 'KYOSHIN MARU NO.31', registration_identifier = 'KG1-267' WHERE id = 59;
-- For id = 60 (vessel_name: KOUEI MARU NO.1), change the value of the column 'imo_identifier' from 'NA' to '9258064'.
-- For id = 60 (vessel_name: KOUEI MARU NO.1), change the value of the column 'vessel_name' from 'KOUEI MARU No.1' to 'KOEI MARU NO.1'.
-- For id = 60 (vessel_name: KOUEI MARU NO.1), change the value of the column 'registration_identifier' from 'NA' to 'KG1-1'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '9258064', vessel_name = 'KOEI MARU NO.1', registration_identifier = 'KG1-1' WHERE id = 60;
-- For id = 61 (vessel_name: RYUUSEI MARU NO.8), change the value of the column 'imo_identifier' from 'NA' to '8708012'.
-- For id = 61 (vessel_name: RYUUSEI MARU NO.8), change the value of the column 'vessel_name' from 'RYUUSEI MARU No.8' to 'RYUSEI MARU NO.8'.
-- For id = 61 (vessel_name: RYUUSEI MARU NO.8), change the value of the column 'registration_identifier' from 'NA' to 'KG1-383'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '8708012', vessel_name = 'RYUSEI MARU NO.8', registration_identifier = 'KG1-383' WHERE id = 61;
-- For id = 62 (vessel_name: FUKUTOKU MARU NO.38), change the value of the column 'imo_identifier' from 'NA' to '9185360'.
-- For id = 62 (vessel_name: FUKUTOKU MARU NO.38), change the value of the column 'vessel_name' from 'FUKUTOKU MARU No.38' to 'FUKUTOKU MARU NO. 38'.
-- For id = 62 (vessel_name: FUKUTOKU MARU NO.38), change the value of the column 'registration_identifier' from 'NA' to 'MG1-1938'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '9185360', vessel_name = 'FUKUTOKU MARU NO. 38', registration_identifier = 'MG1-1938' WHERE id = 62;
-- For id = 63 (vessel_name: SEIFUKU MARU NO.78), change the value of the column 'imo_identifier' from 'NA' to '9262792'.
-- For id = 63 (vessel_name: SEIFUKU MARU NO.78), change the value of the column 'vessel_name' from 'SEIFUKU MARU No.78' to 'SEIFUKU MARU NO. 78'.
-- For id = 63 (vessel_name: SEIFUKU MARU NO.78), change the value of the column 'registration_identifier' from 'NA' to 'IT1-703'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '9262792', vessel_name = 'SEIFUKU MARU NO. 78', registration_identifier = 'IT1-703' WHERE id = 63;
-- For id = 64 (vessel_name: HUKUTOKU MARU NO.88), change the value of the column 'imo_identifier' from 'NA' to '9671711'.
-- For id = 64 (vessel_name: HUKUTOKU MARU NO.88), change the value of the column 'vessel_name' from 'HUKUTOKU MARU No.88' to 'FUKUTOKU MARU NO. 88'.
-- For id = 64 (vessel_name: HUKUTOKU MARU NO.88), change the value of the column 'registration_identifier' from 'NA' to 'MG1-2066'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '9671711', vessel_name = 'FUKUTOKU MARU NO. 88', registration_identifier = 'MG1-2066' WHERE id = 64;
-- For id = 65 (vessel_name: KATSUEI MARU NO.8), change the value of the column 'imo_identifier' from 'NA' to '8990225'.
-- For id = 65 (vessel_name: KATSUEI MARU NO.8), change the value of the column 'vessel_name' from 'KATSUEI MARU NO.8' to 'KATSUEI MARU NO. 8'.
-- For id = 65 (vessel_name: KATSUEI MARU NO.8), change the value of the column 'registration_identifier' from 'NA' to 'KG1-880'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '8990225', vessel_name = 'KATSUEI MARU NO. 8', registration_identifier = 'KG1-880' WHERE id = 65;
-- For id = 66 (vessel_name: SHOUEI MARU NO.123), change the value of the column 'imo_identifier' from 'NA' to '9671735'.
-- For id = 66 (vessel_name: SHOUEI MARU NO.123), change the value of the column 'vessel_name' from 'SHOUEI MARU No.123' to 'SHOEI MARU NO. 123'.
-- For id = 66 (vessel_name: SHOUEI MARU NO.123), change the value of the column 'registration_identifier' from 'NA' to 'MG1-2071'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '9671735', vessel_name = 'SHOEI MARU NO. 123', registration_identifier = 'MG1-2071' WHERE id = 66;
-- For id = 67 (vessel_name: SHOEI MARU NO.88), change the value of the column 'imo_identifier' from 'NA' to '9036715'.
-- For id = 67 (vessel_name: SHOEI MARU NO.88), change the value of the column 'vessel_name' from 'SHOEI MARU No.88' to 'SHOEI MARU NO.88'.
-- For id = 67 (vessel_name: SHOEI MARU NO.88), change the value of the column 'registration_identifier' from 'NA' to 'MG1-1838'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '9036715', vessel_name = 'SHOEI MARU NO.88', registration_identifier = 'MG1-1838' WHERE id = 67;
-- For id = 68 (vessel_name: MYOJIN MARU NO.8), change the value of the column 'imo_identifier' from 'NA' to '8921250'.
-- For id = 68 (vessel_name: MYOJIN MARU NO.8), change the value of the column 'ircs_identifier' from 'JIJL' to '6KSA'.
-- For id = 68 (vessel_name: MYOJIN MARU NO.8), change the value of the column 'vessel_name' from 'MYOJIN MARU No.8' to 'NO.11 HAE CHEON'.
-- For id = 68 (vessel_name: MYOJIN MARU NO.8), change the value of the column 'registration_identifier' from 'NA' to '1705001-6261409'.
-- For id = 68 (vessel_name: MYOJIN MARU NO.8), change the value of the column 'flag_code' from 'JPN' to 'KOR'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '8921250', ircs_identifier = '6KSA', vessel_name = 'NO.11 HAE CHEON', registration_identifier = '1705001-6261409', flag_code = 'KOR' WHERE id = 68;
-- For id = 70 (vessel_name: FUKUSEKI MARU NO.31), change the value of the column 'imo_identifier' from 'NA' to '9119050'.
-- For id = 70 (vessel_name: FUKUSEKI MARU NO.31), change the value of the column 'vessel_name' from 'FUKUSEKI MARU No.31' to 'TOYOKUNI MARU NO.31'.
-- For id = 70 (vessel_name: FUKUSEKI MARU NO.31), change the value of the column 'registration_identifier' from 'NA' to 'SO1-1155'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '9119050', vessel_name = 'TOYOKUNI MARU NO.31', registration_identifier = 'SO1-1155' WHERE id = 70;
-- For id = 72 (vessel_name: FUKUSEKI MARU NO.35), change the value of the column 'imo_identifier' from 'NA' to '9279941'.
-- For id = 72 (vessel_name: FUKUSEKI MARU NO.35), change the value of the column 'vessel_name' from 'FUKUSEKI MARU No.35' to 'FUKUSEKI MARU NO.35'.
-- For id = 72 (vessel_name: FUKUSEKI MARU NO.35), change the value of the column 'registration_identifier' from 'NA' to 'SO1-1258'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '9279941', vessel_name = 'FUKUSEKI MARU NO.35', registration_identifier = 'SO1-1258' WHERE id = 72;
-- For id = 73 (vessel_name: TOUEI MARU NO.6), change the value of the column 'imo_identifier' from 'NA' to '8909745'.
-- For id = 73 (vessel_name: TOUEI MARU NO.6), change the value of the column 'vessel_name' from 'TOUEI MARU No.6' to 'TOEI MARU NO.6'.
-- For id = 73 (vessel_name: TOUEI MARU NO.6), change the value of the column 'registration_identifier' from 'NA' to 'KN1-702'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '8909745', vessel_name = 'TOEI MARU NO.6', registration_identifier = 'KN1-702' WHERE id = 73;
-- For id = 74 (vessel_name: 85 KINEI MARU), change the value of the column 'imo_identifier' from 'NA' to '9287364'.
-- For id = 74 (vessel_name: 85 KINEI MARU), change the value of the column 'vessel_name' from '85 KINEI MARU' to 'KINEI MARU NO. 85'.
-- For id = 74 (vessel_name: 85 KINEI MARU), change the value of the column 'registration_identifier' from 'NA' to 'IT1-604'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '9287364', vessel_name = 'KINEI MARU NO. 85', registration_identifier = 'IT1-604' WHERE id = 74;
-- For id = 75 (vessel_name: MYOUJIN MARU NO.3), change the value of the column 'imo_identifier' from 'NA' to '9004396'.
-- For id = 75 (vessel_name: MYOUJIN MARU NO.3), change the value of the column 'vessel_name' from 'MYOUJIN MARU No.3' to 'MYOJIN MARU NO.3'.
-- For id = 75 (vessel_name: MYOUJIN MARU NO.3), change the value of the column 'registration_identifier' from 'NA' to 'MG1-1782'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '9004396', vessel_name = 'MYOJIN MARU NO.3', registration_identifier = 'MG1-1782' WHERE id = 75;
-- For id = 77 (vessel_name: MYOUJINN MARU NO.8), change the value of the column 'imo_identifier' from 'NA' to '8921250'.
-- For id = 77 (vessel_name: MYOUJINN MARU NO.8), change the value of the column 'ircs_identifier' from 'JIJL' to '6KSA'.
-- For id = 77 (vessel_name: MYOUJINN MARU NO.8), change the value of the column 'vessel_name' from 'MYOUJINN MARU No.8' to 'NO.11 HAE CHEON'.
-- For id = 77 (vessel_name: MYOUJINN MARU NO.8), change the value of the column 'registration_identifier' from 'NA' to '1705001-6261409'.
-- For id = 77 (vessel_name: MYOUJINN MARU NO.8), change the value of the column 'flag_code' from 'JPN' to 'KOR'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '8921250', ircs_identifier = '6KSA', vessel_name = 'NO.11 HAE CHEON', registration_identifier = '1705001-6261409', flag_code = 'KOR' WHERE id = 77;
-- For id = 78 (vessel_name: TAIYOU MARU NO.8), change the value of the column 'imo_identifier' from 'NA' to '9057977'.
-- For id = 78 (vessel_name: TAIYOU MARU NO.8), change the value of the column 'vessel_name' from 'TAIYOU MARU No.8' to 'TAIYO MARU NO.8'.
-- For id = 78 (vessel_name: TAIYOU MARU NO.8), change the value of the column 'registration_identifier' from 'NA' to 'KG1-38'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '9057977', vessel_name = 'TAIYO MARU NO.8', registration_identifier = 'KG1-38' WHERE id = 78;
-- For id = 79 (vessel_name: KOUEI MARU NO.88), change the value of the column 'imo_identifier' from 'NA' to '9128714'.
-- For id = 79 (vessel_name: KOUEI MARU NO.88), change the value of the column 'vessel_name' from 'KOUEI MARU No.88' to 'KOEI MARU NO.88'.
-- For id = 79 (vessel_name: KOUEI MARU NO.88), change the value of the column 'registration_identifier' from 'NA' to 'KG1-888'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '9128714', vessel_name = 'KOEI MARU NO.88', registration_identifier = 'KG1-888' WHERE id = 79;
-- For id = 80 (vessel_name: SEIFUKU MARU NO.68), change the value of the column 'imo_identifier' from 'NA' to '9036765'.
-- For id = 80 (vessel_name: SEIFUKU MARU NO.68), change the value of the column 'vessel_name' from 'SEIFUKU MARU No.68' to 'SEIFUKU MARU NO.68'.
-- For id = 80 (vessel_name: SEIFUKU MARU NO.68), change the value of the column 'registration_identifier' from 'NA' to 'IT1-296'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '9036765', vessel_name = 'SEIFUKU MARU NO.68', registration_identifier = 'IT1-296' WHERE id = 80;
-- For id = 81 (vessel_name: FUKURYUU MARU NO.21), change the value of the column 'imo_identifier' from 'NA' to '9042740'.
-- For id = 81 (vessel_name: FUKURYUU MARU NO.21), change the value of the column 'vessel_name' from 'FUKURYUU MARU No.21' to 'FUKURYU MARU NO. 21'.
-- For id = 81 (vessel_name: FUKURYUU MARU NO.21), change the value of the column 'registration_identifier' from 'NA' to 'SO1-1102'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '9042740', vessel_name = 'FUKURYU MARU NO. 21', registration_identifier = 'SO1-1102' WHERE id = 81;
-- For id = 82 (vessel_name: KATSUEI MARU NO.88), change the value of the column 'imo_identifier' from 'NA' to '9172973'.
-- For id = 82 (vessel_name: KATSUEI MARU NO.88), change the value of the column 'vessel_name' from 'KATSUEI MARU No.88' to 'KATSUEI MARU NO. 88'.
-- For id = 82 (vessel_name: KATSUEI MARU NO.88), change the value of the column 'registration_identifier' from 'NA' to 'KG1-800'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '9172973', vessel_name = 'KATSUEI MARU NO. 88', registration_identifier = 'KG1-800' WHERE id = 82;
-- For id = 83 (vessel_name: KOTOSHIRO MARU NO.58), change the value of the column 'imo_identifier' from 'NA' to '9942782'.
-- For id = 83 (vessel_name: KOTOSHIRO MARU NO.58), change the value of the column 'iotc_vessel_identifier' from 'IOTC001554' to 'IOTC018214'.
-- For id = 83 (vessel_name: KOTOSHIRO MARU NO.58), change the value of the column 'ircs_identifier' from 'JIOU' to '7KKT'.
-- For id = 83 (vessel_name: KOTOSHIRO MARU NO.58), change the value of the column 'vessel_name' from 'KOTOSHIRO MARU No.58' to 'KOTOSHIRO MARU NO.58'.
-- For id = 83 (vessel_name: KOTOSHIRO MARU NO.58), change the value of the column 'registration_identifier' from 'NA' to 'SO1-1858'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '9942782', iotc_vessel_identifier = 'IOTC018214', ircs_identifier = '7KKT', vessel_name = 'KOTOSHIRO MARU NO.58', registration_identifier = 'SO1-1858' WHERE id = 83;
-- For id = 85 (vessel_name: ELAI ALAI), change the value of the column 'registration_identifier' from 'NA' to 'ESP000022462'.
UPDATE ros_common.vessel_identification SET  registration_identifier = 'ESP000022462' WHERE id = 85;
-- For id = 86 (vessel_name: ALAKRANA), change the value of the column 'registration_identifier' from 'NA' to 'ESP000026547'.
UPDATE ros_common.vessel_identification SET  registration_identifier = 'ESP000026547' WHERE id = 86;
-- For id = 87 (vessel_name: PLAYA DE ARITZATXU), change the value of the column 'ircs_identifier' from 'EBVR' to 'S7SP'.
-- For id = 87 (vessel_name: PLAYA DE ARITZATXU), change the value of the column 'vessel_name' from 'PLAYA DE ARITZATXU' to 'BETI AURRERA'.
-- For id = 87 (vessel_name: PLAYA DE ARITZATXU), change the value of the column 'registration_identifier' from 'NA' to '50360'.
-- For id = 87 (vessel_name: PLAYA DE ARITZATXU), change the value of the column 'flag_code' from 'ESP' to 'SYC'.
UPDATE ros_common.vessel_identification SET  ircs_identifier = 'S7SP', vessel_name = 'BETI AURRERA', registration_identifier = '50360', flag_code = 'SYC' WHERE id = 87;
-- For id = 88 (vessel_name: ALBACORA CUATRO), change the value of the column 'registration_identifier' from 'NA' to 'ESP000000755'.
UPDATE ros_common.vessel_identification SET  registration_identifier = 'ESP000000755' WHERE id = 88;
-- For id = 89 (vessel_name: TXORI ARGI), change the value of the column 'registration_identifier' from 'NA' to 'ESP000025900'.
UPDATE ros_common.vessel_identification SET  registration_identifier = 'ESP000025900' WHERE id = 89;
-- For id = 90 (vessel_name: IZURDIA), change the value of the column 'registration_identifier' from 'NA' to 'ESP000026158'.
UPDATE ros_common.vessel_identification SET  registration_identifier = 'ESP000026158' WHERE id = 90;
-- For id = 91 (vessel_name: ALBATUN TRES), change the value of the column 'registration_identifier' from 'NA' to 'ESP000026123'.
UPDATE ros_common.vessel_identification SET  registration_identifier = 'ESP000026123' WHERE id = 91;
-- For id = 92 (vessel_name: ATERPE ALAI), change the value of the column 'registration_identifier' from 'NA' to 'ESP000100101'.
UPDATE ros_common.vessel_identification SET  registration_identifier = 'ESP000100101' WHERE id = 92;
-- For id = 93 (vessel_name: TXORI ZURI), change the value of the column 'registration_identifier' from 'NA' to 'ESP000027691'.
UPDATE ros_common.vessel_identification SET  registration_identifier = 'ESP000027691' WHERE id = 93;
-- For id = 94 (vessel_name: ITSAS TXORI), change the value of the column 'registration_identifier' from 'NA' to 'ESP000027547'.
UPDATE ros_common.vessel_identification SET  registration_identifier = 'ESP000027547' WHERE id = 94;
-- For id = 95 (vessel_name: ALBACAN), change the value of the column 'ircs_identifier' from 'EACO' to '3 BUW'.
-- For id = 95 (vessel_name: ALBACAN), change the value of the column 'registration_identifier' from 'NA' to 'MR 344'.
-- For id = 95 (vessel_name: ALBACAN), change the value of the column 'flag_code' from 'ESP' to 'MUS'.
UPDATE ros_common.vessel_identification SET  ircs_identifier = '3 BUW', registration_identifier = 'MR 344', flag_code = 'MUS' WHERE id = 95;
-- For id = 96 (vessel_name: TXORI GORRI), change the value of the column 'registration_identifier' from 'NA' to 'ESP000027068'.
UPDATE ros_common.vessel_identification SET  registration_identifier = 'ESP000027068' WHERE id = 96;
-- For id = 97 (vessel_name: PLAYA DE RIS), change the value of the column 'registration_identifier' from 'NA' to 'ESP000027578'.
UPDATE ros_common.vessel_identification SET  registration_identifier = 'ESP000027578' WHERE id = 97;
-- For id = 98 (vessel_name: ALBACORA UNO), change the value of the column 'registration_identifier' from 'NA' to 'ESP000023164'.
UPDATE ros_common.vessel_identification SET  registration_identifier = 'ESP000023164' WHERE id = 98;
-- For id = 99 (vessel_name: DONIENE), change the value of the column 'registration_identifier' from 'NA' to 'ESP000023194'.
UPDATE ros_common.vessel_identification SET  registration_identifier = 'ESP000023194' WHERE id = 99;
-- For id = 100 (vessel_name: TORRE GIULIA), change the value of the column 'ircs_identifier' from 'FLSI' to 'IBIO'.
-- For id = 100 (vessel_name: TORRE GIULIA), change the value of the column 'vessel_name' from 'TORRE GIULIA' to 'TORRE ITALIA'.
-- For id = 100 (vessel_name: TORRE GIULIA), change the value of the column 'flag_code' from 'FRA' to 'ITA'.
UPDATE ros_common.vessel_identification SET  ircs_identifier = 'IBIO', vessel_name = 'TORRE ITALIA', flag_code = 'ITA' WHERE id = 100;
-- For id = 101 (vessel_name: MEN CREN), change the value of the column 'registration_identifier' from 'FRA000911287' to '911287'.
UPDATE ros_common.vessel_identification SET  registration_identifier = '911287' WHERE id = 101;
-- For id = 104 (vessel_name: CAP BOJADOR), change the value of the column 'registration_identifier' from 'FRA000752550' to '752550'.
UPDATE ros_common.vessel_identification SET  registration_identifier = '752550' WHERE id = 104;
-- For id = 107 (vessel_name: TAKAMAKA), change the value of the column 'imo_identifier' from 'NA' to '9189691'.
-- For id = 107 (vessel_name: TAKAMAKA), change the value of the column 'iotc_vessel_identifier' from 'IOTC000367' to 'IOTC015488'.
-- For id = 107 (vessel_name: TAKAMAKA), change the value of the column 'ircs_identifier' from 'FUHZ' to 'S7TK'.
-- For id = 107 (vessel_name: TAKAMAKA), change the value of the column 'registration_identifier' from 'FRA000545342' to '50195'.
-- For id = 107 (vessel_name: TAKAMAKA), change the value of the column 'flag_code' from 'FRA' to 'SYC'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '9189691', iotc_vessel_identifier = 'IOTC015488', ircs_identifier = 'S7TK', registration_identifier = '50195', flag_code = 'SYC' WHERE id = 107;
-- For id = 109 (vessel_name: GUERIDEN), change the value of the column 'registration_identifier' from 'FRA000752577' to '752577'.
UPDATE ros_common.vessel_identification SET  registration_identifier = '752577' WHERE id = 109;
-- For id = 111 (vessel_name: VIA AVENIR), change the value of the column 'registration_identifier' from 'FRA000752564' to '752564'.
UPDATE ros_common.vessel_identification SET  registration_identifier = '752564' WHERE id = 111;
-- For id = 112 (vessel_name: STERENN), change the value of the column 'registration_identifier' from 'FRA000911313' to '911313'.
UPDATE ros_common.vessel_identification SET  registration_identifier = '911313' WHERE id = 112;
-- For id = 113 (vessel_name: VIA MISTRAL), change the value of the column 'registration_identifier' from 'FRA000790948' to '790948'.
UPDATE ros_common.vessel_identification SET  registration_identifier = '790948' WHERE id = 113;
-- For id = 114 (vessel_name: GUEOTEC), change the value of the column 'registration_identifier' from 'FRA000752558' to '752558'.
UPDATE ros_common.vessel_identification SET  registration_identifier = '752558' WHERE id = 114;
-- For id = 115 (vessel_name: VIA EUROS), change the value of the column 'registration_identifier' from 'FRA000791294' to '791294'.
UPDATE ros_common.vessel_identification SET  registration_identifier = '791294' WHERE id = 115;
-- For id = 116 (vessel_name: DOLOMIEU), change the value of the column 'registration_identifier' from 'NA' to 'FRA000930604'.
UPDATE ros_common.vessel_identification SET  registration_identifier = 'FRA000930604' WHERE id = 116;
-- For id = 117 (vessel_name: BELOUVE), change the value of the column 'ircs_identifier' from 'FIDQ' to '3BTL'.
-- For id = 117 (vessel_name: BELOUVE), change the value of the column 'registration_identifier' from 'NA' to 'MR 317'.
-- For id = 117 (vessel_name: BELOUVE), change the value of the column 'flag_code' from 'FRA' to 'MUS'.
UPDATE ros_common.vessel_identification SET  ircs_identifier = '3BTL', registration_identifier = 'MR 317', flag_code = 'MUS' WHERE id = 117;
-- For id = 118 (vessel_name: MANAPANY), change the value of the column 'registration_identifier' from 'NA' to 'FRA000929204'.
UPDATE ros_common.vessel_identification SET  registration_identifier = 'FRA000929204' WHERE id = 118;
-- For id = 121 (vessel_name: TREVIGNON), change the value of the column 'registration_identifier' from 'NA' to 'FRA000925754'.
UPDATE ros_common.vessel_identification SET  registration_identifier = 'FRA000925754' WHERE id = 121;
-- For id = 122 (vessel_name: IZARO), change the value of the column 'registration_identifier' from 'NA' to '50221'.
UPDATE ros_common.vessel_identification SET  registration_identifier = '50221' WHERE id = 122;
-- For id = 123 (vessel_name: DEMIKU), change the value of the column 'registration_identifier' from 'NA' to '50087'.
UPDATE ros_common.vessel_identification SET  registration_identifier = '50087' WHERE id = 123;
-- For id = 124 (vessel_name: ARTZA), change the value of the column 'registration_identifier' from 'NA' to '50150'.
UPDATE ros_common.vessel_identification SET  registration_identifier = '50150' WHERE id = 124;
-- For id = 125 (vessel_name: BALBAYA), change the value of the column 'registration_identifier' from 'NA' to 'MR 310'.
-- For id = 125 (vessel_name: BALBAYA), change the value of the column 'flag_code' from 'SYC' to 'MUS'.
UPDATE ros_common.vessel_identification SET  registration_identifier = 'MR 310', flag_code = 'MUS' WHERE id = 125;
-- For id = 126 (vessel_name: TXORI), change the value of the column 'registration_identifier' from 'NA' to '50149'.
UPDATE ros_common.vessel_identification SET  registration_identifier = '50149' WHERE id = 126;
-- For id = 128 (vessel_name: GALERNA III), change the value of the column 'vessel_name' from 'Galerna III' to 'GALERNA III'.
-- For id = 128 (vessel_name: GALERNA III), change the value of the column 'registration_identifier' from '1145' to '50233'.
UPDATE ros_common.vessel_identification SET  vessel_name = 'GALERNA III', registration_identifier = '50233' WHERE id = 128;
-- For id = 129 (vessel_name: MORN SESELWA), change the value of the column 'vessel_name' from 'Morn Seselwa' to 'MORN SESELWA'.
-- For id = 129 (vessel_name: MORN SESELWA), change the value of the column 'registration_identifier' from 'NA' to '50235'.
UPDATE ros_common.vessel_identification SET  vessel_name = 'MORN SESELWA', registration_identifier = '50235' WHERE id = 129;
-- For id = 130 (vessel_name: PLAYA DE ANZORAS), change the value of the column 'registration_identifier' from 'NA' to '50222'.
UPDATE ros_common.vessel_identification SET  registration_identifier = '50222' WHERE id = 130;
-- For id = 131 (vessel_name: DRACO), change the value of the column 'vessel_name' from 'Draco' to 'DRACO'.
-- For id = 131 (vessel_name: DRACO), change the value of the column 'registration_identifier' from 'NA' to '50168'.
UPDATE ros_common.vessel_identification SET  vessel_name = 'DRACO', registration_identifier = '50168' WHERE id = 131;
-- For id = 132 (vessel_name: ALBA UNO), change the value of the column 'ircs_identifier' from 'S7IF' to '3BSY'.
-- For id = 132 (vessel_name: ALBA UNO), change the value of the column 'vessel_name' from 'Alba Uno' to 'BALBAYA'.
-- For id = 132 (vessel_name: ALBA UNO), change the value of the column 'registration_identifier' from 'NA' to 'MR 310'.
-- For id = 132 (vessel_name: ALBA UNO), change the value of the column 'flag_code' from 'SYC' to 'MUS'.
UPDATE ros_common.vessel_identification SET  ircs_identifier = '3BSY', vessel_name = 'BALBAYA', registration_identifier = 'MR 310', flag_code = 'MUS' WHERE id = 132;
-- For id = 133 (vessel_name: GALERNA II), change the value of the column 'vessel_name' from 'Galerna II' to 'GALERNA II'.
-- For id = 133 (vessel_name: GALERNA II), change the value of the column 'registration_identifier' from 'NA' to '50225'.
UPDATE ros_common.vessel_identification SET  vessel_name = 'GALERNA II', registration_identifier = '50225' WHERE id = 133;
-- For id = 134 (vessel_name: TXORI BAT), change the value of the column 'vessel_name' from 'Txori Bat' to 'TXORI BAT'.
-- For id = 134 (vessel_name: TXORI BAT), change the value of the column 'registration_identifier' from 'NA' to '50166'.
UPDATE ros_common.vessel_identification SET  vessel_name = 'TXORI BAT', registration_identifier = '50166' WHERE id = 134;
-- For id = 135 (vessel_name: INTERTUNA TRES), change the value of the column 'registration_identifier' from 'NA' to '50130'.
UPDATE ros_common.vessel_identification SET  registration_identifier = '50130' WHERE id = 135;
-- For id = 136 (vessel_name: TXORI AUNDI), change the value of the column 'vessel_name' from 'Txori Aundi' to 'TXORI AUNDI'.
-- For id = 136 (vessel_name: TXORI AUNDI), change the value of the column 'registration_identifier' from 'NA' to '50140'.
UPDATE ros_common.vessel_identification SET  vessel_name = 'TXORI AUNDI', registration_identifier = '50140' WHERE id = 136;
-- For id = 137 (vessel_name: MORNE BLANC), change the value of the column 'vessel_name' from 'Morne Blanc' to 'PLAYA DE LAIDA'.
-- For id = 137 (vessel_name: MORNE BLANC), change the value of the column 'registration_identifier' from 'NA' to '50243'.
UPDATE ros_common.vessel_identification SET  vessel_name = 'PLAYA DE LAIDA', registration_identifier = '50243' WHERE id = 137;
-- For id = 138 (vessel_name: TXORI TOKI), change the value of the column 'registration_identifier' from 'NA' to '50245'.
UPDATE ros_common.vessel_identification SET  registration_identifier = '50245' WHERE id = 138;
-- For id = 139 (vessel_name: EUSKADI ALAI), change the value of the column 'vessel_name' from 'Euskadi Alai' to 'EUSKADI ALAI'.
-- For id = 139 (vessel_name: EUSKADI ALAI), change the value of the column 'registration_identifier' from 'NA' to '50252'.
UPDATE ros_common.vessel_identification SET  vessel_name = 'EUSKADI ALAI', registration_identifier = '50252' WHERE id = 139;
-- For id = 140 (vessel_name: JAI ALAI), change the value of the column 'vessel_name' from 'Jai Alai' to 'JAI ALAI'.
-- For id = 140 (vessel_name: JAI ALAI), change the value of the column 'registration_identifier' from 'NA' to '50226'.
UPDATE ros_common.vessel_identification SET  vessel_name = 'JAI ALAI', registration_identifier = '50226' WHERE id = 140;
-- For id = 142 (vessel_name: BELLE RIVE), change the value of the column 'registration_identifier' from 'NA' to 'MR 293'.
UPDATE ros_common.vessel_identification SET  registration_identifier = 'MR 293' WHERE id = 142;
-- For id = 143 (vessel_name: BELLE ISLE), change the value of the column 'registration_identifier' from 'NA' to 'MR 294'.
UPDATE ros_common.vessel_identification SET  registration_identifier = 'MR 294' WHERE id = 143;
-- For id = 144 (vessel_name: ERROXAPE), change the value of the column 'registration_identifier' from 'NA' to '1311001-6261100'.
UPDATE ros_common.vessel_identification SET  registration_identifier = '1311001-6261100' WHERE id = 144;
-- For id = 146 (vessel_name: BLUE OCEAN), change the value of the column 'registration_identifier' from 'NA' to '0805002-6261103'.
UPDATE ros_common.vessel_identification SET  registration_identifier = '0805002-6261103' WHERE id = 146;
-- For id = 147 (vessel_name: XIXILI), change the value of the column 'registration_identifier' from 'NA' to '1207001-6261101'.
UPDATE ros_common.vessel_identification SET  registration_identifier = '1207001-6261101' WHERE id = 147;
-- For id = 148 (vessel_name: WASANA 381), change the value of the column 'imo_identifier' from '' to '1740865'.
-- For id = 148 (vessel_name: WASANA 381), change the value of the column 'ircs_identifier' from 'HO 4972' to '4SF5469'.
-- For id = 148 (vessel_name: WASANA 381), change the value of the column 'vessel_name' from 'Wasana 381' to 'WASANA NO 381'.
-- For id = 148 (vessel_name: WASANA 381), change the value of the column 'registration_identifier' from 'IMUL-A-138 CBO' to 'IMULA0138CBO'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '1740865', ircs_identifier = '4SF5469', vessel_name = 'WASANA NO 381', registration_identifier = 'IMULA0138CBO' WHERE id = 148;
-- For id = 149 (vessel_name: WASANA NO 777), change the value of the column 'ircs_identifier' from 'YJRAZ' to '4SF5465'.
-- For id = 149 (vessel_name: WASANA NO 777), change the value of the column 'registration_identifier' from 'IMUL-A-0128 CBO' to 'IMULA0128CBO'.
UPDATE ros_common.vessel_identification SET  ircs_identifier = '4SF5465', registration_identifier = 'IMULA0128CBO' WHERE id = 149;
-- For id = 150 (vessel_name: HIRU - 01), change the value of the column 'imo_identifier' from '' to '8589806'.
-- For id = 150 (vessel_name: HIRU - 01), change the value of the column 'iotc_vessel_identifier' from '' to 'IOTC003946'.
-- For id = 150 (vessel_name: HIRU - 01), change the value of the column 'ircs_identifier' from '4SF4763' to '4SF4783'.
-- For id = 150 (vessel_name: HIRU - 01), change the value of the column 'vessel_name' from 'HIRU - 01' to 'HIRU 01'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '8589806', iotc_vessel_identifier = 'IOTC003946', ircs_identifier = '4SF4783', vessel_name = 'HIRU 01' WHERE id = 150;
-- For id = 152 (vessel_name: HIRU 09), change the value of the column 'imo_identifier' from 'NA' to '8453514'.
-- For id = 152 (vessel_name: HIRU 09), change the value of the column 'iotc_vessel_identifier' from '17273' to 'IOTC017273'.
-- For id = 152 (vessel_name: HIRU 09), change the value of the column 'vessel_name' from 'Hiru 09' to 'HIRU 09'.
-- For id = 152 (vessel_name: HIRU 09), change the value of the column 'registration_identifier' from 'IMUL-A-0144-CBO' to 'IMULA0144CBO'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '8453514', iotc_vessel_identifier = 'IOTC017273', vessel_name = 'HIRU 09', registration_identifier = 'IMULA0144CBO' WHERE id = 152;
-- For id = 153 (vessel_name: WASANA NO 387), change the value of the column 'registration_identifier' from 'IMUL-A-0135CBO' to 'IMULA0135CBO'.
UPDATE ros_common.vessel_identification SET  registration_identifier = 'IMULA0135CBO' WHERE id = 153;
-- For id = 154 (vessel_name: WASANA-328), change the value of the column 'imo_identifier' from 'NA' to '8977613'.
-- For id = 154 (vessel_name: WASANA-328), change the value of the column 'iotc_vessel_identifier' from '0017066' to 'IOTC017066'.
-- For id = 154 (vessel_name: WASANA-328), change the value of the column 'vessel_name' from 'WASANA-328' to 'WASANA 328'.
-- For id = 154 (vessel_name: WASANA-328), change the value of the column 'registration_identifier' from 'IMUL-A-0132CBO' to 'IMULA0132CBO'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '8977613', iotc_vessel_identifier = 'IOTC017066', vessel_name = 'WASANA 328', registration_identifier = 'IMULA0132CBO' WHERE id = 154;
-- For id = 155 (vessel_name: HIRU 2), change the value of the column 'imo_identifier' from '' to '8453502'.
-- For id = 155 (vessel_name: HIRU 2), change the value of the column 'iotc_vessel_identifier' from 'IOTC 962' to 'IOTC000962'.
-- For id = 155 (vessel_name: HIRU 2), change the value of the column 'vessel_name' from 'Hiru 2' to 'HIRU 02'.
-- For id = 155 (vessel_name: HIRU 2), change the value of the column 'registration_identifier' from '115' to 'IMULA0115CBO'.
UPDATE ros_common.vessel_identification SET  imo_identifier = '8453502', iotc_vessel_identifier = 'IOTC000962', vessel_name = 'HIRU 02', registration_identifier = 'IMULA0115CBO' WHERE id = 155;
-- For id = 157 (vessel_name: ALBATUN DOS), change the value of the column 'registration_identifier' from 'NA' to 'ESP000025923'.
UPDATE ros_common.vessel_identification SET  registration_identifier = 'ESP000025923' WHERE id = 157;

-- For id = 26 (vessel_name: MONTVERT), change the value of the column 'ircs_identifier' from 'FQWM' to 'FOWM'.
-- For id = 26 (vessel_name: MONTVERT), change the value of the column 'vessel_name' from 'MONTVERT' to 'AR LETOAD'.
UPDATE ros_common.vessel_identification SET  ircs_identifier = 'FOWM', vessel_name = 'AR LETOAD' WHERE id = 26;

ALTER TABLE ros_common.vessel_identification ADD CONSTRAINT uk_ros_common_vessel_identification_iotc_observer_identifier   UNIQUE (iotc_vessel_identifier);
ALTER TABLE ros_common.vessel_identification ADD CONSTRAINT uk_ros_common_vessel_identification_registration_identifier   UNIQUE (registration_identifier);
ALTER TABLE ros_common.vessel_identification ADD CONSTRAINT uk_ros_common_vessel_identification_ircs_identifier   UNIQUE (ircs_identifier);
ALTER TABLE ros_common.vessel_identification ADD CONSTRAINT uk_ros_common_vessel_identification_imo_identifier   UNIQUE (imo_identifier);
ALTER TABLE ros_common.vessel_identification ALTER COLUMN iotc_vessel_identifier SET NOT NULL;
ALTER TABLE ros_common.vessel_identification ALTER COLUMN main_fishing_gear_code SET NOT NULL;
select setval('ros_common.vessel_identification_id_seq', (select max(id) from ros_common.vessel_identification));

-- For LL-EUR-FR 2022
INSERT INTO ros_common.vessel_identification (imo_identifier, iotc_vessel_identifier, ircs_identifier, vessel_name, registration_identifier, main_fishing_gear_code, flag_code) VALUES('9184366', 'IOTC000374', 'FOCU', 'CAP CLOE', 'FRA000918277', 'DL', 'FRA');
INSERT INTO ros_common.vessel_identification (imo_identifier, iotc_vessel_identifier, ircs_identifier, vessel_name, registration_identifier, main_fishing_gear_code, flag_code) VALUES('8589454', 'IOTC003577', 'FOSW', 'CAP SUD',  'FRA000899736', 'DL', 'FRA');
-- For LL-EUR-FR 2023
INSERT INTO ros_common.vessel_identification (imo_identifier, iotc_vessel_identifier, ircs_identifier, vessel_name, registration_identifier,main_fishing_gear_code, flag_code) VALUES( NULL, 'IOTC001140', 'FGA4525', 'CHARLES 5', '899774', 'DL', 'FRA');


