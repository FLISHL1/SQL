EXPLAIN SELECT Jokeys.*, Races.time FROM Races
                                     JOIN Jokeys ON Jokeys.id = Races.id_jokey
WHERE Races.id_rallys = 1
  and Races.time > (SELECT SEC_TO_TIME(SUM(TIME_TO_SEC(time))/COUNT(time)) FROM Races as f
                    WHERE f.id_rallys = Races.id_rallys
                    GROUP BY f.id_rallys);

CREATE INDEX races_idRallys_time  ON races (id_rallys, time);

EXPLAIN SELECT Jokeys.*, Races.time FROM Races
                                     JOIN Jokeys ON Jokeys.id = Races.id_jokey
WHERE Races.id_rallys = 1
  and Races.time > (SELECT SEC_TO_TIME(SUM(TIME_TO_SEC(time))/COUNT(time)) FROM Races as f
                    WHERE f.id_rallys = Races.id_rallys
                    GROUP BY f.id_rallys);