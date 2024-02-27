-- Extract table list
SELECT tablename
FROM pg_tables 
WHERE schemaname = 'public';

-- Extract column list and data types for Orders table
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'dim_date';

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'orders';
-- the query above is automated in script 'extract_column_names.py' for all tables

---Question 1: How many staff are there in all of the UK stores?
SELECT country, SUM(staff_numbers) AS total_staff_numbers
FROM dim_store
WHERE country = 'UK'
GROUP BY country;

-- Question 2: Which month in 2022 has had the highest revenue?
SELECT 
    SUM(o.product_quantity * dp.sale_price) AS "Total Revenue", 
    dd.month_name AS "Month"
FROM orders o
INNER JOIN dim_product dp ON dp.product_code = o.product_code
INNER JOIN dim_date dd ON dd.date = o.order_date
WHERE dd.year = '2022'
GROUP BY dd.month_name
ORDER BY "Total Revenue" DESC
LIMIT 1;

-- Question 3: Which German store type had the highest revenue for 2022? 
SELECT 
    SUM(o.product_quantity * dp.sale_price) AS "Total Revenue", 
    ds.store_type AS "Store Type"
FROM orders o
INNER JOIN dim_product dp ON dp.product_code = o.product_code
INNER JOIN dim_store ds ON ds.store_code = o.store_code
INNER JOIN dim_date dd ON dd.date = o.order_date
WHERE dd.year = '2022' AND ds.country = 'Germany'
GROUP BY "Store Type"
ORDER BY "Total Revenue" DESC
LIMIT 1;

-- Question 4: Create a view where the rows are the store types and the columns are 
-- the total sales, percentage of total sales and the count of orders.
CREATE VIEW "Summary Store Data" AS
SELECT 
    "Store Type",
    "Revenue",
    "Revenue" / SUM("Revenue") OVER () AS "Percentage of Total Revenue",
    "Count of Orders"
FROM(
    SELECT 
        ds.store_type AS "Store Type",
        SUM(o.product_quantity * dp.sale_price) AS "Revenue", 
        COUNT(*) AS "Count of Orders"
    FROM orders o
    INNER JOIN dim_product dp ON dp.product_code = o.product_code
    INNER JOIN dim_store ds ON ds.store_code = o.store_code
    INNER JOIN dim_date dd ON dd.date = o.order_date
    GROUP BY "Store Type"
) AS info;


-- Question 5: Which product category generated the most profit for 
-- the "Wiltshire, UK" region in 2021?
SELECT 
    SUM(o.product_quantity * (dp.sale_price - dp.cost_price)) AS "Profit", 
    dp.category AS "Product Category"
FROM orders o
INNER JOIN dim_product dp ON dp.product_code = o.product_code
INNER JOIN dim_store ds ON ds.store_code = o.store_code
INNER JOIN dim_date dd ON dd.date = o.order_date
WHERE dd.year = '2021' AND ds.full_region = 'Wiltshire, UK'
GROUP BY "Product Category"
ORDER BY "Profit" DESC
LIMIT 1;
