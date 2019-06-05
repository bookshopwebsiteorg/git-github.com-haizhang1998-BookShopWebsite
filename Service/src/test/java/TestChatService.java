import com.bookShop.mapper.ChatMapper;
import com.bookShop.service.ChatService;
import com.haizhang.entity.Friend;
import com.haizhang.entity.TempMsg;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@Transactional()
@TransactionConfiguration(transactionManager = "transactionManager",defaultRollback = true)
@ContextConfiguration("classpath:spring-aop.xml")

public class TestChatService {

    @Resource
    ChatService chatService;
    //查询离线记录
    @Test
    public void getTempMsg(){
        System.out.println(chatService.getTempMsg(5,1));
    }
    //清空指定朋友的所有离线记录
    @Test
    public  void clearTempMsg( ){
        System.out.println(chatService.clearTempMsg(1,5));

    }
    //插入离线记录
    @Test
    public  void addTempMsg(){
        TempMsg tempMsg = new TempMsg();
        tempMsg.setDate(new Date());
        tempMsg.setFriendId(3);
        tempMsg.setUserId(1);
        tempMsg.setTempMsg("test");
        chatService.addTempMsg(tempMsg);
    }

    //添加好友
    @Test
    public  void addFriend(){
        chatService.addFriend(1,6);
    }

    //删除指定好友
    @Test
    public void deleteFriend(){
        chatService.deleteFriend(1,6);
    }

    //查询所有朋友
    @Test
    public void queryAllFriends(){

       List<Friend> list=chatService.queryAllFriends(5);
       for(Friend f: list){
           System.err.println(f.getFriendInfo().getId());
           for(int i=0;i<f.getTempMsg().size();i++){
               System.err.println(f.getTempMsg().get(i).getTempMsg());
           }
       }
    }

    @Test
    public void queryMsgNumber(){
        System.out.println(chatService.queryMsgNumber(3));
    }

    @Test
    public void queryExistFriend(){
        System.out.println(chatService.queryExistFriend(1,5));
    }

    @Test
    public void queryFriendById(){
        System.out.println(chatService.queryFriendById(1,5));
    }
}
