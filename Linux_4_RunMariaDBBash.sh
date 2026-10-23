#!/bin/bash

# Wechsle in den Ordner des Skripts, damit docker compose die docker-compose.yml findet
cd "$(dirname "$0")" || exit 1

# Öffne die MariaDB-Shell im Container
docker compose exec maria mariadb -u root --password=schueler

echo "Fertig."
