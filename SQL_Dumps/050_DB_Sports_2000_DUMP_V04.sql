-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Erstellungszeit: 15. Apr 2015 um 10:52
-- Server Version: 5.5.32
-- PHP-Version: 5.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Datenbank: `sports_2000`
--
CREATE DATABASE IF NOT EXISTS `sports_2000` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `sports_2000`;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `customer`
--

CREATE TABLE IF NOT EXISTS `customer` (
  `custid` int(11) NOT NULL DEFAULT '0',
  `name` varchar(50) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `zip` varchar(50) DEFAULT NULL,
  `area` int(11) DEFAULT '0',
  `phone` varchar(50) DEFAULT NULL,
  `repid` int(11) DEFAULT '0',
  `creditlimit` decimal(19,4) DEFAULT '0.0000',
  `comments` text,
  PRIMARY KEY (`custid`),
  KEY `custid` (`custid`),
  KEY `repid` (`repid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `customer`
--

INSERT INTO `customer` (`custid`, `name`, `address`, `city`, `state`, `zip`, `area`, `phone`, `repid`, `creditlimit`, `comments`) VALUES
(100, 'JOCKSPORTS', '345 VIEWRIDGE', 'BELMONT', 'CA', '96711', 415, '598-6609', 7844, '5000.0000', 'Very friendly people to work with -- sales rep likes to be called Mike.'),
(101, 'TKB SPORT SHOP', '490 BOLI RD.', 'REDWOOD CITY', 'CA', '94061', 415, '368-1223', 7521, '10000.0000', 'Rep called 5/8 about change in order - contact shipping.'),
(102, 'VOLLYRITE', '9722 HAMILTON', 'BURLINGAME', 'CA', '95133', 415, '644-3341', 7654, '7000.0000', 'Company doing heavy promotion beginning 10/89.'),
(103, 'JUST TENNIS', 'HILLVIEW MALL', 'BURLINGAME', 'CA', '97544', 415, '677-9312', 7521, '3000.0000', 'Contact rep about new line of tennis rackets.'),
(104, 'EVERY MOUNTAIN', '574 SURRY RD.', 'CUPERTINO', 'CA', '93301           ', 408, '996-2323', 7499, '10000.0000', 'Customer with high market share (23%) due to aggressive advertising.'),
(105, 'K + T SPORTS', '3476 EL PASO', 'SANTA CLARA', 'CA', '91003', 408, '376-9966', 7844, '5000.0000', 'Tends to order large amounts of merchandise at once.'),
(106, 'SHAPE UP', '908 SEQUOIA', 'PALO ALTO', 'CA', '94301', 415, '364-9777', 7521, '6000.0000', 'Support intensive. Orders small amounts (< 800) of merchandise at a time.'),
(107, 'WOMENS SPORTS', 'VALCO VILLAGE', 'SUNNYVALE', 'CA', '93301', 408, '967-4398', 7499, '10000.0000', 'First sporting goods store geared exclusively towards women. Unusual promotion.'),
(108, 'NORTH WOODS HEALTH AND FITNESS SUPPLY CENTER', '98 LONE PINE WAY', 'HIBBING', 'MN', '55649', 612, '566-9123', 7844, '8000.0000', NULL);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `dept`
--

CREATE TABLE IF NOT EXISTS `dept` (
  `deptno` int(11) NOT NULL DEFAULT '0',
  `dname` varchar(50) DEFAULT NULL,
  `loc` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`deptno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `dept`
--

INSERT INTO `dept` (`deptno`, `dname`, `loc`) VALUES
(10, 'ACCOUNTING', 'NEW YORK'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO'),
(40, 'OPERATIONS', 'BOSTON');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `emp`
--

CREATE TABLE IF NOT EXISTS `emp` (
  `empno` int(11) NOT NULL DEFAULT '0',
  `ename` varchar(50) DEFAULT NULL,
  `job` varchar(50) DEFAULT NULL,
  `mgr` int(11) DEFAULT '0',
  `hiredate` datetime DEFAULT NULL,
  `sal` decimal(19,4) DEFAULT '0.0000',
  `comm` decimal(19,4) DEFAULT '0.0000',
  `deptno` int(11) DEFAULT '0',
  PRIMARY KEY (`empno`),
  KEY `mgr` (`mgr`),
  KEY `FK_FEPTNO` (`deptno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `emp`
--

INSERT INTO `emp` (`empno`, `ename`, `job`, `mgr`, `hiredate`, `sal`, `comm`, `deptno`) VALUES
(7369, 'SMITH', 'CLERK', 7902, '1980-12-17 00:00:00', '800.0000', '0.0000', 20),
(7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20 00:00:00', '1600.0000', '300.0000', 30),
(7521, 'WARD', 'SALESMAN', 7698, '1981-02-22 00:00:00', '1250.0000', '500.0000', 30),
(7566, 'JONES', 'MANAGER', 7839, '1981-04-02 00:00:00', '2975.0000', '0.0000', 20),
(7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28 00:00:00', '1250.0000', '1400.0000', 30),
(7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01 00:00:00', '2850.0000', '0.0000', 30),
(7782, 'CLARK', 'MANAGER', 7839, '1981-06-09 00:00:00', '2450.0000', '0.0000', 10),
(7788, 'SCOTT', 'ANALYST', 7566, '1982-12-09 00:00:00', '3000.0000', '0.0000', 20),
(7839, 'KING', 'PRESIDENT', 0, '1981-11-17 00:00:00', '5000.0000', '0.0000', 10),
(7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08 00:00:00', '1500.0000', '0.0000', 30),
(7876, 'ADAMS', 'CLERK', 7788, '1983-01-12 00:00:00', '1100.0000', '0.0000', 20),
(7900, 'JAMES', 'CLERK', 7698, '1981-12-03 00:00:00', '950.0000', '0.0000', 30),
(7902, 'FORD', 'ANALYST', 7566, '1981-12-03 00:00:00', '3000.0000', '0.0000', 20),
(7934, 'MILLER', 'CLERK', 7782, '1982-01-23 00:00:00', '1300.0000', '0.0000', 10);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `item`
--

CREATE TABLE IF NOT EXISTS `item` (
  `ordid` int(11) NOT NULL DEFAULT '0',
  `prodid` int(11) DEFAULT '0',
  `itemid` int(11) NOT NULL DEFAULT '0',
  `actualprice` decimal(19,4) DEFAULT '0.0000',
  `qty` int(11) DEFAULT '0',
  `itemtot` decimal(19,4) DEFAULT '0.0000',
  PRIMARY KEY (`ordid`,`itemid`),
  KEY `itemid` (`itemid`),
  KEY `ordid` (`ordid`),
  KEY `prodid` (`prodid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `item`
--

INSERT INTO `item` (`ordid`, `prodid`, `itemid`, `actualprice`, `qty`, `itemtot`) VALUES
(601, 200376, 1, '2.4000', 1, '2.4000'),
(602, 100870, 1, '2.8000', 20, '56.0000'),
(603, 100860, 2, '56.0000', 4, '224.0000'),
(604, 100890, 1, '58.0000', 3, '174.0000'),
(604, 100861, 2, '42.0000', 2, '84.0000'),
(604, 100860, 3, '44.0000', 10, '440.0000'),
(605, 100861, 1, '45.0000', 100, '4500.0000'),
(605, 100870, 2, '2.8000', 500, '1400.0000'),
(605, 100890, 3, '58.0000', 5, '290.0000'),
(605, 101860, 4, '24.0000', 50, '1200.0000'),
(605, 101863, 5, '9.0000', 100, '900.0000'),
(605, 102130, 6, '3.4000', 10, '34.0000'),
(606, 102130, 1, '3.4000', 1, '3.4000'),
(607, 100871, 1, '5.6000', 1, '5.6000'),
(608, 101860, 1, '24.0000', 1, '24.0000'),
(608, 100871, 2, '5.6000', 2, '11.2000'),
(609, 100861, 1, '35.0000', 1, '35.0000'),
(609, 100870, 2, '2.5000', 5, '12.5000'),
(609, 100890, 3, '50.0000', 1, '50.0000'),
(610, 100860, 1, '35.0000', 1, '35.0000'),
(610, 100870, 2, '2.8000', 3, '8.4000'),
(610, 100890, 3, '58.0000', 1, '58.0000'),
(611, 100861, 1, '45.0000', 1, '45.0000'),
(612, 100860, 1, '30.0000', 100, '3000.0000'),
(612, 100861, 2, '40.5000', 20, '810.0000'),
(612, 101863, 3, '10.0000', 150, '1500.0000'),
(612, 100871, 4, '5.5000', 100, '550.0000'),
(613, 100871, 1, '5.6000', 100, '560.0000'),
(613, 101860, 2, '24.0000', 200, '4800.0000'),
(613, 200380, 3, '4.0000', 150, '600.0000'),
(613, 200376, 4, '2.2000', 200, '400.0000'),
(614, 100860, 1, '35.0000', 444, '15540.0000'),
(614, 100870, 2, '2.8000', 1000, '2800.0000'),
(614, 100871, 3, '5.6000', 1000, '5600.0000'),
(615, 100861, 1, '45.0000', 4, '180.0000'),
(615, 100870, 2, '2.8000', 100, '280.0000'),
(615, 100871, 3, '5.0000', 50, '250.0000'),
(616, 100870, 1, '45.0000', 10, '450.0000'),
(616, 100870, 2, '2.8000', 50, '140.0000'),
(616, 100890, 3, '58.0000', 2, '116.0000'),
(616, 102130, 4, '3.4000', 10, '34.0000'),
(616, 200376, 5, '2.4000', 10, '24.0000'),
(617, 100860, 1, '35.0000', 50, '1750.0000'),
(617, 100861, 2, '45.0000', 100, '4500.0000'),
(617, 100870, 3, '2.8000', 500, '1400.0000'),
(617, 100871, 4, '5.6000', 500, '2800.0000'),
(617, 100890, 5, '58.0000', 500, '29000.0000'),
(617, 101860, 6, '24.0000', 100, '2400.0000'),
(617, 101863, 7, '12.5000', 200, '2500.0000'),
(617, 102130, 8, '3.4000', 100, '340.0000'),
(617, 200376, 9, '2.4000', 200, '480.0000'),
(617, 200380, 10, '4.0000', 300, '1200.0000'),
(618, 100860, 1, '35.0000', 23, '805.0000'),
(618, 100861, 2, '45.1100', 50, '2255.5000'),
(618, 100870, 3, '45.0000', 10, '450.0000'),
(619, 200380, 1, '4.0000', 100, '400.0000'),
(619, 200376, 2, '2.4000', 100, '240.0000'),
(619, 102130, 3, '3.4000', 100, '340.0000'),
(619, 100871, 4, '5.6000', 50, '280.0000'),
(620, 100860, 1, '35.0000', 10, '350.0000'),
(620, 200376, 2, '2.4000', 1000, '2400.0000'),
(620, 102130, 3, '3.4000', 500, '1700.0000'),
(621, 100861, 1, '45.0000', 10, '450.0000'),
(621, 100870, 2, '2.8000', 100, '280.0000');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ord`
--

CREATE TABLE IF NOT EXISTS `ord` (
  `ordid` int(11) NOT NULL DEFAULT '0',
  `orderdate` datetime DEFAULT NULL,
  `commplan` varchar(50) DEFAULT NULL,
  `custid` int(11) NOT NULL DEFAULT '0',
  `shipdate` datetime DEFAULT NULL,
  `total` decimal(19,4) DEFAULT '0.0000',
  PRIMARY KEY (`ordid`),
  KEY `custid` (`custid`),
  KEY `ordid` (`ordid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `ord`
--

INSERT INTO `ord` (`ordid`, `orderdate`, `commplan`, `custid`, `shipdate`, `total`) VALUES
(601, '1986-05-01 00:00:00', 'A', 106, '1986-05-30 00:00:00', '2.4000'),
(602, '1986-06-05 00:00:00', 'B', 102, '1986-06-20 00:00:00', '56.0000'),
(603, '1986-06-05 00:00:00', NULL, 102, '1986-06-05 00:00:00', '224.0000'),
(604, '1986-06-15 00:00:00', 'A', 106, '1986-06-30 00:00:00', '698.0000'),
(605, '1986-07-14 00:00:00', 'A', 106, '1986-07-30 00:00:00', '8324.0000'),
(606, '1986-07-14 00:00:00', 'A', 100, '1986-07-30 00:00:00', '3.4000'),
(607, '1986-07-18 00:00:00', 'C', 104, '1986-07-18 00:00:00', '5.6000'),
(608, '1986-07-25 00:00:00', 'C', 104, '1986-07-25 00:00:00', '35.2000'),
(609, '1986-08-01 00:00:00', 'B', 100, '1986-08-15 00:00:00', '97.5000'),
(610, '1987-01-07 00:00:00', 'A', 101, '1987-01-08 00:00:00', '101.4000'),
(611, '1987-01-11 00:00:00', 'B', 102, '1987-01-11 00:00:00', '45.0000'),
(612, '1987-01-15 00:00:00', 'C', 104, '1987-01-20 00:00:00', '5860.0000'),
(613, '1987-02-01 00:00:00', NULL, 108, '1987-02-01 00:00:00', '6400.0000'),
(614, '1987-02-01 00:00:00', NULL, 102, '1987-02-05 00:00:00', '23940.0000'),
(615, '1987-02-01 00:00:00', NULL, 107, '1987-02-06 00:00:00', '710.0000'),
(616, '1987-02-03 00:00:00', NULL, 103, '1987-02-10 00:00:00', '764.0000'),
(617, '1987-02-05 00:00:00', NULL, 105, '1987-03-03 00:00:00', '46370.0000'),
(618, '1987-02-15 00:00:00', 'A', 102, '1987-03-06 00:00:00', '3510.5000'),
(619, '1987-02-22 00:00:00', NULL, 104, '1987-02-04 00:00:00', '1260.0000'),
(620, '1987-03-12 00:00:00', NULL, 100, '1987-03-12 00:00:00', '4450.0000'),
(621, '1987-03-15 00:00:00', 'A', 100, '1987-01-01 00:00:00', '730.0000');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `product`
--

CREATE TABLE IF NOT EXISTS `product` (
  `prodid` int(11) NOT NULL DEFAULT '0',
  `descrip` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`prodid`),
  KEY `prodid` (`prodid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `product`
--

INSERT INTO `product` (`prodid`, `descrip`) VALUES
(100860, 'ACE TENNIS RACKET I'),
(100861, 'ACE TENNIS RACKET II'),
(100870, 'ACE TENNIS BALLS-3 PACK'),
(100871, 'ACE TENNIS BALLS-6 PACK'),
(100890, 'ACE TENNIS NET'),
(101860, 'SP TENNIS RACKET'),
(101863, 'SP JUNIOR RACKET'),
(102130, 'RH: "GUIDE TO TENNIS"'),
(200376, 'SB ENERGY BAR-6 PACK'),
(200380, 'SB VITA SNACK-6 PACK');

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`repid`) REFERENCES `emp` (`empno`);

--
-- Constraints der Tabelle `emp`
--
ALTER TABLE `emp`
  ADD CONSTRAINT `FK_FEPTNO` FOREIGN KEY (`deptno`) REFERENCES `dept` (`deptno`);

--
-- Constraints der Tabelle `item`
--
ALTER TABLE `item`
  ADD CONSTRAINT `item_ibfk_2` FOREIGN KEY (`prodid`) REFERENCES `product` (`prodid`),
  ADD CONSTRAINT `item_ibfk_1` FOREIGN KEY (`ordid`) REFERENCES `ord` (`ordid`);

--
-- Constraints der Tabelle `ord`
--
ALTER TABLE `ord`
  ADD CONSTRAINT `ord_ibfk_1` FOREIGN KEY (`custid`) REFERENCES `customer` (`custid`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
