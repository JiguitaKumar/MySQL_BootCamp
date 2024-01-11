# Constraints

-- UNIQUE
USE example1;
CREATE TABLE contacts(
	name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE
);

INSERT INTO contacts (name, phone) VALUES ('Ana', '9791213455');
SELECT * FROM contacts;

INSERT INTO contacts (name, phone) VALUES ('Joao', '9791213455'); #error as we have a duplicate value
INSERT INTO contacts (name, phone) VALUES ('Ana', '91523734'); #OK!


-- CHECK 
CREATE TABLE users (
	username VARCHAR(10) NOT NULL,
	age INT CHECK (age > 0)
);

INSERT INTO users (username, age) VALUES ('Mia', 20);
SELECT * FROM users;
INSERT INTO users (username, age) VALUES ('Rui', -2); #error - constraint violated

CREATE TABLE palindrome (
	word VARCHAR(100) CHECK (REVERSE(word) = word)
);

INSERT INTO palindrome (word) VALUES ('racecar');
SELECT * FROM palindrome;
INSERT INTO palindrome (word) VALUES ('Hello'); # error - constraint is violated


-- Name Constraints
CREATE TABLE partiers(
	name VARCHAR(20),
    age INT,
    CONSTRAINT age_over_18 CHECK (age > 18)
);

INSERT INTO partiers (name, age) VALUES ('Bia', 20);
SELECT * FROM partiers;
INSERT INTO partiers (name, age) VALUES ('Rita', 17); #Error - constraint 'age_over_18' is violated
INSERT INTO partiers (name, age) VALUES ('Diogo', 25), ('Gil', 13);
INSERT INTO partiers (name, age) VALUES ('Diogo', 23), ('Maia', 30);


-- Multiple columns constraints
CREATE TABLE companies (
	name VARCHAR(25) NOT NULL,
    address VARCHAR(250) NOT NULL,
    CONSTRAINT name_address UNIQUE (name, address)
);

INSERT INTO companies (name, address) VALUES ('Luigi\'s', '123street');
INSERT INTO companies (name, address) VALUES ('blackbird', '123street');
SELECT * FROM companies;
INSERT INTO companies (name, address) VALUES ('Luigi\'s', '123street'); # error - duplicate entry for name_address


#Alter tables
-- ADD COLUMN
ALTER TABLE companies ADD COLUMN phone VARCHAR(15);
DESC companies;
SELECT * FROM companies;

ALTER TABLE companies ADD COLUMN employee_count INT NOT NULL; #attributes a default value of 0


-- DROP COLUMN
ALTER TABLE companies DROP COLUMN phone;
DESC companies;


-- RENAME
RENAME TABLE companies TO suppliers;
SELECT * FROM companies; #error - doesn't exist
SELECT * FROM suppliers;

ALTER TABLE suppliers RENAME COLUMN name TO company_name;
DESC suppliers;


-- Modify columns
ALTER TABLE suppliers MODIFY company_name VARCHAR(100) DEFAULT 'unknown';
DESC suppliers;

INSERT INTO suppliers (address, employee_count) VALUES ('2554street', 3);
SELECT * FROM suppliers;


-- ALTER CONSTRAINTS
ALTER TABLE suppliers ADD CONSTRAINT positive_employees CHECK (employee_count >= 0);
DESC suppliers;
INSERT INTO suppliers (company_name, address, employee_count) VALUES ('pizzahut', '234street', -2); #error - check is violated
INSERT INTO suppliers (company_name, address, employee_count) VALUES ('pizzahut', '234street', 2);
SELECT * FROM suppliers; 