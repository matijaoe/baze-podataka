#U bazi radionice: Potrebno je obrisati sve kvarove koje su popravljali radnici kojima prezime sadrži slovo a.
DELETE
FROM kvar
WHERE kvar.sifKvar IN (
    SELECT nalog.sifKvar
    FROM nalog
             JOIN radnik ON nalog.sifRadnik = radnik.sifRadnik
    WHERE radnik.prezimeRadnik LIKE '%a%');


#U bazi radionice: Potrebno je svim nalozima koji su vršeni na klijentima kojima je mjesto prebivanja Zagreb podići
# ostvarene sate rada za 20%.
UPDATE nalog
SET nalog.OstvareniSatiRada = nalog.OstvareniSatiRada * 1.2
WHERE nalog.sifKlijent IN (
    SELECT klijent.sifKlijent
    FROM klijent
             JOIN mjesto ON klijent.pbrKlijent = mjesto.pbrMjesto
    WHERE mjesto.nazivMjesto = 'Zagreb'
);


#U bazi studenti: Pomoću podupita potrebno je ispisati nastavnike (sve kolone) koji ne predaju niti na jednom kolegiju.
SELECT nastavnici.*
FROM nastavnici
WHERE nastavnici.jmbg NOT IN (SELECT izvrsitelji.jmbgNastavnik
                              FROM izvrsitelji
);

# ------------------ grader mislav ----------------------------

/*
U bazi studenti: Potrebno je svim nastavnicima koji predaju na kolegiju Fizika promjeniti titulu iza u dr.sc.
*/

UPDATE nastavnici
SET nastavnici.titulaIza = 'dr.sc'
WHERE nastavnici.jmbg IN (SELECT i.jmbgNastavnik
                          FROM izvrsitelji i
                                   JOIN kolegiji k ON i.idKolegij = k.id
                          WHERE k.naziv = 'Fizika'
);

/*
U bazi radionice: Ispisati nazive kvarova i vrijednosti satiKvar-a koji su veći od bilo koje vrijednosti satServisa
iz tablice rezervacija.
*/


SELECT kvar.nazivKvar, kvar.satiKvar
FROM kvar
WHERE kvar.satiKvar > ANY (SELECT rezervacija.satServis FROM rezervacija)

/*
U bazi studenti: Potrebno je izbrisati one ocjene koje su dodjeljene studentima koji prebivaju u Zagrebu.
*/
DELETE
FROM ocjene
WHERE ocjene.jmbagStudent IN (SELECT studenti.jmbag
                              FROM studenti
                                       JOIN mjesta m ON studenti.postBrPrebivanje = m.postbr
                              WHERE m.nazivMjesto = 'Zagreb');

# ----------------------------------------------------------------

/*
U bazi studenti: Promjeniti naziv županija u kojima ne stanuje niti jedan student niti nastavnik i u kojima nema niti
jedne ustanove u "Vukojebina"
*/

UPDATE zupanije
SET zupanije.nazivZupanija = 'Vukojebina'
WHERE zupanije.id NOT IN
      (SELECT mjesta.idZupanija
       FROM mjesta
                JOIN studenti s ON mjesta.postbr = s.postBrPrebivanje)
  AND zupanije.id NOT IN
      (SELECT mjesta.idZupanija
       FROM mjesta
                JOIN nastavnici n ON mjesta.postbr = n.postBr)
  AND zupanije.id NOT IN
      (SELECT mjesta.idZupanija
       FROM mjesta
                JOIN ustanove u ON mjesta.postbr = u.postbr);

/*
U bazi studenti: Ispisati prosjek ocjena na najstarijoj ustanovi.
*/
SELECT AVG(ocjene.ocjena)
FROM ocjene
         JOIN kolegiji k ON ocjene.idKolegij = k.id
         JOIN smjerovi s ON s.id = k.idSmjer
         JOIN ustanove u ON s.oibUstanova = u.oib
WHERE u.datumOsnutka = (SELECT MIN(ustanove.datumOsnutka) FROM ustanove);

/*
U bazi studenti: Ispisati id i naziv smjera, te naziv njegovog nadsmjera pomoću podupita.
*/

/*
U bazi radionica: Pomoću podupita ispisati sva mjesta gdje žive klijenti ali nije registriran niti jedan automobil.
*/
SELECT mjesto.*
FROM mjesto
WHERE mjesto.pbrMjesto NOT IN (SELECT klijent.pbrReg
                               FROM klijent
                                        JOIN mjesto ON klijent.pbrReg = mjesto.pbrMjesto)
  AND mjesto.pbrMjesto IN (SELECT klijent.pbrKlijent
                           FROM klijent
                                    JOIN mjesto ON klijent.pbrKlijent = mjesto.pbrMjesto)

/*
U bazi radionice: Ispisati sve radnike koji imaju plaću veću od prosječne plaće uvećane za 500 kn.
*/
SELECT radnik.*
FROM radnik
WHERE radnik.KoefPlaca * radnik.IznosOsnovice > (SELECT AVG(radnik.IznosOsnovice * radnik.KoefPlaca) FROM radnik) + 500;


/*
U bazi studenti: Potrebno je izbrisati one izvršitelje u koje spadaju nastavnici čije prezime počinje sa V.
*/
DELETE
FROM izvrsitelji
WHERE izvrsitelji.jmbgNastavnik IN
      (SELECT nastavnici.jmbg FROM nastavnici WHERE nastavnici.prezime LIKE 'V%')


/*
U bazi radionice: Potrebno je obrisati sve naloge na kojima su radili radnici iz županije Grad Zagreb.
*/
DELETE
FROM nalog
WHERE nalog.sifRadnik IN (SELECT radnik.sifRadnik
                          FROM radnik
                                   JOIN mjesto ON radnik.pbrStan = mjesto.pbrMjesto
                                   JOIN zupanija z ON z.sifZupanija = mjesto.sifZupanija
                          WHERE z.nazivZupanija = 'Grad Zagreb')


/*
U bazi radionice: Ispisati nazive kvarova i vrijednosti satiKvar-a koji su veći od bilo koje vrijednosti satServisa iz tablice rezervacija.
*/


/*
U bazi radionice: Pomoću podupita potrebno je uz svako mjesto ispisati koliko klijenata u tom mjestu stanuje i koliko ih ima registriran automobil.
*/


/*
U bazi studenti: Pomoću podupita potrebno je prikazati studente koji su se prvi upisali.
*/

/*
U bazi radionice: Ispisati sve radnike s ispodprosječnim plaćama.
*/


/*
U bazi studenti: Ispisati sve studente koji imaju ocjene unutar prosjeka +-10%.
*/


/*
U bazi studenti: Pomoću podupita potrebno je ispisati sve gradove u kojima ne prebiva niti jedan student.
*/



