create or replace view ros_common.contact_with_observer(id, full_name, iotc_observer_identifier, nationality_code, active, email, phone) as
    SELECT t.id,
           t.full_name,
           o.iotc_observer_identifier,
           t.nationality_code,
           FALSE,
           t.email,
           t.phone
    FROM ros_common.observer o
    JOIN ros_common.contact t ON t.id = o.contact_id
    ORDER BY t.full_name;

