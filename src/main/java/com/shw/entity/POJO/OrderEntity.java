package com.shw.entity.POJO;

//下单时订单的实体
public class OrderEntity {
    private String oid;
    private Double price;
    private Integer uid;
    private Integer cid;
    private Integer pid;
    private String enterprise;

    public OrderEntity(Double price, Integer uid, Integer cid, Integer pid, String enterprise) {
        this.price = price;
        this.uid = uid;
        this.cid = cid;
        this.pid = pid;
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

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }
}
