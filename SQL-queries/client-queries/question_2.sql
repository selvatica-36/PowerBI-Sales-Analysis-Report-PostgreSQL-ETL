-- Q2. Which month in 2022 has had the highest revenue?
-- the table of interest is forquerying2
SELECT
    month_name,
    SUM(product_quantity * sale_price) AS revenue
FROM
    forquerying2
WHERE
    EXTRACT(YEAR FROM CAST(dates AS TIMESTAMP)) = 2022
GROUP BY
    month_name
ORDER BY
    revenue DESC
LIMIT 1;