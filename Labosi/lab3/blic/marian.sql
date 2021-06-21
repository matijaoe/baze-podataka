/* U bazi radionice: Ispišite ukupan broj radnika. */
SELECT COUNT(*)
FROM radnik;

/* U bazi studenti: Potrebno je ispisati sve studente kojima je drugo slovo imena "a" */
SELECT *
FROM studenti
WHERE ime LIKE '_a%';

/* U bazi studenti: Potrebno je ispisati koliko je nastavnika s adresom u Zagrebu(10000). */
SELECT COUNT(*)
FROM nastavnici
WHERE postBr = 10000;

/* U bazi studenti: Potrebno je ispisati zadnja 3 slova naziva mjesta velikim slovima. */
SELECT UPPER(RIGHT(nazivMjesto, 3))
FROM mjesta;