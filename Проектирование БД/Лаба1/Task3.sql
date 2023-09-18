SELECT Horses.name as horse, Jokeys.name as jokey, place as place, Races.time FROM Rallys
                                                                                       JOIN Races ON Rallys.id = Races.id_rallys
                                                                                       JOIN Horses ON Races.id_horse = Horses.id
                                                                                       JOIN Jokeys ON Races.id_jokey = Jokeys.id
WHERE Rallys.id = 1