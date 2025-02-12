USE census;

-- Joining Tables in Hive Using Left Join
SELECT personname.firstname, personname.lastname, address.postname
FROM
  census.personname
LEFT JOIN
  census.address
ON (personname.persid = address.persid);

-- 期望输出如下
-- Albert Ape NULL
-- Bob Burger KA13
-- Charlie Clown KA9
-- Danny Drywer NULL


-- Joining Tables in Hive Using Right Join
SELECT personname.firstname, personname.lastname, address.postname
FROM
  census.personname
RIGHT JOIN
  census.address
ON (personname.persid = address.persid);

-- 期望输出如下
-- Bob Burger KA13
-- Charlie Clown KA9
-- NULL NULL SW1


-- Joining Tables in Hive Using a Full Outer Join
SELECT personname.firstname, personname.lastname, address.postname
FROM
  census.personname
FULL OUTER JOIN
  census.address
ON (personname.persid = address.persid);

-- 期望输出如下
-- Albert Ape NULL
-- Bob Burger KA13
-- Charlie Clown KA9
-- Danny Drywer NULL
-- NULL NULL SW1
