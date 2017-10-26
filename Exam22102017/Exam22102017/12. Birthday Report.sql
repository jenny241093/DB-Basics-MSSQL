--Select all categories
-- in which users have 
-- submitted a report 
-- on their birthday.
--  Order them by name alphabetically.
--Required columns:
--?	Category Name
SELECT DISTINCT c.Name FROM Categories c
JOIN Reports r ON r.CategoryId=c.Id
JOIN Users u ON u.Id=r.UserId 
WHERE DATEPART(d, OpenDate) = DATEPART(d, u.BirthDate)
    AND DATEPART(m, OpenDate) = DATEPART(m, u.BirthDate)
ORDER BY c.Name

SELECT OpenDate FROM Reports 
SELECT Birthdate FROM Users