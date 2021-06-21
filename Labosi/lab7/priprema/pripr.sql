/*
Ispisati prosjek i standardnu devijaciju ocjena dobivenih prošle godine grupirano po studentima
koji stanuju u mjestu "Zagreb", a koji pohađaju neki od smjerova ustanove koja se nalazi u mjestu "Varaždin".
Ukoliko postoji student koji nema ocjene, istoga je također potrebno ispisati, a umjesto srednje vrijednosti
i standardne devijacije potrebno je ispisati matematičku 0.
*/
SELECT s.jmbag,
       s.ime,
       s.prezime,
       IFNULL(AVG(o.ocjena), 0),
       IFNULL(STD(o.ocjena), 0)
FROM studenti.studenti AS s
         LEFT JOIN ocjene o ON s.jmbag = o.jmbagStudent
         JOIN mjesta mStan ON s.postBrStanovanja = mStan.postbr
         JOIN kolegiji k ON o.idKolegij = k.id
         JOIN smjerovi s2 ON k.idSmjer = s2.id
         JOIN ustanove u ON s2.oibUstanova = u.oib
         JOIN mjesta mUst ON mUst.postbr = u.postbr
WHERE mUst.nazivMjesto = 'Varaždin'
  AND mStan.nazivMjesto = 'Zagreb'
  AND YEAR(o.datumPolaganja) = YEAR(NOW() - INTERVAL 1 YEAR)
GROUP BY s.jmbag, s.ime, s.prezime;

/*
U bazi studenti: Potrebno je ispisati koliko
nastavnika živi u kojoj županiji. Ukoliko u županiji
ne živi niti jedan nastavnik, potrebno je
ispisati 0 za broj nastavnika. Rezultate
sortirati silazno po broju nastavnika.
*/
SELECT zupanije.id, zupanije.nazivZupanija, IFNULL(COUNT(n.jmbg), 0) AS 'Broj nastavnika'
FROM zupanije
         LEFT JOIN mjesta m ON zupanije.id = m.idZupanija
         LEFT JOIN nastavnici n ON m.postbr = n.postBr
GROUP BY zupanije.id, zupanije.nazivZupanija;

/*
U bazi studenti:
Potrebno je ispisati koliko !profesora! živi u kojoj županiji.
Potrebno je ispisati samo one županije koje imaju više od 3 profesora.
Rezultate sortirati silazno po broju profesora.
*/

SELECT z.id AS id, z.nazivZupanija AS naziv, COUNT(n.jmbg) brProf
FROM nastavnici n
         INNER JOIN izvrsitelji i ON n.jmbg = i.jmbgNastavnik
         INNER JOIN ulogaIzvrsitelja ul ON i.idUlogaIzvrsitelja = ul.id
         INNER JOIN mjesta m ON n.postBr = m.postbr
         INNER JOIN zupanije z ON m.idZupanija = z.id
WHERE ul.naziv LIKE '%prof%'
GROUP BY id, naziv
HAVING brProf > 3
ORDER BY brProf DESC;

/*
U bazi studenti:
Potrebno je ispisati 5 mjesta s najviše smjerova.
Ispisati nazive mjesta i broj smjerova po mjestima.
Rezultate sortirati po broju smjerova silazno.
*/
SELECT m.nazivMjesto, m.postbr, COUNT(s.id) AS brojSmjerova
FROM mjesta m
         JOIN ustanove u ON m.postbr = u.postbr
         JOIN smjerovi s ON u.oib = s.oibUstanova
GROUP BY m.nazivMjesto, m.postbr
ORDER BY brojSmjerova DESC
LIMIT 5;


/*
U bazi radionice: Ispisati broj radnika po županijama čiji nazivi mjesta imaju broj znakova manji od 10. 
Uz broj radnika ispisati i nazive županija.
Potrebno je ispisati samo one vrijednosti kod kojih je broj radnika manji od 5 na način da ukoliko u županiji ne postoji 
ni jedan radnik, županiju je svejedno potrebno ispisati. Rezultate je potrebno ograničiti na prvih 15 n-torki sortiranih 
po broju radnika uzlazno.
*/
SELECT z.nazivZupanija, COUNT(r.sifRadnik) AS brojRadnika
FROM radnik r
         RIGHT JOIN mjesto m ON m.pbrMjesto = r.pbrStan
         JOIN zupanija z ON m.sifZupanija = z.sifZupanija
WHERE LENGTH(m.nazivMjesto) < 10
GROUP BY z.nazivZupanija, z.sifZupanija
HAVING brojRadnika < 5
ORDER BY COUNT(r.sifRadnik)
LIMIT 15;

/*
U bazi radionice: Ispisati broj klijenata po županijama stanovanja čiji nazivi mjesta na drugoj poziciji sadrži slovo "a". 
Uz broj klijenata ispisati i nazive županija.
Potrebno je ispisati samo one vrijednosti kod kojih je broj klijenata manji od 5 na način da ukoliko u županiji ne 
postoji ni jedan klijent, županiju je svejedno potrebno ispisati. Rezultate je potrebno ograničiti na prvih 10 n-torki 
sortiranih po broju klijenata uzlazno.
*/
SELECT z.nazivZupanija, COUNT(k.pbrKlijent) AS brojKlijenata
FROM klijent k
         JOIN mjesto m ON m.pbrMjesto = k.pbrKlijent
         RIGHT JOIN zupanija z ON m.sifZupanija = z.sifZupanija
WHERE SUBSTR(m.nazivMjesto, 2, 1) = 'a'
GROUP BY z.nazivZupanija, z.sifZupanija
HAVING brojKlijenata < 5
ORDER BY brojKlijenata ASC
LIMIT 10;

SELECT zu.sifZupanija, zu.nazivZupanija, COUNT(kl.sifKlijent) AS cnt
FROM klijent kl
         RIGHT JOIN mjesto mj ON mj.pbrMjesto=kl.pbrKlijent
         RIGHT JOIN zupanija zu ON zu.sifZupanija=mj.sifZupanija
WHERE mj.nazivMjesto LIKE '_a%'
GROUP BY zu.sifZupanija, zu.nazivZupanija
HAVING cnt < 5
ORDER BY cnt ASC
LIMIT 10