@echo off
setlocal

:: Wechsle in den Ordner des Skripts, damit docker compose die docker-compose.yml findet
cd /d "%~dp0"

:: Öffne die MariaDB-Shell im Container
docker compose exec maria mariadb -u root --password=schueler


echo Fertig.
endlocal
