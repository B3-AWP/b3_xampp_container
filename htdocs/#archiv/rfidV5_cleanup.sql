
-- RFID CLeanup
-- Änderungen von Rol:
--  - Importiert die ursprünglichen Datensätze
--  - Notwendig, da DQL über zwei Tabellen nach DDL und DML kommt


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

SET FOREIGN_KEY_CHECKS=0;

USE `rfidv5klein`;
-- --------------------------------------------------------

-- 
-- Inhalte aus Tabellen löschen
-- 
TRUNCATE TABLE `tblZutrittsversuche`;
TRUNCATE TABLE `tblReader`;
TRUNCATE TABLE `tblBenutzer`;
TRUNCATE TABLE `tblChips`;
TRUNCATE TABLE `tblBerechtigung`;




--
-- Daten für Tabelle `tblBenutzer`
--

INSERT INTO `tblBenutzer` (`BenutzerID`, `Nachname`) VALUES
(1, 'Nettmann'),
(2, 'Schmidt'),
(3, 'Aydin'),
(4, 'Tabor'),
(5, 'Maier'),
(6, 'Praktikant'),
(7, 'Gast');

--
-- Daten für Tabelle `tblChips`
--

INSERT INTO `tblChips` (`ChipsID`, `ChipSerienNr`, `tblBenutzer_BenutzerID`) VALUES
(2, '01104A1CAAED',  1),
(3, '01104A6DBF89',  2),
(4, '01104A3EE085',  3),
(5, '010FA0DF2657',  4),
(12, '01104A3EC4A1', 5),
(14, '01104A41CBD1', 6),
(15, '011049BF7790', 7);


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

--
-- Daten für Tabelle `tblZutrittsversuche`
--

