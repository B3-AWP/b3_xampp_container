<!--###########################################  -->
<!--###########################################  -->
<!--Version: 0.9 - Rol/Hng -->
<!--Der Zugang erfolgt je nach Einstellung in der config.php nach dem Zufälligkeitsprinzip  -->
<!-- Versions-info: Dynamisches Laden der Chips und Reader -->
<!--###########################################  -->


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta 
		http-equiv="Content-Type" 
		content="text/html; charset=utf-8; X-Content-Type-Options=nosniff"
				
		
	/>
    <title>RFID Simulator</title>
    <style type="text/css">
        div {
            display: inline-block;
            background-repeat: repeat;  
        }
    </style>

    <!-- Einbindung des jQuery ui Stylesheets und des internen Stylesheets -->
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="css/style.css">

    <!-- Einbindung von externen JavaScript Bibliotheken -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    
    <!-- Beginn eigener JavaScript Code -->
    <script>
        $(document).ready(function(){
			
			//pageLoad wird beim ersten Seitenaufruf aufgerufen
			pageload();
			
			$( "#btnRefresh" ).button().on( "click", function() {
				var loader = "<div class='loader'></div>"
				$('.init').append(loader) 
				$(".loader").fadeOut(1000);
				console.log("Chips und Reader aktualisiert");
				
				pageload();
			});		
		
			function pageload(){
            // Die Draggable Objekte werden aufgerufen. Diese stellen die RFID Transponder da.
				$.ajax({ 
					type: "POST", // HTTP method POST or GET
					url: 'ajax/ajax_load_chips.php', 
					dataType: 'json', 
					success: function(data) { 
						var Chips = "Meine RFID Transponder<br>";
						for(var i = 0; i < data.length; i++) {
							Chips += "<div id='draggable_"+data[i].ChipsID+"' class='chips, ui-widget-content, color_"+data[i].colorclass+"'>";
							Chips += 	"<img src='img/RFID_Transponder_color"+data[i].counter1+".png'>";
							Chips += 	"<div class='centered'>"+data[i].ChipsID+"</div>";
							if (data[i].Nachname != null){
								Chips += 	"<div class='bottom'>"+data[i].Nachname+"</div>";
							}
							
							Chips += "</div>";
						}
					
						$('.grid_RFID_transponder').html(Chips); 
						for (var i = 0; i < data.length; i++) {
							   $( "#draggable_"+data[i].ChipsID).draggable();
						} 
					},
					error: function (request, status, error) {
						console.error("Chips konnten nicht geladen werden!");
						alert(request.responseText);
					 }  
				});
				
				// Die Droppable Objekte werden aufgerufen. Diese stellen die RFID Reader da.
				$.ajax({ 
					type: "POST", // HTTP method POST or GET
					url: 'ajax/ajax_load_reader.php', 
					dataType: 'json', 
					success: function(data) { 
						var Reader = "Meine RFID Türen <br>";
						if (data.length > 0){
							
							for(var i = 0; i < data.length; i++) {
								Reader += "<div id='RFIDReader_"+data[i].ReaderID+"'  class='ui-widget-content'>";
								Reader += 	"<p>"+data[i].Bezeichnung+"</p>";
								Reader += 	"<img id='RFIDReaderPicture_"+data[i].ReaderID+"' src='img/RFID_Access_Initial.png'>"; 
								Reader += "</div>";
							}
						
							$('.grid_RFID_reader').html(Reader); 
							for (var i = 0; i < data.length; i++) {
								$( "#RFIDReader_"+data[i].ReaderID).droppable({
									classes: {
										"ui-droppable-active": "ui-state-active",
										"ui-droppable-hover": "ui-state-hover"
									},
									drop: function( event, ui ) {
										  CheckAccess(ui.draggable.attr("id"), $(this).attr("id") );
									}
								});
							} 
						}
					},
					error: function (request, status, error) {
							console.error("Chips konnten nicht geladen werden!");
							alert(request.responseText);
					 }  
				});
				
				
				//GET the datebase settings and general information
				$.ajax({ 
					type: "POST", // HTTP method POST or GET
					url: 'ajax/ajax_load_settings.php', 
					dataType: 'json', 
					success: function(data) { 
						var DBSettings = "";
						var tr = "<div class='TableRow'>";
						var tc = "<div class='TableCell'>";
							
						DBSettings += "<div id='DBSettingTable' class='Table'>";
							DBSettings += tr + tc + "random: </div>" + tc + data.random+"</div></div>";
							DBSettings += tr + tc + "database: </div>" + tc + data.databasename+"</div></div>";
							DBSettings += tr + tc + "user: </div>" + tc +data.username+"</div></div>";
							DBSettings += tr + tc + "tables: </div>" + tc;
						
							for(var i = 0; i < data.tables.length; i++) {
								DBSettings += 	data.tables[i];
								if (i != data.tables.length - 1){
									DBSettings += ", ";
								}else{
									DBSettings += "</div></div>";
								}
							}

							DBSettings += tr + tc + "Connection: </div>" + tc + data.is_internetconnection+"</div></div>";						
						DBSettings += "</div>";
						
						$('.grid_Setting_Info').html(DBSettings);
						$( "#DBSettingTable").draggable();
					
					},
					error: function (request, status, error) {
						console.error("DB Einstellungsinformationen konnten nicht geladen werden.");
						alert(request.responseText);
					 }  
				});
				
			}
	
            //Prozedur übergibt Daten der Tür und des Transponders an eine Datenbank
            function CheckAccess(RFID_ID, RFID_Reader){
                // Zu übergebende Variablen werden festgelegt.
                var myData = {
                    RFID_ID: RFID_ID, 
                    RFID_Reader: RFID_Reader  
                };
                
                // Ajax Aufruf
                $.ajax({
                    type: "POST", // HTTP method POST or GET
                    url: "ajax/ajax_save.php", //Where to make Ajax calls
                    dataType:"json", 
                    data: myData, //Zu übergebenden Variablen
                    
                    //Falls ajax call erfolgreich war, dann...
                    success:function(myData){
                        // Falls Zugang gewährt wurde, dann...
                        if (myData.Resultat == true) {
                            console.error("Access granted for "+myData.RFID_ID+" on reader "+myData.RFID_Reader);
                            $("#RFIDReaderPicture_"+myData.RFID_Reader).attr("src","img/RFID_Access_Granted.png");
                        } else {
                            console.error("Access denied for "+myData.RFID_ID+" on reader "+myData.RFID_Reader);
                            $("#RFIDReaderPicture_"+myData.RFID_Reader).attr("src","img/RFID_Access_Denied.png");
                            
                        }
                        //Zurücksetzen des Draggable Objekts.
                        //Nach 100 ms Soll Style von Draggable zunächst entfernt werden. 
                        //Anschließend wird Style wieder hinzugefügt, damit ursprüngliche Position angezeigt wird.
                        setTimeout(function(){
                            $("#draggable_"+myData.RFID_ID).removeAttr("style"); 
                            $( "#draggable_"+myData.RFID_ID ).attr('style',  'position:relative'); 
                        }, 100 );   
                        //Zürcksetzen des Droppable Objekts.
                        //Nach 1 Sekunde wird Style von Droppable zunächst entfernt.
                        setTimeout(function(){ 
                            $("#RFIDReaderPicture_"+myData.RFID_Reader).attr("src","img/RFID_Access_Initial.png");
                        }, 1000 );   
                    },
                    
                    //Falls es zu Fehlern kommt, dann Ausgabe des Fehlers auf KOnsole und in Pop-Up
                    error: function (request, status, error) {
                        console.error("Ajax war nicht erfolgreich!");
                        alert(request.responseText);
                    }   
                });
            }       
        });
    </script>
