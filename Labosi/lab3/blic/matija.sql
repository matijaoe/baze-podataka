-- U bazi studenti: Potrebno je ispisati najveću ocjenu studenta sa jmbag-om 0112052200.
SELECT MAX(ocjena)
FROM ocjene
WHERE jmbagStudent = '0112052200';

-- U bazi studenti: Potrebno je ispisati sve nastavnike kojima je drugo slovo imena i treće i četvrto slovo prezimena tvore "eri"
SELECT *
FROM nastavnici
WHERE ime LIKE '_e%'
  AND prezime LIKE '__ri%';

SELECT *
FROM nastavnici
WHERE CONCAT(SUBSTR(ime, 2, 1), SUBSTR(prezime, 3, 2)) = 'eri';

-- U bazi studenti: Potrebno je ispisati koliko je nastavnika s adresom u Zagrebu(10000).
SELECT COUNT(*)
FROM nastavnici
WHERE postBr = 10000;

-- U bazi studenti: Potrebno je ispisati nastavnike u jednom stupcu na način da se ispiše "titula ispred ime prezime titula iza".
SELECT CONCAT_WS(' ', titulaIspred, ime, prezime, titulaIza)
FROM nastavnici;