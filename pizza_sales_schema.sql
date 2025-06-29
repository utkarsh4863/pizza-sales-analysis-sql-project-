-- 1. Table: pizza_types

CREATE TABLE pizza_types (
    pizza_type_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL, -- e.g., Classic, Veggie, Chicken, Supreme
    ingredients TEXT -- comma-separated list of ingredients
);

-- 2. Table: pizzas

CREATE TABLE pizzas (
    pizza_id VARCHAR(50) PRIMARY KEY,
    pizza_type_id VARCHAR(50),
    size VARCHAR(5), -- e.g., S, M, L, XL
    price DECIMAL(5,2),
    FOREIGN KEY (pizza_type_id) REFERENCES pizza_types(pizza_type_id)
);

-- 3. Table: orders

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    date DATE,
    time TIME
);

-- 4. Table: order_details

CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    pizza_id VARCHAR(50),
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (pizza_id) REFERENCES pizzas(pizza_id)
);
