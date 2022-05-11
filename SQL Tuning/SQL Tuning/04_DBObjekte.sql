--_Sichten
--Sicht enthält nur eine Abfrage und keine Daten
--können Sichten INS UP DEL.. geht aber nicht immer : join oder wenn Pflichtspalten nicht gefüllt sind
--Sichten werden wie Tabellen behandelt
--können auch Rechte haben
--Warum Sichten: Daten filtern 
--                            Komplexe Abfragen komfortabeler weiderverwendbar

create view vName
as
--nur 1 SELECT  (auch select mit UNION ) 

select * from view 

--Prozedur

create proc gpName @par1 int, @par2 int, ...
as
--CODE INS UP DEL SEL

exec gpname 2,5

--Warum Prozeduren

--zentraler Code 
--komlizierter Code mit BI Logik -- ähnelt eines Windws Batch
--sie ist schnell(er) als der normale Code


--F()
select f(wert) , f(Spalte) from f(sp) where f(spate) > (F(wert)

--extrem flexibel einsetzbar... aber sie sind LANGSAM!!!, weil schlecht vorab einschätzbar



--View ..und deren Problemzonen
create table slf (id int , stadt int, land int)

insert into slf
select 1,10,100
UNION 
select 2,20,200
union 
select 3,30,300

select * from slf

create or Alter view vslf
as
select * from slf;
GO --Batchdelimiter

select * from vslf

alter table slf add fluss int 

update slf set fluss = id *1000

select * from slf --alles

select * from vslf --kein Fluss obwohl * 

alter table slf drop column land

select * from vslf --komplett falsch .. Land mit Werten von Fluss???


--Vermeidung

--with schemabinding

--von vorne
drop table slf
drop view vslf


create table slf (id int , stadt int, land int)

insert into slf
select 1,10,100
UNION 
select 2,20,200
union 
select 3,30,300

select * from slf

create or Alter view vslf with schemabinding  ----du musst sehr exakt arbeiten
as
select id, stadt, land from dbo.slf; --kein * mehr--und Angabe von Schema
GO --Batchdelimiter

select * from vslf

alter table slf add fluss int 

update slf set fluss = id *1000

select * from slf --alles

select * from vslf --korrektes Ergebnis

alter table slf drop column land --geht nicht, weil Sicht nicht mehr korrekt wäre, es läßt sich jede Spalte löschen die nicht in der Sicht verwendet wrid und andersrum

select * from vslf 

--- 

create view vKundeUmsatz
as
SELECT      Customers.CustomerID, Customers.CompanyName, Customers.ContactName, Customers.ContactTitle, Customers.City, Customers.Country, Orders.EmployeeID, Orders.OrderDate, Orders.Freight, Orders.ShipName, Orders.ShipCity, Orders.ShipCountry, [Order Details].OrderID, [Order Details].ProductID, 
                   [Order Details].UnitPrice, [Order Details].Quantity, Products.ProductName, Products.UnitsInStock, Employees.LastName, Employees.FirstName, Employees.BirthDate
FROM         Customers INNER JOIN
                   Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                   [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                   Products ON [Order Details].ProductID = Products.ProductID INNER JOIN
                   Employees ON Orders.EmployeeID = Employees.EmployeeID;
GO

select * from vKundeUmsatz --schön einfach...

--Liste alle Kunden auf, die weniger als 1 Frachtkosten hatten
--wir wollen nur die customerid sehen

select customerid , freight from vKundeumsatz where freight < 1 --43 Zeilen

--einfache Liste der Kunden
select distinct customerid  from vKundeumsatz where freight < 1 --19

--was macht die Abfrage eigtl..?


--statt dessen
select distinct c.customerid from customers c inner join orders o on c.CustomerID=o.CustomerID
where freight < 1



--deutlich günstiger, wenn man die Sicht nicht verwendet, weil die Sicht alle Tabellen abfragen muss, aber der Join nur die notwendigen 2 Tabellen



--Prozedur

create proc gpname @par1 int , @par2 int = 100  (default Wert)
as
--code

--customers ..customerid nchar(5)   alfki Blaus 

exec gpKdSuche 'ALFKI' --1 Treffer
exec gpKdSuche 'A' --4 Treffer  alle mit A beginnend
exec gpKdSuche --dann alle


create or alter  proc gpKdSuche @Kdnr varchar(50) ='' --nchar(5) ... A    'A....%' --besser varchar
as
select * from customers where customerid like @kdnr + '%' --kein = !!

exec gpKdSuche 'ALFKI' --1 Treffer
exec gpKdSuche 'A' --4 Treffer  alle mit A beginnend
exec gpKdSuche --dann alle

--mit varchar klappts
--super schlechte Prozedur

--Proc sind schneller ..aber warum
--macht einen Plan mit den ersten Parameter (ALFKI.. 1 DS.. optimal    und der muss auch sehr gut sein für alle DS??????
--der Plan wird nach dem ersten Aufruf kompiliert


select * from customers where customerid like '' + '%' --kein = !!


set statistics io, time on


--schlimmer

create prc gpdemo1 @par1 int
as
If @par1 < 10 select * from orders where 
IF @par1 < 100 select * from customers where 
	else 
			select * from products

select * into ku from vKundeumsatz


insert into ku
select * from ku

alter table ku add id int identity



set statistics io, time on

create proc gpdemo @par1 int
as
select * from ku where id < @par1


select * from ku where id < 2

select 60000*8 --480

--optimierung

select * from ku where id < 2 --IX seek

--besser mit IX.. statt 60000 Seiten und 250ms CPU und 50ms Dauer... jetzt 0ms und 4 Seiten

--optimierung

select * from ku where id < 500000  --Scan


exec gpdemo 2


exec gpdemo 1000000

--Prozeduren sind super.. wenn sie richtig vrwendet werden--> sie sollen immer das gleiche liefern..
--rel wenige DS oder immer sehr viele.. aber nicht gemischt
--wie finden wir das raus... und was macht dagegen?


select * from orders where year(orderdate) = 1997 --immer ein SCAN




--wie praktisch

select * from orders











--der Plan scheint nicht immer optimal zu sein  immer SEEK egal mit welchem Parameter
--Plan besser mit SCAN oder bei SEEK bleiben


dbcc freeproccache --alle Pläne wegwerfen

exec gpdemo 1000000

exec gpdemo 2 








---F() 
--wer ist in Rentenalter: >= 65
select * from employees

select year(getdate())
select datepart(yy, getdate())

select dateadd(dd, -5, getdate()),  dateadd(yy, -65, Getdate())
select datediff(dd, getdate(), '30.7.1969'), datediff(dd, '30.7.1969', getdate())


select * from employees where year(getdate()) -year(BirthDate) >=65  --SCAN
select * from employees where   birthdate <=  dateadd(yy, -65, Getdate()) --SEEK
select * from employees where datediff (yy, birthdate, getdate()) > =65 ---SCAN


select * from  [Order Details]

--wie hoch ist die Rechnungsumme pro Bestellung

select orderid as BestNr, sum(unitprice*quantity) from [Order Details]
where orderid = 10248
group by orderid 

---günstigerweise ein F()--> fRngSumme(orderid) --- 440 --Skalarwertfunktion


create function fRngSumme(@BestNr int) returns money   ----decimal(10,2) 10 Stellen davon 2 Nachkommas  money kommt von float und hat 8 Nachkommastellen
as
BEGIN
	  return(select sum(unitprice*quantity) from [Order Details]		where orderid = @BestNr group by orderid )
END


select fRNGSumme (10248) --
select dbo.fRNGSumme (10248) --


alter table orders add RngSumme as dbo.fRngSumme(orderid)

select * from orders ---RngSumme drin ..genial...
where RngSumme = 440


---die F(), die am meisten Aufwand erzeugt taucht weder im tats Plan noch in Stats auf..
--SQL 2019 ... einfachen Skalarwertf() --> Unterabfragen

--F() werden auch nicht paralellisiert --merh CPUS für eine Abfragen



--adhoc  Sichten proz f()

--langsam-----------------------------> schnell
--F()    --- Sichten / adhoc   --> Proz

--Proz    --F() -->  Sihten/adhoc

---





