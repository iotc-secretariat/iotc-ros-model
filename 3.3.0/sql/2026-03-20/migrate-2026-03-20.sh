#! /bin/sh

DB_NAME=$1
PG_USER=$2

SCRIPTS="./yo"
SCRIPT=update-2026-03-20.psql
rm -rf "$SCRIPTS"
rm -rf "$SCRIPT"
find -name "08_*.sql" -printf "%h/%f\\n" | sort >> "$SCRIPTS"

#cat "$SCRIPTS"
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