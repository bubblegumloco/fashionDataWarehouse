SELECT * FROM bronze_raw_product_data;

/*check for nulls or duplicates in PK

this is uses instead of DISTINCT because it will return the count 
distinct only returns the unique values, even if it appears just once 

*/

SELECT product_id, COUNT(*)
FROM silver_product_info
GROUP BY product_id
HAVING COUNT(*) > 1;

SELECT purchase_id, COUNT(*)
FROM silver_purchase_info
GROUP BY purchase_id
HAVING COUNT(*) > 1;

SELECT return_id, COUNT(*)
FROM silver_returns
GROUP BY return_id
HAVING COUNT(*) > 1;

/*No nulls + duplicates*/


/*Check for unwanted spaces*/

SELECT *
FROM silver_product_info
WHERE category != TRIM(category)
	OR brand != TRIM(brand)
    OR season != TRIM(season)
    OR size != TRIM(size)
    OR color != TRIM(color); #none 
    
SELECT *
FROM silver_returns
WHERE is_returned != TRIM(is_returned)
	OR return_reason != TRIM(return_reason); #none
    

/*Data Standardization & Consistency*/
SELECT DISTINCT season
FROM silver_product_info; 

SELECT DISTINCT size
FROM silver_product_info; # 6 sizes, one null 

SELECT DISTINCT color
FROM silver_product_info; #11 colors 

SELECT DISTINCT category
FROM silver_product_info; #6 categories 

SELECT DISTINCT is_returned
FROM silver_returns; #Boolean

SELECT DISTINCT customer_rating
FROM silver_returns;


#Check for NULLs or Negitive Nums
SELECT original_price, current_price 
FROM silver_purchase_info
WHERE original_price < 0 OR original_price IS NULL OR current_price < 0 OR current_price IS NULL;




