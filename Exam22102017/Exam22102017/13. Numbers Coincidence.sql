--Select all unique usernames which:
--?	starts with a digit and
-- have reported in a category 
-- with id equal to the digit
--OR
--?	ends with a digit and
-- have reported in a category
--  with id equal to the digit
--Required columns:
--?	Username
--Order them alphabetically
SELECT u.Username FROM Users u
JOIN Reports r ON r.UserId=u.Id
WHERE ((ISNUMERIC(SUBSTRING(U.Username, 1, 1)) = 1
AND 
CategoryId = LEFT(u.Username,1)))
OR
((ISNUMERIC(SUBSTRING(U.Username, 1,LEN(u.UserName)))=1
AND 
CategoryId = RIGHT(u.Username,1)))
ORDER BY u.Username


SELECT u.Username FROM Users u
JOIN Reports r ON r.UserId=u.Id
WHERE (u.UserName LIKE '[0-9]%'
AND 
CategoryId = LEFT(u.UserName,1))
OR
((u.UserName LIKE '%[0-9]'
AND 
CategoryId = RIGHT(u.UserName,1)))
ORDER BY u.Username