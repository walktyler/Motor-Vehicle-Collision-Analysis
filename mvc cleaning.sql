-- 2235783 ROWS
SELECT COUNT(*) FROM DBO.RAW_COLLISIONS;

SELECT TOP 1 * FROM DBO.RAW_COLLISIONS;


-- No standardized format for vehicle type code
SELECT top 20 VEHICLE_TYPE_CODE_1, count(*) FROM DBO.RAW_COLLISIONS
GROUP BY VEHICLE_TYPE_CODE_1
order by count(*) desc;

-- Using 10% of the data, i'll determine what are the relevant vehicle type codes based on their usage. 
--NULL should be = to unknown
-- PASSENGER VEHICLE,SPORT UTILITY / STATION WAGON,TAXI,VAN,OTHER,UNKNOWN,BUS,SMALL COM VEH(4 TIRES),LARGE COM VEH(6 OR MORE TIRES),PICK-UP TRUCK, LIVERY VEHICLE,MOTORCYCLE,AMBULANCE,FIRE TRUCK,BICYCLE,NULL,SCOOTER,PEDICAB
WITH TOP_10 AS (SELECT TOP 10 PERCENT * FROM DBO.RAW_COLLISIONS) 
SELECT VEHICLE_TYPE_CODE_1, count(*) FROM TOP_10
GROUP BY VEHICLE_TYPE_CODE_1
ORDER BY COUNT(*) DESC;

-- Relevant Columns
SELECT TOP 100 collision_id, Crash_date, Crash_time, Borough, Zip_code, Latitude, Longitude, Location, 
Number_of_persons_injured,Number_of_persons_killed,
Number_of_pedestrians_injured,Number_of_pedestrians_killed,
Number_of_cyclist_injured,Number_of_cyclist_killed
Number_of_Motorist_injured, Number_of_Motorist_killed,
Contributing_factor_vehicle_1, Vehicle_Type_Code_1,
CASE WHEN UPPER(BOROUGH) NOT IN ('MANHATTAN','BROOKLYN','QUEENS','STATEN ISLAND','BRONX') OR BOROUGH IS NULL THEN 'UNSPECIFIED' END AS BOROUGH_IS,
CASE WHEN ZIP_CODE IS NULL THEN 'UNSPECIFIED' END AS ZIPCODE_IS,
CASE WHEN LATITUDE IS NULL THEN 'UNSPECIFIED' END AS LAT_IS,
CASE WHEN LONGITUDE IS NULL THEN 'UNSPECIFIED' END AS LONG_IS,
CASE WHEN LOCATION IS NULL THEN 'UNSPECIFIED' END AS LOCATION_IS
from DBO.Raw_Collisions; 

-- Check for duplicate collision ids

-- First method
SELECT collision_id, count(*) from dbo.raw_collisions
group by collision_id
having count(*) > 1
order by collision_id;

-- Second method
with cte as (
select collision_id, row_number() over (partition by collision_id order by collision_id ) rn from raw_collisions
) 
select * from cte
where rn > 1
order by rn desc;

-- CHECK FOR ABNORMALITIES IN BOROUGH COLUMN
SELECT BOROUGH FROM RAW_COLLISIONS
WHERE UPPER(BOROUGH) NOT IN ('MANHATTAN','BROOKLYN','QUEENS','STATEN ISLAND','BRONX')
AND BOROUGH IS NOT NULL;

create view mvc_frequency as
SELECT VEHICLE_TYPE_CODE_1, ROUND((count(*)/2235783.0)*100,4) as per FROM DBO.RAW_COLLISIONS
GROUP BY VEHICLE_TYPE_CODE_1
order by per desc;

-- standardizing names
--sedan
select distinct vehicle_type_code_1 from raw_collisions
where 
Lower(vehicle_type_code_1) LIKE '%sedan%'
--SUV
select distinct 
vehicle_type_code_1 from raw_collisions
where 
Lower(vehicle_type_code_1) LIKE '%suv%'
or
Lower(vehicle_type_code_1) LIKE '%station wagon%'
or
Lower(vehicle_type_code_1)LIKE '%utility vehicle%'
--Van
select distinct 
vehicle_type_code_1 from raw_collisions
where 
Lower(vehicle_type_code_1) LIKE '%van%'

--Buses, 20 types, condense
select distinct 
vehicle_type_code_1 from raw_collisions
where 
Lower(vehicle_type_code_1) LIKE '%bus%'

--Condense unknown and Null to one type
select distinct
vehicle_type_code_1 
from raw_collisions
where 
Lower(vehicle_type_code_1) LIKE '%unknown%'
or 
VEHICLE_TYPE_CODE_1 is null;
--Condense vehicle types where


select 
	COLLISION_ID,
	BOROUGH,
	LOCATION,
	LATITUDE,
	LONGITUDE
from raw_collisions
where 
LOCATION is null
AND 
LATITUDE IS NULL
AND LONGITUDE IS NULL;

-- Number of rows where location/latitude/longitude is null (240530)
-- If there's no geolocation data, then it will be removed.
select COUNT(*) from raw_collisions
where 
LOCATION is null
AND 
LATITUDE IS NULL
AND 
LONGITUDE IS NULL;

--If there is no location, we remove it from the dataset (1995253)
select COUNT(*) from raw_collisions
where 
LOCATION is NOT null;


--Number of rows where latitude and longitude is not present (1995243)
select 
* 
from raw_collisions
where latitude is not null
and LONGITUDE is not null;

-- difference of 10 records between those with a location, and those with a latitude and longitude. 
-- Found the 10 records with a lattitude and/or missing longitude
select * from raw_collisions
WHERE 
(latitude is not null and LONGITUDE is null)
OR 
(latitude is null and LONGITUDE is not null)

--update the missing longitude values 
select 
TRIM(')' FROM RIGHT(location,6)) 
from raw_collisions
WHERE 
(latitude is not null and LONGITUDE is null)
OR 
(latitude is null and LONGITUDE is not null)


-- Identifying then labeling boroughs that are null that have location data, location data can be used to identify borough.
SELECT 
COLLISION_ID,
LOCATION 
FROM raw_collisions
WHERE 
BOROUGH IS NULL
AND 
LOCATION IS NOT NULL;

WITH MVC_TC AS (
	SELECT 
		raw_collisions.COLLISION_ID,
		raw_collisions.CRASH_DATE,
		raw_collisions.CRASH_TIME,
		CASE WHEN raw_collisions.BOROUGH IS NULL THEN 'UNSPECIFIED' ELSE BOROUGH END AS BOROUGH,
		CASE WHEN raw_collisions.ZIP_CODE IS NULL THEN 0 ELSE ZIP_CODE END AS ZIP_CODE, 
		raw_collisions.LATITUDE, raw_collisions.LONGITUDE, raw_collisions.LOCATION,
		raw_collisions.NUMBER_OF_PERSONS_INJURED,
		raw_collisions.NUMBER_OF_PERSONS_KILLED,
		raw_collisions.NUMBER_OF_PEDESTRIANS_INJURED,
		raw_collisions.NUMBER_OF_PEDESTRIANS_KILLED,
		raw_collisions.NUMBER_OF_CYCLIST_INJURED,
		raw_collisions.NUMBER_OF_CYCLIST_KILLED,
		raw_collisions.NUMBER_OF_MOTORIST_INJURED,
		raw_collisions.NUMBER_OF_MOTORIST_KILLED,
		raw_collisions.CONTRIBUTING_FACTOR_VEHICLE_1,
		raw_collisions.VEHICLE_TYPE_CODE_1
	FROM raw_collisions
	WHERE LOCATION IS NOT NULL)
