-- U bazi radionice: Ispišite maksimalan iznos koeficijenta plaće iz tablice radnik.
SELECT MAX(KoefPlaca)
FROM radnik;

-- U bazi studenti: Potrebno je ispisati sve studente koji imaju jednaku duljinu imena i prezimena u broju znakova.
SELECT *
FROM studenti
WHERE LENGTH(ime) = LENGTH(prezime);

-- U bazi studenti: Potrebno je ispisati studente koji stanuju u Zagrebu (10000).
SELECT *
FROM studenti
WHERE postBrStanovanja = 10000;

-- U bazi radionice: Potrebno je ispisati zadnja slova imena i prezimena svih klijenata u jednoj koloni. Na primjer, ukoliko je klijentu ime "Ivan", a prezime "Horvat" potrebno je ispisati "nt".
SELECT CONCAT(RIGHT(imeKlijent, 1), RIGHT(prezimeKlijent, 1))
FROM klijent;