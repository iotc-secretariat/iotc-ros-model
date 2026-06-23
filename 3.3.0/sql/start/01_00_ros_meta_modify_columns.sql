-- Change the type of column ```ros_meta.focal_points→active``` to boolean (default value true)
ALTER TABLE ros_meta.focal_points ADD COLUMN active2 BOOLEAN DEFAULT TRUE;
UPDATE ros_meta.focal_points SET active2 = case when active = 0 then FALSE when active = 1 then TRUE end;
ALTER TABLE ros_meta.focal_points DROP COLUMN active;
ALTER TABLE ros_meta.focal_points RENAME active2 TO active;
-- Change the type of column ```ros_meta.observers→active``` to boolean (default value false)
-- need to rewrite view ros_analysis.v_observers_summary
DROP VIEW ros_analysis.v_observers_summary;
-- need to rewrite view ros_analysis.v_observers
DROP VIEW ros_analysis.v_observers;
ALTER TABLE ros_meta.observers ADD COLUMN active2 BOOLEAN DEFAULT FALSE NOT NULL;
UPDATE ros_meta.observers SET active2 = case when active = 0 then FALSE when active = 1 then TRUE end;
ALTER TABLE ros_meta.observers DROP COLUMN active;
ALTER TABLE ros_meta.observers RENAME active2 TO active;
create view ros_analysis.v_observers(iotc_number, flag_code, last_name, first_name, nationality_code, active) as
    WITH obs AS (SELECT ob.iotc_number,
                        f.code AS flag_code,
                        ob.last_name,
                        ob.first_name,
                        n.code AS nationality_code,
                        ob.active
                 FROM ros_meta.observers ob
                          JOIN ros_meta.observers_2_flags o2f ON ob.iotc_number = o2f.iotc_number
                          JOIN refs_admin.countries f ON o2f.flag_code = f.code
                          JOIN refs_admin.countries n ON ob.nationality_code = n.code)
    SELECT DISTINCT iotc_number,
                    CASE
                        WHEN iotc_number ~~ '%EUR%'::text THEN 'EUR'::bpchar
                        ELSE flag_code
                        END AS flag_code,
                    last_name,
                    first_name,
                    nationality_code,
                    active
    FROM obs
    WHERE iotc_number !~~ '%DUM%'::text
      AND last_name::text !~~ '%DUMMY%'::text
      AND last_name::text !~~ '%KEN ROS%'::text;
create view ros_analysis.v_observers_summary(flag_code, num_active, num_inactive) as
    SELECT CASE
               WHEN iotc_number ~~ '%EUR%'::text THEN 'EUR'::bpchar
               ELSE flag_code
               END          AS flag_code,
           sum(
                   CASE
                       WHEN active = TRUE THEN 1
                       ELSE 0
                       END) AS num_active,
           sum(
                   CASE
                       WHEN active = FALSE THEN 1
                       ELSE 0
                       END) AS num_inactive
    FROM ros_analysis.v_observers v
    GROUP BY (
                 CASE
                     WHEN iotc_number ~~ '%EUR%'::text THEN 'EUR'::bpchar
                     ELSE flag_code
                     END);
-- Change the type of column ```ros_meta.observers→basic_training``` to boolean (default value false)
ALTER TABLE ros_meta.observers ADD COLUMN basic_training2 BOOLEAN DEFAULT FALSE;
UPDATE ros_meta.observers SET basic_training2 = case when basic_training = 0 then FALSE when basic_training = 1 then TRUE end;
ALTER TABLE ros_meta.observers DROP COLUMN basic_training;
ALTER TABLE ros_meta.observers RENAME basic_training2 TO basic_training;
-- Change the type of column ```ros_meta.observers→medical_certificate``` to boolean (default value false)
ALTER TABLE ros_meta.observers ADD COLUMN medical_certificate2 BOOLEAN DEFAULT FALSE;
UPDATE ros_meta.observers SET medical_certificate2 = case when medical_certificate = 0 then FALSE when medical_certificate = 1 then TRUE end;
ALTER TABLE ros_meta.observers DROP COLUMN medical_certificate;
ALTER TABLE ros_meta.observers RENAME medical_certificate2 TO medical_certificate;