# E-Commerce Report: Evaluating Sales Performance in a Multinational Retail Company

[![Open in Visual Studio Code](https://img.shields.io/badge/Open%20in-Visual_Studio_Code-5C2D91?style=flat&logo=visual%20studio&logoColor=white)](https://open.vscode.dev/selvatica-36/Exploratory-data-analysis---Online-shopping-in-retail) ![GitHub commit activity](https://img.shields.io/github/commit-activity/y/selvatica-36/Exploratory-data-analysis---Online-shopping-in-retail)  ![GitHub last commit](https://img.shields.io/github/last-commit/selvatica-36/Exploratory-data-analysis---Online-shopping-in-retail)  ![issues](https://img.shields.io/github/issues/selvatica-36/Exploratory-data-analysis---Online-shopping-in-retail.svg) 

## Stack
![Power bi](https://img.shields.io/badge/power_BI-FF9900?style=for-the-badge&logo=powerbi&logoColor=white) ![PostgreSQL](https://img.shields.io/badge/postgresql-3776AB?style=for-the-badge&logo=postgresql&logoColor=white) ![Git](https://img.shields.io/badge/Git-B1361E?style=for-the-badge&logo=git&logoColor=white) ![VSCode](https://img.shields.io/badge/VSCode-2962FF?style=for-the-badge&logo=visual%20studio&logoColor=white) ![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white) 


### Summary
**Welcome!** Join me on a learning journey in **Power BI** and **SQL**, to create an industry-standard, interactive and comprehensive report.  We will be working on an industry online retail dataset, and extracting valuable insights to inform business decisions.
 
In the first part of the project, we will focus on data cleaning, creation of a STAR-based data model and subsequent development of the Power BI report. However, not all clients will have access to Power tools like Power BI desktop or Service. We want to ensure that data insights can still be extracted and shared with a broader audience. For this reason, the second objective focuses on creating SQL queries to extract and disseminate key data in a different way. These queries will answer common questions that clients might have.
 
This documentation will also include a detailed guide into Power BI data modelling and reporting. Let's dive in!

### Project Preview
This interactive and comprehensive Power BI report contains four pages, including an Executive Summary, a Customer Detail Page, a Product Detail Page and a Stores Map.


 
## Table of Contents
1. [Setting Up](#1-setting-up)
2. [In this Repository](#2-in-this-repository)
3. [Tables in our Dataset](#3-tables-in-our-dataset)
4. [Importing Data into Power BI](#4-importing-data-into-power-bi)
5. [Data Cleaning: Transforming Data in Power Query Editor](#5-data-cleaning-transforming-data-in-power-query-editor)
6. [Creating the Data Model](#6-creating-the-data-model)
7. [Power BI Report](#7-power-bi-report)
8. [SQL Metrics for Users Outside the Company](#8-sql-metrics-for-users-outside-the-company)

## 1. Setting Up
 
This project requires downloading Power BI desktop: https://www.microsoft.com/en-gb/download/details.aspx?id=58494

As it is only available in Windows machines, users of other operating systems will want to download the program in a virtual machine, such as Azure's Windows VM.

Later in the project, we will be connecting remotely to a database stored in Azure's cloud platform. The user may want to download VSCode and the SQLTools extension for this purpose. 

*Optional*: The user may want to install the psycopg2 library to automate sql queries with python (```pip install psycopg2```).
 
## 2. In this Repository
These are the files you will find in this repository:
- Main Power BI Report: `power-BI-online-retail-report.pbix`
- **SQL-queries** folder, containing:
    - SQL file to check table and column names: `check_table_and_col_names.sql`
    - Python script to automate extraction of column names into csv files for all tables in the dataset, using psycopg2 library: `extract_col_names.py`
    - Python utilities to connect to database and extract information, folowing OOP principles: `database_utils.py`
    - **database-info** folder, containing all csv files extracted. Most files are named as {table name}_columns.csv: they list all column names in each dataset table. Also contains a `table-list.csv` file, containing a list of all tables in the database.
    - **client-queries** folder, containing the sql queries (.sql files) and answers (.csv files) to some key stakeholder questions.
- This `README.md` file.
- `.gitignore` file

## 3. Tables in our Dataset
 
- The **Orders** table is the main fact table. It contains information about each order, including the order and shipping dates, the customer, store and product IDs for associating with dimension tables, and the amount of each product ordered. Each order in this table consists of an order of a single product type, so there is only one product code per order.
 
- The **Products** table contains information about each product sold by the company, including the product code, name, category, cost price, sale price, and weight.
 
- The **Stores** table contains information about each store, including the store code, store type, country, region, and address.
 
- The **Customers** table contains names and personal details of all customers. 
 
## 4. Importing Data into Power BI
 
The first phase focuses on data loading and preparation. Each table was uploaded from a different source. The tables downloaded from Azure required specific credentials provided by AiCore (unavailable in this repository). 

To import data into Power BI, go to `Get Data` menu and find the appropriate option. 

| **Table** | **Type**  | **Imported from**            |
|-----------|-----------|------------------------------|
| Orders    | Facts     | Azure SQL Database           |
| Customers | Dimension | Combining 3 local .csv files |
| Products  | Dimension | Local .csv file              |
| Stores    | Dimension | Azure Blob Storage           |
 
 ![alt text](/readme-images/get_azure_data_final.png)
 ![alt text](/readme-images/get_folder_data.png)
 
## 5. Data Cleaning: Transforming Data in Power Query Editor
After importing all tables to Power BI, I performed some transformations in the Power Query Editor, to clean the data, fix column naming, data types and transform some columns into a more usable format. 

Throughout this process, it is important to make sure that all tables have consistent and comprehensive naming, and that their format matched the convention: for example, column names should be written as "Full Name" instead of "full_name" or "full-name". 

![alt text](/readme-images/power_query_home_pane.PNG)


### Orders table: Transformations

| **Action** | **Column/Condition**  | **Reason**            |
|-----------|-----------|------------------------------|
| Delete column   | Card number     | Ensure data privacy           |
| Delete rows | If value is null | Ensure data integrity |
| Split datetime column  | Order date | Split into a date column and a time column             |
| Split datetime column   | Shipping date | Split into a date column and a time column           |



![alt text](/readme-images/power_query_remove_rows_with_nulls.png)
- To split datetime columns, go to `Split Column` > `by delimiter`, and chose a blank space as the delimiter. Alternatively, duplicate the column, and choose the format as 'date' or 'time' in the data type option.
![alt text](/readme-images/power_query_split_col_by_delimiter.png)
![alt text](/readme-images/ordeR_ship_date.PNG)

![alt text](/readme-images/power_query_change_dtype.png)


### Products table: Transformations


| **Action**        | **Column/Condition**         | **Reason** | **Method** |
|-------------------|------------------------------|------------|------------|
| Remove duplicates | Product code                              | Ensure each product code is unique           | n/a            |
| Split column      | weight (e.g. values: 10g)                             | Into weight values column and units column           | Column from Examples            |
| Fix datatype      | weight values column                             | To decimal           | n/a            |
| Calculated column | New column name: Weight Kilograms                            | Calculated from *Weight Values* and *Weight Units* columns, to transform all values to kg           | DAX (see below)            |
| Delete columns    | weight values / weight units | No longer needed           | Delete           |

![alt text](/readme-images/power_query_col_from_examples.PNG)

*This was done outside Power Query Editor, using DAX in `Data View` > `New Calculated Column`. The DAX formula used for this transformation is: 
```
Weight Kilograms = IF([Weight Units]="kg", [Clean Weight Values], [Clean Weight Values]/1000)
```
Values in the original Weight column were either in kg, g or mL. Those in mL were approximated to g using the density of water (1 g = 1 mL). 
![alt text](/readme-images/weight_column.PNG)

### Customers table: Transformations
The main transformation performed on this table was combining the columns `First Name` and `Last name` into a new column called `Full name`. This can be done by selecting both columns of interest and going to `Add Column` > `Merge Columns`.
![alt text](/readme-images/power_query_merge_columns.PNG)

## 6. Creating the Data Model
### Unlocking time Intellingence: Dates table
To create a data model that takes advantage of all Power BI time intellingence functions, we need to first create a continuos `Dates` table, spanning the full time period of our data. To do this, I created a date table running from the start of the year containing the earliest date in the `Orders['Order Date']` column to the end of the year containing the latest date in the `Orders['Shipping Date']` column. These table contains the following columns, added using DAX formulas:
- Day of Week
- Month Number (i.e. Jan = 1, Dec = 12 etc.)
- Month Name
- Quarter
- Year
- Start of Year
- Start of Quarter
- Start of Month
- Start of Week

Finally, we need to create a **data hierarchy** inside the dates table. This will allow the user to drill down into our data and perform granular analysis within the report. The hierarchy should be: `Start of Year`>`Start of Quarter`>`Start of Month`>`Start of Week`>`Date`.

![alt text](/readme-images/create_hierarchy_right_click.png)
![alt text](/readme-images/date_table.PNG)
![alt text](/readme-images/Dates%20table.PNG)

### Establishing table-table relationships: STAR Schema Data Model
In `Model View`, we can establish all active an inactive relationships between our tables, that will allow Power BI to perform calculations across all tables. The relationshps in our report are:
- `Orders[Product Code]` to `Products[Product Code]`
- `Orders[Store Code]` to `Stores[Store Code]`
- `Orders[User ID]` to `Customers[User UUID]`
- `Orders[Order Date]` to `Dates[Date]` (active)
- `Orders[Shipping Date]` to `Date[Date]` (inactive)

They are all one-to-many relationships with a single filter direction:  

![alt text](/readme-images/data_model.png)

### Geography Hierarchy
To allow our report to filter data by region, country and province/state, we created a geography hierarchy with the following levels:
`World Region` > `Country` > `Country Region`.
To do this, I had to first set up the following columns:
- New calculated column `Country` in the **Stores** table that creates a full country name for each row, based on the Stores[Country Code] column:
- New calculated column `Full region` in the **Stores** table, containing the values on the `Stores[Country Region]`, and `Store[Country]` columns, separated by a comma and a space. 

### Measures Table
Before adding visualisations, we need to create a `Measures Table ` in the data view. This should contain one column and one row, and we should then hide this column. We can now proceed to add new measures, using DAX. These measures will be used by Power BI to set up visualisations by performing the right calculations of the data. Examples of these include `Total Profit`, `Profit YTD`, `Total Revenue`, `Total Orders`, and many more. Please refer to the .pbix file in the repository for more informations, including DAX formulas.

![alt text](/readme-images/measures_table.PNG)

## 7. Power BI Report 
### Planning and Setting Up the Report
The first step is to create all report pages. Go to `Report View` and add four pages, as follows:
- Executive Summary
- Customer Detail
- Product Detail
- Stores Map

### Page 1: Executive Summary Page

 ![alt text](/readme-images/executive_final.png)
 
 
### Page 2: Customer Detail Page
 
 ![alt text](/readme-images/customer_final.png)
 
### Page 3: Product Detail Page
 
 ![alt text](/readme-images/product_final.png)

Upon clicking on the top left Filter button, a slicer opens, letting up choose product category and country:

 ![alt text](/readme-images/product_slicer_1.png)
 ![alt text](/readme-images/product_slicer_2.png)
 ![alt text](/readme-images/product_slicer_3.png)
 ![alt text](/readme-images/slice_bar_settings.PNG)

  
### Page 4: Stores Map Page
 
 ![alt text](/readme-images/stores_map_final.png)
 ![alt text](/readme-images/capt_map_tooltip.png)
 ![alt text](/readme-images/map_settings.PNG)
 
***Creating a Stores Drillthrough Page***

To make it easy for the region managers to check on the progress of a given store, we need to create a drillthrough page that summarises each store's performance. This page should open once the user click on a specific store on the map. 

This drilltrhough page should be created as a new page in the report, and designed as drilltrough page. 
 
![alt text](/readme-images/drilltrhough_final.png)
![alt text](/readme-images/drilltrhough_settings.PNG)
![alt text](/readme-images/map_drilltrhough.png)
 
***Creating a Stores Tooltip Page***
 
 To allow users to be able to see each store's year-to-date profit performance against the profit target just by hovering the mouse over a store on the map.

 ![alt text](/readme-images/tooltip_final.png)

 
### Fixing Cross-filtering and Navigation

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

## 8. SQL Metrics for Users Outside the Company
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






