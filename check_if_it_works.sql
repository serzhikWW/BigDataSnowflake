SELECT * FROM fact_sales
ORDER BY sale_date DESC
LIMIT 10;

SELECT COUNT(*) AS total_sales FROM fact_sales;

SELECT SUM(total_price) AS total_revenue FROM fact_sales;

SELECT customer_id, COUNT(*) AS purchases_count
FROM fact_sales
GROUP BY customer_id
ORDER BY purchases_count DESC
LIMIT 10;

SELECT c.first_name, c.last_name, COUNT(*) AS purchases
FROM fact_sales fs
JOIN customers c ON fs.customer_id = c.customer_id
WHERE c.country = 'United States'
GROUP BY c.first_name, c.last_name;

SELECT seller_id, SUM(total_price) AS total_sales
FROM fact_sales
GROUP BY seller_id
ORDER BY total_sales DESC
LIMIT 5;

SELECT first_name, last_name, COUNT(*) AS sales_count
FROM fact_sales fs
JOIN sellers s ON fs.seller_id = s.seller_id
GROUP BY first_name, last_name;

SELECT name, SUM(fs.total_price) AS store_revenue
FROM fact_sales fs
JOIN stores s ON fs.store_id = s.store_id
GROUP BY name
ORDER BY store_revenue DESC;

SELECT name, location
FROM stores
WHERE city = 'San Francisco';

select city
from stores s