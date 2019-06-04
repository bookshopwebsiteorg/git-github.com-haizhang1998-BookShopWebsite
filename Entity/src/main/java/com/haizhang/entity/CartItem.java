package com.haizhang.entity;

import java.io.Serializable;

/**
 * 存放购物车里面的信息
 *
 * @author 海章
 * @create 2018-11-17 20:38
 */
public class CartItem implements Serializable {
    private int goodsId;
    private int userId;
    private String imgDir;
    private String goodsName;
    private double price;
    private int sumOfGoods;        //订单货品的数量
    private double totalPrice;      //订单的货品总金额
    private int remainNumber; //库存
    //private double allPrice;//购物车总价

   /* public double getAllPrice(){return allPrice;}
    public void setAllPrice(double allPrice){ this.allPrice=allPrice; }*/

    public double getTotalPrice() {
        return totalPrice;
    }
    public void setTotalPrice(double totalPrice) {
        this.totalPrice = sumOfGoods*price;
    }

    public CartItem(){}

   public int getGoodsId(){ return goodsId;}
   public void setGoodsId(int goodsId){this.goodsId = goodsId;}

    public int getSumOfGoods() {
        return sumOfGoods;
    }
    public void setSumOfGoods(int sumOfGoods) {
        this.sumOfGoods = sumOfGoods;
    }

    public int getUserId(){ return userId;}
    public void setUserId(int userId){this.userId = userId;}

    public int getRemainNumber(){ return remainNumber;}
    public void setRemainNumber(int remainNumber){this.remainNumber = remainNumber;}

    public String getGoodsName() {return goodsName; }
    public void setGoodsName(String goodsName) {this.goodsName = goodsName; }

    public String getImgDir() { return imgDir; }
    public void setImgDir(String imgDir) { this.imgDir = imgDir; }

    public double getPrice(){ return price;}
    public void setPrice(){this.price = price;}

    @Override
    public String toString() {
        return "CartItem{" +
                "goodsId=" + goodsId +
                ", userId=" + userId +
                ", imgDir='" + imgDir + '\'' +
                ", goodsName=" + goodsName +
                ", price='" + price + '\'' +
                ", sumOfGoods=" + sumOfGoods +
                ", totalPrice='" + totalPrice + '\'' +
                '}';
    }

}
