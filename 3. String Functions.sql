#String Functions

-- Create database
CREATE DATABASE book_shop;
USE book_shop;
SELECT database();


-- Create table and inserting data
CREATE TABLE books (
	book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100),
    author_fname VARCHAR(100),
	author_lname VARCHAR(100),
    released_year INT,
    stock_quantity INT,
    pages INT
);
DESC books;

INSERT INTO books (title, author_fname, author_lname, released_year, stock_quantity, pages)
VALUES ('The Namesake', 'Jhumpa', 'Lahiri', 2003, 32, 291),
	   ('Norse Mythology', 'Neil', 'Gaiman', 2016, 43, 304),
       ('American Gods', 'Neil', 'Gaiman', 2001, 12, 465),
       ('Interpreter of Maladies', 'Jhumpa', 'Lahiri', 1996, 97, 198),
       ('A Hologram for the King: A Novel', 'Dave', 'Eggers', 2012, 154, 352),
       ('The Circle', 'Dave', 'Eggers', 2013, 26, 504),
       ('The Amazing Adventures of Kavalier & Clay', 'Michael', 'Chabon', 2000, 68, 634),
	   ('Just Kids', 'Patti', 'Smith', 2010, 55, 304),
       ('A Heartbreaking Work of Staggering Genius', 'Dave', 'Eggers', 2001, 104, 437),
       ('Coraline', 'Neil', 'Gaiman', 2003, 100, 208),
       ('What We Talk About When We Talk About Love: Stories', 'Raymond', 'Carver', 1981, 23, 176),
       ("Where I'm Calling From: Selected Stories", 'Raymond', 'Carver', 1989, 12, 526),
       ('White Noise', 'Don', 'DeLillo', 1985, 49, 320),
       ('Cannery Row', 'John', 'Steinbeck', 1945, 95, 181),
       ('Oblivion: Stories', 'David', 'Foster Wallace', 2004, 172, 329),
       ('Consider the Lobster', 'David', 'Foster Wallace', 2005, 92, 343);
       
SELECT * FROM books;
DESC books;


-- CONCAT
SELECT CONCAT(author_fname, ' ', author_lname) AS author_name FROM books;
SELECT CONCAT_WS('-', title, author_fname, author_lname) FROM books;
 
 
 -- SUBSTRING
 SELECT SUBSTRING('Hello World', 1, 4);
 SELECT SUBSTRING('Hello World', 5);
 SELECT SUBSTRING('Hello World', -5, 2);
 
 SELECT SUBSTRING(title, 1, 15) FROM books;
 SELECT SUBSTR(author_lname, 1, 1) AS initial, author_lname FROM books;
 SELECT CONCAT(SUBSTR(title, 1, 10), '...') AS short_title FROM books;
 
 SELECT CONCAT(SUBSTR(author_fname, 1, 1), '.', SUBSTR(author_lname, 1, 1), '.') AS author_initials FROM books;
 
 
--  REPLACE
SELECT REPLACE('cheese bread coffee milk', ' ', ' and ');
SELECT REPLACE(title, ' ', '-') FROM books;
 
 
 -- REVERSE
 SELECT REVERSE('Hello World');
 SELECT REVERSE(author_fname) FROM books;
 
 SELECT CONCAT(author_fname, REVERSE(author_fname)) AS palindrome FROM books;
 
 
 -- CHAR_LENGTH
 SELECT CHAR_LENGTH('hello world');
 SELECT CHAR_LENGTH(title) AS len, title FROM books;
 SELECT CONCAT(author_lname, ' is ', CHAR_LENGTH(author_lname), ' characters long') FROM books;
 
 
 -- UPPER and LOWER
 SELECT UPPER('Hello World');
 SELECT LOWER('Hello World');
 SELECT UCASE(title) FROM books;
 SELECT CONCAT_WS(' ', 'I LOVE', UCASE(title), '!!!') FROM books;
 
 
 -- INSERT
 SELECT INSERT('Hello World', 6, 0, ' beautiful');
 
 -- LEFT and RIGHT
 SELECT LEFT(author_lname, 3) from books;
 SELECT RIGHT(author_fname, 2) from books;
 
 
 -- REPEAT
 SELECT REPEAT('ha', 4);
 
 
 -- TRIM
 SELECT TRIM('    Lisbon'); 
 SELECT TRIM(BOTH '.' FROM '....Hello...');
 
 
 
 # String Function Exercise
SELECT * FROM books;

-- Reverse and Uppercase 
SELECT UCASE(REVERSE('Why does my cat look at me with such hatred?'));

-- in books replace title spaces with arrows
SELECT REPLACE(title, ' ', '->') AS title FROM books;

-- backwards lname of author
SELECT author_lname AS forwards, REVERSE(author_lname) AS backwards FROM books;

-- full name in caps
SELECT UCASE(CONCAT(author_fname, ' ', author_lname)) AS 'full name in caps' FROM books;

-- blurb
SELECT CONCAT_WS(' ', title, 'was released in', released_year) AS blurb FROM books;

-- title and respective length
SELECT title, CHAR_LENGTH(title) AS 'character count' FROM books;

-- short title, author and quantity
SELECT CONCAT(SUBSTR(title, 1, 10), '...') AS 'short title', 
	   CONCAT_WS(',', author_lname, author_fname) AS author, 
       CONCAT(stock_quantity, ' in stock') AS quantity
FROM books;
