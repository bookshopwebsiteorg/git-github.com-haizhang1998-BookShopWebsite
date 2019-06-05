package com.bookShop.webSocketConfig;

import com.bookShop.service.ChatService;
import com.bookShop.service.UserService;
import com.bookShop.service.impl.ChatServiceImpl;
import com.google.gson.Gson;
import com.haizhang.entity.Friend;
import com.haizhang.entity.Message;
import com.haizhang.entity.TempMsg;
import com.haizhang.entity.UserInfo;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.*;
import org.springframework.web.util.HtmlUtils;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.*;

/**
 * webSocket 处理器
 */
public class ChatWebSocketHandler implements WebSocketHandler {
    Logger logger = Logger.getLogger(ChatWebSocketHandler.class);
    private Gson gsonUtils=new Gson();
    //在线用户的SocketSession 存储了所有的通信通道
    private static final Map<Integer,WebSocketSession> USER_SOCKETSESSION_MAP;
    private static final Map<Integer,List<Friend>>friendMap;
    @Resource
    ChatService chatService;
    @Resource
    UserService userService;
    //存储所有的在线用户
    static{
        USER_SOCKETSESSION_MAP=new HashMap<>();
        friendMap=new HashMap<>();
    }

    /**
     * webSocket建立好连接后的处理函数 ,连接建立否的准备工作
     * @param session
     * @throws Exception
     */
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        logger.info("invoke:afterConnectionEstablished");
          //获取当前用户的信息
        UserInfo user = (UserInfo) session.getAttributes().get("userInfo");
        int userId=user.getId();
        String imageLogo=user.getImageLogo();
        USER_SOCKETSESSION_MAP.put(userId,session);
        Message msg =new Message();
        //当前在线的用户列表
        List<Friend> userOnlineList=new ArrayList<>();
        //当前用户的离线列表
        List<Friend> userDisOnlineList=new ArrayList<>();
        //上线信息
        msg.setMsgType(1);
        //设置你自己的id
        msg.setFrom(userId);
        //设置昵称
        msg.setFromName(user.getNikeName());
        //设置自己的头像
        msg.setTransportImageLogo(imageLogo);
        //发送并添加在线列表
        handleAddFriendOrInitFriendList(session,userOnlineList,userDisOnlineList,msg);
    }

    /**
     * 处理增加用户和更新用户列表初始化用户列表的操作
     * @param session
     * @param userOnlineList
     * @param userDisOnlineList
     * @param msg
     * @throws IOException
     */
    private void handleAddFriendOrInitFriendList(WebSocketSession session,List<Friend>userOnlineList
    ,List<Friend>userDisOnlineList,Message msg) throws IOException {
        System.err.println(msg);
       //得到用户id
        UserInfo userInfo=(UserInfo)session.getAttributes().get("userInfo");
        int userId=userInfo.getId();
        //查询当前用户所有的好友
        List<Friend> friendList=chatService.queryAllFriends(userId);
        //设置返回给客户端类型,更新用户表
        friendMap.put(userId,friendList);
        //更新自己的用户列表，不用发给其他人你上线了
        if(msg.getMsgType()==3)
        {
            //得到好友的信息
            UserInfo friendInfo=userService.queryUserInfoById(msg.getTo());

            //拿出你添加的那个朋有webSocketSession 如果它存在的话
            if(USER_SOCKETSESSION_MAP.containsKey(msg.getTo())){
                //我们就直接拿到它的webSocketSession给他发信息，让他更新在线列表
                msg.setMsgType(4);
                //添加我的id和昵称给对方
                msg.setFromName(userInfo.getNikeName());
                msg.setFrom(userId);
                msg.setTransportImageLogo(userInfo.getImageLogo());
                //更新friendMap
                friendMap.put(friendInfo.getId(),chatService.queryAllFriends(friendInfo.getId()));
                //告诉它有人添加了你，要求他更新列表
                USER_SOCKETSESSION_MAP.get(msg.getTo()).sendMessage(new TextMessage(gsonUtils.toJson(msg)));
                //同时通知我更新放在在线列表
                 msg.setMsgType(6);
                 msg.setFrom(friendInfo.getId());
                 msg.setFromName(friendInfo.getNikeName());
                 msg.setTransportImageLogo(friendInfo.getImageLogo());
                 session.sendMessage(new TextMessage(gsonUtils.toJson(msg)));

            }else{
                System.err.println("好友不在线！"+friendInfo);
                //添加的好友离线，只用更新自己的
                msg.setMsgType(5);
                msg.setFrom(friendInfo.getId());
                msg.setFromName(friendInfo.getNikeName());
                msg.setTransportImageLogo(friendInfo.getImageLogo());
                session.sendMessage(new TextMessage(gsonUtils.toJson(msg)));
            }

        }
        //否则是初始化列表的操作,通知其他人做更新
        else{
            for(Friend friend:friendList) {
                //如果朋友在线，则拔这个上线消息给朋友,并添加进在线列表
                if (USER_SOCKETSESSION_MAP.get(friend.getFriendInfo().getId()) != null){
                    //单发
                    sendMessageToUser(friend.getFriendInfo().getId(),new TextMessage(gsonUtils.toJson(msg)));
                    userOnlineList.add(friend);

            }
                else
                    userDisOnlineList.add(friend);
            }
            //设置给自己更新添加好友后的列表
            msg.setMsgType(2);
            msg.setUserOnlineList(userOnlineList);
            msg.setUserDisOnlineList(userDisOnlineList);
            session.sendMessage(new TextMessage(gsonUtils.toJson(msg)));
        }
    }


    /**
     * 客户端发送消息到服务器时的处理函数，收到消息后可做分发消息处理
     * 客户端通过WebSocket API 发送的消息会经过这里，进行相应处理
     * @param session
     * @param message
     * @throws Exception
     */
    @Override
    public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {

        //如果消息没有任何内容，则直接返回
        if(message.getPayloadLength() == 0)return;
          //反序列化服务端接受到的json数据
        Message msg= gsonUtils.fromJson(message.getPayload().toString(),Message.class);
        //判断是否为添加用户的msg 类型为3
        if(msg.getMsgType()==3){
            //当前在线的用户列表
            List<Friend> userOnlineList=new ArrayList<>();
            //当前用户的离线列表
            List<Friend> userDisOnlineList=new ArrayList<>();
            handleAddFriendOrInitFriendList(session,userOnlineList,userDisOnlineList,msg);
        }else{
            msg.setDate(new Date());
            //处理html的字符，转义
            String text = msg.getText();
            //转译为HTML转义字符表示
            String htmlEscapeText = HtmlUtils.htmlEscape(text);
            msg.setText(htmlEscapeText);
            //标志为普通信息
            msg.setMsgType(0);

            //判断是群发还是单发
            if(msg.getTo() == -1){
                //群发
                sendMessageToAll(new TextMessage(gsonUtils.toJson(msg)));
            }
            else{
                //单发 判断用户是否在线
                if(!USER_SOCKETSESSION_MAP.containsKey(msg.getTo())){
                    TempMsg tempMsg =new TempMsg();
                    tempMsg.setTempMsg(msg.getText());
                    tempMsg.setDate(new Date());
                    tempMsg.setFriendId(msg.getTo());
                    tempMsg.setUserId(msg.getFrom());
                    chatService.addTempMsg(tempMsg);

                }else

                sendMessageToUser(msg.getTo(),new TextMessage(gsonUtils.toJson(msg)));

            }
        }
    }

    /**
     * 处理异常，断开连接并通知
     * @param session
     * @param exception
     * @throws Exception
     */
    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
        System.out.println("WebSocket异常断开"+session.getId()+"已关闭");
        //一旦有异常，强制用户下线
        if(session.isOpen()){
            session.close();
        }
        //发消息告诉大家
        Message msg=new Message();
        msg.setDate(new Date());
        //获取用户id
        UserInfo user= (UserInfo) session.getAttributes().get("userInfo");
        //-1代表下线
        msg.setMsgType(-1);
        //设置你自己的id
        msg.setFrom(user.getId());
        //设置自己的头像
        msg.setTransportImageLogo(user.getImageLogo());
        //设置昵称
        msg.setFromName(user.getNikeName());
        //通知所有在线的用户，告诉他们你下线
        for(Friend friend:friendMap.get(user.getId())){
            if(USER_SOCKETSESSION_MAP.containsKey(friend.getFriendInfo().getId())){
                sendMessageToUser(friend.getFriendInfo().getId(),new TextMessage(gsonUtils.toJson(msg)));
            }
        }
        //清楚该用户的在线列表
        USER_SOCKETSESSION_MAP.remove(user.getId());
        friendMap.remove(user.getId());
    }

    /**
     * 当session对话结束或关闭时调用的方法
     * @param session
     * @param closeStatus
     * @throws Exception
     */
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus closeStatus) throws Exception {
        logger.info("正常断开"+session.getId()+"已关闭");
        //一旦有异常，强制用户下线
        if(session.isOpen()){
            session.close();
        }
        //发消息告诉大家
        Message msg=new Message();
        msg.setDate(new Date());
        //获取用户id
        UserInfo user= (UserInfo) session.getAttributes().get("userInfo");
        //-1代表下线
        msg.setMsgType(-1);
        //设置你自己的id
        msg.setFrom(user.getId());
        //设置自己的头像
        msg.setTransportImageLogo(user.getImageLogo());
        //设置昵称
        msg.setFromName(user.getNikeName());
        //通知所有在线的用户，告诉他们你下线
        for(Friend friend:friendMap.get(user.getId())){
            if(USER_SOCKETSESSION_MAP.containsKey(friend.getFriendInfo().getId())){
                sendMessageToUser(friend.getFriendInfo().getId(),new TextMessage(gsonUtils.toJson(msg)));
            }
        }
        //清楚该用户的在线列表
        USER_SOCKETSESSION_MAP.remove(user.getId());
        friendMap.remove(user.getId());
    }

    /**
     * 拆分消息，消息过于长会将其决定拆分成一段段的
     * 如果为true。那么会多次调用handleMessage方法拆分长文本
     * @return
     */
    @Override
    public boolean supportsPartialMessages() {
        return false;
    }

    /**
     * 单发
     * @param id 指定的用户
     * @param textMessage 发送消息的内容
     * @throws IOException
     */
    private void sendMessageToUser(Integer id, TextMessage textMessage) throws IOException {
        //获取要接受消息的用户
        WebSocketSession webSocketSession=USER_SOCKETSESSION_MAP.get(id);

        if(webSocketSession!=null&&webSocketSession.isOpen()){
            webSocketSession.sendMessage(textMessage);
        }
    }

    /**
     * 群发功能
     * @param message
     */
    private void sendMessageToAll(final TextMessage message){
        //获取到所有在线用户的SocketSession对象（一个浏览器对应一个）
        Set<Map.Entry<Integer, WebSocketSession>> entrySet=USER_SOCKETSESSION_MAP.entrySet();
        for(Map.Entry<Integer, WebSocketSession>entry:entrySet){
            //获取用户的session
            final WebSocketSession webSocketSession=entry.getValue();
            //检查是否在线
            if(webSocketSession.isOpen()){
                //多线程推送消息(高效)
                new Thread(
                        new Runnable() {
                            @Override
                            public void run() {
                                try {
                                    webSocketSession.sendMessage(message);
                                } catch (IOException e) {
                                    e.printStackTrace();
                                }
                            }
                        }
                ).start();
            }

        }

    }
}
