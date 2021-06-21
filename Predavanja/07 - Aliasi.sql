/*Aliasi nad atributima*/

SELECT ime, prezime
FROM studenti;

/*Ime studenta je potrebno preimenovati u imeStudent, a prezime u prezimeStudent*/

SELECT ime AS imeStudent, prezime AS prezimeStudent
FROM studenti;

#ili

SELECT ime imeStudent, prezime prezimeStudent
FROM studenti;

/*Aliasi nad atributima su najkorisniji kada postoji neka dugačka funkcija:*/

SELECT CONCAT('Ime: ', ime, ', Prezime: ', prezime)
FROM studenti;

SELECT CONCAT('Ime: ', ime, ', Prezime: ', prezime) AS imePrezime
FROM studenti;



/*Spajanje*/

/*Ispisati ime i prezime klijenta, naziv mjesta i naziv županije iz kojeg 
dolazi klijent, te datum kad je za klijenta zaprimljen nalog i prezime radnika. 
Uz ime Ispisati samo one zapise kod kojih naziv županije počinje slovom S a prezime 
klijenta završava na ć i mjesec kad je zaprimljen nalog je 12 ili 6.
*/

SELECT klijent.imeKlijent,
       klijent.prezimeKlijent,
       mjesto.nazivMjesto,
       zupanija.nazivZupanija,
       nalog.datPrimitkaNalog,
       radnik.prezimeRadnik
FROM klijent,
     mjesto,
     zupanija,
     nalog,
     radnik
WHERE klijent.pbrKlijent = mjesto.pbrMjesto
  AND mjesto.sifZupanija = zupanija.sifZupanija
  AND klijent.sifKlijent = nalog.sifKlijent
  AND nalog.sifRadnik = radnik.sifRadnik
  AND zupanija.nazivZupanija LIKE 'S%'
  AND klijent.prezimeKlijent LIKE '%ć'
  AND MONTH(nalog.datPrimitkaNalog) IN (12, 6);

/*S JOIN-om:*/

SELECT klijent.imeKlijent,
       klijent.prezimeKlijent,
       mjesto.nazivMjesto,
       zupanija.nazivZupanija,
       nalog.datPrimitkaNalog,
       radnik.prezimeRadnik
FROM klijent
         INNER JOIN
     mjesto ON klijent.pbrKlijent = mjesto.pbrMjesto
         INNER JOIN
     zupanija ON mjesto.sifZupanija = zupanija.sifZupanija
         INNER JOIN
     nalog ON klijent.sifKlijent = nalog.sifKlijent
         INNER JOIN
     radnik ON nalog.sifRadnik = radnik.sifRadnik
WHERE zupanija.nazivZupanija LIKE 'S%'
  AND klijent.prezimeKlijent LIKE '%ć'
  AND MONTH(nalog.datPrimitkaNalog) IN (12, 6);


/*Prirodni spoj s aliasima:*/

SELECT k.imeKlijent,
       k.prezimeKlijent,
       m.nazivMjesto,
       z.nazivZupanija,
       n.datPrimitkaNalog,
       r.prezimeRadnik
FROM klijent k,
     mjesto m,
     zupanija z,
     nalog n,
     radnik r
WHERE k.pbrKlijent = m.pbrMjesto
  AND m.sifZupanija = z.sifZupanija
  AND k.sifKlijent = n.sifKlijent
  AND n.sifRadnik = r.sifRadnik
  AND z.nazivZupanija LIKE 'S%'
  AND k.prezimeKlijent LIKE '%ć'
  AND MONTH(n.datPrimitkaNalog) IN (12, 6);


/*JOIN s aliasima:*/

SELECT k.imeKlijent,
       k.prezimeKlijent,
       m.nazivMjesto,
       z.nazivZupanija,
       n.datPrimitkaNalog,
       r.prezimeRadnik
FROM klijent AS k
         INNER JOIN
     mjesto AS m ON k.pbrKlijent = m.pbrMjesto
         INNER JOIN
     zupanija AS z ON m.sifZupanija = z.sifZupanija
         INNER JOIN
     nalog AS n ON k.sifKlijent = n.sifKlijent
         INNER JOIN
     radnik AS r ON n.sifRadnik = r.sifRadnik