</head>
<body>
	<!--Start Ladesymbol einbinden, da Seitenaufbau dauern kann -->
	<script>
		
		$(window).on('load', function(){ 
			$(".loader").fadeOut(1000);
		})

	</script>
	<div class="init">
		<div class="loader"></div>
	</div>
	<!--Ende Ladesymbol einbinden, da Seitenaufbau dauern kann -->


    <div class="wrapper">

		<!-- Die Überschrift -->
        <div class="grid_header_heading">
            <h3>RFID Zugangskontrolle - Simulator<h3>
        </div>

        <!-- Das Logo -->
        <div class="grid_header_Logo.png">
            <img src="img/Nettmann_logo.png" height="42">
        </div>
        
        <!-- Die RFID Transponder -->
        <div class="grid_RFID_transponder">
          <!-- Bereich wird dynamisch gefüllt -->
        </div>

		<!-- Der Bereich der RFID Reader (Droppable Area)-->
        <div class="grid_RFID_reader">
			<!-- Bereich wird dynamisch gefüllt -->
        </div>
		
		<div>
		  <button id="btnRefresh" class="ui-button ui-widget ui-corner-all">
			<span class="ui-icon ui-icon-refresh"></span>Aktualisieren
		  </button>
		</div>
		
		<!-- Bereich für Einstellungsinformationen -->
		<div class="grid_Setting_Info" >
					<!-- Bereich wird dynamisch gefüllt -->
        </div>
		

</div>
</body>
</html>

