------------------------------------------------------------------------------
----------------样例-------------样例------------样例-------------------------
--   UDF 就重写 evaluate 方法
------------------------------------------------------------------------------
package com.suning.hive.udf;

import org.apache.hadoop.hive.ql.exec.UDF;

public class helloUDF extends UDF {
    //必须要重写evaluate方法
    public String evaluate(String str) {
        try {
            return "Hello World " + str;
        } catch (Exception e) {
            return null;
        }
    }
    
//    public static void main(String args[]){
//    	
//    	System.out.println(new helloUDF().evaluate("UDF!"));
//    }
}
------------------------------------------------------------------------------
--需要添加的jar包
--备注：打包的时候需要把jar包打进去
--------------------------------------------------------------------------------------
--添加jar包，并执行
--
--ADD JAR helloWorld.jar;
--CREATE TEMPORARY FUNCTION helloworld AS 'com.suning.hive.udf.helloUDF';
--insert into  table ZT_SOR.TSOR_CMF_TB2096_TEST 
--SELECT helloworld("你好") FROM zt_sor.tsor_dual;
--DROP TEMPORARY FUNCTION helloworld;
----------------------------------------------------------------------------------------
--结果：
--Hello World 你好 