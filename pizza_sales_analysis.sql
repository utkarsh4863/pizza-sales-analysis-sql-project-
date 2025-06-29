-- 1.Retrieve the total number of orders placed

select count(order_id) from orders;



-- 2.Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM 
    order_details od
JOIN  
    pizzas p ON od.pizza_id = p.pizza_id;



-- 3.Identify the highest-priced pizza.

SELECT 
    pt.name AS pizza_name,
    pt.category,
    p.size,
    p.price
FROM 
    pizzas p
JOIN 
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
ORDER BY 
    p.price DESC
LIMIT 1;


-- 4.Identify the most common pizza size ordered.

SELECT 
    p.size,
    SUM(od.quantity) AS total_ordered
FROM 
    order_details od
JOIN 
    pizzas p ON od.pizza_id = p.pizza_id
GROUP BY 
    p.size
ORDER BY 
    total_ordered DESC
LIMIT 1;


-- 5.List the top 5 most ordered pizza types along with their quantities.

SELECT 
    pt.name AS pizza_name,
    SUM(od.quantity) AS total_quantity
FROM 
    order_details od
JOIN 
    pizzas p ON od.pizza_id = p.pizza_id
JOIN 
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY 
    pt.name
ORDER BY 
    total_quantity DESC
LIMIT 5;


-- 6.Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pt.category,
    SUM(od.quantity) AS total_quantity
FROM 
    order_details od
JOIN 
    pizzas p ON od.pizza_id = p.pizza_id
JOIN 
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY 
    pt.category
ORDER BY 
    total_quantity DESC;


-- 7.Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(time) AS order_hour,
    COUNT(order_id) AS total_orders
FROM 
    orders
GROUP BY 
    order_hour
ORDER BY 
    order_hour;


-- 8.Join relevant tables to find the category-wise distribution of pizzas.  

SELECT 
    pt.category,
    COUNT(p.pizza_id) AS total_pizzas
FROM 
    pizzas p
JOIN 
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY 
    pt.category
ORDER BY 
    total_pizzas DESC;


-- 9.Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT 
    o.date,
    SUM(od.quantity) AS total_pizzas_ordered,
    (SELECT ROUND(AVG(daily_pizzas), 2) FROM (
        SELECT SUM(quantity) AS daily_pizzas
        FROM orders o2
        JOIN order_details od2 ON o2.order_id = od2.order_id
        GROUP BY o2.date
    ) AS sub) AS avg_pizzas_per_day
FROM 
    orders o
JOIN 
    order_details od ON o.order_id = od.order_id
GROUP BY 
    o.date
ORDER BY 
    o.date;  


-- 10.Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    pt.name AS pizza_name,
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM 
    order_details od
JOIN 
    pizzas p ON od.pizza_id = p.pizza_id
JOIN 
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY 
    pt.name
ORDER BY 
    total_revenue DESC
LIMIT 3; 


-- 11.Calculate the percentage contribution of each pizza type to total revenue.

SELECT 
    pt.category,
    ROUND(SUM(od.quantity * p.price), 2) AS category_revenue,
    ROUND(
        (SUM(od.quantity * p.price) / 
         (SELECT SUM(od2.quantity * p2.price)
          FROM order_details od2
          JOIN pizzas p2 ON od2.pizza_id = p2.pizza_id)
        ) * 100, 2
    ) AS percentage_contribution
FROM 
    order_details od
JOIN 
    pizzas p ON od.pizza_id = p.pizza_id
JOIN 
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY 
    pt.category
ORDER BY 
    percentage_contribution DESC;


-- 12.Analyze the cumulative revenue generated over time. 

SELECT 
    o.date,
    ROUND(SUM(od.quantity * p.price), 2) AS daily_revenue,
    ROUND(SUM(SUM(od.quantity * p.price)) OVER (ORDER BY o.date), 2) AS cumulative_revenue
FROM 
    orders o
JOIN 
    order_details od ON o.order_id = od.order_id
JOIN 
    pizzas p ON od.pizza_id = p.pizza_id
GROUP BY 
    o.date
ORDER BY 
    o.date;  
