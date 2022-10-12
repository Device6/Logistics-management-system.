package com.shw.entity;

//驿站
public class PostStation {
    private Integer pid;
    private String role; // 驿站(默认为3)
    private String account; // 账号
    private String password; // 密码
    private String psname; // 驿站名
    private String telephone;// 联系电话
    private String psaddress; // 地址

    public PostStation() {
    }

    public PostStation(String account, String password, String psname, String telephone, String psaddress) {
        this.account = account;
        this.password = password;
        this.psname = psname;
        this.telephone = telephone;
        this.psaddress = psaddress;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPsname() {
        return psname;
    }

    public void setPsname(String psname) {
        this.psname = psname;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getPsaddress() {
        return psaddress;
    }

    public void setPsaddress(String psaddress) {
        this.psaddress = psaddress;
    }

    @Override
    public String toString() {
        return "PostStation{" +
                "pid=" + pid +
                ", psname='" + psname + '\'' +
                ", telephone='" + telephone + '\'' +
                ", psaddress='" + psaddress + '\'' +
                '}';
    }

}
