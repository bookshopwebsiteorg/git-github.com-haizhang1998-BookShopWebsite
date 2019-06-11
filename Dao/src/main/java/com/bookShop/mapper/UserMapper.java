
package com.bookShop.mapper;
import com.haizhang.entity.UserInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 用户数据库操作接口
 */
public interface UserMapper {
    //注册
    public int registUserInfo(UserInfo userInfo);
    //登录
    public UserInfo loginUser(@Param("username") String username, @Param("password") String password);
    //查询指定用户
    public  List<UserInfo> queryUserInfo(UserInfo userInfo);
    //查询全部用户
    public  List<UserInfo> queryAllUserInfo();
    //冻结用户
    public int freezeUser(@Param("id")Integer userId);
    //解冻用户
    public int unfreezeUser(@Param("id")Integer userId);
    //删除用户
    public int deleteUser(@Param("id")Integer id);
    //申请开店
    public int reigstMerchant(@Param("id")Integer userId);
    //修改账号信息
    public int reviseUserInfo(UserInfo userInfo);
    //实现分页查询
    public List<UserInfo> queryUserByPage(@Param("limit")int limit,@Param("offset")int offset);
    //得到所有用户数量
    public int countUserNum();
    //根据用户id获取用户
    public UserInfo queryUserInfoById(int id);

}
