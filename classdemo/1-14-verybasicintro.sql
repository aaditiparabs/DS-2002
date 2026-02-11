-- 1/14 demo

USE northwind; -- this will be bolded as default db, any commands after will target this db
SELECT COUNT(*) AS ProductCount FROM northwind.products -- ProductCount becomes an alias for that count
WHERE list_price >15.00;
