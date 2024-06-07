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

---Query 1: How many staff are there in all of the UK stores?
SELECT country, SUM(staff_numbers) AS total_staff_numbers
FROM dim_store
WHERE country = 'UK'
GROUP BY country;

-- Query 2: Which month in 2022 has had the highest revenue?
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

-- Query 3: Which German store type had the highest revenue for 2022? 
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

-- Query 4: Create a view where the rows are the store types and the columns are 
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


-- Query 5: Which product category generated the most profit for 
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


-- Query 6: What are the most frequently ordered products by individual customers?
WITH count_products_cte AS (
    SELECT user_id, product_code, COUNT(product_code) AS product_count
    FROM orders
    GROUP BY user_id, product_code
    ORDER BY user_id ASC),
    
    product_rank_cte AS (
        SELECT user_id, product_code,
               DENSE_RANK() OVER(PARTITION BY user_id ORDER BY product_count DESC) AS rank
        FROM count_products_cte
    )
SELECT c2.product_code, p.description, COUNT(c2.user_id) as most_ordered_count
FROM product_rank_cte c2
INNER JOIN dim_product p ON c2.product_code = p.product_code
WHERE rank = 1
GROUP BY c2.product_code, p.description
ORDER BY most_ordered_count DESC LIMIT 10;

-- The result from Query 6 returns the 10 products that were
-- the most ordered by individual customers. This provides valuable information on which products 
-- have the most loyalty and repeated sales to specific customers.
-- The count column returns the number of customers where each product was their most ordered




