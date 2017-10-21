--12.	Parts Cost
--Display the total cost of all parts ordered during the last three weeks. Assume the current date is 24 April 2017.
--Required columns:
--•	Parts Total Cost

SELECT ISNULL(SUM(p.Price*op.Quantity),0) AS [Parts Total]
 FROM Parts AS p
JOIN OrderParts AS op ON op.PartId=p.PartId
JOIN Orders AS o ON o.OrderId=op.OrderId
WHERE DATEDIFF(WEEK, o.IssueDate, '04-24-2017') <= 3
