package com.shw.entity;

//用户类
public class User {
    //用户账号信息
    private Integer id; // id，唯一标识
    private Integer role; // 身份码 (1:Admin 2:user 3:post station 4:company)
    private String username; // 用户名(账号)
    private String password; // 密码
    //用户个人信息
    private String realname; //真实姓名
    private Integer age; //年龄
    private String gender; //性别
    private String creditnumber; //身份证号
    private String telephone; // 手机号
    private String address; //住址

    public User(){}

    public User(String username, String password) {
        this.username = username;
        this.password = password;
    }

    public Integer getRole() {
        return role;
    }

    public void setRole(Integer role) {
        this.role = role;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRealname() {
        return realname;
    }

    public void setRealname(String realname) {
        this.realname = realname;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getCreditnumber() {
        return creditnumber;
    }

    public void setCreditnumber(String creditnumber) {
        this.creditnumber = creditnumber;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", role=" + role +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", realname='" + realname + '\'' +
                ", age=" + age +
                ", gender='" + gender + '\'' +
                ", creditnumber='" + creditnumber + '\'' +
                ", telephone='" + telephone + '\'' +
                ", address='" + address + '\'' +
                '}';
    }

    public String toString(boolean flag) {
        String res = "User{" +
                "id=" + id +
                ", role=" + role +
                ", username='" + username + '\'' +
                '}';
        if (flag == true){
            res = "User{" +
                    "id=" + id +
                    ", username='" + username + '\'' +
                    ", realname='" + realname + '\'' +
                    ", age=" + age +
                    ", gender='" + gender + '\'' +
                    ", telephone='" + telephone + '\'' +
                    ", address='" + address + '\'' +
                    '}';
        }
        return res;
    }

}
