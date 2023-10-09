create database The_CHINOOK

use The_CHINOOK

create table Artist(
Artist_id bigint primary key,
Name nvarchar(50)
);

create table Album(
Album_ID bigint primary key,
Title Nvarchar(30),
Artist_ID bigint,
foreign key(Artist_ID) references Artist(Artist_ID)
);

create table Track(
Track_ID int primary key,
Name Nvarchar(50),
Album_ID Bigint,
Media_Type_ID Int,
Genere_ID bigint,
Composer Nvarchar(20),
Miliseconds time,
Bytes varbinary(max),
unit_Price money,
foreign key (Album_ID) references Album(Album_Id)
);

Create Table Media_Type(
Media_Type_ID Int primary key,
Name nvarchar(50)
);


Create Table Playlist(
Playlist_ID int primary key,
Name Nvarchar(50)
);

create table Playlist_Track(
Playlist_ID int,
Track_ID int
);

create Table Genere(
Genere_ID bigint primary key,
Name nvarchar(50)
);

Create table Invoice_Line(
Invoiceline_ID int primary key,
Invoice_ID Int,
Track_ID int,
Unit_Price money,
Quantity int
);

create table Invoice(
Invoice_ID int primary key,
Customer_ID int,
Invoice_Date date,
Billing_Address nvarchar(500) not null,
Billing_City nvarchar(50) not null,
Billing_State nvarchar(30) not null,
Billing_Country nvarchar(30) not null,
Billing_Postal_Code int not null,
Total Money,
);


Create table Employee(
Employee_ID nvarchar(30),
First_Name nvarchar(20),
Last_Name nvarchar(20),
Title nvarchar(20),
Reports_To nvarchar(20),
Birth_Date date,
Hire_Date date,
"Address" nvarchar(50),
City nvarchar(10),
"State" Nvarchar(20),
Country nvarchar(30) not null,
Postal_Code int not null,
Phone_No bigint,
Fax Bigint,
Email nvarchar(50)
);



create table Customer(
Customer_ID int primary key,
First_Name nvarchar(20) not null,
Last_Name nvarchar(20) not null,
Company nvarchar(20),
"Address" nvarchar(50),
City nvarchar(10),
"State" Nvarchar(20),
Country nvarchar(30) not null,
Postal_Code int not null,
Phone_No bigint,
Fax Bigint,
Email nvarchar(50),
Support_ReID nvarchar(30)
);

alter table Playlist_Track add constraint FK_playlist foreign key (Playlist_ID) 
references Playlist(Playlist_ID) on update cascade on delete cascade

alter table Album add constraint AK_Artist foreign key (Artist_ID) 
references Artist(Artist_id) on update cascade on delete cascade

alter table Album add constraint AK_Artist foreign key (Artist_ID) 
references Artist(Artist_id) on update cascade on delete cascade

alter table Playlist_Track add constraint FK_TRACKID foreign key (Track_ID) 
references Track(Track_ID) on update cascade on delete cascade

alter table Invoice_Line add constraint FK_TRACKID_Invoice foreign key (Track_ID) 
references Track(Track_ID) on update cascade on delete cascade

alter table Track add constraint FK_Media_Type foreign key (Genere_ID) 
references Genere(Genere_ID) on update cascade on delete cascade

alter table Track add constraint FK_Media foreign key (Media_Type_ID) 
references Media_Type(Media_Type_ID) on update cascade on delete cascade

alter table Invoice add constraint FK_CustomerID foreign key (Customer_ID) 
references Customer(Customer_ID) on update cascade on delete cascade

alter table Customer add constraint FK_Support foreign key (Support_ReID) 
references Employee(Employee_ID) on update cascade on delete cascade

alter table Employee alter column Employee_ID nvarchar(30)not null
alter table Employee add constraint PK_Employee_ID primary key (Employee_ID)

alter table Invoice_Line add constraint FK_invoice_ID foreign key (Invoice_ID) 
references Invoice(Invoice_ID) on update cascade on delete cascade




