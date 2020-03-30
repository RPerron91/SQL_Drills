--1) How many records are in the vehicles table? 33442
--SELECT COUNT(*)
--FROM vehicles;

-- 2) Write a query that returns all the records in the vehicles table.
--SELECT *
--FROM vehicles;

--3) Return the id, make, and model fields for all the records for 2010 vehicles
--SELECT id, make, model
--FROM vehicles
--WHERE year = 2010;

--4) Return the count of vehicles from 2010: 1109
--SELECT COUNT(*)
--FROM vehicles
--WHERE year = 2010;

--5) Return the count of vehicles between the years 2010 and 2015, inclusive: 5995
--SELECT COUNT(*)
--FROM vehicles
--WHERE year BETWEEN 2010 AND 2015;

--6) Return the count of vehicles from the years 1990, 2000, and 2010: 3026
--SELECT COUNT(*)
--FROM vehicles
--WHERE year IN (1990, 2000, 2010);

--7) Return the count of all records between 1987 and 2005, exclusive of the years 1990 and 2000: 17235
--SELECT COUNT(*)
--FROM vehicles
--WHERE year BETWEEN 1987 AND 2005 AND year != 1990 AND year != 2000;
--Testing another method for #7
--SELECT COUNT(*)
--FROM vehicles
--WHERE year BETWEEN 1987 AND 2005 AND year NOT IN (1990, 2000);

--8) Returns the year, make, model, and a field called average_mpg that calculates the average
--   highway/city fuel consumption
--SELECT (hwy + cty)/2 AS average_mpg, make, model, year
--FROM vehicles;

--9) Returns the year, make, model, and a text field displaying “X highway; Y city.”
--SELECT hwy || ' highway: ' || cty || ' city.', make, model, year
--FROM vehicles;

--10) Returns the id, make, model, and year for all records that have NULL for
--    either the cyl or displ fields

--SELECT id, make, model, year
--FROM vehicles
--WHERE cyl IS NULL OR displ IS NULL;

--11) Returns all fields for records with rear-wheel drive and diesel
--    vehicles since 2000, inclusive. Also sort by year and highway mileage, both descending

--SELECT *
--FROM vehicles
--WHERE drive = 'Rear-Wheel Drive' AND fuel = 'Diesel' AND year >= 2000
--ORDER BY hwy DESC, year DESC;

--12) Count the number of vehicles that are either Fords or Chevrolets
--    and either compact cars or 2-seaters: 2173

--SELECT COUNT(*)
--FROM vehicles
--WHERE (make = 'Ford' OR make = 'Chevrolet') AND (class ILIKE '%compact%' OR class ILIKE '%2wd');

--13) Return the records for 10 vehicles with the highest highway fuel mileage

--SELECT *
--FROM vehicles
--ORDER BY hwy DESC
--LIMIT 10;

--14) Return all the records of vehicles since the year 2000 whose model name
--    starts with a capital X. Sort the list A through Z by make
--    What happens when you use a lowercase “x” instead?:
--    Only displays smaller list of models starting with 'x'

--SELECT *
--FROM vehicles
--WHERE year >= 2000 AND model LIKE 'X%';

--15) Return the count of records where the “cyl” field is NULL: 58
--SELECT COUNT(*)
--FROM vehicles
--WHERE cyl IS NULL;

--16) Return the count of all records before the year 2000 that got
--    more than 20 mpg hwy and had greater than 3 liters displacement (“displ” field): 1964

--SELECT COUNT(*)
--FROM vehicles
--WHERE year < 2000 AND hwy > 20 AND displ > 3;

--17) Write a query that returns all records whose model name has a (capital) X in its 3rd position

--SELECT *
--FROM vehicles
--WHERE model LIKE '__X%';