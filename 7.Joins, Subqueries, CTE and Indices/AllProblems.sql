--Problem 1.	Employee Address
SELECT TOP 5 EmployeeID,JobTitle,emp.AddressID,AddressText FROM Employees AS emp
 JOIN Addresses  AS ad
ON emp.AddressID=ad.AddressID
ORDER BY AddressID 
--Problem 2.	Addresses with Towns
SELECT TOP 50 FirstName,LastName,t.Name as Town,a.AddressText
 FROM Employees AS e
 JOIN Addresses AS a ON e.AddressID=a.AddressID
 JOIN Towns AS t ON a.TownID=t.TownID
 ORDER BY FirstName,LastName
 --Problem 3.	Sales Employee
 SELECT EmployeeId,FirstName,LastName,d.Name as DepartmentName
 FROM Employees AS e
 JOIN Departments AS d ON e.DepartmentID=d.DepartmentID 
 WHERE d.Name='Sales'
 ORDER BY EmployeeID

 --Problem 4.	Employee Departments
 SELECT TOP 5 EmployeeId,FirstName,Salary,d.Name
 AS DeprtmentName
 FROM Employees AS e
 JOIN  Departments as d ON e.DepartmentID=d.DepartmentID
 WHERE Salary > 15000
 ORDER BY d.DepartmentID

 --Problem 5.	Employees Without Project
 SELECT TOP 3 e.EmployeeID,e.FirstName FROM Employees
 AS e
LEFT JOIN EmployeesProjects AS ep ON ep.EmployeeID=e.EmployeeID
WHERE ep.EmployeeID IS NULL
ORDER BY ep.EmployeeID

--Problem 6.	Employees Hired After
SELECT e.FirstName,e.LastName,e.HireDate,
d.Name AS DeptName 
FROM Employees AS e
RIGHT JOIN Departments AS d ON e.DepartmentID=d.DepartmentID
WHERE e.HireDate>'1/1/1999' AND d.Name='Sales' OR d.Name ='Finance'
ORDER BY HireDate

--Problem 7.	Employees with Project
 SELECT TOP 5 e.EmployeeID,e.FirstName,p.Name AS ProjectName
FROM Employees AS e
JOIN EmployeesProjects AS ep ON ep.EmployeeID=e.EmployeeID
JOIN Projects AS p ON p.ProjectID=ep.ProjectID 
 WHERE p.StartDate >'2002-08-12' AND
 p.EndDate IS NULL
ORDER BY e.EmployeeID

--Problem 8.	Employee 24
SELECT  e.EmployeeID,e.FirstName,IIF(p.StartDate > '2005-01-01', NULL, p.Name) AS ProjectName 
FROM Employees AS e
JOIN EmployeesProjects AS ep ON ep.EmployeeID=e.EmployeeID
JOIN Projects AS p ON p.ProjectID=ep.ProjectID
WHERE e.EmployeeID=24
--Problem 9.	Employee Manager
SELECT e.EmployeeID,e.FirstName,e.ManagerID,d.FirstName
AS ManagerName 
FROM Employees AS e
JOIN Employees AS d ON d.EmployeeID=e.ManagerID
WHERE e.ManagerID IN (3,7)
ORDER BY e.EmployeeID

--Problem 10.	Employee Summary
SELECT TOP 50 e.EmployeeID,e.FirstName + ' ' + e.LastName AS EmployeeName,m.FirstName+ ' '+m.LastName AS ManagerName,d.Name
AS DepartmentName 
FROM Employees AS e
JOIN Employees AS m ON m.EmployeeID=e.ManagerID
JOIN Departments AS d ON d.DepartmentID = e.DepartmentID
ORDER BY e.EmployeeID

--Problem 11.	Min Average Salary
SELECT TOP 1 AVG(Salary) AS MinAverageSalary
FROM Employees
GROUP BY DepartmentID
ORDER BY MinAverageSalary
USE SoftUni
SELECT MIN(AverageSalary)FROM
(SELECT AVG(e.Salary) AS AverageSalary FROM Employees AS e
GROUP BY DepartmentID)as AvgSalary


--Problem 12.	Highest Peaks in Bulgaria
USE Geography
SELECT mc.CountryCode,m.MountainRange,p.PeakName,p.Elevation
FROM Peaks AS p
JOIN Mountains AS m ON m.Id=p.MountainId
JOIN MountainsCountries AS mc ON mc.MountainId=m.Id
WHERE p.Elevation>2835 AND mc.CountryCode='BG'
ORDER BY Elevation DESC
--Problem 13.	Count Mountain Ranges
SELECT mc.CountryCode,Count(MountainRange) AS MountainRanges
FROM Mountains AS m
JOIN MountainsCountries AS mc ON mc.MountainId=m.ID
WHERE mc.CountryCode IN ('BG','US','RU')
GROUP BY CountryCode

