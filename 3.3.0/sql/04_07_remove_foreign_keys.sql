-- remove 8 foreign key(s) from ros_common.iotc_person_contact_details→id
-- remove the foreign key for ros_gn.observer_data→creator_id
ALTER TABLE ros_gn.observer_data DROP CONSTRAINT gnbserverdatacreatorid;
-- remove the foreign key for ros_gn.observer_data→submitter_id
ALTER TABLE ros_gn.observer_data DROP CONSTRAINT gnbserverdatasbmtterid;
-- remove the foreign key for ros_ll.observer_data→creator_id
ALTER TABLE ros_ll.observer_data DROP CONSTRAINT llbserverdatacreatorid;
-- remove the foreign key for ros_ll.observer_data→submitter_id
ALTER TABLE ros_ll.observer_data DROP CONSTRAINT llbserverdatasbmtterid;
-- remove the foreign key for ros_pl.observer_data→creator_id
ALTER TABLE ros_pl.observer_data DROP CONSTRAINT plbserverdatacreatorid;
-- remove the foreign key for ros_pl.observer_data→submitter_id
ALTER TABLE ros_pl.observer_data DROP CONSTRAINT plbserverdatasbmtterid;
-- remove the foreign key for ros_ps.observer_data→creator_id
ALTER TABLE ros_ps.observer_data DROP CONSTRAINT psbserverdatacreatorid;
-- remove the foreign key for ros_ps.observer_data→submitter_id
ALTER TABLE ros_ps.observer_data DROP CONSTRAINT psbserverdatasbmtterid;
-- remove 1 foreign key(s) from ros_common.observer_identification→id
-- remove the foreign key for ros_common.general_vessel_and_trip_information→observer_identification_id
ALTER TABLE ros_common.general_vessel_and_trip_information DROP CONSTRAINT gnrlvsslnbsrvrdntfctnd;
-- remove 2 foreign key(s) from ros_common.person_details→id
-- remove the foreign key for ros_common.vessel_owner_and_personnel→fishing_master_id
ALTER TABLE ros_common.vessel_owner_and_personnel DROP CONSTRAINT vsslwnrndprsfshngmstrd;
-- remove the foreign key for ros_common.vessel_owner_and_personnel→skipper_id
ALTER TABLE ros_common.vessel_owner_and_personnel DROP CONSTRAINT vsslwnrndprsnnelskpprd;
-- remove 4 foreign key(s) from ros_common.person_contact_details→id
-- remove the foreign key for ros_gn.tag_details→tag_finder_id
ALTER TABLE ros_gn.tag_details DROP CONSTRAINT gntagdetailstgfinderid;
-- remove the foreign key for ros_ll.tag_details→tag_finder_id
ALTER TABLE ros_ll.tag_details DROP CONSTRAINT lltagdetailstgfinderid;
-- remove the foreign key for ros_pl.tag_details→tag_finder_id
ALTER TABLE ros_pl.tag_details DROP CONSTRAINT pltagdetailstgfinderid;
-- remove the foreign key for ros_ps.tag_details→tag_finder_id
ALTER TABLE ros_ps.tag_details DROP CONSTRAINT pstagdetailstgfinderid;
