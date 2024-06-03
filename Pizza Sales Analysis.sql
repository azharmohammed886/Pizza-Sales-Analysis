



# CREATING A TABLE FOR ORDERS (to import in in a proper format)

CREATE TABLE orders (
order_id int NOT NULL,
order_date datetime NOT NULL,
order_time time NOT NULL,
PRIMARY KEY (order_id) )

SELECT * FROM pizza_sales.orders;


# CREATING A TABLE FOR ORDER_DETAILS (to import in in a proper format)
CREATE TABLE order_details (
order_id int NOT NULL,
order_details_id int NOT NULL,
pizza_id text NOT NULL,
quantity int NOT NULL,
PRIMARY KEY (order_details_id) )


-- 1.	Retrieve the total number of orders placed.
SELECT COUNT(order_id) AS Total_orders
FROM orders;

-- 2.	Calculate the total revenue generated from pizza sales.
SELECT ROUND(SUM(Quantity * Price),1) AS Total_Revenue
FROM order_details od
JOIN pizzas
ON od.pizza_id = od.pizza_id;

-- 3. Identify the highest-priced pizza.
SELECT MAX(price) AS High_priced_pizza, pizza_type_id
FROM pizzas
GROUP BY pizza_type_id
ORDER BY High_priced_pizza DESC ;

-- 4. Identify the most common pizza size ordered.
#SELECT quantity, COUNT(order_details_id)
#FROM order_details
#GROUP BY quantity;

SELECT pizzas.size, COUNT(order_details.order_details_id) AS Count_order_details
FROM pizzas
JOIN order_details
ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size 
ORDER BY Count_order_details DESC 
LIMIT 5;

-- 5.	List the top 5 most ordered pizza types along with their quantities.
SELECT pt.name, SUM(od.quantity) AS quantity
FROM pizza_types pt
JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od ON od.pizza_id = p.pizza_id
GROUP BY pt.name
ORDER BY quantity DESC
LIMIT 5;

-- Intermediate:
-- 1.	Join the necessary tables to find the total quantity of each pizza category ordered.
	SELECT pt.category, SUM(od.quantity) AS quantity
	FROM pizza_types pt
	JOIN pizzas p
	ON pt.pizza_type_id = p.pizza_type_id
	JOIN order_details od
	ON od.pizza_id = p.pizza_id
	GROUP BY pt.category
	ORDER BY quantity DESC;

-- 2.	Determine the distribution of orders by hour of the day.
SELECT hour(order_time) AS Hour, COUNT(order_id) AS order_count
FROM orders
GROUP BY hour(order_time);

-- 3.	Join relevant tables to find the category-wise distribution of pizzas.
SELECT category, COUNT(name) 
FROM pizza_types
GROUP BY category;

-- 4.	Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT ROUND(AVG(quantity), 1) AS Avg_pizza_order_per_day FROM
(SELECT o.order_date AS Order_date, SUM(od.quantity) AS quantity
FROM orders o
JOIN order_details od
ON o.order_id = od.order_id
GROUP BY Order_date) AS order_quantity;

-- 5.	Determine the top 3 most ordered pizza types based on revenue.

SELECT pizza_types.name, 
SUM(order_details.quantity * pizzas.price) AS Revenue
FROM pizza_types
JOIN pizzas
ON pizzas.pizza_type_id = pizza_types.pizza_type_id
JOIN order_details
ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY Revenue DESC
LIMIT 3;

-- Advanced:
-- 1.	Calculate the percentage contribution of each pizza type to total revenue.







