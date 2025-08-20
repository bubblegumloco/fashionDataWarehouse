SELECT * FROM gold_dim_return_reason;

# Count of each return reason & rating given by those who returned it 
SELECT return_reason, COUNT(return_reason) AS reason_count, AVG(r.customer_rating) AS avg_rating
FROM gold_dim_return_reason r
JOIN gold_dim_product p ON r.product_id = p.product_id
WHERE is_returned = 'True'
GROUP BY return_reason;

# returns per brand & avg customer rating for their items 
SELECT r.brand, COUNT(r.return_reason) AS num_returns, AVG(r.customer_rating) AS avg_rating
FROM gold_dim_return_reason r
JOIN gold_dim_product p ON r.product_id = p.product_id
WHERE is_returned = 'True'
GROUP BY r.brand
ORDER BY num_returns DESC;

