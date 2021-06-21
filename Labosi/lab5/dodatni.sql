SELECT DISTINCT radnik.*
FROM radnik
         LEFT OUTER JOIN
     nalog ON nalog.sifRadnik = radnik.sifRadnik
WHERE nalog.sifKvar IS NULL;

SELECT odjel.*
FROM odjel
         LEFT OUTER JOIN
     kvar ON odjel.sifOdjel = kvar.sifOdjel
WHERE kvar.sifKvar IS NULL;

SELECT odjel.*
FROM odjel
         INNER JOIN
     kvar k ON odjel.sifOdjel = k.sifOdjel
WHERE sifKvar IS NULL;


SELECT MAX(ocjene.ocjena)
FROM ocjene
         JOIN
     studenti ON ocjene.jmbagstudent = studenti.jmbag
         JOIN
     mjesta ON studenti.postbrprebivanje = mjesta.postbr
         JOIN
     zupanije ON mjesta.idzupanija = zupanije.id
WHERE zupanije.nazivzupanija = 'Splitsko-dalmatinska županija'
  AND datumpolaganja BETWEEN ADDDATE(CURRENT_DATE, INTERVAL -18 MONTH) AND CURRENT_DATE;

SELECT DISTINCT nastavnici.*
FROM nastavnici
         JOIN izvrsitelji ON nastavnici.jmbg = izvrsitelji.jmbgNastavnik
         JOIN kolegiji k ON izvrsitelji.idKolegij = k.id
         JOIN smjerovi s ON k.idSmjer = s.id
         JOIN ustanove u ON s.oibUstanova = u.oib
         JOIN mjesta m ON nastavnici.postBr = m.postbr
         JOIN zupanije z ON m.idZupanija = z.id
WHERE z.nazivZupanija NOT LIKE 'Varaždinska'
  AND u.naziv = 'Fakultet organizacije i informatike';

SELECT nastavnici.prezime, nastavnici.ime, zupanije.nazivZupanija
FROM nastavnici
         JOIN mjesta ON nastavnici.postBr = mjesta.postbr
         JOIN zupanije ON mjesta.idZupanija = zupanije.id
UNION ALL
SELECT studenti.prezime, studenti.ime, zupanije.nazivZupanija
FROM studenti
         JOIN mjesta ON studenti.postBrStanovanja = mjesta.postbr
         JOIN zupanije ON mjesta.idZupanija = zupanije.id;


SELECT COUNT(kvar.sifKvar)
FROM kvar
         INNER JOIN
     nalog n ON kvar.sifKvar = n.sifKvar
         INNER JOIN
     klijent k ON n.sifKlijent = k.sifKlijent
         INNER JOIN
     mjesto m ON k.pbrKlijent = m.pbrMjesto
         INNER JOIN
     zupanija z ON m.sifZupanija = z.sifZupanija
WHERE z.nazivZupanija = 'Varaždinska'
   OR z.nazivZupanija = 'Osječko-Baranjska';

SELECT DISTINCT radnik.imeRadnik, radnik.prezimeRadnik
FROM radnik
         JOIN nalog n ON radnik.sifRadnik = n.sifRadnik
         JOIN klijent k ON n.sifKlijent = k.sifKlijent
         JOIN mjesto m ON k.pbrKlijent = m.pbrMjesto
         JOIN zupanija z ON z.sifZupanija = m.sifZupanija
WHERE z.nazivZupanija = 'Grad Zagreb'
  AND radnik.KoefPlaca > 2.1;


SELECT nastavnici.*, zupanije.nazivZupanija
FROM nastavnici
         LEFT JOIN
     mjesta ON nastavnici.postBr = mjesta.postbr
         LEFT JOIN
     zupanije ON mjesta.idZupanija = zupanije.id
UNION
SELECT nastavnici.*, zupanije.nazivZupanija
FROM nastavnici
         RIGHT JOIN
     mjesta ON nastavnici.postBr = mjesta.postbr
         RIGHT JOIN
     zupanije ON mjesta.idZupanija = zupanije.id;

# U bazi studenti: Koristeći JOIN klauzulu ispisati sve kolegija i nastavnike na kojima rade nastavnici čija je
# uloga izvršitelja "profesor" ili "asistent" a mjesec rođenja nije travanj.
SELECT kolegiji.*, nastavnici.*
FROM kolegiji
         INNER JOIN
     izvrsitelji ON kolegiji.id = izvrsitelji.idKolegij
         INNER JOIN
     ulogaizvrsitelja ON izvrsitelji.idUlogaIzvrsitelja = ulogaizvrsitelja.id
         INNER JOIN
     nastavnici ON izvrsitelji.jmbgNastavnik = nastavnici.jmbg
WHERE (ulogaizvrsitelja.naziv = 'profesor' OR ulogaizvrsitelja.naziv = 'asistent')
  AND jmbg NOT LIKE '___4%';

SELECT kolegiji.*, nastavnici.*
FROM kolegiji
         INNER JOIN
     izvrsitelji ON kolegiji.id = izvrsitelji.idKolegij
         INNER JOIN
     ulogaizvrsitelja ON izvrsitelji.idUlogaIzvrsitelja = ulogaizvrsitelja.id
         INNER JOIN
     nastavnici ON izvrsitelji.jmbgNastavnik = nastavnici.jmbg
WHERE (ulogaizvrsitelja.naziv = 'profesor' OR ulogaizvrsitelja.naziv = 'asistent')
  AND jmbg NOT LIKE '___4%';


SELECT DISTINCT radionica.oznRadionica
FROM radionica
         JOIN rezervacija r ON radionica.oznRadionica = r.oznRadionica
         JOIN kvar k ON r.sifKvar = k.sifKvar
         JOIN nalog n ON k.sifKvar = n.sifKvar
         JOIN klijent k2 ON n.sifKlijent = k2.sifKlijent
WHERE k2.jmbgKlijent LIKE '____983%';

SELECT DISTINCT radionica.oznRadionica
FROM radionica
         INNER JOIN rezervacija ON radionica.oznRadionica = rezervacija.oznRadionica
         INNER JOIN kvar ON rezervacija.sifKvar = kvar.sifKvar
         INNER JOIN nalog ON kvar.sifKvar = nalog.sifKvar
         INNER JOIN klijent ON nalog.sifKlijent = klijent.sifKlijent
WHERE SUBSTRING(klijent.jmbgKlijent, 5, 3) = '983';

SELECT nastavnici.*
FROM nastavnici
         JOIN izvrsitelji i ON nastavnici.jmbg = i.jmbgNastavnik
         JOIN kolegiji k ON i.idKolegij = k.id
         JOIN smjerovi s ON k.idSmjer = s.id
         JOIN ustanove u ON s.oibUstanova = u.oib
         JOIN mjesta m ON nastavnici.postBr = m.postbr
         JOIN zupanije z ON m.idZupanija = z.id
WHERE z.nazivZupanija LIKE 'splitsko%'
  AND YEAR(NOW()) - YEAR(u.datumOsnutka) > 20;

SELECT nastavnici.*
FROM nastavnici
         JOIN izvrsitelji i ON nastavnici.jmbg = i.jmbgNastavnik
         JOIN kolegiji k ON i.idKolegij = k.id
         JOIN smjerovi s ON k.idSmjer = s.id
         JOIN ustanove u ON s.oibUstanova = u.oib
         JOIN mjesta m ON nastavnici.postBr = m.postbr
         JOIN zupanije z ON m.idZupanija = z.id
WHERE z.nazivZupanija LIKE 'splitsko%'
  AND YEAR(u.datumOsnutka) > YEAR(CURDATE()) - 20;
