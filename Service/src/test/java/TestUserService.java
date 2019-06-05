import com.bookShop.service.UserService;
import com.haizhang.entity.UserInfo;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

import org.apache.log4j.*;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@Transactional()
@TransactionConfiguration(transactionManager = "transactionManager",defaultRollback = true)
@ContextConfiguration("classpath:spring-aop.xml")
public class TestUserService {

    private static final Logger logger=Logger.getLogger(TestUserService.class);
    @Resource
    UserService userServiceImpl;

    @Test
    public void testLoginUserInfo()throws Exception{
        UserInfo u=userServiceImpl.loginUser("2368521029@qq.com","123456");
        System.out.println(u);
    }


    @Test
    public void testRegistUserInfo()throws Exception{
        UserInfo userInfo=new UserInfo();
        userInfo.setPassword("1234567");
        userInfo.setUsername("12345679");
        userInfo.setNikeName("qqqqqqqqqqq");
        userInfo.setName("asdasd");
        userInfo.setPhone("12312312");
        userInfo.setAddr("beijing");
        String u=userServiceImpl.registUserInfo(userInfo);
        System.out.println(u);

    }


    @Test
    public void testQueryUserInfo()throws Exception{
        UserInfo userInfo=new UserInfo();
        UserInfo user=new UserInfo();
        user.setNikeName("克");
        user.setNikeName("克");
        List<UserInfo> userInfos=userServiceImpl.queryUserInfo(user);
        System.out.println(userInfos);

    }

    @Test
    public void testQueryAllUserInfo()throws Exception{

        List<UserInfo>allUsers=userServiceImpl.queryAllUserInfo();
        for(UserInfo userInfo:allUsers){
            System.out.println(userInfo);
        }

    }


    @Test
  //冻结用户
   public void freezeUser() throws Exception {
        System.out.println(userServiceImpl.freezeUser(2));
   }


   @Test
   //解冻用户
   public void testUnFreezeUser() throws Exception {
       System.out.println(userServiceImpl.unfreezeUser(2));
   }

   //删除用户
   @Test
   public void deleteUser() throws Exception {
       System.out.println(userServiceImpl.deleteUser(6));
   }

   //申请开店
    @Test
    public void reigstMerchant() throws Exception {
        System.out.println(userServiceImpl.reigstMerchant(2));
    }
    //修改账号信息
    @Test
    public void reviseAccount() throws Exception {
        UserInfo userInfo=new UserInfo();
        userInfo.setPassword("1234567");
        userInfo.setUsername("a");
        userInfo.setNikeName("qqqqqqqqqqq");
        userInfo.setImageLogo("static/images/grayBg.jpg");
        userInfo.setName("asdasd");
        userInfo.setPhone("12312312");
        userInfo.setAddr("beijing");
        userInfo.setId(2);
        System.out.println(userServiceImpl.reviseUserInfo(2,userInfo ));
    }

    @Test
    public void queryUserInfobyPage(){
        List<UserInfo> userInfos=userServiceImpl.queryUserByPage(6,1);
        for(UserInfo u:userInfos){
            System.out.println(u);
        }
    }
    //计算用户数
    @Test
    public void countUserNum(){
        System.out.println(userServiceImpl.countUserNum());
    }

}
