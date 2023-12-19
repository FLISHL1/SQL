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
EXPLAIN SELECT COUNT(*)
FROM tickets
         LEFT JOIN boarding_passes USING (ticket_no)
WHERE boarding_passes.ticket_no is NULL;

-- task15
explain ANALYZE SELECT ticket_no, flight_id
FROM ticket_flights
         JOIN boarding_passes USING (flight_id ,ticket_no)
         JOIN flights USING (flight_id)
WHERE ticket_flights.fare_conditions != (SELECT seats.fare_conditions
                                         FROM seats
                                         WHERE seats.aircraft_code
                                             = flights.aircraft_code
                                          AND seats.seat_no = boarding_passes.seat_no);

-- Исправлено на такое

explain ANALYZE SELECT ticket_no, flight_id
FROM ticket_flights JOIN boarding_passes USING (ticket_no, flight_id)
JOIN seats USING (seat_no)
JOIN flights USING  (flight_id, aircraft_code)
WHERE seats.fare_conditions != ticket_flights.fare_conditions;


-- task16
SELECT f.min_sum, f.max_sum, count(*)
FROM bookings.bookings
         RIGHT JOIN (VALUES (0.0, 100000.0),
                            (100000.0, 200000.0),
                            (200000.0, 300000.0),
                            (300000.0, 400000.0),
                            (400000.0, 500000.0),
                            (600000.0, 7000000.0),
                            (7000000.0, 800000.0),
                            (800000.0, 900000.0),
                            (10000000.0, 1100000.0),
                            (11000000.0, 1200000.0),
                            (12000000.0, 1300000.0)) AS f (min_sum, max_sum)
ON total_amount > f.min_sum and total_amount < f.max_sum
group by f.max_sum, f.min_sum
ORDER BY min_sum;



-- task17
SELECT DISTINCT arrival_city
FROM routes
WHERE departure_city in ('Москва', 'Санкт-Петербург');

-- task18
SELECT arrival_city
FROM routes
WHERE departure_city in ('Москва')
INTERSECT
SELECT arrival_city
FROM routes
WHERE departure_city in ('Санкт-Петербург');

-- task19
SELECT arrival_city
FROM routes
WHERE departure_city not in ('Москва')
INTERSECT
SELECT arrival_city
FROM routes
WHERE departure_city in ('Санкт-Петербург');

-- task20
SELECT COUNT(*)
FROM routes
WHERE departure_city in ('Москва');

-- task21
SELECT COUNT(*)
FROM flights_v;

-- task22
SELECT departure_city, COUNT(*) as count
FROM routes
GROUP BY departure_city
HAVING COUNT(*) >= 15;

-- task23
SELECT city, COUNT(*)
FROM airports
GROUP BY city
HAVING COUNT(*) > 1;


-- task24
EXPLAIN SELECT
  book_ref,
  book_date,
  EXTRACT(MONTH FROM book_date) AS month,
  EXTRACT(DAY FROM book_date) AS day,
  SUM(count) OVER (PARTITION BY EXTRACT(MONTH FROM book_date) ORDER BY book_date) AS cumulative_count
FROM (
  SELECT
    book_ref,
    book_date,
    COUNT(*) AS count
  FROM bookings
  GROUP BY book_ref, book_date
) AS ticket_counts
ORDER BY book_date;
