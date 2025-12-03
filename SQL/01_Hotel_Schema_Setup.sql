-- HOTEL MANAGEMENT DATABASE SCHEMA

CREATE DATABASE IF NOT EXISTS hotel_db;
USE hotel_db;

-- Users Table
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(100),
    email VARCHAR(100)
);

-- Rooms Table
CREATE TABLE rooms (
    room_id INT PRIMARY KEY,
    room_type VARCHAR(50),
    rate DECIMAL(10,2)
);

-- Bookings Table
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY,
    user_id INT,
    room_id INT,
    booking_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

-- Items Table
CREATE TABLE items (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(100),
    rate DECIMAL(10,2)
);

-- Booking Commercials Table
CREATE TABLE booking_commercials (
    commercial_id INT PRIMARY KEY,
    booking_id INT,
    item_id INT,
    quantity INT,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

-- SAMPLE DATA INSERTION

INSERT INTO users VALUES
(1, 'Ravi', 'ravi@gmail.com'),
(2, 'Priya', 'priya@gmail.com'),
(3, 'Amit', 'amit@gmail.com');

INSERT INTO rooms VALUES
(101, 'Deluxe', 2000),
(102, 'Standard', 1500),
(103, 'Suite', 3000);

INSERT INTO bookings VALUES
(1, 1, 101, '2021-11-05'),
(2, 2, 102, '2021-11-20'),
(3, 3, 103, '2021-12-02');

INSERT INTO items VALUES
(1, 'Breakfast', 200),
(2, 'Lunch', 300),
(3, 'Laundry', 150);

INSERT INTO booking_commercials VALUES
(1, 1, 1, 2),
(2, 1, 2, 1),
(3, 2, 1, 1),
(4, 3, 3, 3);
