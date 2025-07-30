-- 1
SELECT p.ProductID, p.Name, p.Color, p.ListPrice
FROM Production.Product as p;
-- 2
SELECT p.ProductID, p.Name, p.Color, p.ListPrice
FROM Production.Product as p
WHERE p.ListPrice != 0;
-- 3
SELECT p.ProductID, p.Name, p.Color, p.ListPrice
FROM Production.Product as p
WHERE p.Color IS NULL
-- 4
SELECT p.ProductID, p.Name, p.Color, p.ListPrice
FROM Production.Product as p
WHERE p.Color IS NOT NULL
-- 5
SELECT p.ProductID, p.Name, p.Color, p.ListPrice
FROM Production.Product as p
WHERE p.Color IS NOT NULL AND p.ListPrice > 0;
-- 6
SELECT p.Name + ' ' + p.Color AS ProductWithColor
FROM Production.Product as p
WHERE p.Color IS NOT NULL;
-- 7
SELECT 'Name: ' + p.Name + ' -- COLOR:' + p.Color AS Result
FROM Production.Product as p
WHERE p.Name IN (
        'LL Crankarm',
        'ML Crankarm',
        'HL Crankarm',
        'Chainring Bolts',
        'Chainring Nut',
        'Chainring'
    );
-- 8
SELECT p.ProductID, p.Name
FROM Production.Product as p
WHERE p.ProductID BETWEEN 400 AND 500;
-- 9
SELECT p.ProductID, p.Name, p.Color
FROM Production.Product as p
WHERE p.Color = 'Black' OR p.Color = 'Blue'
-- 10
SELECT *
FROM Production.Product
WHERE Name LIKE 'S%';
-- 11
SELECT p.Name, ListPrice
FROM Production.Product as p
WHERE p.Name LIKE 'Seat%' OR p.Name LIKE 'Short-Sleeve Classic Jersey, L%' OR p.Name LIKE 'Short-Sleeve Classic Jersey, M%'
ORDER BY p.Name;
-- 12
SELECT p.Name, ListPrice
FROM Production.Product as p
WHERE p.Name LIKE 'A%' OR p.Name LIKE 'Seat L%' OR p.Name LIKE 'Seat P%'
ORDER BY p.Name;
-- 13
SELECT p.Name
FROM Production.Product as p
WHERE p.Name LIKE 'SPO%' 
AND p.Name NOT LIKE 'SPOK%'
ORDER BY p.Name;
-- 14
SELECT DISTINCT p.Color
FROM Production.Product as p
WHERE p.Color IS NOT NULL
ORDER BY p.Color;


