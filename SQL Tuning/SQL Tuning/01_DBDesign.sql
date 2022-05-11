--DBDesgn


/*
ACID
Normalisierung
PK  --Beziehung --> FK
Datentypen
Generalisierung
Redundanz



1:NF : in jeder Zelle nur ein Wert
2.NF PK (muss eindeutig sein--muss Beziehungen eingehen
3. NF

Beziehungen -- ref Integrität
SHOP



Kunden
KdNR
Vorname
Nachname
Email
PLZ
ORT
STRASSE HR
Hobby1
Hobby2
Hobby3
Fax1
Fax2
Fax3
Frau1
Frau2 NULL ''  0
Frau3
Frau4
Religion
....


Bestellung
KdNr
Menge
PrNr
Datum --datepart(yy  qq  mm  hh   ss dw ww
Lieferkosten
AngNr


2		10	5		3.5.2022   5     7
2		1		1		3.5.2022   5     7
2		10	100	3.5.2022   5



BestellKopf
BestellNr
KdNr
Datum
Lieferkosten
AngNr


BestPos
BestNr
PrNr
Menge
Preis






Produkte
PrNr
Bez
Preis



VS Physik
max Größe eines DS 8060 bytes ..gilt bei fixen Längen
1 DS liegt immer in Seiten
1 Seiten hat max 700 Slots
8 Seiten am Stück = Block Extent
Ist ene Seiten nicht ganz gefüllt, dann wird sie trotzdem 1:1 in RAM geschoben
1 Seiten hat 8192bytes





*/

create table t1 (id int , spx char(4100), spy char(4100))




use northwind


create table t1  (id int identity, spx char(4100))

insert into t1
select 'XY'
GO 20000
--10 Sekunden

--nur Bedarf
set statistics io, time on -- CPU Dauer in MS   Dauer in ms Anzahl der Seiten
--läuft in der akt Sesssion bis off oder Session gekillt wird

--20 000 Datensätze a ca 4kb  --> 80MB  --aber lt Bericht = 160

select * from t1
--Lesevrgänge: 20000* 8 kb = 160MB---> auf HDD und im RAM!!!

--Prüfung auf Füllgrad
dbcc showcontig('t1')
--- Mittlere Seitendichte (voll).....................: 50.79% bei 20000 Seiten



--EVtl DB Design etwas umdenken
--c nur bei fixen Längen
--GebDatum date datetime(ms) datetime2(ns)  smalldatetime(sek) datetimeoffset (ms und Zeitzone)
--nvarchar  nchar  braucht doppelte Menge



--1 DS hat 4100  ...kann max 8060  Seiten kann max 8192

--Suche nach allen Best aus dem Jahr 1997
select * from orders where year(orderdate) =1997 --korrekt aber langsam
select * from orders where datepart(yy, orderdate) =1997 --korrektaber langsam
select * from orders where orderdate between  '1.1.1997' and '31.12.1997' --schnell aber falsch weil tag hat 23:59:59

select * from orders where orderdate between  '1.1.1997' and '31.12.1997 23:59:59.999'  -- schnell aber falsch (1998)

---  datetime (ms) aber ungenau 
select customerid, country from customers



--schneller Blick auf DB Design
