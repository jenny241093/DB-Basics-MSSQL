--Part I – Queries for SoftUni Database
--Problem 1.	Employees with Salary Above 35000
USE SoftUni
GO
CREATE PROC usp_GetEmployeesSalaryAbove35000 
AS 
SELECT FirstName,LastName FROM Employees
WHERE Salary>35000
EXEC usp_GetEmployeesSalaryAbove35000
GO
--Problem 2. Employees with Salary Above Number
CREATE PROC usp_GetEmployeesSalaryAboveNumber(@SalaryBound DECIMAL (18,4))
AS 
BEGIN
SELECT FirstName,LastName FROM Employees
WHERE Salary>=@SalaryBound
END
EXEC usp_GetEmployeesSalaryAboveNumber 48100


GO
--Problem 3. Town Names Starting With

CREATE PROC usp_GetTownsStartingWith (@TownName VARCHAR(50))
AS
BEGIN
SELECT [Name] FROM Towns
WHERE [Name] LIKE @TownName+'%'
END
EXEC usp_GetTownsStartingWith 'b'

--Problem 4. Employees from Town
GO
CREATE PROC usp_GetEmployeesFromTown (@TownName VARCHAR(50))
AS 
BEGIN
SELECT FirstName,LastName FROM Employees AS e
JOIN Addresses AS a ON a.AddressID=e.AddressID
JOIN Towns AS t ON t.TownID=a.TownID
WHERE t.Name=@TownName
END
EXEC usp_GetEmployeesFromTown Sofia

--Problem 5. Salary Level Function

GO 
CREATE FUNCTION ufn_GetSalaryLevel(@Salary DECIMAL(18,4))
RETURNS NVARCHAR(10)
AS 
BEGIN
DECLARE @SalaryLevel VARCHAR(10)
IF (@Salary < 30000)
  SET @SalaryLevel = 'Low'
ELSE IF(@Salary >= 30000 AND @Salary <= 50000)
  SET @SalaryLevel = 'Average'
ELSE
  SET @SalaryLevel = 'High'
RETURN @SalaryLevel
END

SELECT Salary,dbo.ufn_GetSalaryLevel(Salary)
AS [Salary Level]
FROM SoftUni.[dbo].[Employees]

--Problem 6. Employees by Salary Level
GO
CREATE  PROC usp_EmployeesBySalaryLevel (@SalaryLevel NVARCHAR(10))
AS 
SELECT FirstName,LastName FROM Employees
AS e
WHERE dbo.ufn_GetSalaryLevel(Salary)=@SalaryLevel 

EXEC dbo.usp_EmployeesBySalaryLevel 'Low'

--Problem 7. Define Function
GO
CREATE  FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(50), @word VARCHAR(50))
RETURNS BIT
AS
BEGIN
       DECLARE @i INT=0;
       WHILE (@i<LEN(@word))
       BEGIN
           DECLARE @substring VARCHAR(50)
		   SET @substring=LEFT(RIGHT(@word,LEN(@word)-@i),1)
		   IF (CHARINDEX(@substring,@setOfLetters)<1)
		   BEGIN
		   RETURN 0
		   END
		   SET @i+=1
       END
	   RETURN 1
END

SELECT  dbo.ufn_IsWordComprised('oistmiahf','Sofia') AS Result
--SECOND WAY

CREATE OR ALTER FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(50), @word VARCHAR(50))
RETURNS BIT
AS
BEGIN
  DECLARE @currentLetter CHAR;
  DECLARE @counter INT=1;
  WHILE(LEN(@word)>=@counter)
  BEGIN
     SET @currentLetter=SUBSTRING(@word,@counter,1)
	 DECLARE @match INT=CHARINDEX(@currentLetter,@setOfLetters)
	 IF (@match=0)
	 BEGIN
	 RETURN 0 ;
	 END;
	  SET @counter+=1
   END;
   RETURN 1;
END;
SELECT  dbo.ufn_IsWordComprised('oistmiahf','Sofia') AS Result
--Problem 8. * Delete Employees and Departments



CREATE OR ALTER PROC usp_DeleteEmployeesFromDepartment (@departmentId INT)
AS
ALTER TABLE Departments
ALTER COLUMN ManagerID INT NULL

DELETE FROM EmployeesProjects
WHERE EmployeeID IN (
						SELECT EmployeeID FROM Employees
						WHERE DepartmentID = @departmentId
					)

