CREATE DATABASE IF NOT EXISTS bookmyshow;
USE bookmyshow;

-- 1. Theatre Table
CREATE TABLE Theatre (
    theatre_id INT PRIMARY KEY AUTO_INCREMENT,
    theatre_name VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL
);

-- 2. Movie Table
CREATE TABLE Movie (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    movie_name VARCHAR(200) NOT NULL,
    language VARCHAR(50) NOT NULL,
    certification VARCHAR(10) NOT NULL,
    format VARCHAR(10) NOT NULL
);

-- 3. Show Table
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

INSERT INTO Theatre (theatre_name, location)
VALUES 
('PVR: Nexus Forum', 'Bangalore'),
('INOX: Phoenix Marketcity', 'Chennai');

INSERT INTO Movie (movie_name, language, certification, format)
VALUES
('Dasara', 'Telugu', 'UA', '2D'),
('Kisi Ka Bhai Kisi Ki Jaan', 'Hindi', 'UA', '2D'),
('Tu Jhoothi Main Makkar', 'Hindi', 'UA', '2D'),
('Avatar: The Way of Water', 'English', 'UA', '3D');

-- Shows at PVR: Nexus Forum (theatre_id = 1)
INSERT INTO MovieShow (theatre_id, movie_id, show_date, show_time, screen_type)
VALUES
-- 25th April 2023
(1, 1, '2023-04-25', '12:15:00', '4K Dolby 7.1'),
(1, 2, '2023-04-25', '13:00:00', '4K ATMOS'),
(1, 2, '2023-04-25', '16:10:00', '4K ATMOS'),
(1, 2, '2023-04-25', '18:20:00', '4K Dolby 7.1'),
(1, 3, '2023-04-25', '13:15:00', 'Dolby 7.1'),
(1, 4, '2023-04-25', '13:20:00', 'Playhouse 4K'),

-- 26th April 2023
(1, 1, '2023-04-26', '12:30:00', '4K Dolby 7.1'),
(1, 3, '2023-04-26', '15:00:00', 'Dolby 7.1'),
(1, 4, '2023-04-26', '18:00:00', 'Playhouse 4K'),

-- Shows at INOX: Phoenix Marketcity (theatre_id = 2)
-- 25th April 2023
(2, 2, '2023-04-25', '12:45:00', '4K ATMOS'),
(2, 3, '2023-04-25', '14:30:00', 'Dolby 7.1'),
(2, 4, '2023-04-25', '17:00:00', 'Playhouse 4K'),

-- 26th April 2023
(2, 1, '2023-04-26', '13:00:00', '4K Dolby 7.1'),
(2, 2, '2023-04-26', '15:30:00', '4K ATMOS'),
(2, 4, '2023-04-26', '18:45:00', 'Playhouse 4K');

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
WHERE s.show_date = '2023-04-26'
  AND t.theatre_name = 'INOX: Phoenix Marketcity'
ORDER BY s.show_time;

-- Avatar on 25th April 2023
SELECT 
    t.theatre_name,
    s.show_date,
    s.show_time,
    s.screen_type
FROM MovieShow s
JOIN Movie m ON s.movie_id = m.movie_id
JOIN Theatre t ON s.theatre_id = t.theatre_id
WHERE m.movie_name = 'Avatar: The Way of Water'
  AND s.show_date = '2023-04-25'
ORDER BY t.theatre_name, s.show_time;
