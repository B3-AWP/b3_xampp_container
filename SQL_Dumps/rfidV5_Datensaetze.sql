
-- RFID Vorlage V4
-- Änderungen von Rol:
--  - tblBerechtigungen sind nun mit ChipsID verbunden und nicht mehr mit BenutzerID
--  - Kombination aus Chip und Reader in tblBerechtigungen darf nur einmal vorkommen.
--  - Anpassung der Constraints-Bezeichnung an neue Spaltennamen aus Version V3
--  - ANlage eines DB Users "Simulator". Dieser darf nur in tblZutrittsversuche schreiben aber alle Inhalte aus rfidv4 abfragen.


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;


USE `rfidv5klein`;

-- --------------------------------------------------------


--
-- Daten für Tabelle `tblReader`
--

INSERT INTO `tblReader` (`ReaderID`, `Bezeichnung`) VALUES
(1, 'Eingang Lager'),
(2, 'Eingang Werkstatt'),
(3, 'Eingang Büro'),
(4, 'Zugang Büro/Verkauf');

-- --------------------------------------------------------


--
-- Daten für Tabelle `tblBerechtigung`
--

INSERT INTO `tblBerechtigung` (`tblChips_ChipsID`, `tblReader_ReaderID`) VALUES
(15, 1),
(15, 2),
(15, 3),
(15, 4),
(14, 2),
(14, 3),
(14, 4),
(12, 3),
(12, 4),
(5, 4),
(4, 4);


-- Anlage eines neuen Users für Simulationen, wenn dieser noch nicht vorhanden ist:
-- User soll nur in die Tabelle tblBerechtigungen Einträge machen dürfen und alle Tabellen abfragen.
CREATE OR REPLACE USER 'simulator'@'localhost' IDENTIFIED BY '';
GRANT INSERT ON `rfidv5klein`.`tblZutrittsversuche` TO 'simulator'@'localhost';
GRANT SELECT ON `rfidv5klein`.* TO 'simulator'@'localhost';

