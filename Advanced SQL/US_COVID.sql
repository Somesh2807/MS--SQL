create database US_COVID

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



BULK INSERT reference FROM "G:\US COVID\reference_csv.csv" WITH 
(format='CSV',  FIELDTERMINATOR = ',', ROWTERMINATOR = '\n',  FIRSTROW = 2)

select * from countries_aggregated

