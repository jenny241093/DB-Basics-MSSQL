SELECT r.OpenDate,r.Description,u.Email 
FROM Reports r
JOIN Categories c ON c.Id=r.CategoryId
JOIN Users u ON u.Id=r.UserId
WHERE 
	(r.CloseDate IS NULL )
	AND (LEN(r.Description)>20 
	AND r.Description LIKE '%str%')
	AND (c.DepartmentId IN (1,4,5))
ORDER BY r.OpenDate,u.Email,r.Id

select * from Departments
--Select all reports which satisfy
-- all the following criteria:
--?	are not closed yet
-- (they don’t have a CloseDate)
--?	the description 
--is longer than 20 symbols 
--and the word “str”
-- is mentioned anywhere
--?	are assigned 
--to one of the following departments:
-- “Infrastructure”, “Emergency”,
--  “Roads Maintenance”
--Order the results by OpenDate
-- (ascending), then by Reporter’s 
-- Email (ascending) and then by 
-- Report Id (ascending).
--Required columns:
--?	OpenDate
--?	Description
--?	Reporter Email
