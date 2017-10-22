--Select top 10 best rated products
-- ordered by average rate (descending)
--  then by amount of feedbacks
--   (descending).
--Required columns:
--•	Name
--•	Description
--•	AverageRate – 
--average Rate for each product
--•	FeedbacksAmount
-- – number of feedbacks for each product
SELECT TOP 10 p.Name,
p.Description,
AVG(f.Rate),
COUNT(*)FROM Products AS p
JOIN Feedbacks AS f ON f.ProductId=p.Id
GROUP BY p.Name,p.Description
ORDER BY AVG(f.Rate) DESC,COUNT(*)DESC

