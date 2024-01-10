USE example1;
SHOW TABLES;

-- Working with different types of Dates and Times
CREATE TABLE people ( name VARCHAR(100), birthdate DATE, birthtime TIME, birthdt DATETIME);
DESC people;

INSERT INTO people (name, birthdate, birthtime, birthdt) VALUES ('Elton', '2000-12-25', '11:00:00', '2000-12-25 11:00:00');
INSERT INTO people (name, birthdate, birthtime, birthdt) VALUES ('John', '1985-04-11', '09:45:10', '1985-04-11 09:45:10');
INSERT INTO people (name, birthdate, birthtime, birthdt) VALUES ('David', '2020-08-15', '23:59:00', '2020-08-15 23:59:00');
SELECT * FROM people;


-- DATE functions
SELECT CURDATE();
SELECT CURTIME();
SELECT NOW();

INSERT INTO people (name, birthdate, birthtime, birthdt) VALUES ('Hazel', CURDATE(), CURTIME(), NOW());

SELECT birthdate, DAY(birthdate), DAYOFWEEK(birthdate), DAYOFYEAR(birthdate) FROM people;
SELECT birthdate, MONTHNAME(birthdate) FROM people;

SELECT name, birthdt, YEAR(birthdt), MONTHNAME(birthdt) FROM people;


-- TIME functions
SELECT name, birthtime, HOUR(birthtime), MINUTE(birthtime), SECOND(birthtime) FROM people;


-- Format dates
SELECT birthdate, DATE_FORMAT(birthdate, '%a %b %e') FROM people;
SELECT birthdt, DATE_FORMAT(birthdt, '%H:%i') FROM people;
SELECT birthdt, DATE_FORMAT(birthdt, 'Born on: %r') FROM people;


-- Date Math
SELECT DATEDIFF(CURDATE(), birthdate) FROM people;
SELECT DATEDIFF(CURDATE(), birthdt) FROM people;
SELECT DATE_ADD(CURDATE(), INTERVAL 12 YEAR);
SELECT DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

SELECT birthdate, DATE_ADD(birthdate, INTERVAL 18 YEAR) FROM people;

SELECT TIMEDIFF(CURTIME(), '07:00:00');
SELECT NOW() - INTERVAL 18 YEAR;
SELECT name, birthdate, YEAR(birthdate + INTERVAL 21 YEAR) AS will_be_21 FROM people;


-- Timestamps
CREATE TABLE captions (
	text VARCHAR(150), 
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);
DESC captions;
INSERT INTO captions (text) VALUES ('just me'), ('sunset party');
UPDATE captions SET text='singing in the rain' WHERE text='just me';
UPDATE captions SET text='after party' WHERE text='sunset party';
SELECT * FROM captions;



# Data Types Exercises
-- 1. Good use for CHAR
/* abbreviations of country names, or abbreviations of currencies */

-- 2. Fill the types in the table below
CREATE TABLE inventory (
	item_name VARCHAR(50),
    price DECIMAL(5,2),
    quantity INT
);

-- 3. Diff between DATETIME and TIMESTAMP
/* Both have the info of Time and Date, but timestamp takes up less space in memory as it only goes between 1970 and 2038 */

-- 4. Print out the current time
SELECT CURTIME();

-- 5. Print out the current date
SELECT CURDATE();

-- 6. Print out the current day of the week (the number)
SELECT DAYOFWEEK(CURDATE());

-- 7. Print out the name of the current day of the week
SELECT DATE_FORMAT(CURDATE(), '%a');
SELECT DAYNAME(CURDATE());
SELECT DATE_FORMAT(CURDATE(), '%W');

-- 8. format current date to be 'mm/dd/yyyy'
SELECT DATE_FORMAT(CURDATE(), '%m/%d/%Y');

-- 9. format current DATETIME with this format 'April 1st at 10:18'
SELECT DATE_FORMAT(NOW(), '%M %D at %k:%i');

-- 10. Create table called Tweets
CREATE TABLE tweets (
	content VARCHAR(180),
    username VARCHAR(20),
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
DESC tweets;

INSERT INTO tweets (content, username) VALUES ('this is a tweet', 'JMK');
SELECT * FROM tweets;