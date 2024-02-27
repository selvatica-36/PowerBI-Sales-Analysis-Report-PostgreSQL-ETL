# E-Commerce Report: Evaluating Sales Performance in a Multinational Retail Company

[![Open in Visual Studio Code](https://img.shields.io/badge/Open%20in-Visual_Studio_Code-5C2D91?style=flat&logo=visual%20studio&logoColor=white)](https://open.vscode.dev/selvatica-36/Exploratory-data-analysis---Online-shopping-in-retail) ![GitHub commit activity](https://img.shields.io/github/commit-activity/y/selvatica-36/Exploratory-data-analysis---Online-shopping-in-retail)  ![GitHub last commit](https://img.shields.io/github/last-commit/selvatica-36/Exploratory-data-analysis---Online-shopping-in-retail)  ![issues](https://img.shields.io/github/issues/selvatica-36/Exploratory-data-analysis---Online-shopping-in-retail.svg) 

## Stack
![Power bi](https://img.shields.io/badge/power_BI-FF9900?style=for-the-badge&logo=powerbi&logoColor=white) ![PostgreSQL](https://img.shields.io/badge/postgresql-3776AB?style=for-the-badge&logo=postgresql&logoColor=white) ![Git](https://img.shields.io/badge/Git-B1361E?style=for-the-badge&logo=git&logoColor=white) ![VSCode](https://img.shields.io/badge/VSCode-2962FF?style=for-the-badge&logo=visual%20studio&logoColor=white) ![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white) 


### Summary
**Welcome!** Join me on a learning journey in **Power BI** and **PostgreSQL**, to create an industry-standard, interactive and comprehensive report.  We will be working on an online retail dataset (120,000 records) from an anonymised multinational retail company. We will also and extracting valuable insights to inform business decisions.
 
📌  **The first part of the project focuses on data extraction, cleaning and modelling.** We will perform **ETL** on the data: 1) extract data (E) from four different cloud and local sources; 2) transform (T) the data in Power Query, and 3) load the data back to Power BI. Finally, we will create our STAR-based data model, including a dates table and relevant hierarchies.

📊 **The second part consists on the development of an interactive multi-page Power BI report.** First, we will a table of key measures in **DAX**. We will then build interactive-multi-page report containing 35 visualisations, from KPIs to predictive modelling.

💻 **The third objective focuses on creating custom SQL queries to generate powerful insights** outside the Power BI environment. Why do we want to do this? Not all clients will have access to Power tools like Power BI desktop or Service. We want to ensure that data insights can still be extracted and shared with a broader audience. 
 
This documentation will also include a detailed guide into Power BI data modelling and reporting. Let's dive in!

