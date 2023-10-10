create database US_COVID

CREATE TABLE countries-aggregated (
	'Date' Date,
	`Country` NVARCHAR(32), 
	`Confirmed` bigint , 
	`Recovered` bigint , 
	`Deaths` bigint 
);
