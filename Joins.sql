create database ppt

use ppt

select name
from sys.tables

bulk insert Table1 from 'D:\New folder\table1.csv' with (format ='CSV', rowterminator = '\n', 
firstrow = 2, fieldterminator = ',')
bulk insert Table2 from 'D:\New folder\table2.csv' with (format ='CSV', rowterminator = '\n', 
firstrow = 2, fieldterminator = ',')

select * from Table1
select * from Table2

--- Left Join

SELECT A.Enrolment_ID, B.Name, b.Obtained_Marks
FROM Table1 A
left JOIN Table2 B
ON A.Enrolment_ID=b.Enrolment_ID

---------LEFT Outer Join

SELECT A.Enrolment_ID, B.Name, b.Obtained_Marks
FROM Table1 A
left JOIN Table2 B
ON A.Enrolment_ID=b.Enrolment_ID
where B.Enrolment_ID is null

-----Right Join

SELECT A.Enrolment_ID, B.Name, b.Obtained_Marks
FROM Table1 A
right JOIN Table2 B
ON A.Enrolment_ID=b.Enrolment_ID

-----Right Outer Join
SELECT A.Enrolment_ID, B.Name, b.Obtained_Marks
FROM Table1 A
right JOIN Table2 B
ON A.Enrolment_ID=b.Enrolment_ID
where A.Enrolment_ID is null

----- FUll Join OUTER

SELECT A.Enrolment_ID, B.Name, b.Obtained_Marks
FROM Table1 A
full outer JOIN Table2 B
ON A.Enrolment_ID=b.Enrolment_ID
--- FULL JOIN
SELECT A.Enrolment_ID, B.Name, b.Obtained_Marks
FROM Table1 A
full JOIN Table2 B
ON A.Enrolment_ID=b.Enrolment_ID



--- INNER JOIN
SELECT A.Enrolment_ID, B.Name, b.Obtained_Marks
FROM Table1 A
Inner JOIN Table2 B
ON A.Enrolment_ID=b.Enrolment_ID


create table Boarding_Pass(
Ticket_ID int,
Name nvarchar(50),
Seat_No int,
Class nvarchar(50)
);

bulk insert Seats from 'D:\New folder\Seats.csv' with (fieldterminator =',', rowterminator ='\n', format = 'CSV', firstrow =2)

create table Ticket_No(
Ticket_ID int,
Seat_No int
);

create table Seats(
Ticket_ID int,
Seat_No int,
Class nvarchar(50)
);

select * from Seats
select * from Ticket_No
select * from Boarding_Pass


--airline company wants to understand they are selling most of the tickets
--- list of ticket having no boarding pass

select b.Class,  count(*) as Ticket_Count
from Boarding_Pass B
Join Seats S
on s.Ticket_ID= b.Ticket_ID
group by s.Class, b.Class 

select b.Ticket_ID,t.Ticket_ID
from Ticket_No T
right join Boarding_Pass B
on t.Ticket_ID=b.Ticket_ID
where b.Ticket_ID is null