#!/bin/bash

# Wechsle in den Ordner des Skripts, damit docker compose die docker-compose.yml findet
cd "$(dirname "$0")" || exit 1

# Gehe durch alle .sql-Dateien im Ordner SQL_Dumps
for file in SQL_Dumps/*.sql; do
    if [[ -f "$file" ]]; then
        echo "Verarbeite Datei: $file"
        docker compose exec -T maria mariadb -u root --password=schueler mysql < "$file"
    fi
done

echo "Fertig."
