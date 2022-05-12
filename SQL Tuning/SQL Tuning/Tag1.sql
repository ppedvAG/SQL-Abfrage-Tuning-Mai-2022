/*

DB Design 
Normalisierung --> zu viele JOINs --> langsamer
geziet Redundanz um JOINs zu sparen

pyhsische DB Design

Seiten / Blöcke

8192bytes
1 DS max 8060 bei fixen Längen
Seiten kann max 8070 bytes Nutzlast bzw max 700 Slots

Seiten werden 1:1 von HDD in RAM geschoben

Seiten sollten daher möglichst hohen Füllgrad haben


*/

dbcc showcontig('ku'
----- Gescannte Seiten.............................: 47410
- --Mittlere Seitendichte (voll).....................: 97.98%

set statistics io, time on
select * from ku where freight < 10

--Seitenzahl bei SCAN:  119900  / 58893 vs dbcc  : 94800 / 47000

select (59889-47410)


--der dbcc konnte das nicht verraten..
---das einfügen der Spalte ID hatte lange gedauert


select * from customers

insert into customers (customerid, CompanyName) values ('ppedv', 'Fa ppedv')


select * from sys.dm_db_index_physical_stats(db_id(), object_id('ku'), NULL, NULL, 'detailed')

--forward Record Counts: 12479  int

--Problem beheben:


