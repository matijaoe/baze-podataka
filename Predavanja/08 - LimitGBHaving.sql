/*LIMIT*/
#Potrebno je ispisati prvog klijenta po abecedi:
SELECT *
FROM klijent
ORDER BY prezimeKlijent  ASC, imeKlijent ASC
LIMIT 0,1;
#ILI
SELECT *
FROM klijent
ORDER BY prezimeKlijent ASC, imeKlijent ASC
LIMIT 1;

#Potrebno je ispisati drugih pet radnika po visini plaće
SELECT *
FROM radnik
ORDER BY (koefPlaca * iznosOsnovice) DESC
LIMIT 5,5;
SELECT *
FROM radnik
ORDER BY (koefPlaca * iznosOsnovice) DESC
LIMIT 5;



/*GROUP BY*/

/*Potrebno je ispisati prosjek ocjena iz 
baza podataka po godinama ispita. Sortirati po godini uzlazno.*/
SELECT AVG(ocjene.ocjena), YEAR(datumPolaganja)
FROM ocjene
         INNER JOIN
     kolegiji ON kolegiji.id = ocjene.idKolegij
WHERE kolegiji.naziv = 'baze podataka'
GROUP BY YEAR(datumPolaganja)
ORDER BY YEAR(datumPolaganja) ASC;

/*Potrebno je ispisati broj studenata po imenu i 
sortirati podatke po broju silazno.*/
SELECT COUNT(*), ime
FROM studenti
GROUP BY ime
ORDER BY COUNT(*) DESC;
/*ZATO JE U OSTALIM UPITIMA UVIJEK POTREBNO KORISTITI I
  PRIMARNI KLJUČ U GRUPIRANJU!*/
SELECT ime, COUNT(*)
FROM studenti
GROUP BY 1 # rednibr u selectu
ORDER BY COUNT(*) DESC;

/*Primjerice ispisati prosjek ocjena po studentu:*/
SELECT AVG(ocjene.ocjena), ime, prezime
FROM studenti
         INNER JOIN
     ocjene ON ocjene.jmbagStudent = studenti.jmbag
GROUP BY ime, prezime;

/*Gornji upit nije ispravan jer grupira studente samo po imenu i prezimenu!
  Primjetiti broj redaka:*/
SELECT AVG(ocjene.ocjena), ime, prezime, jmbag
FROM studenti
         INNER JOIN
     ocjene ON ocjene.jmbagStudent = studenti.jmbag
GROUP BY ime, prezime, jmbag;


/*Potrebno je ispisati prosječnu plaću radnika po nazivu odjela.*/
SELECT odjel.nazivOdjel, AVG(koefPlaca * IznosOsnovice)
FROM odjel
         INNER JOIN
     radnik ON odjel.sifOdjel = radnik.sifOdjel
GROUP BY odjel.nazivOdjel, odjel.sifOdjel;

-- SVE STA JE U SELECTU A NIJE UNUTAR AGREGTATA MORA IC U GROUP BY!!!y

/*Potrebno je ispisati broj klijenata po
županiji sortiran po broju klijenata uzlazno*/
SELECT zupanija.nazivZupanija, zupanija.sifZupanija, COUNT(klijent.sifKlijent)
FROM klijent
         INNER JOIN
     mjesto ON klijent.pbrKlijent = mjesto.pbrMjesto
         RIGHT JOIN
     zupanija ON mjesto.sifZupanija = zupanija.sifZupanija
GROUP BY zupanija.nazivZupanija, zupanija.sifZupanija
ORDER BY COUNT(klijent.sifKlijent) ASC;


/*Potrebno je ispisati naziv odjela s najvećom prosječnom
plaćom radnika i iznos prosječne plaće.*/
SELECT odjel.nazivOdjel, AVG(koefPlaca * IznosOsnovice)
FROM odjel
         INNER JOIN
     radnik ON odjel.sifOdjel = radnik.sifOdjel
GROUP BY odjel.sifOdjel, odjel.nazivOdjel
ORDER BY AVG(koefPlaca * IznosOsnovice) DESC
LIMIT 0;


