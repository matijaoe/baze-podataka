/* 1.	Potrebno je napisati SQL naredbu koja će kreirati tablicu naziva "album" s navedenim kolonama:
sifAlbum tipa int,
naslov tipa varchar(150),
izvodjac tipa varchar(170),
trajanjeMin tipa decimal(5, 2),
zanr tipa int.
*/

CREATE TABLE album (
	sifAlbum INT,
	naslov VARCHAR(150),
	izvodjac VARCHAR(170),
	trajanjeMin DECIMAL(5, 2),
	zanr INT
);

/* 2.	U bazi radionice: Potrebno je napisati SQL naredbu koja će promijeniti tablicu naziva 
"nalog" na način da se obriše atribut "prioritetNalog", a atributu "OstvareniSatiRada" promjeni 
naziv u "SatiRada". */

ALTER TABLE nalog
DROP COLUMN prioritetNalog,
CHANGE COLUMN OstvareniSatiRada SatiRada INT(11);

/* 3.	U bazi studenti: Potrebno je izmijeniti tablicu "nastavnici" tako da se izbriše atribut "titulaIza",
 a atributu "titulaIspred" promjeni naziv u "titula". */
 
ALTER TABLE nastavnici
DROP COLUMN titulaIza,
CHANGE COLUMN titulaIspred titula VARCHAR(30);

/* 4.	U bazi radionice: Potrebno je napisati SQL upit koji će obrisati sve podatke iz tablice "klijent". */

DELETE FROM klijent;

/* 5.	U bazi radionice: Potrebno je napisati SQL upit koji će obrisati tablicu "klijent". */

DROP TABLE klijent;

/* 6.	U bazi studenti: Potrebno je obrisat sve podatke iz tablice "ocjene" i samu tablicu. */

DROP TABLE ocjene;

/* 7.	U bazi radionice: Potrebno je unijeti novi kvar naziva "Kvačilo" kojeg će popravljati odjel 6 i 
na kojem će raditi 2 radnika. Ostale podatke je potrebno samostalno izmisliti. */

INSERT INTO kvar VALUES(37, 'Kvačilo', 6, 2, 3);
/* ili */
INSERT INTO kvar (sifKvar, nazivKvar, sifOdjel, brojradnika, satiKvar) 
VALUES (37, 'Kvačilo', 6, 2, 3);

/* 8.	U bazi studenti: Potrebno je unijeti novi smjer s proizvoljnim podacima. */

INSERT INTO smjerovi VALUES (28, 'Informatika', '08814003451', 23);
/* ili */
INSERT INTO smjerovi (id, naziv, oibUstanova, idNadsmjer) 
VALUES(28, 'Informatika', '08814003451', 23);

/* 9.	U bazi radionice: Potrebno je unijeti novog radnika imena "Ivan", Vašeg prezimena i koeficijenta 
plaće "1,56". Ostali se podaci ne smiju unijeti. */

INSERT INTO radnik (imeRadnik, prezimeRadnik, KoefPlaca)
VALUES ('Ivan', 'Kovačević', 1.56);
	
/* 10.	U bazi radionice: Potrebno je ispisati imena i prezimena svih klijenata. */

SELECT imeKlijent, prezimeKlijent FROM klijent;

/* 11.	U bazi radionice: Potrebno je ispisati sve vrijednosti iz tablice "odjel". */

SELECT * FROM odjel;

/* 12.	U bazi radionice: Potrebno je napisati SQL upit koji će svim klijentima promijeniti ime u "Ivan" 
a prezime u "Kovačević". */

UPDATE klijent
SET imeKlijent = 'Ivan',
    prezimeKlijent = 'Kovačević';

/* 13.	U bazi studenti: Potrebno je napisati SQL upit koji će svim smjerovima promijenit naziv u 
"informatika". */

UPDATE smjerovi
SET naziv = 'informatika';

/* 14.	U bazi radionice: Potrebno je napisati SQL upit koji će svim radnicima promijeniti "koefPlaca" 
na način da bude veći za 1. */

UPDATE radnik
SET KoefPlaca = KoefPlaca + 1;