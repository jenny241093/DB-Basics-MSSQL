--Select the first 3 mechanics who have more than 1 active job (not Finished). Order them by number
 --of jobs (descending) and by mechanic ID (ascending).
--Required columns:
--•	Mechanic Full Name
--•	Number of Jobs
SELECT CONCAT(FirstName,' ',LastName) AS Mechanic,COUNT(*)
FROM Mechanics AS m
JOIN Jobs AS j ON j.MechanicId=m.MechanicId
GROUP BY CONCAT(FirstName,' ',LastName),m.MechanicId,j.Status
HAVING j.Status<>'Finished' AND COUNT(*)>1
ORDER BY COUNT(*) ,m.MechanicId
SELECT*FROM Mechanics
SELECT * FROM Jobs