# GlobalMart Sales Analysis
## Data Centralisation (ETL), Power BI Report, Visualisations & SQL queries

### Stack
![Power bi](https://img.shields.io/badge/power_BI-FF9900?style=for-the-badge&logo=powerbi&logoColor=white) ![PostgreSQL](https://img.shields.io/badge/postgresql-3776AB?style=for-the-badge&logo=postgresql&logoColor=white) ![Git](https://img.shields.io/badge/Git-B1361E?style=for-the-badge&logo=git&logoColor=white) ![VSCode](https://img.shields.io/badge/VSCode-2962FF?style=for-the-badge&logo=visual%20studio&logoColor=white) ![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white) 

## Executive Summary:

[Link to live dashboard in Power BI Service](https://app.powerbi.com/view?r=eyJrIjoiOGJjNjA5NDQtMjE2YS00MzhmLTk3MmEtNjg3MjQ5Yzc5MGY3IiwidCI6IjI1Y2UwMjYxLWJiZDYtNDljZC1hMWUyLTU0MjYwODg2ZDE1OSJ9)

Using Power BI and Power Query, I pulled data from 6 different sources (including Azure Cloud) and created a relational database model and an Microsoft Power BI report to monitor sales performance across the organisation. The 4-page report is interactive and filterable, and uses historical data from 2010-2023 sales to track relevant KPIs and forecast their performance in the near future. 

I also created custom SQL queries to access the centralised Azure database from outside the Power BI environment. Using Python and OOP principles, I built a DatabaseConnector class to automate custom SQL queries when needed.

*NOTE: the data presented here is from a fictitious company and has been fabricated. It is **NOT sensitive** data from real customers.*

## Business Problem:

*GlobalMart* is a multinational retail company with multiple stores across the United Kingdomm, Germany and the US. They need someone to build an end-to-end business intelligence solution from the ground up, using raw data containing information about sales, customers, products and store locations. Up until now they have been tracking sales manually, and their raw data is spread out in different platforms (Azure SQL database, Blob Storage) and formats (.csv files). 

My goals are to:
1. Design, build and deploy a Power BI interactive report to share across the organisation.
2. Create and automate SQL queries so clients can query the centralised database from outside the Power BI environment.

#### Power BI Report Preview
This interactive and comprehensive Power BI report contains four pages, including an Executive Summary, a Customer Detail Page, a Product Detail Page and a Stores Map.

![alt text](/images-readme/project-preview.png)

## The Solution:

### Methodology

1. **Data cleaning and centralisation** in Power BI. Shown below is the **ETL pipeline**: using Power Query I loaded data from various sources, cleaned and transformed it, and loaded it to Power BI for data modelling and analysis.

![alt text](/images-readme/ETL_final.png)

STAR-Schema data model:
![alt text](/images-readme/data_model.png)

2. Build **Power BI report** containing 4 pages including an executive summary. The report is interactive and allows easy navigation and filtering.
4. Create SQL queries to answer client questions by pulling data from Azure database without the need for Power BI Service. Can automate this process by creating a custom python class to connect to database (DatabaseConnector Class).

```
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
```

### Skills

`Power BI`: DAX, ETL, calculated columns, functions and measures, data visualisation, data modeling

`SQL`: CTEs, joins, window functions (e.g. DENSE_RANK(), partitions), aggregate functions

`Python`: Pandas, OOP, psycopg2


## Set up instructions and project guides

For the full detailed step-by-step guide to the project, including installation instructions, ETL pipeline and visuals, please check the [GitHub Wiki](https://github.com/selvatica-36/PowerBI-ecommerce-report/wiki).

## License information

This is an open source public repository. 

**IMPORTANT NOTE ON DATA SOURCE AND PRIVACY**: The data shown here is from a **fictitious** company and has been fabricated. The full dataset was obtained from Aicore and it is not from a real company or real customers. AiCore provided the necessary credentials to connect to Azure SQL database and Blob Storage (these credentials are not publicly available).




