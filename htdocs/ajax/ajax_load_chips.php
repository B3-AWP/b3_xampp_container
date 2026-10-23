<?php

// ###########################################################################################
// Diese Seite beschreibt den Aufruf zum Speichern von neuen oder geänderten Kompetenzelementen
// ###########################################################################################

// Datenbankverbindung herstellen
//include db configuration file
include_once("../config.php"); // prüft auch die Datenbankverbindung

//Abfrage der vorhandenen Chips
$sqlQuery = "SELECT C.ChipsID, B.Nachname from tblChips C 
			LEFT Join tblBenutzer B 
			ON C.tblBenutzer_BenutzerID = B.BenutzerID";   


$query_Chips = $db->query($sqlQuery); 

		
	//Falls die Abfrage durchgeführt werden konnte, dann...
	if($query_Chips){
		$num_rows = $query_Chips->num_rows;
		$counter1 = 1;  //wird für die Auswahl des Bildes verwendet
		$counter2 = (int)0; // wird für die Generierung der Klasse "color_" verwendet
		$output = array();
		while($row = $query_Chips->fetch_assoc()){

            $counter2++;
			//Nach jeweils $numberOfTransponders Chips beginnen die Bilder von vorne, daher wird die nächste Farbe verwendet
			switch (true) {
				case ($counter2 <= $numberOfTransponders):
					$colorclass = 0;  //Colorclass 0 ist nicht definiert und daher wird Standartbild angzeigt
					break;
				case ($counter2 <= $numberOfTransponders*2):
					$colorclass = 1;
					break;
				case ($counter2 <= $numberOfTransponders*3):
					$colorclass = 2;
					break;
				case ($counter2 <= $numberOfTransponders*4):
					$colorclass = 3;
					break;
				default: 
					$colorclass = 4;
					break;
			}
			
			//Ausgabe des aktuellen Datensatzes
            $output[] = array(
                "ChipsID"      	=> $row["ChipsID"],
                "Nachname"      => $row["Nachname"],
				"colorclass"	=> $colorclass,
				"counter1"		=> $counter1
            );
						
			if ($counter1<$numberOfTransponders){
				$counter1++;
			}else {
				$counter1 = 1;
			}
			
        }
			// Encodierung der finalen Ausgabe in JSON
					$json = json_encode($output, JSON_HEX_QUOT | JSON_HEX_TAG);

			// Rückgabe des JSON strings
					echo nl2br($json);
					
            // $db->close(); //close db connection
			$db->close();
		
	}  else {
		//header('HTTP/1.1 500 '.mysql_error()); //display sql errors.. must not output sql errors in live mode.
		header('HTTP/1.1 500 Looks like mysql error, could not query chips!');
		echo "Datenbankabfrage nicht möglich aus tblChips: ".$db->error;
		exit();
	}			


?>