/*NULL vrijednosti*/

/*Unijeti zapis u tablicu županija tako da se za šifru 
unese vrijednost 22, a da naziv županije poprimi NULL vrijednost.*/
INSERT INTO zupanija
VALUES (22, NULL);
/*Loša praksa*/
#ili
INSERT INTO zupanija(sifzupanija)
VALUES (23);
#ili
INSERT INTO zupanija
SET sifzupanija=22;
/*(ružno) :)*/


/*Postaviti NULL vrijednost za naziv županije sa šifrom 1.*/
UPDATE zupanija
SET nazivZupanija=NULL
WHERE sifZupanija = 1;

/*Postaviti NULL vrijednost za koefPlaca koje su manje od 1*/
UPDATE radnik
SET koefPlaca=NULL
WHERE koefPlaca < 1;

/*ispisati plaće radnika*/
SELECT radnik.*, (koefPlaca * iznosOsnovice)
FROM radnik;

/*ispisati plaće radnika. Ako su vrijednosti null, koristiti 1 za koefPlace*/
SELECT radnik.*, (IFNULL(koefPlaca, 1) * iznosOsnovice)
FROM radnik;


/*ispisati sve radnike koje imaju null vrijednost koefPlace*/
SELECT *
FROM radnik
WHERE koefPlaca IS NULL;


/*Ovo je neispravno!*/
SELECT *
FROM radnik
WHERE koefPlaca = NULL;


/*ispisati sve radnike koje nemaju null vrijednost koefPlace*/
SELECT *
FROM radnik
WHERE koefPlaca IS NOT NULL;


/*Ovo je neispravno!*/
SELECT *
FROM radnik
WHERE koefPlaca <> NULL;


/*Ispisati ime, prezime radnika, umnožak koeficijenta plaće i osnovice te 
koeficijent plaće za radnike kojima je koeficijent plaće između 0.4 i 1.5*/
SELECT imeRadnik, prezimeRadnik, KoefPlaca * IznosOsnovice
FROM radnik
WHERE KoefPlaca
          BETWEEN 0.4 AND 1.5;


/*Primjeri s agregatnim funkcijama*/
SELECT COUNT(*)
FROM radnik;


SELECT COUNT(*)
FROM radnik
WHERE IznosOsnovice * KoefPlaca > 0;


SELECT COUNT(koefPlaca)
FROM radnik;


SELECT SUM(IznosOsnovice)
FROM radnik;


SELECT SUM(IznosOsnovice)
FROM radnik
WHERE KoefPlaca < 1;

/*Ispisati sumu plaća radnika. Ukoliko je koefPlaca NULL, uzima se koeficijent 1*/
SELECT SUM(IFNULL(koefPlaca, 1) * IznosOsnovice)
FROM radnik;
#bez ifnull dobije se:
SELECT SUM(koefPlaca * IznosOsnovice)
FROM radnik;


/*Ispisati prezime radnika te umnožak koeficijenta plaće i iznosa osnovice za sve 
radnike kod kojih je koeficijent manji od 0.6. Ako je iznos koeficijenta NULL 
vrijednost neka je umnožak jednak 0.*/
SELECT prezimeRadnik, IFNULL(koefPlaca, 0) * IznosOsnovice
FROM radnik
WHERE IFNULL(KoefPlaca, 0) < 1;



/*ORDER BY*/


/*ispisati sve studente i sortirati ih po imenu uzlazno*/
SELECT *
FROM studenti
ORDER BY ime ASC;


/*ispisati sve studente i sortirati ih po imenu uzlazno i prezimenu uzlazno*/
SELECT *
FROM studenti
ORDER BY ime ASC, prezime ASC;


/*ispisati sve studente i sortirati ih po imenu uzlazno i prezimenu silazno*/
SELECT *
FROM studenti
ORDER BY ime ASC, prezime DESC;


UPDATE studenti
SET prezime = NULL
WHERE ime = 'Ana';

/*Ako je nešto NULL*/
SELECT *
FROM studenti
ORDER BY prezime DESC;


/*Sortiranje s krivom kolotacijom*/
SELECT *
FROM studenti
ORDER BY prezime DESC;

ALTER TABLE studenti
    CHANGE COLUMN prezime prezime VARCHAR(50) COLLATE 'cp1250_polish_ci' NULL DEFAULT NULL;

ALTER TABLE studenti
    CHANGE COLUMN prezime prezime VARCHAR(50) COLLATE 'utf8mb4_croatian_ci' NULL DEFAULT NULL;

