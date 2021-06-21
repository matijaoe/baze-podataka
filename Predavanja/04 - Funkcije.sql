/*String funkcije*/

/*Funkcija LENGTH:*/
SELECT LENGTH('12345');

/*Funkcija CONCAT*/
SELECT CONCAT('12345', '67', '8', '9', '0123');

/*Funkcija CONCAT_WS*/
SELECT CONCAT_WS(', ', 'Upit je vratio 54', '57', '58', '65');

/*Funkcija INSERT*/
SELECT INSERT('123456', 3, 2, 'XYZA');

/*Funkcija LOWER*/
SELECT LOWER('ABCDefghIJKlm1234zŽ');

/*Funkcija UPPER*/
SELECT UPPER('ABCDefghIJKlm1234zŽ');

/*Funkcija LEFT*/
SELECT LEFT('ABCDefghIJKlm1234zŽ', 5);

/*Funkcija RIGHT*/
SELECT RIGHT('ABCDefghIJKlm1234zŽ', 5);

/*Funkcija SUBSTRING*/
SELECT SUBSTRING('ABCDefghIJKlm1234zŽ', 2, 5);
SELECT SUBSTRING('ABCDefghIJKlm1234zŽ' FROM 2 FOR 5);

/*Funkcija SUBSTRING bez len*/
SELECT SUBSTRING('ABCDefghIJKlm1234zŽ', 2);
SELECT SUBSTRING('ABCDefghIJKlm1234zŽ' FROM 2);

/*Funkcija TRIM*/
SELECT TRIM(BOTH FROM '     neki čudan tekst   s razmacima     ');
SELECT TRIM(TRAILING FROM '     neki čudan tekst   s razmacima     ');
SELECT TRIM(LEADING FROM '     neki čudan tekst   s razmacima     ');

/*Funkcija TRIM*/
SELECT TRIM(LEADING '.' FROM ' .   neki čudan .tekst.  abc......');

SELECT TRIM(TRAILING '.' FROM ' .   neki čudan .tekst.  abc......');

/*Funkcija REPLACE*/
SELECT REPLACE('Danas je lijep dan', 'je lijep', 'nije ružan');



/*Primjeri string funkcija na bazi podataka*/

/*Potrebno je ispisati inicijale svih studenata u jednoj koloni:*/
SELECT CONCAT(LEFT(ime, 1), '.', LEFT(prezime, 1), '.')
FROM studenti;

/*Potrebno je ispisati prvo slovo imena i zadnje slovo prezimena svih 
studenata u jednoj koloni
  Oba slova moraju biti ispisana velikim slovima.*/
SELECT UPPER(CONCAT(LEFT(ime, 1), RIGHT(prezime, 1)))
FROM studenti;

/*
Potrebno je ispisati imena, prezimena i poštanske brojeve
prebivanja svih studenata u jednoj koloni odvojene zarezom.
Ime i prezime potrebno je napisati velikim slovima.*/

SELECT UPPER(CONCAT(ime, ', ', prezime, ', ', postBrPrebivanje))
FROM studenti;

#ili:

SELECT UPPER(CONCAT_WS(', ', ime, prezime, postBrPrebivanje))
FROM studenti;


/*Potrebno je prikazati dan i mjesec rođenja klijenta*/

SELECT SUBSTRING(jmbgKlijent, 1, 2), SUBSTRING(jmbgKlijent, 3, 2)
FROM klijent;

#u jednoj koloni:

SELECT CONCAT(SUBSTRING(jmbgKlijent, 1, 2), '.', SUBSTRING(jmbgKlijent, 3, 2), '.')
FROM klijent;

# SELECT CONCAT(LEFT(jmbgKlijent, 2),'.', SUBSTRING(jmbgKlijent, 3, 2),'.')
# FROM klijent;


/*Potrebno je ispisati sva prezimena studenata na način da se ne prikazuju mali dijakritički znakovi*/
SELECT REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(prezime, 'č', 'c'), 'ć', 'c'), 'š', 's'), 'đ', 'd'), 'ž', 'z')
FROM studenti;

SELECT ime, prezime
FROM studenti
WHERE prezime = 'krog';


#malo neurednosti sa svim dijakritičkim znakovima:

