-- Q3. Which German store type had the highest revenue for 2022? 
-- The table of interest is forquerying2
SELECT
    country,
    store_type,
    SUM(product_quantity * sale_price) AS revenue
FROM
    forquerying2
WHERE
    EXTRACT(YEAR FROM CAST(dates AS TIMESTAMP)) = 2022 AND country = 'Germany'
GROUP BY
    country, store_type
ORDER BY
    revenue DESC
LIMIT 1;