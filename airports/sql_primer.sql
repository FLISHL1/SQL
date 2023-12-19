EXPLAIN
SELECT *
FROM bookings
ORDER BY book_date, book_ref;

-- Задание 1 так как по мимо того что используется индекс в оценку стоимости еще учитывается затраты процессора и проход по таблицам и т.д.
-- Задание 2 Нет не всегда например когда порядок указанный в ORDER BY не совпадает с порядком индекса,
-- либо же таблица может оказаться слишком маленькой и оптимизатор посчитает исопльзование индекса не рациональным
EXPLAIN
SELECT *
FROM bookings
ORDER BY book_date, book_ref;
-- Задание 3
EXPLAIN
SELECT bookings.*, (SELECT COUNT(*) FROM boarding_passes)
FROM bookings
ORDER BY book_ref;
-- Задание 4
EXPLAIN
SELECT total_amount
FROM bookings
ORDER BY total_amount DESC
LIMIT 5;
/*
 Limit (cost=8666.69..8666.71 rows=5 width=6) - указание лимита
-> Sort (cost=8666.69..9323.66 rows=262788 width=6) - оценка затрат сортировки
Sort Key: total_amount DESC - ключ по которому сортируем
-> Seq Scan on bookings (cost=0.00..4301.88 rows=262788 width=6) - проходимся по всей таблицы для сортировки данных
 */

--  Задание 5, Оценки стоимости (cost) для различных узлов плана запроса могут отличаться из-за различных методов обработки данных.
--  В данном случае, Seq Scan оценивается как более дешевая операция, чем HashAggregate,
--  поэтому у Seq Scan более низкая оценка стоимости.
EXPLAIN
SELECT city, count(*)
FROM airports
GROUP BY city
HAVING count(*) > 1;

-- Задание 6 - В данном случае WindowAgg выполняется позднее так как сначала у нас выполняется оконная функция,
-- а потом уже происходит сортировка данных, что можно увидет уже при выполнении самого запроса
EXPLAIN
SELECT city, row_number() over ()
FROM airports
ORDER BY city;

-- Задание 7
explain
INSERT INTO seats(aircraft_code, seat_no, fare_conditions)
VALUES (319, '2A', 'Business');

explain
DELETE
FROM seats
WHERE aircraft_code = '319';

-- Задание 8
EXPLAIN ANALYZE
SELECT a.aircraft_code                           AS a_code,
       a.model,
       (SELECT count(r.aircraft_code)
        FROM routes r
        WHERE r.aircraft_code = a.aircraft_code) AS num_routes
FROM aircrafts a
GROUP BY 1, 2
ORDER BY 3 DESC;

EXPLAIN ANALYZE
SELECT a.aircraft_code        AS a_code,
       a.model,
       count(r.aircraft_code) AS num_routes
FROM aircrafts a
         LEFT OUTER JOIN routes r
                         ON r.aircraft_code = a.aircraft_code
GROUP BY 1, 2
ORDER BY 3 DESC;

-- Аналогичный запрос

EXPLAIN
SELECT flight_no,
       MAX((SELECT amount FROM ticket_flights WHERE flights.flight_id = ticket_flights.flight_id)),
       MIN((SELECT amount FROM ticket_flights WHERE flights.flight_id = ticket_flights.flight_id))
FROM flights
GROUP BY flight_no;

EXPLAIN
SELECT flight_no, MAX(amount), MIN(amount)
FROM ticket_flights
         JOIN flights USING (flight_id)
GROUP BY flight_no;


-- Задание 9

EXPLAIN ANALYZE
SELECT *
FROM routes;

