DELETE `m`
FROM Marks as `m`
         JOIN
     (SELECT name, MIN(mark) as `min_`, COUNT(*) as `count_`
      FROM Marks
      GROUP BY name) as f
     ON f.name=m.name
WHERE f.count_ = 4 and f.min_ = m.mark;
