package com.haizhang.entity;

/**
 * @author Austin
 * @date 2019/5/25
 */
public class OrderDetail {
    private Long id;
    private Long orderId; //订单编号
    private int goodsId;  //商品编号
    private int num;  //购买数量
    private String detail; //商品描述
    private double price;   //商品单价
    private String image;   //商品图片
    private String shopName;  //店铺名
    private String goodsName; //商品名
    private int merchantId;   //商家id

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public int getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(int goodsId) {
        this.goodsId = goodsId;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getShopName() {
        return shopName;
    }

    public void setShopName(String shopName) {
        this.shopName = shopName;
    }

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }

    public int getMerchantId() {
        return merchantId;
    }

    public void setMerchantId(int merchantId) {
        this.merchantId = merchantId;
    }

    @Override
    public String toString() {
        return "OrderDetail{" +
                "id=" + id +
                ", orderId=" + orderId +
                ", goodsId=" + goodsId +
                ", num=" + num +
                ", detail='" + detail + '\'' +
                ", price=" + price +
                ", image='" + image + '\'' +
                ", shopName='" + shopName + '\'' +
                ", goodsName='" + goodsName + '\'' +
                '}';
    }
}