/*Potrebno je ispisati sva prezimena studenata na način da se ne prikazuju dijakritički znakovi*/
SELECT REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                                                               REPLACE(REPLACE(REPLACE(prezime, 'č', 'c'), 'ć', 'c'), 'š', 's'),
                                                               'đ', 'd'), 'ž', 'z'), 'Č', 'C'), 'Ć', 'C'), 'Š', 'S'),
                       'Đ', 'D'), 'Ž', 'Z')
FROM studenti;


/*Potrebno je ispisati drugo slovo imena i drugo slovo prezimena svakog klijenta u jednoj koloni*/
SELECT CONCAT(SUBSTRING(imeKlijent, 2, 1), SUBSTRING(prezimeKlijent, 2, 1))
FROM klijent;



/*Agregatne funkcije*/


/*Potrebno je ispisati prosječan koeficijent plaća radnika*/
SELECT AVG(koefPlaca)
FROM radnik;


/*Potrebno je ispisati prosječnu plaću radnika*/
SELECT AVG(koefPlaca * iznosOsnovice)
FROM radnik;


/*Potrebno je ispisati prosječne plaće radnika koji imaju poštanski broj 10000*/
SELECT AVG(KoefPlaca * IznosOsnovice)
FROM radnik
WHERE pbrStan = 10000;


/*potrebno je ispisati ukupan broj radnika*/
SELECT COUNT(sifRadnik)
FROM radnik;


/*potrebno je ispisati ukupan broj unikatnih imena radnika*/
SELECT COUNT(DISTINCT imeRadnik)
FROM radnik;


/*potrebno je ispisati ukupan broj klijenata*/
SELECT COUNT(sifKlijent)
FROM klijent;


/*Potrebno je ispisati minimalnu plaću radnika*/
SELECT MIN(koefPlaca * iznosOsnovice)
FROM radnik;


/*Potrebno je ispisati maksimalnu plaću radnika*/
SELECT MAX(koefPlaca * iznosOsnovice)
FROM radnik;


/*Potrebno je ispisati ukupne troškove plaća radnika*/
SELECT SUM(koefPlaca * iznosOsnovice)
FROM radnik;



/*Datumske funkcije*/

/*Potrebno je ispisati umanjene datume osnutka ustanova za 30 dana*/

SELECT ADDDATE(datumOsnutka, INTERVAL -30 DAY)
FROM ustanove;

# SELECT ADDDATE(datumOsnutka, -30)
# FROM ustanove;

#ili:

SELECT SUBDATE(datumOsnutka, INTERVAL 30 DAY)
FROM ustanove;


/*Potrebno je ispisati umanjene datume osnutka ustanova za godinu dana*/

SELECT ADDDATE(datumOsnutka, INTERVAL -1 YEAR)
FROM ustanove;

#ili:

SELECT SUBDATE(datumOsnutka, INTERVAL 1 YEAR)
FROM ustanove;


/*Potrebno je ispisati uvećane datume osnutka ustanova za tri mjeseca*/

SELECT ADDDATE(datumOsnutka, INTERVAL 3 MONTH)
FROM ustanove;

#ili:

SELECT SUBDATE(datumOsnutka, INTERVAL -3 MONTH)
FROM ustanove;


/*Potrebno je prikazati trenutno vrijeme na poslužitelju*/

SELECT CURTIME();
SELECT CURRENT_TIME();
SELECT CURRENT_TIME;

/*Potrebno je prikazati trenutni datum na poslužitelju*/

SELECT CURDATE();
SELECT CURRENT_DATE();
SELECT CURRENT_DATE;


/*Potrebno je prikazati trenutni datum i vrijeme (DATETIME tip podatka) na poslužitelju*/

SELECT NOW();


/*Potrebno je ispisati koliko dana koja ustanova postoji*/

SELECT DATEDIFF(CURDATE(), datumOsnutka), naziv
FROM ustanove;


/*Potrebno je u odvojenim kolonama ispisati dan, mjesec i godinu osnutka svake ustanove*/

SELECT DAY(datumOsnutka), MONTH(datumOsnutka), YEAR(datumOsnutka)
FROM ustanove;


/*Potrebno je ispisati sve ustanove koje su osnovane u trenutnom mjesecu*/

SELECT *
FROM ustanove
WHERE MONTH(datumOsnutka) = MONTH(CURDATE());


/*Potrebno je u odvojenim kolonama ispisati sat, minute i sekunde polaganja svakog ispita*/

