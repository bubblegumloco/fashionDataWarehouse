
# Fashion Data Warehouse 
This project is focused on building a fashion oriented data warehouse to analyze sales trends, inventory levels, and revenue performance. 

A mediallion architeture featuring bronze, silver, and gold layers were implemented to streamline data processing. The data was cleaned, transformed, and normalized to third normal form (3NF) to ensure data consistency and support future scalability. 

Entity relationship diagrams (ERDs) were created for the silver and gold layers and a star schema was used to model product sales and return data. 

This dataset was sourced from Kaggle and MySQL was used for the developement. This project involves extensive use of SQL including both DDL and DML statments. 

This project is ongoing as I continue to build my skills in CTEs, window functions, and recursive queries, which will be added in the future. 

## Data Source

The fashion dataset used in this project is sourced from [Retail Fashion Boutique Data Sales Analytics 2025](https://www.kaggle.com/datasets/pratyushpuri/retail-fashion-boutique-data-sales-analytics-2025). It contains 2,176 records with product details, sales, returns and inventory data. 

## Features

- Implements a medallion architecture with bronze, silver, and gold data layers  
- Cleans, transforms, and normalizes data to third normal form (3NF)  
- Uses entity-relationship diagrams (ERDs) and a star schema for modeling sales and returns  
- Automates stock status updates via SQL triggers  
- Supports analysis of sales trends, inventory levels, and revenue  
- (Planned) Integration of advanced SQL techniques like CTEs, window functions, and recursive queries

## Technology Stack

- **Database:** MySQL  
- **SQL:** DDL and DML statements, triggers  
- **Data Source:** Kaggle fashion dataset  
- **Tools:** VSCode, MySQL Workbench, Git, draw.io (for ERDs)
