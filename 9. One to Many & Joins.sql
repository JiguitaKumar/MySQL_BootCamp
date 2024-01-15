# One To Many & Joins

-- One to Many & Foreign key
CREATE TABLE customers (
	id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    email VARCHAR(50)
);

CREATE TABLE orders (
	id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    amout DECIMAL(8,2),
    customer_id INT, 
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
	   ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');

ALTER TABLE orders RENAME COLUMN amout TO amount; 
DESC orders;

INSERT INTO orders (order_date, amount, customer_id) 
VALUES ('2016-02-10', 99.99, 1),
	   ('2017-11-11', 35.50, 1),
       ('2014-12-12', 800.67, 2),
       ('2015-01-03', 12.50, 2),
       ('1999-04-11', 450.25, 5);
       
SELECT * FROM  customers;
SELECT * FROM orders;


-- Cross Join
SELECT * FROM customers WHERE first_name='Boy' AND last_name='George';
SELECT * FROM orders WHERE customer_id=1;

SELECT * FROM orders WHERE customer_id=(SELECT id FROM customers WHERE first_name='Boy' AND last_name='George');

SELECT * FROM customers, orders; #a mess - not very useful


-- Inner Join
SELECT * FROM customers JOIN orders ON customers.id = orders.customer_id;
SELECT first_name, last_name, order_date, amount FROM customers JOIN orders ON customers.id = orders.customer_id;
SELECT * FROM customers JOIN orders ON customers.id=orders.customer_id WHERE first_name='Boy' AND last_name='George';

SELECT * FROM orders JOIN customers ON customers.id=orders.customer_id; #only changes the sequence in which the info is presented

SELECT first_name, last_name, SUM(amount) AS total FROM customers 
JOIN orders ON customers.id=orders.customer_id 
GROUP BY first_name, last_name
ORDER BY total DESC;


-- Left Join
SELECT * FROM orders LEFT JOIN customers ON customers.id=orders.customer_id; #produces a similar result to INNER JOIN
SELECT * FROM customers LEFT JOIN orders ON customers.id=orders.customer_id; #here we have the info of customers that never placed an order

SELECT first_name, last_name, email, IFNULL(SUM(amount), 0) AS spent FROM customers 
LEFT JOIN orders ON customers.id=orders.customer_id 
GROUP BY first_name, last_name, email;


-- RIGHT JOIN
SELECT first_name, last_name, order_date, amount FROM customers
RIGHT JOIN orders ON customers.id=orders.customer_id; #output similar to inner join


-- DELETE CASCADE
SET SQL_SAFE_UPDATES = 0;
DELETE FROM customers WHERE last_name='George'; #error  because it violates the foreign key constraint

DROP TABLE orders;
DROP TABLE customers;

CREATE TABLE customers (
	id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    email VARCHAR(50)
);

CREATE TABLE orders (
	id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT, 
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
	   ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');

INSERT INTO orders (order_date, amount, customer_id) 
VALUES ('2016-02-10', 99.99, 1),
	   ('2017-11-11', 35.50, 1),
       ('2014-12-12', 800.67, 2),
       ('2015-01-03', 12.50, 2),
       ('1999-04-11', 450.25, 5);

DELETE FROM customers WHERE last_name='George';
SELECT * FROM customers;
SELECT * FROm orders;


-- EXERCISE
-- 1. Create tables and insert data
CREATE TABLE students (
	id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(10)
);
DESC students;

CREATE TABLE papers (
	title VARCHAR(100) NOT NULL,
    grade INT,
    student_id INT,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);
DESC papers;

INSERT INTO students (first_name) VALUES ('Caleb'), ('Samantha'), ('Raj'), ('Carlos'), ('Lisa');
SELECT * FROM students;

INSERT INTO papers (title, grade, student_id) 
VALUES ('My First Book Report', 60, 1),
       ('My Second Book Report', 75, 1),
       ('Russian Lit Through The Ages', 94, 2),
       ('De Montaigne and The Art of The Essay', 98, 2),
       ('Borges and Magical Realism', 89, 4);
SELECT * FROM papers;


-- 2. Join first_name, title and grade (overlap)
SELECT first_name, title, grade FROM students
JOIN papers ON students.id=papers.student_id
ORDER BY grade DESC;


-- 3. LEFT Join first_name, title and grade (everything from students)
SELECT first_name, title, grade FROM students
LEFT JOIN papers ON students.id=papers.student_id;


-- 4. REPLACE NULLs with "MISSING" and 0 in the previous table
SELECT first_name, IFNULL(title, 'MISSING'), IFNULL(grade, 0) FROM students
LEFT JOIN papers ON students.id=papers.student_id;

-- 5. first_name and AVG grade
SELECT first_name, AVG(IFNULL(grade,0)) AS avg_grade FROM students
LEFT JOIN papers ON students.id=papers.student_id
GROUP BY first_name
ORDER BY avg_grade DESC;


-- 6. first_name, avg and passing_status
SELECT first_name, AVG(IFNULL(grade, 0)) AS average, 
	CASE
		WHEN AVG(IFNULL(grade, 0)) > 75 THEN 'PASSING'
		ELSE 'FAILING'
	END AS passing_status
FROM students
LEFT JOIN papers ON students.id=papers.student_id
GROUP BY first_name
ORDER BY average DESC;