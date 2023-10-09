create database practice
use practice

create table sales(
Emp_Name nvarchar(50),
City_ID int primary key,
Sales money)


select * from sales,country



select * from city
create table City(
City_ID int,
City nvarchar(50),
Country_ID int);

create table Country (
Country_ID int primary key,
Country_Name nvarchar(50)
)

alter table City add constraint FK_Country_ID foreign key (Country_ID) references Country(Country_ID)
on delete cascade on update cascade

---list of emp and countries they belong to

select s.Emp_Name,e.Country_Name
from sales S
full join City C on s.City_ID = c.City_ID
full join Country E on c.Country_ID=e.Country_ID


---list of employe details who belongs to only in INdia or US

select s.Emp_Name,e.Country_Name
from sales S
 join City C on s.City_ID = c.City_ID
join Country E on c.Country_ID=e.Country_ID
where e.Country_Name = 'India' or Country_Name = 'US'
