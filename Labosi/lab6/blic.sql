/*
U bazi radionice: Ispisati nazive županija stanovanja klijenata i nazive županija u kojima su registrirani auti
klijenata, za klijente čije prezime završava na ak.
*/
SELECT klijent.*, zKlijent.nazivZupanija, zReg.nazivZupanija
FROM klijent
         JOIN mjesto mKlijent ON klijent.pbrKlijent = mKlijent.pbrMjesto
         JOIN zupanija zKlijent ON mKlijent.sifZupanija = zKlijent.sifZupanija
         JOIN mjesto mReg ON klijent.pbrReg = mReg.pbrMjesto
         JOIN zupanija zReg ON mReg.sifZupanija = zReg.sifZupanija
WHERE klijent.prezimeKlijent LIKE '%ak';

/*
U bazi studenti: Koristeći JOIN naredbu potrebno je ispisati koliko ima profesora na Pomorskom fakultetu.
U ispisu je potrebno zadati naziv stupca 'Broj profesora'.
*/
SELECT COUNT(*) AS 'Broj profesora'
FROM izvrsitelji
         JOIN nastavnici n ON izvrsitelji.jmbgNastavnik = n.jmbg
         JOIN ulogaizvrsitelja ON izvrsitelji.idUlogaIzvrsitelja = ulogaizvrsitelja.id
         JOIN kolegiji ON izvrsitelji.idKolegij = kolegiji.id
         JOIN smjerovi s ON kolegiji.idSmjer = s.id
         JOIN ustanove ON s.oibUstanova = ustanove.oib
WHERE ulogaizvrsitelja.naziv = 'profesor'
  AND ustanove.naziv = 'Pomorski fakultet';

SELECT *
FROM izvrsitelji
         JOIN ulogaizvrsitelja ON izvrsitelji.idUlogaIzvrsitelja = ulogaizvrsitelja.id
         JOIN kolegiji ON izvrsitelji.idKolegij = kolegiji.id
         JOIN smjerovi s ON kolegiji.idSmjer = s.id
         JOIN ustanove ON s.oibUstanova = ustanove.oib
WHERE ulogaizvrsitelja.naziv = 'profesor'
  AND ustanove.naziv = 'Pomorski fakultet';
