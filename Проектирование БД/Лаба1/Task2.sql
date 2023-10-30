EXPLAIN SELECT Owners.name, COUNT(Horses.id) FROM Horses JOIN Owners ON Horses.id_owner = Owners.id
GROUP BY Owners.id