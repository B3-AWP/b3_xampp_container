<?php

// ###########################################################################################
// Diese Seite beschreibt den Aufruf zum Speichern von neuen oder geänderten Kompetenzelementen
// ###########################################################################################

// Datenbankverbindung herstellen
//include db configuration file
include_once("../config.php"); // prüft auch die Datenbankverbindung

//Wird ein neuer Datensatz angelegt wird diese Routine aufgerufen
if(isset($_POST['RFID_ID'])){
    
    //Extraktion der Zahlen aus den Element-IDs (z.B. "draggable_123" -> 123)
    //Die JavaScript-Funktion sendet die vollständigen Element-IDs
    $RFID_ID_raw = preg_replace('/\D/', '', $_POST['RFID_ID']); // Entfernt alles außer Ziffern
    $RFID_Reader_raw = preg_replace('/\D/', '', $_POST['RFID_Reader']);
    
    //Validierung der extrahierten Werte
    $RFID_ID = filter_var($RFID_ID_raw, FILTER_VALIDATE_INT);
    $RFID_Reader = filter_var($RFID_Reader_raw, FILTER_VALIDATE_INT);
    
    if ($RFID_ID === false || $RFID_Reader === false || $RFID_ID_raw === '' || $RFID_Reader_raw === '') {
        http_response_code(400);
        die(json_encode(["error" => "Ungültige Eingabewerte"]));
    }
  
	//Je nach Stundenverlauf, soll der Zugang zufällig gewählt werden oder nicht. 
	//Der Standardwertwert für "$random_permission" kann in der config.php eingestellt werden.
	if ($random_permission==true) {
		 //Prüfung ob Zutritt gewährt wird oder nicht (Zufallsprinzip für Testzwecke)
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
		//KORRIGIERT: Direkte Prüfung in tblBerechtigung mit Prepared Statement
		$stmt = $db->prepare("SELECT COUNT(*) as anzahl 
							  FROM tblBerechtigung 
							  WHERE tblChips_ChipsID = ? 
							  AND tblReader_ReaderID = ?");
		
		if ($stmt === false) {
			http_response_code(500);
			die(json_encode(["error" => "Datenbankabfrage konnte nicht vorbereitet werden: ".$db->error]));
		}
		
		$stmt->bind_param("ii", $RFID_ID, $RFID_Reader);
		$stmt->execute();
		$result = $stmt->get_result();
		$row = $result->fetch_assoc();
		$stmt->close();
		
		//Zutritt gestatten, wenn Berechtigung existiert
		if ($row['anzahl'] > 0) {	
			$ErgebnisText = "Zutritt gestattet";
			$Ergebnis = true;
		} else {
			$ErgebnisText = "Zutritt abgelehnt";
			$Ergebnis = false;
		}
	}

    //aktuellen Zeitstempel holen
    $timestamp = date("Y-m-d H:i:s");  // Datum im Mysql Format: 2001-03-10 17:16:18

//Zutrittsversuch in die Datenbank schreiben mit Prepared Statement
	//Prüfung notwendig, ob Spalte tblReader_ReaderID in tblZutrittsversuche enthalten ist, da dies eine Zusatzaufgabe ist
	if (checkColumnExist($db, "tblZutrittsversuche", "tblReader_ReaderID") === true){
		$stmt_insert = $db->prepare("INSERT INTO tblZutrittsversuche 
										 (Zeitstempel, tblChips_ChipsID, Ergebnis, tblReader_ReaderID, DB_User) 
										 VALUES (?, ?, ?, ?, ?)");
		if ($stmt_insert !== false) {
			$stmt_insert->bind_param("sisis", $timestamp, $RFID_ID, $ErgebnisText, $RFID_Reader, $username);
		}
	} else {
		$stmt_insert = $db->prepare("INSERT INTO tblZutrittsversuche
										 (Zeitstempel, tblChips_ChipsID, Ergebnis, DB_User)
										 VALUES (?, ?, ?, ?)");
		if ($stmt_insert !== false) {
			$stmt_insert->bind_param("siss", $timestamp, $RFID_ID, $ErgebnisText, $username);
		}
	}

	if ($stmt_insert === false) {
		http_response_code(500);
		die(json_encode(["error" => "Eintrag konnte nicht vorbereitet werden: ".$db->error]));
	}

	// Insert record
	$insert_row = $stmt_insert->execute();
	$stmt_insert->close();
	
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
        http_response_code(500);
        echo json_encode(["error" => "Eintrag nicht erfolgreich"]);
		$db->close();
		exit();
	}
}

function checkColumnExist($db, $TableName, $ColumnName){
	
	$stmt = $db->prepare("SHOW COLUMNS FROM `" . $TableName . "` WHERE Field = ?");
	if ($stmt === false) {
		return false;
	}
	$stmt->bind_param("s", $ColumnName);
	$stmt->execute();
	$result = $stmt->get_result();
	$exists = ($result->num_rows === 1);
	$stmt->close();
	
	return $exists;
}

?>