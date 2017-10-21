--014.	Model Repair Time
--Select all models with the average time it took to service, out of all the times it
-- was repaired. Calculate the average as an integer value.
--  Order the results by average service time ascending.
--Required columns:
--•	Model ID
--•	Name
--•	Average Service Time –
-- average number of days it took to finish the job
--; note the word 'days' attached at the end!
SELECT * FROM Models
SELECT * FROM Jobs
SELECT m.ModelId,m.[Name],CONCAT(AVG(DATEDIFF(DAY,j.IssueDate,j.FinishDate)),' ','days')
FROM Models AS m
JOIN Jobs AS j On j.ModelId=m.ModelId
GROUP BY m.ModelId,m.[Name]
ORDER BY AVG(DATEDIFF(DAY,j.IssueDate,j.FinishDate))
