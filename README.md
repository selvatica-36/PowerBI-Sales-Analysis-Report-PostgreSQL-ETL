# GlobalMart Sales Analysis
## Data Centralisation, Power BI Report & SQL queries

### Stack
![Power bi](https://img.shields.io/badge/power_BI-FF9900?style=for-the-badge&logo=powerbi&logoColor=white) ![PostgreSQL](https://img.shields.io/badge/postgresql-3776AB?style=for-the-badge&logo=postgresql&logoColor=white) ![Git](https://img.shields.io/badge/Git-B1361E?style=for-the-badge&logo=git&logoColor=white) ![VSCode](https://img.shields.io/badge/VSCode-2962FF?style=for-the-badge&logo=visual%20studio&logoColor=white) ![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white) 


## Executive Summary:



## Business Problem:


#### Power BI Report Preview
This interactive and comprehensive Power BI report contains four pages, including an Executive Summary, a Customer Detail Page, a Product Detail Page and a Stores Map.

![alt text](/images-readme/project-preview.png)

## The Solution:

### Methodology

1. Data cleaning and centralisation in Power BI. Shown below is the **ETL pipeline**: using Power Query I loaded data from various sources, cleaned and transformed it, and loaded it to Power BI for data modelling and analysis.

![alt text](/images-readme/ETL_final.png)

STAR-Schema data model:
![alt text](/images-readme/data_model.png)

2. Build Power BI report containing 4 pages including an executive summary. The report is interactive and allows easy navigation and filtering.
4. Create SQL queries to answer client questions by pulling data from Azure database without the need for Power BI Service. Can automate this process by creating a custom python class to connect to database (DatabaseConnector Class).



### Skills

`Power BI`: DAX, ETL, calculated columns, functions and measures, data visualization, data modeling

`SQL`: CTEs, joins, window functions (e.g. DENSE_RANK(), partitions), aggregate functions

`Python`: Pandas, OOP, psycopg2


## Set up instructions and project guides

For the full detailed step-by-step guide to the project, including installation instructions, ETL pipeline and visuals, please check the [GitHub Wiki](https://github.com/selvatica-36/PowerBI-ecommerce-report/wiki).

## Currently working on
- Developing a case analysis study to include in this README file. *Come back again soon!*
- Embedding the dashboard into Power BI Service.


## License information

This is an open source public repository. The dataset was obtained from Aicore. AiCore provided the necessary credentials to connect to Azure SQL database and Blob Storage (these credentials are not publicly available).




