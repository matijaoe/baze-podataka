/*
U bazi studenti potrebno je kreirati novi FULLTEXT indeks naziva ftix_06 na tablici smjerovi na koloni naziv.
Nakon toga potrebno je kreirati upit koji traži pomoću FULLTEXT indeksa i ispisuje sve smjerove koji u nazivu sadrže
riječ „smjer“.
*/


CREATE FULLTEXT INDEX ftix_06 ON smjerovi (naziv);

SELECT *
FROM smjerovi
WHERE MATCH(naziv)
            AGAINST('smjer' IN NATURAL LANGUAGE MODE);

/*
U bazi studenti: Potrebno je kreirati novi indeks naziva ix_05 na tablici studenti koji
obuhvaća kolonu prezime i koristi binarno stablo.
*/
CREATE INDEX ix_05 ON studenti (prezime) USING BTREE;

/*
U bazi studenti: Potrebno je kreirati tablicu „podsmjerovi“ koja izgleda kao u nastavku:
idPodsmjer INT
naziv varchar(100)
opis text
idSmjer INT
Tablica „podsmjerovi“ ima primarni ključ na atributu „idPodsmjer“ s tim da ga baza podataka mora sama
slijedno dodjeljivati.
Nad atributom „naziv“ je potrebno kreirati indeks koji koristi BTREE, a nad atributom „idSmjer“
potrebno je kreirati strani ključ koji je vezan na „smjerovi.id“ atribut na bazi podataka.
*/
CREATE TABLE podsmjerovi
(
    idPodsmjer INT PRIMARY KEY AUTO_INCREMENT,
    naziv      VARCHAR(100),
    opis       TEXT,
    idSmjer    INT,
    INDEX (naziv) USING BTREE,
    FOREIGN KEY (idSmjer) REFERENCES smjerovi (id)
);
