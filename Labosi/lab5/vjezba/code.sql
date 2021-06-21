/* studenti iz Osijeka, a studiraju u ZG */
SELECT studenti.*
FROM studenti
         JOIN
     mjesta AS studentiMjesta ON studenti.postBrStanovanja = studentiMjesta.postbr
         JOIN
     smjerovi ON studenti.idSmjer = smjerovi.id
         JOIN
     ustanove ON smjerovi.oibUstanova = ustanove.oib
         JOIN
     mjesta AS ustanoveMjesta ON ustanove.postbr = ustanoveMjesta.postbr
WHERE studentiMjesta.nazivMjesto = 'osijek'
  AND ustanoveMjesta.nazivMjesto = 'zagreb';

/* nazivi zupanija klijenata i nazive zupanija regist auta klijenata za klijente prezimena na -ak */
SELECT imeKlijent,
       prezimeKlijent,
       zupanijaKlijent.nazivZupanija      AS 'Zupanija stanovanja',
       zupanijaRegistracija.nazivZupanija AS 'Zupanija registracije'
FROM klijent
         JOIN
     mjesto AS mjestoKlijent ON klijent.pbrKlijent = mjestoKlijent.pbrMjesto
         JOIN
     zupanija AS zupanijaKlijent ON mjestoKlijent.sifZupanija = zupanijaKlijent.sifZupanija
         JOIN
     mjesto AS mjestoRegistracija ON klijent.pbrReg = mjestoRegistracija.pbrMjesto
         JOIN
     zupanija AS zupanijaRegistracija ON mjestoRegistracija.sifZupanija = zupanijaRegistracija.sifZupanija
WHERE klijent.prezimeKlijent LIKE '%ak'

SELECT kolegiji.id, kolegiji.naziv, kolegiji.*, AVG(ocjene.ocjena) AS 'prosjek'
FROM kolegiji
         JOIN
     ocjene ON kolegiji.id = ocjene.idKolegij
GROUP BY kolegiji.id
ORDER BY prosjek ASC;


SELECT studenti.*, k.naziv, z.nazivZupanija
FROM studenti
         JOIN mjesta m ON studenti.postBrPrebivanje = m.postbr
         JOIN zupanije z ON m.idZupanija = z.id
         JOIN kolegiji k ON studenti.idSmjer = k.idSmjer
WHERE k.naziv = 'Statistika';

-- ime i prezime nastavnika koji zive u zagrebu, a studenti u osijeku
SELECT nastavnici.ime, nastavnici.prezime
FROM nastavnici
         JOIN mjesta ON nastavnici.postBr = mjesta.postbr
WHERE mjesta.nazivMjesto = 'zagreb'
UNION ALL
SELECT studenti.ime, studenti.prezime
FROM studenti
         JOIN mjesta ON studenti.postBrStanovanja = mjesta.postbr
WHERE mjesta.nazivMjesto = 'osijek';

/*
ispisati mjesta unutar zadarske zajedno sa studentima koji u njima stanuju, ako ne postoji student u zupaniji,
treba ispiati mjesto a unutar kolone umjesto studenta NULL
*/
SELECT mjesta.*, studenti.ime, studenti.prezime
FROM zupanije
         JOIN
     mjesta ON zupanije.id = mjesta.idZupanija
         LEFT JOIN
     studenti ON mjesta.postbr = studenti.postBrPrebivanje
WHERE zupanije.nazivZupanija LIKE 'zadarska%';


SELECT mjesta.*, studenti.ime, studenti.prezime
FROM mjesta
         LEFT JOIN
     studenti ON mjesta.postbr = studenti.postBrPrebivanje
         JOIN
     zupanije ON mjesta.idZupanija = zupanije.id
WHERE zupanije.nazivZupanija LIKE 'zadarska%';


-- svi studenti koji slusaju fiziku i stanuju u sibensko-kninskoj
SELECT studenti.*, kolegiji.naziv, zupanije.nazivZupanija
FROM studenti
         JOIN
     mjesta ON studenti.postBrStanovanja = mjesta.postbr
         JOIN
     zupanije ON mjesta.idZupanija = zupanije.id
         JOIN
     smjerovi ON studenti.idSmjer = smjerovi.id
         JOIN
     kolegiji ON smjerovi.id = kolegiji.idSmjer
WHERE kolegiji.naziv = 'fizika'
  AND zupanije.nazivZupanija LIKE 'šibensko%';


-- sve kolegije i smjerove, prikazati sve retke obje tablice
SELECT kolegiji.*, smjerovi.*
FROM kolegiji
         LEFT JOIN smjerovi ON kolegiji.idSmjer = smjerovi.id
UNION ALL
SELECT kolegiji.*, smjerovi.*
FROM smjerovi
         LEFT JOIN kolegiji ON smjerovi.id = kolegiji.idSmjer;


SELECT kolegiji.*, smjerovi.*
FROM kolegiji
         LEFT JOIN smjerovi ON kolegiji.idSmjer = smjerovi.id
UNION ALL
SELECT kolegiji.*, smjerovi.*
FROM kolegiji
         RIGHT JOIN smjerovi ON smjerovi.id = kolegiji.idSmjer;


