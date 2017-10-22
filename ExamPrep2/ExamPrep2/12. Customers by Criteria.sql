----Select customers that are either
-- at least 21 old and contain “an” 
-- in their first name or their
--  phone number ends with “38”
--   and are not from Greece.
--    Order by first name (ascending),
	 --then by age(descending).
--Required columns:
--•	FirstName
--•	Age
--•	PhoneNumber
SELECT FirstName,Age,PhoneNumber FROM Customers
WHERE (Age>=21 AND FirstName LIKE '%an%')
 OR (PhoneNumber LIKE '%38'
AND CountryId <> 31)
ORDER BY FirstName,Age DESC