INSERT INTO `tblZutrittsversuche` (`ZutrittsversuchID`, `Zeitstempel`, `tblChips_ChipsID`, `Ergebnis`, `DB_User`) VALUES
(2275, '2017-04-27 17:52:15', 15, 'Zutritt abgelehnt', 'Import'),
(2276, '2017-04-27 17:52:17', 15, 'Zutritt abgelehnt', 'Import'),
(2277, '2017-04-27 17:52:20', 5, 'Zutritt abgelehnt', 'Import'),
(2278, '2017-04-27 17:52:22', 5, 'Zutritt abgelehnt', 'Import'),
(2279, '2017-04-27 17:52:24', 3, 'Zutritt gestattet', 'Import'),
(2280, '2017-04-27 17:52:27', 3, 'Zutritt abgelehnt', 'Import'),
(2281, '2017-04-27 17:52:30', 12, 'Zutritt gestattet', 'Import'),
(2282, '2017-04-27 17:52:32', 12, 'Zutritt gestattet', 'Import'),
(2283, '2017-04-27 17:54:20', 12, 'Zutritt gestattet', 'Import'),
(2284, '2017-04-27 07:56:26', 5, 'Zutritt abgelehnt', 'Import'),
(2285, '2017-04-27 07:56:32', 5, 'Zutritt abgelehnt', 'Import'),
(2286, '2017-04-27 07:56:56', 5, 'Zutritt gestattet', 'Import'),
(2287, '2017-04-27 08:48:49', 5, 'Zutritt gestattet', 'Import'),
(2288, '2017-04-27 08:48:52', 5, 'Zutritt abgelehnt', 'Import'),
(2289, '2017-04-27 09:42:37', 12, 'Zutritt gestattet', 'Import'),
(2290, '2017-04-27 09:42:39', 12, 'Zutritt gestattet', 'Import'),
(2291, '2017-04-27 09:42:56', 5, 'Zutritt abgelehnt', 'Import'),
(2292, '2017-04-27 09:42:58', 5, 'Zutritt abgelehnt', 'Import'),
(2293, '2017-04-27 09:43:01', 5, 'Zutritt abgelehnt', 'Import'),
(2294, '2017-04-27 09:43:15', 5, 'Zutritt gestattet', 'Import'),
(2295, '2017-04-27 09:43:19', 5, 'Zutritt abgelehnt', 'Import'),
(2296, '2017-04-27 10:13:56', 5, 'Zutritt gestattet', 'Import'),
(2297, '2017-04-27 10:51:38', 5, 'Zutritt abgelehnt', 'Import'),
(2298, '2017-04-27 10:51:43', 5, 'Zutritt abgelehnt', 'Import'),
(2299, '2017-04-27 10:52:20', 5, 'Zutritt gestattet', 'Import'),
(2300, '2017-04-27 10:54:05', 3, 'Zutritt abgelehnt', 'Import'),
(2301, '2017-04-27 10:54:06', 3, 'Zutritt gestattet', 'Import'),
(2302, '2017-04-27 11:41:04', 5, 'Zutritt gestattet', 'Import'),
(2303, '2017-04-27 11:41:07', 5, 'Zutritt gestattet', 'Import'),
(2304, '2017-04-27 11:41:08', 5, 'Zutritt gestattet', 'Import'),
(2305, '2017-04-27 11:43:10', 5, 'Zutritt gestattet', 'Import'),
(2306, '2017-04-27 11:43:18', 5, 'Zutritt abgelehnt', 'Import'),
(2307, '2017-04-27 11:43:53', 5, 'Zutritt gestattet', 'Import'),
(2308, '2017-04-27 11:43:56', 5, 'Zutritt abgelehnt', 'Import'),
(2309, '2017-04-27 11:44:04', 12, 'Zutritt gestattet', 'Import'),
(2310, '2017-04-27 11:44:07', 12, 'Zutritt gestattet', 'Import'),
(2311, '2017-04-27 11:48:40', 5, 'Zutritt abgelehnt', 'Import'),
(2312, '2017-04-27 11:48:44', 5, 'Zutritt abgelehnt', 'Import'),
(2313, '2017-04-27 11:49:02', 5, 'Zutritt gestattet', 'Import'),
(2314, '2017-04-27 19:24:09', 15, 'Zutritt abgelehnt', 'Import'),
(2315, '2017-04-27 19:24:10', 15, 'Zutritt abgelehnt', 'Import'),
(2316, '2017-04-27 19:24:11', 15, 'Zutritt abgelehnt', 'Import'),
(2317, '2017-04-27 19:24:15', 3, 'Zutritt gestattet', 'Import'),
(2318, '2017-04-27 19:24:18', 3, 'Zutritt abgelehnt', 'Import'),
(2319, '2017-04-27 19:24:23', 5, 'Zutritt abgelehnt', 'Import'),
(2320, '2017-04-27 19:24:25', 5, 'Zutritt abgelehnt', 'Import'),
(2321, '2017-04-27 19:24:29', 12, 'Zutritt gestattet', 'Import'),
(2322, '2017-04-27 19:24:31', 12, 'Zutritt gestattet', 'Import'),
(2323, '2017-04-27 19:24:31', 12, 'Zutritt gestattet', 'Import'),
(2324, '2017-04-27 19:24:33', 12, 'Zutritt gestattet', 'Import'),
(2325, '2017-04-27 19:24:34', 12, 'Zutritt gestattet', 'Import'),
(2326, '2017-04-27 19:24:38', 12, 'Zutritt gestattet', 'Import'),
(2327, '2017-04-27 19:24:40', 12, 'Zutritt gestattet', 'Import'),
(2328, '2017-04-27 19:24:42', 12, 'Zutritt gestattet', 'Import'),
(2329, '2017-04-27 19:34:29', 15, 'Zutritt abgelehnt', 'Import'),
(2330, '2017-04-27 19:34:40', 15, 'Zutritt abgelehnt', 'Import'),
(2331, '2017-04-27 19:34:49', 3, 'Zutritt abgelehnt', 'Import'),
(2332, '2017-04-27 19:34:51', 3, 'Zutritt gestattet', 'Import'),
(2334, '2017-11-20 18:05:34', 3, 'Zutritt gestattet', 'Import'),
(2335, '2017-11-22 09:17:23', 5, 'Zutritt abgelehnt', 'Import'),
(2336, '2017-11-22 09:17:27', 15, 'Zutritt abgelehnt', 'Import'),
(2337, '2017-11-22 09:17:32', 3, 'Zutritt abgelehnt', 'Import'),
(2338, '2017-11-22 09:17:35', 12, 'Zutritt abgelehnt', 'Import'),
(2339, '2017-11-22 09:17:38', 12, 'Zutritt gestattet', 'Import'),
(2340, '2017-11-22 09:17:42', 15, 'Zutritt abgelehnt', 'Import'),
(2341, '2017-11-22 09:18:26', 15, 'Zutritt abgelehnt', 'Import'),
(2342, '2017-11-22 09:18:27', 12, 'Zutritt gestattet', 'Import'),
(2343, '2017-11-22 09:18:29', 12, 'Zutritt abgelehnt', 'Import'),
(2344, '2017-11-22 09:18:34', 12, 'Zutritt gestattet', 'Import'),
(2345, '2017-11-22 09:54:44', 12, 'Zutritt abgelehnt', 'Import'),
(2346, '2017-11-22 09:54:46', 12, 'Zutritt gestattet', 'Import'),
(2347, '2017-11-22 09:54:53', 3, 'Zutritt abgelehnt', 'Import'),
(2348, '2017-11-22 09:54:55', 3, 'Zutritt abgelehnt', 'Import'),
(2349, '2017-11-22 11:25:05', 12, 'Zutritt abgelehnt', 'Import'),
(2350, '2017-11-22 11:25:07', 12, 'Zutritt abgelehnt', 'Import'),
(2351, '2017-11-22 11:25:07', 12, 'Zutritt gestattet', 'Import'),
(2352, '2017-11-22 11:25:10', 12, 'Zutritt gestattet', 'Import'),
(2353, '2017-11-22 11:25:13', 12, 'Zutritt abgelehnt', 'Import'),
(2354, '2017-11-22 11:25:35', 12, 'Zutritt gestattet', 'Import'),
(2355, '2017-11-22 11:25:37', 12, 'Zutritt gestattet', 'Import'),
(2356, '2017-11-22 11:26:29', 12, 'Zutritt abgelehnt', 'Import'),
(2357, '2017-11-22 11:26:31', 12, 'Zutritt gestattet', 'Import'),
(2358, '2017-11-22 11:27:34', 12, 'Zutritt abgelehnt', 'Import');


-- Anlage eines neuen Users für Simulationen, wenn dieser noch nicht vorhanden ist:
-- User soll nur in die Tabelle tblBerechtigungen Einträge machen dürfen und alle Tabellen abfragen.
CREATE OR REPLACE USER 'simulator'@'localhost' IDENTIFIED BY '';
GRANT INSERT ON `rfidv5klein`.`tblZutrittsversuche` TO 'simulator'@'localhost';
GRANT SELECT ON `rfidv5klein`.* TO 'simulator'@'localhost';

SET FOREIGN_KEY_CHECKS=1;
