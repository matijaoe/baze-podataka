/* U bazi radionice: Ispisati sva mjesta u kojima ne živi niti jedan radnik. Zadatak je potrebno 
riješiti pomoću podupita. */

SELECT mjesto.* FROM mjesto
WHERE mjesto.pbrMjesto NOT IN 
	(SELECT pbrStan FROM radnik);


/* U bazi studenti: Potrebno je ispisati sve studente koji imaju ocjene veće od prosječne ocjene svih 
studenata zajedno. */

SELECT studenti.* 
FROM studenti INNER JOIN 
     ocjene ON studenti.jmbag = ocjene.jmbagStudent
WHERE ocjene.ocjena > (SELECT AVG(ocjena) FROM ocjene);


/* U bazi radionice: Ispisati sve vrijednosti iz tablice radionica kod kojih je kapacitet radnika veći 
od četiri puta uvećanog maksimalnog sata servisa iz tablice rezervacija. */

SELECT * FROM radionica
WHERE kapacitetRadnika > 
      (SELECT 4 * MAX(satServis) FROM rezervacija);


/* U bazi radionice: Potrebno je obrisati sve naloge koji su vršeni na klijentima kojima je mjesto 
prebivanja Zagreb. */

DELETE FROM nalog
WHERE nalog.sifKlijent IN
      (SELECT klijent.sifKlijent 
       FROM klijent INNER JOIN 
            mjesto ON klijent.pbrKlijent = mjesto.pbrMjesto
       WHERE mjesto.nazivMjesto = "Zagreb");


/* U bazi studenti: Potrebno je izbrisati one izvršitelje u koje spadaju nastavnici čije ime počinje slovom D. */

DELETE FROM izvrsitelji
WHERE jmbgNastavnik IN
	(SELECT jmbg FROM nastavnici
	WHERE ime LIKE "D%");
	
	
/* U bazi studenti: Potrebno je promijeniti svim nastavnicima koji predaju na Tehničkom veleučilištu u Zagrebu 
   titulu ispred u „pred.“. */

UPDATE nastavnici
SET titulaIspred = 'pred.'
WHERE nastavnici.jmbg IN
      (SELECT izvrsitelji.jmbgNastavnik
       FROM izvrsitelji INNER JOIN
            kolegiji ON kolegiji.id = izvrsitelji.idKolegij INNER JOIN
            smjerovi ON kolegiji.idSmjer = smjerovi.id INNER JOIN
            ustanove ON smjerovi.oibUstanova = ustanove.oib
       WHERE ustanove.naziv = 'Tehničko Veleučilište u Zagrebu');
#ILI
UPDATE nastavnici INNER JOIN
       izvrsitelji ON nastavnici.jmbg = izvrsitelji.jmbgNastavnik INNER JOIN
       kolegiji ON kolegiji.id = izvrsitelji.idKolegij INNER JOIN
       smjerovi ON kolegiji.idSmjer = smjerovi.id INNER JOIN
       ustanove ON smjerovi.oibUstanova = ustanove.oib
SET titulaIspred = 'pred.'
WHERE ustanove.naziv = 'Tehničko Veleučilište u Zagrebu';