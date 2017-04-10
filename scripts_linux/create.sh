#!/bin/sh

TMP_FILE=$(mktemp)
SQL="$(find 0-database 1-contact 2-facturation 3-stock -type f -name '*.sql')"

echo "Into file : $TMP_FILE"
cat $SQL > "$TMP_FILE"
./generator/main.rb >> "$TMP_FILE"

mysql -u root -h autoconcept.jeser.me -p < "$TMP_FILE"
