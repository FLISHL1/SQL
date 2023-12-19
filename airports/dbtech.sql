-- Задание 12.1


EXPLAIN ANALYZE SELECT *
FROM bookings
         JOIN tickets USING (book_ref)
         JOIN ticket_flights USING (ticket_no)
         JOIN flights USING (flight_id)
WHERE passenger_name = 'GALINA AFANASEVA'
  AND scheduled_departure BETWEEN '2017-07-15' AND '2017-09-16';

CREATE INDEX passanger_name_tickets
ON tickets (passenger_name);

-- Задание 12.2
EXPLAIN ANALYZE SELECT DISTINCT (flight_no), departure_airport, arrival_airport, scheduled_departure FROM flights
WHERE departure_airport LIKE 'DME' and arrival_airport LIKE 'LED' and DATE(scheduled_departure) = '2017-08-05';

CREATE INDEX airport_schedule_flights_idx
ON flights (departure_airport, arrival_airport, scheduled_departure);

-- Задание 12.3
SET enable_indexscan = true;

-- Задание 12.4
SELECT * FROM pg_stats;
SELECT * FROM pg_statistic;

-- Задание 12.5