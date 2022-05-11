---INNER  LEFT RIGHT FULL CROSS JOIN
--LEFT JOIN = RIGHT JOIN nur umgedreht

--

select * from tabelle A left join tabelle B on 
					--links                      --rechts


--					CROSS JOIN .. alles mit allem 

select * from tabelle A  cross join tabelle b --kein ON


select * from tabelle A inner join tabelle B on A.Sp = B.Sp
										inner join tabelle C on C.sp = A.Sp
										inner join tabelle D on...D.sp = F.Sp --geht nicht
										inner join tabelle F on...

where 








