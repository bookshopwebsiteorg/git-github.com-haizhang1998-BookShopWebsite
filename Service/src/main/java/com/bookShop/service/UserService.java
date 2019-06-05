package com.bookShop.service;

import com.bookShop.exception.UserNotFoundException;
import com.haizhang.entity.UserInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserService {
    //注册
    public String registUserInfo(UserInfo userInfo)throws Exception;
    //登录
    public UserInfo loginUser( String username, String password)throws Exception;
    //查询用户
    public  List<UserInfo> queryUserInfo(UserInfo userInfo)throws Exception;
    //根据用户id获取用户
    public UserInfo queryUserInfoById(int id)throws UserNotFoundException;

    //查询全部用户
    public List<UserInfo> queryAllUserInfo()throws Exception;
    //冻结用户
    public String freezeUser(Integer userId);
    //解冻用户
    public int unfreezeUser(Integer userId)throws Exception;
    //删除用户
    public String deleteUser(Integer userId)throws Exception;
    //申请开店
    public int reigstMerchant(Integer userId)throws Exception;
    //修改账号信息
    public String reviseUserInfo(Integer userId,UserInfo userInfo)throws Exception;

    //实现分页查询
    public List<UserInfo> queryUserByPage(@Param("limit")int limit,@Param("offset")int offset);

    //计算用户数
    public int countUserNum();
}
