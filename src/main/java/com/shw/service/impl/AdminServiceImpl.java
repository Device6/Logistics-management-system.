package com.shw.service.impl;

import com.shw.dao.AdminDao;
import com.shw.dao.UserDao;
import com.shw.entity.*;
import com.shw.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

//管理员实现类
@Service
public class AdminServiceImpl implements AdminService {
    @Autowired
    private AdminDao adminDao;
    @Autowired
    private UserDao userDao;

    //管理员登录
    @Override
    public Admin adminLogin(Map<String, String> map) {
        String adminname = map.get("adminname");
        String password = map.get("password");
        Admin admin = null;
        if (password != null && adminname != null){
            admin = adminDao.adminLoginIn(map);
        }
        return admin;
    }

    @Override
    public Admin queryAdmin(Integer id) {
        return adminDao.queryAdmin(id);
    }

    @Override
    public int queryAdminName(String adminname) {
        return adminDao.queryAdminName(adminname);
    }

    //修改密码
    @Override
    public int updatePass(Integer id, String newPass) {
        if (id != null && newPass != null){
            return adminDao.updatePass(id,newPass);
        }
        return -1;
    }

    //添加管理员
    @Override
    public int addAdmin(Admin admin) {
        String adminname = admin.getAdminname();
        if (adminname != null && adminDao.queryAdminName(adminname)==0){
            return adminDao.addAdmin(admin);
        }
        return -1;
    }

    //查询所有用户
    @Override
    public List<User> queryAllUsers() {
        return adminDao.queryAllUsers();
    }

    @Override
    public int updateOrder(String oid, String state) {
        return adminDao.updateOrder(oid,state);
    }


    //添加驿站（注册驿站）
    @Override
    public int addPostStation(PostStation postStation) {
        if (postStation != null){
            return adminDao.addPostStation(postStation);
        }
        return -1;
    }

    //删除驿站
    @Override
    public int deletePostStation(Integer pid) {
        if (userDao.selectStationById(pid) != null){
            return adminDao.deletePostStation(pid);
        }
        return -1;
    }

    //查询所有驿站
    @Override
    public List<PostStation> queryAllPostStations() {
        return adminDao.queryAllPostStations();
    }

    //添加企业
    @Override
    public int addEnterprise(Enterprise enterprise) {
        String name = enterprise.getName();
        if (adminDao.queryEnterpriseByName(name) == null){
            return adminDao.addEnterprise(enterprise);
        }
        return -1;
    }

    //删除企业
    @Override
    public int deleteEnterprise(String ename) {
        if (ename != null && ename != "" && adminDao.queryEnterpriseByName(ename)!=null){
            return adminDao.deleteEnterprise(ename);
        }
        return -1;
    }

    //根据企业名查找企业
    @Override
    public List<Enterprise> queryEnterpriseByName(String ename) {
        if (ename != null && ename != ""){
            return adminDao.queryEnterpriseByName(ename);
        }
        return null;
    }

    //查询所有企业
    @Override
    public List<Enterprise> queryAllEnterprises() {
        return adminDao.queryAllEnterprises();
    }

    //查询企业的合作驿站(通过企业名)
    @Override
    public List<PostStation> pe_Relation(String ename) {
        if (ename != null && ename != ""){
            return adminDao.pe_Relation(ename);
        }
        return null;
    }

    //查询驿站的合作企业
    @Override
    public List<Enterprise> pe_Relation2(String pname) {
        if (pname != null && pname != ""){
            return adminDao.pe_Relation2(pname);
        }
        return null;
    }

    //查询所有在系统中注册的运输员
    @Override
    public List<Driver> queryAllDrivers() {
        return adminDao.queryAllDrivers();
    }

    //查询企业旗下所有运输员
    @Override
    public List<Driver> queryDriversByEnterprise(String ename) {
        if (ename != null && ename != ""){
            return adminDao.queryDriversByEnterprise(ename);
        }
        return null;
    }
}
