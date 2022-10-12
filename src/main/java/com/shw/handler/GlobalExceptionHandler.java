package com.shw.handler;

import com.shw.exception.NoSuchUserException;
import com.shw.exception.RegisterException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

//控制器处理异常增强
@ControllerAdvice
public class GlobalExceptionHandler{ //全局异常处理器

    //处理用户注册的异常
    @ExceptionHandler(RegisterException.class)
    public ModelAndView doUserRegisterException(Exception e){
        ModelAndView mv = new ModelAndView();
        mv.addObject("msg","注册信息出现问题，请重新输入正确的格式！");
        mv.addObject("exp",e);
        mv.setViewName("registerError");
        return mv;
    }

    //处理用户登录异常
    @ExceptionHandler(NoSuchUserException.class)
    public ModelAndView doUserLoginException(Exception e){
        ModelAndView mv = new ModelAndView();
        mv.addObject("msg","用户名或密码错误，请重新输入!");
        mv.addObject("exp",e);
        mv.setViewName("loginError");
        return mv;
    }


    //处理未定义的异常
    @ExceptionHandler
    public ModelAndView doUndefinedException(Exception e){
        ModelAndView mv = new ModelAndView();
        mv.addObject("msg","出现其他未知异常,请勿随意操作!");
        mv.addObject("exp",e);
        mv.setViewName("undefinedError");
        return mv;
    }

}
