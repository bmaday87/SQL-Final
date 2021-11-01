/* ITEC2120 DB Design & SQL
Northwind SQL Lab
64 Points Possible

Write the SQL queries using the database defined.  Upload the .sql file to the appropriate drop box. */
use Northwind
-- Use Northwind Database
/* 1. For each product list its name, unit price, and how many units we have in stock. */
Select ProductName, UnitPrice, UnitsInStock
From Products;

/* 2.List the product name and units in stock for any product that has a units in stock greater than 10 and less than 50. */
Select ProductName, UnitsInStock
From Products
Where UnitsInStock > 10 and UnitsInStock < 50;

/* 3.List the product name, unit price for each product with a unit price greater than 
$100. Sort the list with the largest unit price on top. */
Select ProductName, UnitPrice
From Products
Where UnitPrice > 100
Order By UnitPrice Desc;

/*4. Create a list of products that should be re-ordered  (Note:  the products should not be discontinued 
(discontinued: 1=True; 0=False and total on hand and products on order should be less than the reorder level. */
Select ProductName, UnitsInStock, UnitsOnOrder, ReorderLevel
From Products
Where Discontinued = '0' and UnitsInStock + UnitsOnOrder < ReorderLevel;

/* 5.Create a list of products that have been discontinued */
Select ProductName, Discontinued
From Products
Where Discontinued = '1';

/* 6. Create a list of all the products (prod_id and name) if all the following are true    (7 
records)
		Supplierid = 2, 5, 16, 8, or 9
		Categoryid = 1, 2, or 4
		Unitprice > 15.00 */
Select ProductID, ProductName, SupplierID , CategoryID, UnitPrice
From Products
Where SupplierID IN	(2,5,16,8,9)
	and CategoryID IN (1,2,4)
	and UnitPrice > 15.00;

/* 7. Create a list of all the products (prod_id and name) if all the following are true    
(11 records)

		Supplierid = 2, 5, 16, 8, or 9 
		AND Categoryid = 1, 2, or 4 
		AND Unitprice > 15.00   
		OR Supplierid = 1, 4, 8 AND categoryid= 3 or 4  */
Select ProductID, ProductName, SupplierID , CategoryID, UnitPrice
From Products
Where SupplierID IN	(2,5,16,8,9)
	and CategoryID IN (1,2,4)
	and UnitPrice > 15.00
	OR SupplierID IN (1,4,8) AND CategoryID IN (3,4)
	
/* 8. Create a list of product names that have the second letter of the name = ‘h’ (8 
records) */
Select ProductName
From Products
WHERE ProductName LIKE ('_h%')

/* 9. Create a list of product names that have the second letter of the name = ‘a’ and the 
last letter = ‘e’  (2 records) */
Select ProductName
From Products
WHERE ProductName LIKE ('_a%e')

/* 10. List all the customers that have one of the following fields NULL (Region or Fax). 
Also the title of the contact should be ‘Owner’  Sort the list by contact name (14 records) */
SELECT ContactName, Region, Fax, ContactTitle
FROM Customers
WHERE (ContactTitle = 'Owner')
AND	(Region is null OR  Fax is null)
ORDER BY ContactName

/* 11. List each employee’s name (first and last in one column) and their birthdate. Sort 
the list by birthdate. */
SELECT trim(FirstName + LastName) as Name, BirthDate
FROM Employees
ORDER BY 2

/* 12. Which employees were born in 1963? */
SELECT trim(FirstName + LastName) as Name, BirthDate
FROM Employees
WHERE YEAR(BirthDate)=1963
ORDER BY 2

/* 13. How many employees does Northwind have? */
SELECT Count(EmployeeID) as NumberOfEmployees 
FROM Employees

/*14. For each customer (customer id) list the date of the first order they placed and the 
date of the last order they placed. */
SELECT Customers.CustomerID, MIN(OrderDate) AS FirstOrder, MAX(OrderDate) as LastOrder
FROM Customers JOIN Orders ON
	 Customers.CustomerID =
	 Orders.CustomerID
GROUP BY Customers.CustomerID

/* 15. Using question 14, only list customers where there last order was in 2011. Sort the 
list by customer. */
SELECT Customers.CustomerID, MAX(OrderDate) as LastOrderIn2011 
FROM Customers JOIN Orders ON
	 Customers.CustomerID =
	 Orders.CustomerID
WHERE YEAR(OrderDate)=2011
GROUP BY Customers.CustomerID

/* 16. Which employees were born in the month of July? */
SELECT trim(FirstName + LastName) as Name, BirthDate
FROM Employees
WHERE MONTH(BirthDate)=7
ORDER BY 2

/* 17. How many orders has Northwind taken? (Answer 830) */
SELECT COUNT(OrderID) AS OrdersTaken
FROM Orders

/* 18. How many orders were placed per year? */
SELECT YEAR(OrderDate) AS Year, COUNT(OrderID) as Orders
FROM Orders
GROUP BY YEAR(OrderDate)
ORDER BY 1

/* 19. How many orders by month for each year? Make sure the list is in order by year and month? */
SELECT YEAR(OrderDate) AS Year,MONTH(OrderDate) as Month, COUNT(OrderID) as Orders
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY 1

