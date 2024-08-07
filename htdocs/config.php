<?php
// ######################################################################
// Diese Seite stellt die Verbindung zur Datenbank her und definiert
// den Usernamen. Das Passwort ist zwingend zu ändern in MySql Datenbank
// ######################################################################


########## Programm Settings #############
### Set $randomPermission to 'true', if the access or deny should be based on random number and not a database query."
$random_permission = false;

########## MySql details (Replace with yours) #############
$username = 'root';  // Default: 'simulator'
$password = 'schueler'; // Default: ''
$hostname = 'maria';  // Default: '127.0.0.1'
$databasename = 'rfidv5'; // Default: 'rfidv5'
$numberOfTransponders = 6; // amount of different transponder .png images. Default: '6'


//connect to database
$db = new mysqli($hostname, $username, $password, $databasename);
if(!$db){
    exit("Datenbank Verbindungsfehler: ".mysqli_connect_error());
    }
//Set_Charset --> used to show German umlaut e.g. "Zutritt gewährt"
$db->set_charset("utf8")
?>
