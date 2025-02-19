-- Querying JSON with a UDF
CREATE TABLE json_udf_table (
  json string);

-- 注意：需要确保 json 文件只有一行
-- 数据由 https://json-generator.com/ 生成。
-- LOAD DATA LOCAL INPATH 'file:///data/chapter07/testdata/json1.json' INTO TABLE json_udf_table;

select get_json_object(json, '$') from json_udf_table;

select
  get_json_object(json, '$.balance') as balance,
  get_json_object(json, '$.gender') as gender,
  get_json_object(json, '$.phone') as phone,
  get_json_object(json, '$.friends.name') as friendname
from json_udf_table;


CREATE TABLE json_serde_table (
  id string,
  about string,
  address string,
  age int,
  balance string,
  company string,
  email string,
  eyecolor string,
  favoritefruit string,
  friends array<struct<id:int, name:string>>,
  gender string,
  greeting string,
  guid string,
  index int,
  isactive boolean,
  latitude double,
  longitude double,
  name string,
  phone string,
  picture string,
  registered string,
  tags array<string>)
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
STORED AS TEXTFILE;

-- LOAD DATA LOCAL INPATH 'file:///data/chapter07/testdata/json1.json' INTO TABLE json_serde_table;

SELECT address, eyecolor, friends.name FROM json_serde_table;
