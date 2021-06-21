/* AGREGATNE FUNKCIJE */
SELECT (SUM(ocjena) / COUNT(ocjena))
FROM ocjene
WHERE idKolegij = 6;

/* WHERE S FUNKCIJAMA */
SELECT *
FROM klijent
WHERE LEFT(imeKlijent, 1) = RIGHT(prezimeKlijent, 1);

/* WHERE */
SELECT *
FROM klijent
WHERE datUnosKlijent BETWEEN '2016-10-10' AND '2017-10-10';

/* STRING FUNKCIJE */
SELECT CONCAT(imeKlijent, ':', prezimeKlijent)
           AS imeIPrezimeKlijent
FROM klijent;