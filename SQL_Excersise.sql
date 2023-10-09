CREATE DATABASE Hotel_Details
USE Hotel_Details
GO

CREATE TABLE hotel
( hotel_no VARCHAR(4) NOT NULL,
name VARCHAR(20) NOT NULL,
address VARCHAR(50) NOT NULL);

CREATE TABLE room
( room_no VARCHAR(4) NOT NULL,
hotel_no VARCHAR(4) NOT NULL,
type CHAR(1) NOT NULL,
price DECIMAL(5,2) NOT NULL);

CREATE TABLE booking
(hotel_no VARCHAR(4) NOT NULL,
guest_no VARCHAR(4) NOT NULL,
date_from DATETIME NOT NULL,
date_to DATETIME NULL,
room_no VARCHAR(4) NOT NULL);


CREATE TABLE guest
( guest_no VARCHAR(4) NOT NULL,
name VARCHAR(20) NOT NULL,
address VARCHAR(50) NOT NULL);

SELECT * FROM hotel
SELECT * FROM room
SELECT * FROM booking
SELECT * FROM guest

INSERT INTO hotel VALUES('H111', 'Grosvenor Hotel', 'London');

INSERT INTO room
VALUES ('1', 'H111', 'S', 72.00);
INSERT INTO room
VALUES ('2', 'H112', 'L', 40.00);
INSERT INTO room
VALUES ('3', 'H113', 'F', 40.00);
INSERT INTO room
VALUES ('4', 'H114', 'S', 35.00);

INSERT INTO guest
VALUES ('G111', 'John Smith', 'London');

INSERT INTO guest
VALUES ('G112', 'Emily Thomas', 'New York');

INSERT INTO guest
VALUES ('G113', 'Adam Gilchrist', 'Argentina');

INSERT INTO guest
VALUES ('G114', 'Anthony Richi', 'London');

INSERT INTO booking
VALUES ('H111', 'G111','1999-01-01','1999-01-02', '1');

UPDATE room SET price = price*1.05;

CREATE TABLE booking_old
( hotel_no CHAR(4) NOT NULL,
guest_no CHAR(4) NOT NULL,
date_from DATETIME NOT NULL,
date_to DATETIME NULL,
room_no VARCHAR(4) NOT NULL)

SELECT * FROM booking_old

INSERT INTO booking_old
select * FROM booking
WHERE date_to < 2000-01-01;
DELETE FROM booking
WHERE date_to < 2000-01-01;

--1.List full details of all hotels.
SELECT * FROM hotel
--2. List full details of all hotels in London.
SELECT * FROM hotel where address='London'

--3. List the names and addresses of all guests in London, alphabetically ordered by name.
SELECT name, address FROM guest WHERE address = 'London' ORDER BY name;

--4. List all double or family rooms with a price below £40.00 per night, in ascending order of price.
SELECT * FROM room WHERE (type = 'S' OR type = 'Family') AND price < 40.00 ORDER BY price;

--5. List the bookings for which no date_to has been specified.
SELECT * FROM booking WHERE date_to IS NULL;

----------------------------Aggregate Function ------------------------------------------------
--1. How many hotels are there?
Select Count(*) as NumOfHotels from hotel;

--2. What is the average price of a room?
Select AVG(price) as AveragePrice from room;

--3. What is the total revenue per night from all double rooms?
SELECT SUM(r.price) AS total_revenue
FROM room r
JOIN booking b ON r.room_no = b.room_no
WHERE r.type = 'S';

--4. How many different guests have made bookings for August?
select *from room
select *from booking
Select *from guest

-------------------------Join and Subquery -----------------------------
--1. List the price and type of all rooms at the Grosvenor Hotel.
SELECT r.price, r.type
FROM room r
JOIN hotel h ON r.hotel_no = h.hotel_no
WHERE h.name = 'Grosvenor Hotel';

--2. List all guests currently staying at the Grosvenor Hotel.
SELECT g.name
FROM guest g
JOIN booking b ON g.guest_no= b.guest_no
JOIN room r ON b.room_no = r.room_no
JOIN hotel h ON r.hotel_no = h.hotel_no
WHERE h.name = 'Grosvenor Hotel'

--4.List the details of all rooms at the Grosvenor Hotel,including the name of the guest staying in the room, if the room is occupied.
SELECT 
    r.room_no,
    r.type,
    r.price,
    CASE
        WHEN b.guest_no IS NOT NULL THEN g.name
        ELSE 'Unoccupied'
    END AS guest_name
FROM room r
JOIN hotel h ON r.hotel_no = h.hotel_no
LEFT JOIN booking b ON r.room_no = b.room_no
LEFT JOIN guest g ON b.guest_no = g.guest_no
WHERE h.name = 'Grosvenor Hotel';

--5.List the rooms that are currently unoccupied at the  Hotel.
SELECT r.room_no, r.type
FROM room r
JOIN hotel h ON r.hotel_no = h.hotel_no
LEFT JOIN booking b ON r.room_no = b.room_no
WHERE h.name = 'Grosvenor Hotel'

--6. What is the lost income from unoccupied rooms at the Grosvenor Hotel?
SELECT SUM(r.price) AS lost_income
FROM room r
JOIN hotel h ON r.hotel_no = h.hotel_no
LEFT JOIN booking b ON r.room_no = b.room_no
WHERE h.name = 'Grosvenor Hotel'

----------------------------------Grouping-------------------------------------
-- 1. List the number of rooms in each hotel.
SELECT h.name, COUNT(r.room_no) AS num_rooms
FROM hotel h
LEFT JOIN room r ON h.hotel_no = r.hotel_no
GROUP BY h.name;

--2 List the number of rooms in each hotel in London.
SELECT h.name, COUNT(r.room_no) AS num_rooms
FROM hotel h
LEFT JOIN room r ON h.hotel_no = r.hotel_no
WHERE h.address = 'London'
GROUP BY h.name;

--3.What is the average number of bookings for each hotel in August?
SELECT h.name, AVG(b.hotel_no) AS avg_bookings
FROM hotel h
LEFT JOIN room r ON h.hotel_no = r.hotel_no
LEFT JOIN booking b ON r.room_no = b.room_no
WHERE MONTH(b.date_from) = 8
GROUP BY h.name;

--5.What is the lost income from unoccupied rooms at each hotel today?
SELECT h.name, SUM(r.price) AS lost_income
FROM hotel h
LEFT JOIN room r ON h.hotel_no = r.hotel_no
LEFT JOIN booking b ON r.room_no = b.room_no
WHERE b.date_to IS NULL
GROUP BY h.name;














