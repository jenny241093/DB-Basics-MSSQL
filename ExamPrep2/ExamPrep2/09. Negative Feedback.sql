--Select all feedbacks alongside
-- with the customers which gave them.
--  Filter only feedbacks which have
--   rate below 5.0. Order results by
--    ProductId (descending)
-- then by Rate (ascending).
SELECT ProductId,Rate,Description,
CustomerId,Age,Gender
FROM Feedbacks f
JOIN Customers c ON c.Id=f.CustomerId
WHERE Rate<5.0
ORDER BY ProductId DESC,Rate