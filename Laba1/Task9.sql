SELECT name, GROUP_CONCAT(subject SEPARATOR ", ") FROM Marks
GROUP BY name
HAVING COUNT(subject) <= 3;
