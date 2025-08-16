CREATE TABLE bronze_raw_product_data (
	product_id VARCHAR(20) NOT NULL,
    category VARCHAR(100),
    brand VARCHAR(100),
    season VARCHAR(50),
    size VARCHAR(10),
    color VARCHAR(50),
    original_price DECIMAL(10,2) NOT NULL,
    markdown_percentage DECIMAL(5,2) DEFAULT NULL,
	current_price DECIMAL(10,2) NOT NULL, 
    purchase_date DATETIME DEFAULT NULL,
    stock_quantity INT DEFAULT 0,
    customer_rating DECIMAL(2,1) DEFAULT NULL, 
    is_returned VARCHAR(10),
    return_reason VARCHAR(100) DEFAULT NULL,
	PRIMARY KEY (product_id)
);



SELECT COUNT(*) FROM bronze_raw_product_data;