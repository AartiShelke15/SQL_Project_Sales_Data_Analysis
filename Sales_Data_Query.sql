-- Creating a database
CREATE DATABASE RETAIL_DB;

-- Dropping a database
DROP DATABASE RETAIL_DB;

-- USE THE DATABASE
USE RETAIL_DB;

-- CREATING SALES FACT

SELECT * FROM sales_fact_dataset ;
SELECT * FROM order_product_mapping;
SELECT * FROM product_info ;
SELECT * FROM customer_info ;
SELECT * FROM branch_details ;


-- How many transactions have been done by each gender?

SELECT gender, COUNT(*) AS transaction_count
FROM customer_info
GROUP BY gender;

-- How many customers have placed an order from more than one store?

SELECT COUNT(DISTINCT customer_id) AS customers_with_multiple_stores
FROM (
    SELECT customer_id
    FROM sales_fact_dataset
    GROUP BY customer_id
    HAVING COUNT(DISTINCT store_id) > 1
) AS subquery;

-- Which city has the highest number of orders?

SELECT city, COUNT(order_id) AS order_count
FROM order_product_mapping
JOIN  branch_details ON store_id = store_id
GROUP BY city
ORDER BY order_count DESC
LIMIT 1;

-- Which area has the highest sales?

SELECT area, SUM(sale_price) AS total_sales
FROM product_info 
JOIN branch_details  ON store_id = store_id
GROUP BY area
ORDER BY total_sales DESC
LIMIT 1;


-- Which state has the highest number of customers?

SELECT state, COUNT(customer_id) AS customer_count
FROM customer_info
JOIN branch_details ON state = state
GROUP BY state
ORDER BY customer_count DESC
LIMIT 1;
