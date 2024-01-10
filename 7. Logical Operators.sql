# Logical Operators

-- NOT EQUAL
SELECT * FROM books WHERE released_year != 2017;
SELECT title, author_lname FROM books WHERE author_lname != 'Gaiman';


-- NOT LIKE
SELECT * FROM books WHERE title NOT LIKE '% %';
SELECT * FROM books WHERE author_fname NOT LIKE 'da%';
SELECT * FROM books WHERE title NOT LIKE '%e%';


-- GREATER THAN >
SELECT * FROM books WHERE released_year > 2005;
SELECT * FROM books WHERE pages > 500;


-- LESS THAN <, EQUAL TO
SELECT title, released_year FROM books WHERE released_year < 2000 ORDER BY released_year;
SELECT title, pages FROM books WHERE pages < 200;
SELECT title, released_year FROM books WHERE released_year >= 2010;
SELECT title, released_year FROM books WHERE released_year <= 1985;


-- AND (&&)
SELECT * FROM books WHERE author_lname='Eggers' AND released_year > 2010;
SELECT * FROM books WHERE author_lname='Eggers' AND released_year > 2010 AND title LIKE '%novel%';
SELECT * FROM books WHERE CHAR_LENGTH(title) >= 15 AND pages > 500;


-- OR
SELECT title, author_lname, released_year FROM books WHERE author_lname='Eggers' OR released_year > 2010;
SELECT title, pages FROM books WHERE pages < 200 OR title LIKE '%stories%';


-- BETWEEN and NOT BETWEEN
SELECT * FROM books WHERE released_year >= 2004 AND released_year <= 2015;
SELECT * FROM books WHERE released_year BETWEEN 2004 AND 2015;
SELECT * FROM books WHERE pages BETWEEN 200 AND 300;
SELECT * FROM books WHERE pages NOT BETWEEN 200 AND 300;


-- Comparing dates
USE example1;
SHOW TABLES;
SELECT * FROM people;

SELECT * FROM people WHERE birthdate < '2005-01-01';
SELECT * FROM people WHERE YEAR(birthdate) < 2005;
SELECT * FROM people WHERE birthtime > '12:00:00';
SELECT * FROM people WHERE HOUR(birthtime) > 12;

SELECT * FROM people WHERE birthtime BETWEEN CAST('10:00:00' AS TIME) AND CAST('16:00:00' AS TIME);
SELECT * FROM people WHERE HOUR(birthtime) BETWEEN 10 AND 16;


-- IN, NOT IN and Remainder Operator
USE book_shop;
SELECT * FROM books WHERE author_lname IN ('Gaiman', 'Lahiri', 'Smith');
SELECT * FROM books WHERE author_lname NOT IN ('Gaiman', 'Lahiri', 'Smith');
SELECT * FROm books WHERE released_year >= 2000 AND released_year % 2 != 0;


-- CASE
SELECT title, released_year, 
	CASE 
		WHEN released_year >= 2000 THEN 'Modern Lit' 
        ELSE '20th Century Lit' 
	END AS genre 
FROM books;

SELECT title, stock_quantity, 
	CASE
		WHEN stock_quantity BETWEEN 0 AND 50 THEN '*'
        WHEN stock_quantity BETWEEN 51 AND 100 THEN '**'
        ELSE '***'
	END AS stock
FROM books;

SELECT title, stock_quantity, 
	CASE
		WHEN stock_quantity <= 50 THEN '*'
        WHEN stock_quantity <= 100 THEN '**'
        ELSE '***'
	END AS stock
FROM books;


-- NULL
SELECT * FROM books WHERE title IS NULL;
SELECT * FROM books WHERE author_lname IS NOT NULL;


# Exercise
SELECT * FROM books;

-- 1. all books written before 1980 (exclusive)
SELECT * FROM books WHERE released_year < 1980;

-- 2. All books written by Eggers or Chabon
SELECT * FROM books WHERE author_lname IN ('Eggers', 'Chabon');

-- 3. Books by Lahiri after 2000
SELECT * FROM books WHERE released_year > 2000 AND author_lname='Lahiri';

-- 4. Books with pages between 100 and 200
SELECT * FROM books WHERE pages BETWEEN 100 AND 200;

-- 5. Books with authors with last name starting with C or S
SELECT * FROM books WHERE author_lname LIKE 'C%' OR author_lname LIKE 'S%';
SELECT * FROM books WHERE SUBSTR(author_lname, 1, 1) IN ('C', 'S');

-- 6. Create table with a column Type using CASE
SELECT title, author_lname,
	CASE
		WHEN title LIKE '%stories%' THEN 'Short Stories'
        WHEN title IN ('Just Kids', 'A Heartbreaking Work of Staggering Genius') THEN 'Memoir'
        ELSE 'Novel'
	END AS type
FROM books;

-- 7. Make the Bonus table
SELECT author_fname, author_lname, 
	CASE
		WHEN COUNT(*) > 1 THEN CONCAT(COUNT(*), ' books')
        ELSE CONCAT(COUNT(*), ' book')
    END AS count 
FROM books 
GROUP BY author_fname, author_lname;