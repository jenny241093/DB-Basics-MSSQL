--Delete all Feedbacks which
-- relate to Customer with 
--Id 14 or to
-- Product with Id 5.
DELETE FROM Feedbacks 
WHERE CustomerId =14 OR ProductId=5

SELECT * FROM Feedbacks