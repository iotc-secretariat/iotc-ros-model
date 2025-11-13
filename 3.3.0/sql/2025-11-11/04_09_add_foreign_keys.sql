-- add 8 foreign key(s) from ros_common.contact→id
-- add the foreign key gnbserverdatacreatorid for ros_gn.observer_data→creator_id
ALTER TABLE ros_gn.observer_data ADD CONSTRAINT gnbserverdatacreatorid FOREIGN KEY (creator_id) REFERENCES ros_common.contact(id);
-- add the foreign key gnbserverdatasbmtterid for ros_gn.observer_data→submitter_id
ALTER TABLE ros_gn.observer_data ADD CONSTRAINT gnbserverdatasbmtterid FOREIGN KEY (submitter_id) REFERENCES ros_common.contact(id);
-- add the foreign key llbserverdatacreatorid for ros_ll.observer_data→creator_id
ALTER TABLE ros_ll.observer_data ADD CONSTRAINT llbserverdatacreatorid FOREIGN KEY (creator_id) REFERENCES ros_common.contact(id);
-- add the foreign key llbserverdatasbmtterid for ros_ll.observer_data→submitter_id
ALTER TABLE ros_ll.observer_data ADD CONSTRAINT llbserverdatasbmtterid FOREIGN KEY (submitter_id) REFERENCES ros_common.contact(id);
-- add the foreign key plbserverdatacreatorid for ros_pl.observer_data→creator_id
ALTER TABLE ros_pl.observer_data ADD CONSTRAINT plbserverdatacreatorid FOREIGN KEY (creator_id) REFERENCES ros_common.contact(id);
-- add the foreign key plbserverdatasbmtterid for ros_pl.observer_data→submitter_id
ALTER TABLE ros_pl.observer_data ADD CONSTRAINT plbserverdatasbmtterid FOREIGN KEY (submitter_id) REFERENCES ros_common.contact(id);
-- add the foreign key psbserverdatacreatorid for ros_ps.observer_data→creator_id
ALTER TABLE ros_ps.observer_data ADD CONSTRAINT psbserverdatacreatorid FOREIGN KEY (creator_id) REFERENCES ros_common.contact(id);
-- add the foreign key psbserverdatasbmtterid for ros_ps.observer_data→submitter_id
ALTER TABLE ros_ps.observer_data ADD CONSTRAINT psbserverdatasbmtterid FOREIGN KEY (submitter_id) REFERENCES ros_common.contact(id);
-- add 2 foreign key(s) from ros_common.contact→id
-- add the foreign key vsslwnrndprsfshngmstrd for ros_common.vessel_owner_and_personnel→fishing_master_id
ALTER TABLE ros_common.vessel_owner_and_personnel ADD CONSTRAINT vsslwnrndprsfshngmstrd FOREIGN KEY (fishing_master_id) REFERENCES ros_common.contact(id);
-- add the foreign key vsslwnrndprsnnelskpprd for ros_common.vessel_owner_and_personnel→skipper_id
ALTER TABLE ros_common.vessel_owner_and_personnel ADD CONSTRAINT vsslwnrndprsnnelskpprd FOREIGN KEY (skipper_id) REFERENCES ros_common.contact(id);
-- add 4 foreign key(s) from ros_common.contact→id
-- add the foreign key gntagdetailstgfinderid for ros_gn.tag_details→tag_finder_id
ALTER TABLE ros_gn.tag_details ADD CONSTRAINT gntagdetailstgfinderid FOREIGN KEY (tag_finder_id) REFERENCES ros_common.contact(id);
-- add the foreign key lltagdetailstgfinderid for ros_ll.tag_details→tag_finder_id
ALTER TABLE ros_ll.tag_details ADD CONSTRAINT lltagdetailstgfinderid FOREIGN KEY (tag_finder_id) REFERENCES ros_common.contact(id);
-- add the foreign key pltagdetailstgfinderid for ros_pl.tag_details→tag_finder_id
ALTER TABLE ros_pl.tag_details ADD CONSTRAINT pltagdetailstgfinderid FOREIGN KEY (tag_finder_id) REFERENCES ros_common.contact(id);
-- add the foreign key pstagdetailstgfinderid for ros_ps.tag_details→tag_finder_id
ALTER TABLE ros_ps.tag_details ADD CONSTRAINT pstagdetailstgfinderid FOREIGN KEY (tag_finder_id) REFERENCES ros_common.contact(id);
-- add 1 foreign key(s) from ros_common.observer→contact_id
-- add the foreign key gnrlvsslnbsrvrdntfctnd for ros_common.general_vessel_and_trip_information→observer_identification_id
ALTER TABLE ros_common.general_vessel_and_trip_information ADD CONSTRAINT gnrlvsslnbsrvrdntfctnd FOREIGN KEY (observer_identification_id) REFERENCES ros_common.observer(contact_id);

