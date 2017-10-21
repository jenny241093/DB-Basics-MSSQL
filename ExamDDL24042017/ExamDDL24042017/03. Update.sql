SELECT * FROM Mechanics WHERE FirstName = 'Ryan'
SELECT * FROM Jobs WHERE Status = 'In Progress' AND MechanicId=3

UPDATE Jobs
SET Status = 'In Progress', MechanicId = 3
WHERE Status = 'Pending'