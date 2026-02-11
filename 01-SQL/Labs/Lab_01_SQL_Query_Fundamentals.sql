-- --------------------------------------------------------------------------------------
-- Course: DS2-2002 - Data Science Systems | Author: Jon Tupitza
-- Lab 1: SQL Query Fundamentals | 5 Points
-- --------------------------------------------------------------------------------------
USE northwind;
-- --------------------------------------------------------------------------------------
-- 1). First, How Many Rows (Products) are in the Products Table? 45			| 0.2 pt
-- --------------------------------------------------------------------------------------
SELECT * FROM northwind.products -- select all valid items in the db
WHERE description != NULL;

SELECT COUNT(*) AS productcount -- save the count in a variable
FROM northwind.products;

-- --------------------------------------------------------------------------------------
-- 2). Fetch Each Product Name and its Quantity per Unit					| 0.2.pt
-- --------------------------------------------------------------------------------------
SELECT product_name,
		quantity_per_unit
FROM northwind.products;

-- --------------------------------------------------------------------------------------
-- 3). Fetch the Product ID and Name of Currently Available Products		| 0.2 pt 
-- --------------------------------------------------------------------------------------
SELECT id AS product_id 
	, product_name
FROM northwind.products
WHERE discontinued = 0;


-- --------------------------------------------------------------------------------------
-- 4). Fetch the Product ID, Name & List Price Costing Less Than $20
--     Sort the results with the most expensive Products first.				| 0.2 pt
-- --------------------------------------------------------------------------------------
SELECT id AS product_id
	, product_name
    , list_price
FROM northwind.products
WHERE list_price<20
ORDER BY list_price DESC;

-- --------------------------------------------------------------------------------------
-- 5). Fetch the Product ID, Name & List Price Costing Between $15 and $20
--     Sort the results with the most expensive Products first.				| 0.2 pt
-- --------------------------------------------------------------------------------------
SELECT id AS product_id
	, product_name
    , list_price
FROM northwind.products
WHERE list_price BETWEEN 15 and 20
ORDER BY list_price DESC;


-- Older (Equivalent) Syntax -----
SELECT id AS product_id,
       product_name,
       list_price
FROM northwind.products
WHERE list_price >= 15 AND list_price <= 20
ORDER BY list_price DESC;



-- --------------------------------------------------------------------------------------
-- 6). Fetch the Product Name & List Price of the 10 Most Expensive Products 
--     Sort the results with the most expensive Products first.				| 0.33 pt
-- --------------------------------------------------------------------------------------
SELECT id AS product_id
	, product_name
    , list_price
FROM northwind.products
ORDER BY list_price DESC -- ordering by most expensive first
LIMIT 10; -- then limit by ten

-- --------------------------------------------------------------------------------------
-- 7). Fetch the Name & List Price of the Most & Least Expensive Products	| 0.33 pt.
-- --------------------------------------------------------------------------------------
SELECT id AS product_id
	, product_name
    , list_price
FROM northwind.products
WHERE list_price = (SELECT MAX(list_price) FROM northwind.products)
OR list_price = (SELECT min(list_price) FROM northwind.products);


-- --------------------------------------------------------------------------------------
-- 8). Fetch the Product Name & List Price Costing Above Average List Price
--     Sort the results with the most expensive Products first.				| 0.33 pt.
-- --------------------------------------------------------------------------------------
SELECT id AS product_id
	, product_name
    , list_price
FROM northwind.products
WHERE list_price > (SELECT AVG(list_price) FROM northwind.products)
ORDER BY list_price DESC;

-- SELECT AVG(list_price) FROM northwind.products;


-- --------------------------------------------------------------------------------------
-- 9). Fetch & Label the Count of Current and Discontinued Products using
-- 	   the "CASE... WHEN" syntax to create a column named "availablity"
--     that contains the values "discontinued" and "current". 				| 0.33 pt 
-- --------------------------------------------------------------------------------------
UPDATE northwind.products SET discontinued = 1 WHERE id IN (95, 96, 97); -- marking these items as discont 

-- TODO: Insert query here.
SELECT CASE
		WHEN discontinued = 1 THEN "discontinued"
		ELSE "current"
    END AS "availability" -- makes that availability column
    , COUNT(*) as product_count
FROM northwind.products
GROUP BY discontinued;
    

UPDATE northwind.products SET discontinued = 0 WHERE id in (95, 96, 97); -- changing back to norml

-- --------------------------------------------------------------------------------------
-- 10). Fetch Product Name, Reorder Level, Target Level and "Reorder Threshold"
-- 	    Where Reorder Level is Less Than or Equal to 20% of Target Level	| 0.33 pt.
-- --------------------------------------------------------------------------------------
SELECT product_name
	, reorder_level
    , target_level 
    , ROUND(target_level/5) AS reorder_threshold
FROM northwind.products
WHERE reorder_level<= ROUND(target_level/5);

-- --------------------------------------------------------------------------------------
-- 11). Fetch the Number of Products per Category Priced Less Than $20.00	| 0.33 pt
-- --------------------------------------------------------------------------------------
SELECT category
	, COUNT(*) as product_count
FROM northwind.products
WHERE list_price<20
GROUP BY category;

-- --------------------------------------------------------------------------------------
-- 12). Fetch the Number of Products per Category With Less Than 5 Units In Stock	| 0.5 pt
-- --------------------------------------------------------------------------------------
SELECT category
	, COUNT(*) as units_in_stock
FROM northwind.products
GROUP BY category
HAVING units_in_stock<5;

-- --------------------------------------------------------------------------------------
-- 13). Fetch Products along with their Supplier Company & Address Info		| 0.5 pt
-- --------------------------------------------------------------------------------------
SELECT p.id AS product_id
	, p.product_code
    , p.product_name
	, s.company AS supplier
    , s.address
    , s.city
    , s.state_province
    , s.zip_postal_code
FROM northwind.products AS p
INNER JOIN northwind.suppliers AS s -- only return matches
ON p.supplier_ids = s.id;

-- --------------------------------------------------------------------------------------
-- 14). Fetch the Customer ID and Full Name for All Customers along with -- left outer join
-- 		the Order ID and Order Date for Any Orders they may have			| 0.5 pt
-- --------------------------------------------------------------------------------------
SELECT 
    c.id AS customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    o.id AS order_id,
    o.order_date
FROM northwind.customers c
LEFT OUTER JOIN northwind.orders o
    ON c.id = o.customer_id;


-- --------------------------------------------------------------------------------------
-- 15). Fetch the Order ID and Order Date for All Orders along with
--   	the Customr ID and Full Name for Any Associated Customers			| 0.5 pt
-- --------------------------------------------------------------------------------------
SELECT 
    o.id AS order_id,
    o.order_date,
    c.id AS customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name
FROM northwind.orders o
LEFT OUTER JOIN northwind.customers c
    ON o.customer_id = c.id;



