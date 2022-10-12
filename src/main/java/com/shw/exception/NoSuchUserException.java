package com.shw.exception;

// 用户不存在异常
public class NoSuchUserException extends MyException{
    public NoSuchUserException() {
        super();
    }

    public NoSuchUserException(String message) {
        super(message);
    }
}
