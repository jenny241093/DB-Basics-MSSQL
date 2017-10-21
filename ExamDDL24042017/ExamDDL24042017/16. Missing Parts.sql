--016.	Missing Parts

--List all parts that are needed for active jobs 
--(not Finished) without sufficient quantity in stock
-- and in pending orders 
-- (the sum of parts in stock and parts ordered 
-- is less than the required quantity).
--  Order them by part ID (ascending).
--Required columns:
--•	Part ID
--•	Description
--•	Required – number of parts required for active jobs
--•	In Stock – how many of the part are currently in stock
--•	Ordered – how many of the parts are expected 
--to be delivered (associated with order 
--that is not Delivered)
--Example:
SELECT p.PartId,p.Description,
SUM(pn.Quantity) AS Required,
AVG(p.StockQty) AS [In stock],
ISNULL(SUM(op.Quantity),0) AS Ordered
 FROM Parts AS p
  JOIN PartsNeeded AS pn ON pn.PartId=p.PartId 
  JOIN Jobs AS j ON j.JobId=pn.JobId
  LEFT JOIN Orders AS o ON o.JobId=J.JobId
  LEFT JOIN OrderParts AS op ON op.OrderId=o.OrderId
WHERE J.Status<>'Finished' 
GROUP BY p.PartId,p.Description
HAVING AVG(p.StockQty)+ ISNULL(SUM(op.Quantity),0)<SUM(pn.Quantity) 
ORDER BY p.PartId
select * from Parts,Jobs