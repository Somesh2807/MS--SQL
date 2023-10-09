create database Rise
Use RISE
Go





Create table BoardingPass(
Tid nvarchar(5),
Name nvarchar(20),
Seat nvarchar(10),
class nvarchar(20)
)




create table TicketNo(
Tid nvarchar(5),
Seat nvarchar(10)
)




create table Seats(
Tid nvarchar(5),
Seat nvarchar(10),
Class nvarchar(20)
)




insert into BoardingPass values('B1','Aman','S1','Bussiness Class')
insert into BoardingPass values('B2','Dhruvesh','S3','General Class')
insert into BoardingPass(Tid,Name)values('B3','Meshva')
insert into BoardingPass values('B4','Jignesh','S6',' Semi-Eco Class')
insert into BoardingPass(Tid,Name)values('B5','Vishal')




select *from BoardingPass
select *from TicketNo
select *from Seats




insert into TicketNo values('B1','S1')
insert into TicketNo values('B2','S2')
insert into TicketNo values('B3','S5')
insert into TicketNo values('B6','S7')
insert into TicketNo values('B7','S9')




insert into Seats values('B1','S1','Bussiness Class')




insert into Seats values('B4','S5','Ecomony Class')




insert into Seats values('B7','S7','Gen Class')




insert into Seats values('B11','S12','Bussiness Class')








--An Airline company want to know that which category they are selling the most of the ticket.




SELECT
    C.class,
    Count(*) AS TotalTicketsSold
FROM
    TicketNo AS T
JOIN
    BoardingPass AS C ON T.Tid = C.Tid
GROUP BY
    C.class
ORDER BY
    TotalTicketsSold DESC;




--list of tickets having no boarding pass
SELECT t.Tid
FROM TicketNo t
LEFT JOIN BoardingPass b ON t.Tid = b.Tid
WHERE b.Tid IS NULL;

select name
from sys.tables

select * from Boardingpass
select * from TicketNo
select * from Seats

--find the maximum most popular class
--count of seat number
--which passenger name has spend most of the ammount(total). booking and ticket table

select top 1 count(s.Class) as Count, a.Class
from seats s
join seats A  on s.Tid=a.Tid
group by a.Class

