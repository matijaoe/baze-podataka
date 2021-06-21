# U bazi studenti: Koristeći JOIN naredbu potrebno je ispisati sve nastavnika koji imaju titulu
# 'dr.sc.' i stanuju u Zagrebu.
SELECT DISTINCT nastavnici.*
FROM nastavnici
         JOIN mjesta ON nastavnici.postBr = mjesta.postbr
WHERE mjesta.nazivMjesto = 'Zagreb'
  AND nastavnici.titulaIspred = 'dr.sc.';

# U bazi studenti: Koristeći OUTER JOIN naredbu potrebno je ispisati
# mjesta iz kojih ne dolazi niti jedan nastavnik.
SELECT DISTINCT mjesta.*
FROM mjesta
         LEFT JOIN nastavnici ON mjesta.postbr = nastavnici.postBr
WHERE nastavnici.jmbg IS NULL;

# U bazi radionice:
# Potrebno je napisati puno vanjsko spajanje i prikazati sve podatke tablica županija, mjesta i klijenta
# na način da se mjesto odnosi na mjesto stanovanja klijenta.

SELECT zupanija.*, mjesto.*, klijent.*
FROM zupanija
         LEFT JOIN mjesto ON zupanija.sifZupanija = mjesto.sifZupanija
         LEFT JOIN klijent ON klijent.pbrKlijent = mjesto.pbrMjesto
UNION
SELECT zupanija.*, mjesto.*, klijent.*
FROM zupanija
         RIGHT JOIN mjesto ON zupanija.sifZupanija = mjesto.sifZupanija
         RIGHT JOIN klijent ON klijent.pbrKlijent = mjesto.pbrMjesto;

SELECT *
FROM zupanija
         LEFT JOIN mjesto ON zupanija.sifZupanija = mjesto.sifZupanija
         LEFT JOIN klijent ON klijent.pbrKlijent = mjesto.pbrMjesto
UNION
SELECT *
FROM zupanija
         RIGHT JOIN mjesto ON zupanija.sifZupanija = mjesto.sifZupanija
         RIGHT JOIN klijent ON klijent.pbrKlijent = mjesto.pbrMjesto;

-- tarek
/*
U bazi radionice: Ispisati sve odjele i kvarove koji su bili popravljani na istima,
a ukoliko ne postoji niti jedan kvar koji je popravljan unutar odjela,
potrebno je umjesto njega ispisati „null“ vrijednosti.
*/
SELECT *
FROM odjel
         LEFT JOIN kvar ON kvar.sifOdjel = odjel.sifOdjel;