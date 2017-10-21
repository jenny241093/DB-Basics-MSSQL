--Select the names of all clients with active jobs (not Finished). Include the status of the job and how many days it’s been since it was submitted. 
--Assume the current date is 24 April 2017. Order results by time length (descending) and by client ID (ascending).
--Required columns:
--•	Client Full Name
--•	Days going – how many days have passed since the issuing
--•	Status
SELECT * FROM Clients
SELECT * FROM Jobs

SELECT FirstName + ' ' + LastName AS Client,
DATEDIFF(DAY,j.IssueDate,'04-24-2017') AS [Days going] ,j.Status
FROM Clients AS c
JOIN Jobs AS j ON j.ClientId=c.ClientId
WHERE j.Status<>'Finished'
ORDER BY [Days going] DESC,c.ClientId