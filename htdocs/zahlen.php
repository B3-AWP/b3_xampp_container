<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/zahlen.css">
    <title>Hundert Zahlen</title>
</head>
<body>
<h1>Hundert Zahlen</h1>
<table>

    <?php
    // Array mit 100 zufälligen Zahlen zwischen 1 und 100 erstellen
    $zahlen = [];
    for ($i = 0; $i < 100; $i++) {
        $zahlen[] = rand(1, 100);
    }

    // Zahlen in Gruppen zu 10 Elementen aufteilen und tabellarisch anzeigen
    foreach (array_chunk($zahlen, 10) as $zeile) {
        echo "<tr>";
        foreach ($zeile as $zahl) {
            echo "<td>" . $zahl . "</td>";
        }
        echo "</tr>";
    }
    ?>
</table>
</body>
</html>
