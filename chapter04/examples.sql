-- Tables
--- Creating Tables
--- 先执行 hadoop fs -mkdir -p /user/demo/customers 创建出后续 SQL 依赖的 LOCATION。

CREATE EXTERNAL TABLE customers (
  fname STRING,
  lname STRING,
  address STRUCT <HOUSENO:STRING, STREET:STRING, CITY:STRING, ZIPCODE:INT,
  STATE:STRING, COUNTRY:STRING>,
  active BOOLEAN,
  created DATE)
LOCATION '/user/demo/customers';


CREATE DATABASE retail;

CREATE EXTERNAL TABLE retail.customers (
  fname STRING,
  lname STRING,
  address STRUCT <HOUSENO:STRING, STREET:STRING, CITY:STRING, ZIPCODE:INT,
  STATE:STRING, COUNTRY:STRING>,
  active BOOLEAN,
  created DATE
  COMMENT "customer master record table")
LOCATION '/user/demo/customers/';

--- Listing Tables
SHOW TABLES IN retail;

--- External/Internal Table Example
---- 数据准备
---- 1. hadoop fs -mkdir -p /user/demo/states 创建依赖的 LOCATION；
---- 2. hadoop fs -put /data/chapter04/testdata/states.txt /user/demo/states/ 创建数据文件；
CREATE TABLE states_internal (state string) LOCATION '/user/demo/states';

SELECT * FROM states_internal;

---- 数据准备
---- 1. hadoop fs -put /data/chapter04/testdata/morestates.txt /user/demo/states/
SELECT * FROM states_internal;

CREATE EXTERNAL TABLE states_external (state string) LOCATION '/user/demo/states';

DESCRIBE FORMATTED states_external;

SELECT * FROM states_external;

CREATE EXTERNAL TABLE states_external2 (state string) LOCATION '/user/demo/states';

DROP TABLE states_external2;

SELECT * FROM states_internal;

DROP TABLE states_internal;

SELECT * FROM states_external;

-- Table Properties
--- 数据准备
--- 1. hadoop fs -mkdir -p /user/demo/states3
--- 2. hadoop fs -put /data/chapter04/testdata/states3.txt /user/demo/states3/

CREATE EXTERNAL TABLE states3 (states string)
LOCATION '/user/demo/states3'
TBLPROPERTIES("skip.header.line.count"="2");

SELECT * FROM states3;

-- Generating a Create Table Command for Existing Tables
SHOW CREATE TABLE states3;

-- Partitioning
CREATE DATABASE IF NOT EXISTS retail;

CREATE EXTERNAL TABLE retail.transactions (
  transdate DATE,
  transid INT,
  custid INT,
  fname STRING,
  lname STRING,
  item STRING,
  qty INT,
  price FLOAT
)
PARTITIONED BY (store STRING);

INSERT INTO retail.transactions
PARTITION (store="new york")
VALUES ("01/25/2016",101,"A109","MATTHEW","SMITH","SHOES",1,112.9);

SHOW PARTITIONS retail.transactions;

--- include the partition key column in the actual table definition, you will get "FAILED:
--- Error in semantic analysis: Column repeated in partitioning columns" .
-- CREATE EXTERNAL TABLE retail.transactions2 (
--   transdate DATE,
--   transid INT,
--   custid INT,
--   fname STRING,
--   lname STRING,
--   item STRING,
--   qty INT,
--   price FLOAT,
--   store STRING
-- )
-- PARTITIONED BY (store STRING);

-- Bucketing
--- 注意事项：从 hive v2 开始，bucketing 属性会根据表定义语句自动设置，不再支持手动设置或更新。
--- 相关 issue https://issues.apache.org/jira/browse/HIVE-12331
CREATE EXTERNAL TABLE customers (
  custid INT,
  fname STRING,
  lname STRING,
  city STRING,
  state STRING
)
CLUSTERED BY (custid) INTO 11 BUCKETS
LOCATION '/user/demo/customers';

--- 执行以下命令可看到 'Num Buckets' 配置为 11。
DESCRIBE FORMATTED customers;

-- Renaming Tables
CREATE EXTERNAL TABLE states (state STRING) LOCATION '/user/demo/states';

ALTER TABLE states RENAME TO states_old;

DESCRIBE FORMATTED states_old;


-- ORC File Format
CREATE TABLE states_orc
STORED AS ORC
TBLPROPERTIES("ORC.COMPRESS"="SNAPPY")
AS SELECT * FROM states;

DESCRIBE EXTENDED states_orc;

DESCRIBE FORMATTED states_orc;

-- Add Partition
--- 数据准备
--- hadoop fs -mkdir -p /user/demo/ids
--- hadoop fs -mkdir /user/demo/ids/2016-05-31
--- hadoop fs -mkdir /user/demo/ids/2016-05-30
--- hadoop fs -put /data/chapter04/testdata/2016-05-31.txt /user/demo/ids/2016-05-31/
--- hadoop fs -put /data/chapter04/testdata/2016-05-30.txt /user/demo/ids/2016-05-30/
CREATE EXTERNAL TABLE ids (a INT)
PARTITIONED BY (datestamp STRING)
LOCATION '/user/demo/ids';

SELECT * FROM ids;

ALTER TABLE ids ADD PARTITION (datestamp='2016-05-30') location '/user/demo/ids/2016-05-30';

SELECT * FROM ids;

ALTER TABLE ids ADD PARTITION (datestamp='2016-05-31') location '/user/demo/ids/2016-05-31';

SELECT * FROM ids;


CREATE TABLE ids_internal (a INT) PARTITIONED BY (datestamp STRING);

INSERT INTO ids_internal PARTITION (datestamp='2016-05-30') values (1);

INSERT INTO ids_internal PARTITION (datestamp='2016-05-31') values (11);

SHOW PARTITIONS ids_internal;

--- hadoop fs -mkdir /opt/hive/data/warehouse/ids_internal/datestamp=2016-05-21
--- hadoop fs -put /data/chapter04/testdata/2016-05-21.txt /opt/hive/data/warehouse/ids_internal/datestamp=2016-05-21
MSCK REPAIR TABLE ids_internal;

-- Rename Partition
ALTER TABLE ids
PARTITION (datestamp='2016-05-31') RENAME to PARTITION (datestamp='31-05-2016');

SHOW PARTITIONS ids;

-- Adding Columns
describe formatted retail.transactions;

ALTER TABLE RETAIL.TRANSACTIONS ADD COLUMNS (loyalty_card boolean);

describe formatted retail.transactions;

-- Dropping Partitions
ALTER TABLE retail.transactions DROP PARTITION (store='oakdrive');

-- Protecting Tables/Partitions
--- 这个功能已在 hive v2.0.0 被移除。相关变更参见 https://issues.apache.org/jira/browse/HIVE-11145。
--- ALTER TABLE retail.transactions ENABLE NO_DROP;

-- Create Table as Select (CTAS)
CREATE TABLE retail.transactions_top100 AS
SELECT * FROM retail.transactions WHERE custid<101;

drop table retail.transactions_top100;

CREATE TABLE retail.transactions_top100
STORED AS ORCFILE
AS SELECT * FROM retail.transactions WHERE custid<101;

-- Create Table Like
CREATE TABLE retail.transactions_test LIKE retail.transactions;
