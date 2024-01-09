# CRUD Challenge

-- 1. create database "shirts_db"
CREATE DATABASE shirts_db;
SHOW DATABASES;
USE shirts_db;
SELECT database();

-- 2. create "shirts" table
CREATE TABLE shirts(
	id INT AUTO_INCREMENT PRIMARY KEY,
    article VARCHAR(50),
    color VARCHAR(50),
    shirt_size VARCHAR(10),
    last_worn INT
);
DESC shirts;

-- 3. insert first batch of data
INSERT INTO shirts (article, color, shirt_size, last_worn) 
VALUES ('t-shirt', 'white', 'S', 10),
	   ('t-shirt', 'green', 'S', 200),
       ('polo shirt', 'black', 'M', 10),
       ('tank top', 'blue', 'S', 50),
       ('t-shirt', 'pink', 'S', 0),
       ('polo shirt', 'red', 'M', 5),
       ('tank top', 'white', 'S', 200),
       ('tank top', 'blue', 'M', 15);
SELECT * FROM shirts;

-- 4. Insert purple shirt
INSERT INTO shirts (article, color, shirt_size, last_worn) VALUES ('polo shirt', 'purple', 'M', 50);
SELECT * FROM shirts;

-- 5. SELECTs
SELECT article, color FROM shirts;
SELECT article, color, shirt_size, last_worn FROM shirts WHERE shirt_size='M';

-- 6. Change the size of all Polo shirts to L
SELECT * FROM shirts WHERE article='polo shirt';
UPDATE shirts SET shirt_size='L' WHERE article='polo shirt';

-- 7. change last worn of t-shirt of 15 days ago to 0
SELECT * FROM shirts WHERE last_worn=15;
UPDATE shirts SET last_worn=0 WHERE last_worn=15;
SELECT * FROM shirts;

-- 8. change all white shirts
SELECT * FROM shirts WHERE color='white';
UPDATE shirts SET shirt_size='XS', color='off white' WHERE color='white';
SELECT * FROM shirts;

-- 9. delete shirts worn 200 days ago
SELECT * FROM shirts WHERE last_worn=200;
DELETE FROM shirts WHERE last_worn=200;

-- 10. delete all tank tops
SELECT * FROM shirts WHERE article='tank top';
DELETE FROM shirts WHERE article='tank top';

-- 11. delete everything
DELETE FROM shirts;

-- 12. delete table
DROP TABLE shirts;

SHOW TABLES;
