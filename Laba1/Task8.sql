# SELECT CONCAT_WS(" ", `Математика`, `Русский`, GREATEST(`Физика`, `Информатика`, `Английский`)) as svod, COUNT(*) FROM
#     (SELECT name,
#             MAX(CASE WHEN subject='Математика' THEN mark ELSE '-' END) as `Математика`,
#             MAX(CASE WHEN subject='Русский' THEN mark ELSE '-' END) as `Русский`,
#             MAX(CASE WHEN subject='Физика' THEN mark ELSE '-' END) as `Физика`,
#             MAX(CASE WHEN subject='Информатика' THEN mark ELSE '-' END) as `Информатика`,
#             MAX(CASE WHEN subject='Английский' THEN mark ELSE '-' END) as `Английский`
#      FROM Marks
#      GROUP BY name
#     ) as f
# GROUP BY CONCAT_WS(" ", `Математика`, `Русский`, GREATEST(`Физика`, `Информатика`, `Английский`));