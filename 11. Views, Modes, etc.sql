#Views

-- Creating a View
CREATE VIEW full_reviews AS
SELECT title, released_year, genre, rating, first_name, last_name FROM reviewers
JOIN reviews ON reviews.reviewer_id=reviewers.id
JOIN series ON series.id=reviews.series_id;

SHOW TABLES;

SELECT * FROM full_reviews WHERE genre='Animation';

SELECT genre, AVG(rating) FROM full_reviews GROUP BY genre;


-- Updateable Views
#we cannot update the previous view because we are using JOINS
#but we can update the view below

CREATE VIEW ordered_series AS
SELECT * FROM series ORDER BY released_year;

INSERT INTO ordered_series (title, released_year, genre) VALUES ('The Great', 2020, 'Comedy'); #it works
SELECT * FROM ordered_series;
SELECT * FROM series;
DELETE FROM series WHERE title='The Great'; #also works!


-- Change the Query from a View
CREATE OR REPLACE VIEW ordered_series AS
SELECT * FROM series ORDER BY released_year DESC;

SELECT * FROM ordered_series;

ALTER VIEW ordered_series AS
SELECT * FROM series ORDER BY released_year;

DROP VIEW ordered_series;


-- HAVING
SELECT 
	title, 
	AVG(rating),
    COUNT(rating) AS review_count
FROM full_reviews 
GROUP BY title HAVING COUNT(rating) > 1;


-- WITH ROLLUP
SELECT title, AVG(rating) FROM full_reviews GROUP BY title WITH ROLLUP; #provides the avg of the table
SELECT title, COUNT(rating) FROM full_reviews GROUP BY title WITH ROLLUP; #provides the total reviews 
SELECT released_year, genre, AVG(rating) FROM full_reviews GROUP BY released_year, genre WITH ROLLUP; #provides an overall average and an average per year


-- SQL Modes Basics
SELECT @@GLOBAL.sql_mode;
SELECT @@SESSION.sql_mode;

SELECT 3/0;
SHOW WARNINGS; #warning - division by 0

SET SESSION sql_mode = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
SELECT 3/0;
SHOW WARNINGS; #no warnings


-- STRICT_TRANS_TABLES
#ensures that the types initially defined are respected


-- ONLY FULL GROUP BY
#ensures we use some sort of aggregate function when we are GROUPing BY and we have columns that vary

SET SESSION sql_mode='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
