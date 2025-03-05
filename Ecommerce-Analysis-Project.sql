CREATE Database ecommerce;
USE ecommerce;

-- Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50),
    country VARCHAR(50),
    signup_date DATE
);

-- Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

-- Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Order Details Table (to handle multiple products in one order)
CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    subtotal DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
SELECT*FROM customers;
SELECT*FROM products;
SELECT*FROM orders;
SELECT*FROM order_details;

INSERT INTO customers (name, email, city, country, signup_date) VALUES
('Alice Johnson', 'alice@example.com', 'New York', 'USA', '2023-01-05'),
('Bob Smith', 'bob@example.com', 'Los Angeles', 'USA', '2023-02-10');

INSERT INTO products (name, category, price) VALUES
('Laptop', 'Electronics', 800.00),
('Smartphone', 'Electronics', 500.00),
('Shoes', 'Fashion', 50.00);

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2024-01-10', 850.00),
(2, '2024-02-15', 500.00);

INSERT INTO order_details (order_id, product_id, quantity, subtotal) VALUES
(1, 1, 1, 800.00),
(1, 3, 1, 50.00),
(2, 2, 1, 500.00);

SELECT*FROM customers;
SELECT*FROM products;
SELECT*FROM orders;
SELECT*FROM order_details;

SELECT SUM(total_amount) AS total_revenue
FROM orders;

SELECT p.name, SUM(od.quantity) AS total_sold
FROM order_details od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.name
ORDER BY total_sold DESC
LIMIT 5;

SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(total_amount) AS monthly_sales
FROM orders
GROUP BY month
ORDER BY month;

SELECT c.name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 1;

CREATE INDEX idx_order_date ON orders(order_date);
CREATE INDEX idx_product_sales ON order_details(product_id);
