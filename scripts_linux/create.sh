#!/bin/sh

cat $(find 1-contact -type f -name "*.sql") | mysql -u root -h autoconcept.jeser.me -p autoconcept
