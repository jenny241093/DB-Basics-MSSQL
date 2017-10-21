--7.	Mechanic Assignments
--Select all mechanics with their jobs. Include job status and issue date. Order by mechanic Id, issue date, job Id (all ascending).
--Required columns:
--•	Mechanic Full Name
--•	Job Status
--•	Job Issue Date
SELECT * FROM Mechanics
SELECT * FROM Jobs

SELECT FirstName + ' ' + LastName AS Mechanic,
j.Status,j.IssueDate
FROM Mechanics AS m
JOIN Jobs AS j ON j.MechanicId=m.MechanicId 
ORDER BY m.MechanicId,IssueDate,JobId