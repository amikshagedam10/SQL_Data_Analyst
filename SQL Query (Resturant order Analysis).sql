-- question 1 View the menu_items table and write a query to find the number of items on the menu
select count(*) item_name from menu_items;
--Ans: 32

--question 2 What are the least expensive items on the menu?
select item_name, price from menu_items
where price =(select min(price)from menu_items) 
               --OR
select item_name, price AS least_expensive from menu_items ORDER BY price limit 1;
--Ans: 5.00


--question 3 What are the most expensive items on the menu?
select item_name, price from menu_items
where price =(select max(price)from menu_items) 
               --OR
select item_name, price AS Most_expensive from menu_items ORDER BY price desc limit 1;
--Ans: 19.95


--question 4 How many Italian dishes are on the menu? What are the least expensive Italian dishes on the menu?
SELECT
    COUNT(*) AS total_italian_dishes,
    MIN(price) AS least_expensive_italian_dish,
    MAX(price) AS most_expensive_italian_dish
FROM
    menu_items
WHERE
    category = 'Italian';

--Question 5 How many dishes are in each category? What is the average dish price within each category?
Select category AS dishes, COUNT(*) AS dishes_count,
AVG(price) AS average_price from menu_items Group BY category;
--Ans: dishes- American,Mexican,Asian,Italian
--   dishes_count- 6,9,8,9
--   average_price- 10.06,11.80,13.47,16.75

--Explore the orders table
--Our second objective is to better understand the orders table by finding the date range, the number of items within each order, and the orders with the highest number of items.

select*from order_details

--Question 1 View the order_details table. What is the date range of the table?
SELECT * FROM order_details 
WHERE order_date BETWEEN '2023-01-01' AND '2023-03-31'

-- To check last order_date
Select order_date from order_details order by order_date DESC
--Ans:2023-03-31

--Question 2 How many orders were made within this date range?
--Step 1: Determine the date range
 select min(order_date) AS earliest_date,
        max(order_date) AS latest_date
 from order_details
--Ans: earliest_date: 2023-01-01
--       latest_date: 2023-03-31

--Step 2: Find the number of orders within the date range
Select Count(Distinct order_id) AS number_of_orders FROM order_details 
WHERE order_date BETWEEN ( select min(order_date) FROM order_details) AND (select max(order_date) FROM order_details)
-- Ans : number_of_orders= 5370

--Question 3 Which orders had the most number of items?
select order_id, count(item_id) AS items_count FROM order_details 
GROUP BY order_id ORDER BY items_count DESC LIMIT 1;
--Ans: order_id= 2675
--     items_count = 14

-- Question 4 How many orders had more than 12 items
SELECT order_id, COUNT(*)
FROM order_details
GROUP BY order_id
HAVING COUNT(*) > 12

--Ans: Order_id:(2675,3583,2126,740,2075,3473,5200,1274,4623,1685,1569,4836,1734,4305,2188,440,443,2725,3292,4482,1957,330,5066)
--     count:(14,13,13,13,13,14,13,13,13,13,13,13,13,14,13,14,14,13,13,14,14,14,13)

--Analyze customer behavior
--Your final objective is to combine the items and orders tables, find the least and most ordered categories, and dive into the details of the highest spend orders.

--Question 1 Combine the menu_items and order_details tables into a single table
 select * from order_details od
    left join menu_items mi
    on od.item_id=mi.menu_item_id;
-- Ans: will get two table join

--Question 2 What were the least and most ordered items? What categories were they in?
--step 1: the most ordered item and its category
SELECT
    mi.menu_item_id,
    mi.item_name,
    mi.category,
    COUNT(od.order_id) AS order_count
FROM
    order_details od
JOIN
    menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY
    mi.menu_item_id, mi.item_name, mi.category
ORDER BY
    order_count DESC
LIMIT 1;


--step 2: the least ordered item and its category
SELECT
    mi.menu_item_id,
    mi.item_name,
    mi.category,
    COUNT(od.order_id) AS order_count
FROM
    order_details od
JOIN
    menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY
    mi.menu_item_id, mi.item_name, mi.category
ORDER BY
    order_count ASC
LIMIT 1;

--Question 3 What were the top 5 orders that spent the most money?
SELECT
    od.order_id,
    SUM(mi.price) AS total_spent
FROM
    order_details od
JOIN
    menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY
    od.order_id
ORDER BY
    total_spent DESC
LIMIT 5;

--Question 4 View the details of the highest spend order.
 SELECT
        od.order_id,
        SUM(mi.price) AS total_spent
    FROM
        order_details od
    JOIN
        menu_items mi ON od.item_id = mi.menu_items_id
    GROUP BY
        od.order_id
    ORDER BY
        total_spent DESC
    LIMIT 5