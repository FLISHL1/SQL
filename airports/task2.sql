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
SELECT city, airport_code, airport_name
FROM airports
WHERE (SELECT COUNT(airport_code) as count FROM airports as f WHERE f.city = airports.city GROUP BY f.city) > 1;

-- task15
SELECT COUNT(*)
FROM routes
         JOIN (SELECT airport_code, coordinates FROM airports) as f2 ON routes.departure_airport = f2.airport_code
WHERE coordinates[0] > 150;

-- task16
SELECT flight_id,
       aircraft_code,
       ((COUNT(ticket_flights) * 100) /
        (SELECT COUNT(*) FROM seats WHERE seats.aircraft_code = flights_v.aircraft_code)) as f
FROM flights_v
         JOIN ticket_flights USING (flight_id)
GROUP BY flight_id, aircraft_code;

-- task17
SELECT boarding_passes.seat_no, passenger_name, seats.fare_conditions
FROM flights_v
         JOIN boarding_passes USING (flight_id)
         JOIN seats ON seats.aircraft_code = flights_v.aircraft_code and seats.seat_no = boarding_passes.seat_no
         JOIN tickets USING (ticket_no)
WHERE flight_id = 3993;

-- task18
CREATE OR replace FUNCTION getBooking(id char(6))
    RETURNS TABLE
            (
                book_ref        char,
                passenger_name  text,
                contact_data    jsonb,
                ticket_no       char,
                flight_id       integer,
                fare_conditions varchar(10),
                amount          numeric(10, 2)
            )
as
$$
BEGIN
    return QUERY SELECT bookings.book_ref,
                        tickets.passenger_name,
                        tickets.contact_data,
                        tickets.ticket_no,
                        ticket_flights.flight_id,
                        ticket_flights.fare_conditions,
                        ticket_flights.amount
                 FROM bookings
                          JOIN tickets USING (book_ref)
                          JOIN ticket_flights USING (ticket_no)
                 WHERE bookings.book_ref = id;
end;
$$
    LANGUAGE plpgsql;
SELECT getBooking('00000F');

-- task19
/*CREATE OR REPLACE PROCEDURE createBooking(dateDeparture date, departure char(3), arrival char(3))
LANGUAGE sql
as $$

$$;*/
/*CREATE OR REPLACE FUNCTION create_booking(
    departure_airport_code VARCHAR,
    destination_airport_code VARCHAR,
    flight_date DATE
) RETURNS INTEGER AS $$
DECLARE
    booking_id INTEGER;
BEGIN
    -- Создание нового бронирования
    INSERT INTO bookings (book_ref, book_date, total_amount) VALUES
                                                                 ('13211', now(), 100000);

    -- Находим перелеты с максимум двумя пересадками
    WITH RECURSIVE FlightPaths AS (
        SELECT
            f.flight_id AS start_flight,
            f.departure_airport AS layover1,
            f.arrival_airport AS layover2,
            f.flight_id AS end_flight,
            0 AS layover_count
        FROM flights f
        WHERE f.departure_airport = 'DME'
          AND f.arrival_airport = 'REN'
          AND f.scheduled_departure::DATE = '2017-09-10'
        UNION ALL
        SELECT
            fp.start_flight,
            f.departure_airport AS layover1,
            fp.layover1 AS layover2,
            f.flight_id AS end_flight,
            fp.layover_count + 1
        FROM FlightPaths fp
                 JOIN flights f ON fp.layover2 = f.departure_airport
        WHERE fp.layover_count < 2
    )
    SELECT * fROM FlightPaths;
    -- Добавляем перелеты в билет
    INSERT INTO ticket_flights (ticket_no, flight_id)
    SELECT '123', start_flight
    FROM FlightPaths
    WHERE layover_count = 0;

    RETURN booking_id;
END;
$$ LANGUAGE plpgsql;
SELECT create_booking('DME', 'BTK', '2017-09-10')*/

-- CREATE PROCEDURE addPassagier(book_ref char(6))

-- task20
CREATE OR REPLACE PROCEDURE add_passenger_to_booking(
    p_book_ref char(6),
    p_passenger_id varchar(20),
    p_passenger_name text,
    p_contact_data jsonb
)
AS
$$
DECLARE
    v_flight record;
    v_ticket_no char(13);
BEGIN
    IF not exists(SELECT *
                  FROM flights f
                  WHERE f.flight_id in (SELECT flight_id
                                        FROM ticket_flights
                                        WHERE ticket_no IN (SELECT ticket_no FROM tickets WHERE book_ref = p_book_ref))
                    AND (SELECT COUNT(tf.ticket_no)
                         FROM ticket_flights tf
                         WHERE tf.flight_id = f.flight_id) < (SELECT COUNT(s.seat_no)
                                                              FROM seats s
                                                              WHERE s.aircraft_code = f.aircraft_code)) THEN
        RAISE EXCEPTION 'На рейсе нет свободных мест';
    END IF;

    v_ticket_no := substr(md5(random()::text), 1, 13);
    FOR v_flight in (SELECT *
                FROM flights f
                WHERE f.flight_id in (SELECT flight_id
                                      FROM ticket_flights
                                      WHERE ticket_no IN (SELECT ticket_no FROM tickets WHERE book_ref = p_book_ref))
                  AND (SELECT COUNT(tf.ticket_no)
                       FROM ticket_flights tf
                       WHERE tf.flight_id = f.flight_id) < (SELECT COUNT(s.seat_no)
                                                            FROM seats s
                                                            WHERE s.aircraft_code = f.aircraft_code))
        LOOP
            if not exists(SELECT * FROM tickets WHERE v_ticket_no = ticket_no) THEN

            INSERT INTO tickets (ticket_no, book_ref, passenger_id, passenger_name, contact_data)
            VALUES (v_ticket_no, p_book_ref, p_passenger_id, p_passenger_name, p_contact_data);
            END IF;

            INSERT INTO ticket_flights (ticket_no, flight_id, fare_conditions, amount)
            VALUES (v_ticket_no, v_flight.flight_id, 'Economy', 0.0);
        END LOOP;

    COMMIT;
END;
$$ LANGUAGE plpgsql;
CALL add_passenger_to_booking('A1AD46', '135', 'Конопский Кирилл', '{"phone": "+70127117011"}');


-- task21
CREATE OR REPLACE FUNCTION check_departure_from_moscow()
    RETURNS TRIGGER AS
$$
BEGIN
    IF (SELECT departure_city FROM flights_v WHERE NEW.flight_id = flights_v.flight_id) = 'Москва' THEN
        RAISE EXCEPTION 'Вылет из Москвы запрещен';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_departure_trigger
    BEFORE INSERT
    ON ticket_flights
    FOR EACH ROW
EXECUTE FUNCTION check_departure_from_moscow();

INSERT INTO ticket_flights (ticket_no, flight_id, fare_conditions, amount)
VALUES ('0005432000987', '1185', 'dsf', 1000);


-- task22
CREATE OR REPLACE FUNCTION update_available_seats()
    RETURNS TRIGGER AS
$$
BEGIN
    IF TG_OP = 'INSERT' THEN
        IF NEW.departure_date >= CURRENT_DATE AND NEW.departure_date < CURRENT_DATE + 1 THEN
            INSERT INTO available_seats_info (flight_id, available_seats)
            SELECT NEW.flight_id, a.total_seats
            FROM flights AS f
                     JOIN aircrafts AS a ON f.aircraft_id = a.aircraft_id
            WHERE f.flight_id = NEW.flight_id;
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

