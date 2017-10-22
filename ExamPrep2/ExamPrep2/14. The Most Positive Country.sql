-- TOP 1 WITH TIES
SELECT TOP 1 WITH TIES coun.Name,AVG(Rate) FROM Countries coun
JOIN Customers cust ON cust.CountryId =coun.Id
JOIN Feedbacks f ON f.CustomerId=cust.Id
GROUP BY coun.Name
ORDER BY AVG(Rate) DESC