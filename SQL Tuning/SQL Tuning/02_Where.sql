--WHERE

Select * from tabelle where
													sp   =
															<  <=  >=
															>
															!=   <> 
															is null
															like --nur hier wildcards
																	% beliebig viele Zeichen 
																	_  ein Zeichen genau

															between
															in
															not ....
															[] Wertebereich reg Expression   steht für ein Zeichen genau

--Suche nach %   _   '


Warum kein = NULL

--weil jeder math Vergelich mit NULL zu NULL führt

select 0*3
select NULL * 3

Ausnahme

update tab set sp = NULL


--Frachtkosten sollen zw 10 und 20 sein 
select * from orders where  freight >= 10 and freight <= 20
select * from orders where freight between 10 and 20

--Wieviele DS gibts in Orders die von Ang 1, 3 5 oder 9 gemanaget wurden
select * from orders where EmployeeID = 1 or EmployeeID = 3  or EmployeeID = 5 or EmployeeID = 9
select * from orders where employeeid in (1,3,5,9)

--Liste mit allen AngIds aus UK
select employeeid  from employees where country = 'UK'

--geht auch mit Unterabfragen
select * from orders where employeeid in (select employeeid  from employees where country = 'UK')

select o.* from orders o  inner join employees e  on o.EmployeeID=e.EmployeeID where e.country = 'UK'

set statistics io, time on


--Bedingungen bei Unterabfragen

--where sp = (select ...) darf nur einen Wert zurückkommen
--
--where sp in (select ...) darf nur eine Spalte aber mehr zeilen zuürckkommen

--suche alle Kunden (Customers: Customerid) die mit A B oder C beginnen

--miot IN gehts nicht  weil in = Vergleiche macht
select * from customers where customerid < 'D' --rel schnell

--aber dann wie folgendes: alle  mit A B E  H oder S beginnend

select * from [order details]

select * from customers where customerid like '[ABEHS]%'

select * from customers where customerid like '[A-C]%'

--wie aber das: alle von a bis C und alle von S bis Z

select * from customers where customerid like '[A-CS-Z]%'
select * from customers where customerid like '[A-C|S-Z]%'

---Website .PIN für Karte....  A03C

--suche alle Zeilen, bei denen die PIN nicht stimmt

--tabelle .. PIN
select * from tabelle where PIN not  between 0 and 9999 .. was ist mit 0007 --wg führ 0

select * from tabelle where pin not like '[0-9}%[0-9}[0-9}[0-9}'

--Suche nach einem % 
select * from customers where companyname  like '%%%'- -- = %

select * from customers where companyname  like '%[%]%' -- = %

--suche nach Firmen, die ein ' drin haben

select * from customers where companyname like '%''%'

select * from customers where companyname like '%''%'

--suche nach Unterstrich

select * from customers where companyname like '%[_]%'



