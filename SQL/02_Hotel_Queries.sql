-- PART A: HOTEL SYSTEM ANALYSIS QUERIES

USE hotel_db;

-- Q1: Last Booked Room
SELECT room_id, MAX(booking_date) AS last_booking_date
FROM bookings
GROUP BY room_id
ORDER BY last_booking_date DESC
LIMIT 1;

-- Q2: Billing in November 2021
SELECT b.booking_id,
       SUM(bc.quantity * i.rate) AS total_bill
FROM bookings b
JOIN booking_commercials bc ON b.booking_id = bc.booking_id
JOIN items i ON bc.item_id = i.item_id
WHERE MONTH(b.booking_date) = 11 AND YEAR(b.booking_date) = 2021
GROUP BY b.booking_id;

-- Q3: Bills Greater Than 1000
SELECT b.booking_id,
       SUM(bc.quantity * i.rate) AS total_bill
FROM bookings b
JOIN booking_commercials bc ON b.booking_id = bc.booking_id
JOIN items i ON bc.item_id = i.item_id
GROUP BY b.booking_id
HAVING total_bill > 1000;

-- Q4: Most and Least Ordered Item Per Month
SELECT
    MONTH(b.booking_date) AS month,
    i.item_name,
    SUM(bc.quantity) AS total_quantity
FROM bookings b
JOIN booking_commercials bc ON b.booking_id = bc.booking_id
JOIN items i ON bc.item_id = i.item_id
GROUP BY month, i.item_name
ORDER BY month, total_quantity DESC;

-- Q5: Second Highest Bill
SELECT booking_id, total_bill
FROM (
    SELECT b.booking_id,
           SUM(bc.quantity * i.rate) AS total_bill,
           DENSE_RANK() OVER (ORDER BY SUM(bc.quantity * i.rate) DESC) AS rnk
    FROM bookings b
    JOIN booking_commercials bc ON b.booking_id = bc.booking_id
    JOIN items i ON bc.item_id = i.item_id
    GROUP BY
