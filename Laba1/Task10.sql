SELECT
    CASE
        WHEN max_sum BETWEEN 281 AND 300 THEN '281-300 баллов'
        WHEN max_sum BETWEEN 261 AND 280 THEN '261-280 баллов'
        WHEN max_sum BETWEEN 241 AND 260 THEN '241-260 баллов'
        WHEN max_sum BETWEEN 221 AND 240 THEN '221-240 баллов'
        END AS score,
    COUNT(*) AS student_count
FROM
    (SELECT name, IF(COUNT(mark) >= 4, SUM(mark) - MIN(mark), SUM(mark)) as max_sum FROM Marks GROUP BY name) as f
GROUP BY
    score;