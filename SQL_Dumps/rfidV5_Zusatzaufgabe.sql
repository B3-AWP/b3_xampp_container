
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
SET @dbname = DATABASE();
--
-- Daten für Tabelle `tblChips`
--
-- Überprüfen, ob die Spalten bereits existieren
SET @table_name = 'tblChips';
SET @column_name1 = 'AusstellungsDatum';
SET @column_name2 = 'AblaufDatum';

SET @exists = (
    SELECT COUNT(*)
    FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = @table_name
      AND COLUMN_NAME IN (@column_name1, @column_name2)
);

-- Wenn die Spalten nicht existieren, führe die Änderungen durch
SET @sql = IF(@exists = 0,
    CONCAT('
        ALTER TABLE `', @table_name, '`
        ADD COLUMN `', @column_name1, '` DATE DEFAULT NULL,
        ADD COLUMN `', @column_name2, '` DATE DEFAULT NULL;

        UPDATE `', @table_name, '` SET `', @column_name1, '` = ''2024-01-10'', `', @column_name2, '` = ''2024-10-31'' WHERE `ChipsID` = 2;
        UPDATE `', @table_name, '` SET `', @column_name1, '` = ''2024-02-15'', `', @column_name2, '` = ''2025-02-15'' WHERE `ChipsID` = 3;
        UPDATE `', @table_name, '` SET `', @column_name1, '` = ''2024-03-20'', `', @column_name2, '` = ''2024-09-20'' WHERE `ChipsID` = 4;
        UPDATE `', @table_name, '` SET `', @column_name1, '` = ''2024-04-25'', `', @column_name2, '` = ''2025-04-25'' WHERE `ChipsID` = 5;
        UPDATE `', @table_name, '` SET `', @column_name1, '` = ''2024-05-30'', `', @column_name2, '` = ''2025-05-30'' WHERE `ChipsID` = 12;
        UPDATE `', @table_name, '` SET `', @column_name1, '` = ''2024-06-05'', `', @column_name2, '` = ''2025-06-05'' WHERE `ChipsID` = 14;
        UPDATE `', @table_name, '` SET `', @column_name1, '` = ''2024-07-10'', `', @column_name2, '` = ''2025-07-10'' WHERE `ChipsID` = 15;
    '),
    'SELECT ''Columns already exist, no changes made.'' AS Message;'
);

PREPARE tblchips_stmt FROM @sql;
EXECUTE tblchips_stmt;
DEALLOCATE PREPARE tblchips_stmt;


-- Überprüfen, ob die Spalte SecurityLevel bereits existiert
SET @table_name = 'tblReader';
SET @column_name = 'SecurityLevel';

SET @exists = (
    SELECT COUNT(*)
    FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = @table_name
      AND COLUMN_NAME = @column_name
);

-- Wenn die Spalte nicht existiert, füge sie hinzu
SET @alter_sql = IF(@exists = 0,
    CONCAT('ALTER TABLE `', @table_name, '` ADD COLUMN `', @column_name, '` INT DEFAULT NULL'),
    'SELECT ''Column already exists'' AS message'
);

PREPARE alter_tblreader_stmt FROM @alter_sql;
EXECUTE alter_tblreader_stmt;
DEALLOCATE PREPARE alter_tblreader_stmt;

-- Update-Befehl vorbereiten und ausführen
SET @update_sql = CONCAT('

    UPDATE `', @table_name, '` SET `', @column_name, '` = ''Standard'' WHERE `ReaderID` = 1;
    UPDATE `', @table_name, '` SET `', @column_name, '` = ''Standard'' WHERE `ReaderID` = 2;
    UPDATE `', @table_name, '` SET `', @column_name, '` = ''HighSecurity'' WHERE `ReaderID` = 3;
    UPDATE `', @table_name, '` SET `', @column_name, '` = ''Standard'' WHERE `ReaderID` = 4;
');

PREPARE update_tblreader_stmt FROM @update_sql;
EXECUTE update_tblreader_stmt;
DEALLOCATE PREPARE update_tblreader_stmt;

-- Anlage eines neuen Users für Simulationen, wenn dieser noch nicht vorhanden ist:
-- User soll nur in die Tabelle tblBerechtigungen Einträge machen dürfen und alle Tabellen abfragen.
CREATE OR REPLACE USER 'simulator'@'localhost' IDENTIFIED BY '';
GRANT INSERT ON `rfidv5klein`.`tblZutrittsversuche` TO 'simulator'@'localhost';
GRANT SELECT ON `rfidv5klein`.* TO 'simulator'@'localhost';

