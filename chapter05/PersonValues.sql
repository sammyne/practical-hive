-- Adding Extra Records to an Existing Table

USE census;

INSERT INTO TABLE personhub VALUES (0);

SELECT persid FROM personhub WHERE persid = 0;
