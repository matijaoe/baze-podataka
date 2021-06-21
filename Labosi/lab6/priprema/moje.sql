/*
1. U bazi radionice: Ispisati nazive mjesta stanovanja klijenata i stanovanja radnika po nalozima
klijenata za radnike, uz uvjet da klijent i radnik žive u različitom gradu ali u istoj županiji.
*/

SELECT CONCAT_WS(' ', klijent.imeKlijent, klijent.prezimeKlijent) AS 'klijent',
       mk.nazivMjesto                                             AS 'mjesto klijenta',
       zk.nazivZupanija                                           AS 'zupanija klijenta',
       CONCAT_WS(' ', radnik.imeRadnik, radnik.prezimeRadnik)     AS 'radnik',
       mr.nazivMjesto                                             AS 'mjesto radnika',
       zr.nazivZupanija                                           AS 'zupanija radnika'
FROM klijent
         JOIN mjesto AS mk ON klijent.pbrKlijent = mk.pbrMjesto
         JOIN zupanija AS zk ON mk.sifZupanija = zk.sifZupanija
         JOIN nalog ON klijent.sifKlijent = nalog.sifKlijent
         JOIN radnik ON radnik.sifRadnik = nalog.sifRadnik
         JOIN mjesto AS mr ON radnik.pbrStan = mr.pbrMjesto
         JOIN zupanija AS zr ON mr.sifZupanija = zr.sifZupanija
WHERE zk.sifZupanija = zr.sifZupanija
  AND mk.pbrMjesto <> mr.pbrMjesto;


/*
2. U bazi radionice: Koristeći JOIN naredbu potrebno je ispisati sve kvarove koji su se odradili po
nalozima klijenata čija su vozila registrirana u županiji Grad zagreb, a žive u Splitsko
dalmatinskoj županiji.
*/
SELECT kvar.*
FROM kvar
         JOIN nalog n ON kvar.sifKvar = n.sifKvar
         JOIN klijent k ON n.sifKlijent = k.sifKlijent
         JOIN mjesto mStan ON k.pbrKlijent = mStan.pbrMjesto
         JOIN zupanija zStan ON zStan.sifZupanija = mStan.sifZupanija
         JOIN mjesto mReg ON k.pbrReg = mReg.pbrMjesto
         JOIN zupanija zReg ON zReg.sifZupanija = mReg.sifZupanija
WHERE zStan.nazivZupanija LIKE 'splitsko%'
  AND zReg.nazivZupanija = 'grad zagreb';


/*
3. U bazi studenti: Koristeći JOIN naredbu potrebno je ispisati sve nastavnike koji žive u županiji
Grad Zagreb, a predaju na ustanovi koja se nalazi u Varaždinskoj županiji.
*/
SELECT nastavnici.*
FROM nastavnici
         JOIN mjesta mNastavnik ON nastavnici.postBr = mNastavnik.postbr
         JOIN zupanije zNastavnik ON mNastavnik.idZupanija = zNastavnik.id
         JOIN izvrsitelji i ON nastavnici.jmbg = i.jmbgNastavnik
         JOIN kolegiji k ON i.idKolegij = k.id
         JOIN smjerovi s ON k.idSmjer = s.id
         JOIN ustanove u ON s.oibUstanova = u.oib
         JOIN mjesta mUstanova ON mUstanova.postbr = u.postbr
         JOIN zupanije zUstanova ON mUstanova.idZupanija = zUstanova.id
WHERE zNastavnik.nazivZupanija = 'grad zagreb'
  AND zUstanova.nazivZupanija LIKE 'varaždinska%';


/*
4. U bazi studenti: Koristeći JOIN naredbu potrebno je ispisati sve studente koji stanuju i prebivaju
u Šibensko-kninskoj županiji.
*/
SELECT studenti.*
FROM studenti
         JOIN mjesta mjPreb ON studenti.postBrPrebivanje = mjPreb.postbr
         JOIN zupanije zupPreb ON mjPreb.idZupanija = zupPreb.id
         JOIN mjesta mjStan ON studenti.postBrStanovanja = mjStan.postbr
         JOIN zupanije zupStan ON mjStan.idZupanija = zupStan.id
WHERE zupStan.id = zupPreb.id
  AND zupStan.nazivZupanija LIKE 'šibensko%';


/*
5. U bazi studenti: Ispisati sva imena i prezimena nastavnika iz Splitsko dalmatinske županije i
nazive mjesta u kojima žive. Ukoliko u mjesto ne živi ni jedan nastavnik, mjesto je svejedno
potrebno ispisati, a umjesto podataka nastavnika ispisati „NULL“ vrijednosti.
*/
SELECT nastavnici.ime, nastavnici.prezime, mjesta.nazivMjesto
FROM mjesta
         LEFT JOIN nastavnici ON mjesta.postbr = nastavnici.postBr
         JOIN zupanije ON mjesta.idZupanija = zupanije.id
WHERE zupanije.nazivZupanija LIKE 'splitsko%';