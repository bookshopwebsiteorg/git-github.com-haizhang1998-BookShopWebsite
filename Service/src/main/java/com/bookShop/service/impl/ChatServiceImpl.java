package com.bookShop.service.impl;

import com.bookShop.mapper.ChatMapper;
import com.bookShop.service.ChatService;
import com.haizhang.entity.Friend;
import com.haizhang.entity.TempMsg;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
@Service
public class ChatServiceImpl implements ChatService {
    @Resource
    private ChatMapper chatMapper;

    /**
     * 获取离线消息
     * @param userId 本人的id
     * @param friendId 朋友的id
     * @return 离线消息列表
     */
    @Override
    public List<TempMsg> getTempMsg(int userId, int friendId) {
        return chatMapper.getTempMsg(userId,friendId);
    }

    /**
     * 清空指定的离线消息
     * @param userId
     * @param friendId
     * @return
     */
    @Override
    public boolean clearTempMsg(int userId, int friendId) {
        return chatMapper.clearTempMsg(userId,friendId);
    }

    /**
     * 添加离线消息
     * @param tempMsg
     * @return
     */
    @Override
    public int addTempMsg(TempMsg tempMsg) {
        tempMsg.setDate(new Date());
        return chatMapper.addTempMsg(tempMsg);
    }


    /**
     * 添加朋友
     * @param userId
     * @param friendId
     * @return
     */
    @Override
    public String addFriend(int userId, int friendId) {
        if(friendId<=0){
            return "添加失败!请确认是否存在此用户！";
        }
        String msg=chatMapper.addFriend(userId,friendId)&&chatMapper.addFriend(friendId,userId)?"添加成功！":"添加失败！请检查网络是否通畅！";
        return msg;
    }


    /**
     * 删除朋友
     * @param userId
     * @param friendId
     * @return
     */
    @Override
    public String deleteFriend(int userId, int friendId) {
        if(friendId <=0){
            return "删除失败！用户id不正确";
        }
        return chatMapper.deleteFriend(userId,friendId)?"删除成功！":"删除失败！请检查是否存在该用户";
    }

    @Override
    public List<Friend> queryAllFriends(int userId) {
        return chatMapper.queryAllFriends(userId);
    }

    @Override
    public Integer queryMsgNumber(int userId) {
        return chatMapper.queryMsgNumber(userId);
    }

    @Override
    public int queryExistFriend(int userId, int friendId) {
        return chatMapper.queryExistFriend(userId,friendId);
    }

    @Override
    public Friend queryFriendById(int userId, int friendId) {
        return chatMapper.queryFriendById(userId,friendId);
    }
}
