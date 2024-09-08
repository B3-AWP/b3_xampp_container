#!/bin/bash

# Extrahiere den Namen des aktuellen Verzeichnisses und konvertiere ihn in Kleinbuchstaben
LOWER_CONTAINERNAME=$(basename "$PWD" | tr '[:upper:]' '[:lower:]')

echo "Der konvertierte Containername in Kleinbuchstaben ist: $LOWER_CONTAINERNAME"

# Erstelle eine Liste aller .sql-Dateien im Ordner SQL_Dumps und zeige sie mit führenden Zahlen an
count=0
declare -A files

echo "Liste der .sql-Dateien im Verzeichnis SQL_Dumps:"
for file in SQL_Dumps/*.sql; do
    if [[ -f "$file" ]]; then
        ((count++))
        files[$count]="$file"
        echo "$count - $file"
    fi
done

# Frage den Benutzer, welche Dateien importiert werden sollen (durch Komma getrennt, 0 für alle)
echo
echo "Geben Sie die Nummern der zu importierenden Dateien ein, getrennt durch Komma (0 für alle):"
read -r choices

# Führe die Auswahl des Benutzers aus
if [[ "$choices" == "0" ]]; then
    for i in $(seq 1 $count); do
        file=${files[$i]}
        echo "Verarbeite Datei: $file"
        docker exec -i "${LOWER_CONTAINERNAME}-maria-1" mariadb -u root --password=schueler mysql < "$file"
    done
else
    IFS=',' read -r -a nums <<< "$choices"
    for num in "${nums[@]}"; do
        file=${files[$num]}
        if [[ -n "$file" ]]; then
            echo "Verarbeite Datei: $file"
            docker exec -i "${LOWER_CONTAINERNAME}-maria-1" mariadb -u root --password=schueler mysql < "$file"
        else
            echo "Ungültige Auswahl: $num"
        fi
    done
fi

echo "Fertig."
