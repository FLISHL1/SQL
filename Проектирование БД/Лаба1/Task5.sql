EXPLAIN SELECT * FROM Horses
WHERE id in (SELECT id_horse FROM Races)