WHERE z.nazivZupanija LIKE 'S%'
  AND k.prezimeKlijent LIKE '%ć'
  AND MONTH(n.datPrimitkaNalog) IN (12, 6);

/*Prirodni spoj s aliasima i aliasima nad atributima:*/
SELECT k.imeKlijent       ik,
       k.prezimeKlijent   pk,
       m.nazivMjesto      nm,
       z.nazivZupanija    nz,
       n.datPrimitkaNalog ndat,
       r.prezimeRadnik    pr
FROM klijent k,
     mjesto m,
     zupanija z,
     nalog n,
     radnik r
WHERE k.pbrKlijent = m.pbrMjesto
  AND m.sifZupanija = z.sifZupanija
  AND k.sifKlijent = n.sifKlijent
  AND n.sifRadnik = r.sifRadnik
  AND z.nazivZupanija LIKE 'S%'
  AND k.prezimeKlijent LIKE '%ć'
  AND MONTH(n.datPrimitkaNalog) IN (12, 6);


/*JOIN s aliasima i aliasima nad atributima:*/
SELECT k.imeKlijent       AS ik,
       k.prezimeKlijent   AS pk,
       m.nazivMjesto      AS nm,
       z.nazivZupanija    AS nz,
       n.datPrimitkaNalog AS ndat,
       r.prezimeRadnik    AS pr
FROM klijent AS k
         INNER JOIN
     mjesto AS m ON k.pbrKlijent = m.pbrMjesto
         INNER JOIN
     zupanija AS z ON m.sifZupanija = z.sifZupanija
         INNER JOIN
     nalog AS n ON k.sifKlijent = n.sifKlijent
         INNER JOIN
     radnik AS r ON n.sifRadnik = r.sifRadnik
WHERE z.nazivZupanija LIKE 'S%'
  AND k.prezimeKlijent LIKE '%ć'
  AND MONTH(n.datPrimitkaNalog) IN (12, 6);



/*Vezanje na iste tablice:*/
/*Mjesto i klijent:*/

SELECT klijent.imeKlijent,
       klijent.prezimeKlijent,
       mjestoklijent.nazivMjesto,
       mjestoreg.nazivMjesto
FROM klijent
         INNER JOIN
     mjesto AS mjestoklijent ON klijent.pbrKlijent = mjestoklijent.pbrMjesto
         INNER JOIN
     mjesto AS mjestoreg ON klijent.pbrReg = mjestoreg.pbrMjesto;



/*Dodvanje županije u upit:*/


/*Potrebno je ispisati županiju stanovanja, županiju registracije i jmbg klijenta:*/

SELECT z1.nazivZupanija, z2.nazivZupanija, jmbgKlijent
FROM mjesto mjestoklijent
         INNER JOIN
     klijent ON klijent.pbrKlijent = mjestoklijent.pbrMjesto
         INNER JOIN
     mjesto mjestoreg ON klijent.pbrReg = mjestoreg.pbrMjesto
         INNER JOIN
     zupanija z1 ON mjestoklijent.sifZupanija = z1.sifZupanija
         INNER JOIN
     zupanija z2 ON mjestoreg.sifZupanija = z2.sifZupanija;



/*Još s radnicima:*/

/*Ispisati nazive mjesta stanovanja klijenta, nazive mjesta 
registracije auta te naziv mjesta stanovanja radnika koji je radio 
na nalogu za te klijente.*/

SELECT m1.nazivMjesto, m2.nazivMjesto, m3.nazivMjesto
FROM klijent
         INNER JOIN
     mjesto m1 ON klijent.pbrKlijent = m1.pbrMjesto
         INNER JOIN
     mjesto m2 ON klijent.pbrReg = m2.pbrMjesto
         INNER JOIN
     nalog ON nalog.sifKlijent = klijent.sifKlijent
         INNER JOIN
     radnik ON nalog.sifRadnik = radnik.sifRadnik
         INNER JOIN
     mjesto m3 ON radnik.pbrStan = m3.pbrMjesto;



