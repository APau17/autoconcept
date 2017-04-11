@echo off

cd C:\Users\kelian\Documents\GitHub\autoconcept
copy ".\0-database\database.sql" /b + ".\1-contact\creation\table.sql" /b + ".\2-facturation\creation\table.sql" /b + ".\3-stock\creation\1-unite.sql" /b + ".\3-stock\creation\2-table.sql" /b + ".\3-stock\creation\3-categorie.sql" ".\scripts_windows\global.sql" /b   
mysql -h autoconcept.jeser.me --user=kells -p < "C:\Users\kelian\documents\github\autoconcept\scripts_windows\global.sql"
pause