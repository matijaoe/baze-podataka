#U bazi radionice: Potrebno je obrisati sve kvarove koje su popravljali radnici kojima prezime sadrži slovo a.
DELETE
FROM kvar
WHERE kvar.sifKvar IN (SELECT DISTINCT nalog.sifKvar
                       FROM nalog
                                JOIN radnik ON nalog.sifRadnik = radnik.sifRadnik
                       WHERE radnik.prezimeRadnik LIKE '%a%');

SELECT COUNT(*)
FROM kvar;

#U bazi radionice: Potrebno je svim nalozima koji su vršeni na klijentima kojima je mjesto prebivanja Zagreb podići
# ostvarene sate rada za 20%.
UPDATE nalog
SET nalog.OstvareniSatiRada = nalog.OstvareniSatiRada * 1.20
WHERE nalog.sifKlijent IN (SELECT klijent.sifKlijent
                           FROM klijent
                                    JOIN mjesto ON klijent.pbrKlijent = mjesto.pbrMjesto
                           WHERE mjesto.nazivMjesto = 'zagreb');


#U bazi studenti: Pomoću podupita potrebno je ispisati nastavnike (sve kolone) koji ne predaju niti na jednom kolegiju.
SELECT nastavnici.*
FROM nastavnici
WHERE nastavnici.jmbg NOT IN (SELECT izvrsitelji.jmbgNastavnik FROM izvrsitelji);

# ime i prezimena studenata koji nemaju nijednu ocjenu
SELECT studenti.ime, studenti.prezime
FROM studenti
where studenti.jmbag not in (select ocjene.jmbagStudent from ocjene)