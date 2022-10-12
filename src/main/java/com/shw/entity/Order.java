package com.shw.entity;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.TimeZone;

public class Order {
    private String oid;
    private Double price;
    private String paid;
    private Timestamp createtime;
    private String state; //运输状态
    private User consignor;
    private Consignee consignee;
    private PostStation postStation;
    private Enterprise enterprise;

    public Order() {
    }

    public Order(Double price, User consignor, Consignee consignee, PostStation postStation, Enterprise enterprise) {
        this.price = price;
        this.consignor = consignor;
        this.consignee = consignee;
        this.postStation = postStation;
        this.enterprise = enterprise;
    }

    public String getOid() {
        return oid;
    }

    public void setOid(String oid) {
        this.oid = oid;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getPaid() {
        return paid;
    }

    public void setPaid(String paid) {
        this.paid = paid;
    }

    public String getCreatetime() {
        return tolocalString(createtime);
    }

    public void setCreatetime(Timestamp createtime) {
        this.createtime = createtime;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public User getConsignor() {
        return consignor;
    }

    public void setConsignor(User consignor) {
        this.consignor = consignor;
    }

    public Consignee getConsignee() {
        return consignee;
    }

    public void setConsignee(Consignee consignee) {
        this.consignee = consignee;
    }

    public PostStation getPostStation() {
        return postStation;
    }

    public void setPostStation(PostStation postStation) {
        this.postStation = postStation;
    }

    private static String tolocalString(Timestamp timestamp){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        sdf.setTimeZone(TimeZone.getTimeZone("Asiz/Shanghai"));
        String time = sdf.format(timestamp);
        return time;
    }

    @Override
    public String toString() {
        return "Order{" +
                "oid='" + oid + '\'' +
                ", price=" + price +
                ", paid='" + paid + '\'' +
                ", createtime=" + tolocalString(createtime) +
                ", state='" + state + '\'' +
                ", consignor=" + consignor +
                ", consignee=" + consignee +
                ", postStation=" + postStation +
                ", enterprise=" + enterprise +
                '}';
    }

    public String toString(boolean flag) {
        if (flag == true){
            return "Order{" +
                    "oid='" + oid + '\'' +
                    ", price=" + price +
                    ", paid='" + paid + '\'' +
                    ", createtime=" + createtime +
                    ", state='" + state + '\'' +
                    '}';
        }else return "Order{" +
                "oid='" + oid + '\'' +
                ", price=" + price +
                ", paid='" + paid + '\'' +
                ", createtime=" + createtime +
                ", state='" + state + '\'' +
                ", consignor=" + consignor +
                ", consignee=" + consignee +
                ", postStation=" + postStation +
                ", enterprise=" + enterprise +
                '}';
    }
}
