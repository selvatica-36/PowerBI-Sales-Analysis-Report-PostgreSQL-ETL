/* Q4. 4. Create a view where the rows are the store types and the columns 
are the total sales, percentage of total sales and the count of orders 
The table of interest is view_1 */
SELECT
    store_type,
    total_sales,
    count_of_orders,
    (total_sales / (SELECT SUM(total_sales) FROM view_1)) * 100 AS sales_percentage
FROM
    view_1;