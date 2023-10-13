-- Create Store procedure IN MS SQL

use rise

	select name as Table_Name
	from sys.tables

	select * from BoardingPass
	sp_help boardingpass

	create procedure sp_name
    as 
	begin 
    select * from BoardingPass 
	end

    

drop procedure SP_name

exec SP_name '@tid= b1', '@class= Bussiness Class'

alter procedure 
CREATE TABLE employee
(
    id         INTEGER NOT NULL PRIMARY KEY,
    first_name VARCHAR(10),
    last_name  VARCHAR(10),
    salary     DECIMAL(10, 2),
    city       VARCHAR(20),
)

INSERT INTO employee
VALUES      (2,
             'Monu',
             'Rathor',
             4789,
             'Agra');

go

INSERT INTO employee
VALUES      (4,
             'Rahul',
             'Saxena',
             5567,
             'London');
go

INSERT INTO employee
VALUES      (5,
             'prabhat',
             'kumar',
             4467,
             'Bombay');
go

INSERT INTO employee
VALUES      (6,
             'ramu',
             'kksingh',
             3456,
             'jk');
go

SELECT *
FROM   employee

--- Create store procedure with subquery 

create proc SP_Name_Salary
as 
begin
select first_name , last_name from employee where  salary > (select avg(salary) from employee)
end
select * from employee
execute SP_Name_Salary

create proc SP_COunt
@empcount int out
as 
begin
select @empcount= count(*) from employee
end

declare @totalcount int
exec SP_COunt @empcount=@totalcount out
print @totalcount 

create table account
(
"AC_No" int primary key,
"AC_Name" nvarchar(50),
"AC_Type" nvarchar(10),
Branch nvarchar(50),
"AC_Balance" money
)


create table Transcation(
"AC_No" int,
"AC_Name" nvarchar(50),
Transaction_ID int identity(78975,59),
Debit money,
credit money,
"Date" nvarchar(50) default sysdatetime()
)

drop table Transcation

select * from Transcation
select * from account

alter table Transcation add constraint FK_TR_NO foreign key ("AC_No")
references account("AC_No") on update cascade 


sp_help account
SP_help Transcation


create procedure credit
@AC_No int , @AC_Name nvarchar(50), @credit money
as
begin 
insert into Transcation (AC_No ,AC_Name ,credit) values ( @AC_No , @AC_Name , @credit)
update account set AC_Balance = @credit + AC_Balance where AC_No = @AC_No
end
-- Query to run credit command

credit @AC_No = 200200126 , @credit = 550000, @AC_Name = "Kinjal"

--- Query for debit Command

create procedure debit
@AC_No int , @AC_Name nvarchar(50), @debit money
as
begin
declare @AC_Balance money
select    @AC_Balance = AC_Balance  from Account where AC_No = @AC_NO
if @AC_Balance >= @debit
begin
insert into Transcation (AC_No ,AC_Name ,debit) values ( @AC_No , @AC_Name , @debit)
update account set AC_Balance = AC_Balance - @debit  where AC_No = @AC_No
print 'Debit transaction successfully Done'
end
else
begin	
print 'Transcation Failed Due To insufficient balance in  your account'
end
end
debit @AC_No = 200200125 , @AC_Name = "Hiral", @debit = 78052.00

select * from account
select * from Transcation