EXPLAIN ANALYSE
WITH f3 AS (SELECT f2.flight_no,
                   f2.departure_airport,
                   f2.arrival_airport,
                   f2.aircraft_code,
                   f2.duration,
                   array_agg(f2.days_of_week) AS days_of_week
            FROM (SELECT f1.flight_no,
                         f1.departure_airport,
                         f1.arrival_airport,
                         f1.aircraft_code,
                         f1.duration,
                         f1.days_of_week
                  FROM (SELECT flights.flight_no,
                               flights.departure_airport,
                               flights.arrival_airport,
                               flights.aircraft_code,
                               flights.scheduled_arrival - flights.scheduled_departure   AS duration,
                               to_char(flights.scheduled_departure, 'ID'::text)::integer AS days_of_week
                        FROM flights) f1
                  GROUP BY f1.flight_no, f1.departure_airport, f1.arrival_airport, f1.aircraft_code, f1.duration,
                           f1.days_of_week
                  ORDER BY f1.flight_no, f1.departure_airport, f1.arrival_airport, f1.aircraft_code, f1.duration,
                           f1.days_of_week) f2
            GROUP BY f2.flight_no, f2.departure_airport, f2.arrival_airport, f2.aircraft_code, f2.duration)
SELECT f3.flight_no,
       f3.departure_airport,
       dep.airport_name AS departure_airport_name,
       dep.city         AS departure_city,
       f3.arrival_airport,
       arr.airport_name AS arrival_airport_name,
       arr.city         AS arrival_city,
       f3.aircraft_code,
       f3.duration,
       f3.days_of_week
FROM f3,
     airports dep,
     airports arr
WHERE f3.departure_airport = dep.airport_code
  AND f3.arrival_airport = arr.airport_code;


-- Задание 10
EXPLAIN ANALYZE
SELECT b.book_ref, sum(tf.amount)
FROM bookings b,
     tickets t,
     ticket_flights tf
WHERE b.book_ref = t.book_ref
  AND t.ticket_no = tf.ticket_no
GROUP BY 1
ORDER BY 1;

EXPLAIN ANALYZE
SELECT book_ref, total_amount
FROM bookings
ORDER BY 1;

CREATE FUNCTION count_pass(book_ref1 varchar(50))
    RETURNS int AS
$$
BEGIN
    return (SELECT COUNT(ticket_no)
            FROM bookings
                     JOIN tickets on bookings.book_ref = tickets.book_ref
            WHERE tickets.book_ref = book_ref1);

End;
$$ LANGUAGE plpgsql;


EXPLAIN ANALYSE
SELECT bookings.book_ref, COUNT(ticket_no)
FROM bookings
         JOIN tickets on bookings.book_ref = tickets.book_ref
group by 1;

EXPLAIN ANALYSE
SELECT bookings.book_ref, count_pass
FROM bookings;

-- Задание 11
CREATE TEMP TABLE flights_tt AS
SELECT *
FROM flights_v;

EXPLAIN ANALYZE
SELECT *
FROM flights_v;

EXPLAIN ANALYZE
SELECT *
FROM flights_tt;


-- Аналогичный запрос
CREATE TEMP TABLE airports_tt AS
SELECT *
FROM airports
ORDER BY coordinates[1] DESC
LIMIT 3;

EXPLAIN ANALYSE
SELECT *
FROM airports
ORDER BY coordinates[1] DESC
LIMIT 3;

EXPLAIN ANALYSE
SELECT *
FROM airports_tt;

-- Задание 12
EXPLAIN ANALYZE
SELECT count(*)
FROM tickets
WHERE passenger_name = 'IVAN IVANOV';

CREATE INDEX passenger_name_key
    ON tickets (passenger_name);



EXPLAIN ANALYSE
SELECT b.book_ref, count(*)
FROM tickets
         JOIN bookings.bookings b on b.book_ref = tickets.book_ref
WHERE passenger_name = 'IVAN IVANOV'
GROUP BY 1;

CREATE INDEX tickets_book_ref_key
    ON tickets (book_ref);

-- Задание 13
EXPLAIN ANALYZE
SELECT num_tickets, count(*) AS num_bookings
FROM (SELECT b.book_ref, count(*)
      FROM bookings b,
           tickets t
      WHERE date_trunc('month', b.book_date) = '2017-06-01'
        AND t.book_ref = b.book_ref
      GROUP BY b.book_ref) AS count_tickets(book_ref, num_tickets)
