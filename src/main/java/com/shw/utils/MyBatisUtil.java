package com.shw.utils;


import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.InputStream;

public class MyBatisUtil {
    private static SqlSessionFactory factory = null;
    static {
        String config = "config/mybatis.xml";
        try {
            InputStream in = Resources.getResourceAsStream(config);
            factory = new SqlSessionFactoryBuilder().build(in);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static SqlSession getSession(){
        SqlSession sqlSession = null ;
        if (factory != null){
            sqlSession = factory.openSession();
        }
        return sqlSession;
    }

    public SqlSession getSession(boolean autoCommit){
        SqlSession sqlSession = null ;
        if (factory != null){
            sqlSession = factory.openSession(autoCommit);
        }
        return sqlSession;
    }

}
