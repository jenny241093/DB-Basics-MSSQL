GO
CREATE or alter FUNCTION udf_GetReportsCount(@employeeId INT , @statusId INT) 
RETURNS INT
AS 
BEGIN
DECLARE @sumOfReports INT;
SET @sumOfReports=(SELECT COUNT(*) FROM Reports 
WHERE EmployeeId=@employeeId AND StatusId=@statusId)
RETURN @sumOfReports
END
GO
SELECT Id, FirstName, Lastname, dbo.udf_GetReportsCount(Id, 2) AS ReportsCount
FROM Employees
ORDER BY Id

SELECT * FROM Reports