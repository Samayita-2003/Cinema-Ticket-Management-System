-- Create the database
CREATE DATABASE CinemaBookingSystem;

-- Use the database
USE CinemaBookingSystem;

-- Create Movies table
CREATE TABLE Movies (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    genre VARCHAR(50),
    duration INT, -- duration in minutes
    release_date DATE
);

-- Create Showtimes table
CREATE TABLE Showtimes (
    showtime_id INT PRIMARY KEY AUTO_INCREMENT,
    movie_id INT,
    show_date DATE,
    show_time TIME,
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

-- Create Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone_number VARCHAR(15)
);

-- Create Bookings table
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    showtime_id INT,
    customer_id INT,
    number_of_tickets INT,
    booking_date DATE,
    FOREIGN KEY (showtime_id) REFERENCES Showtimes(showtime_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
-- Insert data into Movies table
INSERT INTO Movies (title, genre, duration, release_date) VALUES
('Inception', 'Sci-Fi', 148, '2010-07-16'),
('The Dark Knight', 'Action', 152, '2008-07-18'),
('Interstellar', 'Sci-Fi', 169, '2014-11-07');

-- Insert data into Showtimes table
INSERT INTO Showtimes (movie_id, show_date, show_time) VALUES
(1, '2024-09-01', '14:00:00'),
(1, '2024-09-01', '18:00:00'),
(2, '2024-09-01', '16:00:00'),
(3, '2024-09-02', '20:00:00');

-- Insert data into Customers table
INSERT INTO Customers (name, email, phone_number) VALUES
('John Doe', 'john.doe@example.com', '123-456-7890'),
('Jane Smith', 'jane.smith@example.com', '234-567-8901');

-- Insert data into Bookings table
INSERT INTO Bookings (showtime_id, customer_id, number_of_tickets, booking_date) VALUES
(1, 1, 2, '2024-08-31'),
(3, 2, 1, '2024-08-31');

SELECT * FROM Movies;

SELECT S.showtime_id, S.show_date, S.show_time, M.title 
FROM Showtimes S
JOIN Movies M ON S.movie_id = M.movie_id
WHERE M.title = 'Inception';

SELECT B.booking_id, C.name, M.title, S.show_date, S.show_time, B.number_of_tickets
FROM Bookings B
JOIN Customers C ON B.customer_id = C.customer_id
JOIN Showtimes S ON B.showtime_id = S.showtime_id
JOIN Movies M ON S.movie_id = M.movie_id
WHERE C.name = 'John Doe';

SELECT M.title, COUNT(B.booking_id) AS total_bookings
FROM Bookings B
JOIN Showtimes S ON B.showtime_id = S.showtime_id
JOIN Movies M ON S.movie_id = M.movie_id
GROUP BY M.title
ORDER BY total_bookings DESC
LIMIT 1;

SELECT C.name, M.title, B.number_of_tickets, B.booking_date
FROM Customers C
JOIN Bookings B ON C.customer_id = B.customer_id
JOIN Showtimes S ON B.showtime_id = S.showtime_id
JOIN Movies M ON S.movie_id = M.movie_id
WHERE B.booking_date = '2024-08-31';

