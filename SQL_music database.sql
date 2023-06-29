--Q1) Find all the tracks that have a length of 5,000,000 milliseconds or more.

SELECT COUNT(TrackId)
FROM TRACKS
WHERE Milliseconds >= 5000000

------------------------------------------------------------------------------------

--Q2) Find all the invoices whose total is between $5 and $15 dollars.

SELECT InvoiceID,Total
FROM Invoices
WHERE Total > 5 AND Total < 15

------------------------------------------------------------------------------------

--Q3) Find all the customers from the following States: RJ, DF, AB, BC, CA, WA, NY.

SELECT FirstName, LastName, Company, State
FROM Customers
WHERE State IN ('RJ','DF','AB','BC','CA','WA','NY')

------------------------------------------------------------------------------------

--Q4) Find all the invoices for customer 56 and 58 where the total was between 
-- $1.00 and $5.00.

SELECT CustomerId, InvoiceId, Total, InvoiceDate
FROM Invoices
WHERE CustomerID IN (56,58) AND 
Total BETWEEN 1 AND 5

------------------------------------------------------------------------------------

--Q5) Find all the tracks whose name starts with 'All'.

SELECT TrackId, Name
FROM Tracks
WHERE Name LIKE 'All%'

------------------------------------------------------------------------------------

--Q6) Find all the customer emails that start with "J" and are from gmail.com.

SELECT CustomerId, Email
FROM Customers
WHERE Email LIKE "J%@gmail.com"

------------------------------------------------------------------------------------

--Q7) Find all the invoices from Brasilia, Edmonton, and Vancouver and sort in 
-- descending order by invoice ID.

SELECT InvoiceId, BillingCity, Total
FROM Invoices
WHERE BillingCity IN ('Brasilia','Edmonton','Vancouver')
ORDER BY InvoiceId DESC

------------------------------------------------------------------------------------

--Q8) Show the number of orders placed by each customer and sort the result by
-- the number of orders in descending order.

SELECT CustomerId, COUNT(*) AS Orders
FROM Invoices
GROUP BY CustomerId
ORDER BY Orders DESC

------------------------------------------------------------------------------------

--Q9) Find the albums with 12 or more tracks.

SELECT AlbumId, Count(*) AS Ntracks
FROM Tracks
GROUP BY AlbumId
HAVING COUNT (*) >= 12

------------------------------------------------------------------------------------


-- Q10) Pull a list of customer ids with the customer’s full name, and address,
-- along with combining their city and country together. Be sure to make a
-- space in between these two and make it UPPER CASE.

SELECT CustomerId,
       FirstName || " " || LastName AS FullName,
       Address,
       UPPER(City || " " || Country) AS CityCountry
FROM Customers

------------------------------------------------------------------------------------
-- Q11) Create a new employee user id by combining the first 4 letter of the
-- employee’s first name with the first 2 letters of the employee’s last name. 
-- Make the new field lower case and pull each individual step to show your work.

SELECT FirstName,
       LastName,
       LOWER(SUBSTR(FirstName,1,4)) AS A,
       LOWER(SUBSTR(LastName,1,2)) AS B,
       LOWER(SUBSTR(FirstName,1,4)) || LOWER(SUBSTR(LastName,1,2)) AS userId
FROM Employees

------------------------------------------------------------------------------------
-- Q12) Show a list of employees who have worked for the company for 15 or more 
-- years using the current date function. Sort by lastname ascending.

SELECT FirstName,
       LastName,
       HireDate,
       (STRFTIME('%Y', 'now') - STRFTIME('%Y', HireDate)) 
          - (STRFTIME('%m-%d', 'now') < STRFTIME('%m-%d', HireDate)) 
          AS YearsWorked
FROM Employees
WHERE YearsWorked >= 15
ORDER BY LastName ASC

------------------------------------------------------------------------------------
-- Q13) Profiling the Customers table, answer the following question.

SELECT COUNT(*)
FROM Customers
WHERE [some_column] IS NULL

-- some_column: FirstName, PostalCode, Company, Fax, Phone, Address
-- Answers: Postal Code, Company, Fax, Phone

------------------------------------------------------------------------------------
-- Q14) Find the cities with the most customers and rank in descending order.

SELECT City,
       COUNT(*)
FROM Customers
GROUP BY City
ORDER BY COUNT(*) DESC

------------------------------------------------------------------------------------
-- Q15) Create a new customer invoice id by combining a customer’s invoice id with
-- their first and last name while ordering your query in the following order:
-- firstname, lastname, and invoiceID.

SELECT C.FirstName,
       C.LastName,
       I.InvoiceId,
       C.FirstName || C.LastName || I.InvoiceID AS NewId
FROM Customers C INNER JOIN Invoices I
ON C.CustomerId = I.CustomerID
WHERE NewId LIKE 'AstridGruber%'