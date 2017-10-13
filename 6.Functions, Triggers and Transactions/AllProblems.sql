--Part I – Queries for SoftUni Database
--Problem 1.	Employees with Salary Above 35000
USE SoftUni
GO
CREATE PROC usp_GetEmployeesSalaryAbove35000 (@FirstName)
AS 
SELECT FirstName,LastName FROM Employees
WHERE Salary>35000
EXEC usp_GetEmployeesSalaryAbove35000


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