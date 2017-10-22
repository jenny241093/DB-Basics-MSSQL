--Find all ingredients coming from the countries with Id’s of 1, 10, 20. Order them by ingredient Id (ascending).
--Required columns:
--•	Name
--•	Description
--•	OriginCountryId

SELECT Name, Description, OriginCountryId
FROM Ingredients
WHERE OriginCountryId IN (1,10,20)
ORDER BY Id