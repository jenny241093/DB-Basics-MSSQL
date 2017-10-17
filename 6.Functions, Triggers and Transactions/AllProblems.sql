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