--Problem 14.	Countries with Rivers
SELECT TOP 5 c.CountryName,r.RiverName FROM Countries AS c
JOIN Continents AS cont ON cont.ContinentCode = c.ContinentCode
LEFT JOIN CountriesRivers AS cr ON cr.CountryCode=c.CountryCode
LEFT JOIN Rivers AS r ON r.Id=cr.RiverId
WHERE cont.ContinentName='Africa'
ORDER BY c.CountryName

--Problem 15.	*Continents and Currencies
WITH CCYContUsage_CTE(ContinentCode,CurrencyCode,CurrencyUsage) AS
(SELECT ContinentCode, CurrencyCode,COUNT(CurrencyCode) AS CurrencyUsage
FROM Countries
GROUP BY ContinentCode,CurrencyCode
HAVING COUNT(CountryCode)>1
)

SELECT ContMax.ContinentCode,CurrencyCode,ContMax.CurrencyUsage
FROM
(
SELECT ContinentCode,MAX(CurrencyUsage) AS CurrencyUsage
FROM CCYContUsage_CTE
GROUP BY ContinentCode) AS ContMax
JOIN CCYContUsage_CTE AS ccy ON
(ContMax.ContinentCode=ccy.ContinentCode AND ContMax.CurrencyUsage=ccy.CurrencyUsage)
ORDER BY ContMax.ContinentCode


--SecondWay

SELECT ContinentCode,CurrencyCode,CurrencyUsage
FROM(
SELECT ContinentCode,CurrencyCode,CurrencyUsage,
DENSE_RANK()OVER(PARTITION BY (ContinentCode)ORDER BY CurrencyUsage DESC)
 AS [RANK] 
FROM
(SELECT ContinentCode,CurrencyCode, COUNT(CurrencyCode)
AS CurrencyUsage FROM Countries
GROUP BY CurrencyCode,ContinentCode)AS currencies)
AS RankedCurrencies
WHERE [RANK] = 1 AND CurrencyUsage>1
ORDER BY ContinentCode


--Problem 16.	Countries without any Mountains
SELECT COUNT(CountryName) AS CountryCode FROM
(SELECT CountryName ,MountainRange FROM Countries  AS c
LEFT JOIN MountainsCountries AS mc ON mc.CountryCode=c.CountryCode
LEFT JOIN Mountains AS m ON m.Id=mc.MountainId
WHERE MountainRange IS NULL)AS CountMountains

---Problem 17 
SELECT TOP 5 c.CountryName,MAX(p.Elevation) AS HighestPeakElevation,MAX(r.Length) AS LongestRiverLength FROM Countries AS c
LEFT JOIN MountainsCountries AS mc ON mc.CountryCode=c.CountryCode
LEFT JOIN Peaks AS p ON p.MountainId=mc.MountainId 
LEFT JOIN CountriesRivers AS cr ON cr.CountryCode=c.CountryCode
LEFT JOIN Rivers AS r ON r.Id=cr.RiverId
GROUP BY c.CountryName
ORDER BY HighestPeakElevation DESC,
LongestRiverLength DESC,
c.CountryName

--Problem 18.	* Highest Peak Name and Elevation by Country

SELECT TOP 5 CountryName, 
CASE  WHEN PeakName IS NULL THEN '(no highest peak)' 
ELSE PeakName 
END AS [Highest Peak Name],
       CASE WHEN Elevation IS NULL THEN 0
       ELSE Elevation
END AS[Highest Peak Elevation],
       CASE WHEN MountainRange IS NULL THEN '(no mountain)'
       ELSE MountainRange
END AS Mountain
FROM 
(SELECT CountryName,PeakName,Elevation,MountainRange,
DENSE_RANK()OVER (PARTITION BY CountryName ORDER BY Elevation DESC)
 AS [Rank]
FROM
   (SELECT c.CountryName,p.PeakName,p.Elevation,m.MountainRange
   FROM Countries AS c
    LEFT JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
   LEFT JOIN Mountains AS m ON mc.MountainId=m.Id
 LEFT JOIN Peaks AS p ON p.MountainId=m.Id)
 AS allpeaks) 
 AS rankedPeaks
WHERE [Rank]=1
ORDER BY CountryName,[Highest Peak Name]