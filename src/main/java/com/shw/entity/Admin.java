package com.shw.entity;

//管理员
public class Admin {
    private Integer id;
    private Integer role;
    private String adminname;
    private String password;

    public Admin() {
    }

    public Admin(String adminname, String password) {
        this.adminname = adminname;
        this.password = password;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getRole() {
        return role;
    }

    public void setRole(Integer role) {
        this.role = role;
    }

    public String getAdminname() {
        return adminname;
    }

    public void setAdminname(String adminname) {
        this.adminname = adminname;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "Admin{" +
                "id=" + id +
                ", role=" + role +
                ", adminname='" + adminname + '\'' +
                ", password='" + password + '\'' +
                '}';
    }

}
