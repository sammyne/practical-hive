-- Joining Tables in Hive

USE census;

CREATE TABLE census.personname (
  persid int,
  firstname string,
  lastname string
)
CLUSTERED BY (persid) INTO 1 BUCKETS
STORED AS orc
TBLPROPERTIES('transactional' = 'true');

INSERT INTO TABLE census.personname
VALUES
(0,'Albert','Ape'),
(1,'Bob','Burger'),
(2,'Charlie','Clown'),
(3,'Danny','Drywer');

CREATE TABLE census.address (
  persid int,
  postname string
)
CLUSTERED BY (persid) INTO 1 BUCKETS
STORED AS orc
TBLPROPERTIES('transactional' = 'true');

INSERT INTO TABLE census.address
VALUES
(1,'KA13'),
(2,'KA9'),
(10,'SW1');

SELECT personname.firstname, personname.lastname, address.postname
FROM
  census.personname
JOIN
  census.address
ON (personname.persid = address.persid);

-- 期望输出如下
-- Bob Burger KA13
-- Charlie Clown KA9