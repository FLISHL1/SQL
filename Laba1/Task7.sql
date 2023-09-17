SELECT `status`, COUNT(`status`) FROM (SELECT name, avg_mark,
                                              (SELECT CASE
                                                          WHEN (COUNT(*)+1)/(SELECT MAX(id) FROM Marks) < 0.25 THEN 1
                                                          WHEN  (COUNT(*)+1)/(SELECT MAX(id) FROM Marks) < 0.75 THEN 2
                                                          ELSE 3 END FROM (
                                                                              SELECT name, ROUND(AVG(mark), 2) as avg_mark
                                                                              FROM `Marks`
                                                                              GROUP BY name
                                                                          ) AS subquery WHERE avg_mark > f.avg_mark and f.name != name) AS `status`
                                       FROM (
                                                SELECT name, ROUND(AVG(mark), 2) as avg_mark
                                                FROM `Marks`
                                                GROUP BY name
                                            ) AS f
                                       ORDER BY avg_mark DESC) as r
GROUP BY `status`