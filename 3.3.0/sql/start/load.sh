#!/bin/bash

directory=$1
db=$2
fine_directory="$directory"/fine
mkdir "$fine_directory"
PGOPTIONS='--client-min-messages=warning'
for file in $(ls ${directory}/*.sql | sort); do
  echo "Run file $file"
  error_file="$file".error
  log_file="$file".log
  psql --single-transaction --echo-errors --set=ON_ERROR_STOP=on -U ros-admin "$db" -f "$file" > "$log_file" 2> "$error_file"
  if [ -s "$error_file" ] ; then
    echo "Some errors found while loading file $file" ; cat "$error_file"
  else
    echo "No errors found while loading file $file" ; rm -rf "$error_file" ; mv "$file" "$fine_directory" ; mv "$file".log "$fine_directory"
  fi
done