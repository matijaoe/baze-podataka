/*Prikaz storage enginea*/
SHOW ENGINES;


/*Spusti tablicu adrese ako postoji*/
DROP TABLE IF EXISTS adrese;

/*Kreiranje tablice s primarnim ključem i indeksom*/
CREATE TABLE adrese
(
    id      INT AUTO_INCREMENT PRIMARY KEY,
    grad    VARCHAR(50),
    ulica   VARCHAR(50),
    kucniBr VARCHAR(5),
    UNIQUE INDEX (grad, ulica, kucniBr) USING HASH
);

/*Ispiši indekse na tablici*/
SHOW INDEX FROM adrese;
/*Primjetite tip indexa!!!*/


/*Kreiraj još jedan index*/
CREATE INDEX jos_jedan_index ON adrese (ulica) USING BTREE;

/*Obriši indeks*/
DROP INDEX jos_jedan_index ON adrese;


/*FTS*/
ALTER TABLE kolegiji
    DROP INDEX NekiOpis;

SHOW INDEX FROM kolegiji;


ALTER TABLE kolegiji
    ADD FULLTEXT INDEX NekiOpis (naziv, opis);


/*Pretraga*/
SELECT *
FROM kolegiji
WHERE MATCH (naziv, opis)
            AGAINST('baze' IN NATURAL LANGUAGE MODE);



SELECT *
FROM kolegiji
WHERE MATCH(naziv, opis)
            AGAINST('baze' IN NATURAL LANGUAGE MODE);

/*potrebno je pretraživati isključivo po kolonama na kojima je index*/

# nece radit
SELECT *
FROM kolegiji
WHERE MATCH(opis)
            AGAINST('baze' IN NATURAL LANGUAGE MODE);


/*Rangiranje*/
SELECT kolegiji.*,
       MATCH(naziv, opis)
             AGAINST('baze podataka' IN NATURAL LANGUAGE MODE) AS rang
FROM kolegiji
HAVING rang > 0 #Ovo je ako želimo samo one koji imaju nešto korisno
ORDER BY rang DESC;

/*Rangiranje*/
/*SELECT kolegiji.*,
       MATCH(naziv, opis)
             AGAINST('baze podataka' IN NATURAL LANGUAGE MODE)
FROM kolegiji
where MATCH(naziv, opis)
            AGAINST('baze podataka' IN NATURAL LANGUAGE MODE) > 0 #Ovo je ako želimo samo one koji imaju nešto korisno
ORDER BY rang DESC;*/


/*Bez HAVING*/
SELECT kolegiji.*,
       MATCH(naziv, opis)
             AGAINST('baze podataka' IN NATURAL LANGUAGE MODE) AS rang
FROM kolegiji
ORDER BY rang DESC;


# moje

CREATE FULLTEXT INDEX moja_pretraga ON kolegiji (naziv, opis);

SHOW INDEX FROM kolegiji;

SELECT *
FROM kolegiji
WHERE MATCH(naziv, opis)
            AGAINST('baze' IN NATURAL LANGUAGE MODE);

SELECT *
FROM kolegiji
WHERE naziv LIKE '%baze%'
   OR opis LIKE '%baze%';