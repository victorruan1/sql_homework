--Can find 504 products in the Production.Product table
SELECT COUNT(*) AS TotalProducts
FROM Production.Product;

SELECT COUNT(p.ProductSubcategoryID) as ProductsWithSubcategory
FROM Production.Product as p
WHERE p.ProductSubcategoryID IS NOT NULL;

SELECT ProductSubcategoryID AS ProductSubcategoryID, COUNT(*) AS CountedProducts
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID;

--209 Products without sub category
SELECT COUNT(*) AS ProductsWithoutSubcategory
FROM Production.Product
WHERE ProductSubcategoryID IS NULL;

SELECT SUM(Quantity) AS TotalQuantity
FROM Production.ProductInventory;

SELECT pi.ProductID AS ProductID, SUM(Quantity) as TheSum
FROM Production.ProductInventory as pi
WHERE pi.LocationID = 40
GROUP BY ProductID
HAVING SUM(Quantity) < 100;

SELECT AVG(Quantity) as Average
FROM Production.ProductInventory as pi
WHERE pi.LocationID = 10

SELECT pi.ProductID AS ProductID, pi.Shelf as Shelf, AVG(Quantity) as TheAvg
FROM Production.ProductInventory as pi
GROUP BY ProductID, Shelf

SELECT pi.ProductID AS ProductID, pi.Shelf as Shelf, AVG(Quantity) as TheAvg
FROM Production.ProductInventory as pi
WHERE pi.Shelf != 'N/A'
GROUP BY ProductID, Shelf

SELECT p.Color AS Color, p.Class as Class, COUNT(*) AS TheCount, AVG(StandardCost) as AvgPrice
FROM Production.Product as p
WHERE Color IS NOT NULL AND Class IS NOT NULL
GROUP BY Color, Class


SELECT CR.Name as Country, SP.Name as Province
FROM Person.CountryRegion as CR JOIN Person.StateProvince as SP ON CR.CountryRegionCode = SP.CountryRegionCode

SELECT CR.Name AS Country, SP.Name AS Province
FROM Person.StateProvince SP JOIN Person.CountryRegion CR ON SP.CountryRegionCode = CR.CountryRegionCode
WHERE CR.Name IN ('Germany', 'Canada');



SELECT p.ProductID, p.ProductName
FROM dbo.Products p
JOIN dbo.[Order Details] od ON p.ProductID = od.ProductID
JOIN dbo.Orders o ON od.OrderID = o.OrderID
WHERE o.OrderDate >= '1998-01-01'


SELECT TOP 5 c.PostalCode AS ZipCode, SUM(od.Quantity) AS TotalQuantitySold
FROM dbo.[Order Details] od
JOIN dbo.Orders o ON od.OrderID = o.OrderID
JOIN dbo.Customers c ON o.CustomerID = c.CustomerID
WHERE c.PostalCode IS NOT NULL
GROUP BY c.PostalCode
ORDER BY TotalQuantitySold DESC;


SELECT TOP 5 c.PostalCode AS ZipCode, SUM(od.Quantity) AS TotalQuantitySold
FROM dbo.[Order Details] od
JOIN dbo.Orders o ON od.OrderID = o.OrderID
JOIN dbo.Customers c ON o.CustomerID = c.CustomerID
WHERE c.PostalCode IS NOT NULL AND o.OrderDate >= '1998-01-01'
GROUP BY c.PostalCode
ORDER BY TotalQuantitySold DESC;


SELECT City, COUNT(*) AS CustomerCount
FROM dbo.Customers
WHERE City IS NOT NULL
GROUP BY City


SELECT City, COUNT(*) AS CustomerCount
FROM dbo.Customers
WHERE City IS NOT NULL
GROUP BY City
HAVING COUNT(*) > 2

SELECT c.ContactName AS CustomerName, o.OrderDate
FROM dbo.Customers c
JOIN dbo.Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderDate > '1998-01-01'
ORDER BY o.OrderDate;


SELECT c.ContactName AS CustomerName, o.OrderDate
FROM dbo.Customers c JOIN dbo.Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderDate = (
  SELECT MAX(o2.OrderDate)
  FROM dbo.Orders o2
  WHERE o2.CustomerID = c.CustomerID
);


SELECT c.ContactName, SUM(od.Quantity) AS ProductsBought
FROM dbo.[Order Details] od
JOIN dbo.Orders o ON od.OrderID = o.OrderID
JOIN dbo.Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.ContactName

SELECT c.CustomerID, SUM(od.Quantity) AS CountOfProducts
FROM dbo.[Order Details] od
JOIN dbo.Orders o ON od.OrderID = o.OrderID
JOIN dbo.Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID
HAVING SUM(od.Quantity)>100

SELECT DISTINCT s.CompanyName AS [Supplier Company Name], sh.CompanyName AS [Shipping Company Name]
FROM dbo.Suppliers s
JOIN dbo.Products p ON s.SupplierID = p.SupplierID
JOIN dbo.[Order Details] od ON p.ProductID = od.ProductID
JOIN dbo.Orders o ON od.OrderID = o.OrderID
JOIN dbo.Shippers sh ON o.ShipVia = sh.ShipperID;


SELECT o.OrderDate, p.ProductName
FROM dbo.Orders o
JOIN dbo.[Order Details] od ON o.OrderID = od.OrderID
JOIN dbo.Products p ON od.ProductID = p.ProductID
ORDER BY o.OrderDate;

SELECT e1.FirstName + ' ' + e1.LastName as Employee1, e2.FirstName + ' ' + e2.LastName as Employee2, e1.Title 
FROM dbo.Employees as e1 JOIN dbo.Employees as e2 ON e1.Title = e2.Title
WHERE e1.EmployeeID != e2.EmployeeID

SELECT e.EmployeeID as ManagerID, e.FirstName, COUNT(e.EmployeeID) as ReportCount
FROM dbo.Employees as e JOIN dbo.Employees as e2 ON e.ReportsTo = e2.EmployeeID
GROUP BY e.EmployeeID, e.FirstName
HAVING COUNT (e.EmployeeID) > 2


SELECT c.City, c.companyName AS Name, c.ContactName, 'Customer' AS Type
FROM dbo.Customers as c
WHERE c.City IS NOT NULL
UNION 
SELECT s.City, s.CompanyName AS Name, s.ContactName, 'Supplier' AS Type
FROM dbo.Suppliers as s
WHERE City IS NOT NULL
ORDER BY City, Type, Name;






