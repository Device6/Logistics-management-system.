package com.shw.service.impl;

import com.shw.dao.UserDao;
import com.shw.entity.Consignee;
import com.shw.entity.Order;
import com.shw.entity.POJO.OrderEntity;
import com.shw.entity.PostStation;
import com.shw.entity.User;
import com.shw.service.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

//用户实现类
@Service
public class UserServiceImpl implements UserService {
    @Resource
    private UserDao userDao;

    //添加用户
    @Override
    public int addUser(User user) {
        return userDao.insertUser(user);
    }

    //用户登录
    @Override
    public User userLogin(String username, String password) {
        User user = null;
        if (username != null && password != null){
            user = userDao.userloginIn(username,password);
        }
        return user;
    }

    //根据id查找用户
    @Override
    public User queryUserById(Integer id) {
        User user = null;
        if (id > 0 && id != null){
            user = userDao.selectUserById(id);
        }
        return user;
    }

    //更新用户密码
    @Override
    public int updatePassword(String password,Integer id) {
        int nums = 0;
        if (password != null){
            nums = userDao.updatePass(password,id);
        }
        return nums;
    }

    //查询旧密码
    @Override
    public String selectPass(Integer id) {
        String password = null;
        if (id != null && id > 0){
            password = userDao.selectPass(id);
        }
        return password;
    }

    //更新个人信息
    @Override
    public int updateInfo(User user) {
        if (user != null){
            return userDao.updateInfo(user);
        }
        return -1;
    }

    //查询附近所有驿站
    @Override
    public List<PostStation> queryAllStations() {
        List<PostStation> list = userDao.selectAllStations();
        if (list != null){
            return list;
        }
        return null;
    }

    //通过驿站名查询驿站
    @Override
    public List<PostStation> queryStationByName(String psname) {
        List<PostStation> postStations = null;
        if (psname != null && psname != ""){
           postStations = userDao.selectStationByName(psname);
       }
        return postStations;
    }

    //通过id查询驿站
    @Override
    public List<PostStation> queryStationById(Integer pid) {
        if (pid != null && pid > 0){
            List<PostStation> postStations = userDao.selectStationById(pid);
            return postStations;
        }
        return null;
    }

    //发布订单
    @Override
    public int postOrder(OrderEntity order) {
        //生成订单号
        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String dateString = sdf.format(date);
        Random random = new Random();
        Integer randomNumber = random.nextInt(100);
        dateString = dateString + randomNumber;
        order.setOid(dateString);
        int num = userDao.postOrder(order);
        return num;
    }

    //查询当前用户所有的订单
    @Override
    public List<Order> queryAllOrders(Integer uid) {
        if (uid > 0 && uid != null){
            List<Order> list = userDao.queryOrders(uid);
            return list;
        }
        return null;
    }

    @Override
    public List<Order> queryOrders2(Integer uid) {
        if (uid > 0 && uid != null){
            List<Order> list = userDao.queryOrders2(uid);
            return list;
        }
        return null;
    }

    @Override
    public List<Order> queryOrders3(Integer uid) {
        if (uid > 0 && uid != null){
            List<Order> list = userDao.queryOrders3(uid);
            return list;
        }
        return null;
    }

    //通过订单号查询订单
    @Override
    public List<Order> queryOrderByOid(String oid) {
        if (oid != null && oid !=""){
            List<Order> orders = userDao.queryOrderByOid(oid);
            return orders;
        }
        return null;
    }

    //添加收件人
    @Override
    public int addConsignee(Consignee consignee) {
        if (consignee != null){
            int num = userDao.addConsignee(consignee);
            return num;
        }
        return -1;
    }

    //删除收件人
    @Override
    public int deleteConsignee(Integer id) {
        if (id > 0 && id !=null){
            return userDao.deleteConsignee(id);
        }
        return -1;
    }

    //修改收件人
    @Override
    public int updateConsignee(Consignee consignee) {
        if (consignee != null){
            return userDao.updateConsignee(consignee);
        }
        return -1;
    }

    //查询当前订单收件人(通过当前订单收件人的id)
    @Override
    public Consignee queryConsigneeById(Integer cid) {
        if (cid >0 && cid != null){
            Consignee consignee = userDao.queryConsigneeById(cid);
            return consignee;
        }
        return null;
    }

    //查询所有收件人
    @Override
    public List<Consignee> queryAllConsignees(Integer uid) {
        if (uid > 0 && uid != null){
            List<Consignee> list = userDao.queryAllConsignees(uid);
            return list;
        }
       return null;
    }



}
