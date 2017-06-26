--行列转换
select test1,concat_ws(',',collect_set(test2))
  from ZT_SOR.TSOR_CMF_TB2096_TEST2 
 where test3 <> ''  
 group by test1 limit 100

--累计分析函数（sum over）
select fenzhong,
        sum(suzhi) over(order by fenzhong) as leiji
from (select 1 as fenzhong,
               2 as suzhi
         union all
         select 2 as fenzhong,
               3 as suzhi
         union all
               select 3 as fenzhong,
               6 as suzhi ) a

-- row_number() 排序，自增序列
select row_number() over(partition by concat(aa.statis_date,'_',floor(aa.cust_num/10)%8,'_',abs(hash(aa.cust_num))%100)) ORDER_ITEM_ID  
  from ZT_SOR.TSOR_CMF_TB2096_CUST_LEVEL_DTL_D aa
 where aa.statis_date = '${hivevar:statis_date}'; 

--dual 虚表
select fenzhong
select '1' from zt_sor.tsor_dual;


一、Hive下查看数据表信息的方法
方法1：查看表的字段信息
desc table_name;
方法2：查看表的字段信息及元数据存储路径
desc extended table_name;
方法3：查看表的字段信息及元数据存储路径
desc formatted table_name;  ★★★
方法4：查看建表语句及其他详细信息的方法
show create table table_name;
备注：查看表元数据存储路径时，推荐方法3，信息比较清晰。

