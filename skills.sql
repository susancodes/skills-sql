-- 1. Select all columns for all brands in the Brands table.
SELECT * FROM Brands;

-- 2. Select all columns for all car models made by Pontiac in the Models table.
SELECT * FROM Models WHERE brand_name = 'Pontiac';
-- 3. Select the brand name and model 
--    name for all models made in 1964 from the Models table.
SELECT brand_name, name FROM Models WHERE year = '1964';

-- 4. Select the model name, brand name, and headquarters for the Ford Mustang 
--    from the Models and Brands tables.
SELECT Models.name, brand_name, headquarters
FROM Models
JOIN Brands
ON Models.brand_name = Brands.name
WHERE brand_name = 'Ford' AND Models.name = 'Mustang';


-- 5. Select all rows for the three oldest brands 
--    from the Brands table (Hint: you can use LIMIT and ORDER BY).
SELECT *
FROM Brands
ORDER BY founded
LIMIT 3;


-- 6. Count the Ford models in the database (output should be a **number**).
SELECT COUNT(*) FROM Models WHERE brand_name = 'Ford';

-- 7. Select the **name** of any and all car brands that are not discontinued.
SELECT name FROM Brands WHERE discontinued is NULL;

-- 8. Select rows 15-25 of the DB in alphabetical order by model name.
SELECT * FROM Models ORDER BY name LIMIT 11 OFFSET 14;


-- 9. Select the **brand, name, and year the model's brand was 
--    founded** for all of the models from 1960. Include row(s)
--    for model(s) even if its brand is not in the Brands table.
--    (The year the brand was founded should be ``null`` if 
--    the brand is not in the Brands table.)
SELECT Brands.name, Models.name, Brands.founded
FROM Models
LEFT JOIN Brands
ON Models.brand_name = Brands.name 


-- Part 2: Change the following queries according to the specifications. 
-- Include the answers to the follow up questions in a comment below your
-- query.

-- 1. Modify this query so it shows all **brands** that are not discontinued
-- regardless of whether they have any cars in the cars table.
-- before:
    -- SELECT b.name,
    --        b.founded,
    --        m.name
    -- FROM Model AS m
    --   LEFT JOIN brands AS b
    --     ON b.name = m.brand_name
    -- WHERE b.discontinued IS NULL;
SELECT b.name, b.founded, m.name
FROM Brands as b
LEFT JOIN Models as m
ON b.name = m.brand_name
WHERE b.discontinued IS NULL;


-- 2. Modify this left join so it only selects models that have brands in the Brands table.
-- before: 
    -- SELECT m.name,
    --        m.brand_name,
    --        b.founded
    -- FROM Models AS m
    --   LEFT JOIN Brands AS b
    --     ON b.name = m.brand_name;

-- followup question: In your own words, describe the difference between 
-- left joins and inner joins.
SELECT m.name, m.brand_name, b.founded
FROM Models AS m
JOIN Brands AS b
ON b.name = m.brand_name;
-- followup ANSWER: An inner join is an intersection of the two tables and it only 
-- shows if data is present in both tables. A left join show the entirety of the
-- table on the left (the table querying FROM), whether or not it intersects with the
-- table on the right. 



-- 3. Modify the query so that it only selects brands that don't have any car models in the cars table. 
-- (Hint: it should only show Tesla's row.)
-- before: 
    -- SELECT name,
    --        founded
    -- FROM Brands
    --   LEFT JOIN Models
    --     ON brands.name = Models.brand_name
    -- WHERE Models.year > 1940;
SELECT Brands.name, founded
FROM Brands
LEFT JOIN Models
ON brands.name = Models.brand_name
WHERE Models.name IS NULL;

-- 4. Modify the query to add another column to the results to show 
-- the number of years from the year of the model *until* the brand becomes discontinued
-- Display this column with the name years_until_brand_discontinued.
-- before: 
    -- SELECT b.name,
    --        m.name,
    --        m.year,
    --        b.discontinued
    -- FROM Models AS m
    --   LEFT JOIN brands AS b
    --     ON m.brand_name = b.name
    -- WHERE b.discontinued NOT NULL;
SELECT b.name, m.name, m.year, b.discontinued, discontinued - year AS years_until_brand_discontinued
FROM Models AS m
LEFT JOIN Brands as b
ON m.brand_name = b.name
WHERE b.discontinued NOT NULL; 



-- Part 3: Futher Study

-- 1. Select the **name** of any brand with more than 5 models in the database.
SELECT brand_name
FROM Models
GROUP BY brand_name
HAVING Count(*) >5;


-- 2. Add the following rows to the Models table.

-- year    name       brand_name
-- ----    ----       ----------
-- 2015    Chevrolet  Malibu
-- 2015    Subaru     Outback
INSERT INTO Models (year, brand_name, name)
VALUES ('2015', 'Chevrolet', 'Malibu');
INSERT INTO Models (year, brand_name, name)
VALUES ('2015', 'Subaru', 'Outback');

-- 3. Write a SQL statement to crate a table called ``Awards`` 
--    with columns ``name``, ``year``, and ``winner``. Choose 
--    an appropriate datatype and nullability for each column.
CREATE TABLE Awards(
    name varchar(30) NOT NULL,
    year integer NOT NULL,
    winner varchar(30)
    );


-- 4. Write a SQL statement that adds the following rows to the Awards table:

--   name                 year      winner_model_id
--   ----                 ----      ---------------
--   IIHS Safety Award    2015      # get the ``id`` of the 2015 Chevrolet Malibu
--   IIHS Safety Award    2015      # get the ``id`` of the 2015 Subaru Outback

INSERT INTO Awards (name, year, winner)
SELECT 'IIHS Safety Award', '2015', id
FROM Models
WHERE name = 'Malibu';

INSERT INTO Awards (name, year, winner)
SELECT 'IIHS Safety Award', '2015', id
FROM Models
WHERE name = 'Outback';

-- 5. Using a subquery, select only the *name* of any model whose 
-- year is the same year that *any* brand was founded.


SELECT Models.name FROM Models WHERE Models.year 
IN (SELECT founded FROM Brands);


