/* Q5. Which product category generated the most profit for the 
"Wiltshire, UK" region in 2021?
The table of interest is forquerying2*/
SELECT
    full_region,
    category,
    SUM(product_quantity * (sale_price - cost_price)) AS profit
FROM
    forquerying2
WHERE
    EXTRACT(YEAR FROM CAST(dates AS TIMESTAMP)) = 2021 AND full_region = 'Wiltshire, UK'
GROUP BY
    full_region, category
ORDER BY
    profit DESC
LIMIT 1;