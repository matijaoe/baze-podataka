SELECT *
FROM studenti
WHERE MONTH(datumUpisa) = 9
  AND DAY(datumUpisa) = 25
ORDER BY prezime DESC, ime ASC;

SELECT klijent.imeKlijent, klijent.prezimeKlijent, datPrimitkaNalog
FROM nalog,
     klijent,
     mjesto
WHERE nalog.sifKlijent = klijent.sifKlijent
  AND mjesto.pbrMjesto = klijent.pbrReg
  AND mjesto.nazivMjesto = 'zagreb'
  AND QUARTER(datPrimitkaNalog) IN (1, 2)
  AND YEAR(datPrimitkaNalog) = YEAR(NOW() - INTERVAL 1 YEAR)
ORDER BY datPrimitkaNalog DESC;


SELECT imeKlijent, prezimeKlijent, datPrimitkaNalog
FROM klijent,
     nalog,
     mjesto
WHERE klijent.sifKlijent = nalog.sifKlijent
  AND klijent.pbrReg = mjesto.pbrMjesto
  AND YEAR(datPrimitkaNalog) = YEAR(CURDATE()) - 1
  AND MONTH(datPrimitkaNalog) >= 1
  AND MONTH(datPrimitkaNalog) <= 6
  AND nazivMjesto = 'Zagreb'
ORDER BY datPrimitkaNalog DESC;


UPDATE studenti
SET ime     = NULL,
    prezime = NULL
WHERE jmbag LIKE '0036%';

SELECT odjel.nazivOdjel
FROM odjel,
     radnik,
     mjesto
WHERE radnik.sifOdjel = odjel.sifOdjel
  AND radnik.pbrStan = mjesto.pbrMjesto
  AND mjesto.nazivMjesto = 'dubrovnik'
ORDER BY odjel.nazivOdjel;



SELECT studenti.*, ocjene.ocjena
FROM studenti,
     ocjene,
     kolegiji
WHERE kolegiji.naziv = 'Baze podataka'
  AND ocjene.idKolegij = kolegiji.id
  AND studenti.jmbag = ocjene.jmbagStudent
  AND DATE_FORMAT(datumupisa, '%m.%d') BETWEEN '06.07' AND '10.21';


SELECT studenti.*, ocjene.*
FROM studenti
         INNER JOIN
     ocjene ON ocjene.jmbagStudent = studenti.jmbag
         INNER JOIN
     kolegiji ON kolegiji.id = ocjene.idKolegij
WHERE kolegiji.naziv = 'baze podataka'
  AND DATE_FORMAT(datumUpisa, '%m%d') BETWEEN
    '0607' AND '1021';

SELECT studenti.*, ocjene.*
FROM studenti
         INNER JOIN
     ocjene ON ocjene.jmbagStudent = studenti.jmbag
         INNER JOIN
     kolegiji ON kolegiji.id = ocjene.idKolegij
WHERE kolegiji.naziv = 'baze podataka'
  AND STR_TO_DATE(DATE_FORMAT(datumUpisa, '%m%d'), '%m%d')
    BETWEEN '0000-06-07' AND '0000-10-21';

SELECT studenti.*, ocjene.*
FROM studenti
         INNER JOIN
     ocjene ON ocjene.jmbagStudent = studenti.jmbag
         INNER JOIN
     kolegiji ON kolegiji.id = ocjene.idKolegij
WHERE (kolegiji.naziv = 'baze podataka')
  AND ((DAY(datumUpisa) >= 7 AND MONTH(datumUpisa) = 6) OR
       (DAY(datumUpisa) <= 21 AND MONTH(datumUpisa) = 10) OR
       (MONTH(datumUpisa) = 7) OR (MONTH(datumUpisa) = 8) OR
       (MONTH(datumUpisa) = 9));



SELECT *
FROM nalog
WHERE MONTH(datPrimitkaNalog) = 4
  AND YEAR(datPrimitkaNalog) = YEAR(NOW()) - 9
ORDER BY prioritetNalog DESC;

SELECT *
FROM nalog
WHERE MONTH(nalog.datPrimitkaNaloga) = 4
  AND YEAR(nalog.datPrimitkaNaloga) = YEAR(CURDATE()) - 9
ORDER BY prioritetNalog;


SELECT mjesto.pbrMjesto, mjesto.nazivMjesto
FROM mjesto,
     klijent
WHERE klijent.pbrKlijent = mjesto.pbrMjesto
  AND MONTH(datUnosKlijent) > 6
  AND YEAR(datUnosKlijent) = 2018
ORDER BY mjesto.nazivMjesto DESC;


SELECT nazivOdjel, odjel.sifOdjel
FROM odjel,
     radnik,
     mjesto
WHERE odjel.sifOdjel = radnik.sifOdjel
  AND pbrStan = pbrMjesto
  AND nazivMjesto IS NOT NULL
ORDER BY odjel.sifOdjel DESC;


SELECT DISTINCT kolegiji.*
FROM kolegiji,
     ocjene
WHERE kolegiji.id = ocjene.idKolegij
  AND YEAR(datumPolaganja) = YEAR(CURDATE());


DELETE
FROM ocjene
WHERE HOUR(vrijemePolaganja) > 12;


SELECT studenti.*, smjerovi.naziv
FROM studenti,
     naziv,
     ustanove
WHERE smjerovi.id = studenti.idSmjer
  AND YEAR(CURDATE()) = YEAR(datumUpisa) - 3
  AND smjerovi.oibUstanova = ustanove.oib
  AND ustanove.naziv = "Tehničko Veleučilište u Zagrebu"
ORDER BY studenti.ime ASC;


SELECT jmbg, ime, prezime
FROM nastavnici
WHERE titulaIspred IS NULL
ORDER BY ime ASC;

SELECT nalog.*
FROM nalog
WHERE YEAR(datPrimitkaNalog) = YEAR(CURDATE() - 12)
  AND DAY(datPrimitkaNalog) = DAY(CURDATE())
ORDER BY prioritetNalog ASC;


SELECT studenti.ime, studenti.prezime, ocjene.ocjena
FROM studenti,
     ocjene,
     kolegiji
WHERE ocjene.jmbagStudent = studenti.jmbag
  AND kolegiji.id = ocjene.idKolegij
  AND kolegiji.naziv = 'fizika';
