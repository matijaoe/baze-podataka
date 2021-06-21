# U bazi studenti: Ispisati sve studente koji su prošle godine dobili ocjene unutar prosjeka +-15%.
SELECT s.*, o.ocjena
FROM studenti s
         JOIN ocjene o ON s.jmbag = o.jmbagStudent
WHERE (o.ocjena BETWEEN
        (SELECT AVG(ocjene.ocjena) FROM ocjene) * 0.85 AND
        (SELECT AVG(ocjene.ocjena) FROM ocjene) * 1.15)
  AND YEAR(o.datumPolaganja) = YEAR(NOW() - INTERVAL 1 YEAR);

# U bazi studenti: Pomoću podupita potrebno je prikazati sve kolegije iz kojih imaju ocjene studenti koji su se prvi upisali.
SELECT DISTINCT kolegiji.*, studenti.ime, studenti.prezime
FROM kolegiji
         INNER JOIN ocjene ON ocjene.idkolegij = kolegiji.id
         INNER JOIN studenti ON ocjene.jmbagStudent = studenti.jmbag
WHERE studenti.datumUpisa = (SELECT MIN(datumUpisa) FROM studenti);

SELECT ime, prezime, datumUpisa
FROM studenti s
ORDER BY datumUpisa;

# U bazi radionice: Pomoću podupita potrebno je uz svako mjesto ispisati koliko klijenata u tom mjestu stanuje
# i koliko ih ima registriran automobil.
SELECT mjesto.pbrMjesto,
       mjesto.nazivMjesto,
       (SELECT COUNT(*) FROM klijent WHERE klijent.pbrKlijent = mjesto.pbrMjesto) AS mjStan,
       (SELECT COUNT(*) FROM klijent WHERE klijent.pbrReg = mjesto.pbrMjesto)     AS mjAuto
FROM mjesto;

# U bazi radionice: Ispisati nazive kvarova i vrijednosti satiKvar-a koji su veći od bilo koje vrijednosti satServisa
# iz tablice rezervacija uz uvjet da oznaka radionice počinje malim ili velikim slovom 'R'.
SELECT k.nazivKvar, k.satiKvar
FROM kvar k
WHERE k.satikvar > ANY
      (SELECT satServis FROM rezervacija
       WHERE oznRadionica LIKE 'R%');