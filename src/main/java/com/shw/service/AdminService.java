package com.shw.service;

import com.shw.entity.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface AdminService {
    //管理员登录
    Admin adminLogin( Map<String,String> map);

    //查询管理员信息
    Admin queryAdmin(Integer id);

    //查询管理员
    int queryAdminName(String adminname);

    //修改密码
    int updatePass(Integer id,String newPass);

    //添加管理员
    int addAdmin(Admin admin);

    //查询所有用户
    List<User> queryAllUsers();

    //更改订单状态
    int updateOrder(String oid,String state);

    //添加驿站（注册驿站）
    int addPostStation(PostStation postStation);

    //删除驿站
    int deletePostStation(Integer pid);

    //查询所有驿站
    List<PostStation> queryAllPostStations();

    //添加企业
    int addEnterprise(Enterprise enterprise);

    //删除企业
    int deleteEnterprise(String ename);

    //根据企业名查找企业
    List<Enterprise> queryEnterpriseByName(String ename);

    //查询所有企业
    List<Enterprise> queryAllEnterprises();

    //查询企业的合作驿站(通过企业名)
    List<PostStation> pe_Relation(String ename);

    //查询驿站的合作企业
    List<Enterprise> pe_Relation2(String pname);

    //查询所有在系统中注册的运输员
    List<Driver> queryAllDrivers();

    //查询企业旗下所有运输员
    List<Driver> queryDriversByEnterprise(String ename);

}
