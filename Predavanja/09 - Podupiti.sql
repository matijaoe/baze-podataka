/*ispisati kvarove za koje je potrrebno tolko malo radnika da se popravak moze napraviti odjednom
  u bilo kojoj radionici (tj kvarove sa 1 radnikom)
 */
SELECT *
FROM kvar
WHERE brojRadnika <= ALL (SELECT kapacitetRadnika FROM radionica);

SELECT *
FROM kvar
WHERE brojRadnika <= ANY (SELECT kapacitetRadnika FROM radionica);

/* kvarovi s vecim brojem radnika od svih radionica (prakticki vise od najvise)*/
SELECT *
FROM kvar
WHERE brojRadnika > ALL (SELECT kapacitetRadnika FROM radionica);

/*Ispisati radnike s nadprosječnim plaćama*/
SELECT *
FROM radnik
WHERE (koefPlaca * IznosOsnovice) >
      (SELECT AVG(koefPlaca * IznosOsnovice) FROM radnik);

#ILI

SELECT *
FROM radnik
WHERE (koefPlaca * IznosOsnovice) > ALL (SELECT AVG(koefPlaca * IznosOsnovice) FROM radnik);

#ILI

SELECT *
FROM radnik
WHERE (koefPlaca * IznosOsnovice) > ANY (SELECT AVG(koefPlaca * IznosOsnovice) FROM radnik);

#Dakle, kada postoji jedna vrijednost, nije bitno koja se ključna riječ koristi!


/*Ispisati radnike koji imaju plaće unutar prosjeka +/- 500kn*/

SELECT *
FROM radnik
WHERE (koefPlaca * IznosOsnovice) BETWEEN
              (SELECT AVG(koefPlaca * IznosOsnovice) FROM radnik) - 500 AND
              (SELECT AVG(koefPlaca * IznosOsnovice) FROM radnik) + 500;


/*Ispisati sve studente koji imaju više od jedne ocjene*/
SELECT *
FROM studenti
WHERE studenti.jmbag IN
      (SELECT jmbagStudent
       FROM ocjene
       GROUP BY jmbagStudent
       HAVING COUNT(*) > 1);

# moj nacin sa group by
SELECT studenti.*
FROM studenti
         JOIN ocjene ON ocjene.jmbagStudent = studenti.jmbag
GROUP BY studenti.jmbag
HAVING COUNT(*) > 1;


/*Ispisati ustanove koje se nalaze u županiji Grad Zagreb*/

SELECT ustanove.*
FROM ustanove
WHERE ustanove.postBr IN
      (SELECT postBr
       FROM mjesta
       WHERE mjesta.idZupanija IN
             (SELECT id
              FROM zupanije
              WHERE nazivZupanija = 'Grad Zagreb'));

#ILI:

SELECT *
FROM (SELECT ustanove.*
      FROM ustanove
               INNER JOIN
           mjesta ON mjesta.postBr = ustanove.postBr
               INNER JOIN
           zupanije ON zupanije.id = mjesta.idZupanija
      WHERE zupanije.nazivZupanija = 'Grad Zagreb') AS mojaProjekcija;

#postoji li jednostavniji način?

SELECT ustanove.*
FROM ustanove
         INNER JOIN
     mjesta ON mjesta.postBr = ustanove.postBr
         INNER JOIN
     zupanije ON zupanije.id = mjesta.idZupanija
WHERE zupanije.nazivZupanija = 'Grad Zagreb';

#Ukoliko nije potrebno koristiti podupite, bolje ih je izbjegavati!!!

-- moje
/* ispisati radnike koji nisu radili na niti jednom nalogu */
SELECT radnik.*
FROM radnik
         LEFT JOIN nalog n ON radnik.sifRadnik = n.sifRadnik
WHERE n.sifRadnik IS NULL;

SELECT *
FROM radnik
WHERE sifRadnik NOT IN (SELECT sifRadnik FROM nalog);


#Delete podupiti:
#Potrebno je obrisati ocjene studenata s mjestom prebivanja u Zagrebu:

DELETE
FROM ocjene
WHERE jmbagStudent IN (
    SELECT jmbag
    FROM studenti
             INNER JOIN
         mjesta ON mjesta.postBr = studenti.postBrPrebivanje
    WHERE mjesta.nazivMjesto = 'Zagreb');

/*Moguće je napraviti delete preko dvije tablice na MySQL-u od ver. 8, 
ali se ne preporuča jer neke baze ne prepoznaju tu sintaksu:*/
DELETE ocjene
FROM ocjene
         INNER JOIN
     studenti ON studenti.jmbag = ocjene.jmbagStudent
         INNER JOIN
     mjesta ON mjesta.postBr = studenti.postBrPrebivanje
WHERE mjesta.nazivMjesto = 'Zagreb';

select ocjene.*
FROM ocjene
         INNER JOIN
     studenti ON studenti.jmbag = ocjene.jmbagStudent
         INNER JOIN
     mjesta ON mjesta.postBr = studenti.postBrPrebivanje
WHERE mjesta.nazivMjesto = 'Zagreb';


/*Potrebno je svim studentima koji nisu iz Zagreba promjeniti ocjenu u odličan*/

UPDATE ocjene
SET ocjene.ocjena = 4
WHERE jmbagStudent IN (
    SELECT jmbag
    FROM studenti
             INNER JOIN
         mjesta ON mjesta.postBr = studenti.postBrPrebivanje
    WHERE mjesta.nazivMjesto <> 'Zagreb');


#ILI:
/*Potrebno je svim studentima koji nisu iz Zagreba promjeniti ocjenu u dobar*/
UPDATE ocjene INNER JOIN
    studenti ON ocjene.jmbagStudent = studenti.jmbag INNER JOIN
    mjesta ON mjesta.postBr = studenti.postBrPrebivanje
SET ocjene.ocjena = 3
WHERE mjesta.nazivMjesto <> 'Zagreb';

#ili
/*Potrebno je svim studentima koji nisu iz Zagreba promjeniti ocjenu u odličan*/
UPDATE ocjene
SET ocjene.ocjena = 5
WHERE jmbagStudent IN (
    SELECT jmbag
    FROM studenti
             INNER JOIN
         mjesta ON mjesta.postBr = studenti.postBrPrebivanje
    WHERE mjesta.nazivMjesto <> 'Zagreb');

/*Koliko studenata stanuje, a koliko prebiva u pojedinom gradu*/
SELECT mjesta.postBr,
       mjesta.nazivMjesto,
       (SELECT COUNT(*) FROM studenti WHERE studenti.postBrPrebivanje = mjesta.postBr) AS prebiva,
       (SELECT COUNT(*) FROM studenti WHERE studenti.postBrStanovanja = mjesta.postBr) AS stanuje
FROM mjesta;


SELECT klijent.sifKlijent, klijent.prezimeKlijent, klijent.imeKlijent
FROM klijent
WHERE NOT EXISTS
    (SELECT * FROM nalog WHERE nalog.sifklijent = klijent.sifKlijent);


SELECT mjesto.pbrMjesto,
       mjesto.nazivMjesto,
       (SELECT COUNT(*) FROM klijent WHERE mjesto.pbrMjesto = klijent.pbrKlijent) AS stanuje,
       (SELECT COUNT(*) FROM klijent WHERE mjesto.pbrMjesto = klijent.pbrReg)     AS regauto
FROM mjesto;



SELECT klijent.*, n.prioritetNalog
FROM klijent
         JOIN nalog n ON klijent.sifKlijent = n.sifKlijent
WHERE n.prioritetNalog >
      (SELECT AVG(nalog.prioritetNalog) FROM nalog);