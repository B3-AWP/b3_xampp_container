# AWP11_XAMPP_Container
Use Docker instead of XAMPP 

## Anleitung
- Docker Software installieren https://www.docker.com/
- Eingabeaufforderung auswählen (!NIcht Powershell)
- zum Docker Pfad navigieren cd c:/...
- Befehl eingeben: docker-compose build
- Befehl eingeben: docker-compose up -d

## Probleme lösen eines Containers via
```
docker-compose stop
docker-compose rm 
docker-compose up --build -d
docker container ls
```

## Shell öffnen
```
docker exec -it <CONTAINERNAME>-maria-1 mariadb -u root --password=schueler 
```

Zum Beispiel:  <br>
```
docker exec -it b3_xampp_container-maria-1 mariadb -u root --password=schueler
```


## Einbinden von SQL Dumps
1. sql-Dumps in den Ordner ./SQL_Dumps kopieren
2. Zum Docker Pfad navigieren
3. Skript ausführen bzw. Befehl manuell eingeben:
   - Windows:  <br>
        Windows_3_ImportAllSQLDumps.bat

        oder <br>

        ```
        cmd.exe /c 'docker exec -i <CONTAINERNAME>-maria-1 mariadb -u root --password=schueler mysql < ./SQL_Dumps/rfidV5Klein.sql'
        ```
        
    - Linux:  <br>
        Linux_3_ImportAllSQLDumps.sh  
        
        oder <br>
        ```
        docker exec -i "${LOWER_CONTAINERNAME}-maria-1" mariadb -u root --password=schueler < "$file"
        ```
       
        
        oder <br>
        betriebssystemunabhängig: 
        ```
        source /var/lib/mysql-dumps/<FILENAME>
        ```