/* 1.	U bazi radionice: Ispisati sumu sati kvara i broja radnika grupiranu po nazivu odjela. Potrebno je 
ispisati samo one n-torke koje čiji je broj sati kvara veći od 1. Rezultate je potrebno sortirati po sumi 
broja radnika uzlazno. Rezultate je potrebno ograničiti na prvih 5 n-torki. */

SELECT odjel.nazivOdjel, odjel.sifOdjel, SUM(kvar.satiKvar) AS brojSati, SUM(kvar.brojRadnika) AS brojRadnik
FROM kvar 
INNER JOIN odjel ON kvar.sifOdjel = odjel.sifOdjel
GROUP BY odjel.nazivOdjel, odjel.sifOdjel
HAVING brojSati > 1
ORDER BY brojRadnik ASC
LIMIT 5;


/* U bazi radionice: Potrebno je ispisati sumu plaća radnika po mjestu. Rezultate je potrebno ograničiti na 
prvih 5 n-torki. */

SELECT mjesto.nazivMjesto, SUM(radnik.KoefPlaca * IznosOsnovice) AS sumaPlace
FROM mjesto INNER JOIN 
     radnik ON mjesto.pbrMjesto = radnik.pbrStan
GROUP BY mjesto.nazivMjesto
LIMIT 5;


/* U bazi radionice: Ispisati broj kvarova po odjelima. Uz broj kvarova ispisati nazive odjela. Rezultate je 
potrebno uzlazno sortirati po broju kvarova. */

SELECT odjel.nazivOdjel, COUNT(kvar.sifKvar) AS brojKvarova
FROM odjel LEFT JOIN kvar ON odjel.sifOdjel = kvar.sifOdjel
GROUP BY odjel.nazivOdjel
ORDER BY brojKvarova ASC;
/*Priznaje se i bez vanjskog spajanja, ali tada neće prikazati odjele s 0 kvarova.*/


/* U bazi studenti: Potrebno je ispisati broj studenata po mjestu stanovanja. Ukoliko ne postoji ni jedan 
student u određenom mjestu, mjesto je potrebno ispisati, a za broj studenata mora biti 0. Potrebno je ispisati 
samo ona mjesta koja imaju manje od 10 studenata. Rezultate je potrebno ograničiti na prvih 20 n-torki. */

SELECT mjesta.nazivMjesto, mjesta.postBr, COUNT(studenti.jmbag) AS brojStudenata
FROM mjesta LEFT JOIN studenti ON studenti.postBrStanovanja = mjesta.postbr
GROUP BY mjesta.nazivMjesto, mjesta.postBr
HAVING brojStudenata < 10
LIMIT 20;


/* U bazi studenti: Potrebno je ispisati prosječne ocjene studenata po županiji stanovanja. Rezultate je 
potrebno sortirati po prosjeku silazno i ograničiti na prvih 10 n-torki. */

SELECT zupanije.nazivZupanija, zupanije.id, AVG(ocjene.ocjena)
FROM zupanije JOIN mjesta ON zupanije.id = mjesta.idZupanija
JOIN studenti ON mjesta.postbr = studenti.postBrStanovanja
JOIN ocjene ON studenti.jmbag = ocjene.jmbagStudent
GROUP BY zupanije.nazivZupanija, zupanije.id
ORDER BY AVG(ocjene.ocjena) DESC
LIMIT 10;


/* U bazi studenti: Potrebno je ispisati broj nastavnika koji su u ulozi asistenta po ustanovi. Rezultate je 
potrebno sortirati uzlazno po broju nastavnika. */

SELECT ustanove.naziv, ustanove.oib, COUNT(nastavnici.jmbg) AS brojAsistenata
FROM nastavnici JOIN izvrsitelji ON nastavnici.jmbg = izvrsitelji.jmbgNastavnik
JOIN ulogaIzvrsitelja ON izvrsitelji.idUlogaIzvrsitelja = ulogaIzvrsitelja.id
JOIN kolegiji ON izvrsitelji.idKolegij = kolegiji.id
JOIN smjerovi ON kolegiji.idSmjer = smjerovi.id
JOIN ustanove ON smjerovi.oibUstanova = ustanove.oib
WHERE ulogaIzvrsitelja.naziv = 'asistent'
GROUP BY ustanove.naziv, ustanove.oib
ORDER BY brojAsistenata ASC;