CREATE TABLE knjige
(
    id                   INT PRIMARY KEY AUTO_INCREMENT,
    isbn                 CHAR(13),
    naziv                VARCHAR(100),
    opis                 TEXT,
    brojStranica         INT,
    koautori             VARCHAR(100),
    jmbgNastavnik        CHAR(13),
    oibUstanovaIzdavanja CHAR(11),
    UNIQUE INDEX (isbn) USING BTREE,
    FOREIGN KEY (jmbgNastavnik) REFERENCES nastavnici (jmbg),
    FOREIGN KEY (oibUstanovaIzdavanja) REFERENCES ustanove (oib)
) COLLATE = cp1250_croatian_ci;


CREATE INDEX mojIndex ON knjige (naziv, koautori) USING BTREE;

CREATE TABLE automobil
(
    brSasije          CHAR(17) PRIMARY KEY,
    marka             VARCHAR(200),
    model             VARCHAR(250),
    biljeske          TEXT,
    godinaProizvodnje VARCHAR(12),
    registarskaOznaka VARCHAR(12),
    FOREIGN KEY (sifKlijent) REFERENCES klijent (sifKlijent),
    UNIQUE INDEX registracija
);

CREATE TABLE automobil
(
    brSadije             CHAR(17) PRIMARY KEY,
    marka                VARCHAR(200),
    model                VARCHAR(250),
    biljeske             TEXT,
    godinaProizvodnje    YEAR,
    registracijskaOznaka VARCHAR(12),
    pbrReg               INT,
    UNIQUE INDEX (registracijskaOznaka),
    FOREIGN KEY (pbrReg) REFERENCES klijent (pbrReg)
)

DROP TABLE automobil