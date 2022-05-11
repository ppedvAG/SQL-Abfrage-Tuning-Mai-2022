--Seiten (IO) --- weniger --> weniger CPU 
					-- weniger RAM Auslastung 



select * from umsatz --von 2000 bis 2022

--TAB A mit 10000 DS
--TAB B mit 100000 DS
--TAB A und B sind identisch 

--Abfrage die bei A 10 Zeilen und bei B ebenfalls 10 Zeilen
--welche Tabelle bringt das Ergebnis schneller?: 

--Ergo: dann machen wir kleine Tabellen


select * from u2022
select * from u2021
select * from u2020

--aber : die software verlangt UMSATZ!!!



create table u2022( id int , jahr int, spx int)

create table u2021( id int , jahr int, spx int)

create table u2020( id int , jahr int, spx int)

--UNION für Gesamtergebnis

select * from u2022
UNION 
select * from u2021
UNION 
select * from u2020


--Vorsicht : UNION 

select 100
UNION
select 200
UNION 
select 300
UNION --macht distinct
select 100



create view Umsatz
as
select * from u2022
UNION  ALL
select * from u2021
UNION  ALL --kein Suche nach doppelten , weils keine gibt
select * from u2020

select * from umsatz where jahr = 2022 --alle tabellen im Plan


ALTER TABLE dbo.u2021 ADD CONSTRAINT
	CK_u2021 CHECK (jahr=2021)
select * from umsatz 

--nach Einschränkungen auf allen Tabellen, sicht er bei Jahr = xxxx nur noch die Tabellen raus, die die Werte enthalten können


--Probleme: Sicht! -- INS UP DEL ? -->  insert geht akt nicht , weil : identity, und der PK , der über die Sicht eindeutig ist

insert into Umsatz (id, jahr, spx) values (1,2020, 10)

select * from u2020

select * from umsatz

--unhandlich: bei Änderungen (neues Jahr) .... neue Tabelle, neue Einschränkung auf Tabelle, View ändern, PK auf 2 Spalten

--geht auch besser:. rein physikalisch
