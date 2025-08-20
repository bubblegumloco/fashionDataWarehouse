SELECT * FROM gold_dim_product;

# Colors pruchased ranked in descending order 
SELECT color, COUNT(color) as color_count
FROM gold_dim_product 
WHERE is_returned = 'False'
GROUP BY color 
ORDER BY color_count DESC;

# Sales Metrics For Each Brand 
SELECT brand, 
	SUM(original_price) AS total_revenue,
    AVG(original_price) AS avg_price,
    MIN(original_price) AS minimum_price,
    MAX(original_price) AS maximum_price
FROM gold_dim_product
WHERE is_returned = 'False'
GROUP BY brand;

# Which season has the highest revenue 
SELECT season,
	SUM(original_price) AS total_revenue,
    AVG(original_price) AS avg_price
FROM gold_dim_product
WHERE is_returned = 'False'
GROUP BY season
ORDER BY total_revenue DESC, avg_price DESC;

# Total quantity of items from each brand 
SELECT brand, SUM(stock_quantity) AS total_quantity
FROM gold_dim_product
GROUP BY brand
ORDER BY total_quantity DESC;

# Total quantity of items from each brand -> Grouped by brand + category
SELECT brand, category, SUM(stock_quantity) AS total_quantity
FROM gold_dim_product
GROUP BY brand, category;

# Sales Metrics For Each Category 
SELECT category, 
	SUM(original_price) AS total_revenue,
    AVG(original_price) AS avg_price,
    MIN(original_price) AS minimum_price,
    MAX(original_price) AS maximum_price
FROM gold_dim_product
WHERE is_returned = 'False'
GROUP BY category
ORDER BY total_revenue DESC;


/* Percentage of returns vs. no returns
https://stackoverflow.com/questions/22439602/count-boolean-field-values-within-a-single-query*/
SELECT SUM(is_returned = "False") AS not_returned, 
	   SUM(is_returned = "True") AS returned, 
       COUNT(is_returned) as total,
       ROUND((SUM(is_returned = "False")/ COUNT(is_returned)) * 100, 2) AS no_returns_percent,
       ROUND((SUM(is_returned = "True")/ COUNT(is_returned)) * 100, 2) AS returns_percent
FROM gold_dim_product;

/*For each brand & each rating bucket, show how many times a product was returned
Make case statment with segments*/
SELECT brand, 
	CASE 
		WHEN customer_rating BETWEEN 0 AND 1.0 THEN '0 - 1.0'
		WHEN customer_rating BETWEEN 1.0 AND 2.0 THEN '1.0 - 2.0'
		WHEN customer_rating BETWEEN 2.0 AND 3.0 THEN '2.0 - 3.0'
		WHEN customer_rating BETWEEN 3.0 AND 4.0 THEN '3.0 - 4.0'
		WHEN customer_rating BETWEEN 4.0 AND 5.0 THEN '4.0 - 5.0'
        WHEN customer_rating IS NULL THEN 'No Rating'
	END AS rating_bucket, 
	COUNT(is_returned = 'True') AS num_of_returns
FROM gold_dim_product
WHERE is_returned = 'True'
GROUP BY brand, rating_bucket
ORDER BY brand ASC;




