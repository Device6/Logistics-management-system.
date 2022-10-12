package com.shw.service;

import com.shw.entity.Consignee;
import com.shw.entity.Order;
import com.shw.entity.POJO.OrderEntity;
import com.shw.entity.PostStation;
import com.shw.entity.User;
import com.sun.org.apache.xpath.internal.operations.Or;

import java.util.List;

public interface UserService {
    //添加用户
    int addUser(User user);

    //用户登录
    User userLogin(String username, String password);

    //查询用户
    User queryUserById(Integer id);

    //修改用户密码
    int updatePassword(String password, Integer id);

    //查询密码
    String selectPass(Integer id);

    //修改个人信息
    int updateInfo(User user);

    //查询附近所有驿站
    List<PostStation> queryAllStations();

    //通过驿站名查询驿站
    List<PostStation> queryStationByName(String psname);

    //通过id查询驿站
    List<PostStation> queryStationById(Integer pid);

    //下达订单
    int postOrder(OrderEntity orderEntity);

    //查询个人所有订单
    List<Order> queryAllOrders(Integer uid);

    //查看个人未完成订单
    List<Order> queryOrders2(Integer uid);

    //查看个人已完成订单
    List<Order> queryOrders3(Integer uid);

    //通过订单号查询订单
    List<Order> queryOrderByOid(String oid);

    //添加收件人
    int addConsignee(Consignee consignee);

    //删除收件人
    int deleteConsignee(Integer id);

    //修改收件人
    int updateConsignee(Consignee consignee);

    //查询当前订单的收件人
    Consignee queryConsigneeById(Integer cid);

    //查询所有收件人
    List<Consignee> queryAllConsignees(Integer uid);

}