SELECT *
FROM studenti
ORDER BY prezime DESC;


/*Distinct*/

/*Potrebno je ispisati unikatna imena svih radnika*/

SELECT DISTINCT imeRadnik
FROM radnik;

SELECT COUNT(imeRadnik), COUNT(DISTINCT imeRadnik)
FROM radnik;


/*Potrebno je ispisati imena svih studenata*/

SELECT ime
FROM studenti;


/*Potrebno je ispisati unikatna imena svih studenata*/

SELECT DISTINCT ime
FROM studenti;


/*Potrebno je ispisati imena i prezimena svih studenata*/

SELECT ime, prezime
FROM studenti;


/*Potrebno je ispisati unikatna imena i prezimena svih studenata*/

SELECT DISTINCT ime, prezime
FROM studenti;


/*Potrebno je ispisati ukupan broj svih studenata*/

SELECT COUNT(ime)
FROM studenti;


/*Potrebno je ispisati ukupan broj unikatnih imena svih studenata*/

SELECT COUNT(DISTINCT ime)
FROM studenti;



/*Kartezijev produkt*/


/*ispisati sva mjesta iz baze studenata*/

SELECT *
FROM mjesta;


/*ispisati sve županije iz baze studenata*/

SELECT *
FROM zupanije;


/*Napraviti kartezijev produkt mjesta i županije*/


SELECT *
FROM mjesta,
     zupanije;


/*Napraviti kartezijev produkt mjesta, županije i studenata*/


SELECT *
FROM mjesta,
     zupanije,
     studenti;


/*Napraviti kartezijev produkt mjesta, županije, studenata i smjerova*/


SELECT *
FROM mjesta,
     zupanije,
     studenti,
     smjerovi;



/*Malo smo pretjerali? :)*/

/*Napraviti kartezijev produkt mjesta, županije, studenata i ocjena*/


SELECT *
FROM mjesta,
     zupanije,
     studenti,
     ocjene;



/*Ovaj upit i nije neka sreća :D?*/
/*trebao bi ispisati 68*21*162*240=55520640*/

/*Zaključak: U praksi nikada ne koristite kartezijev produkt!!!*/


/*Prirodni spoj*/

/*U bazi radionice: Ispisati sva mjesta s pripadajućim županijama*/
SELECT *
FROM mjesto,
     zupanija
WHERE sifZupanija = sifZupanija;



/*Zašto upit ne radi?*/


/*
Interpreter ne zna točnu tablicu!
Potrebno je navesti točnu tablicu ako postoje kolone s istim nazivima!*/

SELECT *
FROM mjesto,
     zupanija
WHERE mjesto.sifZupanija = zupanija.sifZupanija;


/*Moguće je spajati i po kolonama koje nisu povezane.
  Npr. Potrebno je spojiti sve studente i nastavnike po imenu.*/

SELECT *
FROM studenti,
     nastavnici
WHERE studenti.ime = nastavnici.ime;



/*Super, ali ima li to nekog smisla?*/


/*Potrebno je ispisati sve radnike i nazive županija njihovog stanovanja*/
SELECT radnik.*, zupanija.nazivZupanija
FROM radnik,
     mjesto,
     zupanija
WHERE radnik.pbrStan = mjesto.pbrMjesto
  AND mjesto.sifZupanija = zupanija.sifZupanija;

SELECT radnik.imeRadnik, radnik.prezimeRadnik,  mjesto.nazivMjesto, zupanija.nazivZupanija
FROM radnik,
     mjesto,
     zupanija
WHERE radnik.pbrStan = mjesto.pbrMjesto
  AND mjesto.sifZupanija = zupanija.sifZupanija;

SELECT radnik.*, mjesto.nazivMjesto
FROM radnik,
     mjesto
WHERE radnik.pbrStan = mjesto.pbrMjesto;


/*Dodatni uvjeti*/
/*Potrebno je ispisati sve klijente koji su rođeni u Zagrebačkoj županiji:*/
SELECT klijent.*
FROM klijent,
     mjesto,
     zupanija
WHERE klijent.pbrKlijent = mjesto.pbrMjesto
  AND mjesto.sifZupanija = zupanija.sifZupanija
  AND zupanija.nazivZupanija = 'Zagrebačka';


/*Potrebno je ispisati sve klijente koji imaju 
registriran automobil u Zagrebačkoj županiji:*/
SELECT klijent.*
FROM klijent,
     mjesto,
     zupanija