/*Refleksivna veza*/


/*Ispisati šifre odjela, nazive odjela, 
šifre podređenih odjela te nazive podređenih odjela iz tablice odjel
*/

SELECT odjel.sifOdjel, odjel.nazivOdjel, podOdjel.sifOdjel, podOdjel.nazivOdjel
FROM odjel
         INNER JOIN
     odjel podOdjel ON podOdjel.sifNadOdjel = odjel.sifOdjel;


/*Još jedna razina u dubinu:*/

SELECT odjel.sifOdjel,
       odjel.nazivOdjel,
       podOdjel.sifOdjel,
       podOdjel.nazivOdjel,
       podpodOdjel.sifOdjel,
       podpodOdjel.nazivOdjel
FROM odjel
         INNER JOIN
     odjel podOdjel ON podOdjel.sifNadOdjel = odjel.sifOdjel
         INNER JOIN
     odjel podpodOdjel ON pododjel.sifOdjel = podpodOdjel.sifNadOdjel;


/*Za ovo postoje "common table expressions" dodani od verzije MySQL-a 8
koje ćete raditi na naprednim bazama :)*/
WITH RECURSIVE cte AS (
    SELECT odjel.sifOdjel, odjel.nazivOdjel, odjel.sifNadOdjel
    FROM odjel
    WHERE sifOdjel = 1
    UNION ALL
    SELECT odjel.sifOdjel, odjel.nazivOdjel, odjel.sifNadOdjel
    FROM odjel
             INNER JOIN cte ON odjel.sifNadOdjel = cte.sifOdjel
)
SELECT *
FROM cte;
/*Neke baze podataka ih imaju od davnih dana. :)*/

/*Ispisati ime i prezime klijenta, naziv mjesta i naziv županije iz kojeg
dolazi klijent, naziv mjesta i naziv županije registracije, te datum kad je za klijenta zaprimljen nalog i prezime radnika.
Ispisati mjesto i zupaniju radnika. Uz ime Ispisati samo one zapise kod kojih naziv županije počinje slovom S a prezime
klijenta završava na ć i mjesec kad je zaprimljen nalog je 12 ili 6.
*/

SELECT k.imeKlijent            AS 'prezime klijenta',
       k.prezimeKlijent        AS 'ime klijenta',
       mjStan.nazivMjesto      AS 'mjesto stanovanja',
       zStan.nazivZupanija     AS 'zupanija stanovanja',
       mjReg.nazivMjesto       AS 'mjesto registracije',
       zReg.nazivZupanija      AS 'zupanija registracije',
       n.datPrimitkaNalog      AS 'datum naloga',
       r.prezimeRadnik         AS 'prezime radnika',
       mjRadnik.nazivMjesto    AS 'mjesto radnika',
       zupRadnik.nazivZupanija AS 'zupanija radnika'
FROM klijent AS k
         JOIN mjesto AS mjStan ON k.pbrKlijent = mjStan.pbrMjesto
         JOIN mjesto AS mjReg ON k.pbrReg = mjReg.pbrMjesto
         JOIN nalog AS n ON n.sifKlijent = k.sifKlijent
         JOIN radnik AS r ON n.sifRadnik = r.sifRadnik
         JOIN zupanija AS zStan ON mjStan.sifZupanija = zStan.sifZupanija
         JOIN zupanija AS zReg ON mjReg.sifZupanija = zReg.sifZupanija
         JOIN mjesto AS mjRadnik ON r.pbrStan = mjRadnik.pbrMjesto
         JOIN zupanija AS zupRadnik ON mjRadnik.sifZupanija = zupRadnik.sifZupanija
WHERE (zStan.nazivZupanija LIKE 's%' OR zReg.nazivZupanija LIKE 's%')
  AND k.prezimeKlijent LIKE '%ć'
  AND MONTH(n.datPrimitkaNalog) IN (12, 6);