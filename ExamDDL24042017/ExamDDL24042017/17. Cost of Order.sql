
GO
CREATE OR ALTER FUNCTION udf_GetCost(@jobId INT)
RETURNS DECIMAL(6,2)
AS
BEGIN
DECLARE @cost DECIMAL(6,2) =
(SELECT SUM(p.Price)FROM Jobs AS j
JOIN Orders AS o ON o.JobId=j.JobId
JOIN OrderParts AS op ON op.OrderId=o.OrderId
JOIN Parts AS p ON p.PartId=op.PartId
WHERE j.JobId=@jobId)

RETURN ISNULL ((@cost),0)
END

