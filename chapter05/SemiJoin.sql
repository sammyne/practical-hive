-- 

USE census;

SELECT
  personname.firstname,
  personname.lastname
FROM
  census.personname
LEFT SEMI JOIN
  census.address
ON (personname.persid = address.persid);

-- 期望输出
-- Bob Burger
-- Charlie Clown
