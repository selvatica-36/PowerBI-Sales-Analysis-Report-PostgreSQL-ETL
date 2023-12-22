-- Q1. How many staff are there in all of the UK stores? 
-- The table of interest in dim_store
SELECT country, SUM(staff_numbers) AS total_staff_numbers
FROM dim_store
WHERE country = 'UK'
GROUP BY country;