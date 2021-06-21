# U bazi radionice: Potrebno je svim nalozima koji su vršeni na klijentima kojima je mjesto prebivanja Zagreb
# podići ostvarene sate rada za 20%.

UPDATE nalog
SET nalog.OstvareniSatiRada = nalog.OstvareniSatiRada * 1.2
WHERE nalog.sifKlijent IN (
    SELECT klijent.sifKlijent
    FROM klijent
             JOIN mjesto ON klijent.pbrKlijent = mjesto.pbrMjesto
    WHERE mjesto.nazivMjesto = 'Zagreb'
);

# U bazi radionice: Potrebno je obrisati sve naloge na kojima su radili radnici iz mjesta Split.
DELETE
FROM nalog
WHERE nalog.sifRadnik IN (
    SELECT radnik.sifRadnik
    FROM radnik
             JOIN mjesto ON radnik.pbrStan = mjesto.pbrMjesto
    WHERE mjesto.nazivMjesto = 'Split');

# U bazi studenti Potrebno je ispisati sve kolone tablice studenata koji imaju nadprosječne ocjene.
SELECT DISTINCT studenti.*
FROM studenti
         JOIN ocjene o ON studenti.jmbag = o.jmbagStudent
WHERE o.ocjena > (SELECT AVG(ocjene.ocjena) FROM ocjene);
