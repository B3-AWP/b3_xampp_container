
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


USE `rfidv5`;

-- --------------------------------------------------------

-- Prüfen, ob die Spalte 'SecurityLevel' bereits existiert, und wenn nicht, hinzufügen
SET @dbname = DATABASE();
SET @tablename = "tblReader";
SET @columnname = "SecurityLevel";
SET @preparedStatement = (SELECT IF(
  (
    SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
    WHERE
      (table_name = @tablename)
      AND (table_schema = @dbname)
      AND (column_name = @columnname)
  ) > 0,
  "SELECT 1",
  CONCAT("ALTER TABLE ", @tablename, " ADD ", @columnname, " INT;")
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

-- Aktualisieren der vorhandenen Datensätze mit Beispieldaten
UPDATE tblReader
SET SecurityLevel = FLOOR(1 + RAND() * 5)
WHERE SecurityLevel IS NULL;


-- Anlage eines neuen Users für Simulationen, wenn dieser noch nicht vorhanden ist:
-- User soll nur in die Tabelle tblBerechtigungen Einträge machen dürfen und alle Tabellen abfragen.
CREATE OR REPLACE USER 'simulator'@'localhost' IDENTIFIED BY '';
GRANT INSERT ON `rfidv5klein`.`tblZutrittsversuche` TO 'simulator'@'localhost';
GRANT SELECT ON `rfidv5klein`.* TO 'simulator'@'localhost';

