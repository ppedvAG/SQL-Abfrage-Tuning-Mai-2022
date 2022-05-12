-- INDIZES--
/*
GR IX

NGR IX

eindeutigen IX

zusammengesetzter IX = where

IX mit eingeschlossenen SP  = SELECT 

gefilterter Index --nur ein Teil indizieren, aber es sollten weniger Ebenen werden





eind. NG zusammengetzter IX mit eingechlossen





Nicht gr IX  -- ca 1000mal pro Tabelle
ist gut, wenn rel wenige Ergebniszeilen rauskommen (kann auch unter 1 % liegen)
wann kommen denn rel wenig raus:
		ID Abfragen  / PK


Gr IX nur 1mal pro Tabellen = Tabelle in soetierter Form
gut bei Bereichsabfragen
orderdate 


PK  macht per GUI immer einen eindeutigen  Gr IX rein.. oft Verschwendung
select * from best



*/
--Tabelle ohne IX, 
select * into ku1 from ku

set statistics io, time on

select id from ku1 where id = 10
--Tab Scan

--optimalen IX.. 
--Gr IX sollte orderdate

--NIX_ID
select id from ku1 where id = 10 -- 3Seiten  IX Seek


select id, freight from ku1 where id = 10 --IX seek mit Lookup

select id, freight from ku1 where id <12500  --bei 12500 bereits ein SCAN

---> ERGO:: vermeide LOOKUPs

--besser wäre;  alle Infos in den IX rein...
--NIX_IDFR
--aber ! der zusammengestzte IX kann nicht mehr als 16 Spalten und Schlüsselspalten dürfen in Summe nicht 900byte übersteigen
--und würde auch keinen Sinn
select id, freight from ku1 where id < 900000


select id, freight, country, city from ku1 where id < 100









--optimale IX
select country, city, sum(unitprice*quantity) 
from ku1
where  freight < 1 and employeeid =2
group by country, city


CREATE NONCLUSTERED INDEX [NIX1] ON [dbo].[ku1]
(	[EmployeeID] ,	[Freight] )
INCLUDE([City],[Country],[UnitPrice],[Quantity]) 
GO

CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>]
ON [dbo].[ku1] ([EmployeeID],[Freight])
INCLUDE ([City],[Country],[UnitPrice],[Quantity])

--ab einem OR keine Vorschlag mehr
select country, city, sum(unitprice*quantity) 
from ku1
where  freight < 1 OR employeeid =2
group by country, city

--NIXFR  NIXEID



select country, city, sum(unitprice*quantity) 
from ku1
where  freight < 1 OR employeeid =2 and Country = 'UK' --was macht der eigtl...
group by country, city

select country, city, sum(unitprice*quantity) 
from ku1
where  freight < 1 OR (employeeid =2 and Country = 'UK' )--was macht der eigtl...
group by country, city

select country, city, sum(unitprice*quantity) 
from ku1
where  (freight < 1 OR employeeid =2) and Country = 'UK' --was macht der eigtl...
group by country, city

---Tabelle mit Spalten ABC
--A B C  AB AC BA BC ABC ACB BCA BAC CAB CBA .. ca 1000 

--bitte keine überflüssigen bzw zu viele IX machen, da lle bei INS UP DEL aktualisert werden müssen...




select * into Kunden from customers



select  top 10 * from ku
--Abfrage: where  aggregat
----Wieviel Kunden gitb pro Land und Stadt , die wo mehr als 10 Stück kauften
set statistics io, time on
select country, city, count(*)
from ku
where quantity > 10
group by country, city

--SCAN ..besser mit NIX_   CPU-Zeit = 312 ms, verstrichene Zeit = 44 ms.  5700 Seiten


select country, city, count(*)
from ku1
where quantity > 10
group by country, city

---ähh???? 0 ms 2 ms Dauer ..keine Lesevorgänge

--stimmts ja oder nein.. ist die wirklich 3,5MB groß-- japp es stimmt
-- und es kommen nur 3,5 MB in RAM un dnich tmehr 450MB

--Grund .. wieso so klein: komprimiert

