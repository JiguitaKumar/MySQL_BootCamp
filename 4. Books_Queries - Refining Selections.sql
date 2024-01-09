SELECT * FROM books;

INSERT INTO books
    (title, author_fname, author_lname, released_year, stock_quantity, pages)
    VALUES ('10% Happier', 'Dan', 'Harris', 2014, 29, 256), 
           ('fake_book', 'Freida', 'Harris', 2001, 287, 428),
           ('Lincoln In The Bardo', 'George', 'Saunders', 2017, 1000, 367);
           
-- DISTINCT
SELECT DISTINCT author_lname FROM books;
SELECT DISTINCT released_year FROM books;
SELECT DISTINCT CONCAT(author_fname, ' ', author_lname) FROM books;
SELECT DISTINCT author_fname, author_lname FROM books;

-- ORDER BY
SELECT book_id, author_fname, author_lname FROM books ORDER BY author_lname;
SELECT title, pages FROM books ORDER BY pages DESC;
SELECT title, pages FROM books ORDER BY released_year;
SELECT title, pages FROM books ORDER BY 1;
SELECT * FROM books ORDER BY author_lname, released_year DESC;
SELECT CONCAT(author_fname, ' ', author_lname) AS author FROM books ORDER BY author;

-- LIMIT
SELECT * FROM books LIMIT 5;
SELECT * FROM books ORDER BY released_year LIMIT 2, 5;

-- LIKE
SELECT title, author_fname, author_lname FROM books WHERE author_fname LIKE '%da%';
SELECT * FROM books WHERE title LIKE '%:%';
SELECT * FROM books WHERE author_fname LIKE '____';
SELECT * FROM books WHERE author_fname LIKE '_a_';
SELECT * FROM books WHERE author_fname LIKE 'd%';


# Refining Exercises
-- all the book titles that contain 'stories'
SELECT title FROM books WHERE title LIKE '%stories%';

-- Longest book
SELECT title, pages FROM books ORDER BY pages DESC LIMIT 1;

-- summary of the 3 most recent books
SELECT CONCAT(title, ' - ', released_year) AS summary FROM books ORDER BY released_year DESC LIMIT 3;

-- books with author with last name with space
SELECT title, author_lname FROM books WHERE author_lname LIKE '% %';

-- top 3 lowest stock
SELECT title, released_year, stock_quantity FROM books ORDER BY stock_quantity, released_year DESC LIMIT 3;

-- sort by last name and then title
SELECT title, author_lname FROM books ORDER BY author_lname, title;

-- yell table sorted by last name
SELECT UCASE(CONCAT('My favorite author is ', author_fname, ' ', author_lname, '!')) AS yell FROM books ORDER BY author_lname;