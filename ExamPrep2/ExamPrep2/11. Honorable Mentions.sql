SELECT f.[ProductId],
       CONCAT(c.FirstName,' ',c.LastName),
	   f.Description
FROM Feedbacks f
JOIN (SELECT CustomerId FROM FeedBacks
GROUP BY CustomerId
HAVING COUNT (Id)>=3
)as topCust  ON f.CustomerId=topCust.CustomerId
JOIN Customers AS c ON c.Id=topCust.CustomerId
ORDER BY f.ProductId,
         CONCAT(c.FirstName,' ',c.LastName),
		 f.Id