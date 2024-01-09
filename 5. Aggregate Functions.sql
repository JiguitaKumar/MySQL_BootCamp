#Aggregate Functions

SELECT * FROM books;

-- COUNT
SELECT COUNT(*) FROM books;
SELECT COUNT(DISTINCT author_fname) FROM books;
SELECT COUNT(DISTINCT released_year) FROM books;
SELECT COUNT(*) FROM books WHERE title LIKE '%the%';

-- GROUP BY
SELECT author_lname, COUNT(*) AS books_written FROM books GROUP BY author_lname ORDER BY books_written DESC;
SELECT author_fname, author_lname, COUNT(*) FROM books GROUP BY author_lname, author_fname;
SELECT CONCAT(author_fname, ' ', author_lname) AS fullname, COUNT(*) FROM books GROUP BY fullname;
SELECT released_year, COUNT(*) AS books_released FROM books GROUP BY released_year ORDER BY released_year;

-- MIN and MAX
SELECT MIN(released_year) FROM books;
SELECT MAX(pages) FROM books;
SELECT MIN(author_lname), MAX(author_lname) FROM books;
SELECT MAX(CHAR_LENGTH(title)) FROM books;
SELECT author_fname, author_lname, COUNT(*) AS books_written, MIN(released_year) AS earliest_release FROM books GROUP BY author_fname, author_lname;

-- Subqueries
SELECT title FROM books ORDER BY char_length(title) DESC;
SELECT * FROM books WHERE CHAR_LENGTH(title) = (SELECT MAX(CHAR_LENGTH(title)) FROM books);
SELECT * FROM books WHERE pages = (SELECT MIN(pages) FROM books);
SELECT title, released_year FROM books WHERE released_year=(SELECT MIN(released_year) FROM books);

-- SUM
SELECT SUM(pages) FROM books;
SELECT author_lname, SUM(pages) FROM BOOKS GROUP BY author_lname;
SELECT author_lname, COUNT(*), SUM(released_year) FROM books GROUP BY author_lname;

-- AVG
SELECT AVG(released_year) FROM books;
SELECT AVG(pages) FROM books;
SELECT AVG(stock_quantity) FROM books;
SELECT released_year, COUNT(*), AVG(stock_quantity) FROM books GROUP BY released_year;


# Agg Functions Exercise

-- 1. Total number of books in the table
SELECT COUNT(*) FROM books;

-- 2. How many books were released in each year
SELECT released_year, COUNT(*) AS books_released FROM books GROUP BY released_year ORDER BY released_year;

-- 3. Total books in stock
SELECT SUM(stock_quantity) FROM books;

-- 4. Avg release year for each author
SELECT author_fname, author_lname, AVG(released_year) AS avg_released_year FROM books GROUP BY author_fname, author_lname;

-- 5. Full name of author with longest Book
SELECT CONCAT(author_fname, ' ', author_lname) AS author, title FROM books WHERE CHAR_LENGTH(title) = (SELECT MAX(CHAR_LENGTH(title)) FROM books);

-- 6. table with year, num of books and avg pages
SELECT released_year AS year, COUNT(*) AS '# books', AVG(pages) AS 'avg pages' FROM books GROUP BY released_year ORDER BY released_year;
