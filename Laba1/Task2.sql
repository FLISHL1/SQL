SELECT `mark`, COUNT(`mark`) FROM `Marks`
WHERE `subject` = "Математика"
GROUP BY `mark`;