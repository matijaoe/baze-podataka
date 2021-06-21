/*U bazi radionice: Potrebno je kreirati tablicu „komentari“ koja izgleda kao u nastavku:
komentari:
sifKomentar INT
naslovKomentar varchar(100)
komentar text
sifKlijent INT
Tablica „komentari“ ima primarni ključ na atributu „sifKomentar“ s tim da ga baza podataka 
mora sama slijedno dodjeljivati. Nad atributom „naslovKomentar“ je potrebno kreirati indeks 
koji koristi BTREE, a nad atributom „sifKlijent“ potrebno je kreirati strani ključ koji je 
vezan na „klijent.sifKlijent“ atribut na bazi podataka. 
*/

CREATE TABLE komentari(
sifKomentar INT PRIMARY KEY AUTO_INCREMENT,
naslovKomentar VARCHAR(100),
komentar TEXT,
sifKlijent INT,
INDEX (naslovKomentar) USING BTREE,
FOREIGN KEY (sifKlijent) REFERENCES klijent(sifKlijent)
);


/*U bazi studenti: Potrebno je kreirati tablicu „podsmjerovi“ koja izgleda kao u nastavku:
idPodsmjer INT
naziv varchar(100)
opis text
idSmjer INT
Tablica „podsmjerovi“ ima primarni ključ na atributu „idPodsmjer“ s tim da ga baza podataka 
mora sama slijedno dodjeljivati. Nad atributom „naziv“ je potrebno kreirati indeks koji koristi 
BTREE, a nad atributom „idSmjer“ potrebno je kreirati strani ključ koji je vezan na „smjerovi.id“ 
atribut na bazi podataka.
*/

CREATE TABLE podsmjerovi(
idPodsmjer INT PRIMARY KEY AUTO_INCREMENT,
naziv VARCHAR(100),
opis TEXT,
idSmjer INT,
INDEX (naziv) USING BTREE,
FOREIGN KEY (idSmjer) REFERENCES smjerovi(id)
);

/*U bazi radionice: Potrebno je kreirati novi indeks na tablici radnik na kolone ime i prezime koji koristi BTREE.*/

CREATE INDEX ix_radnik_ime_prezime ON radnik(imeRadnik, prezimeRadnik) USING BTREE;
/*ili*/
ALTER TABLE radnik
ADD INDEX ix_radnik_ime_prezime (imeRadnik, prezimeRadnik) USING BTREE;

/*U bazi studenti: Potrebno je kreirati novi indeks na tablici studenti na kolonu prezime koji koristi BTREE.*/

CREATE INDEX ix_studenti_prezime ON studenti(prezime) USING BTREE;
/*ili*/
ALTER TABLE studenti
ADD INDEX ix_studenti_prezime (prezime) USING BTREE;

/*U bazi radionice potrebno je kreirati novi FULLTEXT indeks na tablici kvar na koloni nazivKvar. 
Nakon toga potrebno je kreirati upit koji traži pomoću FULLTEXT indeksa sve kvarove koji u nazivu 
sadrže riječ „Zamjena“.*/

CREATE FULLTEXT INDEX ix_kvar_full ON kvar(nazivKvar);
/*ili*/
ALTER TABLE kvar
ADD FULLTEXT INDEX ix_kvar_full (nazivKvar);

/*Drugi dio zadatka:*/
SELECT * FROM kvar
WHERE MATCH(nazivKvar)
AGAINST ('Zamjena' IN NATURAL LANGUAGE MODE);


/*U bazi studenti potrebno je kreirati novi FULLTEXT indeks na tablici kolegiji na koloni opis. 
Nakon toga potrebno je kreirati upit koji traži pomoću FULLTEXT indeksa sve kolegije koji u opisu 
sadrže riječ „savladati“. Rangirati rezultate sa izbačenim ne relevantnim rezultatima.*/

CREATE FULLTEXT INDEX ix_kolegiji_full ON kolegiji(opis);
/*ili*/
ALTER TABLE kolegiji
ADD FULLTEXT INDEX ix_kolegiji_full (opis);

/*Drugi dio zadatka:*/
SELECT kolegiji.*, MATCH(opis) 
AGAINST('savladati' IN NATURAL LANGUAGE MODE) AS rang
FROM kolegiji
HAVING rang>0
ORDER BY rang DESC;