#! /bin/sh

DB_NAME=$1
PG_USER=$2
DIRECTORY=$3

cd "$DIRECTORY/migration"
SCRIPTS="./yo"
SCRIPT=update-$DIRECTORY.psql
rm -rf "$SCRIPTS"
rm -rf "$SCRIPT"
find -name "*.sql" -printf "%h/%f\\n" | sort >> "$SCRIPTS"

while read -r line; do
echo "-- Script $line" >> "$SCRIPT"
cat $line >> "$SCRIPT"
echo "" >> "$SCRIPT"
done < "$SCRIPTS"
rm -rf "$SCRIPTS"
echo "Update db $DB_NAME ($(wc -l $SCRIPT | cut -d' ' -f1) statement(s))"
echo "Update started at $(date)"
PGOPTIONS='--client-min-messages=warning' psql --single-transaction --quiet --echo-errors --username="$PG_USER" --dbname="$DB_NAME" --set=ON_ERROR_STOP=on --file="$SCRIPT"

echo "Update ended at $(date)"
#rm -rf "$SCRIPT"

#PGOPTIONS='--client-min-messages=warning' psql --single-transaction --quiet --echo-errors --username="ros-admin" --dbname="IOTC_ReferenceData_2026_06_18" --set=ON_ERROR_STOP=on --file="/tmp/ChangeLog-2026-06-25.sql"