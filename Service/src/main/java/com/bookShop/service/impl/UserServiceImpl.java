package com.bookShop.service.impl;

import com.bookShop.exception.QueryUserException;
import com.bookShop.exception.UserLoginValidatorException;
import com.bookShop.exception.UserNotFoundException;
import com.bookShop.mapper.UserMapper;
import com.bookShop.service.UserService;
import com.haizhang.entity.UserInfo;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("userServiceImpl")
public class UserServiceImpl implements UserService {
    @Resource
   private UserMapper userMapper;

    @Override
    public String registUserInfo(UserInfo userInfo)throws Exception {
        return userMapper.registUserInfo(userInfo)>0?"注册成功！":"注册失败！";
    }

    @Override
    public UserInfo loginUser(String username, String password)throws Exception{
        UserInfo userInfo=userMapper.loginUser(username,password);
        System.out.println(userInfo);
        if(userInfo==null) throw new UserLoginValidatorException("登录验证失败！请输入正确用户名及密码！");
        return userInfo;
    }

    @Override
    public List<UserInfo> queryUserInfo(UserInfo userInfo)throws Exception {
        List<UserInfo> users=userMapper.queryUserInfo(userInfo);
        if(users.isEmpty())throw new QueryUserException("用户不存在，请检查信息是否正确！");
        return users;

    }

    @Override
    public UserInfo queryUserInfoById(int id) throws UserNotFoundException {
        return userMapper.queryUserInfoById(id);
    }

    @Override
    public List<UserInfo> queryAllUserInfo()throws Exception {
        List<UserInfo>userInfos=userMapper.queryAllUserInfo();
        return userInfos;
    }

    @Override
    public String freezeUser(Integer userId) {
        return userMapper.freezeUser(userId)>0?"冻结成功!":"冻结失败!请检查该用户是否已被冻结！";
    }

    @Override
    public int unfreezeUser(Integer userId)throws Exception {
        return userMapper.unfreezeUser(userId);
    }

    @Override
    public String deleteUser(Integer userId)throws Exception {
        return userMapper.deleteUser(userId)>0?"删除成功!":"删除无效!请检查是否存在该用户!";
    }

    @Override
    public int reigstMerchant(Integer userId)throws Exception {
        return userMapper.reigstMerchant(userId);
    }

    @Override
    public String reviseUserInfo(Integer userId, UserInfo userInfo)throws Exception {
        return userMapper.reviseUserInfo(userInfo)>0?"修改成功!":"修改失败!";
    }

    @Override
    public List<UserInfo> queryUserByPage(int limit, int offset) {
        return userMapper.queryUserByPage(limit,offset);
    }

    @Override
    public int countUserNum() {
        return userMapper.countUserNum();
    }
}
