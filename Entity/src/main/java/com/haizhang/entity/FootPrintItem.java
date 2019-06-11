package com.haizhang.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 我的足迹项
 *
 * @author 海章
 * @create 2018-12-16 10:18
 */
public class FootPrintItem implements Serializable ,Comparable<FootPrintItem>{
    private int goodsId;
    private int id;
    private Date time;
    private String imgDir;
    private String goodsName;

    public String getImgDir() {
        return imgDir;
    }

    public void setImgDir(String imgDir) {
        this.imgDir = imgDir;
    }

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
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


    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    @Override
    public String toString() {
        return "FootPrintItem{" +
                "goodsId=" + goodsId +
                ", id=" + id +
                ", time='" + time + '\'' +
                ", imgDir='" + imgDir + '\'' +
                ", goodsName='" + goodsName + '\'' +
                '}';
    }

    //重写equals()方法
    @Override
    public boolean equals(Object obj)
    {
        if(obj==this)//自己和自己比较
            return true;//那就是同一个相等了
        //传入的引用不为空，而且两个的类型一样
        if(obj!=null&&obj.getClass()==this.getClass())
        {
            FootPrintItem footPrintItem=(FootPrintItem) obj;//类型转换
            return this.time==footPrintItem.time&&this.goodsId==footPrintItem.goodsId;
            //如果两个的编号一样，那就认为相等
        }
        return false;
    }
    @Override
    public int compareTo(FootPrintItem o) {
        return (this.getTime().after(o.getTime()))?1:(this.getTime().before(o.getTime()))?-1:0;
    }
}