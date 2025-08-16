# dim_return_reason

DROP VIEW IF EXISTS gold.dim_return_reason;

CREATE VIEW gold_dim_return_reason AS 
SELECT 
	r.return_id,
	prod.product_id,
    prod.category,
    prod.brand, 
    pur.current_price,
    r.return_reason,
    r.customer_rating
FROM silver_product_info AS prod
JOIN silver_purchase_info AS pur ON prod.product_id = pur.product_id
JOIN silver_returns AS r ON r.purchase_id = pur.purchase_id
WHERE is_returned = 'True';


#fact_sales for completed sales 

DROP VIEW IF EXISTS gold_fact_sales;

CREATE VIEW gold_fact_sales AS 
SELECT 
    pur.purchase_id,
	pur.purchase_date,
	prod.product_id,
    prod.category,
    prod.brand,
    prod.stock_quantity,
    pur.original_price,
    pur.markdown_percentage,
    pur.current_price,
    r.customer_rating
FROM silver_product_info AS prod
JOIN silver_purchase_info AS pur ON prod.product_id = pur.product_id
JOIN silver_returns AS r ON r.purchase_id = pur.purchase_id
WHERE r.is_returned = 'False';


#Time Dimaension 

DROP VIEW IF EXISTS gold_dim_time;

CREATE VIEW gold_dim_time AS
SELECT 
    pur.purchase_id,
	prod.product_id,
	pur.purchase_date,
    YEAR(pur.purchase_date) AS Year,
    MONTH(pur.purchase_date) AS Month,
    MONTHNAME(purchase_date) AS Month_Name,
    DAY(pur.purchase_date) AS Day_Of_Month,
    DAYNAME(pur.purchase_date) AS Day_Name,
    CASE
		WHEN DAYNAME(pur.purchase_date) IN ('Saturday', 'Sunday') THEN TRUE
        ELSE False 
	END AS is_weekend,
	CASE 
		WHEN MONTH(pur.purchase_date) IN (1,2,3) THEN 'Q1'
		WHEN MONTH(pur.purchase_date) IN (4,5,6) THEN 'Q2'
		WHEN MONTH(pur.purchase_date) IN (7,8,9) THEN 'Q3'
		ELSE 'Q4'
	END AS Quarter
FROM silver_product_info AS prod
JOIN silver_purchase_info AS pur ON prod.product_id = pur.product_id
JOIN silver_returns AS r ON r.purchase_id = pur.purchase_id
WHERE r.is_returned = FALSE;

# Product Dimension 

DROP VIEW IF EXISTS gold_dim_product;

CREATE VIEW gold_dim_product AS
SELECT 
	prod.product_id,
    prod.brand,
    prod.category,
    prod.season, 
    prod.size,
    prod.color,
    prod.stock_quantity,
    pur.original_price,
    r.customer_rating,
    r.is_returned
FROM silver_product_info AS prod
JOIN silver_purchase_info AS pur ON prod.product_id = pur.product_id	
JOIN silver_returns AS r ON r.purchase_id = pur.purchase_id;