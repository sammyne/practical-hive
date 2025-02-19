-- Ingesting Data
-- 数据准备：
--  1. 下载：从 https://dumps.wikimedia.org/other/clickstream/ 下载数据，例如 
--    curl -LO https://dumps.wikimedia.org/other/clickstream/2025-01/clickstream-enwiki-2025-01.tsv.gz
--    数据格式如下
--      - prev: the result of mapping the referrer URL to the fixed set of values described above
--      - curr: the title of the article the client requested type: describes (prev, curr)
--      - link: if the referrer and request are both articles and the referrer links to the request
--        - external: if the referrer host is not en(.m)?.wikipedia.org
--        - other: if the referrer and request are both articles but the referrer does not link to the request.
--          This can happen when clients search or spoof their refer.
--      - n: the number of occurrences of the (referrer, resource) pair
--  2. 上传数据（假设数据放在 /data/chapter07/testdata 目录）
--    hadoop fs -mkdir -p /tmp/wikiclickstream/
--    hadoop fs -put /data/chapter07/testdata/clickstream-enwiki-2025-01.tsv.gz /tmp/wikiclickstream/

CREATE DATABASE IF NOT EXISTS clickstream;

USE clickstream;

-- Creating a Schema
CREATE TABLE wikilogs (
  prev STRING,
  curr STRING,
  type STRING,
  n INT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '09'
STORED AS textfile;

-- Loading Data
-- LOAD DATA INPATH '/tmp/wikiclickstream/clickstream-enwiki-2025-01.tsv.gz' OVERWRITE INTO TABLE wikilogs;

-- Querying the Data
CREATE VIEW wikilogs_view (n, prev, curr)
AS SELECT n, prev, curr FROM wikilogs;

SELECT * FROM wikilogs_view
SORT BY n DESC;

SELECT * FROM wikilogs_view
WHERE prev = 'other-facebook'
SORT BY n DESC;
