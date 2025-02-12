-- Using Hive to Upload a Data File

-- Create a new database
CREATE DATABASE IF NOT EXISTS census;

-- Use the new database
USE census;

-- Create a new table
CREATE TABLE person (
  persid int,
  lastname string,
  firstname string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',';

-- Load data into the new table from csv file
LOAD DATA LOCAL INPATH 'file:///data/chapter05/testdata/Person001.csv' OVERWRITE INTO TABLE person;

-- Check if the data is in table
SELECT persid, lastname, firstname FROM person;
