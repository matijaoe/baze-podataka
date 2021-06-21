/*INNER JOIN*/

SELECT *
FROM klijent
         INNER JOIN
     mjesto ON klijent.pbrklijent = mjesto.pbrmjesto;

#Ili:
SELECT *
FROM klijent
         JOIN
     mjesto ON klijent.pbrklijent = mjesto.pbrmjesto;

/*Prirodni spoj:*/
SELECT *
FROM klijent,
     mjesto
WHERE klijent.pbrklijent = mjesto.pbrMjesto;


/*Potrebno je ispisati sve radnike koji stanuju u 
  Ličko-senjskoj županiji.*/
SELECT radnik.*
FROM radnik
         INNER JOIN
     mjesto ON radnik.pbrStan = mjesto.pbrMjesto
         INNER JOIN
     zupanija ON mjesto.sifZupanija = zupanija.sifZupanija
WHERE zupanija.nazivZupanija = 'Ličko-senjska';

-- prirodni spoj
SELECT radnik.*
FROM radnik,
     mjesto,
     zupanija
WHERE radnik.pbrStan = mjesto.pbrMjesto
  AND mjesto.sifZupanija = zupanija.sifZupanija
  AND nazivZupanija = 'ličko-senjska';


/*Potrebno je ispisati unikatne radnike koji su vršili 
  popravke za naloge klijenata koji žive u Splitu.*/
SELECT DISTINCT radnik.*
FROM radnik
         INNER JOIN
     nalog ON radnik.sifRadnik = nalog.sifRadnik
         INNER JOIN
     klijent ON nalog.sifKlijent = klijent.sifKlijent
         INNER JOIN
     mjesto ON klijent.pbrKlijent = mjesto.pbrMjesto
WHERE mjesto.nazivMjesto = 'Split';


/*Potrebno je ispisati sve klijente koji su vršili popravak kvara na
odjelu „Dijagnostika“, a automobil im je registriran u županiji „Grad Zagreb“:*/
SELECT DISTINCT klijent.*
FROM odjel
         INNER JOIN
     kvar ON odjel.sifOdjel = kvar.sifOdjel
         INNER JOIN
     nalog ON kvar.sifKvar = nalog.sifKvar
         INNER JOIN
     klijent ON nalog.sifKlijent = klijent.sifKlijent
         INNER JOIN
     mjesto ON klijent.pbrReg = mjesto.pbrMjesto
         INNER JOIN
     zupanija ON mjesto.sifZupanija = zupanija.sifZupanija
WHERE odjel.nazivOdjel = 'Dijagnostika'
  AND zupanija.nazivZupanija = 'Grad Zagreb';


/*Potrebno je ispisati sve klijente koji su vršili popravak 
kvara na odjelu „Dijagnostika“, 
automobil im je registriran u županiji „Grad Zagreb“, 
a kvar je popravljao radnik imena „Marko“:*/
SELECT DISTINCT klijent.*
FROM odjel
         INNER JOIN
     kvar ON odjel.sifOdjel = kvar.sifOdjel
         INNER JOIN
     nalog ON kvar.sifKvar = nalog.sifKvar
         INNER JOIN
     radnik ON nalog.sifRadnik = radnik.sifRadnik
         INNER JOIN
     klijent ON nalog.sifKlijent = klijent.sifKlijent
         INNER JOIN
     mjesto ON klijent.pbrReg = mjesto.pbrMjesto
         INNER JOIN
     zupanija ON mjesto.sifZupanija = zupanija.sifZupanija
WHERE odjel.nazivOdjel = 'Dijagnostika'
  AND zupanija.nazivZupanija = 'Grad Zagreb'
  AND radnik.imeRadnik = 'Marko';


/*Potrebno je ispisati sve klijente koji su vršili
popravak kvara na odjelu „Dijagnostika“, 
automobil im je registriran u županiji „Grad Zagreb“, 
kvar je popravljao radnik imena 
„Marko“, a za popravak je bila rezervirana radionica oznake „R12“:*/
SELECT DISTINCT klijent.*
FROM odjel
         INNER JOIN
     kvar ON odjel.sifOdjel = kvar.sifOdjel
         INNER JOIN
     rezervacija ON rezervacija.sifKvar = kvar.sifKvar
         INNER JOIN
     nalog ON kvar.sifKvar = nalog.sifKvar
         INNER JOIN
     radnik ON nalog.sifRadnik = radnik.sifRadnik
         INNER JOIN
     klijent ON nalog.sifKlijent = klijent.sifKlijent
         INNER JOIN
     mjesto ON klijent.pbrReg = mjesto.pbrMjesto
         INNER JOIN
     zupanija ON mjesto.sifZupanija = zupanija.sifZupanija
