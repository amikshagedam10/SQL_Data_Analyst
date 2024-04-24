--Query Based on Customer Table

--Question 1 how many total customer do we have?
select count(*) AS Total_customer FROM customers

--Question 2 The number of Customer in each Country
select count(*) AS number_of_customer_in_country, country from Customers
Group by Country

--Question 3 What is the average age of the customer?
select AVG(extract(year from age(CURRENT_DATE, Birthday))) AS avg_age FROM Customers

--Question 4 List of Customers sort by age
select Name,Birthday, AGE(Birthday) AS Age FROM Customers Order by Age 

--Question 5 Number of Male and Female Customers
select Count(*) AS numbers_of_male_female, gender From Customers Group by Gender

--Question 6 The number of Customer per state
select count(*) AS Number_of_customer_per_state, state FROM Customers Group by state

--Question 7 Customer from specific continant and gender
select * from Customers where continant = 'North America' AND Gender = 'Female'
select * from Customers where continant = 'Australia' AND Gender = 'Male'

--	Question 8 Customer who has not provided gender
select * from customers where gender ='NULL'

select * from customers

--Query Based on Store Table

--Question 1 Top 5 largest store
select * from Store ORDER BY Square_meters DESC LIMIT 5

--Question 2 Total Numbers of store in each country
select count(*) AS Total_store, Country From store GROUP BY Country

--Question 3 The Average size of the store in each state
select state, avg(square_meters) from store group by state

--Question 4 Stored open in 2018-2019 year
select * from Store WHERE Open_Date >= CURRENT_DATE - INTERVAL '7 year'

--Question 5 Retrieve stores sorted by their opening date in descending order
select * from Store ORDER BY Open_Date DESC;

select * from store

--Query Based on exchange rates Table

--Question 1 the latest exchange rate for each currency
SELECT Currency, MAX(Date) AS latest_date, Exchange
FROM Exchange_Rates
GROUP BY Currency, Exchange;

--Question 2 the average exchange rate for each currency
SELECT Currency, AVG(Exchange) AS avg_exchange_rate
FROM Exchange_Rates
GROUP BY Currency;

--Question 3 Retrieve exchange rates for a specific currency
SELECT * FROM Exchange_Rates
WHERE Currency = 'CAD';

--Question 4 Calculate the average exchange rate for each year
SELECT EXTRACT(YEAR FROM Date) AS year, AVG(Exchange) AS avg_exchange_rate
FROM Exchange_Rates
GROUP BY year
ORDER BY year;

--Question 5 Retrieve the exchange rate trend (increasing, decreasing, or stable) for each currency
SELECT Currency,
       CASE 
           WHEN Exchange > LAG(Exchange) OVER (PARTITION BY Currency ORDER BY Date) THEN 'Increasing'
           WHEN Exchange < LAG(Exchange) OVER (PARTITION BY Currency ORDER BY Date) THEN 'Decreasing'
           ELSE 'Stable'
       END AS trend
FROM Exchange_Rates;

--Question 6 Calculate the percentage change in exchange rate compared to the first recorded date for each currency
SELECT Currency, 
       (Exchange - FIRST_VALUE(Exchange) OVER (PARTITION BY Currency ORDER BY Date)) / FIRST_VALUE(Exchange) OVER (PARTITION BY Currency ORDER BY Date) * 100 AS percentage_change
FROM Exchange_Rates;

select * from exchange_rates

--Query Based on products Table

--Question 1 Find products from a specific brand
SELECT * FROM Products WHERE brand = 'Contoso';

--Question 2 Count the number of products in each sub-category
SELECT Sub_Category, COUNT(*) AS num_products
FROM Products
GROUP BY Sub_Category;

--Question 3 Retrieve products with a specific name or part of the name
SELECT * FROM Products WHERE Product_Name LIKE '%SV%';

--Question 4 Calculate the total number of products
SELECT COUNT(*) AS total_products FROM Products;

--Question 5 Retrieve products from a specific category and brand
SELECT * FROM Products WHERE Category = 'TV and Video' AND Brand = 'Litware';

select * from products

--Query Based on Sales Table

--Question 1 Find sales transactions for a specific order number
SELECT * FROM Sales WHERE Order_Number = 367007;

--Question 2 Retrieve sales transactions for a specific store
SELECT * FROM Sales WHERE StoreKey = 15;

--Question 3 Find sales transactions for a specific product:
SELECT * FROM Sales WHERE ProductKey = 1577;

--Question 4 Calculate the total quantity sold for each product
SELECT ProductKey, SUM(Quantity) AS total_quantity_sold
FROM Sales
GROUP BY ProductKey;

--Question 5 Find the top 5 best-selling products
SELECT ProductKey, SUM(Quantity) AS total_quantity_sold
FROM Sales
GROUP BY ProductKey
ORDER BY total_quantity_sold DESC
LIMIT 5;

--Question 6 Retrieve sales transactions within a specific date range
SELECT * FROM Sales WHERE Order_Date BETWEEN '2016/1/1' AND '2016/1/31';

--Question 7 Retrieve sales transactions with a specific currency code
SELECT * FROM Sales WHERE Currency_Code = 'USD';

select * from sales

--Query based on all table combine

--Queston 1 combine two table based on names and states, through this we can get customer name and which state he belongs
SELECT cust.name, st.state
FROM Customers cust
INNER JOIN store st ON st.state = cust.state;

--Question 2 This query will give us results about all product name and their respective currency code
SELECT p.product_name , s.currency_code
FROM products p
INNER JOIN sales s ON s.productkey = p.productkey ;

--Question 3 The following SQL statement returns the country (only distinct values) from both the "Customers" and the "Store" table
SELECT Country FROM Customers
UNION
SELECT Country FROM Store
ORDER BY Country;

