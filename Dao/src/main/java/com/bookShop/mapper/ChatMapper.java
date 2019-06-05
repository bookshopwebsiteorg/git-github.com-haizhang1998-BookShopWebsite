package com.bookShop.mapper;

import com.haizhang.entity.Friend;
import com.haizhang.entity.TempMsg;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 专门管理有关聊天的操作
 */
public interface ChatMapper {
    //查询离线记录
    public List<TempMsg> getTempMsg(@Param("userId") int userId,@Param("friendId") int friendId);
    //清空指定朋友的所有离线记录
    public boolean clearTempMsg(@Param("userId") int userId,@Param("friendId") int friendId);
    //插入离线记录
    public int addTempMsg(TempMsg tempMsg);


    //添加好友
    public boolean addFriend(@Param("userId") int userId,@Param("friendId") int friendId);

    //删除指定好友
    public boolean deleteFriend(@Param("userId") int userId,@Param("friendId") int friendId);

    //获取所有的好友
    public List<Friend> queryAllFriends(@Param("userId")int userId);

    //查询是否添加过此好友
    public int queryExistFriend(@Param("userId")int userId,@Param("friendId")int friendId);

    //查询指定的好友
    public Friend queryFriendById(@Param("userId")int userId,@Param("friendId")int friendId);
    //获取所有离线消息的条数
    public Integer queryMsgNumber(int userId);



}
