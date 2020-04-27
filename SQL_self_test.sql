-- 1

SELECT *
FROM information_schema.columns
WHERE table_name = 'naep';

-- 2

SELECT *
FROM naep
LIMIT 50;

-- 3

SELECT state, COUNT(avg_math_4_score), ROUND(AVG(avg_math_4_score), 2) average, MIN(avg_math_4_score), MAX(avg_math_4_score)
FROM naep
GROUP BY state
ORDER BY state;

-- 4

SELECT state, COUNT(avg_math_4_score), ROUND(AVG(avg_math_4_score), 2) average, MIN(avg_math_4_score), MAX(avg_math_4_score)
FROM naep
GROUP BY state
HAVING (MAX(avg_math_4_score) - MIN(avg_math_4_score)) > 30
ORDER BY state;

-- 5

SELECT state AS bottom_10_states
FROM naep
WHERE year = 2000
ORDER BY avg_math_4_score
LIMIT 10;

-- 6

SELECT ROUND(AVG(avg_math_4_score), 2)
FROM naep
WHERE year = 2000;

-- 7

SELECT state AS below_average_states_y2000
FROM naep
WHERE year = 2000
GROUP BY state, avg_math_4_score
HAVING avg_math_4_score < (SELECT ROUND(AVG(avg_math_4_score), 2) FROM naep WHERE year = 2000);

-- 8

SELECT state as scores_missing_y2000
FROM naep
WHERE year = 2000
GROUP BY state
HAVING  count(avg_math_4_score) = 0;

-- 9

SELECT n.state, ROUND(AVG(n.avg_math_4_score), 2) AS avg_2000_math_scores, SUM(f.total_expenditure) AS total_2000_expenditure
FROM naep n 
LEFT OUTER JOIN finance f ON n.id = f.id
WHERE n.year = 2000
GROUP BY n.state
HAVING NOT count(avg_math_4_score) = 0
ORDER BY SUM(f.total_expenditure) DESC;