SELECT * FROM gold_fact_sales;
# Finding the years of data collection in the dataset (2024, 2025)
SELECT DISTINCT(YEAR(purchase_date)) FROM gold_fact_sales;

#brands that gave the most discount 
SELECT brand, ROUND(AVG(markdown_percentage), 2) AS avg_discount
FROM gold_fact_sales
GROUP BY brand
ORDER BY avg_discount DESC;

# Total Revenue For Each Year 
SELECT YEAR(s.purchase_date), SUM(current_price) AS total_revenue 
FROM gold_fact_sales s
JOIN gold_dim_product p ON s.product_id = p.product_id 
WHERE is_returned = "False" 
GROUP BY YEAR(s.purchase_date);

# --------- Time Analysis ------------


# Which day on average makes the most revenue 
SELECT t.day_name AS Day, AVG(s.current_price) AS avg_revenue
FROM gold_dim_time t
JOIN gold_dim_product p ON t.product_id = p.product_id 
JOIN gold_fact_sales s ON s.purchase_id = t.purchase_id
WHERE p.is_returned = "False" 
GROUP BY t.day_name
ORDER BY avg_revenue DESC;

# Which quarter in 2024 made this most revenue? 
SELECT t.quarter, SUM(s.current_price) AS total_revenue
FROM gold_dim_time t
JOIN gold_dim_product p ON t.product_id = p.product_id 
JOIN gold_fact_sales s ON s.purchase_id = t.purchase_id
WHERE p.is_returned = "False" AND t.year = 2024
GROUP BY t.quarter;

# Which quarter in 2025 made this most revenue? 
SELECT t.quarter, SUM(s.current_price) AS total_revenue
FROM gold_dim_time t
JOIN gold_dim_product p ON t.product_id = p.product_id 
JOIN gold_fact_sales s ON s.purchase_id = t.purchase_id
WHERE p.is_returned = "False" AND t.year = 2025
GROUP BY t.quarter;





