----Select all mechanics and the average time they
-- take to finish their assigned jobs. 
--Calculate the average as an integer.
-- Order results by mechanic ID (ascending).
----Required columns:
----•	Mechanic Full Name
----•	Average Days – average number of days the machanic took to finish the job

SELECT CONCAT(FirstName,' ',LastName) AS Mechanic,AVG(DATEDIFF(DAY,j.IssueDate,j.FinishDate))
FROM Mechanics AS m
JOIN Jobs AS j ON j.MechanicId=m.MechanicId
GROUP BY CONCAT(FirstName,' ',LastName),m.MechanicId
ORDER BY m.MechanicId
