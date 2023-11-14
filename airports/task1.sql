-- task1
SELECT *
FROM aircrafts
WHERE model LIKE '%Аэробус%';

SELECT *
FROM aircrafts_data;

-- task2
SELECT *
FROM aircrafts
WHERE model LIKE '%Аэробус%'
   or model LIKE '%Боинг%';

-- task3
SELECT *
FROM airports
WHERE airport_name LIKE '___';

-- task4
SELECT *
FROM aircrafts
WHERE model not LIKE '%300';

-- task5
SELECT *
FROM aircrafts
where range BETWEEN 3000 and 6000
ORDER BY range DESC;

-- task6
SELECT aircraft_code, model, range, range / 1.609 as miles
FROM aircrafts
where range BETWEEN 3000 and 6000
ORDER BY range DESC;

-- task7
SELECT DISTINCT timezone
FROM airports;

-- task8
SELECT *
FROM airports
ORDER BY coordinates[1] DESC
LIMIT 3;

-- task9
SELECT *
FROM airports
ORDER BY coordinates[1] DESC
OFFSET 3 LIMIT 3;

-- task10
SELECT aircraft_code,
       model,
       range,
       CASE
           WHEN range < 2000 THEN 'ближнемагистральные'
           WHEN range >= 2000 and range < 5000 THEN 'среднемагистральные'
           WHEN range >= 5000 THEN 'дальненемагистральные' end
FROM aircrafts;

-- task11
SELECT seats.*
FROM aircrafts
         JOIN seats USING (aircraft_code)
WHERE model = 'Сессна 208 Караван';

-- task12
SELECT *
FROM flights_v;

-- task13
SELECT aircrafts.model, COUNT(*)
FROM flights_v
         JOIN aircrafts USING (aircraft_code)
GROUP BY aircrafts.model;

-- task14
SELECT COUNT(*) FROM tickets LEFT JOIN boarding_passes USING(ticket_no)
WHERE boarding_passes.ticket_no is NULL;

-- task15



-- task17
SELECT DISTINCT arrival_city
FROM routes
WHERE departure_city in ('Москва', 'Санкт-Петербург');

-- task18
SELECT arrival_city FROM routes
WHERE departure_city in ('Москва')
INTERSECT
SELECT arrival_city FROM routes
WHERE departure_city in ('Санкт-Петербург');

-- task19
SELECT arrival_city FROM routes
WHERE departure_city not in ('Москва')
INTERSECT
SELECT arrival_city FROM routes
WHERE departure_city in ('Санкт-Петербург');

-- task20
SELECT COUNT(*) FROM routes
WHERE departure_city in ('Москва');

-- task21
SELECT COUNT(*) FROM flights_v;

-- task22
SELECT departure_city, COUNT(*) as count FROM routes
GROUP BY departure_city
HAVING COUNT(*) >= 15;

-- task23
SELECT city, COUNT(*) FROM airports
GROUP BY city
HAVING COUNT(*) > 1;
