SELECT FirstName, LastName,Description, CONVERT(VARCHAR(10), R.OpenDate, 20) FROM Employees e
JOIN Reports r ON r.EmployeeId=e.Id AND r.EmployeeId IS NOT NULL
ORDER BY e.Id,OpenDate,r.Id


--Select only employees who have an assigned report
-- and show all reports of each found employee. 
-- Show the open date column in the format “yyyy-MM-dd”.
--  Order them by employee id (ascending)
-- then by open date (ascending) and then by
--  report Id (again ascending).