QUESTION 1

-- create database Productdetail;
CREATE TABLE Productdetail.Productdetail (
    OrderID INT primary key,
    CustomerName VARCHAR(100),
    Products VARCHAR(255)
);


USE Productdetail;

SELECT 
  OrderID,
  CustomerName,
  TRIM(j.product) AS Product
FROM 
  ProductDetail,
  JSON_TABLE(
    CONCAT('["', REPLACE(Products, ',', '","'), '"]'),
    '$[*]' COLUMNS (product VARCHAR(100) PATH '$')
  ) AS j;

INSERT INTO ProductDetail (OrderID, CustomerName, Products)
VALUES 
(101, 'John Doe', 'Laptop, Mouse'),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');

QUESTION 2
-- CREATE DATABASE orders;
CREATE TABLE orders.Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);
CREATE TABLE orders.OrderDetails (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

USE Productdetail;
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

INSERT INTO OrderDetails (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;