WHERE klijent.pbrReg = mjesto.pbrMjesto
  AND mjesto.sifZupanija = zupanija.sifZupanija
  AND zupanija.nazivZupanija = 'Zagrebačka';


/*Potrebno je ispisati sve radnike koji su 
radili na kvaru „Zamjena klipa“:*/
SELECT radnik.*
FROM radnik,
     nalog,
     kvar
WHERE radnik.sifRadnik = nalog.sifRadnik
  AND nalog.sifKvar = kvar.sifKvar
  AND kvar.nazivKvar = 'Zamjena klipa';


/*Zašto se javljaju dupli rezultati?*/

/*Zato što postoji više naloga po kojima se vršila 
zamjena klipa javljaju se dupli rezultati. 
Pošto što je u ovom pitanju bilo traženo ispisati 
samo radnike koji su radili na kvaru, a ne i naloge 
po kojima se kvar popravljao, potrebno je koristiti DISTINCT izjavu. */

SELECT DISTINCT radnik.*
FROM radnik,
     nalog,
     kvar
WHERE radnik.sifRadnik = nalog.sifRadnik
  AND nalog.sifKvar = kvar.sifKvar
  AND kvar.nazivKvar = 'Zamjena klipa';

/*A koji je razlog da se tablice ne spajaju 
preko tablice nalog a ne odjel?*/


/*Ukoliko se spoje preko tablice odjel, 
to bi značilo da se kvar popravljao na 
istom odjelu na kojem radi radnik, ali 
nije nužno da je baš taj radnik vršio 
popravak tog kvara. Također je moguće 
da je radnik iz npr. odjela „Limarija“ 
vršio popravak nekog kvara na odjelu „Alarmi“.*/


/*Potrebno je ispisati sve klijente koji su 
vršili popravak kvara na odjelu „Dijagnostika“:*/
SELECT DISTINCT klijent.*
FROM odjel,
     kvar,
     nalog,
     klijent
WHERE odjel.sifOdjel = kvar.sifOdjel
  AND kvar.sifKvar = nalog.sifKvar
  AND nalog.sifKlijent = klijent.sifKlijent
  AND odjel.nazivOdjel = 'Dijagnostika';


/*Potrebno je ispisati sve klijente koji su vršili popravak kvara na odjelu 
„Dijagnostika“, a automobil im je registriran u županiji „Grad Zagreb“:*/
SELECT DISTINCT klijent.*
FROM odjel,
     kvar,
     nalog,
     klijent,
     mjesto,
     zupanija
WHERE odjel.sifOdjel = kvar.sifOdjel
  AND kvar.sifKvar = nalog.sifKvar
  AND nalog.sifKlijent = klijent.sifKlijent
  AND klijent.pbrReg = mjesto.pbrMjesto
  AND mjesto.sifZupanija = zupanija.sifZupanija
  AND odjel.nazivOdjel = 'Dijagnostika'
  AND zupanija.nazivZupanija = 'Grad Zagreb';


/*Potrebno je ispisati sve klijente koji su vršili popravak kvara na odjelu 
„Dijagnostika“ ili im je automobil registriran u županiji „Grad Zagreb“:*/
SELECT DISTINCT klijent.*
FROM odjel,
     kvar,
     nalog,
     klijent,
     mjesto,
     zupanija
WHERE odjel.sifOdjel = kvar.sifOdjel
    AND kvar.sifKvar = nalog.sifKvar
    AND nalog.sifKlijent = klijent.sifKlijent
    AND klijent.pbrReg = mjesto.pbrMjesto
    AND mjesto.sifZupanija = zupanija.sifZupanija
    AND odjel.nazivOdjel = 'Dijagnostika'
   OR zupanija.nazivZupanija = 'Grad Zagreb';



/*Malo (pre)dugo traje? :)*/


/*Koristite zagrade!!!*/

SELECT DISTINCT klijent.*
FROM odjel,
     kvar,
     nalog,
     klijent,
     mjesto,
     zupanija
WHERE (odjel.sifOdjel = kvar.sifOdjel
    AND kvar.sifKvar = nalog.sifKvar
    AND nalog.sifKlijent = klijent.sifKlijent
    AND klijent.pbrReg = mjesto.pbrMjesto
    AND mjesto.sifZupanija = zupanija.sifZupanija)
  AND (odjel.nazivOdjel = 'Dijagnostika'
    OR zupanija.nazivZupanija = 'Grad Zagreb');
