/*U bazi radionice: Ispisati sve klijente koji su 
uneseni u bazu na današnji dan prije 25 godina 
(obzirom na datum trenutnog pozivanja upita). 
Rezultate je potrebno sortirati po datumu unosa 
klijenta uzlazno.*/

SELECT *
FROM klijent
WHERE datUnosKlijent = ADDDATE(CURDATE(), INTERVAL -25 YEAR)
ORDER BY datUnosKlijent ASC;


/*U bazi studenti: Potrebno je ispisati prosjek
ocijena koje su dobivene polaganjem prošle godine.*/

SELECT AVG(ocjena)
FROM ocjene
WHERE YEAR(datumPolaganja) = YEAR(CURDATE()) - 1;


/*U bazi radionice: Potrebno je ispisati sva mjesta koja
se nalaze u županijama kojima naziv nije NULL vrijednost.*/

SELECT mjesto.*
FROM mjesto
         INNER JOIN
     zupanija ON zupanija.sifZupanija = mjesto.sifZupanija
WHERE zupanija.nazivZupanija IS NOT NULL;


/*U bazi studenti: Potrebno je ispisati imena i prezimena
nastavnika kojima je titula iza NULL vrijednost. Rezultate 
je potrebno sortirati po imenu uzlazno i po prezimenu silazno.*/

SELECT ime, prezime
FROM nastavnici
WHERE titulaIza IS NULL
ORDER BY ime ASC, prezime DESC;


/*U bazi radionice: Potrebno je ispisati podatke radnika i
prioritete naloga na kojima su vršili popravak kvara naziva 
"Zamjena klipa".*/

SELECT radnik.*, nalog.prioritetNalog
FROM radnik
         INNER JOIN
     nalog ON nalog.sifRadnik = radnik.sifRadnik
         INNER JOIN
     kvar ON nalog.sifKvar = kvar.sifKvar
WHERE kvar.nazivKvar = 'Zamjena klipa';


/*U bazi studenti: Potrebno je ispisati imena i prezimena
nastavnika, njihova mjesta prebivanja i nazive kolegija na 
kojima rade.*/

SELECT nastavnici.ime, nastavnici.prezime, mjesta.nazivMjesto, kolegiji.naziv
FROM nastavnici
         INNER JOIN
     mjesta ON mjesta.postBr = nastavnici.postBr
         INNER JOIN
     izvrsitelji ON nastavnici.jmbg = izvrsitelji.jmbgNastavnik
         INNER JOIN
     kolegiji ON kolegiji.id = izvrsitelji.idKolegij


/*U bazi radionice: Potrebno je napisati upit koji će
radionici s oznakom R10 promjeniti kapacitet radnika u 5.*/

UPDATE radionica
SET kapacitetRadnika = 5
WHERE oznRadionica = 'R10';


/*U bazi studenti: Potrebno je izbrisati ocjene
studentima kojima jmbag počinje s 0035.*/

DELETE
FROM Ocjene
WHERE ocjene.jmbagStudent LIKE '0035%'

