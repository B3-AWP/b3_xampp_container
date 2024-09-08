#!/bin/bash

# Extrahiere den Namen des aktuellen Verzeichnisses und konvertiere ihn in Kleinbuchstaben
LOWER_CONTAINERNAME=$(basename "$PWD" | tr '[:upper:]' '[:lower:]')

echo "Der konvertierte Containername in Kleinbuchstaben ist: $LOWER_CONTAINERNAME"

# Gehe durch alle .sql-Dateien im Ordner SQL_Dumps
for file in SQL_Dumps/*.sql; do
    if [[ -f "$file" ]]; then
        echo "Verarbeite Datei: $file"
        # Führe den Docker-Befehl aus, ersetze <<CONTAINERNAME>> durch den tatsächlichen Namen in Kleinbuchstaben
        docker exec -i "${LOWER_CONTAINERNAME}-maria-1" mariadb -u root --password=schueler < "$file"
    fi
done

echo "Fertig."
