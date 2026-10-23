@echo off
setlocal

:: Wechsle in den Ordner des Skripts, damit docker compose die docker-compose.yml findet
cd /d "%~dp0"

:: Gehe durch alle .sql Dateien im Ordner SQL_Dumps
for %%F in (SQL_Dumps\*.sql) do (
    echo Verarbeite Datei: %%F
    docker compose exec -T maria mariadb -u root --password=schueler mysql < "%%F"
)

echo Fertig.
endlocal