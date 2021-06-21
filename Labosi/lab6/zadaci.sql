SELECT DISTINCT klijent.*, zReg.nazivZupanija, zStan.nazivZupanija
FROM klijent
         INNER JOIN
     nalog ON klijent.sifKlijent = nalog.sifKlijent
         INNER JOIN
     radnik ON nalog.sifRadnik = radnik.sifRadnik
         INNER JOIN
     mjesto mStan ON radnik.pbrStan = mStan.pbrMjesto
         INNER JOIN
     zupanija zStan ON mStan.sifZupanija = zStan.sifZupanija
         INNER JOIN
     mjesto mReg ON mReg.pbrMjesto = klijent.pbrReg
         INNER JOIN
     zupanija zReg ON zReg.sifZupanija = mReg.sifZupanija
         INNER JOIN
     mjesto mKlijent ON klijent.pbrKlijent = mKlijent.pbrMjesto
WHERE (RIGHT(klijent.prezimeKlijent, 1) <> RIGHT(radnik.prezimeRadnik, 1))
  AND (mKlijent.pbrMjesto = mStan.pbrMjesto);

SELECT DISTINCT kolegiji.naziv
FROM kolegiji
         JOIN ocjene o ON kolegiji.id = o.idKolegij
         JOIN studenti s ON o.jmbagStudent = s.jmbag
         JOIN mjesta ms ON s.postBrStanovanja = ms.postbr
         JOIN zupanije zs ON ms.idZupanija = zs.id
         JOIN mjesta msp ON s.postBrPrebivanje = msp.postbr
         JOIN zupanije zsp ON msp.idZupanija = zs.id
         JOIN izvrsitelji i ON kolegiji.id = i.idKolegij
         JOIN nastavnici n ON i.jmbgNastavnik = n.jmbg
         JOIN mjesta mn ON n.postBr = mn.postbr
         JOIN zupanije zn ON mn.idZupanija = zn.id
WHERE zn.id <> zs.id;

SELECT DISTINCT kolegiji.naziv
FROM kolegiji
         JOIN izvrsitelji i ON kolegiji.id = i.idKolegij
         JOIN nastavnici n ON i.jmbgNastavnik = n.jmbg
         JOIN mjesta m ON n.postBr = m.postbr
         JOIN zupanije z ON m.idZupanija = z.id
         JOIN ocjene o ON kolegiji.id = o.idKolegij
         JOIN studenti s ON o.jmbagStudent = s.jmbag
         JOIN mjesta m2 ON s.postBrPrebivanje = m2.postbr
         JOIN zupanije z2 ON m2.idZupanija = z2.id
         JOIN mjesta m3 ON s.postBrStanovanja = m3.postbr
         JOIN zupanije z3 ON m3.idZupanija = z3.id
WHERE (z.nazivZupanija != z2.nazivZupanija)
  AND (z.nazivZupanija != z3.nazivZupanija)
  AND (z2.nazivZupanija != z3.nazivZupanija);

SELECT zstan.*, zpreb.*
FROM studenti
         JOIN mjesta mstan ON studenti.postBrStanovanja = mstan.postbr
         JOIN zupanije zstan ON mstan.idZupanija = zstan.id
         JOIN mjesta mpreb ON studenti.postBrPrebivanje = mpreb.postbr
         JOIN zupanije zpreb ON mpreb.idZupanija = zpreb.id
         JOIN ocjene o ON studenti.jmbag = o.jmbagStudent
         JOIN kolegiji k ON o.idKolegij = k.id
         JOIN smjerovi s ON k.idSmjer = s.id
         JOIN ustanove u ON s.oibUstanova = u.oib
         JOIN mjesta must ON u.postbr = must.postbr
         JOIN zupanije zust ON zust.id = must.idZupanija
         JOIN izvrsitelji i ON k.id = i.idKolegij
         JOIN nastavnici n ON i.jmbgNastavnik = n.jmbg
         JOIN mjesta mnast ON n.postBr = mnast.postbr
WHERE zust.nazivZupanija = 'Grad Zagreb'
  AND mnast.nazivMjesto = 'zagreb';

SELECT Zstan.nazivZupanija, zPreb.nazivZupanija, zUstanove.nazivZupanija
FROM nastavnici
         JOIN mjesta mNast ON mNast.postbr = nastavnici.postBr
         JOIN zupanije zNast ON zNast.id = mNast.idZupanija
         JOIN izvrsitelji i ON nastavnici.jmbg = i.jmbgNastavnik
         JOIN kolegiji k ON k.id = i.idKolegij
         JOIN smjerovi s ON s.id = k.idSmjer
         JOIN ustanove u ON u.oib = s.oibUstanova
         JOIN mjesta mUstanove ON mUstanove.postbr = u.postbr
         JOIN zupanije zUstanove ON zUstanove.id = mUstanove.idZupanija
         JOIN studenti st ON s.id = st.idSmjer
         JOIN mjesta mStan ON mStan.postbr = st.postBrStanovanja
         JOIN zupanije Zstan ON Zstan.id = mStan.idZupanija
         JOIN mjesta mPreb ON mPreb.postbr = st.postBrPrebivanje
         JOIN zupanije zPreb ON zPreb.id = mPreb.idZupanija
WHERE zUstanove.nazivZupanija = 'Grad Zagreb'
  AND zNast.nazivZupanija = 'Grad Zagreb'

