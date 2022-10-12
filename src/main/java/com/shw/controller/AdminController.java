package com.shw.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.shw.dao.AdminDao;
import com.shw.entity.*;
import com.shw.exception.NoSuchAdminException;
import com.shw.exception.RegisterException;
import com.shw.service.AdminService;
import com.shw.service.UserService;
import javafx.geometry.Pos;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

//管理员控制器
@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private AdminDao adminDao;
    @Autowired
    private AdminService adminService;
    @Autowired
    private UserService userService;

    /**
     * 管理员登录
     * @param adminname
     * @param password
     * @return
     */
    @RequestMapping("/adminLogin")
    public String adminLogin(String adminname,String password,HttpServletRequest request) throws NoSuchAdminException {
        Map<String,String> map = new HashMap<>();
        map.put("adminname",adminname);
        map.put("password",password);
        Admin admin = adminService.adminLogin(map);
        if (admin != null){
            request.getSession().setAttribute("id",admin.getId());
            request.getSession().setAttribute("adminname",admin.getAdminname());
            return "forward:/Admin/mainPage.jsp";
        }else {
            throw new NoSuchAdminException("管理员名或密码错误！");
        }
    }

    @ResponseBody
    @RequestMapping("/getAdminName")
    public String getAdminName(HttpServletRequest request, HttpServletResponse response){
        return (String) request.getSession().getAttribute("adminname");
    }

    @ResponseBody
    @RequestMapping("/getAdmin")
    public Admin getAdmin(String id){
        if (id != null && id!=""){
            return adminService.queryAdmin(Integer.valueOf(id));
        }
        return null;
    }

    /**
     * 登出
     * @param request
     * @return
     */
    @RequestMapping("/adminLoginout")
    public String adminLoginout(HttpServletRequest request){
        request.getSession().invalidate();
        return "forward:/loginPageForAdmin.jsp";
    }

    /**
     * 修改密码
     * @param password
     */
    @RequestMapping("/updatePass")
    public String updatePass(String password,HttpServletRequest request){
        Integer id = (Integer) request.getSession().getAttribute("id");
        if (password != null && password != "") {
            int res = adminService.updatePass(id, password);
        }
        return "forward:/loginPageForAdmin.jsp";
    }

    @RequestMapping("/queryAllUsers")
    @ResponseBody
    public List<User> queryAllUsers(){
        List<User> users = adminService.queryAllUsers();
        return users;
    }

    @RequestMapping("/queryAllPostStations")
    @ResponseBody
    public List<PostStation> queryAllPostStations(){
        List<PostStation> postStations = adminService.queryAllPostStations();
        return postStations;
    }

    @RequestMapping("/queryPostStationById")
    @ResponseBody
    public List<PostStation> queryPostStationById(String pid){
        if (pid != null && pid != ""){
            Integer id = Integer.valueOf(pid);
            List<PostStation> postStations = userService.queryStationById(id);
            return postStations;
        }
        return null;
    }

    @RequestMapping("/queryPostStationByName")
    @ResponseBody
    public List<PostStation> queryPostStationByName(String psname){
        if (psname != null && psname != ""){
            List<PostStation> stations = userService.queryStationByName(psname);
            return stations;
        }
        return null;
    }


    @RequestMapping("/addPostStation")
    @ResponseBody
    public void addPostStation(String account,String password,String psname,String telephone,String psaddress) throws RegisterException {
        PostStation postStation = new PostStation(account,password,psname,telephone,psaddress);
        if (postStation != null){
            int result =  adminService.addPostStation(postStation);
        }else {
            throw new RegisterException("注册站点失败");
        }
    }

    @RequestMapping("/deletePostStationById")
    @ResponseBody
    public void deletePostStationById(String pid) throws Exception {
        if (pid != null && pid !=""){
            Integer id = Integer.valueOf(pid);
            if (userService.queryStationById(id)!=null){
                adminService.deletePostStation(id);
            }else{
                throw new Exception("没有此站点");
            }
        }else{
            throw new Exception("参数错误！");
        }
    }

    @RequestMapping("/queryAllOrders")
    @ResponseBody
    public List<Order> queryAllOrders(){
        return adminDao.queryAllOrders();
    }

    @RequestMapping("/queryAllOrdersPaid")
    @ResponseBody
    public List<Order> queryAllOrdersPaid(){
        return adminDao.queryAllOrdersPaid();
    }

    @RequestMapping("queryOrder")
    @ResponseBody
    public List<Order> queryOrder(String oid){
        return userService.queryOrderByOid(oid);
    }

    @RequestMapping("/queryOrdersByPid")
    @ResponseBody
    public List<Order> queryOrdersByPid(String pid){
        return adminDao.queryOrdersByPid(Integer.valueOf(pid));
    }

    @RequestMapping("/queryOrdersByEnter")
    @ResponseBody
    public List<Order> queryOrdersByEnter(String enterprise){
        return adminDao.queryOrdersByEnter(enterprise);
    }

    @RequestMapping("/updateOrder")
    @ResponseBody
    public void updateOrder(String oid,String state){
        if (oid != null && state != null){
            adminService.updateOrder(oid,state);
        }
    }

    @RequestMapping("/queryAllEnterprises")
    @ResponseBody
    public List<Enterprise> queryAllEnterprises(){
        return adminService.queryAllEnterprises();
    }

    @RequestMapping("/queryEnterpriseByName")
    @ResponseBody
    public List<Enterprise> queryEnterpriseByName(String enterprise){
        return adminService.queryEnterpriseByName(enterprise);
    }

    @RequestMapping("/deleteEnterpriseByName")
    @ResponseBody
    public void deleteEnterpriseByName(String enterprise){
        adminService.deleteEnterprise(enterprise);
    }

}
