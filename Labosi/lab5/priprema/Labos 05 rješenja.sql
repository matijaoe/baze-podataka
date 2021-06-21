/* 1.	U bazi radionice: Potrebno je koristeći JOIN naredbu ispisati podatke radnika i prioritete 
naloga na kojima su vršili popravak kvara naziva "Zamjena klipa". */

SELECT radnik.*, nalog.prioritetNalog 
FROM radnik INNER JOIN 
     nalog ON radnik.sifRadnik = nalog.sifRadnik INNER JOIN 
     kvar ON nalog.sifKvar = kvar.sifKvar
WHERE kvar.nazivKvar = 'Zamjena klipa';

/* 2.	U bazi radionice: Koristeći JOIN naredbu potrebno je ispisati sve kvarove koji su se odradili 
po nalozima klijenata čija su vozila registrirana u županiji „Grad Zagreb“. */

SELECT kvar.* 
FROM kvar INNER JOIN 
     nalog ON kvar.sifKvar = nalog.sifKvar INNER JOIN 
     klijent ON nalog.sifKlijent = klijent.sifKlijent INNER JOIN 
     mjesto ON klijent.pbrReg = mjesto.pbrMjesto INNER JOIN 
     zupanija ON mjesto.sifZupanija = zupanija.sifZupanija
WHERE nazivZupanija = 'Grad Zagreb';

/* 3.	U bazi radionice: Ispisati sva mjesta koja se nalaze unutar Splitsko-dalmatinske županije kao 
i klijente koji su registrirali automobil u istima. Ukoliko ne postoji 
klijent koji je registrirao automobil u mjestu unutar županije, potrebno je svejedno ispisati mjesto, 
a unutar kolona klijenta „null“ vrijednosti. */

SELECT mjesto.*, klijent.* 
FROM zupanija LEFT OUTER JOIN 
     mjesto ON zupanija.sifZupanija = mjesto.sifZupanija LEFT OUTER JOIN 
     klijent ON mjesto.pbrMjesto = klijent.pbrReg
WHERE zupanija.nazivZupanija = 'Splitsko-dalmatinska';

/* 4.	U bazi studenti: Koristeći JOIN naredbu potrebno je ispisati sve nastavnike koji predaju na 
Tehničkom Veleučilištu u Zagrebu. */

SELECT DISTINCT nastavnici.*
FROM nastavnici INNER JOIN
     izvrsitelji ON nastavnici.jmbg = izvrsitelji.jmbgNastavnik INNER JOIN
     kolegiji ON izvrsitelji.idKolegij = kolegiji.id INNER JOIN
     smjerovi ON kolegiji.idSmjer = smjerovi.id INNER JOIN
     ustanove ON smjerovi.oibUstanova = ustanove.oib
WHERE ustanove.naziv = 'Tehničko Veleučilište u Zagrebu';

/* 5.	U bazi studenti: Potrebno je ispisati sve nastavnike koji ne predaju ni na jednom kolegiju. */

SELECT nastavnici.* 
FROM nastavnici 
	LEFT JOIN izvrsitelji ON nastavnici.jmbg=izvrsitelji.jmbgNastavnik
	LEFT JOIN kolegiji ON izvrsitelji.idKolegij=kolegiji.id
WHERE kolegiji.id IS NULL;
