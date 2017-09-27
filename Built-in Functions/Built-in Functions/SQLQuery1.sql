---Problem 1.	Find Names of All Employees by First Name
SELECT FirstName,LastName FROM Employees
WHERE FirstName LIKE 'Sa%' 
---02. Find Names of All Employees by Last Name

SELECT FirstName,LastName FROM Employees
WHERE LastName LIKE '%ei%' 
---Problem 3.	Find First Names of All Employees

SELECT FirstName FROM Employees
WHERE (HireDate>=1995 OR HireDate<=2005) AND DepartmentID IN (3,10)
---Problem 4.	Find All Employees Except Engineers
SELECT FirstName,LastName FROM Employees
WHERE  JobTitle NOT LIKE '%engineer%'

---Problem 5.	Find Towns with Name Length
SELECT Name FROM Towns
WHERE LEN(Name)=5 OR LEN(Name)=6
ORDER BY Name
--Problem 6.	 Find Towns Starting With

SELECT TownID,Name FROM Towns
WHERE Name LIKE 'M%'OR Name LIKE 'K%' OR Name Like 'B%' OR Name LIKE 'E%'
ORDER BY Name

---Problem 7.	 Find Towns Not Starting With
SELECT TownID,Name FROM Towns
WHERE Name NOT LIKE 'R%'AND Name NOT LIKE 'B%' AND Name NOT Like 'D%'
ORDER BY Name
---Problem 8.	Create View Employees Hired After 2000 Year
GO
CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT FirstName,LastName FROM Employees
WHERE HireDate>'2001'
GO
SELECT FirstName,LastName FROM V_EmployeesHiredAfter2000
---Problem 9.	Length of Last Name
SELECT FirstName,LastName FROM Employees
WHERE LEN(LastName)=5

---Problem 10.	Countries Holding ‘A’ 3 or More Times
SELECT CountryName,IsoCode FROM Countries
WHERE CountryName LIKE '%a%a%a%'
ORDER BY IsoCode

---Problem 11.	 Mix of Peak and River Names
SELECT PeakName,RiverName,
LOWER(PeakName+RIGHT(RiverName,LEN(RiverName)-1))AS Mix FROM Rivers,Peaks
WHERE RIGHT(PeakName,1)=LEFT(RiverName,1)
ORDER BY Mix
---Problem 12.	Games from 2011 and 2012 year

SELECT TOP (50) Name,Start FROM Games
WHERE Start BETWEEN 2011 AND 2012
