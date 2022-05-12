--Session 1
begin transaction
select @@TRANCOUNT

--update kunden set city = 'Paris' where customerid = 'ALFKI'
update customers set city = 'Paris' where customerid = 'ALFKI'


select * from Customers

rollback

--Session 2
select * from kunden where customerid = 'FISSA'  --geht auch nicht.. kruzi....

select * from customers where customerid = 'ALFKI' --musste warte

select * from customers where customerid = 'FISSA'  --geht auch nicht.. kruzi....

set transaction isolation level read committed
set transaction isolation level read uncommitted -- eigt ein nicht sicherr undef Zustand