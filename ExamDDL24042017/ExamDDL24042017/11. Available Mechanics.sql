

--this code doesnt work
SELECT CONCAT(FirstName,' ',LastName) AS Mechanic
FROM Mechanics AS m
JOIN Jobs AS j ON j.MechanicId=m.MechanicId
GROUP BY CONCAT(FirstName,' ',LastName),m.MechanicId,j.Status
HAVING j.Status  = 'Finished' OR m.MechanicId = NULL
ORDER BY m.MechanicId


SELECT FirstName + ' ' + LastName AS Available
  FROM Mechanics
WHERE MechanicId NOT IN
(SELECT DISTINCT MechanicId FROM Jobs
WHERE MechanicId IS NOT NULL AND Status <> 'Finished')
ORDER BY MechanicId