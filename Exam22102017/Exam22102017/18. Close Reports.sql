
GO
CREATE or alter TRIGGER tr_Status ON [Status]
AFTER UPDATE
AS 
BEGIN
DECLARE @isCompleted DATETIME2 =(SELECT  TOP 1 CloseDate
							 FROM inseted 
							)
IF (@isCompleted IS NOT NULL)
	BEGIN
UPDATE Reports
SET StatusId=3
WHERE Id=(SELECT TOP 1 Id FROM inserted)

	END
END

UPDATE Reports
SET
CloseDate = '12/10/2017'
WHERE Id = 3;

SELECT Id, StatusId FROM Reports
WHERE Id = 3

