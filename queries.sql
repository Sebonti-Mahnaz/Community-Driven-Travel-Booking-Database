-- Community Driven Travel Booking Database
-- SQL Analysis Queries

-- Query 1: List destinations that have an average rating higher than 4.3
SELECT d.name AS destination,
       AVG(r.rating) AS average_rating
FROM Destination d
INNER JOIN Travel_Review r
    ON d.destination_id = r.destination_id
GROUP BY d.name
HAVING AVG(r.rating) > 4.3;


-- Query 2: Retrieve customer names, reviews, and ratings
-- for Kyoto Imperial Palace
SELECT u.first_name,
       u.last_name,
       tr.experience_details,
       tr.rating,
       d.name
FROM User u
INNER JOIN Customer c
    ON u.user_id = c.user_id
INNER JOIN Travel_Review tr
    ON c.user_id = tr.customer_user_id
INNER JOIN Destination d
    ON tr.destination_id = d.destination_id
WHERE d.name = 'Kyoto Imperial Palace';


-- Query 3: Count bookings managed by each agent
SELECT a.user_id,
       u.first_name,
       u.last_name,
       COUNT(b.booking_id) AS total_bookings
FROM User u
INNER JOIN Agent a
    ON u.user_id = a.user_id
INNER JOIN Booking b
    ON a.user_id = b.agent_user_id
GROUP BY a.user_id, u.first_name, u.last_name
ORDER BY total_bookings;


-- Query 4: Find bookings for each customer and associated agent specialty
-- Include bookings even when there is no associated agent
SELECT b.booking_id,
       b.customer_user_id,
       b.agent_user_id,
       a.speciality
FROM Booking b
LEFT JOIN Agent a
    ON b.agent_user_id = a.user_id;


-- Query 5: Retrieve destinations suitable for Weekend Trips and Long Trips,
-- including popularity rating and total bookings
SELECT d.name,
       d.popularity_rating,
       COUNT(b.booking_id) AS total_bookings
FROM Destination d
INNER JOIN Booking b
    ON d.destination_id = b.destination_id
INNER JOIN Trip_Type t
    ON b.trip_type_id = t.trip_type_id
WHERE t.description_trip_type = 'Weekend Trip'
   OR t.description_trip_type = 'Long Trip'
GROUP BY d.name, d.popularity_rating
ORDER BY total_bookings DESC;
