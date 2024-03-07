/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

USE `rfidv5klein`;


-- Lösungen basierend auf V03
select "=== Lösungen für Nettmann LS 2.2 DQL 2 Tabellen V05 ===" as "";
-- Aufgabe 1
select "=== Aufgabe 1 ===" as "";

SELECT * 
FROM tblZutrittsversuche, tblChips;


-- Aufgabe 2
select "=== Aufgabe 2 ===" as "";

SELECT ChipSerienNr 
FROM tblChips 
WHERE ChipSerienNr LIKE '011%';

-- Aufgabe 3:
select "=== Aufgabe 3 ===" as "";

SELECT ZutrittsversuchID, ChipSerienNr 
FROM tblZutrittsversuche, tblChips 
WHERE tblChips_ChipsID = ChipsID;

-- Aufgabe 4:
select "=== Aufgabe 4 ===" as "";


SELECT ZutrittsversuchID, ChipSerienNr 
FROM tblZutrittsversuche 
 INNER JOIN tblChips ON tblChips_ChipsID = ChipsID;

-- Aufgabe 5:
select "=== Aufgabe 5 ===" as "";


SELECT tblBenutzer_BenutzerID 
FROM tblZutrittsversuche 
 INNER JOIN tblChips ON tblChips_ChipsID = ChipsID 
 WHERE ZutrittsversuchID=2300;

-- Aufgabe 6:
select "=== Aufgabe 6 ===" as "";


SELECT Zeitstempel
FROM tblZutrittsversuche
 INNER JOIN tblChips ON tblChips_ChipsID = ChipsID 
 WHERE Ergebnis = 'Zutritt abgelehnt' AND tblBenutzer_BenutzerID = 5 
 ORDER BY Zeitstempel DESC; 

-- Aufgabe 7:
select "=== Aufgabe 7 ===" as "";


SELECT ZutrittsversuchID, ChipSerienNr 
FROM tblZutrittsversuche inner join tblChips 
  on tblChips_ChipsID = ChipsID 
   WHERE DATE(`Zeitstempel`) = '2017.11.20' 
   AND `Ergebnis` = "Zutritt gestattet";

-- Aufgabe 8:
select "=== Aufgabe 8 ===" as "";


SELECT tblBenutzer_BenutzerID, COUNT(tblBenutzer_BenutzerID) AS Abgelehnt 
FROM tblZutrittsversuche 
 INNER JOIN tblChips ON tblChips_ChipsID = ChipsID 
WHERE Ergebnis = 'Zutritt abgelehnt'
GROUP BY tblBenutzer_BenutzerID;

-- Aufgabe 9:
select "=== Aufgabe 9===" as "";


SELECT `tblBenutzer_BenutzerID`, COUNT(tblChips_ChipsID) AS Anzahl 
FROM tblChips 
 LEFT JOIN tblZutrittsversuche ON tblChips_ChipsID = ChipsID 
--where tblBenutzer_BenutzerID is not null 
GROUP BY tblBenutzer_BenutzerID;


-- Aufgabe 10:
select "=== Aufgabe 10 ===" as "";


SELECT `tblBenutzer_BenutzerID`, COUNT(tblChips_ChipsID) AS Anzahl 
FROM tblZutrittsversuche 
 RIGHT JOIN tblChips ON tblChips_ChipsID = ChipsID 
--where tblBenutzer_BenutzerID is not null 
GROUP BY tblBenutzer_BenutzerID;


-- Aufgabe 11:
select "=== Aufgabe 11 Variante 1===" as "";


SELECT tblBenutzer_BenutzerID, COUNT(z2.tblChips_ChipsID) as Anzahl 
FROM tblChips 
 LEFT JOIN tblZutrittsversuche z2 ON tblChips_ChipsID = ChipsID 
WHERE z2.Ergebnis = "Zutritt abgelehnt" OR z2.tblChips_ChipsID is NULL  
GROUP BY tblBenutzer_BenutzerID;
 
 
 -- Aufgabe 11:
select "=== Aufgabe 11 Variante 2 ===" as "";


SELECT tblBenutzer_BenutzerID,
(SELECT COUNT(z2.tblChips_ChipsID) 
 from tblZutrittsversuche as z2 
 WHERE z2.Ergebnis like "%abgelehnt" and z2.tblChips_ChipsID = z1.tblChips_ChipsID) as abgelehnt 
FROM tblChips LEFT JOIN tblZutrittsversuche as z1 ON z1.tblChips_ChipsID = ChipsID
  --WHERE tblBenutzer_BenutzerID is not null
  GROUP BY tblBenutzer_BenutzerID;
  
  
