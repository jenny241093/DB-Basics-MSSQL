--Problem 1.	Create Table Logs
CREATE TABLE Logs (
LogId INT PRIMARY KEY IDENTITY,
AccountId INT,
OldSum MONEY,
NewSum Money
)
GO
CREATE TRIGGER tr_AddingNewEntryToLogs ON Accounts
AFTER UPDATE
AS
INSERT INTO Logs
VALUES (
         (SELECT Id FROM inserted),
         (SELECT Balance FROM deleted),
         (SELECT Balance FROM inserted)


)
GO
--Problem 2.	Create Table Emails
CREATE TABLE NotificationEmails(
Id INT PRIMARY KEY IDENTITY,
Recipient VARCHAR(MAX) NOT NULL,
[Subject] VARCHAR(MAX),
Body VARCHAR (MAX)NOT NULL
)
GO
CREATE TRIGGER tr_CreateNewEmail ON Logs
AFTER INSERT
AS

BEGIN 
    DECLARE @recipient INT = (SELECT AccountId FROM inserted);
    DECLARE @oldBalance MONEY = (SELECT OldSum FROM inserted);
    DECLARE @newBalance MONEY = (SELECT NewSum FROM inserted);
    DECLARE @subject VARCHAR(MAX)= CONCAT('Balance change for account: ', @recipient)
	DECLARE @body VARCHAR(MAX)=CONCAT('On ', GETDATE(), ' your balance was changed from ', @oldBalance, ' to ', @newBalance, '.')
INSERT INTO NotificationEmails(Recipient, Subject, Body)

VALUES(@recipient, @subject, @body)
END


GO
--Problem 3.	Deposit Money
CREATE OR ALTER PROC  usp_DepositMoney (@accountId int, @depositAmount money)
AS
BEGIN
  BEGIN TRANSACTION
  UPDATE Accounts
  SET Balance += @depositAmount
  WHERE (Id = @accountId)

  IF (@@ROWCOUNT <> 1) 
    BEGIN
      ROLLBACK;
      RAISERROR ('Invalid account!', 16, 1);
      RETURN;
    END

  COMMIT;

END
 EXEC dbo.usp_DepositMoney 1,200

 GO
 --Problem 4.	Withdraw Money
 CREATE OR ALTER PROC  usp_WithdrawMoney (@accountId INT, @moneyAmount DECIMAL(15,4))
 AS 
 BEGIN
 BEGIN TRANSACTION
 DECLARE @amount DECIMAL (15,2)=(SELECT Balance FROM Accounts WHERE Id=@accountId)

 IF(@amount<0)
	     BEGIN
		
	    RAISERROR('Unsufficient amount!',16,1);
		RETURN;
		 END
   UPDATE Accounts
   
 SET Balance-=@moneyAmount
	WHERE Id=@accountId
	
	
	IF (@@ROWCOUNT<>1)
      BEGIN
	    ROLLBACK;
	    RAISERROR('Invalid account!',16,1);
		RETURN;
	  END
	
	COMMIT
 END

 SELECT * FROM Accounts
 WHERE Id=1

 EXEC dbo.usp_WithdrawMoney 1,200

 --Problem 5.	Money Transfer


 --Write stored procedure usp_TransferMoney(SenderId, ReceiverId, Amount) 
 --that transfers money from one account to another. Make sure to guarantee valid positive MoneyAmount
  --with precision up to fourth sign after decimal point. Make sure that the whole procedure passes 
  --without errors and if error occurs make no change in the database. You can use both:
   --“usp_DepositMoney”, “usp_WithdrawMoney” (look at previous two problems about those procedures). 
 GO
 CREATE OR ALTER PROC usp_TransferMoney(@senderId INT, @receiverId INT , @amount MONEY)
 AS
 BEGIN
      BEGIN 
      EXEC dbo.usp_WithdrawMoney @senderId,@amount
	  EXEC dbo.usp_DepositMoney @receiverId,@amount
	  END
 END
 EXEC usp_TransferMoney 5,1,5000
 --PART II – Queries for Diablo Database

 USE Diablo

 --Problem 6.	Trigger
 GO

 ----1.
 CREATE TRIGGER tr_UserGameItems ON UserGameItems
 INSTEAD OF INSERT
 AS
        INSERT INTO UserGameItems
		SELECT ItemId,UserGameId FROM inserted
		WHERE ItemId IN
		   (SELECT Id 
		    FROM Items
			WHERE MinLevel<=
			    (SELECT[Level]FROM UsersGames 
				 WHERE Id=UserGameId)
		    )
GO
----2.
UPDATE UsersGames
SET Cash=Cash+50000+
            (SELECT SUM(i.Price)FROM Items AS i
				JOIN UserGameItems AS ug ON ug.ItemId=i.Id
			    WHERE UserGameId = UsersGames.Id)
		        WHERE UserId IN(
			           SELECT Id FROM Users
			           WHERE Username IN('loosenoise', 'baleremuda', 'inguinalself', 'buildingdeltoid', 'monoxidecos'))
AND GameId = (SELECT ID FROM Games Where Name='Bali')

----3.
INSERT INTO UserGameItems(UserGameId,ItemId)
SELECT UsersGames.Id,i.Id
FROM UsersGames,Items AS i
WHERE UserId IN(
          Select Id
		  FROM Users
		  WHERE Username IN ('loosenoise', 'baleremuda', 'inguinalself', 'buildingdeltoid', 'monoxidecos')
		  ) AND GameId = (SELECT Id FROM Games WHERE Name = 'Bali' ) 
		         AND ((i.Id > 250 AND i.Id < 300)
		         OR (i.Id > 500 AND i.Id < 540))
-- Get cash from users
UPDATE UsersGames
SET Cash = Cash - (SELECT SUM(i.Price) FROM Items i JOIN UserGameItems ugi ON ugi.ItemId = i.Id WHERE ugi.UserGameId = UsersGames.Id)
WHERE UserId IN (
	SELECT Id 
	FROM Users 
	WHERE Username IN ('loosenoise', 'baleremuda', 'inguinalself', 'buildingdeltoid', 'monoxidecos')
)
AND GameId = (SELECT Id FROM Games where Name = 'Bali')

---4.4. Select all users in the current game (“Bali”) with their items. Display username, game name, cash
 --and item name. Sort the result by username alphabetically, then by item name alphabetically. 

SELECT u.Username, g.Name, ug.Cash, i.Name AS [Item Name] FROM UsersGames ug
JOIN Games g ON ug.GameId = g.Id
JOIN Users u ON ug.UserId = u.Id
JOIN UserGameItems ugi ON ugi.UserGameId = ug.Id
JOIN Items i ON i.Id = ugi.ItemId
WHERE g.Name = 'Bali'
ORDER BY Username, [Item Name]
