-- Create the database
create database Electric_Vehicle_Population;
use Electric_Vehicle_Population;

-- Create the Electric_Vehicles table
create table Electric_Vehicles
(    VIN varchar(200), 
    country varchar(200), 
    city varchar(200), 
    state varchar(200),
    postal_code int, 
    model_year int,
    make varchar(200), 
    model varchar(200),
    electric_vehicle_type varchar(200), 
    cafv_eligibility varchar(200),
    electric_range int, 
    base_msrp int,
    legislative_district varchar(200),
    dol_vehicle_id varchar(200), 
    vehicle_location varchar(200),
    electric_utility varchar(200), 
    census_tract_2020 varchar(200)
);

ALTER TABLE Electric_Vehicles
MODIFY COLUMN postal_code VARCHAR(100);


 -- Load data from CSV file into the Electric_Vehicles table
select * from Electric_Vehicles;
load data infile "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Electric_Vehicle_Population.csv" into table Electric_Vehicles
fields terminated by ','
ENCLOSED BY '"'
lines terminated by '\n'
ignore 1 rows;

-- To identify null values, not useful values, or potentially suspicious data in the electric vehicle dataset
--  Find Records with Unspecified Electric Utility:
SELECT * FROM electric_vehicles
WHERE Electric_Utility IS NULL OR Electric_Utility = '';

 -- to delete duplicates rows frow the table 
CREATE TABLE copy_of_electric_vehicles SELECT DISTINCT VIN , country, city, state , postal_code , model_year , make , 
    model, electric_vehicle_type , cafv_eligibility, electric_range , base_msrp , legislative_district , dol_vehicle_id , vehicle_location ,
    electric_utility, census_tract_2020  FROM electric_vehicles;
    
DROP TABLE electric_vehicles;
ALTER TABLE copy_of_electric_vehicles RENAME TO electric_vehicles;

SELECT COUNT(*) AS row_count FROM electric_vehicles;

-- Check for Unusual Model Years:
SELECT * FROM electric_vehicles
WHERE Model_Year < 2010 OR Model_Year > 2023; -- Example range for unusual years

SELECT * FROM electric_vehicles
WHERE country IS NULL OR country = '';



SELECT * FROM electric_vehicles
WHERE city IS NULL OR city = '';

SELECT * FROM electric_vehicles
WHERE legislative_district IS NULL OR legislative_district = '';


--  Market Analysis - Count of Vehicles by State
SELECT State, COUNT(*) AS VehicleCount
FROM electric_vehicles
GROUP BY State;

-- Model Performance Evaluation - Average Base MSRP by Make
SELECT Make, AVG(Base_MSRP) AS AvgMSRP
FROM electric_vehicles
GROUP BY Make;

-- Legislative Impact - Eligibility Breakdown
SELECT cafv_Eligibility, COUNT(*) AS EligibleCount
FROM electric_vehicles
GROUP BY cafv_Eligibility;

-- Range Optimization - Average Electric Range for PHEVs
SELECT AVG(Electric_Range) AS AvgRange
FROM electric_vehicles
WHERE Electric_Vehicle_Type = 'Plug-in Hybrid Electric Vehicle (PHEV)';


-- Electric Utility Partnerships - Count by Utility
SELECT Electric_Utility, COUNT(*) AS UtilityCount
FROM electric_vehicles
GROUP BY Electric_Utility;


-- Census Tract Analysis - Vehicles per Census Tract
SELECT `Census_Tract_2020`, COUNT(*) AS VehicleCount
FROM electric_vehicles
GROUP BY `Census_Tract_2020`;

-- Model Year Analysis - Count of Vehicles by Model Year
SELECT Model_Year, COUNT(*) AS VehicleCount
FROM electric_vehicles
GROUP BY Model_Year;

-- Top 5 Makes with Highest Base MSRP
SELECT Make, MAX(Base_MSRP) AS HighestMSRP
FROM electric_vehicles
GROUP BY Make
ORDER BY HighestMSRP DESC
LIMIT 5;

-- Average Electric Range by Vehicle Type
SELECT Electric_Vehicle_Type, AVG(Electric_Range) AS AvgRange
FROM electric_vehicles
GROUP BY Electric_Vehicle_Type;

-- County-wise Analysis - Count of Vehicles by County
SELECT County, COUNT(*) AS VehicleCount
FROM electric_vehicles
GROUP BY County;

-- Vehicles with Unknown Eligibility
select * from electric_vehicles 
where cafv_eligibility = 'Eligibility unknown as battery range has not been researched';


-- Highest Legislative Districts with Electric Vehicles
SELECT Legislative_District, COUNT(*) AS VehicleCount
FROM electric_vehicles
GROUP BY Legislative_District
ORDER BY VehicleCount DESC
LIMIT 5;
