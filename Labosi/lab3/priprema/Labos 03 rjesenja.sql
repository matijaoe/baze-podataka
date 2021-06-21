/*U bazi radionice: Ispišite maksimalan iznos koeficijenta plaće iz tablice radnik.*/
SELECT MAX(koefPlaca) FROM radnik;



/*U bazi studenti: Potrebno je ispisati najmanju ocjenu studenta sa jmbag-om 0128055514.*/
SELECT MIN(ocjena) 
FROM ocjene
WHERE jmbagStudent = '0128055514';


/*U bazi radionice: Potrebno je ispisati imena i prezimena svih klijenata velikim slovima i 
u jednoj koloni. Npr ukoliko je klijentu ime "Ivan", a prezime "Horvat" potrebno ga je 
ispisati kao "IVAN HORVAT".*/
SELECT UPPER(CONCAT(imeKlijent, ' ', prezimeKlijent))
FROM klijent;


/*U bazi radionice: Potrebno je ispisati inicijale svih radnika. Na primjer, ukoliko je radniku 
ime "Ivan", a prezime "Horvat" potrebno je ispisati "I.H.".*/
SELECT UPPER(CONCAT(LEFT(imeRadnik, 1), '.', LEFT(prezimeRadnik, 1), '.'))
FROM radnik;


/*U bazi studenti: Potrebno je ispisati nazive kolegija i od koliko se znakova sastoje.*/
SELECT naziv, LENGTH(naziv)
FROM kolegiji;


/*U bazi radionice: Potrebno je ispisati sva mjesta koja se nalaze u županiji sa šifrom 5, 8 ili 11.*/
SELECT *
FROM mjesto
WHERE sifZupanija IN (5, 8, 11);


/*U bazi studenti: Potrebno je ispisati koliko studenta je upisano na smjer sa id=1.*/
SELECT COUNT(*)
FROM studenti
WHERE idSmjer = 1;


/*U bazi studenti: Potrebno je ispisati one studente kojima jmbag počinje sa 119.*/
SELECT *
FROM studenti
WHERE jmbag LIKE '119%';


/*U bazi radionice: Potrebno je ispisati sve klijente koji imaju jednaku duljinu imena i prezimena u broju znakova.*/
SELECT *
FROM klijent
WHERE LENGTH(imeKlijent) = LENGTH(prezimeKlijent);


/*U bazi studenti: Potrebno je ispisati sve nastavnike čije je prvo slovo imena i zadnje slovo prezimena jednako.*/
SELECT *
FROM nastavnici
WHERE LEFT(ime, 1) = RIGHT(prezime, 1);