/*Najčešća greška na labosima:*/
/*Zaboravi se staviti GROUP BY*/
/*Zadatak kao gore bez GROUP BY klauzule na žalost baca rezultate
ako nije namješten ONLY_FULL_GROUP_BY u sql-mode-u u my.ini :*/
SELECT odjel.nazivOdjel, AVG(koefPlaca * IznosOsnovice)
FROM odjel
         INNER JOIN
     radnik ON odjel.sifOdjel = radnik.sifOdjel
ORDER BY AVG(koefPlaca * IznosOsnovice) DESC
LIMIT 0,1;



/*HAVING*/


/*Potrebno je ispisati broj klijenata po županiji. Potrebno 
je ispisati sve županije u kojima živi više od 10 klijenata. 
Rezultate je potrebno sortirati po broju klijenata po županiji 
uzlazno.*/
SELECT zupanija.sifZupanija, zupanija.nazivZupanija, COUNT(klijent.sifKlijent)
FROM klijent
         INNER JOIN
     mjesto ON klijent.pbrKlijent = mjesto.pbrMjesto
         INNER JOIN
     zupanija ON mjesto.sifZupanija = zupanija.sifZupanija
GROUP BY zupanija.sifZupanija, zupanija.NazivZupanija
HAVING COUNT(klijent.sifKlijent) > 10
ORDER BY COUNT(klijent.sifKlijent) ASC;


/*Potrebno je ispisati broj klijenata po županiji koja u nazivu
sadrži slovo „a“. Potrebno je ispisati prvih 5 rezultata s 
najmanjim brojem klijenata.*/
SELECT zupanija.sifZupanija, zupanija.nazivZupanija, COUNT(klijent.sifKlijent)
FROM klijent
         INNER JOIN
     mjesto ON klijent.pbrKlijent = mjesto.pbrMjesto
         INNER JOIN
     zupanija ON mjesto.sifZupanija = zupanija.sifZupanija
GROUP BY zupanija.sifZupanija, zupanija.NazivZupanija
HAVING zupanija.nazivZupanija LIKE '%a%'
ORDER BY COUNT(klijent.sifKlijent) ASC
LIMIT 0,5;


#ILI:

SELECT zupanija.sifZupanija, zupanija.nazivZupanija, COUNT(klijent.sifKlijent)
FROM klijent
         INNER JOIN
     mjesto ON klijent.pbrKlijent = mjesto.pbrMjesto
         INNER JOIN
     zupanija ON mjesto.sifZupanija = zupanija.sifZupanija
WHERE zupanija.nazivZupanija LIKE '%a%'
GROUP BY zupanija.sifZupanija, zupanija.NazivZupanija
ORDER BY COUNT(klijent.sifKlijent) ASC
LIMIT 0,5;



/* U HAVING smiju doći samo agregat i dio koji je u GROUP BY klauzuli!*/


/*Potrebno je ispisati sumu broja sati kvara iz tablice kvar po šifri,
imenu i prezimenu klijenta. Potrebno je ispisati one vrijednosti čije 
su sume veće od 5.*/
SELECT klijent.sifKlijent,
       klijent.imeKlijent,
       klijent.prezimeKlijent,
       SUM(satiKvar)
FROM kvar
         INNER JOIN
     nalog ON kvar.sifKvar = nalog.sifKvar
         INNER JOIN
     klijent ON nalog.sifKlijent = klijent.sifKlijent
GROUP BY klijent.sifKlijent, klijent.prezimeKlijent, klijent.imeKlijent
HAVING SUM(satiKvar) > 5;

#Ovo ne radi:

SELECT klijent.sifKlijent,
       klijent.imeKlijent,
       klijent.prezimeKlijent,
       SUM(satiKvar)
FROM kvar
         INNER JOIN
     nalog ON kvar.sifKvar = nalog.sifKvar
         INNER JOIN
     klijent ON nalog.sifKlijent = klijent.sifKlijent
WHERE SUM(satiKvar) > 5
GROUP BY klijent.sifKlijent, klijent.prezimeKlijent, klijent.imeKlijent;

/*U WHERE nikako ne smije doći agregatna funkcija!!!*/


