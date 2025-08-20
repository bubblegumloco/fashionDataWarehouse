SELECT * FROM gold_dim_time;

# Number of orders per a year 
SELECT year, COUNT(*) as total_purchases
FROM gold_dim_time
GROUP BY year
ORDER BY total_purchases DESC;

# monthly order amounts for 2025
SELECT month, year, COUNT(*) as total_purchases
FROM gold_dim_time
WHERE year = 2025
GROUP BY month
ORDER BY month; 

# monthly order amounts for 2024
SELECT month, year, COUNT(*) as total_purchases
FROM gold_dim_time
WHERE year = 2024
GROUP BY month
ORDER BY month; 



