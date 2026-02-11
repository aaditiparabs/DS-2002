DROP database `northwind_dw`;
CREATE DATABASE `northwind_dw` /*!40100 DEFAULT CHARACTER SET latin1 */ /*!80016 DEFAULT ENCRYPTION='N' */; -- creating the new database

USE northwind_dw; -- putting the context on this database

-- CREATING CUSTOMER TABLE
DROP TABLE IF EXISTS `dim_customers`;
CREATE TABLE `dim_customers` ( 
  `customer_key` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `company` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `job_title` varchar(50) DEFAULT NULL,
  `business_phone` varchar(25) DEFAULT NULL,
  `fax_number` varchar(25) DEFAULT NULL,
  `address` longtext,
  `city` varchar(50) DEFAULT NULL,
  `state_province` varchar(50) DEFAULT NULL,
  `zip_postal_code` varchar(15) DEFAULT NULL,
  `country_region` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`customer_key`),
  KEY `customer_id` (`customer_id`),
  KEY `city` (`city`), 
  KEY `company` (`company`),
  KEY `first_name` (`first_name`),
  KEY `last_name` (`last_name`),
  KEY `zip_postal_code` (`zip_postal_code`),
  KEY `state_province` (`state_province`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4;


-- CREATING EMPLOYEES TABLE
DROP TABLE IF EXISTS `dim_employees`;
CREATE TABLE `dim_employees` (
  `employee_key` int NOT NULL AUTO_INCREMENT,
  `employee_id` int NOT NULL,
  `company` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `email_address` varchar(50) DEFAULT NULL,
  `job_title` varchar(50) DEFAULT NULL,
  `business_phone` varchar(25) DEFAULT NULL,
  `home_phone` varchar(25) DEFAULT NULL,
  `fax_number` varchar(25) DEFAULT NULL,
  `address` longtext,
  `city` varchar(50) DEFAULT NULL,
  `state_province` varchar(50) DEFAULT NULL,
  `zip_postal_code` varchar(15) DEFAULT NULL,
  `country_region` varchar(50) DEFAULT NULL,
  `web_page` longtext,
  PRIMARY KEY (`employee_key`),
  KEY `employee_id` (`employee_id`),
  KEY `city` (`city`),
  KEY `company` (`company`),
  KEY `first_name` (`first_name`),
  KEY `last_name` (`last_name`),
  KEY `zip_postal_code` (`zip_postal_code`),
  KEY `state_province` (`state_province`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

-- CREATE PRODUCTS TBALE
DROP TABLE IF EXISTS `dim_products`;
CREATE TABLE `dim_products` (
  `product_key` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `product_code` varchar(25) DEFAULT NULL,
  `product_name` varchar(50) DEFAULT NULL,
  `standard_cost` decimal(19,4) DEFAULT '0.0000',
  `list_price` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `reorder_level` int DEFAULT NULL,
  `target_level` int DEFAULT NULL,
  `quantity_per_unit` varchar(50) DEFAULT NULL,
  `discontinued` tinyint(1) NOT NULL DEFAULT '0',
  `minimum_reorder_quantity` int DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`product_key`),
  KEY `product_id` (`product_id`),
  KEY `product_code` (`product_code`),
  KEY `discontinued` (`discontinued`),
  KEY `category` (`category`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4;

# ----------------------------------------------------------
# TODO: CREATE the `dim_shippers` dimension table ----------
# ----------------------------------------------------------
DROP TABLE IF EXISTS `dim_shippers`;
-- Know we have to extract data from the dimension: shipper
-- first profile the data:
-- SELECT * FROM northwind.shippers; -- will show you the whole table and see which columns are useful or not
-- right click on table to make the create statement
CREATE TABLE `dim_shippers` (
  `shipper_key` int NOT NULL AUTO_INCREMENT,
  `shipper_id` int NOT NULL, -- can track which row the shipper came from on the source system
  `company` varchar(50) DEFAULT NULL,
  `address` longtext,
  `city` varchar(50) DEFAULT NULL,
  `state_province` varchar(50) DEFAULT NULL,
  `zip_postal_code` varchar(15) DEFAULT NULL,
  `country_region` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`shipper_key`),
  KEY `shipper_id` (`shipper_id`),
  KEY `city` (`city`),
  KEY `company` (`company`),
 --  KEY `first_name` (`first_name`),
  -- KEY `last_name` (`last_name`),
  KEY `zip_postal_code` (`zip_postal_code`),
  KEY `state_province` (`state_province`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;



# ----------------------------------------------------------------------
# TODO: JOIN the orders, order_details, order_details_status and 
#       orders_status tables to create a new Fact Table in Northwind_DW.
# To keep things simple, don't include purchase order or inventory info
# ----------------------------------------------------------------------

# video notes
# in orders table, we have status id and in order status table, we have id column
# "id" is not very descriptive. can call it order status id in the order status table

DROP TABLE IF EXISTS `fact_orders`;

CREATE TABLE `fact_orders` (
  `fact_order_key` int NOT NULL AUTO_INCREMENT, 
  `order_id` int NOT NULL,
  `order_detail_id` int NOT NULL,
  `employee_key` int DEFAULT NULL,
  `customer_key` int DEFAULT NULL,
  `product_key` int DEFAULT NULL,
  `shipper_key` int DEFAULT NULL,
  `order_date` datetime DEFAULT NULL,
  `paid_date` datetime DEFAULT NULL,
  `date_allocated` datetime DEFAULT NULL,
  `shipped_date` datetime DEFAULT NULL,
  `shipping_fee` decimal(19,4) DEFAULT '0.0000',
  `taxes` decimal(19,4) DEFAULT '0.0000',
  `payment_type` varchar(50) DEFAULT NULL,
  `tax_rate` double DEFAULT '0',
  `quantity` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `unit_price` decimal(19,4) DEFAULT '0.0000',
  `discount` double NOT NULL DEFAULT '0',
  `tax_status_id` tinyint DEFAULT NULL,
  `order_status` varchar(50) NOT NULL,
  `order_details_status` varchar(50) NOT NULL,
  PRIMARY KEY (`fact_order_key`),
  KEY `customer_key` (`customer_key`),
  KEY `employee_key` (`employee_key`),
  KEY `product_key` (`product_key`),
  KEY `order_id` (`order_id`),
  KEY `order_detail_id` (`order_detail_id`),
  KEY `shipper_key` (`shipper_key`),
  KEY `tax_status` (`tax_status_id`)
  -- KEY `ship_zip_postal_code` (`ship_zip_postal_code`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb3;



-- order details table, some columns of this can go in the fact table
CREATE TABLE `order_details` (
  
  `status_id` int DEFAULT NULL,
  `purchase_order_id` int DEFAULT NULL,
  `inventory_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `inventory_id` (`inventory_id`),
  KEY `id_2` (`id`),
  KEY `id_3` (`id`),
  KEY `id_4` (`id`),
  KEY `product_id` (`product_id`),
  KEY `product_id_2` (`product_id`),
  KEY `purchase_order_id` (`purchase_order_id`),
  KEY `id_5` (`id`),
  KEY `fk_order_details_orders1_idx` (`order_id`),
  KEY `fk_order_details_order_details_status1_idx` (`status_id`),
  CONSTRAINT `fk_order_details_order_details_status1` FOREIGN KEY (`status_id`) REFERENCES `order_details_status` (`id`),
  CONSTRAINT `fk_order_details_orders1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `fk_order_details_products1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8mb3;

-- create order_details_status
CREATE TABLE `order_details_status` (
  `id` int NOT NULL,
  `order_details_status` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;





