# Abstract

This directory contains the version **3.1.2** of the _Ros_ database.

The directory [ddl](ddl) contains the _DDL_ of the _Postgres_ database associated.

# Content of the version

This version was produced in July 2025 with the following improvements:

* Replace old-style code-lists (from the _Ros_ database), and use now the code-lists from _IOTC_ReferenceData_
  * schema ```ros_references``` was deleted
  * schema ```refs_admin``` was added
  * schema ```refs_biological``` was added
  * schema ```refs_biological_config``` was added
  * schema ```refs_data``` was added
  * schema ```refs_fishery``` was added
  * schema ```refs_fishery_config``` was added
  * schema ```refs_gis``` was added
  * schema ```refs_legacy``` was added
  * schema ```refs_socio_economics``` was added
* In _Ros_ tables, all references to code-lists are now based on the ```code``` of the code-list (any ```xxx_id``` was replaced by ```xxx_code```)

