@echo off
setlocal enabledelayedexpansion

:: Extrahiere den Namen des aktuellen Verzeichnisses und konvertiere ihn in Kleinbuchstaben mit PowerShell
for /f "delims=" %%I in ('powershell -Command "Write-Output \'%CD%\' | Split-Path -Leaf | ForEach-Object { $_.ToLower() }"') do set "LOWER_CONTAINERNAME=%%I"

echo Der konvertierte Containername in Kleinbuchstaben ist: %LOWER_CONTAINERNAME%

:: Erstelle eine Liste aller .sql Dateien im Ordner SQL_Dumps und zeige sie mit führenden Zahlen an
set /a count=0
for %%F in (SQL_Dumps\*.sql) do (
    set /a count+=1
    set "file!count!=%%F"
    echo !count! - %%F
)

:: Frage den Benutzer, welche Dateien importiert werden sollen (durch Komma getrennt, 0 für alle)
echo.
echo Geben Sie die Nummern der zu importierenden Dateien ein, getrennt durch Komma (0 für alle):
set /p choices="Auswahl: "

:: Führe die Auswahl des Benutzers aus
if "!choices!"=="0" (
    for /l %%i in (1,1,!count!) do (
        set "file=!file%%i!"
        echo Verarbeite Datei: !file!
        cmd.exe /c "docker exec -i %LOWER_CONTAINERNAME%-maria-1 mariadb -u root --password=schueler mysql < !file!"
    )
) else (
    for %%a in (!choices!) do (
        set /a num=%%a
        set "file=!file%%a!"
        if defined file%%a (
            echo Verarbeite Datei: !file%%a!
            cmd.exe /c "docker exec -i %LOWER_CONTAINERNAME%-maria-1 mariadb -u root --password=schueler mysql < !file%%a!"
        ) else (
            echo Ungültige Auswahl: %%a
        )
        set "file="
    )
)

echo Fertig.
pause
endlocal
