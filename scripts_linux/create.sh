#!/bin/sh

cat $(find 0-database 1-contact 2-facturation -type f -name "*.sql") | mysql -u root -h autoconcept.jeser.me -p;
