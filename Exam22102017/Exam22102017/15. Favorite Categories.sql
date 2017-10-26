CREATE PROC usp_AssignEmployeeToReport(@employeeId INT , @reportId INT )
AS 
BEGIN
--DECLARE @employeeReq BIT=(SELECT EmployeeId FROM Reports 
--					WHERE EmployeeId=@employeeId)
--DECLARE @reportIdReq BIT=(SELECT Id FROM Reports 
--					WHERE Id=@reportId )

UPDATE Reports

IF @employeeReq=@reportIdReq
	BEGIN
	END
IF @quantity<=0
	 BEGIN
	  RAISERROR('Part quantity must be more than zero!',16,1)
	 RETURN
	 END
     IF (@jobStatus='Finished')
	 BEGIN
	 RAISERROR('This job is not active!',16,1)
	 RETURN
	 END
	 
DECLARE @jobIdSelected INT = (SELECT @@ROWCOUNT FROM JOBS WHERE JobId=@jobId)
     IF (@jobIdSelected IS NULL)
	 BEGIN
	   RAISERROR('Job not found!',16,1)
	 RETURN
	 END
	 
DECLARE @PartId INT = (SELECT PartId FROM Parts WHERE SerialNumber=@serialNumber)
     IF @PartId IS NULL
	 BEGIN
	 RAISERROR('Part not found!',16,1)
	 END

DECLARE @OrderId INT=( SELECT o.OrderId FROM Orders AS o
	 JOIN OrderParts AS op ON op.OrderId=o.OrderId
	 JOIN Parts AS p ON p.PartId=op.PartId
	 WHERE JobId=@jobId AND p.PartId=@PartId)
   IF (@OrderId IS NULL)
   BEGIN
   INSERT INTO Orders(JobId,IssueDate)
   VALUES
   (@jobId,NULL)

   INSERT INTO OrderParts(OrderId,PartId,Quantity)VALUES
   (IDENT_CURRENT('Orders'),@partId,@quantity)
   END
   ELSE 
   BEGIN
DECLARE @PartExistInOrdred INT= (SELECT @@ROWCOUNT FROM
								 OrderParts WHERE OrderId=@OrderId
								 AND PartId=@PartId)
IF @PartExistInOrdred IS NULL
   BEGIN 
    INSERT INTO OrderParts(OrderId,PartId,Quantity)VALUES
       (@OrderId,@partId,@quantity)
   END
      ELSE       
         BEGIN 
         UPDATE OrderParts
         SET Quantity+=@quantity
         WHERE OrderId=@OrderId AND PartId=@PartId
         END
    END
END