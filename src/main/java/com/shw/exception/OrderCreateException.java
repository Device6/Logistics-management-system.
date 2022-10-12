package com.shw.exception;

public class OrderCreateException extends MyException{
    public OrderCreateException() {
        super();
    }

    public OrderCreateException(String message) {
        super(message);
    }
}
