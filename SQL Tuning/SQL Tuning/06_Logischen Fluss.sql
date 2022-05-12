---SELECT --  %wert
--1 MIO / 50000 Seiten -------->  SEEK 100 / 5000 DS                                   100 Seiten
---From ------------------------> WHERE (SCAN  / SEEK) ---> GROUP BY --------> HAVING  ---> SELECT (nicht Ausgabe Alias/Mathe)
-----> ORDER BY ---> TOP DISTINCT ---> Ausgabe


*/

--Bläd!
select country,  sum(unitprice*quantity) from [Order Details]
group by country having country = 'UK'

--tu nie Dinge im having filtern was ein where kann!!
--im having sollte immer nur ein AGG zu finden sein



select country, city as Stadt from customers c where c.Country = 'UK' order by Country

select country, city as Stadt from customers c 
	where c.Country = 'UK'  and city = 'LONDON'
order by stadt


