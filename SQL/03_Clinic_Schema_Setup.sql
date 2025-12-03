-- CLINIC MANAGEMENT DATABASE SCHEMA

CREATE DATABASE IF NOT EXISTS clinic_db;
USE clinic_db;

-- Clinics Table
CREATE TABLE clinics (
    cid         VARCHAR(20) PRIMARY KEY,
    clinic_name VARCHAR(200),
    city        VARCHAR(100),
    state       VARCHAR(100),
    country     VARCHAR(100)
);

-- Customer Table
CREATE TABLE customer (
    cust_id   VARCHAR(20) PRIMARY KEY,
    cust_name VARCHAR(200),
    city      VARCHAR(100),
    state     VARCHAR(100),
    country   VARCHAR(100)
);

-- Clinic Sales Table
CREATE TABLE clinic_sales (
    sid           INT PRIMARY KEY AUTO_INCREMENT,
    cid           VARCHAR(20),
    cust_id       VARCHAR(20),
    sales_channel VARCHAR(50),
    amount        DECIMAL(10,2),
    datetime      DATETIME,
    FOREIGN KEY (cid)     REFERENCES clinics(cid),
    FOREIGN KEY (cust_id) REFERENCES customer(cust_id)
);

-- Expenses Table
CREATE TABLE expenses (
    eid      INT PRIMARY KEY AUTO_INCREMENT,
    cid      VARCHAR(20),
    amount   DECIMAL(10,2),
    datetime DATETIME,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

-- Sample Data
INSERT INTO clinics (cid, clinic_name, city, state, country) VALUES
('cnc-010001','GreenCare Clinic','Hyderabad','Telangana','India'),
('cnc-010002','Sunrise Clinic','Bengaluru','Karnataka','India'),
('cnc-010003','HealthFirst','Hyderabad','Telangana','India');

INSERT INTO customer (cust_id, cust_name, city, state, country) VALUES
('cus-001','Amit','Hyderabad','Telangana','India'),
('cus-002','Priya','Bengaluru','Karnataka','India'),
('cus-003','Rahul','Hyderabad','Telangana','India'),
('cus-004','Sneha','Hyderabad','Telangana','India');

INSERT INTO clinic_sales (cid, cust_id, sales_channel, amount, datetime) VALUES
('cnc-010001','cus-001','Online', 3000.00,'2021-03-05 10:10:00'),
('cnc-010001','cus-003','Offline',2000.00,'2021-03-10 11:30:00'),
('cnc-010002','cus-002','Online', 2500.00,'2021-03-08 12:00:00'),
('cnc-010003','cus-004','Offline',4000.00,'2021-03-09 09:45:00');

INSERT INTO expenses (cid, amount, datetime) VALUES
('cnc-010001',1000.00,'2021-03-31 18:00:00'),
('cnc-010002',1500.00,'2021-03-31 18:00:00'),
('cnc-010003',2000.00,'2021-03-31 18:00:00');
