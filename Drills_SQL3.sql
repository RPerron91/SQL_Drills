--Write a query that returns the namefirst and namelast fields of the people table,
--along with the inducted field from the hof_inducted table. 
--All rows from the people table should be returned,
--and NULL values for the fields from hof_inducted should be returned when there is no match found.

SELECT p.namefirst, p.namelast, hof.inducted
FROM people as p
	LEFT OUTER JOIN hof_inducted hof ON p.playerid = hof.playerid;

--In 2006, a special Baseball Hall of Fame induction was conducted for players from the negro baseball leagues.
--In that induction, 17 players were posthumously inducted into the Baseball Hall of Fame. 
--Write a query that returns the first and last names, birth and death dates, and birth countries for these players. 
--Note that the year of induction was 2006, and the value for votedby will be “Negro League.”

SELECT p.namefirst, p.namelast, p.birthyear, p.deathyear, p.birthcountry
FROM people p
	INNER JOIN hof_inducted hof ON p.playerid = hof.playerid
WHERE hof.yearid = 2006 AND hof.votedby = 'Negro League';

--Write a query that returns the yearid, playerid, teamid, and salary fields from the salaries table, 
--along with the category field from the hof_inducted table. 
--Keep only the records that are in both salaries and hof_inducted. 
--Hint: While a field named yearid is found in both tables, don’t JOIN by it. 
--You must, however, explicitly name which field to include.

SELECT s.yearid, s.playerid, s.teamid, s.salary, hof.category
FROM salaries s
	INNER JOIN hof_inducted hof ON s.playerid = hof.playerid;

--Write a query that returns the playerid, yearid, teamid, lgid, and salary fields from the salaries table 
--and the inducted field from the hof_inducted table. Keep all records from both tables.

SELECT s.playerid, s.yearid, s.teamid, s.lgid, s.salary, hof.inducted
FROM salaries s
	FULL OUTER JOIN hof_inducted hof ON s.playerid = hof.playerid;
	
--There are 2 tables, hof_inducted and hof_not_inducted, indicating successful and unsuccessful inductions 
--into the Baseball Hall of Fame, respectively:
--Combine these 2 tables by all fields. Keep all records,
--then get a distinct list of all player IDs for players who have been put up for HOF induction

SELECT * 
FROM hof_inducted
UNION
SELECT *
FROM hof_not_inducted;

SELECT DISTINCT(playerid)
FROM hof_inducted
WHERE inducted = 'Y' AND category = 'Player';

--Write a query that returns the last name, first name (see people table), 
--and total recorded salaries for all players found in the salaries table.

SELECT p.namelast, p.namefirst, SUM(s.salary) total_salary
FROM people p
	INNER JOIN salaries s ON p.playerid = s.playerid
GROUP BY p.playerid;

--Write a query that returns all records from the hof_inducted and hof_not_inducted tables that include: 
--playerid, yearid, namefirst, and namelast. Hint: Each FROM statement will include a LEFT OUTER JOIN!

SELECT hofi.playerid, hofi.yearid, p.namefirst, p.namelast
FROM hof_inducted hofi
	LEFT OUTER JOIN people p ON hofi.playerid = p.playerid
UNION
SELECT hofni.playerid, hofni.yearid, p.namefirst, p.namelast
FROM hof_not_inducted hofni
	LEFT OUTER JOIN people p ON hofni.playerid = p.playerid;

--Return a table including all records from both hof_inducted and hof_not_inducted,
--and include a new field, namefull, which is formatted as namelast , namefirst 
--(in other words, the last name, followed by a comma, then a space, then the first name).
--The query should also return the yearid and inducted fields. Include only records since 1980 from both tables. 
--Sort the resulting table by yearid, then inducted so that Y comes before N. Finally, sort by the namefull field, A to Z

SELECT hofi.*, CONCAT(p.namefirst, ', ', p.namelast) AS namefull
FROM hof_inducted hofi
	LEFT JOIN people p ON p.playerid = hofi.playerid
WHERE yearid > 1980
UNION
SELECT hofni.*, CONCAT(p.namefirst, ', ', p.namelast) AS namefull
FROM hof_not_inducted hofni
	LEFT JOIN people p ON p.playerid = hofni.playerid
WHERE yearid > 1980
ORDER BY yearid, inducted DESC, namefull;

--Write a query that returns the highest annual salary for each teamid, ranked from high to low, 
--along with the corresponding playerid. 
--Bonus! Return namelast and namefirst in the resulting table. (You can find these in the people table.)

SELECT s.teamid, MAX(s.salary) max_salary, s.playerid, p.namelast, p.namefirst
FROM salaries s
	INNER JOIN people p ON p.playerid = s.playerid
GROUP BY s.teamid, s.playerid, p.namelast, p.namefirst
ORDER BY max_salary DESC;

--Select birthyear, deathyear, namefirst, and namelast of all the players born since the birth year of Babe Ruth
--(playerid = ruthba01). Sort the results by birth year from low to high

SELECT birthyear, deathyear, namefirst, namelast
FROM people
WHERE birthyear > (SELECT birthyear FROM people WHERE playerid = 'ruthba01')
ORDER BY birthyear;

--Using the people table, write a query that returns namefirst, namelast, and a field called usaborn. 
--The usaborn field should show the following: if the player's birthcountry is the USA, then the record is 'USA.' 
--Otherwise, it's 'non-USA.' Order the results by 'non-USA' records first

SELECT namefirst, namelast, 
	CASE WHEN birthcountry = 'USA' THEN 'USA'
		 ELSE 'non-USA'
	END usaborn
FROM people
ORDER BY usaborn;

--Calculate the average height for players throwing with their right hand versus their left hand. 
--Name these fields right_height and left_height, respectively.

SELECT DISTINCT((SELECT ROUND(AVG(height), 2) right_height FROM people WHERE throws = 'R' )), 
	   (SELECT ROUND(AVG(height), 2) left_height FROM people WHERE throws = 'L' )
FROM people;

--Get the average of each team's maximum player salary since 2010. Hint: WHERE will go inside your CTE.

WITH smax2010 AS 
(
SELECT MAX(salary) as max_salary, teamid, yearid
FROM salaries
WHERE yearid >= 2010
GROUP BY teamid, yearid
)
SELECT teamid, ROUND(AVG(max_salary), 2) AS avg_max_sal
FROM smax2010
GROUP BY teamid;