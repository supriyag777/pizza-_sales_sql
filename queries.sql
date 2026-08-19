-- 1 .Retrieve the total number of orders placed.SWQ

SELECT 
    *
FROM
    orders;
SELECT 
    COUNT(order_id) AS total_orders
FROM
    orders;

-- 2. Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_revenue
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id

-- 3.Identify the highest-priced pizza.
SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1
;
DESCRIBE pizzas;

-- 4.Identify the most common pizza size ordered.-- 
SELECT quantity ,COUNT(order_details_id)
FROM order_details group by quantity;

SELECT 
    pizzas.size,
    COUNT(order_details.order_details_id) AS order_count
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC
;

-- 5. List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pizza_types.name,
    SUM(order_details.quantity) AS total_quantity
FROM pizza_types
JOIN pizzas
    ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
    ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.name
ORDER BY total_quantity DESC
LIMIT 5;

-- 6.Intermediate:
-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;

--7 Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(order_time) AS order_hour,
    COUNT(order_id) AS order_count
FROM orders
GROUP BY HOUR(order_time)
ORDER BY order_hour;

-- 8.Join relevant tables to find the 
-- category-wise distribution of pizzas.
SELECT 
    pizza_types.category,
    COUNT(pizzas.pizza_id) AS pizza_count
FROM pizza_types
JOIN pizzas
    ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY pizza_types.category;
"This counts the actual pizza entries in the pizzas table for each category."


-- 9."Count how many pizza types exist in each category."
select category ,count(name) from pizza_types
group by category;
" This counts the number of pizza types/names in each category."

-- 10.Group the orders by date and calculate the average 
-- number of pizzas ordered per day.total pizzas ordered per day.
SELECT 
    orders.order_date,
    SUM(order_details.quantity) AS total_pizzas
FROM orders
JOIN order_details
    ON orders.order_id = order_details.order_id
GROUP BY orders.order_date
ORDER BY orders.order_date;

--11. specifically wants the average number of pizzas per day,-- 
SELECT AVG(daily_total) AS average_pizzas_per_day
FROM (
    SELECT 
        orders.order_date,
        SUM(order_details.quantity) AS daily_total
    FROM orders
    JOIN order_details
        ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date
) AS daily_orders;

-- 12.Determine the top 3 most ordered pizza types based on revenue. give code
SELECT 
    pizza_types.name,
    SUM(order_details.quantity * pizzas.price) AS revenue
FROM pizza_types
JOIN pizzas
    ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
    ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3;

-- 13.Calculate the percentage contribution of each pizza type to total revenue.

SELECT 
    pizza_types.name,
    ROUND(SUM(order_details.quantity * pizzas.price), 2) AS revenue,
    
    ROUND(
        SUM(order_details.quantity * pizzas.price) /
        (SELECT SUM(order_details.quantity * pizzas.price)
         FROM order_details
         JOIN pizzas
             ON order_details.pizza_id = pizzas.pizza_id) * 100,
        2
    ) AS revenue_percentage

FROM pizza_types
JOIN pizzas
    ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
    ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue_percentage DESC;

-- 14.Analyze the cumulative revenue generated over time.
SELECT
    order_date,
    revenue,
    ROUND(
        SUM(revenue) OVER (
            ORDER BY order_date
        ), 2
    ) AS cumulative_revenue
FROM (
    SELECT
        orders.order_date,
        SUM(order_details.quantity * pizzas.price) AS revenue
    FROM orders
    JOIN order_details
        ON orders.order_id = order_details.order_id
    JOIN pizzas
        ON order_details.pizza_id = pizzas.pizza_id
    GROUP BY orders.order_date
) AS daily_revenue
ORDER BY order_date;

--15. Determine the top 3 most ordered pizza types based on revenue for each pizza category.
WITH pizza_revenue AS (
    SELECT
        pizza_types.category, 
        pizza_types.name,
        SUM(order_details.quantity * pizzas.price) AS revenue
    FROM pizza_types
    JOIN pizzas
        ON pizza_types.pizza_type_id = pizzas.pizza_type_id
    JOIN order_details
        ON pizzas.pizza_id = order_details.pizza_id
    GROUP BY pizza_types.category, pizza_types.name
),
ranked_pizzas AS (
    SELECT
        category,
        name,
        ROUND(revenue, 2) AS revenue,
        RANK() OVER (
            PARTITION BY category
            ORDER BY revenue DESC
        ) AS pizza_rank
    FROM pizza_revenue
)
SELECT
    category,
    name,
    revenue,
    pizza_rank
FROM ranked_pizzas
WHERE pizza_rank <= 3
ORDER BY category, pizza_rank;





