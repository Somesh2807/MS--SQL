create Database Hotel

CREATE TABLE hotel
( hotel_no CHAR(4) NOT NULL,
name VARCHAR(20) NOT NULL,
address VARCHAR(50) NOT NULL);


CREATE TABLE room
( room_no VARCHAR(4) NOT NULL,
hotel_no CHAR(4) NOT NULL,
type CHAR(1) NOT NULL,
price DECIMAL(5,2) NOT NULL);

CREATE TABLE booking
(hotel_no CHAR(4) NOT NULL,
guest_no CHAR(4) NOT NULL,
date_from DATETIME NOT NULL,
date_to DATETIME NULL,
room_no CHAR(4) NOT NULL);

CREATE TABLE guest
( guest_no CHAR(4) NOT NULL,
name VARCHAR(20) NOT NULL,
address VARCHAR(50) NOT NULL);

INSERT INTO hotel VALUES ('H111', 'Grosvenor Hotel','London') 

INSERT INTO room VALUES (1,'H111', 'S', '72.00')

INSERT INTO guest VALUES ('G111', 'John Smith', 'London')

INSERT INTO booking VALUES ('H111', 'G111','1999-01-01','1999-01-02', 1)

-- Updating Room Price 
UPDATE room SET price = price*1.05;
-- Creating Booking Table to store archieve/ deleted data

CREATE TABLE booking_old
( hotel_no CHAR(4) NOT NULL,
guest_no CHAR(4) NOT NULL,
date_from DATETIME NOT NULL,
date_to DATETIME NULL,
room_no VARCHAR(4) NOT NULL);

INSERT INTO booking_old
(select * FROM booking WHERE date_to <'2000-01-01')

DELETE FROM booking
WHERE date_to < DATE'2000-01-01';