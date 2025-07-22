# Abstract

This directory contains the version **3.2.0** of the _Ros_ database.

The directory [ddl](ddl) contains the _DDL_ of the _Postgres_ database associated.


# Content of the version

This version was produced in July 2025 with the following improvements:

* [x] Remove the redundant prefix on the table which is already named in the schema name (See [file](./tables_to_rename.csv)).
* [x] Remove the redundant prefix on columns which are already named in the schema name (See [file](./columns_to_rename.csv)).
* [x] Move some tables from ```ros_common``` to their dedicated specific schema (See [file](./tables_to_move.csv)).
* [x] Remove in views SPECIES.SPECIES_OFFICIAL column (See [file](./remove_species_official.csv)).
* [ ] Review the following measurement tables to avoir duplicated measurement: 
  * [ ] ```capacities```
  * [ ] ```depths```
  * [ ] ```diameters```
  * [ ] ```heights```
  * [ ] ```lengths```
  * [ ] ```ranges```
  * [ ] ```sizes```
  * [ ] ```texts```
  * [ ] ```thicknesses```
  * [ ] ```tonnages```
