-- task1
SELECT departure_city, arrival_city
FROM routes
         JOIN aircrafts USING (aircraft_code)
WHERE model LIKE 'Боинг 777-300';

-- task2
SELECT departure_city, COUNT(DISTINCT arrival_city)
FROM routes
group by departure_city;

-- task3
SELECT arrival_city, COUNT(*)
FROM routes
WHERE departure_city LIKE 'Москва'
  AND days_of_week = ARRAY [1, 2, 3, 4, 5, 6, 7]
GROUP BY arrival_city
ORDER BY 2 DESC
LIMIT 5;

-- task4
SELECT COUNT(*)
FROM routes
WHERE departure_city LIKE 'Москва'
  AND days_of_week = ARRAY [1, 2, 3, 4, 5, 6, 7];

-- task5
SELECT flight_no, MAX(amount), MIN(amount)
FROM ticket_flights
         JOIN flights USING (flight_id)
GROUP BY flight_no;

-- task6
SELECT flight_no
FROM ticket_flights
         JOIN flights USING (flight_id)
         RIGHT JOIN routes USING (flight_no)
WHERE amount is NULL
GROUP BY flight_no;

-- task7
SELECT split_part(passenger_name, ' ', 1) as first_name, COUNT(*)
FROM tickets
GROUP BY 1;

-- task8
SELECT COUNT(f.*)
FROM (SELECT DISTINCT departure_airport, arrival_airport FROM routes) as f;

-- task9
SELECT COUNT(*)
FROM bookings
WHERE total_amount > (SELECT AVG(total_amount) FROM bookings);

-- task10
SELECT *
FROM routes
         JOIN (SELECT airport_code, timezone FROM airports) as f1 ON routes.arrival_airport = f1.airport_code
         JOIN (SELECT airport_code, timezone FROM airports) as f2 ON routes.departure_airport = f2.airport_code
WHERE f1.timezone = f2.timezone
  and f1.timezone LIKE 'Asia/Krasnoyarsk';

-- task11
SELECT *
FROM airports
WHERE coordinates[1] = (SELECT MAX(coordinates[1]) FROM airports)
   or coordinates[1] = (SELECT MIN(coordinates[1]) FROM airports);

-- task12
SELECT DISTINCT arrival_city
FROM flights_v
WHERE departure_city not LIKE 'Москва';

-- task13
/*SELECT model,
       (SELECT COUNT(fare_conditions)
        FROM seats
        WHERE aircrafts.aircraft_code = seats.aircraft_code
          and fare_conditions = 'Economy') as Economy,
       (SELECT COUNT(fare_conditions)
        FROM seats
        WHERE aircrafts.aircraft_code = seats.aircraft_code
          and fare_conditions = 'Business') as Business,
       (SELECT COUNT(fare_conditions)
        FROM seats
        WHERE aircrafts.aircraft_code = seats.aircraft_code
          and fare_conditions = 'Comfort') as Comfort
FROM aircrafts;
*/

-- task14
SELECT city, airport_code, airport_name FROM airports
WHERE  (SELECT COUNT(airport_code) as count FROM airports as f WHERE f.city = airports.city GROUP BY  f.city) > 1;

-- task15
SELECT COUNT(*) FROM routes
         JOIN (SELECT airport_code, coordinates FROM airports) as f2 ON routes.departure_airport = f2.airport_code
WHERE coordinates[0] > 150;

-- task16
SELECT FROM flights
    JOIN


