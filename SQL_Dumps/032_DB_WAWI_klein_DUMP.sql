-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Erstellungszeit: 23. Apr 2015 um 14:40
-- Server Version: 5.5.32
-- PHP-Version: 5.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Datenbank: `wawiklein`
--
CREATE DATABASE IF NOT EXISTS `wawiklein` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `wawiklein`;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `artikel`
--

CREATE TABLE IF NOT EXISTS `artikel` (
  `A_Nr` int(11) NOT NULL DEFAULT '0',
  `A_Bez` varchar(50) DEFAULT NULL,
  `A_Art` varchar(50) DEFAULT NULL,
  `A_VK` decimal(9,2) DEFAULT '0.00',
  `A_Bestand` int(11) DEFAULT '0',
  `A_MinBestand` int(11) DEFAULT '0',
  PRIMARY KEY (`A_Nr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `artikel`
--

INSERT INTO `artikel` (`A_Nr`, `A_Bez`, `A_Art`, `A_VK`, `A_Bestand`, `A_MinBestand`) VALUES
(1, 'HP Laserjet P6', 'Laserdrucker', '375.00', 15, 2),
(2, 'Cannon', 'Laserdrucker', '260.00', 4, 1),
(3, 'MACOM', 'Monitor', '155.00', 10, 4),
(4, 'Highscreen', 'Monitor', '125.00', 7, 5),
(5, 'Sony', 'CD-ROM', '99.00', 20, 5),
(6, 'Mitsumi 32', 'CD-ROM', '85.00', 15, 4),
(7, 'Mitsumi 24', 'CD-ROM', '78.00', 8, 4);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `bestelldetails`
--

CREATE TABLE IF NOT EXISTS `bestelldetails` (
  `B_Nr` int(11) DEFAULT '0',
  `A_Nr` int(11) DEFAULT '0',
  `B_Menge` int(11) DEFAULT '0',
  KEY `A_Nr` (`A_Nr`),
  KEY `B_Nr` (`B_Nr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `bestelldetails`
--

INSERT INTO `bestelldetails` (`B_Nr`, `A_Nr`, `B_Menge`) VALUES
(1, 1, 2),
(1, 2, 7),
(1, 3, 1),
(2, 4, 1),
(3, 5, 4),
(4, 6, 2),
(5, 7, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `bestellungen`
--

CREATE TABLE IF NOT EXISTS `bestellungen` (
  `B_Nr` int(11) NOT NULL DEFAULT '0',
  `B_Datum` datetime DEFAULT NULL,
  `B_Lieferdatum` datetime DEFAULT NULL,
  `B_Erledigt` boolean DEFAULT '0',
  `B_Rechnung` boolean DEFAULT '0',
  `K_Nr` int(11) DEFAULT '0',
  PRIMARY KEY (`B_Nr`),
  KEY `K_Nr` (`K_Nr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `bestellungen`
--

INSERT INTO `bestellungen` (`B_Nr`, `B_Datum`, `B_Lieferdatum`, `B_Erledigt`, `B_Rechnung`, `K_Nr`) VALUES
(1, '1998-09-23 00:00:00', '1998-10-07 00:00:00', 0, 0, 5),
(2, '1998-09-23 00:00:00', '1998-10-10 00:00:00', 0, 0, 5),
(3, '1998-09-23 00:00:00', '1998-10-01 00:00:00', 0, 0, 5),
(4, '1998-09-24 00:00:00', '1998-10-14 00:00:00', 0, 0, 6),
(5, '1998-09-25 00:00:00', '1998-10-16 00:00:00', 0, 0, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `kunden`
--

CREATE TABLE IF NOT EXISTS `kunden` (
  `K_Nr` int(11) NOT NULL DEFAULT '0',
  `K_Name` varchar(30) DEFAULT NULL,
  `K_Vorname` varchar(20) DEFAULT NULL,
  `K_Strasse` varchar(30) DEFAULT NULL,
  `K_PLZ` varchar(10) DEFAULT NULL,
  `K_Ort` varchar(30) DEFAULT NULL,
  `K_Telefon` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`K_Nr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `kunden`
--

INSERT INTO `kunden` (`K_Nr`, `K_Name`, `K_Vorname`, `K_Strasse`, `K_PLZ`, `K_Ort`, `K_Telefon`) VALUES
(1, 'Schwab ', 'Christoph', 'Fasanenweg', '90600', 'Nürnberg', NULL),
(5, 'Hintersteiner ', 'Xaver', 'Platz 8', '89000', 'München', '089-4444444'),
(6, 'Lohmeier', 'Karin', 'Hohlweg 18', '89445', 'Frötmaning', '089-445588');

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `artikel`
--
ALTER TABLE `artikel`
  ADD CONSTRAINT `artikel_ibfk_1` FOREIGN KEY (`A_Nr`) REFERENCES `bestelldetails` (`A_Nr`);

--
-- Constraints der Tabelle `bestelldetails`
--
ALTER TABLE `bestelldetails`
  ADD CONSTRAINT `bestelldetails_ibfk_1` FOREIGN KEY (`B_Nr`) REFERENCES `bestellungen` (`B_Nr`);

--
-- Constraints der Tabelle `kunden`
--
ALTER TABLE `kunden`
  ADD CONSTRAINT `kunden_ibfk_1` FOREIGN KEY (`K_Nr`) REFERENCES `bestellungen` (`K_Nr`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
