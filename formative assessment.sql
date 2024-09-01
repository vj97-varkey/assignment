CREATE DATABASE IF NOT EXISTS global_store_db;
USE global_store_db;

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2),
    quantity INT
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    quantity_ordered INT,
    order_date DATE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

ALTER TABLE products
ADD COLUMN category VARCHAR(50) AFTER price;

RENAME TABLE products TO inventory;

INSERT INTO inventory (name, price, quantity, category)
VALUES 
('Laptop', 999.99, 50, 'Electronics'),
('Smartphone', 799.99, 100, 'Electronics'),
('Headphones', 69.99, 200, 'Electronics'),
('Book', 19.99, 500, 'Books'),
('Shirt', 39.99, 300, 'Clothing'),
('Tablet', 699.99, 75, 'Electronics'),
('Socks', 14.99, 400, 'Clothing'),
('Pillow', 29.99, 250, 'Home Goods'),
('Toothbrush', 5.99, 600, 'Personal Care'),
('Notebook', 12.99, 700, 'Stationery');

INSERT INTO orders (product_id, quantity_ordered, order_date)
VALUES 
(1, 5, '2024-01-01'),
(2, 10, '2024-01-02'),
(3, 15, '2024-01-03'),
(4, 25, '2024-01-04'),
(5, 35, '2024-01-05');

SELECT * FROM inventory;
SELECT * FROM orders;

SELECT DISTINCT category FROM inventory;

SELECT * FROM inventory ORDER BY price DESC LIMIT 5;

SELECT * FROM inventory WHERE quantity > 10;

SELECT SUM(price * quantity) AS total_price FROM inventory;

SELECT category, COUNT(*) AS product_count FROM inventory GROUP BY category;

SELECT name, price FROM inventory WHERE quantity = 0;

CREATE VIEW expensive_products AS
SELECT *
FROM inventory
WHERE price > (SELECT AVG(price) FROM inventory);

SELECT i.name, o.quantity_ordered
FROM inventory i
LEFT JOIN orders o ON i.product_id = o.product_id;


