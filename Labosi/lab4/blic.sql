-- U bazi studenti: Potrebno je ispisati sve studente zajedno s nazivom smjera i nazivom ustanove koju su upisali.
-- Potrebno je ispisati one studente kojima JMBAG počinje s "0036".

SELECT studenti.*, smjerovi.naziv, ustanove.naziv
FROM studenti,
     smjerovi,
     ustanove
WHERE studenti.jmbag LIKE '0036%'
  AND studenti.idSmjer = smjerovi.id
  AND smjerovi.oibUstanova = ustanove.oib;

/*
U bazi radionice: Potrebno je ispisati sva mjesta koja se nalaze u županijama kojima naziv nije NULL vrijednost.
Rezultate je potrebno sortirati po nazivu županije silazno, nazivu mjesta uzlazno i po poštanskom broju silazno.
*/

SELECT mjesto.*
FROM mjesto,
     zupanija
WHERE mjesto.sifZupanija = zupanija.sifZupanija
  AND zupanija.nazivZupanija IS NOT NULL
ORDER BY zupanija.nazivZupanija DESC, mjesto.nazivMjesto ASC, mjesto.pbrMjesto DESC;

/*
U bazi radionice: Ispisati sve klijente koji su uneseni u bazu u prvoj polovini prošlog mjeseca
(obzirom na datum trenutnog pozivanja upita). Pazite na promjenu godine (mora raditi i ako se upit pozove u Siječnju)!
Rezultate je potrebno sortirati po imenima klijenata silazno.
*/

SELECT *
FROM klijent
WHERE DAY(datUnosKlijent) <= 15
  AND MONTH(datUnosKlijent) = MONTH(NOW()) - 1
ORDER BY klijent.imeKlijent DESC;


/*
U bazi radionice: Potrebno je napisati upit koji će radniku sa šifrom 440 promijeniti ime u "Albert", a prezime u "Einstein".
*/

UPDATE radnik
SET imeRadnik     = 'Albert',
    prezimeRadnik = 'Einstein'
WHERE radnik.sifRadnik = 440;


-- ---------------------------

SELECT mjesto.*
FROM mjesto,
     zupanija
WHERE mjesto.sifZupanija = zupanija.sifZupanija
  AND zupanija.nazivZupanija IS NOT NULL
ORDER BY zupanija.nazivZupanija DESC, mjesto.nazivMjesto ASC, mjesto.pbrMjesto DESC;


SELECT *
FROM klijent
WHERE DAY(datUnosKlijent) <= 15
  AND MONTH(datUnosKlijent) = MONTH(NOW() - INTERVAL 1 MONTH)
ORDER BY klijent.imeKlijent DESC;


SELECT *
FROM klijent
WHERE DAY(datUnosKlijent) <= 15
  AND MONTH(datUnosKlijent) = DATEDIFF(NOW(), 30)
ORDER BY klijent.imeKlijent DESC;

SELECT MONTH((NOW() - INTERVAL 4 MONTH));