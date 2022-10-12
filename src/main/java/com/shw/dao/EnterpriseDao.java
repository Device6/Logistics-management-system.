package com.shw.dao;

import com.shw.entity.Driver;
import com.shw.entity.Order;
import com.shw.entity.PostStation;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EnterpriseDao {
    //查询合作站点
    List<PostStation> queryOperators(String ename);

    //查询企业负责订单
    List<Order> queryOrders(String ename);

    //查询企业旗下运输员
    List<Driver> queryAllDrivers(String ename);

    //分配订单给运输员(每次最多分配50单)
    int distributeOrders(@Param("oid") String oid, @Param("address")String address,@Param("driverId") String driverId);



}
