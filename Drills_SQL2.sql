----1) Return a list of all the unique values in the 'country' field

--SELECT DISTINCT country
--FROM ksprojects;

----2) How many unique values are there for the main_category field?: 15
----   What about for the category field?: 158

--SELECT COUNT(DISTINCT main_category) AS main_categories, COUNT(DISTINCT category) AS categories
--FROM ksprojects;

----3)  List all the unique combinations of main_category and category fields,
----    sorted A to Z by main_category

--SELECT DISTINCT main_category, category
--FROM ksprojects
--ORDER BY main_category;

----4) Number of unique categories in each category

--SELECT DISTINCT main_category, COUNT(DISTINCT category) AS count_categories
--FROM ksprojects
--GROUP BY main_category
--ORDER BY main_category;

----5) Return the average number of backers per main_category,
----   rounded to the nearest whole number and sorted from high to low

--SELECT main_category, ROUND(AVG(backers),0) as avg_backers
--FROM ksprojects
--GROUP BY main_category
--ORDER BY avg_backers DESC;

----6) For each category, how many campaigns were successful
----   and the average difference per project between dollars pledged 
----   and the goal for successful campaigns in that category

--SELECT category, COUNT(category) AS successful_campaigns, AVG(usd_pledged - goal) AS avg_pledge_difference
--FROM ksprojects
--WHERE state = 'successful'
--GROUP BY category;

----7) For each main category, how many projects had zero backers for that category 
----   and the largest goal amount for that category (also for projects with zero backers)

----** The wording in this one confused me. The below is my best interpretation:

--SELECT main_category, COUNT(backers) AS count_backers, MAX(goal) AS max_goal
--FROM ksprojects
--WHERE backers = 0
--GROUP BY main_category
--ORDER BY max_goal DESC;

----8) For each category, find the average USD per backer, 
----   and return only those results for which the average USD per backer is < $50,
----   sorted high to low

--SELECT category, AVG(usd_pledged/ NULLIF (backers,0)) AS avg_USD_per_backer
--FROM ksprojects
--GROUP BY category
--HAVING AVG(usd_pledged/ NULLIF(backers, 0)) < 50
--ORDER BY avg_USD_per_backer DESC;

----9) For each main_category, how many successful projects had between 5 and 10 backers

--SELECT main_category, COUNT(backers) AS num_backers
--FROM ksprojects
--WHERE state = 'successful'
--GROUP BY main_category, backers
--HAVING backers BETWEEN 5 AND 10;

----10)  Total the amount ‘pledged’ for each type of currency,
----     grouped by its respective currency. Sort by ‘pledged’ from high to low

--SELECT currency, SUM(pledged) AS sum_pledged
--FROM ksprojects
--GROUP BY currency
--ORDER BY sum_pledged DESC;

----11) Excluding Games and Technology records in the main_category field, 
----    return the total of all backers for successful projects by main_category, 
----    where the total was more than 100,000. Sort by main_category from A to Z

--SELECT DISTINCT main_category
--FROM ksprojects;

SELECT main_category, SUM(backers) AS sum_backers
FROM ksprojects
WHERE state = 'successful' AND main_category != 'Games' AND main_category != 'Technology'
GROUP BY main_category
HAVING SUM(backers) > 100000
ORDER BY main_category;