SELECT STDDEV(ocjene.ocjena)
FROM ocjene
         JOIN kolegiji k ON ocjene.idKolegij = k.id
         JOIN izvrsitelji i ON k.id = i.idKolegij
         JOIN nastavnici n ON i.jmbgNastavnik = n.jmbg
         JOIN mjesta m ON n.postBr = m.postbr
         JOIN zupanije z ON m.idZupanija = z.id
         JOIN smjerovi s ON k.idSmjer = s.id
         JOIN ustanove u ON s.oibUstanova = u.oib
         JOIN mjesta m2 ON m2.postbr = u.postbr
         JOIN zupanije z2 ON m2.idZupanija = z2.id
WHERE z2.nazivZupanija = 'grad zagreb'
  AND z.nazivZupanija LIKE 'zagrebačka%'
  AND YEAR(datumPolaganja) IN (YEAR(NOW()), YEAR(NOW() - INTERVAL 2 YEAR));

SELECT nadsmjer.id    AS 'Smjer ID',
       nadsmjer.naziv AS 'Naziv smjera',
       smjerovi.id    AS 'Podsmjer id',
       smjerovi.naziv AS 'Naziv podmsjer'
FROM smjerovi
         JOIN smjerovi nadsmjer
              ON nadsmjer.idNadsmjer = smjerovi.id;

SELECT smjerovi.id    AS 'Smjer ID',
       smjerovi.naziv AS 'Naziv smjera',
       podsmjer.id    AS 'Podsmjer ID',
       podsmjer.naziv AS 'Naziv podsmjer'
FROM smjerovi
         JOIN
     smjerovi AS podSmjer ON smjerovi.id = podSmjer.idNadsmjer;

SELECT zs.nazivZupanija, zp.nazivZupanija
FROM studenti s
         JOIN
     mjesta ms ON s.postBrStanovanja = ms.postBr
         JOIN
     zupanije zs ON ms.idZupanija = zs.id
         JOIN
     mjesta mp ON s.postBrPrebivanje = mp.postBr
         JOIN
     zupanije zp ON mp.idZupanija = zp.id
         JOIN
     smjerovi sm ON s.idSmjer = sm.id
         JOIN
     ustanove u ON sm.oibUstanova = u.oib
         JOIN
     mjesta mu ON u.postBr = mu.postBr
         JOIN
     zupanije zu ON mu.idZupanija = zu.id
WHERE zu.nazivZupanija = 'Varaždinska županija';

SELECT zs.nazivZupanija, zp.nazivZupanija
FROM studenti
         JOIN mjesta mp ON studenti.postBrPrebivanje = mp.postbr
         JOIN zupanije zp ON zp.id = mp.idZupanija
         JOIN mjesta ms ON studenti.postBrStanovanja = ms.postbr
         JOIN zupanije zs ON zs.id = ms.idZupanija
         JOIN ocjene o ON studenti.jmbag = o.jmbagStudent
         JOIN kolegiji k ON o.idKolegij = k.id
         JOIN smjerovi s ON k.idSmjer = s.id
         JOIN ustanove u ON s.oibUstanova = u.oib
         JOIN mjesta m2 ON u.postbr = m2.postbr
         JOIN zupanije z2 ON m2.idZupanija = z2.id
WHERE z2.nazivZupanija LIKE 'varaždinska%';

SELECT DISTINCT *
FROM klijent
         JOIN mjesto mreg ON klijent.pbrReg = mreg.pbrMjesto
         JOIN zupanija z ON mreg.sifZupanija = z.sifZupanija
         JOIN mjesto mstan ON klijent.pbrKlijent = mstan.pbrMjesto
         JOIN nalog n ON klijent.sifKlijent = n.sifKlijent
         JOIN radnik r ON n.sifRadnik = r.sifRadnik
         JOIN mjesto mr ON r.pbrStan = mr.pbrMjesto
         JOIN zupanija zr ON mr.sifZupanija = zr.sifZupanija
WHERE zr.nazivZupanija like 'Sisačko-moslavačka%';

SELECT DISTINCT z.nazivZupanija, z2.nazivZupanija
FROM klijent
         JOIN
     nalog n ON klijent.sifKlijent = n.sifKlijent
         JOIN
     radnik r ON n.sifRadnik = r.sifRadnik
         JOIN
     mjesto m ON m.pbrMjesto = r.pbrStan
         JOIN
     mjesto m2 ON m2.pbrMjesto = klijent.pbrReg
         JOIN
     zupanija z ON z.sifZupanija = m2.sifZupanija
         JOIN
     mjesto m3 ON m3.pbrMjesto = klijent.pbrKlijent
         JOIN
     zupanija z2 ON m3.sifZupanija = z2.sifZupanija
WHERE m.nazivMjesto = 'Sisačko-moslavačka županija';

SELECT DISTINCT *
FROM klijent
         JOIN mjesto mreg ON klijent.pbrReg = mreg.pbrMjesto
         JOIN zupanija z ON mreg.sifZupanija = z.sifZupanija
         JOIN mjesto mstan ON klijent.pbrKlijent = mstan.pbrMjesto
         JOIN nalog n ON klijent.sifKlijent = n.sifKlijent
         JOIN radnik r ON n.sifRadnik = r.sifRadnik
         JOIN mjesto mr ON r.pbrStan = mr.pbrMjesto
         JOIN zupanija zr ON mr.sifZupanija = zr.sifZupanija
WHERE zr.nazivZupanija like 'Sisačko-moslavačka%';