--Naredba za brisanje buffera
DBCC DROPCLEANBUFFERS
GO
DBCC FREEPROCCACHE
GO

select count(*) from testTable


select * from testTable
where RandomString LIKE 'vu%'



CREATE CLUSTERED INDEX IX_test ON testTable(RandomString ASC)
GO

DROP INDEX IX_test ON testTable
GO 









--FullText
--Koristi drugu bazu
USE FullTextTest


select count(*) from Sentences

--Uklanjanje indexa
drop fulltext index on Sentences
DROP FULLTEXT CATALOG [ft]

--Create full text index
CREATE FULLTEXT CATALOG ft AS DEFAULT;
CREATE FULLTEXT INDEX ON Sentences(Sentence LANGUAGE Croatian) 
   KEY INDEX PK_Sentences
   WITH STOPLIST = SYSTEM;
GO

--Mogu�e ga je tako�er kreirati kroz GUI ;)






--Koje su stopirane rije�i za na� jezik?
select sys.fulltext_system_stopwords.stopword 
from sys.fulltext_system_stopwords 
inner join sys.fulltext_languages 
on language_id = lcid
where sys.fulltext_languages.name = 'Croatian' 

--Podr�ani jezici
select * from sys.fulltext_languages

--Napravimo prvo neka mjerenja
DBCC DROPCLEANBUFFERS  
GO
DBCC FREEPROCCACHE
GO


DECLARE @StartTime datetime

SET @StartTime = GETDATE() -- Po�nimo mjerenje
select * from Sentences where FREETEXT(Sentence, 'Lucas')
SELECT ExecutionTimeInMS =  DATEDIFF(millisecond,  @StartTime, getdate())


DBCC DROPCLEANBUFFERS  -- Obri�emo buffer
GO
DBCC FREEPROCCACHE
GO
DECLARE @StartTime datetime
SET @StartTime = GETDATE() -- Zapo�nemo mjerenje
select * from Sentences where Sentence LIKE '%Lucas%'
SELECT ExecutionTimeInMS =  DATEDIFF(millisecond,  @StartTime, getdate())

--Malo je br�e :)


--Najbolja stvar je rangiranje
SELECT KEY_TBL.RANK, Sentences.Sentence
FROM Sentences
     INNER JOIN
     FREETEXTTABLE(Sentences, Sentence, 'luke') AS KEY_TBL
     ON Sentences.ID = KEY_TBL.[KEY]
ORDER BY KEY_TBL.RANK DESC;


--Mogu�e je pretra�iti cijele re�enice
SELECT KEY_TBL.RANK, Sentences.Sentence
FROM Sentences
     INNER JOIN
     FREETEXTTABLE(Sentences, Sentence, 'Tek se sada sigurnosna 
	 mre�a po�ela razdvajati') AS KEY_TBL
     ON Sentences.ID = KEY_TBL.[KEY]
ORDER BY KEY_TBL.RANK DESC;