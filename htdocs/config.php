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
$databasename = 'rfidv5klein'; // Default: 'rfidv5'
$numberOfTransponders = 6; // amount of different transponder .png images. Default: '6'


//Fehler werden über Rückgabewerte (if-Abfragen) geprüft. Ab PHP 8.1 wirft mysqli sonst Exceptions und die if-Abfragen greifen nie.
mysqli_report(MYSQLI_REPORT_OFF);

//connect to database (@ unterdrückt die PHP-Warnung, die Fehlermeldung wird unten selbst ausgegeben)
$db = @new mysqli($hostname, $username, $password, $databasename);
if($db->connect_errno){
    http_response_code(500);
    exit("Datenbank Verbindungsfehler: ".$db->connect_error);
    }
//Set_Charset --> used to show German umlaut e.g. "Zutritt gewährt"
$db->set_charset("utf8")
?>