GROUP by num_tickets
ORDER BY num_tickets DESC;

SET enable_nestloop = on;
SET enable_hashjoin = off;
CREATE INDEX tickets_book_ref_key
    ON tickets (book_ref);
/*
    В случае когда включены и NestLoop и HashJoin используется индекс таблицы tickets
    В случае когда включен только HashJoin используется также только индекс таблицы tickets
    В случае когда включен только NestLoop также только индекс таблицы tickets
    В случае когда все выклюенно используется также  только индекс таблицы tickets
*/

-- Задание 14
CREATE TABLE nulls AS
SELECT num::integer, 'TEXT' || num::text AS txt
FROM generate_series( 1, 200000 ) AS gen_ser( num );

CREATE INDEX nulls_ind
ON nulls ( num DESC );

INSERT INTO nulls
VALUES ( NULL, 'TEXT' );

EXPLAIN
SELECT *
FROM nulls
ORDER BY num;

SELECT *
FROM nulls
ORDER BY num
OFFSET 199995;

EXPLAIN
SELECT *
FROM nulls
ORDER BY num NULLS FIRST;

EXPLAIN
SELECT *
FROM nulls
ORDER BY num DESC NULLS FIRST;
-- Слово Backward означает что происходит индексное сканирование в обратном порядке

EXPLAIN
SELECT *
FROM nulls
ORDER BY num NULLS FIRST;

CREATE INDEX nulls_ind
ON nulls ( num NUllS FIRST );

EXPLAIN
SELECT *
FROM nulls
ORDER BY num DESC NULLS FIRST;

EXPLAIN
SELECT *
FROM nulls
ORDER BY num DESC NULLS LAST;

-- Задание 15
EXPLAIN ANALYZE SELECT * FROM aircrafts WHERE range BETWEEN 3000 AND 6000;

EXPLAIN ANALYZE SELECT model, range, range / 1.609 AS miles FROM aircrafts;


EXPLAIN ANALYZE SELECT model, range, round( range / 1.609, 2 ) AS miles
FROM aircrafts;

EXPLAIN ANALYZE SELECT * FROM aircrafts ORDER BY range DESC;

EXPLAIN ANALYZE SELECT DISTINCT timezone FROM airports ORDER BY 1;

EXPLAIN ANALYZE SELECT model, range,
CASE WHEN range < 2000 THEN 'Ближнемагистральный'
WHEN range < 5000 THEN 'Среднемагистральный'
ELSE 'Дальнемагистральный'
END AS type
FROM aircrafts
ORDER BY model;

EXPLAIN ANALYZE SELECT a.aircraft_code, a.model, s.seat_no, s.fare_conditions
FROM seats AS s
JOIN aircrafts AS a
ON s.aircraft_code = a.aircraft_code
WHERE a.model ~ '^Cessna'
ORDER BY s.seat_no;

EXPLAIN ANALYZE SELECT s.seat_no, s.fare_conditions
FROM seats s
JOIN aircrafts a ON s.aircraft_code = a.aircraft_code
WHERE a.model ~ '^Cessna'
ORDER BY s.seat_no;

EXPLAIN ANALYZE SELECT a.aircraft_code, a.model, s.seat_no, s.fare_conditions
FROM seats s, aircrafts a
WHERE s.aircraft_code = a.aircraft_code
AND a.model ~ '^Cessna'
ORDER BY s.seat_no;

EXPLAIN ANALYZE SELECT count( * )
FROM airports a1, airports a2
WHERE a1.city <> a2.city;

EXPLAIN ANALYZE SELECT r.aircraft_code, a.model, count( * ) AS num_routes
FROM routes r
JOIN aircrafts a ON r.aircraft_code = a.aircraft_code
GROUP BY 1, 2
ORDER BY 3 DESC;

-- Задание 16

SET enable_hashjoin = off;
SET enable_mergejoin = off;
SET enable_nestloop = off;


EXPLAIN
SELECT a.model, count( * )
FROM aircrafts a, seats s
WHERE a.aircraft_code = s.aircraft_code
GROUP BY a.model;