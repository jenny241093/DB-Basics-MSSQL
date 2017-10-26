--Select all employees who have
-- at least one assigned closed
--  or open report through year 
--  2016 and their total sum. 
--  Open reports don’t have a 
--  CloseDate. Reports that 
--  have been opened before 
--  2016 but were closed in
--   2016 are counted as 
--   closed only! 
--   Order by Name 
--   (ascending), and then by employee Id
--Required columns:
--?	Name - name - 
--Full name consisting 
--of FirstName and LastName and
-- a space between them
--?	Closed /Open reports number
SELECT FirstName + ' ' + LastName
 FROM Employees