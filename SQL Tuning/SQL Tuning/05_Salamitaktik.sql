--Seiten (IO) --- weniger --> weniger CPU 
					-- weniger RAM Auslastung 

--part Sicht-------------

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

--geht auch besser:. rein physikalisch --> Partitionierung

-------100------------200-----------------------------
-- 1                 2                                3


create function fxy (@zahl int) returuns int .. hätte gerne 100 Bereiche
as
begin
	If @zahl <= 100 return 1
	If @zahl > 200 return 1
end


create partition function fzahl(int) 
as
RANGE LEFT for values (100, 200)

select $partition.fzahl(117)



create table t2 (id int) ON HOT

--bis100    bis200   rest bis5000


create partition scheme schZahl
as
partition fzahl to (bis100,bis200, rest)
---                                 1            2       3

create table ptab (id int identity, nummer int, spx char(4100)) ON schZahl(nummer)


declare @i as int = 1

while @i <=20000
begin
		insert into ptab (nummer , spx) values (@i, 'XY')
		set @i +=1 --set @i=@i +1 -- :-(      set @i= +1
end

--wieso geht die Schleife schneller als der GO 20000 .. 6 sek statt 10 sek
--warum--- weil keine 20000 Batches!!


--GO 20000 = 20000 Batches und 20000 Transaktion

--while = 1 Batch .. schneller

drop table ptab
declare @i as int = 1
begin tran
while @i <=20000
begin
		insert into ptab (nummer , spx) values (@i, 'XY')
		set @i +=1 --set @i=@i +1 -- :-(      set @i= +1
end
commit


--hats was gebracht

set statistics io, time on

select * from ptab where id = 10-- weil 100 Seiten .... 100 log Lese

select * from ptab where nummer = 1000 --Seek auf HEap--- 3 Haufen


--Sperre auf Part möglich

set statistics io, time on
select * from ptab where nummer = 1000



--Jahresweise
create partition function fzahl(datetime)  --alles was sortierbar ist.. Tipp Grnzen sind harte Grenzen
as
RANGE LEFT for values ('31.12.2022 23:59:59.997','')

--A bis M  --- N bis S ---  T bis Z
create partition function fzahl(varchar(50))  --alles was sortierbar ist.. Tipp Grnzen sind harte Grenzen
as
RANGE LEFT for values ('N','T')

--A----------------M--- Maier


create partition scheme schZahl
as
partition fzahl ALL  to ([PRIMARY])--faktisch 15000 Teile machbar

---GROUP BY 
-- CTE

select * from Employees

--partition .. window function
--ist sql sytax case sensitiv
---GROUP BY 
-- CTE

















create partition scheme schZahl
as
partition fzahl to (bis100,bis200, rest)





