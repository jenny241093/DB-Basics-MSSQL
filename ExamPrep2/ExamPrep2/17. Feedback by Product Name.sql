
GO
CREATE OR ALTER FUNCTION udf_GetRating(@Name VARCHAR(50))
RETURNS NVARCHAR(100)
AS
BEGIN
DECLARE @FeedBack NVARCHAR(100)

SET @FeedBack=(SELECT DISTINCT 
     CASE 
     WHEN AVG(f.Rate)<5 THEN 'Bad'
     WHEN AVG(f.Rate) BETWEEN 5 AND 8 THEN 'Average'
     WHEN AVG(f.Rate) > 8 THEN 'Good'
	 ELSE 'No rating' end
FROM Feedbacks as f
RIGHT JOIN Products p on p.Id=f.ProductId
WHERE p.Name=@Name)
RETURN @FeedBack
END


SELECT TOP 5 Id, Name, dbo.udf_GetRating(Name)
  FROM Products
 ORDER BY Id
