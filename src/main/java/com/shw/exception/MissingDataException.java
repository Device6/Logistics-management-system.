package com.shw.exception;

//无法查询数据异常
public class MissingDataException extends MyException{
    public MissingDataException() {
        super();
    }

    public MissingDataException(String message) {
        super(message);
    }
}
