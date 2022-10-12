package com.shw.entity;

//货车司机
public class Driver {
    private String id; //工号
    private String password;
    private Enterprise enterprise; //所属公司
    private String realname;
    private String phone;

    public Driver() {
    }

    public Driver(String id, String password, Enterprise enterprise, String realname, String phone) {
        this.id = id;
        this.password = password;
        this.enterprise = enterprise;
        this.realname = realname;
        this.phone = phone;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Enterprise getEnterprise() {
        return enterprise;
    }

    public void setEnterprise(Enterprise enterprise) {
        this.enterprise = enterprise;
    }

    public String getRealname() {
        return realname;
    }

    public void setRealname(String realname) {
        this.realname = realname;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Override
    public String toString() {
        return "Driver{" +
                "id='" + id + '\'' +
                ", enterprise=" + enterprise +
                ", realname='" + realname + '\'' +
                ", phone='" + phone + '\'' +
                '}';
    }

    public String toString(boolean flag) {
        if (flag == true) {
            return "Driver{" +
                    "id='" + id + '\'' +
                    ", realname='" + realname + '\'' +
                    ", phone='" + phone + '\'' +
                    '}';
        } else return "Driver{" +
                "id='" + id + '\'' +
                ", enterprise=" + enterprise +
                ", realname='" + realname + '\'' +
                ", phone='" + phone + '\'' +
                '}';
    }
}
