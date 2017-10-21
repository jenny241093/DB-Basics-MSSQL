
--Select all finished jobs and the total 
--cost of all parts that were ordered for them. 
--Sort by total cost of parts ordered (descending)
 --and by job ID (ascending).
--Required columns:
--•	Job ID
--•	Total Parts Cost

 ---this code = 2/4 
 SELECT j.JobId, 
       (SELECT ISNULL(SUM(p.Price*op.Quantity),0) FROM Parts AS p
JOIN OrderParts AS op ON op.PartId=p.PartId
JOIN Orders AS o ON o.OrderId=op.OrderId
JOIN Jobs AS jo ON j.JobId=o.JobId  
WHERE jo.JobId=j.JobId) AS [Total]
FROM Jobs AS j
WHERE  j.Status = 'Finished'
ORDER BY Total DESC,j.JobId
--4/4
SELECT j.JobId,
       (SELECT ISNULL(SUM(p.Price * op.Quantity), 0) FROM Parts AS p
        JOIN OrderParts AS op ON op.PartId = p.PartId
        JOIN Orders AS o ON o.OrderId = op.OrderId
        JOIN Jobs AS jo ON jo.JobId = o.JobId
        WHERE jo.JobId = j.JobId) AS Total
FROM Jobs j
WHERE j.Status = 'Finished'
ORDER BY Total DESC, j.JobId