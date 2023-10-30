

EXPLAIN SELECT Horses.name FROM Horses JOIN Owners ON Horses.id_owner = Owners.id
WHERE id_owner=1