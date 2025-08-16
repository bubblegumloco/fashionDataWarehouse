DELIMITER $$

CREATE PROCEDURE fashion_dw.load_silver_layer()
BEGIN
	DECLARE batch_start_time DATETIME;
	SET batch_start_time = NOW();
		
	#Logging the beginning of the process 
		
	SELECT '======================================' AS '';
	SELECT 'Loading Silver Layer...' AS '';
	SELECT CONCAT('Batch Start Time: ', batch_start_time) AS '';
	SELECT '======================================' AS '';
		
		
	# Loading silver_product_info
	SET start_time = NOW();
	SELECT '>> Truncating Table: fashion_dw.silver_product_info';
	TRUNCATE TABLE fashion_dw.silver_product_info;
	SELECT '>> Inserting Data Into: fashion_dw.silver_product_info';
	INSERT INTO fashion_dw.silver_product_info (
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
		
	SET end_time = NOW();
	SET duration_seconds = TIMESTAMPDIFF(SECOND, start_time, end_time);
	SELECT CONCAT('>> Load Duration: ', duration_seconds, ' seconds') AS '';
	SELECT '>> ------------------' AS '';
		
		
	# Loading silver_purchase_info
	SET start_time = NOW();
	SELECT '>> Truncating Table: fashion_dw.silver_purchase_info';
	TRUNCATE TABLE fashion_dw.silver_purchase_info;
	SELECT '>> Inserting Data Into: fashion_dw.silver_purchase_info';
	INSERT INTO fashion_dw.silver_purchase_info (
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
		
	SET end_time = NOW();
	SET duration_seconds = TIMESTAMPDIFF(SECOND, start_time, end_time);
	SELECT CONCAT('>> Load Duration: ', duration_seconds, ' seconds') AS '';
	SELECT '>> ------------------' AS '';
		
	#Loading silver_returns 
	SET start_time = NOW();
	SELECT '>> Truncating Table: fashion_dw.silver_returns ';
	TRUNCATE TABLE fashion_dw.silver_returns ;
	SELECT '>> Inserting Data Into: fashion_dw.silver_returns ';
	INSERT INTO fashion_dw.silver_returns (
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
	JOIN silver_purchase_info p ON TRIM(b.product_id) = p.product_id AND b.purchase_date = p.purchase_date;
		
	SET end_time = NOW();
	SET duration_seconds = TIMESTAMPDIFF(SECOND, start_time, end_time);
	SELECT CONCAT('>> Load Duration: ', duration_seconds, ' seconds') AS '';
	SELECT '>> ------------------' AS '';
		
	# Ending the Load Process
		
	SELECT '======================================' AS '';
	SELECT 'Silver Layer Load Process Is Completed...' AS '';
	SELECT CONCAT('Batch End Time: ', batch_end_time) AS '';
	SELECT '======================================' AS '';
		
END$$

DELIMITER ;
		
    