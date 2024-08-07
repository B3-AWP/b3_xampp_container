<?PHP
$MeineAusgabe = [1, 21, 123, 512, 561, 123];
foreach ($MeineAusgabe as $AusgabeZeile) {
	$AusgabeZeile += $AusgabeZeile;
	echo $AusgabeZeile."<br>";
}
?> 