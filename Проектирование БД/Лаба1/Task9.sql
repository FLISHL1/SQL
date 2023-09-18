SELECT Jokeys.*, Races.time FROM Races
                                     JOIN Jokeys ON Jokeys.id = Races.id_jokey
    and Races.time > (SELECT SEC_TO_TIME(SUM(TIME_TO_SEC(time))/COUNT(time)) FROM Races as f);
