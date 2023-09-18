SELECT Hippos.name as hippos_name, Jokeys.name as jokeys_name, MIN(Races.time) as best_time FROM Races
                                                                                                     JOIN Jokeys ON Races.id_jokey = Jokeys.id
                                                                                                     JOIN Rallys ON Rallys.id = Races.id_rallys
                                                                                                     JOIN Hippos ON Rallys.id_hippo = Hippos.id
GROUP BY hippos_name, Jokeys.id