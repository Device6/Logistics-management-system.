package com.shw.controller;

import com.shw.dao.UserDao;
import com.shw.entity.*;
import com.shw.entity.POJO.OrderEntity;
import com.shw.exception.*;
import com.shw.service.AdminService;
import com.shw.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserDao userDao;
    @Resource
    private UserService userService;
    @Autowired
    private AdminService adminService;

    /**
     * 用户注册
     * @param username 用户名
     * @param password 密码
     * @return 主页（重新登录）
     * @throws RegisterException 注册异常
     */
    @RequestMapping("/userRegister")
    public String userRegister(String username,String password) throws RegisterException {
        User user =  new User(username,password);
        int num = userService.addUser(user);
        if (num > 0){
            // 注册成功，跳转登录页面
            return "redirect:/loginPageForUser.jsp";
        }else{
            throw new RegisterException("注册失败，请求出现问题!");
        }
    }

    @RequestMapping("/findUserByUsername")
    @ResponseBody
    public String findUserByUsername(String username){
        if (userDao.selectUserByUsername(username) != null){
            return "no";
        }else {
            return "yes";
        }
    }


    /**
     * 用户登录
     * @param username 用户名
     * @param password 密码
     * @return
     */
    @RequestMapping("/userLogin")
    public String userLogin(String username, String password,HttpServletRequest request) throws NoSuchUserException {
        User user = userService.userLogin(username,password);
        int id = user.getId();
        String location="";
        //判断存在此用户
        if (user != null){
            //用户存在，跳转到主页
            request.getSession().setAttribute("id",id);
            request.getSession().setAttribute("password",password);
            return "forward:/User/mainPage.jsp";
        }else{
            throw new NoSuchUserException("用户名或密码错误！");
        }
    }


    @RequestMapping(value = "/getUserName",produces = "text/html;charset=utf-8")
    @ResponseBody
    public String getUserName(String id){
        Integer uid = Integer.valueOf(id);
        if (uid != null){
            User user = userService.queryUserById(uid);
            return user.getRealname();
        }
        return null;
    }

    @RequestMapping("/getUser")
    @ResponseBody
    public User getUser(String id){
        Integer uid = Integer.valueOf(id);
        return userService.queryUserById(uid);
    }


    //更改密码
    @RequestMapping(value = "/updatePassword",method = RequestMethod.POST)
    @ResponseBody
    public void updatePassword(String password,String id) throws WrongPassFormatException {
        if (password != null && id != null){
            userService.updatePassword(password,Integer.valueOf(id));
        }else{
            throw new WrongPassFormatException("密码格式错误!");
        }
    }

    /**
     * 验证旧密码是否正确
     * @param oldPass
     * @return
     */
    @RequestMapping(value = "/confirmOldPass",method = RequestMethod.POST)
    @ResponseBody
    public String confirmOldPass(String oldPass,HttpServletRequest request){
        String id = request.getParameter("id");
        String password = userService.selectPass(Integer.valueOf(id));
        if (oldPass.equals(password)){
            //旧密码正确
            return "true";
        }
        return "false";
    }

    // 查询所有驿站
    @RequestMapping("/selectAllStations")
    @ResponseBody
    public List<PostStation> selectAllStations() throws MissingDataException {
        List<PostStation> list = userService.queryAllStations();
        if (list != null){
         return list; //servlet会将集合转成json集合
        }else{
            throw new MissingDataException("无法获取数据，或数据为空");
        }
    }

    //通过名称查询驿站
    @ResponseBody
    @RequestMapping("/selectStationByName")
    public List<PostStation> selectStationByName(String psname,HttpServletRequest request){
        List<PostStation> stations = userService.queryStationByName(psname);
        if (stations == null){
            request.getSession().setAttribute("msg","没有此驿站!");
        }
        return stations;
    }

    @RequestMapping("/postOrder")
    @ResponseBody
    public void postOrder(String price,String uid,String cid,String pid,String enterprise) throws OrderCreateException {
        //生成订单
        if (price != null && uid != null && cid != null && pid != null && enterprise !=null){
            OrderEntity order = new OrderEntity(Double.valueOf(price),Integer.valueOf(uid),Integer.valueOf(cid),Integer.valueOf(pid),enterprise);
            userService.postOrder(order);
        }else{
            throw new OrderCreateException("无法创建此订单");
        }
    }

    @RequestMapping("/queryAllOrders")
    @ResponseBody
    public List<Order> queryAllOrders(String id){
        if (id != null && id !=""){
            List<Order> orders = userService.queryAllOrders(Integer.valueOf(id));
            return orders;
        }
        return null;
    }

    @RequestMapping("/queryAllOrders2")
    @ResponseBody
    public List<Order> queryAllOrders2(String id){
        if (id != null && id !=""){
            List<Order> orders = userService.queryOrders2(Integer.valueOf(id));
            return orders;
        }
        return null;
    }

    @RequestMapping("/queryAllOrders3")
    @ResponseBody
    public List<Order> queryAllOrders3(String id){
        if (id != null && id !=""){
            List<Order> orders = userService.queryOrders3(Integer.valueOf(id));
            return orders;
        }
        return null;
    }


    @RequestMapping("/queryAllConsignees")
    @ResponseBody
    public List<Consignee> queryAllConsignees(String id){
        if (id != null && id !=""){
            List<Consignee> consignees = userService.queryAllConsignees(Integer.valueOf(id));
            return consignees;
        }
        return null;
    }

    @RequestMapping("/deleteConsignee")
    @ResponseBody
    public void deleteConsignee(String id) throws Exception {
        if (id != null && id != ""){
            userService.deleteConsignee(Integer.valueOf(id));
        }else {
            throw new Exception("删除失败！");
        }
    }

    @RequestMapping("/addConsignee")
    @ResponseBody
    public void addConsignee(String uid,String name,String phone,String address){
        Consignee consignee = new Consignee(name,phone,address);
        consignee.setUid(Integer.valueOf(uid));
        if (consignee != null) {
            userService.addConsignee(consignee);
        }
    }

    @RequestMapping("/updateConsignee")
    @ResponseBody
    public void updateConsignee(String id,String name,String phone,String address){
        if (id !=null && id !=""){
            Consignee consignee = userService.queryConsigneeById(Integer.valueOf(id));
            consignee.setName(name);
            consignee.setPhone(phone);
            consignee.setAddress(address);
            userService.updateConsignee(consignee);
        }
    }

    @RequestMapping("/queryAllStations")
    @ResponseBody
    public List<PostStation> queryAllStations(){
        return userService.queryAllStations();
    }

    @RequestMapping("/queryAllEnterprises")
    @ResponseBody
    public List<Enterprise> queryAllEnterprises(){
        return adminService.queryAllEnterprises();
    }

    @RequestMapping("/updateInformation")
    @ResponseBody
    public void updateInformation(String id,String realname,String age,String gender,String telephone,String address){
        User user = userService.queryUserById(Integer.valueOf(id));
        if (user != null){
            user.setRealname(realname);
            user.setAge(Integer.valueOf(age));
            user.setGender(gender);
            user.setTelephone(telephone);
            user.setAddress(address);
            userService.updateInfo(user);
        }
    }

    @RequestMapping("/payForOrder")
    @ResponseBody
    public void payForOrder(String oid){
        if (oid != null && oid !=""){
            userDao.payTheOrder(oid);
        }
    }

}

