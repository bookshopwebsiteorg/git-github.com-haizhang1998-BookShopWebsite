package com.bookShop.webSocketConfig;

import com.bookShop.service.ChatService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import javax.annotation.Resource;

/**
 * 说明：webSocket配置处理器
 * 把处理器和拦截器注册到spring websokcet中
 */
@EnableWebMvc
@Configuration
@EnableWebSocket
public class WebSocketConfig extends WebMvcConfigurerAdapter implements WebSocketConfigurer {
    //注册处理器
//    @Autowired
//    private ChatWebSocketHandler chatWebSocketHandler;
//    //拦截器 可以在握手时做过滤
//    @Autowired
//    private ChatHandshakeInterceptor chatHandshakeInterceptor;
    @Resource
    private ChatService chatService;


    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        System.err.println("chatService is null "+ chatService);
        //添加一个处理器和定义一个处理器的路径
        //参数一：WebSocket处理器(用来处理消息)
        //参数二：websocket访问地址： ws//上下文/ws
        registry.addHandler(chatWebSocketHandler(), "/ws").addInterceptors(new ChatHandshakeInterceptor()).setAllowedOrigins("*");
        /**
         * 在这里我们用到.withSockeJS(),SockJS是spring用来处理浏览器对webSocket的兼容性
         * SockJS 根据浏览器是否支持websocket提供三种websocket的请求
         * WebSocket,Http Streaming,Http Long Polling
         */
        registry.addHandler(chatWebSocketHandler(), "/ws/sockjs").addInterceptors(new ChatHandshakeInterceptor()).withSockJS();
    }

    @Bean
    public ChatWebSocketHandler chatWebSocketHandler(){
        return new ChatWebSocketHandler();
    }

}
