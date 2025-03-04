-- 

USE census;

CREATE TABLE census.account (
  persid int,
  bamount int
)
CLUSTERED BY (persid) INTO 1 BUCKETS
STORED AS orc
TBLPROPERTIES('transactional' = 'true');

INSERT INTO TABLE census.account
VALUES
  (1,12),
  (2,9);

SELECT
  personname.firstname,
  personname.lastname,
  address.postname,
  account.bamount
FROM
  census.personname
JOIN
  census.address
ON (personname.persid = address.persid)
JOIN
  census.account
ON (personname.persid = account.persid);

-- 期望输出如下
-- +-----------------------+----------------------+-------------------+------------------+
-- | personname.firstname  | personname.lastname  | address.postname  | account.bamount  |
-- +-----------------------+----------------------+-------------------+------------------+
-- | Bob                   | Burger               | KA13              | 12               |
-- | Charlie               | Clown                | KA9               | 9                |
-- +-----------------------+----------------------+-------------------+------------------+