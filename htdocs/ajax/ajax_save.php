<?php

// ###########################################################################################
// Diese Seite beschreibt den Aufruf zum Speichern von neuen oder geänderten Kompetenzelementen
// ###########################################################################################

// Datenbankverbindung herstellen
//include db configuration file
include_once("../config.php");

// Datenbankverbindung prüfen
if (mysqli_connect_errno()) {
    printf("Datenbankverbindung nicht hergestellt: %s\n", $mysqli->connect_error);
    exit();
}

//Wird ein neuer Datensatz angelegt wird diese Routine aufgerufen
if(isset($_POST['RFID_ID'])){
    
    //Entfernung von Buchstaben und Sonderzeichen
    $RFID_ID = filter_var($_POST['RFID_ID'],FILTER_SANITIZE_NUMBER_INT);
    $RFID_Reader = filter_var($_POST['RFID_Reader'],FILTER_SANITIZE_NUMBER_INT);
  
	//Je nach Stundenverlauf, soll der Zugang zufällig gewählt werden oder nicht. 
	//Der Standardwertwert für "$random_permission" kann in der config.php eingestellt werden.
	if ($random_permission==false) {
		 //Prüfung ob Zutritt gewährt wird oder nicht (Aktuell Zufallsprinzip, da Datenbankdesign noch nicht fertig)
		 $zufallszahl = rand(10, 100);
			if ($zufallszahl>50){
				$ErgebnisText = "Zutritt gestattet";
				$Ergebnis = true;
			} else {
				$ErgebnisText = "Zutritt abgelehnt";
				$Ergebnis = false;
			}
	} else {
		//Tatsächliche Prüfung, ob Berechtigung vorhanden ist (ohne Zeitbereiche)
		$sqlQuery = "SELECT DISTINCT tblBerechtigung.tblReader_ReaderID
						FROM tblZutrittsversuche
						INNER JOIN tblChips ON tblZutrittsversuche.tblChips_ChipsID = tblChips.ChipsID
						INNER JOIN tblBerechtigung ON tblChips.ChipsID = tblBerechtigung.tblChips_ChipsID
						WHERE tblZutrittsversuche.tblChips_ChipsID = '".$RFID_ID."' 
						AND tblBerechtigung.tblReader_ReaderID = '".$RFID_Reader."'
						";
		
		$query_permission = $db->query($sqlQuery); 
		
		//Falls die Abfrage durchgeführt werden konnte, dann...
		if($query_permission){
			//Abfrage der Ergebnisse. 
			$total_num_rows = $query_permission->num_rows;
			
			//Zutritt gestatten, wenn Abfrage ein Ergebnis bringt
			if ($total_num_rows>0) {	
				$ErgebnisText = "Zutritt gestattet";
				$Ergebnis = true;
			} else {
				$ErgebnisText = "Zutritt abgelehnt";
				$Ergebnis = false;
			}	
		}  else {
			echo "Datenbankabfrage nicht möglich";

			//header('HTTP/1.1 500 '.mysql_error()); //display sql errors.. must not output sql errors in live mode.
			header('HTTP/1.1 500 Looks like mysql error, could not query permissions!');
			exit();
		}			
	}

    //aktuellen Zeitstempel holen
    $timestamp = date("Y-m-d H:i:s");  // Datum im Mysql Format: 2001-03-10 17:16:18

    //Zutrittsversuch in die Datenbank schreiben
	//Prüfung notwendig, ob Spalte tblReader_ReaderID in tblZutrittsversuche enthalten ist, da dies eine Zusatzaufgabe ist
	if (checkColumnExist($db, "tblZutrittsversuche", "tblReader_ReaderID") === true){
		$sqlInsert = "INSERT INTO tblZutrittsversuche (
											Zeitstempel,
											tblChips_ChipsID,
											Ergebnis,
											tblReader_ReaderID,
											DB_User                                        
										)VALUES(
												'".$timestamp."',
												'".$RFID_ID."',
												'".$ErgebnisText."',
												'".$RFID_Reader."',
												'".$username."' 											
										)";
	} else {
		$sqlInsert = "INSERT INTO tblZutrittsversuche (
											Zeitstempel,
											tblChips_ChipsID,
											Ergebnis,
											DB_User                                        
										)VALUES(
												'".$timestamp."',
												'".$RFID_ID."',
												'".$ErgebnisText."',
												'".$username."' 											
										)";
	}

	// Insert sanitize string in record
	$insert_row = $db->query($sqlInsert);                                
	
   if($insert_row){                                    
        
        //Ausgabe des aktuellen Datensatzes
            $output = array(
                "RFID_ID" => $RFID_ID,
                "RFID_Reader" => $RFID_Reader,
                "Resultat" =>  $Ergebnis,
                "Zeitstempel" => $timestamp
                );
          //  }
          
            // Encodierung der finalen Ausgabe in JSON
            $json = json_encode($output, JSON_HEX_QUOT | JSON_HEX_TAG);

            // Rückgabe des JSON strings
            echo $json;

			// $db->close(); //close db connection
			$db->close();

    }
    else{
        echo "Eintrag nicht erfolgreich";

		//header('HTTP/1.1 500 '.mysql_error()); //display sql errors.. must not output sql errors in live mode.
		header('HTTP/1.1 500 Looks like mysql error, could not insert record!');
		exit();
	}
}

function checkColumnExist($db, $TableName, $ColumnName){
	
	$sqlQuery = "show columns from $TableName where field = '$ColumnName';";   
			
	$query_ColumnExist = $db->query($sqlQuery); 

	//Falls die Abfrage durchgeführt werden konnte, dann...
	if($query_ColumnExist && $query_ColumnExist->num_rows === 1){
		return true;
	}
	else {
		return false;
	}
}

?>