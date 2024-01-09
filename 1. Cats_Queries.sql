# Rapid Fire exercises - video 63 from The Ultimate MySQL Bootcamp

SELECT * FROM cats;

-- 1. cat_ids
SELECT cat_id FROM cats;

-- 2. name and breed
SELECT name, breed FROM cats;

-- 3. name and age only for Tabby cats
SELECT name, age FROM cats WHERE breed = 'Tabby';

-- 4. cat_id and age for cats that have the id = age
SELECT cat_id, age FROM cats WHERE cat_id = age;


SET SQL_SAFE_UPDATES = 0;
SELECT * FROM cats WHERE name = 'Misty';
UPDATE cats SET age=14 WHERE name='Misty';


# Update exercise - video 71
-- 1. change Jackson's name
SELECT * FROM cats WHERE name='Jackson';
UPDATE cats SET name='Jack' WHERE name='Jackson';

-- 2. change Ringo's breed
SELECT * FROM cats WHERE name='Ringo';
UPDATE cats SET breed='British Shorthair' WHERE name='Ringo';

-- 3. update ages of Maine Coons
SELECT * FROM cats WHERE breed='Maine Coon';
UPDATE cats SET age=12 WHERE breed='Maine Coon';


DELETE FROM cats WHERE name='Egg';


# Delete exercise - video 76
-- 1. Delete all 4y old cats
DELETE FROM cats WHERE age=4;

-- 2. Delete cats with age = id
DELETE FROM cats WHERE cat_id=age;

-- 3. Delete all rows
DELETE FROM cats;