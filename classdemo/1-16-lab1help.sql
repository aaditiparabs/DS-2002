-- 1/16 demo
USE northwind;

SELECT * FROM northwind.products
WHERE description != NULL;

SELECT COUNT(*) AS productcount
FROM northwind.products;

SELECT product_name,
		quantity_per_unit
FROM northwind.products;

SELECT id AS product_id
	, product_name
    , discontinued
FROM northwind.products;
-- could instead use WHERE discontinued = 0; to find discontinued products


SELECT id AS product_id
	, product_name
    , list_price
FROM northwind.products
WHERE list_price<20 -- WHERE list_price BETWEEN 15 and 20 -- between is inclusive of boundaries
ORDER BY list_price DESC;

SELECT id AS product_id
	, product_name
    , list_price
FROM northwind.products
ORDER BY list_price DESC
LIMIT 10;

-- subquerying
SELECT id AS product_id
	, product_name
    , list_price
FROM northwind.products
WHERE list_price = (SELECT MAX(list_price) FROM northwind.products)
OR list_price = (SELECT min(list_price) FROM northwind.products);

