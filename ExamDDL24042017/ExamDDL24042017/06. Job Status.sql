--Find all active jobs (that aren’t Finished) and display their status and issue date. Order by issue date and by job ID (both ascending).
--Required columns:
--•	Status
--•	Issue Date
SELECT Status,IssueDate FROM Jobs
WHERE Status <> 'Finished'
ORDER BY IssueDate,JobId