/* Normalized to 3NF, No partial or transitive dependencies */

DROP TABLE IF EXISTS silver_product_info; 

CREATE TABLE silver_product_info (
	product_id VARCHAR(20) NOT NULL,
    category VARCHAR(100) NULL,
    brand VARCHAR(100) NULL,
    season VARCHAR(50) NULL,
    size VARCHAR(10) NULL,
    color VARCHAR(50) NULL,
    stock_quantity INT DEFAULT 0,
	PRIMARY KEY (product_id),
    dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    dwh_update_date DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS silver_purchase_info;

CREATE TABLE silver_purchase_info (
	purchase_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id VARCHAR(20) NOT NULL,
	original_price DECIMAL(10,2) NOT NULL,
    markdown_percentage DECIMAL(5,2) NULL,
	current_price DECIMAL(10,2) NOT NULL, 
    purchase_date DATETIME NULL,
    FOREIGN KEY (product_id) REFERENCES silver_product_info (product_id),
    dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    dwh_update_date DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS silver_returns; 

CREATE TABLE silver_returns (
	return_id INT AUTO_INCREMENT PRIMARY KEY,
    is_returned VARCHAR(10),
    return_reason VARCHAR(100) NULL,
    customer_rating DECIMAL(2,1) NULL, 
    dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    dwh_update_date DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

/* Insertion — Pulling data from bronze to silver tables */

INSERT INTO silver_product_info (
	product_id,
	category,
    brand,
    season,
    size,
    color,
    stock_quantity
)
SELECT 
	TRIM(product_id),
    TRIM(category),
    TRIM(brand),
    TRIM(season),
    TRIM(size),
    TRIM(color),
    stock_quantity
FROM bronze_raw_product_data 
WHERE product_id IS NOT NULL;

INSERT INTO silver_purchase_info (
    product_id,
	original_price,
    markdown_percentage,
	current_price, 
    purchase_date
)
SELECT
    TRIM(product_id),
    original_price,
    markdown_percentage,
    current_price,
    purchase_date
FROM bronze_raw_product_data
WHERE product_id IS NOT NULL;

#empty strings cause cast errors 
INSERT INTO silver_returns (
	is_returned,
    return_reason,
    customer_rating
)
SELECT
    TRIM(is_returned),
    TRIM(return_reason),
    CAST(NULLIF(TRIM(customer_rating), '') AS DECIMAL (2,1))
FROM bronze_raw_product_data;

# Adding FK purchase_id to link returns to purchases
ALTER TABLE silver_returns
ADD COLUMN purchase_id INT;

/*bronze table is the common link to make sure purchase id matches in both tables 

purchase_id is auto generated and not in the raw data 

matching purchase to the raw data 
each return row can have the proper purchase id 

*/
INSERT INTO silver_returns (
    is_returned,
    return_reason,
    customer_rating,
    purchase_id,
    dwh_create_date,
    dwh_update_date
)
SELECT
    TRIM(b.is_returned),
    TRIM(b.return_reason),
    CAST(NULLIF(TRIM(b.customer_rating), '') AS DECIMAL(2,1)),
    p.purchase_id,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM bronze_raw_product_data b
JOIN silver_purchase_info p
  ON TRIM(b.product_id) = p.product_id
  AND b.purchase_date = p.purchase_date;

SELECT * FROM silver_returns;

ALTER TABLE silver_returns 
ADD CONSTRAINT fk_purchase_id FOREIGN KEY (purchase_id) 
REFERENCES silver_purchase_info(purchase_id);





