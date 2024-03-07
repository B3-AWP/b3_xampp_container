<?php

// ###########################################################################################
// Diese Seite beschreibt das Laden und Überprüfen der Standard-Einstellungen
// ###########################################################################################

// Datenbankverbindung herstellen
//include db configuration file
include_once("../config.php");

			$is_conn = "Nein";
			
		
			$connected = fsockopen("www.b3-fuerth.de", 80); 
			if ($connected){
				$is_conn = "Ja"; //action when connected
				fclose($connected);
			}
	
			
			// Datenbankverbindung prüfen
			if (mysqli_connect_errno()) {
				printf("Datenbankverbindung nicht hergestellt: %s\n", $mysqli->connect_error);
				exit();
			}

			//Abfrage der vorhandenen Tabellen
			$sqlQuery = "SHOW TABLES FROM $databasename";   
			
			$query_Reader = $db->query($sqlQuery); 

			//Falls die Abfrage durchgeführt werden konnte, dann...
			if($query_Reader){
				
				while($table = mysqli_fetch_array($query_Reader)){
					$tables[] = $table[0];
				}

				

				$output = array(
						"random"				=> $random_permission,
						"tables"      			=> $tables,
						"databasename" 			=> $databasename,
						"username"				=> $username,
						"is_internetconnection"	=> $is_conn,
				);
				
				// Encodierung der finalen Ausgabe in JSON
				$json = json_encode($output, JSON_HEX_QUOT | JSON_HEX_TAG);

				// Rückgabe des JSON strings
				echo nl2br($json);
				
				// $db->close(); //close db connection
				$db->close();
				
			} else {
				echo "Datenbankabfrage nicht möglich";

				//header('HTTP/1.1 500 '.mysql_error()); //display sql errors.. must not output sql errors in live mode.
				header('HTTP/1.1 500 Looks like mysql error, could not query readers!');
				exit();
			}			
			
							

?>