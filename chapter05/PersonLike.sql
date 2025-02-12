-- Using an Existing Table to Create a New Table with the Same Structure

USE census;

CREATE TABLE person40 LIKE person;

SELECT * FROM person40;

INSERT INTO TABLE person40 VALUES (0,'Bob','Burger'),(1,'Charlie','Clown');

SELECT * FROM person40;