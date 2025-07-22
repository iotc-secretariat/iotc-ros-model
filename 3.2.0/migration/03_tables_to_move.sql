-- ros_common.gn_observer_data_properties → ros_gn.observer_data_properties
create table ros_gn.observer_data_properties
(
    observer_data_id integer not null constraint gnbsrvrdtprprtbsrvrdtd references ros_gn.observer_data,
    property_id      integer not null constraint gnbsrvrdtprprtsprprtyd references ros_common.properties,
    primary key (observer_data_id, property_id)
);
create index index_gn_observer_data_properties_observer_data_id on ros_gn.observer_data_properties (observer_data_id);
create index index_gn_observer_data_properties_property_id on ros_gn.observer_data_properties (property_id);
drop table if exists ros_common.gn_observer_data_properties;
-- ros_common.gn_observer_data_transhipment_details → ros_gn.observer_data_transhipment_details
create table ros_gn.observer_data_transhipment_details
(
    observer_data_id       integer not null constraint gnbsrvrdttrnshbsrvrdtd references ros_gn.observer_data,
    transhipment_detail_id integer not null constraint gnbsrvrdttrnshpmntdtld references ros_common.transhipment_details,
    primary key (observer_data_id, transhipment_detail_id)
);
create index index_gn_observer_data_transhipment_details_observer_data_id on ros_gn.observer_data_transhipment_details (observer_data_id);
create index index_gn_odt_details_transhipment_detail_id on ros_gn.observer_data_transhipment_details (transhipment_detail_id);
drop table if exists ros_common.gn_observer_data_transhipment_details;
-- ros_common.ll_observer_data_properties → ros_ll.observer_data_properties
create table ros_ll.observer_data_properties
(
    observer_data_id integer not null constraint llbsrvrdtprprtbsrvrdtd references ros_ll.observer_data,
    property_id      integer not null constraint llbsrvrdtprprtsprprtyd references ros_common.properties,
    primary key (observer_data_id, property_id)
);
create index index_ll_observer_data_properties_observer_data_id on ros_ll.observer_data_properties (observer_data_id);
create index index_ll_observer_data_properties_property_id on ros_ll.observer_data_properties (property_id);
drop table if exists ros_common.ll_observer_data_properties;
-- ros_common.ll_observer_data_transhipment_details → ros_ll.observer_data_transhipment_details
create table ros_ll.observer_data_transhipment_details
(
    observer_data_id       integer not null constraint llbsrvrdttrnshbsrvrdtd references ros_ll.observer_data,
    transhipment_detail_id integer not null constraint llbsrvrdttrnshpmntdtld references ros_common.transhipment_details,
    primary key (observer_data_id, transhipment_detail_id)
);
create index index_ll_observer_data_transhipment_details_observer_data_id on ros_ll.observer_data_transhipment_details (observer_data_id);
create index index_ll_odt_details_transhipment_detail_id on ros_ll.observer_data_transhipment_details (transhipment_detail_id);
drop table if exists ros_common.ll_observer_data_transhipment_details;
-- ros_common.pl_observer_data_daily_activities → ros_pl.observer_data_daily_activities
create table if not exists ros_pl.observer_data_daily_activities
(
    observer_data_id  integer not null constraint plbsrvrdtdlyctbsrvrdtd references ros_pl.observer_data,
    daily_activity_id integer not null constraint plbsrvrdtdlycdlyctvtyd references ros_common.daily_activities,
    primary key (observer_data_id, daily_activity_id)
);
create index index_pl_observer_data_daily_activities_observer_data_id on ros_pl.observer_data_daily_activities (observer_data_id);
create index index_pl_observer_data_daily_activities_daily_activity_id on ros_pl.observer_data_daily_activities (daily_activity_id);
drop table if exists ros_common.pl_observer_data_daily_activities;
-- ros_common.pl_observer_data_properties → ros_pl.observer_data_properties
create table if not exists ros_pl.observer_data_properties
(
    observer_data_id integer not null constraint gnbsrvrdtprprtbsrvrdtd references ros_gn.observer_data,
    property_id      integer not null constraint gnbsrvrdtprprtsprprtyd references ros_common.properties,
    primary key (observer_data_id, property_id)
);
create index index_pl_observer_data_properties_observer_data_id on ros_pl.observer_data_properties (observer_data_id);
create index index_pl_observer_data_properties_property_id on ros_pl.observer_data_properties (property_id);
drop table if exists ros_common.pl_observer_data_properties;
-- ros_common.pl_observer_data_transhipment_details → ros_pl.observer_data_transhipment_details
create table ros_pl.observer_data_transhipment_details
(
    observer_data_id       integer not null constraint plbsrvrdttrnshbsrvrdtd references ros_pl.observer_data,
    transhipment_detail_id integer not null constraint plbsrvrdttrnshpmntdtld references ros_common.transhipment_details,
    primary key (observer_data_id, transhipment_detail_id)
);
create index index_pl_observer_data_transhipment_details_observer_data_id on ros_pl.observer_data_transhipment_details (observer_data_id);
create index index_pl_observer_data_transhipment_pl_transhipment_detail_id on ros_pl.observer_data_transhipment_details (transhipment_detail_id);
drop table if exists ros_common.pl_observer_data_transhipment_details;
-- ros_common.ps_observer_data_daily_activities → ros_ps.observer_data_daily_activities
create table ros_ps.observer_data_daily_activities
(
    observer_data_id  integer not null constraint psbsrvrdtdlyctbsrvrdtd references ros_ps.observer_data,
    daily_activity_id integer not null constraint psbsrvrdtdlycdlyctvtyd references ros_common.daily_activities,
    primary key (observer_data_id, daily_activity_id)
);
create index index_ps_observer_data_daily_activities_observer_data_id on ros_ps.observer_data_daily_activities (observer_data_id);
create index index_ps_observer_data_daily_activities_daily_activity_id on ros_ps.observer_data_daily_activities (daily_activity_id);
drop table if exists ros_common.ps_observer_data_daily_activities;
-- ros_common.ps_observer_data_properties → ros_ps.observer_data_properties
create table ros_ps.observer_data_properties
(
    observer_data_id integer not null constraint psbsrvrdtprprtbsrvrdtd references ros_ps.observer_data,
    property_id integer not null constraint psbsrvrdtprprtsprprtyd references ros_common.properties,
    primary key (observer_data_id, property_id)
);
create index index_ps_observer_data_properties_observer_data_id on ros_ps.observer_data_properties (observer_data_id);
create index index_ps_observer_data_properties_property_id on ros_ps.observer_data_properties (property_id);
drop table if exists ros_common.ps_observer_data_properties;
-- ros_common.ps_observer_data_transhipment_details → ros_ps.observer_data_transhipment_details
create table ros_ps.observer_data_transhipment_details
(
    observer_data_id integer not null constraint psbsrvrdttrnshbsrvrdtd references ros_ps.observer_data,
    transhipment_detail_id integer not null constraint psbsrvrdttrnshpmntdtld references ros_common.transhipment_details,
    primary key (observer_data_id, transhipment_detail_id)
);
create index index_ps_observer_data_transhipment_details_observer_data_id on ros_ps.observer_data_transhipment_details (observer_data_id);
create index index_ps_observer_data_transhipment_ps_transhipment_detail_id on ros_ps.observer_data_transhipment_details (transhipment_detail_id);
drop table if exists ros_common.ps_observer_data_transhipment_details;
