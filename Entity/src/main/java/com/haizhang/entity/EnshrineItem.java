package com.haizhang.entity;

/**
 * 收藏项
 *
 * @author 海章
 * @create 2018-12-15 15:46
 */
public class EnshrineItem {
    private int goodsId;  //货物id
    private int id;       //收藏id
    private int updatePriceFlag=0; //降价标志   -1为降价0为正常1为升价
    private int validFlag=0;  //无效标志   0为有效1为无校
    private double changePrice=0; //价格较上次降低或升高多少
    private String goodsName; //货物名称
    private double price; //价格

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }

    public double getChangePrice() {
        return changePrice;
    }

    public void setChangePrice(double changePrice) {
        this.changePrice = changePrice;
    }

    public int getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(int goodsId) {
        this.goodsId = goodsId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUpdatePriceFlag() {
        return updatePriceFlag;
    }

    public void setUpdatePriceFlag(int updatePriceFlag) {
        this.updatePriceFlag = updatePriceFlag;
    }

    public int getValidFlag() {
        return validFlag;
    }

    public void setValidFlag(int validFlag) {
        this.validFlag = validFlag;
    }

    @Override
    public String toString() {
        return "EnshrineItem{" +
                "goodsId=" + goodsId +
                ", id=" + id +
                ", updatePriceFlag=" + updatePriceFlag +
                ", validFlag=" + validFlag +
                ", changePrice=" + changePrice +
                ", goodsName='" + goodsName + '\'' +
                ", price=" + price +
                '}';
    }
}