SELECT HOUR(vrijemePolaganja), MINUTE(vrijemePolaganja), SECOND(vrijemePolaganja)
FROM ocjene;


/*Potrebno je u odvojenim kolonama ispisati sve ispite koji su bili polagani u trenutni sat*/

SELECT *
FROM ocjene
WHERE HOUR(vrijemePolaganja) = HOUR(CURTIME());


/*Potrebno je u odvojenim kolonama ispisati dan, mjesec i godinu 
  osnutka svake ustanove pomoću EXTRACT() funkcije*/

SELECT EXTRACT(DAY FROM datumOsnutka),
       EXTRACT(MONTH FROM datumOsnutka),
       EXTRACT(YEAR FROM datumOsnutka)
FROM ustanove;


/*Potrebno je u odvojenim kolonama ispisati sat, minute i sekunde polaganja svakog ispita pomoću EXTRACT funkcije*/

SELECT EXTRACT(HOUR FROM vrijemePolaganja),
       EXTRACT(MINUTE FROM vrijemePolaganja),
       EXTRACT(SECOND FROM vrijemePolaganja)
FROM ocjene;


/*Potrebno je ispisati datum osnutka ustanove po hrvatskim standardima. Znači, "DD.MM.YYYY."*/

SELECT DATE_FORMAT(datumOsnutka, '%d.%m.%Y.')
FROM ustanove;


/*Potrebno je ispisati datum i mjesec osnutka ustanove u formatu "DD.MM."."*/

SELECT DATE_FORMAT(datumOsnutka, '%d.%m.')
FROM ustanove;


/*Potrebno je ispisati sve ustanove koje su osnovane na današnji datum bez obzira na godinu*/

SELECT *
FROM ustanove
WHERE DATE_FORMAT(datumOsnutka, '%d%m') = DATE_FORMAT(CURDATE(), '%d%m');


/*Potrebno je iz JMBG-a nastavnika ispisati datume njihovih rođenja.*/

SELECT STR_TO_DATE(jmbg, '%d%m9%y')
FROM nastavnici;


#Zašto je krivo, i koja je godina prijelazna?
SELECT STR_TO_DATE('311269', '%d%m%y');

SELECT STR_TO_DATE('010170', '%d%m%y');



/*Ostale funkcije*/

/*Potrebno je provjeriti korisničku šifru nastavnika uz JMBG (za login npr.)*/

SELECT *
FROM nastavnici
WHERE jmbg = '0205951330124'
  AND lozinka = MD5('VedranGrubišić');

/*Pogrešna lozinka:*/
SELECT *
FROM nastavnici
WHERE jmbg = '0205951330124'
  AND lozinka = MD5('12345');


/*Potrebno je kriptirati JMBG pomoću AES algoritma:*/
SELECT AES_ENCRYPT(jmbg, 'Neki key')
FROM nastavnici;

/*Enkriptiranje i dekriptiranje*/
SELECT AES_DECRYPT(AES_ENCRYPT(jmbg, 'Neki key'), 'Neki key')
FROM nastavnici;


/*Cast, tj. pretvaranje jednog tipa podatka u drugi tip podatka*/
SELECT CAST('1234567890' AS CHAR(5));


/*IFNULL() funkcija*/

SELECT IFNULL(NULL, 'ja sam null');

SELECT IFNULL('ja nisam null', 'ja sam null');


SELECT odjel.nazivOdjel, IFNULL(sifNadOdjel, 'ja nemam nadodjel'), sifOdjel, sifNadOdjel
FROM odjel;


/*Samo za primjer vlastite funkcije. To će se raditi na bazama 2!*/

CREATE FUNCTION hello(s CHAR(20))
    RETURNS CHAR(50) DETERMINISTIC
    RETURN CONCAT('Pozdrav ', s, '!');


SELECT hello('Marko');


DROP FUNCTION hello;



/*Aliasi*/

/*Potrebno je ispisati ukupne troškove plaća radnika*/
SELECT SUM(koefPlaca * iznosOsnovice) AS troskovi
FROM radnik;

# ili:

SELECT SUM(koefPlaca * iznosOsnovice) troskovi
FROM radnik;

# više riječi:

SELECT SUM(koefPlaca * iznosOsnovice) AS 'troskovi radnika'
FROM radnik;

