--Select all clients ordered by last name (ascending) then by client ID (ascending). 
--Required columns:
--•	First Name
--•	Last Name
--•	Phone
SELECT FirstName,LastName,Phone FROM Clients
ORDER BY LastName,ClientId