WHERE odjel.nazivOdjel = 'Dijagnostika'
  AND zupanija.nazivZupanija = 'Grad Zagreb'
  AND radnik.imeRadnik = 'Marko'
  AND rezervacija.oznRadionica = 'R12';


/*NATURAL JOIN*/

/*Potrebno je ispisati sve radnike koji rade na odjelu „Balansiranje guma“.*/
SELECT radnik.*
FROM odjel
         NATURAL JOIN radnik
WHERE odjel.nazivOdjel = 'Balansiranje guma';

SELECT radnik.*
FROM odjel
         JOIN radnik ON odjel.sifOdjel = radnik.sifOdjel
WHERE odjel.nazivOdjel = 'Balansiranje guma';

/*Potrebno je ispisati sve radnike i nazive njihovih mjesta stanovanja.*/
SELECT radnik.*, mjesto.nazivMjesto
FROM radnik
         NATURAL JOIN mjesto;



/*Ne radi? :)*/

/*Točno rješenje potrebno je napisati pomoću INNER JOIN naredbe:*/
SELECT radnik.*, mjesto.nazivMjesto
FROM radnik
         INNER JOIN mjesto ON radnik.pbrStan = mjesto.pbrMjesto;



/*LEFT OUTER JOIN*/
/*Potrebno je ispisati sve županije i sva mjesta koje one sadrže. 
Ukoliko ne postoji ni jedno mjesto u određenoj županiji, potrebno 
je svejedno ispisati županiju, a za mjesto null vrijednosti:*/
SELECT *
FROM zupanija
         LEFT OUTER JOIN
     mjesto ON zupanija.sifZupanija = mjesto.sifZupanija;

-- ovo nece ispisat nepoznatu zupaniju jer ona nema niti jedno mjesto
SELECT *
FROM zupanija
         INNER JOIN
     mjesto ON zupanija.sifZupanija = mjesto.sifZupanija;

#ili
SELECT *
FROM zupanija
         LEFT JOIN
     mjesto ON zupanija.sifZupanija = mjesto.sifZupanija;


/*Ispisati sve odjele i kvarove koji su bili popravljani na istima, a ukoliko ne 
postoji ni jedan kvar koji je odjel popravljao potrebno je ispisati „null“ vrijednosti:*/
SELECT *
FROM odjel
         LEFT OUTER JOIN
     kvar ON odjel.sifOdjel = kvar.sifOdjel;

# SELECT *
# FROM kvar
#          RIGHT OUTER JOIN
#      odjel ON odjel.sifOdjel = kvar.sifOdjel;

SELECT *
FROM kvar
         LEFT OUTER JOIN
     odjel ON odjel.sifOdjel = kvar.sifOdjel;

/*Potrebno je ispisati sva mjesta koja se nalaze unutar Varaždinske županije
kao i klijente koji su registrirali automobil u istima. Ukoliko ne postoji 
klijent koji je registrirao automobil u mjestu unutar županije, potrebno je 
svejedno ispisati mjesto, a unutar kolona klijenta „null“ vrijednosti.*/
SELECT mjesto.nazivMjesto, klijent.*
FROM zupanija
         JOIN
     mjesto ON zupanija.sifZupanija = mjesto.sifZupanija
         LEFT OUTER JOIN
     klijent ON mjesto.pbrMjesto = klijent.pbrReg
WHERE zupanija.nazivZupanija = 'Varaždinska';


/*Potrebno je ispisati oznaku radionice, sate servisa i nazive kvarova. 
Ukoliko ne postoji ni jedna rezervacija za radionicu, odnosno ni jedan 
kvar za rezervaciju potrebno je ispisati null vrijednosti.*/
SELECT radionica.oznRadionica, rezervacija.satServis, kvar.nazivKvar
FROM radionica
         LEFT OUTER JOIN
     rezervacija ON radionica.oznRadionica = rezervacija.oznRadionica
         LEFT OUTER JOIN
     kvar ON rezervacija.sifKvar = kvar.sifKvar;



/*RIGHT OUTER JOIN*/

/*Potrebno je ispisati sve županije i sva mjesta koje one sadrže. 
Ukoliko ne postoji ni jedno mjesto u određenoj županiji, potrebno 
je svejedno ispisati županiju, a za mjesto null vrijednosti:*/
SELECT *
FROM mjesto
         RIGHT OUTER JOIN
     zupanija ON zupanija.sifZupanija = mjesto.sifZupanija;
