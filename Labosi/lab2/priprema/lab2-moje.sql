# 1
CREATE TABLE album (
	sifAlbum INT,
	naslov VARCHAR(150),
	izvodjac VARCHAR(170),
	trajanjeMin DECIMAL(5,2),
	zanr INT,
	PRIMARY KEY sifAlbum (sifAlbum)
);

# 2
USE radionica

ALTER TABLE nalog
DROP COLUMN prioritetNalog,
CHANGE COLUMN OstvareniSatiRada SatiRada INT;

# 3
USE studenti

ALTER TABLE nastavnici
DROP COLUMN titulaIspred,
CHANGE COLUMN titulaIza titula VARCHAR(30);

# 4
USE radionica;

TRUNCATE TABLE klijent; # DELETE FROM klijent;

# 5
DROP TABLE klijent;

# 6
USE studenti;
DROP TABLE ocjene;

# 7
USE radionica;

INSERT INTO kvar(sifKvar, nazivKvar, sifOdjel, brojRadnika, satiKvar) 
VALUES(69,'Kvačilo', 6, 2, 4);

# 8
USE studenti;
INSERT INTO smjerovi (naziv, oibUstanova,idNadsmjer) 
VALUES('Informatika', '08814003451',23);

# 9
USE radionica;
INSERT INTO radnik (imeRadnik, prezimeRadnik, koefPlaca)
VALUES ('Ivana','Osrecki',1.66);

# 10 - klijent smo zbrisali tho?
SELECT imeKlijent, prezimeKlijent FROM klijent;

# 11
SELECT * FROM odjel;

# 12
UPDATE klijent SET imeKlijent='Ivan', prezimeKlijent='Kovačević';

# 13
USE studenti;
UPDATE smjerovi SET naziv='Informatika';

# 14
USE radionica;
SELECT imeRadnik, prezimeRadnik, KoefPlaca FROM radnik;
UPDATE radnik SET KoefPlaca = KoefPlaca + 1;
