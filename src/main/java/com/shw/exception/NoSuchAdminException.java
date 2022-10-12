package com.shw.exception;

public class NoSuchAdminException extends MyException{
    public NoSuchAdminException() {
        super();
    }

    public NoSuchAdminException(String message) {
        super(message);
    }
}
