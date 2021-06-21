/*1 Primary and foreign key*/

/*Primary key violation*/
INSERT INTO nastavnici (jmbg, ime, prezime, adresa, titulaispred, titulaiza, postbr, lozinka)
VALUES ('3105981300709', 'Nova Vesna', 'Ilić', 'Paška ulica 25', NULL, 'prof.', 40000, 'd85a9058fab489ca8812e2482ccd44ac');

/*Foreign key violation*/
INSERT INTO mjesta(postbr, nazivMjesto, idZupanija)
VALUES(33334, 'Kikinda', 21);


/*prikaz svih kolotacija u bazi*/
SHOW COLLATION;

/*cs je oznaka za case sensitive!*/
SHOW COLLATION WHERE COLLATION LIKE '%_cs';


/*Prikaži standarde za pohranu znakovnog niza*/
SHOW CHARACTER SET;

/*Operatori:*/
SELECT 3<2;

/*Operator between:*/
SELECT 3 BETWEEN 1 AND 3;

/*Operator IS NULL:*/
SELECT 3 IS NULL;

/*Operator IN:*/
SELECT 3 IN (1, 2, 3, 4, 5, 100, 150);

/*Operator LIKE:*/
SELECT 'abcdefgh' LIKE '%ab%';

/*Operator REGEXP:*/
SELECT 'abcdefgh' REGEXP '^ab.*$';