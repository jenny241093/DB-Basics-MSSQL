--Find the model that breaks the most 
--(has the highest number of jobs 
--associated with it).
-- Include the cost of parts ordered for it. 
-- If there are more than one models that were 
-- serviced the same number of times, list them all.
--Required columns:
--•	Name
--•	Times Serviced – number of assiciated jobs
--•	Parts Total – cost of all parts ordered for the jobs


SELECT TOP 1 WITH TIES 
         m.Name,COUNT(*) AS [Time Serviced],
         (SELECT ISNULL(SUM(p.Price*op.Quantity),0)  FROM Jobs as j
         JOIN Orders AS o ON o.JobId=j.JobId
         JOIN OrderParts AS op ON op.OrderId=o.OrderId
         JOIN Parts AS p ON p.PartId=op.PartId
         WHERE j.ModelId=m.ModelId) AS [Parts Total]
FROM Models AS m
JOIN Jobs AS j ON j.ModelId=m.ModelId
GROUP BY m.ModelId, m.Name
ORDER BY [Time Serviced] DESC

