package com.bookShop.service;

import com.haizhang.entity.Friend;
import com.haizhang.entity.TempMsg;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ChatService {
    //查询离线记录
    public List<TempMsg> getTempMsg( int userId,int friendId);
    //清空指定朋友的所有离线记录
    public boolean clearTempMsg( int userId,int friendId);
    //插入离线记录
    public int addTempMsg(TempMsg tempMsg);

    //添加好友
    public String addFriend(int userId, int friendId);

    //删除指定好友
    public String deleteFriend( int userId,int friendId);

    //获取所有的好友
    public List<Friend> queryAllFriends(int userId);

    public Integer queryMsgNumber(int userId);
    //查询是否添加过好友
    public int queryExistFriend(int userId,int friendId);

    public Friend queryFriendById(int userId,int friendId);

}
