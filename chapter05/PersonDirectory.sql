-- Using an Existing Table to Create an Output Directory

INSERT OVERWRITE DIRECTORY '/exampleoutput'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
SELECT persid, firstname, lastname
FROM person;
