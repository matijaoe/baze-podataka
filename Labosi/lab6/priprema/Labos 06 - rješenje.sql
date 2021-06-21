/*U bazi radionice: Ispisati nazive mjesta stanovanja klijenata i stanovanja radnika po nalozima
klijenata za radnike, uz uvjet da klijent i radnik žive u različitom gradu ali u istoj županiji.*/

SELECT kMjesto.nazivMjesto, rMjesto.nazivMjesto
FROM klijent
         JOIN mjesto AS kMjesto ON klijent.pbrKlijent = kMjesto.pbrMjesto
         JOIN zupanija AS kZup ON kMjesto.sifZupanija = kZup.sifZupanija
         JOIN nalog ON klijent.sifKlijent = nalog.sifKlijent
         JOIN radnik ON nalog.sifRadnik = radnik.sifRadnik
         JOIN mjesto AS rMjesto ON radnik.pbrStan = rMjesto.pbrMjesto
         JOIN zupanija AS rZup ON rMjesto.sifZupanija = rZup.sifZupanija
WHERE rMjesto.pbrMjesto != kMjesto.pbrMjesto
  AND rZup.sifZupanija = kZup.sifZupanija;

/*U bazi radionice: Koristeći JOIN naredbu potrebno je ispisati sve kvarove koji su se odradili po
nalozima klijenata čija su vozila registrirana u županiji Grad zagreb, a žive u Splitsko
dalmatinskoj županiji.*/

SELECT kvar.*
FROM kvar
         JOIN nalog ON kvar.sifKvar = nalog.sifKvar
         JOIN klijent ON nalog.sifKlijent = klijent.sifKlijent
         JOIN mjesto AS sMjesto ON klijent.pbrKlijent = sMjesto.pbrMjesto
         JOIN mjesto AS rMjesto ON klijent.pbrReg = rMjesto.pbrMjesto
         JOIN zupanija AS sZup ON sMjesto.sifZupanija = sZup.sifZupanija
         JOIN zupanija AS rZup ON rMjesto.sifZupanija = rZup.sifZupanija
WHERE rZup.nazivZupanija = 'Grad Zagreb'
  AND sZup.nazivZupanija = 'Splitsko-dalmatinska';

/*U bazi studenti: Koristeći JOIN naredbu potrebno je ispisati sve nastavnike koji žive u
županiji Grad Zagreb, a predaju na ustanovi koja se nalazi u Varaždinskoj županiji. */

SELECT nastavnici.*
FROM zupanije AS nzupanije
         INNER JOIN
     mjesta AS nmjesta ON nmjesta.idZupanija = nzupanije.id
         INNER JOIN
     nastavnici ON nastavnici.postBr = nmjesta.postBr
         INNER JOIN
     izvrsitelji ON izvrsitelji.jmbgNastavnik = nastavnici.jmbg
         INNER JOIN
     kolegiji ON izvrsitelji.idKolegij = kolegiji.id
         INNER JOIN
     smjerovi ON kolegiji.idSmjer = smjerovi.id
         INNER JOIN
     ustanove ON ustanove.oib = smjerovi.oibUstanova
         INNER JOIN
     mjesta AS umjesta ON umjesta.postbr = ustanove.postBr
         INNER JOIN
     zupanije AS uzupanije ON uzupanije.id = umjesta.idZupanija
WHERE nzupanije.nazivZupanija = 'Grad Zagreb'
  AND uzupanije.nazivZupanija = 'Varaždinska županija';

/*U bazi studenti: Koristeći JOIN naredbu potrebno je ispisati sve studente koji stanuju i prebivaju
u Šibensko-kninskoj županiji. */

SELECT studenti.*
FROM studenti
         JOIN mjesta AS prebMjesto ON studenti.postBrPrebivanje = prebMjesto.postbr
         JOIN zupanije AS prebZup ON prebMjesto.idZupanija = prebZup.id
         JOIN mjesta AS stanMjesto ON studenti.postBrStanovanja = stanMjesto.postbr
         JOIN zupanije AS stanZup ON stanMjesto.idZupanija = stanZup.id
WHERE prebZup.nazivZupanija = 'Šibensko-kninska županija'
  AND stanZup.nazivZupanija = 'Šibensko-kninska županija';


/*U bazi studenti: Ispisati sva imena i prezimena nastavnika iz Splitsko-dalmatinske županije 
i nazive mjesta u kojima žive. Ukoliko u mjesto ne živi ni jedan nastavnik, mjesto je svejedno potrebno 
ispisati, a umjesto podataka nastavnika ispisati „NULL“ vrijednosti.*/


SELECT ime, prezime, nazivMjesto
FROM nastavnici
         RIGHT OUTER JOIN
     mjesta ON nastavnici.postBr = mjesta.postBr
         INNER JOIN
     zupanije ON mjesta.idZupanija = zupanije.id
WHERE zupanije.nazivZupanija = 'Splitsko-dalmatinska županija';
