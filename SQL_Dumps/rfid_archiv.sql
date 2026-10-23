SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";
SET SESSION time_zone = "+00:00";
SET @@sql_mode='Traditional';

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Datenbank: `rfid_archiv`
--
DROP DATABASE IF EXISTS `rfid_archiv`;
CREATE DATABASE IF NOT EXISTS `rfid_archiv` DEFAULT CHARACTER SET utf8 COLLATE utf8_swedish_ci;
USE `rfid_archiv`;



-- ODER manuelle Lösung

CREATE TABLE IF NOT EXISTS tblZutrittsversuche (
    ZutrittsversuchID INT PRIMARY KEY,
    Zeitstempel TIMESTAMP,
    tblChips_ChipsID INT,
    ChipSerienNr varchar(14),
    tblBenutzer_BenutzerID int(11),
    Nachname varchar(45),
    tblReader_ReaderID INT,
    Bezeichnung varchar(30),
    Ergebnis VARCHAR(50),
    DB_User VARCHAR(50)
);


-- Smarte Lösung Kopie der Original-Tabelle.
/*
CREATE TABLE IF NOT EXISTS tblZutrittsversuche like rfidv5.tblZutrittsversuche;
-- Hinzufügen weiter Information, auf die in Original-Datenbank nur referenziert wird.
Alter TABLE tblZutrittsversuche (
    ChipSerienNr varchar(14),
    tblBenutzer_BenutzerID int(11),
    Nachname varchar(45),
    Bezeichnung varchar(30),
);
-- Entfernen des auto_increments wäre bei Kopie noch notwendig, da die ID fest vergeben werden sollte.
Alter table tblZutrittsversuche change ZutrittsversuchID ZutrittsversuchID INT;
*/

CREATE TABLE IF NOT EXISTS tblFehlerprotokoll (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Fehlerzeit DATETIME,
    Fehlerbeschreibung TEXT
);


-- Nützliche Abfragen
show tables;
SELECT * FROM rfid_archiv.tblZutrittsversuche; 
SELECT * FROM rfidv5_klein.tblZutrittsversuche; 
SELECT * FROM rfid_archiv.tblFehlerprotokoll; 
delete from rfid_archiv.tblZutrittsversuche; 