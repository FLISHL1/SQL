SELECT sum_mark, COUNT(sum_mark)
FROM (SELECT name, SUM(mark) as sum_mark FROM `Marks` GROUP BY name) as f
GROUP BY sum_mark;