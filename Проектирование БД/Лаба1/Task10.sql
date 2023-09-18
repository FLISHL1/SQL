SELECT Hippos.name, COUNT(*) FROM Rallys
                                      JOIN Hippos ON Rallys.id_hippo = Hippos.id
GROUP BY Hippos.id
HAVING COUNT(*) > 1;