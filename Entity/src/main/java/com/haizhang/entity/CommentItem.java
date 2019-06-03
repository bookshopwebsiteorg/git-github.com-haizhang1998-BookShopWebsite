package com.haizhang.entity;

import java.io.Serializable;
import java.util.Date;
/**
 * 用户评论的Javabean
 * @author 海章
 * @create 2018-12-14 21:09
 */
public class CommentItem implements Serializable {
    private int goodsId;   //评论的货物编号
    private int id;        //评论人的id
    private String commentDetail;  //评论的具体信息
    private Date time;     //评论发布的时间
    private String nikeName; //用户昵称
    private int score; //书本的评分
    private String imageLogo;//评论用户的头像
    private long orderId;

    public long getOrderId() {
        return orderId;
    }

    public void setOrderId(long orderId) {
        this.orderId = orderId;
    }

    public String getNikeName() {
        return nikeName;
    }

    public void setNikeName(String nikeName) {
        this.nikeName = nikeName;
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

    public String getCommentDetail() {
        return commentDetail;
    }

    public void setCommentDetail(String commentDetail) {
        this.commentDetail = commentDetail;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public int getScore() {
        return score;
    }

    public String getImageLogo() {
        return imageLogo;
    }

    public void setImageLogo(String imageLogo) {
        this.imageLogo = imageLogo;
    }

    public void setScore(int score) {
        this.score = score;
    }

    @Override
    public String toString() {
        return "CommentItem{" +
                "goodsId=" + goodsId +
                ", id=" + id +
                ", commentDetail='" + commentDetail + '\'' +
                ", time=" + time +
                ", nikeName='" + nikeName + '\'' +
                ", score=" + score +
                ", imageLogo='" + imageLogo + '\'' +
                '}';
    }
}