### Project Preview
This interactive and comprehensive Power BI report contains four pages, including an Executive Summary, a Customer Detail Page, a Product Detail Page and a Stores Map.


 
## Table of Contents
1. [Setting Up](#1-setting-up)
2. [In this Repository](#2-in-this-repository)
3. [Tables in our Dataset](#3-tables-in-our-dataset)
4. [Extract-Transform-Load (ETL) in Power BI](#4-extract-transform-load-etl-in-power-bi)

    4.1. [Importing Data into Power BI](#41-importing-data-into-power-bi)

    4.2. [Data Cleaning: Transforming Data in Power Query Editor](#42-data-cleaning-transforming-data-in-power-query-editor)
5. [Creating the Data Model](#5-creating-the-data-model)
6. [Power BI Report](#6-power-bi-report)

    6.1. [Executive Summary Page](#61-executive-summary-page)

    6.2. [Customer Detail Page](#62-customer-detail-page)

    6.3. [Product Detail Page](#63-product-detail-page)

    6.4. [Stores Map Page](#64-stores-map-page)

    6.5. [Fixing Crossfiltering and Navigation](#65-fixing-cross-filtering-and-navigation)
7. [SQL Metrics for Users Outside the Company](#7-sql-metrics-for-users-outside-the-company)

## 1. Setting Up
 
This project requires downloading Power BI desktop: https://www.microsoft.com/en-gb/download/details.aspx?id=58494

As it is only available in Windows machines, users of other operating systems will want to download the program in a virtual machine, such as Azure's Windows VM.

Later in the project, we will be connecting remotely to a database stored in Azure's cloud platform. The user may want to download VSCode and the SQLTools extension for this purpose. 

*Optional*: The user may want to install the psycopg2 library to automate SQL queries with python:
 ```
 pip install psycopg2
 ```
 
## 2. In this Repository
These are the files you will find in this repository:
- Main Power BI Report: `power_BI_report.pbix`
- **SQL-queries** folder, containing:
    - SQL file to check table and column names: `check_table_and_col_names.sql`
    - Python script to automate extraction of column names into csv files for all tables in the dataset, using psycopg2 library: `extract_col_names.py`
    - Python utilities to connect to database and extract information, folowing OOP principles: `database_utils.py`
    - **database-info** folder, containing all csv files extracted. Most files are named as {table name}_columns.csv: they list all column names in each dataset table. Also contains a `table-list.csv` file, containing a list of all tables in the database.
    - **client-queries** folder, containing the sql queries (.sql files) and answers (.csv files) to some key stakeholder questions.
- This `README.md` file.
- `.gitignore` file

## 3. Tables in our Dataset
 
- The `Orders` table is the main fact table. It contains information about each order, including the order and shipping dates, the customer, store and product IDs for associating with dimension tables, and the amount of each product ordered. Each order in this table consists of an order of a single product type, so there is only one product code per order.
 
- The `Products` table contains information about each product sold by the company, including the product code, name, category, cost price, sale price, and weight.
 
- The `Stores` table contains information about each store, including the store code, store type, country, region, and address.
 
- The `Customers` table contains names and personal details of all customers. 
 
## 4. Extract-Transform-Load (ETL) in Power BI
The first step is to consolidate all the data into a single Power BI (.pbix) file. Currently, the data needs ot be extracted from four different sources (*see 4.1*), cleaned (*see 4.2*) and loaded. 

The diagram below gives a quick overview of the ETL pipeline, as well as the types of transformations performed on the data.

![alt text](/images-readme/ETL_final.png)

NOTE: *the credentials needed to access and/or download the data are not available in this repository.*

### 4.1. Importing Data into Power BI
 
The first phase focuses on data loading and preparation. Each table was uploaded from a different source. The tables downloaded from Azure required specific credentials provided by AiCore (unavailable in this repository). 

To import data into Power BI, go to `Get Data` menu and find the appropriate option. 

| **Table** | **Type**  | **Imported from**            |
|-----------|-----------|------------------------------|
| Orders    | Facts     | Azure SQL Database           |
| Customers | Dimension | Combining 3 .csv files, stored in a local folder |
| Products  | Dimension | Local .csv file              |
| Stores    | Dimension | Azure Blob Storage           |
 
The figure below shows how to import data from **Azure SQL Databse** and **Azure Blob Storage**.
 ![alt text](/images-readme/get_azure_data_final.png)

The figure below shows how to import data from a local **.csv** file or multiple files saved in a local **folder**.
![alt text](/images-readme/get_folder_data.png)
 
### 4.2. Data Cleaning: Transforming Data in Power Query Editor
After importing all tables to Power BI, we need to transform the data in the **Power Query Editor**. Common transformations to all tables include:
- Fix column naming. Throughout this process, it is important to make sure that all tables have consistent and comprehensive naming, and that their format matched the convention: for example, column names should be written as "Full Name" instead of "full_name" or "full-name". 
- Ensure data types are correct and accurate. 

The specific transformations performed on each table are specified in the ETL diagram above and in the sections below in more detail. 

### Orders table: Transformations

| **Action** | **Column/Condition**  | **Reason**            |
|-----------|-----------|------------------------------|
| Delete column   | Card number     | Ensure data privacy           |
| Delete rows | If value is null | Ensure data integrity |
| Split datetime column  | Order date | Split into a date column and a time column             |
| Split datetime column   | Shipping date | Split into a date column and a time column           |

- To split datetime columns, go to `Split Column` > `by delimiter`, and chose a blank space as the delimiter. Alternatively, duplicate the column, and choose the format as 'date' or 'time' in the data type option.

![alt text](/images-readme/power_query_split_col_by_delimiter.png)

- To change data type, click on the icon to the left on the column name and select the desired data type.

![alt text](/images-readme/power_query_change_dtype.png)


### Products table: Transformations


| **Action**        | **Column/Condition**         | **Reason** | **Method** |
|-------------------|------------------------------|------------|------------|
| Remove duplicates | Product code                              | Ensure each product code is unique           | See below            |
| Split column      | weight (e.g. values: 10g)                             | Into weight values column and units column           | Column from Examples            |
| Fix datatype      | weight values column                             | To decimal           | n/a            |
| Calculated column | New column name: Weight Kilograms                            | Calculated from *Weight Values* and *Weight Units* columns, to transform all values to kg           | DAX (see below)            |


- To remove duplicates, click on 'Remove Rows' > 'Remove Duplicates' in the Power Query Home pane:

![alt text](/images-readme/power_query_remove_rows_with_nulls.png)

- The `weight` column contains values in either in kg, g or mL. Those in mL will be approximated to g using the density of water (1 g = 1 mL). Before transforming, the data is in the format e.g. 800g, 400mL, 0.1kg. this involves multiple steps:
    - 1. In Power Query, create 'Column from Examples' based on the weight column, containing only the numerical values. 
![alt text](/images-readme/power_query_col_from_examples.png)
    - 2. In Power Query, create 'Column from Examples' based on the weight column, containing only the units as strings e.g. 'g'.
    - 3. Load the data to Power BI (exit Power Query). 
    - 4. Create final weight column, containing only weights in kg (as floats): to do this go to `Data View` > `New Calculated Column`. The DAX formula used for this transformation is: 
        ```
        Weight Kilograms = IF([Weight Units]="kg", [Clean Weight Values], [Clean Weight Values]/1000)
        ``` 
        The desired output should look like the column highlighted in the image below:
![alt text](/images-readme/weight_column.png)

### Customers table: Transformations
The main transformation performed on this table was combining the columns `First Name` and `Last name` into a new column called `Full name`. This can be done in **Power Query** by selecting both columns of interest and going to `Add Column` > `Merge Columns` in the *Transform* pane. 
![alt text](/images-readme/power_query_merge_columns.png)

## 5. Creating the Data Model
### Unlocking time Intellingence: `Dates` table
To create a data model that takes advantage of all Power BI time intellingence functions, we need to first create a continuos `Dates` table, spanning the full time period of our data. To do this, I created a date table running from the start of the year containing the earliest date in the `Orders['Order Date']` column to the end of the year containing the latest date in the `Orders['Shipping Date']` column. These table contains the following columns, added in `Data View` > `New Calculated Column`, using DAX formulas:

|      Calculated Column      |                                  DAX measure                                  |
|:---------------------------:|:-----------------------------------------------------------------------------:|
|            Dates            | `CALENDAR(MIN('Orders'[Order Date]), MAX ('Orders'[Shipping Date]))` |
|         Day of Week         |                         `FORMAT([Date], "dddd" )`                        |
| Month Number (i.e. Jan = 1) |                            `MONTH(Dates[Date])`                            |
|          Month Name         |                            `Dates[Date].[Month]`                            |
|           Quarter           |                           `QUARTER(Dates[Date])`                           |
|             Year            |                              `YEAR(Dates[Date])`                              |
|        Start of Year        |                           `STARTOFYEAR(Dates[Date])`                          |
|       Start of Quarter      |                        `STARTOFQUARTER(Dates[Date])`                       |
|        Start of Month       |                          `STARTOFMONTH(Dates[Date])`                          |
|        Start of Week        |                   `Dates[Date] - WEEKDAY(Dates[Date],2) + 1`                  |

The `Dates` table should look like the one below.
![alt text](/images-readme/date_table.png)

Finally, we need to create a **date hierarchy** inside the dates table. This will allow the user to drill down into our data and perform granular analysis within the report. The hierarchy should be: `Start of Year`>`Start of Quarter`>`Start of Month`>`Start of Week`>`Date`.
To add hierarchy, right clonk on the table of interest > select 'Create hierarchy' from dropdown menu. To add column to the hierarchy, right click on each column > select 'Add to hierarchy'. 

![alt text](/images-readme/create_hierarchy_right_click.png)

The dates hierarchy should look as follows:

![alt text](/images-readme/Dates%20table.png)

### Establishing table-table relationships: STAR Schema Data Model
In `Model View`, we can establish all active an inactive relationships between our tables, that will allow Power BI to perform calculations across all tables. The relationshps in our report are:
- `Orders[Product Code]` to `Products[Product Code]`
- `Orders[Store Code]` to `Stores[Store Code]`
- `Orders[User ID]` to `Customers[User UUID]`
- `Orders[Order Date]` to `Dates[Date]` (active)
- `Orders[Shipping Date]` to `Date[Date]` (inactive)

They are all one-to-many relationships with a single filter direction:  

![alt text](/images-readme/data_model.png)

### Geography Hierarchy
To allow our report to filter data by region, country and province/state, we created a geography hierarchy with the following levels:
`World Region` > `Country` > `Country Region`.
To do this, I had to first set up the following columns:
- New calculated column `Country` in the **Stores** table that creates a full country name for each row, based on the Stores[Country Code] column.

- New calculated column `Full region` in the **Stores** table, containing the values on the `Stores[Country Region]`, and `Store[Country]` columns, separated by a comma and a space. 

### Measures Table
We need to create DAX measures to use in our visualisations. To do this, we need to create a `Measures Table ` in the data view:
 1. Create a new table. This table should initially  contain one column and one row; this column should be hidden. 
 ![alt text](/images-readme/measures_table.png)
2. **Add DAX measures.** These measures will be used by Power BI to set up visualisations by performing the right calculations of the data. Examples of these include `Total Profit`, `Profit YTD`, `Total Revenue`, `Total Orders`, and many more.  We used a **31 measures in total** - some are shown in the table below. Please refer to the .pbix file in the repository for more information, including complete DAX formulas.

| Key Measure Name    | DAX formula                                                                                                                                  |
|---------------------|----------------------------------------------------------------------------------------------------------------------------------------------|
| Total Profit        | `SUMX( Orders , ( RELATED ( Products[Sale Price] ) -   RELATED ( Products[Cost Price] ))* Orders[Product Quantity] )`                        |
| Profit YTD          | `CALCULATE (SUMX(Orders, (RELATED(Products[Sale Price]) - RELATED(Products[Cost Price]))*Orders[Product Quantity]),DATESYTD(Dates[Date]))`   |
| Profit Goal         | `Profit Goal =  VAR PreviousYearProfitYTD = CALCULATE([Profit YTD], SAMEPERIODLASTYEAR('Dates'[Date]))  RETURN  PreviousYearProfitYTD * 1.2` |
| Top Product Revenue | `CALCULATE (VALUES(Products[Description]), TOPN(1, Products, [Total Revenue], DESC))`                                                        |
| Total Revenue       | `SUMX(Orders, Orders[Product Quantity]*RELATED(Products[Sale Price]))`                                                                       |

## 6. Power BI Report 
### Planning and Setting Up the Report
The first step is to create all report pages. Go to `Report View` and add four pages, as follows:
- Executive Summary
- Customer Detail
- Product Detail
- Stores Map

### 6.1. Executive Summary Page

![alt text](/images-readme/executive_final.png)

The executive summary contains:
- **Card visuals** for `Total Revenue`, `Total Orders` and `Total Profit`.
- **Line chart** to show the revenue over time and the predicted revenue in the coming cycles.  
    - **Drill-down**: Set X axis to your Date Hierarchy, with only the `Start of Year`, `Start of Quarter` and `Start of Month` levels displayed.
    - Set Y-axis to `Total Revenue`.
    - **Predictive modelling**: Add a trend line, and a forecast for the next 10 periods with a 95% confidence interval.
- **KPI** charts for quarterlyy revenue, profit and orders:
    - The **Value** field should be `Total Revenue/Profit/Orders`
    - The **Trend Axis** should be `Start of Quarter`
    - The **Target** should be `Target Revenue/Profit/Orders`.
    - In the Format pane, set the Trend Axis to On, expand the associated tab, and set the values as follows: Direction -> High is Good | Bad Colour -> red | Transparency -> 15%.
- **Donut** charts to show the breakdown of revenue both by country and by store type.
    - X-axis: `Total Revenue` measure.
    - Filter with `Store[Country]` column or `Store[Store Type]` column.
- **Clustered bar chart** to show the number of orders by product category.
    - X-axis: `Total Orders` measure.
    - Filter with `Products[Category]` column.

### 6.2. Customer Detail Page
 
 ![alt text](/images-readme/customer_final.png)
 
 The customer detail page contains:
 - Headline **card visuals**:
    - Unique customers card: measure `Total Customers`.
    - Revenue per customer card: measure `Revenue per Customer`.
- **Donut** charts to show the breakdown of total customers by country.
    - X-axis: `Total Customers` measure.
    - Filter with `Users[Country]` column.
 - **Column chart** to show the number of customers by product category.
    - X-axis: `Total Customers` measure.
    - Filter with `Products[Category]` column.
- **Line chart** to show the customer trending over time and the predicted customer numbers in the coming cycles.  
    - **Drill-down**: Set X axis to your Date Hierarchy, with only the `Start of Year`, `Start of Quarter` and `Start of Month` levels displayed.
    - Set Y-axis to `Total Customers`.
    - **Predictive modelling**: Add a trend line, and a forecast for the next 10 periods with a 95% confidence interval.
- **Top 20 Customers table**. Built using measures `Total Revenue` and `Total Orders` filtered by `Customer[Full Name]` column. 
- **Top Customer card visuals**:
    - Top Customer card: `Top Customer Name` measure.
    - Revenue card: `Total Revenue by Top Customer` measure.
    - Order card: `Orders By Top Customer` measure.
- **Date slicer**. Add slicer > style: 'between'. Select `Dates[Year]`.

### 6.3. Product Detail Page
 
 ![alt text](/images-readme/product_final.png)

The customer detail page contains:
 - **Filter state cards**:
    - First define the following measures:
    ```
    Category Selection = IF(ISFILTERED(Products[Category]), SELECTEDVALUE(Products[Category]), "No Selection"),"No Selection")

    Country Selection = IF(ISFILTERED(Stores[Country]), SELECTEDVALUE(Stores[Country]), "No Selection"),"No Selection") 
    ```
    - Add each measure to a filter card visual. These measures will work in tandem with the slicer toolbar we will build below.
- **Gauge visuals**. Should show the current-quarter performance of Orders, Revenue and Profit against a quarterly target (10% quarter-on-quarter growth).
    - As the value, assign the measures `QTD Revenue/Orders/Profit` (QTD = quarter to date), respectively.
    - Set the target measures as the maximum value of the guage.
 - **Area chart** of revenue by product category.
    - X axis should be `Dates[Start of Quarter]`.
    - Y axis values should be `Total Revenue` measure.
    - Legend should be `Products[Category]`.
- **Scatter graph**. *Which product ranges are both top-selling items and also profitable?*
    - Create a new calculated column called `[Profit per Item]` in the `Products` table.
    - Values: `Products[Description]`
    - X-Axis: `Products[Profit per Item]`
    - Y-Axis: `Orders[Total Quantity]`
    - Legend: `Products[Category]`
- **Top Products table**. Built in the same way as the table from the customer Detail page.
- **Top Product card visuals**:
    - Top Customer card: `Top Customer Name` measure.
    - Revenue card: `Total Revenue by Top Customer` measure.
    - Order card: `Orders By Top Customer` measure.

#### Slicer Toolbar: Filtering by Category and Country
We want to create a pop-out toolbar to filter our Poduct Detail page by product category and country. Upon clicking on the top left Filter button, a slicer opens, letting up choose product category and country:

![alt text](/images-readme/product_slicer_3.png)

To create it, we need to follow these steps:
1. Adds filter button to the top of the navigation bar, with the following settings:
 ![alt text](/images-readme/product_slicer_2.png)

2. Draw a new rectangle shape and **add  vertical list slicers**:
    - One set to `Products[Category]`.
    - The second set to `Stores[Country]`.
3. Add a back button to the slicer panel (select 'Back' button type).
4. Open the Bookmarks pane and add two new bookmarks: one with the toolbar group hidden in the Selection pane, and one with it visible. Name them Slicer Bar Closed and Slicer Bar Open. 
    ![alt text](/images-readme/product_slicer_1.png)

    ![alt text](/images-readme/product_slicer_3.png)
Right-click each bookmark in turn, and ensure that Data is unchecked.
    ![alt text](/images-readme/slice_bar_settings.png)

### 6.4. Stores Map Page
Contains a **map visual** with all store locations, as well as a country slicer that allows the user to zoom in to a specific country in the map.
 ![alt text](/images-readme/stores_map_final.png)

To add the map visual, set the following values:
- Location: Geography hierarchy
- Bubble size: `Profit YTD` measure.

![alt text](/images-readme/map_settings.png)

***Creating a Stores Tooltip Page***

To allow users to be able to see each store's year-to-date profit performance against the profit target just by hovering the mouse over a store on the map.
![alt text](/images-readme/capt_map_tooltip.png)

Upon hovering on a specific location, the map shows a gauge visual of `Profit YTD` vs. target. This is achieved by creating a separate page in the report (called *Store ToolTip*) and linking it to map under the **Tooltips** field (see map settings picture in main section). 

![alt text](/images-readme/tooltip_final.png)

 
***Creating a Stores Drillthrough Page***

To make it easy for the region managers to check on the progress of a given store, we need to create a drillthrough page that summarises each store's performance. 
![alt text](/images-readme/drilltrhough_final.png)

This page should open once the user click on a specific store on the map. 
![alt text](/images-readme/map_drilltrhough.png)

This drillthrough page should be created as a new page in the report, called *Stores Drillthrough*. Once created, open the format pane and expand the Page information tab. Set the Page type to Drillthrough and set Drill through when to Used as category. Set the 'Drill through from' field to `[Country Region]`. 

![alt text](/images-readme/drilltrhough_settings.png)


### 6.5. Fixing Cross-filtering and Navigation

***Crossfiltering***

To avoid unnecessary confusion and get the right message across, it is important that only the desired visuals can filter the rest. Power BI lets us control these cross-filtering interactions.

From the Edit Interactions view in the Format tab of the ribbon, we can modify filtering interactions between visuals:

`Executive Summary Page `
- Product Category bar chart and Top 10 Products table should not filter the card visuals or KPIs
- Top 10 Products table should not affect any other visuals 

`Customer Detail Page`
- Top 20 Customers table should not filter any of the other visuals
- Total Customers by Product Donut Chart should not affect the Customers line graph
- Total Customers by Country donut chart should cross-filter Total Customers by Product donut Chart 

`Product Detail Page`
- Orders vs. Profitability scatter graph should not affect any other visuals

***Navigation Bar***

A navigation bar was set up on the left side of each page, to allow navigation between pages of the report. To allow this functionality, we need to `Add Button` and turn `Action` to ON, select `Navigation` and the desired report page for each button. 

## 7. SQL Metrics for Users Outside the Company
It is very common to encounter clients who don't have access to specialised visualisation tools like Power BI. Here, I use SQL queries as an additional tool of my data analysis toolkit. 

### Step 1: Connect to remote SQL database
The database in stored in Azure PostgreSQL database cloud platform. To connect to it, I established a new connection in SQLTools (inside VSCode), by providing the credentials obtained from AiCore. 

### Step 2: Explore the contents of the remote database
First, I queried the database to obtain a list of all table names (/database-info/table-list.csv).

Then, I created another query to extract all column names from a specified table into a csv file (SQL query in: /SQL-queries/check_table_and_col_names.sql). The file can then be extracted into .csv using the SQLTools user interface (button just below query output).

As there were many tables in the dataset, I decided to automate the column list query using python's psycopg2 package. This library allows us to connect to the database using our credentials and perform sql queries on it.

### Step 3: Query the database to answer client's questions
All queries and answers are stored in SQL-queries/client-queries folder, in this repository.
The questions we have answered here are:
 - ***Question 1***: How many staff are there in all of the UK stores? 

 - ***Question 2***: Which month in 2022 has had the highest revenue?

 - ***Question 3***: Which German store type had the highest revenue for 2022? 

 - ***Question 4***: Create a view where the rows are the store types and the columns are the total sales, percentage of total sales and the count of orders. 
 
 - ***Question 5***: Which product category generated the most profit for the "Wiltshire, UK" region in 2021?






