SELECT Jokeys.name as jokeys_name, MIN(time) FROM Races JOIN Jokeys ON Races.id_jokey = Jokeys.id
GROUP BY Jokeys.id