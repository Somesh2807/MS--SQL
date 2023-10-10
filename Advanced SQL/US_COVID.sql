create database US_COVID
use US_COVID
CREATE TABLE countries_aggregated (
	"Date" Date,
	Country NVARCHAR(32), 
	Confirmed bigint , 
	Recovered bigint , 
	Deaths bigint 
);

CREATE TABLE reference
(
	"UID" DECIMAL(38, 0), 
	iso2 VARCHAR(2), 
	iso3 VARCHAR(3), 
	code3 DECIMAL(38, 0), 
	FIPS DECIMAL(38, 0), 
	Admin2 VARCHAR(41), 
	Province_State VARCHAR(40), 
	Country_Region VARCHAR(32) , 
	Lat DECIMAL(38, 8), 
	Long DECIMAL(38, 9), 
	"Combined_Key" VARCHAR(55) , 
	"Population" DECIMAL(38, 0)
);

CREATE TABLE us_confirmed
(
	"UID" DECIMAL(38, 0) , 
	iso2 VARCHAR(2) , 
	iso3 VARCHAR(3) , 
	code3 DECIMAL(38, 0) , 
	"FIPS" DECIMAL(38, 0), 
	"Admin2" VARCHAR(41), 
	"Lat" DECIMAL(38, 15) , 
	"Combined_Key" VARCHAR(55) , 
	"Date" DATE , 
	"Case" DECIMAL(38, 0) , 
	"Long" DECIMAL(38, 14) , 
	"Country/Region" VARCHAR(2) , 
	"Province/State" VARCHAR(24) 
);

CREATE TABLE us_simplified (
	"Date" DATE , 
	"FIPS" DECIMAL(38, 0), 
	"Admin2" VARCHAR(41), 
	"Province/State" VARCHAR(24)   , 
	"Confirmed" DECIMAL(38, 0)   , 
	"Deaths" DECIMAL(38, 0)   , 
	"Population" DECIMAL(38, 0)   , 
	"Country/Region" VARCHAR(2)   
);

CREATE TABLE worldwide_aggregate 
(
	"Date" DATE   , 
	"Confirmed" DECIMAL(38, 0)   , 
	"Recovered" DECIMAL(38, 0)   , 
	"Deaths" DECIMAL(38, 0)   , 
	"Increase rate" DECIMAL(38, 16)
);

CREATE TABLE key_countries_pivoted (
	"Date" DATE  , 
	"China" DECIMAL(38, 0)  , 
	"US" DECIMAL(38, 0)  , 
	"United_Kingdom" DECIMAL(38, 0)  , 
	"Italy" DECIMAL(38, 0)  , 
	"France" DECIMAL(38, 0)  , 
	"Germany" DECIMAL(38, 0)  , 
	"Spain" DECIMAL(38, 0)  , 
	"Iran" DECIMAL(38, 0)  
);

CREATE TABLE time_series_19_covid_combined (
	"Date" DATE, 
	"Country/Region" VARCHAR(32)  , 
	"Province/State" VARCHAR(32), 
	"Lat" DECIMAL(38, 16)  , 
	"Long" DECIMAL(38, 16)  , 
	"Confirmed" DECIMAL(38, 0)  , 
	"Recovered" DECIMAL(38, 0), 
	"Deaths" DECIMAL(38, 0)  
);

CREATE TABLE us_deaths
(
	"UID" DECIMAL(38, 0)  , 
	iso2 VARCHAR(2)  , 
	iso3 VARCHAR(3)  , 
	code3 DECIMAL(38, 0)  , 
	"FIPS" DECIMAL(38, 0), 
	"Admin2" VARCHAR(41), 
	"Lat" DECIMAL(38, 15)  , 
	"Combined_Key" VARCHAR(55)  , 
	"Population" DECIMAL(38, 0)  , 
	"Date" DATE  , 
	"Case" DECIMAL(38, 0)  , 
	"Long" DECIMAL(38, 14)  , 
	"Country/Region" VARCHAR(2)  , 
	"Province/State" VARCHAR(24)  
);





BULK INSERT us_deaths FROM "G:\US COVID\us_deaths_csv.csv" WITH 
(format='CSV',  FIELDTERMINATOR = ',', ROWTERMINATOR = '\n',  FIRSTROW = 2)

csvsql __dialect mysql __snifflimit 999999999 us_confirmed_csv.csv>us_confirmed.sql


INSERT INTO US_COVID.dbo.reference
SELECT * FROM master.dbo.reference

select name
from sys.tables
select * from	us_simplified
select * from	worldwide_aggregate
select * from	key_countries_pivoted
select * from	time_series_19_covid_combined
select * from	us_deaths
select * from	us_confirmed
select * from	countries_aggregated
select * from	reference

select sum([Case]) over (partition by [Country/Region]) as case1,
Row_Number() over (order by [Country/Region] ) as row_num1
from us_deaths

select * from us_deaths