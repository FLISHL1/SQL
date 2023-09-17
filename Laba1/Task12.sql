UPDATE `Marks` join (SELECT subject, AVG(mark) as avg_mark FROM Marks GROUP BY subject) as f on f.subject=Marks.subject
SET `mark` = avg_mark
WHERE `mark` is NULL