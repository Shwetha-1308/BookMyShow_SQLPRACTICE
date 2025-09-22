# BookMyShow SQL Practice README

BookMyShow is a ticketing platform where users can book tickets for movie shows.  
For a given theatre, users can see the next 7 available dates. Upon selecting a date, the platform displays all shows running in that theatre along with their show timings.

## Technologies and Tools Used

- Database: MySQL
- SQL Concepts: Table Creation, Normalization (1NF, 2NF, 3NF, BCNF), JOIN Queries  
- Editor/IDE: MySQL Workbench 
- Version Control: Git & GitHub  

## P1 – Database Design: Entities, Attributes, and Tables

### Entities & Attributes

Theatre
- theatre_id (Primary Key)  
- theatre_name 
- location 

Movie 
- movie_id (Primary Key)  
- movie_name  
- language 
- certification (UA, A, etc.)  
- format (2D, 3D, etc.)  

MovieShow  
- show_id (Primary Key)  
- theatre_id (Foreign Key → Theatre)  
- movie_id (Foreign Key → Movie)  
- show_date 
- show_time 
- screen_type (Dolby 7.1, 4K ATMOS, Playhouse 4K, etc.)  

### SQL Database Creation

CREATE DATABASE IF NOT EXISTS bookmyshow;
USE bookmyshow;

### SQL Table Creation

--Theatre Table

CREATE TABLE Theatre (
    theatre_id INT PRIMARY KEY AUTO_INCREMENT,
    theatre_name VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL
);

-- Movie Table

CREATE TABLE Movie (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    movie_name VARCHAR(200) NOT NULL,
    language VARCHAR(50) NOT NULL,
    certification VARCHAR(10) NOT NULL,
    format VARCHAR(10) NOT NULL
);

-- MovieShow Table

CREATE TABLE MovieShow (
    show_id INT PRIMARY KEY AUTO_INCREMENT,
    theatre_id INT NOT NULL,
    movie_id INT NOT NULL,
    show_date DATE NOT NULL,
    show_time TIME NOT NULL,
    screen_type VARCHAR(50),
    FOREIGN KEY (theatre_id) REFERENCES Theatre(theatre_id),
    FOREIGN KEY (movie_id) REFERENCES Movie(movie_id)
);

Sample Data Inserts

-- Theatres

INSERT INTO Theatre (theatre_name, location)
VALUES 
('PVR: Nexus Forum', 'Bangalore'),
('INOX: Phoenix Marketcity', 'Chennai');

-- Movies

INSERT INTO Movie (movie_name, language, certification, format)
VALUES
('Dasara', 'Telugu', 'UA', '2D'),
('Kisi Ka Bhai Kisi Ki Jaan', 'Hindi', 'UA', '2D'),
('Tu Jhoothi Main Makkar', 'Hindi', 'UA', '2D'),
('Avatar: The Way of Water', 'English', 'UA', '3D');

-- MovieShow entries (Multiple dates & theatres)

INSERT INTO MovieShow (theatre_id, movie_id, show_date, show_time, screen_type)
VALUES
-- PVR: Nexus Forum (theatre_id = 1) – 25th April
(1, 1, '2023-04-25', '12:15:00', '4K Dolby 7.1'),
(1, 2, '2023-04-25', '13:00:00', '4K ATMOS'),
(1, 2, '2023-04-25', '16:10:00', '4K ATMOS'),
(1, 2, '2023-04-25', '18:20:00', '4K Dolby 7.1'),
(1, 2, '2023-04-25', '19:20:00', '4K ATMOS'),
(1, 2, '2023-04-25', '22:30:00', '4K ATMOS'),
(1, 3, '2023-04-25', '13:15:00', 'Dolby 7.1'),
(1, 4, '2023-04-25', '13:20:00', 'Playhouse 4K'),

-- PVR: Nexus Forum – 26th April
(1, 1, '2023-04-26', '12:30:00', '4K Dolby 7.1'),
(1, 3, '2023-04-26', '15:00:00', 'Dolby 7.1'),
(1, 4, '2023-04-26', '18:00:00', 'Playhouse 4K'),

-- INOX: Phoenix Marketcity (theatre_id = 2) – 25th April
(2, 2, '2023-04-25', '12:45:00', '4K ATMOS'),
(2, 3, '2023-04-25', '14:30:00', 'Dolby 7.1'),
(2, 4, '2023-04-25', '17:00:00', 'Playhouse 4K'),

-- INOX: Phoenix Marketcity – 26th April
(2, 1, '2023-04-26', '13:00:00', '4K Dolby 7.1'),
(2, 2, '2023-04-26', '15:30:00', '4K ATMOS'),
(2, 4, '2023-04-26', '18:45:00', 'Playhouse 4K');

Normalization Check

1NF: All tables have atomic values and no repeating groups ✅

2NF: No partial dependency (all primary keys are single column) ✅

3NF: No transitive dependency; non-key attributes depend only on PK ✅

BCNF: Each determinant is a candidate key ✅


P2 – Query: List All MovieShows on a Given Date at a Given Theatre

Query 1 – All Shows on a Given Date at a Given Theatre
-- 25th April 2023 at PVR: Nexus Forum

SELECT 
    m.movie_name,
    m.language,
    m.format,
    s.show_date,
    s.show_time,
    s.screen_type
FROM MovieShow s
JOIN Movie m ON s.movie_id = m.movie_id
JOIN Theatre t ON s.theatre_id = t.theatre_id
WHERE s.show_date = '2023-04-25'
  AND t.theatre_name = 'PVR: Nexus Forum'
ORDER BY m.movie_name, s.show_time;

Query 2 – All Shows at INOX: Phoenix Marketcity on 26th April 2023

SELECT 
    m.movie_name,
    m.language,
    m.format,
    s.show_date,
    s.show_time,
    s.screen_type
FROM Show s
JOIN Movie m ON s.movie_id = m.movie_id
JOIN Theatre t ON s.theatre_id = t.theatre_id
WHERE s.show_date = '2023-04-26'
  AND t.theatre_name = 'INOX: Phoenix Marketcity'
ORDER BY s.show_time;

Query 3 – All Theatres Showing a Specific Movie on a Given Date
-- Avatar on 25th April 2023

SELECT 
    t.theatre_name,
    s.show_date,
    s.show_time,
    s.screen_type
FROM Show s
JOIN Movie m ON s.movie_id = m.movie_id
JOIN Theatre t ON s.theatre_id = t.theatre_id
WHERE m.movie_name = 'Avatar: The Way of Water'
  AND s.show_date = '2023-04-25'
ORDER BY t.theatre_name, s.show_time;

How to Use
1)Open MySQL Workbench.

2)Create a new database, e.g., bookmyshow.

3)Run the table creation scripts.

4)Insert the sample data into tables.

5)Run the queries to fetch shows by theatre and date.



