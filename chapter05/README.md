# 05. Data Manipulation Language (DML)

## 温馨提示
- hive 支持 ACID 依赖以下配置（可借助 `SET` 命令设置）
  - `hive.support.concurrency=true`
  - `hive.txn.manager=org.apache.hadoop.hive.ql.lockmgr.DbTxnManager`
