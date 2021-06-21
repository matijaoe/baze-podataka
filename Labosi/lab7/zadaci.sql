/*
Ispisati prosjek i standardnu devijaciju ocjena dobivenih prošle godine grupirano po studentima
koji stanuju u županiji "Grad Zagreb", a koji pohađaju neki od smjerova ustanove koja se nalazi u Međimurskoj županiji.
Ukoliko postoji student koji nema ocjene, istoga je također potrebno ispisati, a umjesto srednje vrijednosti
i standardne devijacije potrebno je ispisati matematičku 0.
*/

SELECT s.jmbag,
       s.ime,
       s.prezime,
       IFNULL(AVG(o.ocjena), 0),
       IFNULL(STD(o.ocjena), 0)
FROM studenti AS s
         LEFT JOIN ocjene o ON s.jmbag = o.jmbagStudent
         JOIN mjesta mStan ON s.postBrStanovanja = mStan.postbr
         JOIN zupanije zStan ON mStan.idZupanija = zStan.id
         JOIN kolegiji k ON o.idKolegij = k.id
         JOIN smjerovi s2 ON k.idSmjer = s2.id
         JOIN ustanove u ON s2.oibUstanova = u.oib
         JOIN mjesta mUst ON mUst.postbr = u.postbr
         JOIN zupanije zUst ON zUst.id = mUst.idZupanija
WHERE zStan.nazivZupanija = 'Grad Zagreb'
  AND zUst.nazivZupanija = 'Međimurska županija'
  AND YEAR(o.datumPolaganja) = YEAR(NOW() - INTERVAL 1 YEAR)
GROUP BY s.jmbag, s.ime, s.prezime;


/*
U bazi studenti: Potrebno je ispisati koliko nastavnika živi u kojoj županiji za sve županije koje nazivu sadrže 'sko'.
Ukoliko u županiji ne živi niti jedan nastavnik, potrebno je ispisati 0 za broj nastavnika. Rezultate sortirati silazno
po broju nastavnika.
*/
SELECT zupanije.id, zupanije.nazivZupanija, COUNT(nastavnici.jmbg)
FROM zupanije
         LEFT JOIN
     mjesta ON mjesta.idZupanija = zupanije.id
         LEFT JOIN
     nastavnici ON nastavnici.postBr = mjesta.postbr
WHERE zupanije.nazivZupanija LIKE '%sko%'
GROUP BY zupanije.id, zupanije.nazivZupanija
ORDER BY COUNT(nastavnici.jmbg) DESC

/*
  U bazi studenti: Potrebno je ispisati koliko profesora (nastavnik s ulogom profesora!) živi u kojoj županiji.
  Potrebno je ispisati samo one županije koje imaju više od 3 profesora. Rezultate sortirati silazno po broju profesora.
 */
SELECT zupanije.id, zupanije.nazivZupanija, COUNT(n.jmbg) brojProfesora
FROM zupanije
         JOIN mjesta m ON zupanije.id = m.idZupanija
         JOIN nastavnici n ON m.postbr = n.postBr
         JOIN izvrsitelji i ON n.jmbg = i.jmbgNastavnik
         JOIN ulogaizvrsitelja u ON i.idUlogaIzvrsitelja = u.id
WHERE u.naziv = 'profesor'
GROUP BY zupanije.id, zupanije.nazivZupanija
HAVING brojProfesora > 3
ORDER BY brojProfesora DESC;

/*
U bazi studenti: Potrebno je ispisati 8 županija s najviše smjerova. Ispisati naziv i id županija i broj smjerova po
županijama. Rezultate sortirati po broju smjerova silazno.
*/
SELECT z.nazivZupanija, z.id, COUNT(s.id) AS brojSmjerova
FROM zupanije z
         LEFT JOIN
     mjesta m ON z.id = m.idZupanija
         LEFT JOIN
     ustanove u ON m.postbr = u.postbr
         LEFT JOIN
     smjerovi s ON u.oib = s.oibUstanova
GROUP BY z.nazivZupanija, z.id
ORDER BY brojSmjerova DESC
LIMIT 8;

/*
U bazi studenti: Potrebno je ispisati prosjek ocjena po mjestu u kojem se ustanova nalazi. Ispisati samo prosjeke
ustanova kojima je on veći od 3,4. U prosjek ne smije ići ocjena 1! Rezultate sortirati po prosjeku uzlazno.
*/
SELECT m.postbr, m.nazivMjesto, AVG(o.ocjena) AS prosjek
FROM mjesta m
         JOIN ustanove u ON m.postbr = u.postbr
         JOIN smjerovi s ON u.oib = s.oibUstanova
         JOIN kolegiji k ON s.id = k.idSmjer
         JOIN ocjene o ON k.id = o.idKolegij
WHERE o.ocjena != 1
GROUP BY m.postbr, m.nazivMjesto
HAVING prosjek > 3.4
ORDER BY prosjek;

/*
U bazi radionica: Potrebno je ispisati prosječnu plaću radnika po županiji koja u nazivu sadrži slovo 'o'. Ispisati
šifru i nazive županija te iznos prosječne plaće. Rezultate sortirati po iznosu plaće silazno. Ispis mora uključivati i
one županije kojima je prosjek 0!
*/
SELECT z.sifZupanija, z.nazivZupanija, IFNULL(AVG(r.KoefPlaca * r.IznosOsnovice), 0) placa
FROM radnik r
         RIGHT JOIN
     mjesto m ON r.pbrStan = m.pbrMjesto
         RIGHT JOIN
     zupanija z ON m.sifZupanija = z.sifZupanija
WHERE z.nazivZupanija LIKE '%o%'
GROUP BY z.sifZupanija, z.nazivZupanija
ORDER BY placa DESC;

/*
U bazi radionica: Potrebno je ispisati 6 radionica u kojima je potrošeno najmanje sati po nalozima.
Potrebno je ispisati oznaku radionice i broj utrošenih sati.
*/
SELECT r.oznRadionica, SUM(n.ostvarenisatirada) AS sati
FROM radionica r
         INNER JOIN rezervacija re ON r.oznradionica = re.oznradionica
         INNER JOIN kvar k ON re.sifkvar = k.sifkvar
         INNER JOIN nalog n ON k.sifkvar = n.sifkvar
GROUP BY r.oznRadionica
ORDER BY sati ASC
LIMIT 6;

/*
U bazi studenti: Potrebno je ispisati prosjek ocjena po mjestu stanovanja studenta koje su dobivene polaganjem prije 2 godine u veljači gledajući od trenutne godine.
Rezultate je potrebno sortirati po mjestu stanovanja uzlazno.
Potrebno je ispisati prvih 10 n-torki.
*/