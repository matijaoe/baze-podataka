/*2 DDL naredbe*/

/*Kreiranje baze podataka*/
CREATE DATABASE sqlPredavanje;





/*Namješta bazu na kojoj se izvršavju sljedeći upiti - 
Ne smije se raditi kada se predaje na GRADER jer on generira bazu nasumičnog imena!*/
USE sqlPredavanje;





/*Kreiranje tablice zupanija*/

CREATE TABLE zupanija (
   sifZupanija INT AUTO_INCREMENT,
   naziv VARCHAR(50),   
   PRIMARY KEY sifZupanija (sifZupanija)
);

/*Kreiranje tablice mjesto koja se veže na županiju*/

CREATE TABLE mjesto (
   pbrMjesto INT,
   naziv VARCHAR(50),
   opis TEXT,
   sifZupanija INT,   
   PRIMARY KEY pbrMjesto (pbrMjesto),
   FOREIGN KEY (sifZupanija) REFERENCES  zupanija(sifZupanija)
);

/*Promjena baze*/
ALTER DATABASE sqlPredavanje 
CHARACTER SET = cp1250 
COLLATE = cp1250_croatian_ci;




/*Alter table*/

ALTER TABLE mjesto
DROP COLUMN opis,
ADD COLUMN geoX DECIMAL(7,5) DEFAULT NULL AFTER pbrMjesto,
ADD COLUMN geoY DECIMAL(7,5) DEFAULT NULL AFTER geoX,
CHANGE COLUMN naziv nazivMjesto VARCHAR(100) NOT NULL;




/*Drop table*/
DROP TABLE zupanija;








/*Drop ne radi jer se Mjesto referencira na zupaniju
  Prvo je potrebno obrisati mjesto, potom županiju! :)*/
DROP TABLE mjesto;








/*3. DML naredbe*/


/*Insert*/

/*1. način*/
INSERT INTO zupanija VALUES(1, 'Zagrebačka županija');

INSERT INTO mjesto VALUES(10000, 5, 5, 'Zagreb', 1);





/*Zašto to i nije najbolja ideja?
  Što ako dodam dodatnu kolonu u bazu?
  Hoće li upit raditi?*/

ALTER TABLE zupanija
ADD COLUMN opis TEXT DEFAULT NULL AFTER naziv;

/*Prvi pokušaj:*/
INSERT INTO zupanija VALUES(2, 'Zagrebačka županija');


/*Drugi pokušaj:*/
INSERT INTO zupanija VALUES(58, 'Zagrebačka županija', 'Neki opis');





/*2. Način (bolji način:))*/

INSERT INTO zupanija(naziv) VALUES('Zagrebačka županija');

INSERT INTO mjesto(pbrMjesto, nazivMjesto, sifZupanija)
VALUES (10002, 'Neko mjesto u zagrebačkoj zupaniji', 1);






/*Insert preko select-a*/
INSERT INTO mjesto (pbrMjesto, nazivMjesto, sifZupanija)
SELECT sifZupanija, naziv, sifZupanija FROM zupanija;











/*Select*/

/*Potrebno je ispisati sve kolone tablice mjesto*/
SELECT * FROM mjesto;

/*Potrebno je ispisati sve kolone tablice mjesto*/
SELECT mjesto.* FROM mjesto;

/*Potrebno je ispisati neke kolone određene tablice
  U ovom slučaju to su pbrMjesto i nazivMjesto*/
SELECT pbrMjesto, nazivMjesto FROM mjesto;



/*Update*/

/*Potrebno je svim mjestima promjeniti geokoordinatu X u 10*/
UPDATE mjesto
SET geoX = 10;


/*Potrebno je svim mjestima promjeniti geokoordinatu X da bude 
  veća za 2, Y da bude kao novi X - 3, a naziv mjesta u 'Mjesto1234'*/
  
UPDATE mjesto
SET geoX = geoX + 2,
    geoY = geoX - 3,
    nazivMjesto = 'Mjesto1234';
    

/*U MySQL-u je bitan poredak zbrajanja među kolonama!!!*/

UPDATE mjesto
SET geoX = 10;

UPDATE mjesto
SET geoY = geoX - 3,
    geoX = geoX + 2,
    nazivMjesto = 'Mjesto1234';



/*Delete*/

DELETE FROM zupanija;










/*Zašto upit ne radi???*/






/*Jer su stavke referencirane na
  mjesto.*/
  
/*Hoće li ovaj upit raditi?*/
DELETE FROM mjesto;







/*I počistimo za sobom... :)*/
DROP DATABASE sqlPredavanje;









/*WHERE*/

USE radionica;

/*Klasična select naredba*/
SELECT * FROM klijent;

/*ispisati sve klijente koji se zovu Davor*/
SELECT * FROM klijent
WHERE imeKlijent = 'Davor';

/*ispisati sve klijente kojima ime počinje sa slovom D*/
SELECT * FROM klijent
WHERE imeKlijent LIKE 'D%';

SELECT * FROM klijent
WHERE imeKlijent REGEXP '^D.*$';

SELECT * FROM klijent
WHERE imeKlijent REGEXP '^D';





/*Loša praksa! Funkcije ćemo raditi sljedeći puta. Rade puno sporije od LIKE*/
SELECT * FROM klijent
WHERE LEFT(imeKlijent, 1) = 'D';


/*ispisati sve klijente kojima ime počinje sa slovom D 
  i pbrKlijent im je 10000*/
SELECT * FROM klijent
WHERE (imeKlijent LIKE 'D%')
  AND (pbrKlijent = 10000);

  
  
 /*ispisati sve klijente kojima ime počinje sa slovom D 
  i pbrKlijent im je 10000 ili 42000*/
SELECT * FROM klijent
WHERE (imeKlijent LIKE 'D%')
  AND ((pbrKlijent = 10000) OR (pbrklijent = 42000));
  
  
  
  
  
 /*što se dogodi ako maknem zagradu iza AND?*/
SELECT * FROM klijent
WHERE (imeKlijent LIKE 'D%')
  AND ((pbrKlijent = 10000) 
   OR (pbrklijent = 42000));





/*Može se i ovako napisati*/
SELECT * FROM klijent
WHERE (imeKlijent LIKE 'D%')
  AND pbrKlijent IN (10000, 42000);
  
  
  
  
  
  
  
  
/*Potrebno je ispisati sve klijente koji imaju poštanski broj 
  stanovanja između 10000 i 30000 (uključivo) */
SELECT * FROM klijent
WHERE pbrKlijent BETWEEN 10000 AND 30000;



/*update i delete where*/


/*Klijentu Tihomiru Crnkoviću promjeniti poštanski broj registracije na 10360*/
UPDATE klijent
SET pbrReg = 10360
WHERE imeKlijent = 'Tihomir' AND
      prezimeKlijent = 'Crnković';
      
      
      
      

/*Dva komada, pa kako?*/
SELECT * FROM klijent
WHERE imeKlijent = 'Tihomir' AND
      prezimeKlijent = 'Crnković';
      
      
      
      
/*Za promjene (u pravom slučaju) je najbolje koristiti primarni ključ
kako ne bi došlo do neželjenih promjena podataka na bazi*/
UPDATE klijent
SET pbrReg = 10000
WHERE sifKlijent = 1238;





/*Potrebno je obrisati sve kvarove na kojima je radilo manje od 2 radnika*/
DELETE FROM kvar
WHERE brojRadnika < 2;


/* nece radit log zapis za svaki red nego samo jedan log za brisanje svih redaka */
TRUNCATE TABLE radnik;

     