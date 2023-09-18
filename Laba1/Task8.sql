SELECT comb, COUNT(comb) FROM
(SELECT SUBSTRING_INDEX(GROUP_CONCAT(mark ORDER BY mark DESC SEPARATOR ', '), ', ', 3) as comb
    FROM Marks
    GROUP BY name) as f
GROUP BY comb;


