@echo off
setlocal

:: Extrahiere den Namen des aktuellen Verzeichnisses und konvertiere ihn in Kleinbuchstaben mit PowerShell
for /f "delims=" %%I in ('powershell -Command "Write-Output \'%CD%\' | Split-Path -Leaf | ForEach-Object { $_.ToLower() }"') do set "LOWER_CONTAINERNAME=%%I"

echo Der konvertierte Containername in Kleinbuchstaben ist: %LOWER_CONTAINERNAME%

:: Gehe durch alle .sql Dateien im Ordner SQL_Dumps
for %%F in (SQL_Dumps\*.sql) do (
    echo Verarbeite Datei: %%F
    :: Führe den Docker-Befehl aus, ersetze <<CONTAINERNAME>> durch den tatsächlichen Namen in Kleinbuchstaben
    cmd.exe /c "docker exec -it %LOWER_CONTAINERNAME%-maria-1 mariadb -u root --password=schueler"
)

echo Fertig.
endlocal
