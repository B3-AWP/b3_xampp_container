<?php

// ###########################################################################################
// Diese Seite beschreibt den Aufruf zum Speichern von neuen oder geänderten Kompetenzelementen
// ###########################################################################################

// Datenbankverbindung herstellen
//include db configuration file
include("../config.php"); // prüft auch die Datenbankverbindung

//Abfrage der vorhandenen Chips
$sqlQuery = "SELECT * from tblReader";   

$query_Reader = $db->query($sqlQuery); 

		
	//Falls die Abfrage durchgeführt werden konnte, dann...
	if($query_Reader){
		$num_rows = $query_Reader->num_rows;
		$output = array();
		while($row = $query_Reader->fetch_assoc()){
           
			//Ausgabe des aktuellen Datensatzes
            $output[] = array(
                "ReaderID"      => $row["ReaderID"],
				"Bezeichnung"	=> $row["Bezeichnung"],
            );
        }
		
		// Encodierung der finalen Ausgabe in JSON
		$json = json_encode($output, JSON_HEX_QUOT | JSON_HEX_TAG);

		// Rückgabe des JSON strings
		echo nl2br($json);
		
		// $db->close(); //close db connection
		$db->close();
		
	} else {
		//header('HTTP/1.1 500 '.mysql_error()); //display sql errors.. must not output sql errors in live mode.
		header('HTTP/1.1 500 Looks like mysql error, could not query readers!');
		echo "Datenbankabfrage nicht möglich aus tblReader: ".$db->error;
		exit();
	}			


?>




