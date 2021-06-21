SELECT AVG(IznosOsnovice * KoefPlaca + 350)
FROM radnik;

SELECT COUNT(DISTINCT ime)
FROM studenti;

SELECT UPPER(CONCAT(RIGHT(ime, 1), RIGHT(prezime, 1)))
FROM studenti;

# dobih ovdje bod hehe
SELECT *
FROM mjesta
WHERE postbr IN (10000, 20000, 42000, 10430);

SELECT *
FROM mjesta
WHERE postbr BETWEEN 10000 AND 20000;


SELECT *
FROM studenti
WHERE LENGTH(prezime) = LENGTH(ime) + 4;

SELECT *
FROM studenti
WHERE LEFT(ime, 1) = RIGHT(prezime, 1);

SELECT *
FROM studenti
WHERE SUBSTR(ime, 3, 1) = 't';

SELECT *
FROM studenti
WHERE CONCAT(SUBSTR(ime, 2, 1), SUBSTR(prezime, 3, 1), SUBSTR(prezime, 4, 1)) = 'emi';

SELECT *
FROM studenti
WHERE ime LIKE '_e%'
  AND prezime LIKE '__mi%';

SELECT STR_TO_DATE(jmbg, '%d%m9%y')
FROM nastavnici;

SELECT CONCAT(SUBSTRING(jmbg, 1, 2), '.', SUBSTRING(jmbg, 3, 2), '.', SUBSTRING(jmbg, 5, 2), '.')
FROM nastavnici;

SELECT *
FROM nastavnici
WHERE LEFT(ime, 1) = 's'
  AND SUBSTRING(ime, 3, 1) = 'j'
  AND lozinka = MD5('StjepanLukić');

SELECT *
FROM studenti
WHERE prezime NOT REGEXP '[đčćšž]';

SELECT *
FROM studenti
WHERE prezime REGEXP '[đčćšž]';

SELECT COUNT(*)
FROM studenti
WHERE SUBSTR(jmbag, 1, 4) = 0036;