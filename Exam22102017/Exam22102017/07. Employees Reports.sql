SELECT c.Name,COUNT(*)
       FROM Categories AS c
JOIN Reports r ON r.CategoryId=c.Id
GROUP BY c.Name
ORDER BY COUNT(*)DESC,Name


--Select ALL categories
-- and order them by the number
--  of reports per category in
--   descending order and
--    then alphabetically by name.
--Required columns:
--?	CategoryName
--?	ReportsNumber
