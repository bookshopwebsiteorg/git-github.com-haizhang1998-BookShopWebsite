package com.bookShop.webSocketConfig;

import com.haizhang.entity.UserInfo;
import org.apache.log4j.Logger;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Map;


public class ChatHandshakeInterceptor extends HttpSessionHandshakeInterceptor {
    Logger logger = Logger.getLogger(ChatHandshakeInterceptor.class);
    /**
     * 握手前 若返回false 则不廉洁
     * @param request
     * @param response
     * @param wsHandler
     * @param attributes websocket的session
     * @return
     * @throws Exception
     */
    @Override
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler, Map<String, Object> attributes) throws Exception {
        if(request instanceof ServletServerHttpRequest){
            HttpServletRequest servletServerHttpRequest = ((ServletServerHttpRequest) request).getServletRequest();
            HttpSession session = servletServerHttpRequest.getSession(false);
            //若用户已登录 ，允许聊天
            if(session.getAttribute("userInfo")!=null){
                //获取登录的用户
                UserInfo user = (UserInfo) session.getAttribute("userInfo");
                if(attributes.containsKey("userInfo"))return false;
                //将用户放入socket处理器的绘画(webSocketSession中)
                attributes.put("userInfo",user);
                logger.info("用户"+user+"已经连接");
            }else {
                //用户没登陆拒绝连接
                //握手失败
                logger.warn("连接失败，请检查是否连接");
                return false;
            }
        }
        logger.info("握手成功！开始连接");
        return true;
    }

    @Override
    public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler, Exception exception) {
       super.afterHandshake(request,response,wsHandler,exception);
    }
}
