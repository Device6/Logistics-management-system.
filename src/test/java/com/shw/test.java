package com.shw;

import com.shw.dao.AdminDao;
import com.shw.dao.EnterpriseDao;
import com.shw.dao.PostStationDao;
import com.shw.dao.UserDao;
import com.shw.entity.*;
import com.shw.entity.POJO.OrderEntity;
import com.shw.service.AdminService;
import com.shw.service.UserService;
import javafx.geometry.Pos;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import java.text.SimpleDateFormat;
import java.util.*;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration("src/main/resources")
@ContextConfiguration(locations = {"classpath:config/springMVC.xml",
        "classpath:config/mybatis.xml","classpath:config/applicationContext.xml"})
public class test {
    @Autowired
    private UserDao userDao;
    @Autowired
    private UserService userService;
    @Autowired
    private AdminDao adminDao;
    @Autowired
    private AdminService adminService;
    @Autowired
    private PostStationDao psDao;
    @Autowired
    private EnterpriseDao enterpriseDao;

    @Test
    public void test01(){
        User user = userService.userLogin("鞠强","123456");
        System.out.println(user);
    }
    @Test
    public void test02(){
        User user = new User("陈龙伟","123456");
        int num = userService.addUser(user);
        System.out.println(num + "," + user);
    }

    @Test
    public void test03(){
        int num = 3;
        User user = userService.queryUserById(num);
        System.out.println(user);
    }

    @Test
    public void test04(){
        Map<String,String> map = new HashMap<>();
        map.put("adminname","root");
        map.put("password","123456");
        Admin admin = adminService.adminLogin(map);
        System.out.println(admin);
    }

    @Test
    public void testUpdatePassword(){
        String newPassword = "1234567";
        Integer id = 1;
        int num =  userService.updatePassword(newPassword,id);
        User user =  userService.queryUserById(id);
        System.out.println(num);
        System.out.println(user);
    }

    //生成订单号
    @Test
    public void generateOid(){
        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String dateString = sdf.format(date);
        Random random = new Random();
        Integer randomNumber = random.nextInt(100);
        dateString = dateString + randomNumber;
        System.out.println(dateString);
    }



    @Test
    public void testConsginee(){
        List<Consignee> list = userService.queryAllConsignees(1);
        list.forEach(consignee -> {
            System.out.println(consignee);
        });
    }

    @Test
    public void testAddConsignee(){
        Consignee consignee = new Consignee("敖夏凯","江西九江","12345678911");
        consignee.setUid(1);
        int res = userService.addConsignee(consignee);
    }

    @Test
    public void testOrder_test(){
//        Double price = 999.99;
//        OrderEntity newOrder = new OrderEntity(price,1,1,1);
//        int res = userService.postOrder(newOrder);
//        if (res == 1){
//            System.out.println("下单成功!");
//            List<Order> list = userService.queryAllOrders(1);
//            list.forEach(order -> {
//                System.out.println(order);
//            });
//        }
        List<Order> list = userService.queryAllOrders(1);
        list.forEach(order -> {
            System.out.println(order);
        });

    }

    @Test
    public void testEverything(){
       List<PostStation> list = adminDao.pe_Relation("中通快递");
        list.forEach(postStation -> {
            System.out.println(postStation);
        });
    }

    @Test
    public void test(){
       List<Order> lists = userService.queryOrderByOid("2022051409125420");
       lists.forEach(list->{
           System.out.println(list);
       });
    }

}