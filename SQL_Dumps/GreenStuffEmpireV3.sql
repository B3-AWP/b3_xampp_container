DROP DATABASE IF EXISTS `GreenStuffEmpire`;
CREATE DATABASE `GreenStuffEmpire` DEFAULT CHARACTER SET utf8 COLLATE utf8_swedish_ci;
USE GreenStuffEmpire;

CREATE TABLE kunde( 
	KndNr INT PRIMARY KEY AUTO_INCREMENT, 
	Vorname VARCHAR(64),
	Nachname VARCHAR(64),
	Strasse VARCHAR(64),
	Wohnort VARCHAR(64)
	);
	 
CREATE TABLE bestellung(
	BstNr INT PRIMARY KEY AUTO_INCREMENT,
	KndNr INT, 
	BstDatum DATETIME,
	CONSTRAINT FK_Kunde 
        	FOREIGN KEY (KndNr) REFERENCES kunde(KndNr) 
	);

CREATE TABLE lagerplatz(
	LagerID int PRIMARY KEY AUTO_INCREMENT,
	Regalnummer int,
	Fachnummer int
	);

CREATE TABLE artikel(
	ArtNr int PRIMARY KEY AUTO_INCREMENT,
	Bezeichnung VARCHAR(128),
	Preis DECIMAL(10,2),
	LagerID int,
	Bestand int,
	CONSTRAINT FK_Lagerplatz
		FOREIGN KEY (LagerID) REFERENCES lagerplatz(LagerID)
	);

CREATE TABLE bestellposition(
	BstNr int,
	ArtNr int,
	Menge int,
	PRIMARY KEY(BstNr, ArtNr),
	CONSTRAINT FK_Bestellung
		FOREIGN KEY (BstNr) REFERENCES bestellung(BstNr),
	CONSTRAINT FK_Artikel
		FOREIGN KEY (ArtNr) REFERENCES artikel(ArtNr)
	);

INSERT INTO kunde(Vorname,Nachname,Strasse,Wohnort) VALUES
	('Klaus','Kuno','Brunnengasse 12','12345 Marktstadt'),
	('Johanna','Carilis','Nebelstr. 34','23456 Niederstett'),
	('Kim','Nguyen','Schillerstr. 11','34567 Lohstatt'),
	('Kara','Altan','Ahornweg 3','45678 Oberdorf'),
	('Timo','Zimmermann','Torweg 1','15342 Kleinstadt'),
	('John','Weller','Dunststr. 25','27416 Grossdorf'),
	('Carmen','Diaz','Goethestr. 33','40567 Oststadt'),
	('Marek','Aldogan','Eichenweg 6','41583 Nordstadt');

INSERT INTO lagerplatz(Regalnummer, Fachnummer) VALUES
	(1,1),
	(1,2),
	(1,3),
	(1,4),
	(2,1),
	(2,2),
	(2,3),
	(2,4),
	(3,1),
	(3,2),
	(3,3),
	(3,4);

INSERT INTO artikel(Bezeichnung,Preis,LagerID,Bestand) VALUES
	('Bambus Schale',10.0,1,85),
	('Glas Strohhalme',8.0,2,88),
	('Bambus Zahnbürste',6.0,3,87),
	('Edelstahl Brotdose',20.0,4,88),
	('Bambus Teller',8.0,5,95),
	('Hanf Pullover',36.0,6,95),
	('Jutebeutel',3.0,7,94),
	('Kokos Schale',15.0,8,96),
	('Hanf T-Shirt',24.0,9,99),
	('Bambus Besteck',15.0,10,100);

INSERT INTO bestellung(KndNr,BstDatum) VALUES
	(1,'2021-11-04 10:27:44.483'),
	(2,'2021-11-13 15:12:26.645'),
	(3,'2021-11-28 09:53:38.583'),
	(4,'2021-12-03 13:22:45.453'),
	(5,'2021-12-12 23:01:16.145'),
	(4,'2021-12-17 08:33:28.583'),
	(6,'2021-12-27 17:57:22.183'),
	(5,'2022-01-04 10:16:23.245'),
	(1,'2022-01-11 13:22:18.553'),
	(1,'2022-01-23 09:57:44.443'),
	(8,'2022-02-01 18:12:23.685'),
	(2,'2022-02-02 09:23:58.583');

INSERT INTO bestellposition(BstNr,ArtNr,Menge) VALUES
	(1,1,2),
	(1,3,3),
	(2,4,1),
	(3,2,2),
	(4,1,3),
	(4,3,2),
	(4,9,1),
	(5,4,2),
	(6,4,3),
	(6,7,2),
	(7,1,4),
	(7,8,1),
	(8,3,3),
	(8,4,3),
	(8,5,1),
	(9,1,2),
	(9,3,2),
	(9,4,1),
	(9,7,2),
	(10,1,4),
	(10,2,5),
	(10,3,2),
	(10,4,1),
	(10,6,3),
	(10,8,3),
	(11,2,2),
	(11,4,1),
	(11,5,4),
	(11,7,2),
	(12,2,3),
	(12,3,1),
	(12,6,2);