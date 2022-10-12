package com.shw.entity.POJO;

import com.shw.entity.Driver;

//保存订单号和送达地址以及配送员
public class OrderShort {
    private String oid;
    private String address;
    private Driver driver;

    public OrderShort() {
    }

    public OrderShort(String oid, String address) {
        this.oid = oid;
        this.address = address;
    }

    public OrderShort(String oid, String address, Driver driver) {
        this.oid = oid;
        this.address = address;
        this.driver = driver;
    }

    public String getOid() {
        return oid;
    }

    public void setOid(String oid) {
        this.oid = oid;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Driver getDriver() {
        return driver;
    }

    public void setDriver(Driver driver) {
        this.driver = driver;
    }

    @Override
    public String toString() {
        return "OrderShort{" +
                "oid='" + oid + '\'' +
                ", address='" + address + '\'' +
                ", driver=" + driver +
                '}';
    }
}
