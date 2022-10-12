package com.shw.exception;

//密码格式错误异常
public class WrongPassFormatException extends MyException{
    public WrongPassFormatException() {
        super();
    }

    public WrongPassFormatException(String message) {
        super(message);
    }
}
