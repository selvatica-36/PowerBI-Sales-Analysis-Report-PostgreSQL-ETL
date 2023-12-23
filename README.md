# Online Shopping Report: Evaluating Sales Performance in a Multinational Retail Company
## Stack: Power BI and PostgreSQL

### Summary
**Welcome!** Join me on a learning journey in **Power BI** and **SQL**, to create an industry-standard, interactive and comprehensive report.  We will be working on a realistic online retail dataset, and extracting valuable insights to inform business decisions.
 
In the first part of the project, we will focus on data cleaning, creation of a STAR-based data model and subsequent development of the Power BI report. However, not all clients will have access to Power tools like Power BI desktop or Service. We want to ensure that data insights can still be extracted and shared with a broader audience. For this reason, the second objective focuses on creating SQL queries to extract and disseminate key data in a different way. These queries will answer common questions that clients might have.
 
This documentation will also include a detailed guide into Power BI data modelling and reporting. Let's dive in!
 
## Table of Contents
1. [Setting Up](#1-setting-up)
2. [Tables in our Dataset](#2-tables-in-our-dataset)
3. [Importing Data into Power BI](#3-importing-data-into-power-bi)
4. [Transforming Data in Power Query Editor](#4-transforming-data-in-power-query-editor)
5. [Creating the Data Model](#5-creating-the-data-model)
6. [Power BI Report](#6-power-BI-report)
[Planning the Report](#6.1-planning-the-report)



## 1. Setting Up
 
This project requires downloading Power BI desktop: https://www.microsoft.com/en-gb/download/details.aspx?id=58494

As it is only available in Windows machines, users of other operating systems will want to download the program in a virtual machine, such as Azure's Windows VM.

Later in the project, we will be connecting remotely to a database stored in Azure's cloud platform. The user may want to download VSCode and the SQLTools extension for this purpose. 
 
## 2. Tables in our Dataset
 
- The **Orders** table is the main fact table. It contains information about each order, including the order and shipping dates, the customer, store and product IDs for associating with dimension tables, and the amount of each product ordered. Each order in this table consists of an order of a single product type, so there is only one product code per order.
 
- The **Products** table contains information about each product sold by the company, including the product code, name, category, cost price, sale price, and weight.
 
- The **Stores** table contains information about each store, including the store code, store type, country, region, and address.
 
- The **Customers** table contains names and personal details of all customers. 
 
## 3. Importing Data into Power BI
 
The first phase focuses on data loading and preparation. Each table was uploaded from a different source. The tables downloaded from Azure required specific credentials provided by AiCore (unavailable in this repository). 

To import data into Power BI, go to **Get Data** menu and find the appropriate option. 

| **Table** | **Type**  | **Imported from**            |
|-----------|-----------|------------------------------|
| Orders    | Facts     | Azure SQL Database           |
| Customers | Dimension | Combining 3 local .csv files |
| Products  | Dimension | Local .csv file              |
| Stores    | Dimension | Azure Blob Storage           |
 
 
## 4. Data Cleaning: Transforming Data in Power Query Editor
After importing all tables to Power BI, I performed some transformations in the Power Query Editor, to clean the data, fix column naming, data types and transform some columns into a more usable format.

### Orders table: Transformations

| **Action** | **Column/Condition**  | **Reason**            |
|-----------|-----------|------------------------------|
| Delete column   | Card number     | Ensure data privacy           |
| Delete rows | If value is null | Ensure data integrity |
| Split datetime column  | Order date | Split into a date column and a time column             |
| Split datetime column   | Shipping date | Split into a date column and a time column           |

### Products table: Transformations


| **Action**        | **Column/Condition**         | **Reason** | **Method** |
|-------------------|------------------------------|------------|------------|
| Remove duplicates | Product code                              | Ensure each product code is unique           |            |
| Split column      | weight (e.g. values: 10g)                             | Into weight values column and units column           |            |
| Fix datatype      | weight values column                             | To decimal           |            |
| Calculated column | new column name: weight (kg)                             | Calculated from weight values and weight units column, to transform all values to kg           |            |
| Delete columns    | weight values / weight units | No longer needed           | Delete           |



*This is done outside Power Query Editor, using DAX in Data View > New Calculated Column.


## 5. Creating the Data Model
hhhh

![alt text](/readme-images/data_model.png)


## 6. Power BI Report
 
 
4.	Planning and Setting Up the Report
 
 
 
5.	Page 1: Executive Summary Page
 
 
 ![alt text](/readme-images/executive.png)
 
 
1.	Page 2: Customer Detail Page
 
 
 ![alt text](/readme-images/customer.png)
 
 
 
1.	Page 3: Product Detail Page
 
 
 
 ![alt text](/readme-images/product.png)
 
 
 
 
 
 
1.	Page 4: Stores Map Page
 
 
 ![alt text](/readme-images/stores_map.png)
 
 
a.	Creating a Drillthrough Page
 
 ![alt text](/readme-images/drillthrough.png)
 
 
a.	Creating a tooltip page
 
 
 
 ![alt text](/readme-images/tooltip.png)
 
 
 
 
1.	Fixing Cross-filtering and Navigation
 
1.	SQL Metrics for Users Outside the Company

