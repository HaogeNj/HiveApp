-- 设置作业名
set mapred.job.name = SCHEMA.TSSA_TABLE1(${hivevar:statis_date});
-- 每个Map最大输入大小
set mapred.max.split.size = 300000000;
-- 每个Map最小输入大小
set mapred.min.split.size = 100000000;
-- 执行Map前进行小文件合并
set hive.input.format = org.apache.hadoop.hive.ql.io.CombineHiveInputFormat;
-- hive自动根据sql，选择使用common join或者map join
set hive.auto.convert.join = false;
-- 在Map-only的任务结束时合并小文件
set hive.merge.mapfiles = true;
-- 在Map-Reduce的任务结束时不合并小文件
set hive.merge.mapredfiles = false;
-- 合并文件的大小
set hive.merge.size.per.task = 300000000;

--★★★★★★
--开启动态分区  
set hive.exec.dynamic.partition=true;
--修改动态分区插入模式
set hive.exec.dynamic.partition.mode=nonstrict;

USE ztbd;
insert overwrite table SCHEMA.TSSA_TABLE1
       partition(STATIS_DATE) 
select aa.CUST_NUM	,
       aa.SEQ	,
       from_unixtime(unix_timestamp(),'yyyy-MM-dd HH:mm:ss') ETL_TIME ,
       concat(statis_date,'_',floor(aa.cust_num/10)%8,'_',abs(hash(aa.cust_num))%100) STATIS_DATE
  from SCHEMA.TSSA_TABLE aa 
 where statis_date = '${hivevar:statis_date}'; 