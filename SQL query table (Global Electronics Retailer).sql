CREATE TABLE Customers(
Customer_Key INT PRIMARY KEY,
Gender VARCHAR,
Name VARCHAR,
City VARCHAR,
State_Code VARCHAR,
State VARCHAR,
Zip_Code VARCHAR,
Country VARCHAR,
Continant VARCHAR,
Birthday Date
);
DROP TABLE Customers
SELECT * FROM Customers

SET client_encoding = 'UTF8';

CREATE TABLE Store(
StoreKey Serial PRIMARY KEY, 
Country VARCHAR,
State VARCHAR,
Square_meters INT,
Open_Date DATE
);
SELECT * FROM Store

CREATE TABLE Sales(
Order_Number INT,
Line_Item INT,
Order_Date DATE,
Delivery_Date DATE,
CustomerKey INT,
StoreKey INT,
ProductKey INT,
Quantity INT,
Currency_Code VARCHAR
);
DROP TABLE Sales
SELECT * FROM Sales

CREATE TABLE Exchange_Rates(
Date DATE,
Currency VARCHAR,
Exchange NUMERIC
);

SELECT * FROM Exchange_Rates

CREATE TABLE Products(
ProductKey Serial,
Product_Name VARCHAR,
Brand VARCHAR,
Color VARCHAR,
Unit_Cost_USD VARCHAR,
Unit_Price_USD VARCHAR,
Sub_Category_Key INT,
Sub_Category VARCHAR,
Category_Key INT,
Category VARCHAR
);
SELECT * FROM Products
Drop table Products