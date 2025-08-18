
1. gold_dim_return_reason


| Column Name      | Data Type     | Description                                    |
| ---------------- | ------------- | ---------------------------------------------- |
| return\_id       | INT           | Surrogate key uniquely identifying each return |
| product\_id      | INT           | Foreign key referencing `silver_product_info`  |
| category         | VARCHAR(100)  | Product category                               |
| brand            | VARCHAR(100)  | Product brand                                  |
| current\_price   | DECIMAL(10,2) | Price of the product at the time of return     |
| return\_reason   | VARCHAR(100)  | Reason for the return                          |
| customer\_rating | DECIMAL(2,1)  | Customer rating for the product                |


2. gold_fact_sales 

| Column Name          | Data Type     | Description                                      |
| -------------------- | ------------- | ------------------------------------------------ |
| purchase\_id         | INT           | Surrogate key uniquely identifying each purchase |
| purchase\_date       | DATE          | Date of the purchase                             |
| product\_id          | INT           | Foreign key referencing `silver_product_info`    |
| category             | VARCHAR(100)  | Product category                                 |
| brand                | VARCHAR(100)  | Product brand                                    |
| stock\_quantity      | INT           | Quantity of product purchased                    |
| original\_price      | DECIMAL(10,2) | Original price of the product                    |
| markdown\_percentage | DECIMAL(5,2)  | Discount percentage applied to the product price |
| current\_price       | DECIMAL(10,2) | Price at the time of purchase                    |
| customer\_rating     | DECIMAL(2,1)  | Customer rating for the product                  |



3. gold_dim_time

| Column Name    | Data Type   | Description                                                       |
| -------------- | ----------- | ----------------------------------------------------------------- |
| purchase\_id   | INT         | Surrogate key uniquely identifying each purchase                  |
| product\_id    | INT         | Foreign key referencing `silver_product_info`                     |
| purchase\_date | DATE        | Date of the purchase                                              |
| Year           | INT         | Year of the purchase                                              |
| Month          | INT         | Month of the purchase                                             |
| Month\_Name    | VARCHAR(20) | Name of the month                                                 |
| Day\_Of\_Month | INT         | Day of the month                                                  |
| Day\_Name      | VARCHAR(20) | Day of the week                                                   |
| is\_weekend    | BOOLEAN     | Indicates whether the purchase was made on a weekend (True/False) |
| Quarter        | VARCHAR(2)  | Quarter in which the purchase was made (Q1, Q2, Q3, Q4)           |



4. gold_dim_product

| Column Name      | Data Type     | Description                                             |
| ---------------- | ------------- | ------------------------------------------------------- |
| product\_id      | INT           | Surrogate key uniquely identifying each product         |
| brand            | VARCHAR(100)  | Product brand                                           |
| category         | VARCHAR(100)  | Product category                                        |
| season           | VARCHAR(50)   | Product season (e.g., Spring, Summer)                   |
| size             | VARCHAR(10)   | Product size                                            |
| color            | VARCHAR(50)   | Product color                                           |
| stock\_quantity  | INT           | Quantity of product in stock                            |
| original\_price  | DECIMAL(10,2) | Original price of the product                           |
| customer\_rating | DECIMAL(2,1)  | Customer rating for the product                         |
| is\_returned     | BOOLEAN       | Indicates whether the product was returned (True/False) |
