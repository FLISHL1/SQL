# SELECT CONCAT_WS(" ", `����������`, `�������`, GREATEST(`������`, `�����������`, `����������`)) as svod, COUNT(*) FROM
#     (SELECT name,
#             MAX(CASE WHEN subject='����������' THEN mark ELSE '-' END) as `����������`,
#             MAX(CASE WHEN subject='�������' THEN mark ELSE '-' END) as `�������`,
#             MAX(CASE WHEN subject='������' THEN mark ELSE '-' END) as `������`,
#             MAX(CASE WHEN subject='�����������' THEN mark ELSE '-' END) as `�����������`,
#             MAX(CASE WHEN subject='����������' THEN mark ELSE '-' END) as `����������`
#      FROM Marks
#      GROUP BY name
#     ) as f
# GROUP BY CONCAT_WS(" ", `����������`, `�������`, GREATEST(`������`, `�����������`, `����������`));