CREATE DATABASE RetailDB;

USE RetailDB;

CREATE TABLE RetailTransactions (
    TransactionID VARCHAR(20),
    Date DATE,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Region VARCHAR(20),
    SalesChannel VARCHAR(20),
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    TotalAmount DECIMAL(10,2),
    PaymentMode VARCHAR(30),
    CustomerID VARCHAR(20)
);


SELECT * FROM RetailTransactions LIMIT 10;

-- Total sales amount per region for the last quarter.

SELECT Region, SUM(TotalAmount) AS TotalSales FROM RetailTransactions
WHERE Date BETWEEN '2024-10-01' AND '2024-12-31'
GROUP BY Region
ORDER BY TotalSales DESC;

-- Top 5 best-selling products (by revenue).

SELECT ProductName, SUM(TotalAmount) AS TotalRevenue FROM RetailTransactions
GROUP BY ProductName
ORDER BY TotalRevenue DESC LIMIT 5;

-- Monthly sales trend across all regions.

SELECT MONTH(Date) AS Month, YEAR(Date) AS Year, SUM(TotalAmount) AS MonthlySales
FROM RetailTransactions GROUP BY YEAR(Date), MONTH(Date)
ORDER BY Year, Month;

-- Region-wise contribution to total sales (as a %).

SELECT Region, SUM(TotalAmount) AS RegionSales,
SUM(TotalAmount) * 100 / (SELECT SUM(TotalAmount) FROM RetailTransactions) AS Percentage
FROM RetailTransactions
GROUP BY Region;

-- Compare Online vs Offline sales across all months.

SELECT SalesChannel, MONTH(Date) AS Month, SUM(TotalAmount) AS TotalSales
FROM RetailTransactions GROUP BY SalesChannel, MONTH(Date)
ORDER BY Month;

-- Sales trend by Category – Which categories are rising/falling?

SELECT Category, SUM(TotalAmount) AS TotalSales, COUNT(*) AS TotalOrders
FROM RetailTransactions GROUP BY Category
ORDER BY TotalSales DESC;

--  List customers who purchased more than 10 times.

SELECT CustomerID, COUNT(*) AS PurchaseCount FROM RetailTransactions
GROUP BY CustomerID HAVING COUNT(*) > 10
ORDER BY PurchaseCount DESC;
