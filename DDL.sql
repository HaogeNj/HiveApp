--表创建
CREATE TABLE SCHEMA.TSSA_TABLE1(
DETAIL_ID BIGINT,
ETL_TIME	STRING
)
PARTITIONED BY (STATIS_DATE string) 
STORED AS INPUTFORMAT 'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat';

--分区处理
use SCHEMA;
alter table TSSA_TABLE1 drop if exists partition(STATIS_DATE = '20160101');
alter table TSSA_TABLE1 add if not exists partition(STATIS_DATE = '20160101');

--截断表数据
USE SCHEMA;
TRUNCATE TABLE TSSA_TABLE1;

--修改表表字段属性，字段个数。。
use SCHEMA;
alter table TSSA_TABLE1  REPLACE COLUMNS (test11 string,test12 string,test13 string);

--Replace-测试------------------------------------------------
use SCHEMA;
CREATE TABLE SCHEMA.TSSA_TABLE1(
DETAIL_ID BIGINT,
ETL_TIME	STRING
)
PARTITIONED BY (STATIS_DATE string) 
STORED AS INPUTFORMAT 'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat';

use SCHEMA;
alter table TSSA_TABLE1 REPLACE COLUMNS (DETAIL_ID BIGINT,ETL_TIME STRING,test13 string);

insert overwrite table TSSA_TABLE1 
       partition(STATIS_DATE= 1) 
select 1,2,3,4 from SCHEMA.tssa_dual;

alter table TSSA_TABLE1 add COLUMNS (test2 string);

select * from TSSA_TABLE1;
--测试结果说明:----------------------------
普通表，使用add和replace的方式添加字段，insert都可以插入值；
分区表，使用add添加的字段，insert的值写不进去，repace方式的可以。


-查看建表语句：
use SCHEMA;
show create table TSSA_TABLE1;

说明：
LOCATION
  'hdfs://Hadoop2/user/SCHEMA/TSSA_TABLE1'
对应hdfs的路径

