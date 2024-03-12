# AWP11_XAMPP_Container
Use Docker instead of XAMPP 

## Anleitung
- Docker Software installieren https://www.docker.com/
- Eingabeaufforderung auswählen (!NIcht Powershell)
- zum Docker Pfad navigieren cd c:/...
- Befehl eingeben: docker-compose build
- Befehl eingeben: docker-compose up -d

## Probleme lösen eines Containers via
- docker-compose stop
- docker-compose rm 
- docker-compose up --build -d

## Einbinden von SQL Dumps
1. sql-Dumps in den Ordner ./SQL_Dumps kopieren
2. Zum Docker Pfad navigieren
3. Befehl eingeben:
    docker exec -i temp-maria-1 mysql -u root --password=schueler mysql < ./SQL_Dumps/rfidV5Klein.sql