#ili
SELECT *
FROM mjesto
         RIGHT JOIN
     zupanija ON zupanija.sifZupanija = mjesto.sifZupanija;
#ili
SELECT *
FROM zupanija
         LEFT JOIN
     mjesto ON zupanija.sifZupanija = mjesto.sifZupanija;
#Redosljed je drugačiji jer je zupanija na prvom mjestu


/*Ispisati sve odjele i kvarove koji su bili popravljani na istima,
a ukoliko ne postoji ni jedan kvar koji je odjel popravljao potrebno 
je ispisati „null“ vrijednosti:*/
SELECT *
FROM kvar
         RIGHT OUTER JOIN
     odjel ON odjel.sifOdjel = kvar.sifOdjel;


/*Potrebno je ispisati sva mjesta koja se nalaze unutar Varaždinske
županije kao i klijente koji su registrirali automobil u istima. 
Ukoliko ne postoji klijent koji je registrirao automobil u mjestu 
unutar županije, potrebno je svejedno ispisati mjesto, a unutar kolona 
klijenta „null“ vrijednosti.*/

-- moje
SELECT mjesto.nazivMjesto, klijent.*
FROM mjesto
         JOIN
     zupanija ON mjesto.sifZupanija = zupanija.sifZupanija
         LEFT OUTER JOIN
     klijent ON klijent.pbrKlijent = mjesto.pbrMjesto
WHERE zupanija.nazivZupanija = 'varaždinska';



SELECT mjesto.nazivMjesto, klijent.*
FROM klijent
         RIGHT OUTER JOIN
     mjesto ON mjesto.pbrMjesto = klijent.pbrKlijent
         INNER JOIN
     zupanija ON zupanija.sifZupanija = mjesto.sifZupanija
WHERE zupanija.nazivZupanija = 'Varaždinska';


/*Potrebno je ispisati oznaku radionice, sate servisa i nazive kvarova.
Ukoliko ne postoji ni jedna rezervacija za radionicu, odnosno ni jedan 
kvar za rezervaciju potrebno je ispisati null vrijednosti.*/

SELECT radionica.oznRadionica, rezervacija.satServis, kvar.nazivKvar
FROM kvar
         RIGHT OUTER JOIN
     rezervacija ON rezervacija.sifKvar = kvar.sifKvar
         RIGHT OUTER JOIN
     radionica ON radionica.oznRadionica = rezervacija.oznRadionica;



/*Unija*/
/*Potrebno je ispisati imena i prezimena svih radnika i klijenata u istoj projekciji.
*/
SELECT imeKlijent, prezimeklijent
FROM klijent
UNION
SELECT imeRadnik, prezimeRadnik
FROM radnik;


/*S duplim rezultatima*/
SELECT imeKlijent, prezimeklijent
FROM klijent
UNION ALL
SELECT imeRadnik, prezimeRadnik
FROM radnik;


/*full outer join*/

SELECT *
FROM mjesto
         LEFT JOIN
     zupanija ON mjesto.sifZupanija = zupanija.sifZupanija
UNION
SELECT *
FROM mjesto
         RIGHT JOIN
     zupanija ON mjesto.sifZupanija = zupanija.sifZupanija;

/*Potrebno je prikazati nazive mjesta i nazive 
  županija. Potrebno prikazati sve retke obje tablice.*/
SELECT mjesto.nazivMjesto, zupanija.nazivZupanija
FROM mjesto
         LEFT OUTER JOIN
     zupanija ON zupanija.sifZupanija = mjesto.sifZupanija
UNION
SELECT mjesto.nazivMjesto, zupanija.nazivZupanija
FROM mjesto
         RIGHT OUTER JOIN
     zupanija ON zupanija.sifZupanija = mjesto.sifZupanija;



/*Uvjeti selekcije*/
/*Bez uvjeta*/
SELECT *
FROM klijent
         LEFT OUTER JOIN
     mjesto ON klijent.pbrklijent = mjesto.pbrmjesto;

/*Dodatak uvjeta:*/
SELECT *
FROM klijent
         LEFT OUTER JOIN
     mjesto ON klijent.pbrklijent = mjesto.pbrmjesto
WHERE klijent.pbrKlijent > 10000;

/*Uvjet na krivom mjestu:*/
SELECT *
FROM klijent
         LEFT OUTER JOIN
     mjesto ON klijent.pbrklijent = mjesto.pbrmjesto AND klijent.pbrKlijent > 10000;


         