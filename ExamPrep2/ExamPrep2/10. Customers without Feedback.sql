--Select all customers without feedbacks.
 --Order them by customer id (ascending).
--Required columns:
--•	CustomerName – customer’s first and last name, concatenated with space
--•	PhoneNumber
--•	Gender

SELECT CONCAT(c.FirstName,' ',c.LastName),
c.PhoneNumber,
c.Gender
FROM Feedbacks f
RIGHT JOIN Customers c ON c.Id=f.CustomerId
WHERE f.Rate IS NULL
ORDER BY c.Id
