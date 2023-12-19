# Task 1
SELECT group_id, `group`.number
FROM schedule
         JOIN `group` ON schedule.group_id = `group`.id
GROUP BY group_id
HAVING COUNT(*) = (SELECT MAX(c) FROM (SELECT COUNT(*) as c FROM `schedule` as f GROUP BY `group_id`) as f);

# Task 2
SELECT number_caf, COUNT(*) as count_par
FROM `schedule`
         JOIN teachers ON `schedule`.`teacher_id` = teachers.id
GROUP BY number_caf;

# Task 3
EXPLAIN
SELECT auditorys.number
FROM `schedule`
         JOIN `auditorys` ON `auditory_id` = `auditorys`.id
WHERE (SELECT COUNT(*)
       FROM `schedule` as f
       WHERE f.auditory_id = `schedule`.auditory_id
         and day_week != 7
       GROUP BY f.auditory_id) < 2;

# Task 4
SELECT t.name
FROM teachers t
         JOIN `schedule` s ON t.id = s.teacher_id
         JOIN subjects sub ON s.subject_id = sub.id
WHERE sub.name = 'Физика'
   OR sub.name = 'Математика'
GROUP BY t.id
HAVING COUNT(DISTINCT sub.name) = 1;

# Task 5
SELECT day_week, number_par, subjects.name, auditorys.number, teachers.name
FROM `schedule`
         JOIN auditorys ON auditorys.id = `schedule`.`auditory_id`
         JOIN teachers ON teachers.id = `schedule`.teacher_id
         JOIN subjects ON subjects.id = `schedule`.subject_id
WHERE group_id = 1
ORDER BY day_week, number_par;
