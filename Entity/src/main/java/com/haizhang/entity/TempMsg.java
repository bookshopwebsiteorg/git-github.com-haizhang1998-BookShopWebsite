package com.haizhang.entity;

import java.util.Date;

/**
 * 留言信息
 */
public class TempMsg {
    //留言信息
    private String tempMsg;
    //本人的id
    private int userId;
    //朋友的id
    private int friendId;
    //留言时间
    private Date date;

    public String getTempMsg() {
        return tempMsg;
    }

    public void setTempMsg(String tempMsg) {
        this.tempMsg = tempMsg;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getFriendId() {
        return friendId;
    }

    public void setFriendId(int friendId) {
        this.friendId = friendId;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    @Override
    public String toString() {
        return "TempMsg{" +
                "tempMsg='" + tempMsg + '\'' +
                ", userId=" + userId +
                ", friendId=" + friendId +
                ", date=" + date +
                '}';
    }
}
