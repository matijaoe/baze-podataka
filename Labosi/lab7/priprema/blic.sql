/*
U bazi radionice: Ispisati broj radnika po odjelima. Uz broj radnika ispisati šifru i naziv odjela. 
Rezultate je potrebno ograničiti na prvih 10 n-torki uz uzlazno sortiranje po nazivu odjela.
*/
SELECT o.sifOdjel, o.nazivOdjel, COUNT(r.sifRadnik) AS brojRadnika
FROM odjel o
         LEFT JOIN radnik r ON o.sifOdjel = r.sifOdjel
GROUP BY o.sifOdjel, o.nazivOdjel
ORDER BY o.nazivOdjel ASC
LIMIT 10;

/*
U bazi radionice: Potrebno je ispisati sumu plaća radnika po mjestu (ispisati poštanski broj i naziv).
Rezultate je potrebno ograničiti na prvih 5 n-torki.
*/
SELECT m.pbrMjesto, m.nazivMjesto, SUM(r.IznosOsnovice * r.KoefPlaca) AS placaRadnika
FROM radnik r
         JOIN mjesto m ON r.pbrStan = m.pbrMjesto
GROUP BY m.pbrMjesto, m.nazivMjesto
LIMIT 5;

/*
U bazi studenti: Potrebno je ispisati najboljih 10 studenata (ime, prezime i jmbag) po visini prosječne ocjene koji idu 
na Međimursko veleučilište u Čakovcu.
*/
SELECT studenti.ime, studenti.prezime, studenti.jmbag
FROM studenti
         JOIN ocjene o ON studenti.jmbag = o.jmbagStudent
         JOIN kolegiji k ON o.idKolegij = k.id
         JOIN smjerovi s ON k.idSmjer = s.id
         JOIN ustanove u ON s.oibUstanova = u.oib
WHERE u.naziv = 'Međimursko veleučilište u Čakovcu'
GROUP BY studenti.ime, studenti.prezime, studenti.jmbag
ORDER BY AVG(o.ocjena) DESC
LIMIT 10;
