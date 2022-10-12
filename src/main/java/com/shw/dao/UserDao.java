package com.shw.dao;

import com.shw.entity.*;
import com.shw.entity.POJO.OrderEntity;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

//用户类接口
@Repository
public interface UserDao {
    //添加用户
    int insertUser(User user);

    //用户登录
    User userloginIn(@Param("username") String username, @Param("password") String password);

    //修改密码
    int updatePass(@Param("password") String password, @Param("id") Integer id);

    //修改个人信息
    int updateInfo(User user);

    //通过id查询用户
    User selectUserById(Integer id);

    //通过用户名查询用户
    User selectUserByUsername(String username);

    //查询密码
    String selectPass(Integer id);

    //查询所有附近驿站
    List<PostStation> selectAllStations();

    //通过名字查询驿站
    List<PostStation> selectStationByName(String psname);

    //通过id查询驿站
    List<PostStation> selectStationById(@Param("pid") Integer pid);

    //下订单
    int postOrder(OrderEntity orderEntity);

    //支付订单
    int payTheOrder(String oid);

    //查看个人所有订单
    List<Order> queryOrders(Integer uid);

    //查看个人未完成订单
    List<Order> queryOrders2(Integer uid);

    //查看个人已完成订单
    List<Order> queryOrders3(Integer uid);

    //通过订单号查询订单
    List<Order> queryOrderByOid(String oid);

    //查询当前订单的收件人
    Consignee queryConsigneeById(Integer cid);

    //添加收件人
    int addConsignee(Consignee consignee);

    //删除收件人
    int deleteConsignee(Integer id);

    //修改收件人
    int updateConsignee(Consignee consignee);

    //查看所有收件人
    List<Consignee> queryAllConsignees(Integer uid);


}
