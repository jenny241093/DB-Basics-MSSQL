--Switch all report’s
 --status to “in progress” 
 --where it is currently “waiting” 
 --for the “Streetlight” category 
 --(look up the category ID and 
 --status ID’s manually, 
 --there is no need to use table joins).

 SELECT  * FROM Reports

 UPDATE Reports
 SET StatusId=2
 WHERE StatusId=1 AND
 CategoryId=4