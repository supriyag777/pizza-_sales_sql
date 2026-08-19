CREATE DATABASE IF NOT EXISTS pizzahut;
USE pizzahut;

-- Create Order Details Table
DROP TABLE IF EXISTS order_details;
CREATE TABLE order_details (
    order_details_id INT NOT NULL,
    order_id INT NOT NULL,
    pizza_id TEXT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (order_details_id)
);
CREATE DATABASE IF NOT EXISTS pizzahut;
USE pizzahut;

-- 1. Create Pizza_Types Table
DROP TABLE IF EXISTS pizza_types;
CREATE TABLE pizza_types (
    pizza_type_id VARCHAR(50) NOT NULL,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    ingredients TEXT NOT NULL,
    PRIMARY KEY (pizza_type_id)
);

-- 2. Create Pizzas Table
DROP TABLE IF EXISTS pizzas;
CREATE TABLE pizzas (
    pizza_id VARCHAR(50) NOT NULL,
    pizza_type_id VARCHAR(50) NOT NULL,
    size VARCHAR(10) NOT NULL,
    price DECIMAL(5,2) NOT NULL,
    PRIMARY KEY (pizza_id)
);

-- 3. Create Orders Table
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_time TIME NOT NULL,
    PRIMARY KEY (order_id)
);

-- 4. Create Order_Details Table
DROP TABLE IF EXISTS order_details;
CREATE TABLE order_details (
    order_details_id INT NOT NULL,
    order_id INT NOT NULL,
    pizza_id VARCHAR(50) NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (order_details_id)
);
