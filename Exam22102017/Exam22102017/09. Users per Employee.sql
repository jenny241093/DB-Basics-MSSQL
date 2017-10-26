SELECT  e.FirstName+' '+e.LastName AS [Name],
       COUNT(r.UserId)
FROM Employees e
LEFT JOIN Reports r ON r.EmployeeId=e.Id
GROUP BY e.FirstName+' '+e.LastName
ORDER BY COUNT(r.UserId) DESC,[Name]

--Select all employees and
-- show how many unique users
--  each of them have served to.
--Required columns:
--?	Employee’s name - 
--Full name consisting of 
--FirstName and LastName 
--and a space between them 
--?	User’s number
--Order by Users Number 
--descending and then by Name ascending.
