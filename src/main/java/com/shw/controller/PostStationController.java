package com.shw.controller;

import com.shw.dao.PostStationDao;
import com.shw.entity.Order;
import com.shw.entity.PostStation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/poststation")
public class PostStationController {

    @Autowired
    private PostStationDao postStationDao;

    @RequestMapping("/login")
    public String login(String account, String password, HttpServletRequest request){
        PostStation ps = postStationDao.postLoginIn(account,password);
        if (ps != null){
            request.getSession().setAttribute("station",ps.getPsname());
            request.getSession().setAttribute("pid",ps.getPid());
            return "forward:/Poststation/mainPage.jsp";
        }else {
            return null;
        }
    }

    @RequestMapping("/queryAllOrdersPaid")
    @ResponseBody
    public List<Order> queryAllOrdersPaid(String pid){
        return postStationDao.queryAllOrdersPaid(Integer.valueOf(pid));
    }

    @RequestMapping("/queryOrdersNotProcessed")
    @ResponseBody
    public List<Order> queryOrdersNotProcessed(String pid){
        return postStationDao.queryOrdersNotProcessed(Integer.valueOf(pid));
    }

    @RequestMapping("/queryOrdersProcessed")
    @ResponseBody
    public List<Order> queryOrdersProcessed(String pid){
        return postStationDao.queryOrdersProcessed(Integer.valueOf(pid));
    }

}
