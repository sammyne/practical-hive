-- Updating Records in an Existing Table

USE census;

-- 需执行以下命令更新 hive 配置，使之支持事务
SET hive.support.concurrency=true;
SET hive.txn.manager=org.apache.hadoop.hive.ql.lockmgr.DbTxnManager;

CREATE TABLE census.person20 (
  persid int,
  lastname string,
  firstname string
)
CLUSTERED BY (persid) INTO 1 BUCKETS
STORED AS orc
TBLPROPERTIES('transactional' = 'true');

INSERT INTO TABLE person20 VALUES (0,'A','B'),(2,'X','Y');

SELECT * FROM census.person20;

UPDATE census.person20 SET lastname = 'SS' WHERE persid = 0;

SELECT * FROM census.person20;