UPDATE Employees
SET ManagerID = NULL
WHERE ManagerID IN (
						SELECT EmployeeID FROM Employees
						WHERE DepartmentID = @departmentId
				   )


UPDATE Departments
SET ManagerID = NULL
WHERE ManagerID IN (
						SELECT EmployeeID FROM Employees
						WHERE DepartmentID = @departmentId
				   )

DELETE FROM Employees
WHERE EmployeeID IN (
						SELECT EmployeeID FROM Employees
						WHERE DepartmentID = @departmentId
				    )

DELETE FROM Departments
WHERE DepartmentID = @departmentId
SELECT COUNT(*) AS [Employees Count] FROM Employees AS e
JOIN Departments AS d
ON d.DepartmentID = e.DepartmentID
WHERE e.DepartmentID = @departmentId

--PART II – Queries for Bank Database
--Problem 9. Find Full Name
--You are given a database schema with tables AccountHolders(Id (PK), FirstName, LastName, SSN) and Accounts(Id (PK), AccountHolderId (FK), Balance). 
 --Write a stored procedure usp_GetHoldersFullName that selects the full names of all people. 
 GO
CREATE PROC usp_GetHoldersFullName
AS
SELECT FirstName + ' ' + LastName FROM AccountHolders AS [Full Name]

EXEC usp_GetHoldersFullName

--Problem 10. People with Balance Higher Than

--Your task is to create a stored procedure usp_GetHoldersWithBalanceHigherThan
 --that accepts a number as a parameter and returns all people who have more money
  --in total of all their accounts than the supplied number, ordered by Last Name.
  GO
  CREATE PROC usp_GetHoldersWithBalanceHigherThan(@RequiredMoney MONEY )
  AS
  BEGIN
  SELECT FirstName,LastName FROM AccountHolders AS ac
  LEFT JOIN Accounts AS a ON a.[AccountHolderId]=ac.Id
  GROUP BY FirstName, LastName
  HAVING SUM(a.Balance)>@RequiredMoney
  END
  EXEC usp_GetHoldersWithBalanceHigherThan 200040

  --Problem 11. Future Value Function

--  Your task is to create a function ufn_CalculateFutureValue that accepts as parameters – sum (decimal),
 --yearly interest rate (float) and number of years(int). It should calculate and return the future value of
  --the initial sum. Using the following formula:
--FV=I?(?(1+R)?^T)
--	I – Initial sum
--	R – Yearly interest rate
--	T – Number of years
GO 

CREATE FUNCTION ufn_CalculateFutureValue (@sum money, @annualIntRate float, @years int)
RETURNS MONEY
AS
BEGIN

  RETURN @sum * POWER(1 + @annualIntRate, @years);  

END;
SELECT dbo.ufn_CalculateFutureValue(1000, 0.1, 5) AS FV

--Problem 12. Calculating Interest
GO
CREATE  PROC usp_CalculateFutureValueForAccount(@accountId INT,@interestRate FLOAT)
AS
   SELECT ac.Id AS [Account Id],ac.FirstName,ac.LastName,a.Balance AS [CurrentBalance],
          dbo.ufn_CalculateFutureValue(a.Balance,@interestRate,5) AS [Balance in 5 years]
          FROM AccountHolders AS ac
		  JOIN Accounts AS a ON a.[AccountHolderId]=ac.[Id]
		  WHERE a.Id=@accountId

  EXEC usp_CalculateFutureValueForAccount 1, 0.10;
--Problem 13. *Scalar Function: Cash in User Games Odd Rows
  CREATE FUNCTION ufn_CashInUsersGames (@GameName NVARCHAR(MAX))
RETURNS @oddRowsGames TABLE(SumCash MONEY)
AS
BEGIN
 INSERT INTO @oddRowsGames
					 SELECT SUM(Cash.Cash) FROM (SELECT ug.GameId, ug.Cash, ROW_NUMBER() OVER
					 (PARTITION BY ug.GameId ORDER BY ug.Cash DESC)
					 AS 'RowNumber'	 FROM UsersGames AS ug
					 INNER JOIN Games AS g ON ug.GameId = g.Id
					 WHERE g.Name = @gameName) AS Cash
					 WHERE Cash.RowNumber % 2 <> 0
 RETURN
END
