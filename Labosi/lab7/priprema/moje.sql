/* 1. U bazi radionice: Ispisati sumu sati kvara i broja radnika grupiranu po nazivu odjela. Potrebno
je ispisati samo one n-torke koje čiji je broj sati kvara veći od 1. Rezultate je potrebno
sortirati po sumi broja radnika uzlazno. Rezultate je potrebno ograničiti na prvih 5 n-torki.*/
SELECT odjel.nazivOdjel, odjel.sifOdjel, SUM(kvar.satiKvar) AS brojSati, SUM(kvar.brojRadnika) AS brojRadnika
FROM kvar
         JOIN odjel ON kvar.sifOdjel = odjel.sifOdjel
GROUP BY odjel.nazivOdjel, odjel.sifOdjel
HAVING brojSati > 1
ORDER BY brojRadnika ASC
LIMIT 5;


/* 2. U bazi radionice: Potrebno je ispisati sumu plaća radnika po mjestu. Rezultate je potrebno
ograničiti na prvih 5 n-torki.*/
SELECT mjesto.nazivMjesto, SUM(radnik.IznosOsnovice * radnik.KoefPlaca) AS placaRadnika
FROM radnik
         JOIN mjesto ON radnik.pbrStan = mjesto.pbrMjesto
GROUP BY mjesto.nazivMjesto, mjesto.pbrMjesto
LIMIT 5;


/* 3. U bazi radionice: Ispisati broj kvarova po odjelima. Uz broj kvarova ispisati nazive odjela.
Rezultate je potrebno uzlazno sortirati po broju kvarova.*/
SELECT odjel.nazivOdjel, COUNT(k.sifKvar) AS brojKvarova
FROM odjel
         LEFT JOIN kvar k ON odjel.sifOdjel = k.sifOdjel
GROUP BY odjel.nazivOdjel, odjel.nazivOdjel
ORDER BY brojKvarova ASC;


/* 4. U bazi studenti: Potrebno je ispisati broj studenata po mjestu stanovanja. Ukoliko ne postoji
ni jedan student u određenom mjestu, mjesto je potrebno ispisati, a za broj studenata mora
biti 0. Potrebno je ispisati samo ona mjesta koja imaju manje od 10 studenata. Rezultate je
potrebno ograničiti na prvih 20 n-torki.*/
SELECT mjesta.nazivMjesto, mjesta.postBr, COUNT(s.jmbag) AS brojStudenata
FROM studenti AS s
         RIGHT JOIN mjesta ON s.postBrStanovanja = mjesta.postbr
GROUP BY mjesta.nazivMjesto, mjesta.postbr
HAVING brojStudenata < 10
LIMIT 20;


/* 5. U bazi studenti: Potrebno je ispisati prosječne ocjene studenata po županiji stanovanja.
Rezultate je potrebno sortirati po prosjeku silazno i ograničiti na prvih 10 n-torki.*/
SELECT z.nazivZupanija, AVG(o.ocjena) AS prosjekOcjena
FROM studenti
         JOIN mjesta m ON studenti.postBrStanovanja = m.postbr
         JOIN zupanije z ON z.id = m.idZupanija
         JOIN ocjene o ON studenti.jmbag = o.jmbagStudent
GROUP BY z.nazivZupanija, z.id
ORDER BY prosjekOcjena DESC
LIMIT 10;


/* 6. U bazi studenti: Potrebno je ispisati broj nastavnika koji su u ulozi asistenta po ustanovi.
Rezultate je potrebno sortirati uzlazno po broju nastavnika*/
SELECT ustanove.naziv, ustanove.oib, COUNT(nastavnici.jmbg) AS brojAsistenata
FROM nastavnici
         JOIN izvrsitelji ON nastavnici.jmbg = izvrsitelji.jmbgNastavnik
         JOIN ulogaizvrsitelja uloga ON izvrsitelji.idUlogaIzvrsitelja = uloga.id
         JOIN kolegiji ON kolegiji.id = izvrsitelji.idKolegij
         JOIN smjerovi ON kolegiji.idSmjer = smjerovi.id
         JOIN ustanove ON smjerovi.oibUstanova = ustanove.oib
WHERE uloga.id = 2
GROUP BY ustanove.naziv, ustanove.oib
ORDER BY brojAsistenata ASC;

