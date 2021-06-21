/*
1
U bazi radionice: Ispisati sve klijente koji su uneseni u bazu na današnji dan prije 25 godina
(obzirom na datum trenutnog pozivanja upita). Rezultate je potrebno sortirati po datumu
unosa klijenta uzlazno.
 */
SELECT *
FROM klijent
WHERE datUnosKlijent = DATE_SUB(NOW(), INTERVAL 25 YEAR)
ORDER BY datUnosKlijent ASC;

SELECT *
FROM klijent
WHERE datUnosKlijent = NOW() - INTERVAL 25 YEAR
ORDER BY datUnosKlijent ASC;

/*
2
U bazi studenti: Potrebno je ispisati prosjek ocjena koje su dobivene polaganjem prošle
godine.
*/
SELECT AVG(ocjena)
FROM ocjene
WHERE YEAR(datumPolaganja) = YEAR(NOW() - INTERVAL 1 YEAR);

SELECT AVG(ocjena)
FROM ocjene
WHERE YEAR(datumPolaganja) = YEAR(NOW()) - 1;

# dokaz da tocno
SELECT AVG(ocjena)
FROM ocjene
WHERE YEAR(datumPolaganja) = '2020';

/*
3
U bazi radionice: Potrebno je ispisati sva mjesta koja se nalaze u županijama kojima naziv nije
NULL vrijednost.
*/
SELECT DISTINCT mjesto.*
FROM mjesto,
     zupanija
WHERE zupanija.nazivZupanija IS NOT NULL
ORDER BY sifZupanija;


/*
4
U bazi studenti: Potrebno je ispisati imena i prezimena nastavnika kojima je titula iza NULL
vrijednost. Rezultate je potrebno sortirati po imenu uzlazno i po prezimenu silazno.
*/
SELECT ime, prezime
FROM nastavnici
WHERE titulaIza = '' -- jer nijedan nema null, inace IS NULL
ORDER BY ime ASC, prezime DESC;

/*
5
U bazi radionice: Potrebno je ispisati podatke radnika i prioritete naloga na kojima su vršili
popravak kvara naziva "Zamjena klipa".
*/
SELECT radnik.*, nalog.prioritetNalog
FROM radnik,
     nalog,
     kvar
WHERE nalog.sifRadnik = radnik.sifRadnik
  AND nalog.sifKvar = kvar.sifKvar
  AND kvar.nazivKvar = 'zamjena klipa';


/*
6
U bazi studenti: Potrebno je ispisati imena i prezimena nastavnika, njihova mjesta prebivanja
i nazive kolegija na kojima rade.
*/
SELECT ime, prezime, mjesta.nazivMjesto, kolegiji.naziv
FROM nastavnici,
     mjesta,
     kolegiji,
     izvrsitelji
WHERE nastavnici.postBr = mjesta.postbr
  AND izvrsitelji.jmbgNastavnik = nastavnici.jmbg
  AND izvrsitelji.idKolegij = kolegiji.id;

/*
7
U bazi radionice: Potrebno je napisati upit koji će radionici s oznakom R10 promijeniti
kapacitet radnika u 5.
*/
UPDATE radionica
SET kapacitetRadnika = 5
WHERE oznRadionica = 'R10';

/*
8
U bazi studenti: Potrebno je izbrisati ocjene studentima kojima JMBAG počinje s 0035.
*/
DELETE
FROM ocjene
WHERE ocjene.jmbagStudent LIKE '0035%';