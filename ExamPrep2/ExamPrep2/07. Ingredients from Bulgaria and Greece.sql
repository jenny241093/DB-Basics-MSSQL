SELECT TOP 15 i.Name,i.Description,c.Name FROM Ingredients AS i
LEFT JOIN Countries as c ON C.Id=i.OriginCountryId
WHERE c.Name IN ('Greece','Bulgaria')
ORDER BY  i.Name,c.Name