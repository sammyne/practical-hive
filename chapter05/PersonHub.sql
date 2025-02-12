-- Using an Existing Table to Create a New Table

-- Use existing database
USE census;

drop table if exists personhub;

-- Create new table
CREATE TABLE personhub (
  persid int
);

-- Insert data into table, overwriting existing data in table
INSERT OVERWRITE
TABLE personhub
SELECT DISTINCT persid FROM Person;

-- Check if data in table
SELECT persid FROM personhub;

INSERT INTO TABLE personhub SELECT DISTINCT persid FROM Person;

select count(*) as n from personhub;

INSERT OVERWRITE TABLE personhub SELECT DISTINCT persId + 1000 FROM Person;

select * from personhub;
