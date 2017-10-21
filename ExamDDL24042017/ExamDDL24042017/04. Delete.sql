--4.	Delete
--Cancel Order with ID 19 – delete the order from the database and all associated entries from the mapping table.
SELECT*FROM Orders
DELETE FROM OrderParts
 WHERE OrderId=19
DELETE FROM Orders
 WHERE OrderId=19