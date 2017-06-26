在可以操作的环境中，可以有多种方式将数据录入到hive表中。

1.本地文件加载方式
[ztbd@master2-dev testxh]$ hive
hive>load data local inpath 'tb2096.txt' into table zt_ssa.tssa_lmp_tb2096_test;
Copying data from file:/data/home/ztbd/testxh/tb2096.txt
Copying file: file:/data/home/ztbd/testxh/tb2096.txt
Loading data to table zt_ssa.tssa_lmp_tb2096_test
OK
Time taken: 1.564 seconds

检查：
[ztbd@master2-dev testxh]$ hadoop fs -ls  /user/ztbd/hive/warehouse/zt_ssa.db/tssa_lmp_tb2096_test/
-rw-r--r--   3 ztbd supergroup        220 2016-09-18 15:26 /user/ztbd/hive/warehouse/zt_ssa.db/tssa_lmp_tb2096_test/tb2096_copy_1.txt
名称发生变化

2.手动将本地文件系统文件加载到hive表对应的HDFS的路径下
[ztbd@master2-dev testxh]$ hadoop fs -put ./tb2096.txt /user/ztbd/hive/warehouse/zt_ssa.db/tssa_lmp_tb2096_test/
检查：
[ztbd@master2-dev testxh]$ hadoop fs -ls  /user/ztbd/hive/warehouse/zt_ssa.db/tssa_lmp_tb2096_test/
-rw-r--r--   3 ztbd ztbd              220 2016-09-18 15:16 /user/ztbd/hive/warehouse/zt_ssa.db/tssa_lmp_tb2096_test/tb2096.txt

二、查看表容量大小
方法1：查看一个hive表文件总大小时(单位为Byte)，可以通过一行脚本快速实现，其命令如下：
-- #查看普通表的容量
[ztbd@master2-dev ~]$ hadoop fs -ls /user/ztbd/hive/warehouse/zt_sor.db/tsor_dual|awk -F ' ' '{print $5}'|awk '{a+=$1}END{print a}'
[ztbd@master2-dev ~]$ hadoop fs -ls /user/ztbd/hive/warehouse/zt_sor.db/tsor_dual|awk -F ' ' '{print $5}'|awk '{a+=$1}END{print a/(1024*1024*1024)}'
这样可以省去自己相加，下面命令是列出该表的详细文件列表
[ztbd@master2-dev ~]$ hadoop fs -ls /user/ztbd/hive/warehouse/zt_sor.db/tsor_dual
统计文件详细数目
[ztbd@master2-dev ~]$ hadoop fs -ls /user/ztbd/hive/warehouse/zt_sor.db/tsor_dual|wc -l
-- #查看分区表的容量
[ztbd@master2-dev ~]$ hadoop fs -ls /user/ztbd/hive/warehouse/zt_sor.db/tsor_cmf_tb1676_cust_level_d/statis_date=20160101|awk -F ' ' '{print $5}'|awk '{a+=$1}END {print a/(1024*1024*1024)}'
这样可以省去自己相加，下面命令是列出该表的详细文件列表
[ztbd@master2-dev ~]$ hadoop fs -ls /user/ztbd/hive/warehouse/zt_sor.db/tsor_cmf_tb1676_cust_level_d/statis_date=20160101
方法2：查看该表总容量大小，单位为G
[ztbd@master2-dev ~]$ hadoop fs -du /user/ztbd/hive/warehouse/zt_sor.db/tsor_cmf_tb1676_cust_level_d|awk ' { SUM += $1 } END { print SUM/(1024*1024*1024) }'
