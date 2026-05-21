-- Fresh demo setup ONLY. Do not import over an existing database.

CREATE DATABASE IF NOT EXISTS ecommerce_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE ecommerce_db;

SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `role` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'CUSTOMER',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_id` int NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `price` decimal(10,2) NOT NULL,
  `stock` int NOT NULL DEFAULT '0',
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `total_amount` decimal(10,2) NOT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Pending',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `order_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT IGNORE INTO categories (id,name,description,is_active) VALUES (1,'Men’s Fragrances','Fragrances selected for men',1);

INSERT IGNORE INTO categories (id,name,description,is_active) VALUES (2,'Women’s Fragrances','Elegant and long-lasting fragrances for women',1);

INSERT IGNORE INTO categories (id,name,description,is_active) VALUES (3,'Unisex Fragrances','Fragrances for everyone',1);

INSERT IGNORE INTO categories (id,name,description,is_active) VALUES (4,'Oriental Fragrances','Rich, warm oriental-inspired fragrances',1);

INSERT IGNORE INTO categories (id,name,description,is_active) VALUES (5,'Home Fragrances','Pleasant scents for home and office',1);

INSERT IGNORE INTO products (id,category_id,name,description,price,stock,image_url,is_active) VALUES (1,1,'Noir','Intense, long-lasting fragrance for men',850.00,22,'images/MAN.png',1);

INSERT IGNORE INTO products (id,category_id,name,description,price,stock,image_url,is_active) VALUES (2,1,'Sport','Fresh fragrance for everyday wear',750.00,12,'images/UNI.png',1);

INSERT IGNORE INTO products (id,category_id,name,description,price,stock,image_url,is_active) VALUES (3,2,'Rose','Elegant fragrance with rose notes',900.00,9,'images/FEM.png',1);

INSERT IGNORE INTO products (id,category_id,name,description,price,stock,image_url,is_active) VALUES (4,2,'Bloom','Light floral fragrance',780.00,13,'images/FEM.png',1);

INSERT IGNORE INTO products (id,category_id,name,description,price,stock,image_url,is_active) VALUES (5,3,'Pure','Clean, understated unisex fragrance',820.00,17,'images/UNI.png',1);

INSERT IGNORE INTO products (id,category_id,name,description,price,stock,image_url,is_active) VALUES (6,3,'Fresh','Fresh and light unisex fragrance',700.00,19,'images/UNI.png',1);

INSERT IGNORE INTO products (id,category_id,name,description,price,stock,image_url,is_active) VALUES (7,4,'Oud','Oriental fragrance with oud notes',1200.00,7,'images/MAN.png',1);

INSERT IGNORE INTO products (id,category_id,name,description,price,stock,image_url,is_active) VALUES (8,4,'Amber','Warm fragrance with amber and spice notes',1100.00,8,'images/MAN.png',1);

INSERT IGNORE INTO products (id,category_id,name,description,price,stock,image_url,is_active) VALUES (9,5,'Home','Pleasant home and office fragrance',450.00,24,'images/MAN.png',1);
