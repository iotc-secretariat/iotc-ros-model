# Abstract

This document summarizes all modification specific to the meta domain (says the ```ros_meta``` schema) of the _Ros_ database coming from version 3.2.0 to 3.3.0.

The directory [sql](sql) contains all _SQL_ scripts to perform the migration.

## Actions to perform on the database to go to version 3.3.0

* [x] Change the type of column ```ros_meta.focal_points→active``` to boolean (default value true)
* [x] Change the type of column ```ros_meta.observers→active``` to boolean (default value false)
* [x] Change the type of column ```ros_meta.observers→basic_training``` to boolean (default value false)
* [x] Change the type of column ```ros_meta.observers→medical_certificate``` to boolean (default value false)
