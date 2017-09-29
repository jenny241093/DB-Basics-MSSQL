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
SELECT*FROM Games
SELECT TOP(50) Name,FORMAT(Start,'yyyy-MM-dd')AS Start FROM Games
WHERE YEAR(Start) BETWEEN 2011 AND 2012
ORDER BY Start, Name
---Problem 13.	 User Email Providers
SELECT*FROM Users
SELECT Username, SUBSTRING(Email,CHARINDEX('@',Email)+1,LEN(Email)) AS [Email Provider]FROM Users
ORDER BY [Email Provider],Username

---Problem 14.	 Get Users with IPAdress Like Pattern
SELECT Username, IpAddress FROM Users
WHERE IpAddress LIKE '___.1%.%.___'
ORDER BY Username

---Problem 15.Show All Games with Duration and Part of the Day
SELECT [Name] AS Game, 
	CASE 
		WHEN  DATEPART(HOUR,Start) BETWEEN 0 AND 11 THEN 'Morning'
		WHEN  DATEPART(HOUR,Start )BETWEEN 12 AND 17 THEN 'Afternoon' 
		WHEN  DATEPART(HOUR, Start) BETWEEN 18 AND 23 THEN 'Evening'  
	END AS [Part of the Day],
	CASE 
	WHEN Duration <=3 THEN 'Extra Short'
	WHEN Duration BETWEEN 4 AND 6 THEN 'Short'	
	WHEN Duration >6 THEN 'Long'
	ELSE 'Extra Long'
END AS[Duration]
FROM Games 
ORDER BY Game,Duration,[Part of the Day]
---Problem 16.	 Orders Table

SELECT ProductName,OrderDate,DATEADD(DAY,3,OrderDate)AS [Pay Due],DATEADD(MONTH,1,OrderDate) AS[Deliver Due] FROM Orders

---Problem 17.   People Table
CREATE TABLE People
(
Id INT PRIMARY KEY IDENTITY,
Name VARCHAR(50)NOT NULL,
Birthdate DATETIME NOT NULL
)
--Write a query to find age in years,
--- months, days and minutes for each person
-- for the current time of executing the query.
INSERT INTO People
VALUES
('Victor','2000-12-07'),
('Steven','1992-09-10'),
('Stephen','1910-09-19'),
('John','2010-01-06')

SELECT Name ,DATEDIFF(Year, Birthdate,GETDATE()) AS [Age in Years],
       DATEDIFF(DAY, Birthdate,GETDATE()) AS [Age in Days],
       DATEDIFF(MINUTE, Birthdate,GETDATE()) AS [Age in Minutes],
 * FROM People