/* 20. Using question 19, list only the months where Northwind have less than 25 orders. (3 records) */
SELECT YEAR(OrderDate) AS Year,MONTH(OrderDate) as Month, COUNT(OrderID) as Orders
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
HAVING COUNT(OrderID) < 25
ORDER BY 1

/* 21. For each order detail, list the ordered, productid, and the total sale price */
SELECT COUNT(Quantity) AS Ordered, ProductID, SUM(UnitPrice) AS Total
FROM Order_Details
GROUP BY ProductID

/* 22. List the total amount of sales for all orders.*/
SELECT SUM(UnitPrice * Quantity) as TotalSales
FROM Order_Details

/* 23. For each order detail, list the orderid, productid, and the total sale price (include the discount). 
	HINT: If my quantity was 10, each one cost $20 and had a discount of 10%, my formula may appear as (10*(20*(1
-.10)) result would be 180. */
SELECT OrderID, ProductID, (UnitPrice-(UnitPrice*Discount))*Quantity AS TotalPrice 
FROM Order_Details
GROUP BY OrderID, ProductID, Quantity, UnitPrice, Discount

/* 24. List the total amount of sales for all orders. (with discounts included).  
	Result:  1265793.03974152 */
SELECT SUM((UnitPrice-(UnitPrice*Discount))*Quantity) AS TotalSales 
FROM Order_Details

/* 25. How old is each employee? List the oldest at the top of the list.  
HINT: Can use DateDiff(interval, date1, date2) function: DATEDIFF(dd, Birthdate, SYSDATETIME())/365 AS Age */
SELECT TRIM(FirstName +','+ LastName) AS Name
		,DATEDIFF(YEAR, BirthDate, GETDATE())
FROM Employees

/* 26. Create a list of suppliers (companyname, contactname) and the products (product name) they supply. 
Sort the list by supplier, then product (77 Records) */
SELECT DISTINCT CompanyName, ContactName, ProductName 
FROM Products JOIN Suppliers ON
		Products.SupplierID = Suppliers.SupplierID

/* 27. Create a list of customers (companyname) and some information about each order 
(orderid, orderdate, shipdate) they have placed. (830 Records) */
SELECT CompanyName, OrderID, OrderDate, ShippedDate 
FROM Customers JOIN Orders ON
		Customers.CustomerID = Orders.CustomerID

/* 28. Create list of products that were shipped to customers on 04/18/2012. (4 Records) */
SELECT PRODUCTS.ProductID, ProductName, CompanyName, ShippedDate
FROM	Products JOIN Order_Details ON
		Products.ProductID = Order_Details.ProductID
		JOIN Orders ON
		Order_Details.OrderID = Orders.OrderID
		JOIN Customers ON
		Customers.CustomerID = ORDERS.CustomerID
WHERE   ShippedDate = '04/18/2012'

/* 29. Create a list of customers that have ordered Tofu. Make sure to list each customer only once. (18 Records) */
SELECT  DISTINCT PRODUCTS.ProductID, ProductName, CompanyName
FROM	Products JOIN Order_Details ON
		Products.ProductID = Order_Details.ProductID
		JOIN Orders ON
		Order_Details.OrderID = Orders.OrderID
		JOIN Customers ON
		Customers.CustomerID = ORDERS.CustomerID
WHERE   ProductName = 'Tofu'

/*30. Create a list of customers that have placed and order in 2011 and 2012. Sort the list 
by customer contact. (65 Records) */
SELECT  ContactName, COUNT(OrderDate) AS Orders 
FROM	Customers JOIN Orders ON
		Customers.CustomerID = Orders.CustomerID
WHERE	OrderDate <= '12/31/2012' and OrderDate >= '01/01/2011'
group by ContactName
ORDER BY 1

/* 31. Create a mailing list to send information to all the customers, employees, and 
suppliers. Sort the list by city.  (129 records) */
SELECT TRIM(LastName + ',' + FirstName) AS Name, Address, City, Region, PostalCode, Country FROM Employees
UNION 
SELECT CompanyName, Address, City, Region, PostalCode, Country FROM Customers
UNION
SELECT CompanyName, Address, City, Region, PostalCode, Country FROM Suppliers
ORDER BY 3

/* 32. Create a view called NumCustomerOrders which lists all the customers and the 
number of orders they have placed. Be sure to list the customer even if they have 
not placed an order. (91 records) */

CREATE VIEW [NumCustomerOrders] AS
SELECT CompanyName, COUNT(OrderID) AS NumberOrders
FROM Customers LEFT JOIN Orders ON 
	 Customers.CustomerID = Orders.CustomerID
WHERE CompanyName IS NOT NULL
GROUP BY CompanyName

SELECT * FROM NumCustomerOrders
Order by NumberOrders
DROP VIEW NumCustomerOrders

CREATE VIEW NumCustomerOrders AS
SELECT Customers.CompanyName, COUNT(Orders.OrderId)
FROM Customers
    LEFT JOIN Orders ON Orders.CustomerId = Customers.CustomerID
WHERE    Orders.OrderID IS NULL
GROUP BY Customers.CustomerID;