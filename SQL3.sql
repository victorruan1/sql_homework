
SELECT DISTINCT c.City
FROM dbo.EMPLOYEES as e JOIN dbo.CUSTOMERS as c ON e.City = c.city 
WHERE c.City IS NOT NULL;


--2.a
SELECT DISTINCT c.City
FROM dbo.CUSTOMERS as c
WHERE c.City IS NOT NULL AND c.City NOT IN (
    SELECT DISTINCT e.City FROM dbo.EMPLOYEES as e WHERE e.City IS NOT NULL
)

--2.b
SELECT DISTINCT c.City
FROM dbo.CUSTOMERS as c LEFT JOIN dbo.EMPLOYEES as e ON c.City = e.city 
WHERE c.City IS NOT NULL;

SELECT p.ProductName, SUM(od.Quantity) AS TotalOrderedQuantity
FROM dbo.Products p
LEFT JOIN dbo.[Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductName


SELECT c.City AS CustomerCity, SUM(od.Quantity) AS TotalProductsOrdered
FROM dbo.Customers c
JOIN dbo.Orders o ON c.CustomerID = o.CustomerID
JOIN dbo.[Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.City

SELECT c.City AS CustomerCity, COUNT(*) AS NumCustomers
FROM dbo.Customers c
GROUP BY c.City
HAVING COUNT(*)>=2

SELECT c.City AS CustomerCity, COUNT(DISTINCT od.ProductID) AS TotalUniqueProducts
FROM dbo.Customers c
JOIN dbo.Orders o ON c.CustomerID = o.CustomerID
JOIN dbo.[Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.City
HAVING COUNT(DISTINCT od.ProductID)>=2

SELECT c.CompanyName, c.City AS CustomerCity, o.ShipCity AS OrderShipCity
FROM dbo.Customers c
JOIN dbo.Orders o ON c.CustomerID = o.CustomerID
WHERE o.ShipCity != c.City


SELECT TOP 5 p.ProductName, AVG(od.UnitPrice) AS AvgPrice, c.City AS TopCity, SUM(od.Quantity) AS TotalQuantity
FROM dbo.[Order Details] od
JOIN dbo.Products p ON od.ProductID = p.ProductID
JOIN dbo.Orders o ON od.OrderID = o.OrderID
JOIN dbo.Customers c ON o.CustomerID = c.CustomerID
GROUP BY p.ProductName, c.City
ORDER BY TotalQuantity DESC;


--9.a
SELECT e.City
FROM dbo.Employees e
WHERE e.City NOT IN (
      SELECT c.City
      FROM dbo.Customers c
      JOIN dbo.Orders o ON c.CustomerID = o.CustomerID
      WHERE c.City IS NOT NULL
  );


--9.b
SELECT e.City
FROM dbo.Employees e
LEFT JOIN dbo.Customers c ON e.City = c.City
LEFT JOIN dbo.Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL 

--10
SELECT TOP 1 e.City AS EmployeeCity, COUNT(*) AS TotalOrders
INTO #TopEmpCity
FROM dbo.Orders o
JOIN dbo.Employees e ON o.EmployeeID = e.EmployeeID
GROUP BY e.City
ORDER BY TotalOrders DESC
--10
SELECT TOP 1 c.City AS CustomerCity, SUM(od.Quantity) AS TotalQuantity
INTO #TopCustCity
FROM dbo.[Order Details] od
JOIN dbo.Orders o ON od.OrderID = o.OrderID
JOIN dbo.Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.City
ORDER BY TotalQuantity DESC
--10
SELECT 
    ec.TotalOrders,
    cc.TotalQuantity
FROM #TopEmpCity ec
CROSS JOIN #TopCustCity cc;

--11. Use primary key or unique constraint. These constraints automatically prevent duplicate rows.

