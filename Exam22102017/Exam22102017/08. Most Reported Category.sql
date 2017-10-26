--Select ALL categories and the
-- number of employees in each
--  category and order them
--   alphabetically by category name.
--Required columns:
--?	CategoryName
--?	Employees Number

 SELECT c.Name,COUNT(e.Id)
       FROM Categories AS c
 JOIN Departments d ON d.Id=c.DepartmentId
 JOIN Employees e ON e.DepartmentId=d.Id
GROUP BY c.Name
ORDER BY c.Name
