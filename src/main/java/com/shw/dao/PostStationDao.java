package com.shw.dao;

import com.shw.entity.Order;
import com.shw.entity.PostStation;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PostStationDao {
    //站点登录
    PostStation postLoginIn(@Param("account") String account, @Param("password") String password);

    //查询所有订单
    List<Order> queryAllOrdersPaid(Integer pid);

    //查询未处理订单
    List<Order> queryOrdersNotProcessed(Integer pid);

    //查询已处理订单
    List<Order> queryOrdersProcessed(Integer pid);

    //更新订单信息
    int updateOrder(Order order);




}
