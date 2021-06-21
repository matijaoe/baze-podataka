SELECT KoefPlaca
FROM radionica.radnik
ORDER BY KoefPlaca DESC;

# 1
SELECT MAX(KoefPlaca)
FROM radionica.radnik;

# 2
SELECT MIN(ocjena)
FROM studenti.ocjene
WHERE jmbagStudent = '0128055514';

# 3
SELECT UPPER(CONCAT_WS(' ', imeKlijent, prezimeKlijent)) AS klijent
FROM radionica.klijent;

# 4
SELECT CONCAT(LEFT(imeRadnik, 1), '.', LEFT(prezimeRadnik, 1), '.') AS inicijali
FROM radionica.radnik;

# 5
SELECT naziv, CHAR_LENGTH(naziv)
FROM studenti.kolegiji;

# 6
# SELECT *
# FROM radionica.mjesto
# WHERE sifZupanija = 5
#    OR sifZupanija = 8
#    OR sifZupanija = 11;

SELECT *
FROM radionica.mjesto
WHERE sifZupanija IN (5, 8, 11);


# 7
SELECT COUNT(*)
FROM studenti.studenti
WHERE idSmjer = 1;

# 8
SELECT ime, prezime, jmbag
FROM studenti.studenti
WHERE jmbag LIKE '119%';

# 9
SELECT imeKlijent, prezimeKlijent
FROM radionica.klijent
WHERE CHAR_LENGTH(imeKlijent) = CHAR_LENGTH(prezimeKlijent);

# 10
SELECT *
FROM studenti.nastavnici
WHERE LEFT(ime, 1) = RIGHT(prezime, 1);
