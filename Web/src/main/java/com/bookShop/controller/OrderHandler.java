package com.bookShop.controller;

import com.bookShop.service.GoodService;
import com.bookShop.service.OrderService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.haizhang.DTO.OrderDTO;
import com.haizhang.DTO.OrderDetailDTO;
import com.haizhang.entity.*;
import com.sun.org.apache.bcel.internal.generic.NEW;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Austin
 * @date 2019/5/6
 */

@Controller
@RequestMapping("/order")
public class OrderHandler {
    @Resource
    GoodService goodServiceImpl;
    @Resource
    OrderService orderServiceImpl;


    /**
     * 进入订单界面
     * @param
     * @return
     */
    @RequestMapping(value = "/test",method = RequestMethod.GET)
    public String test(HttpSession session) {
        UserInfo userInfo=(UserInfo) session.getAttribute("userInfo");
        OrderDTO orderDTO = new OrderDTO();
        orderDTO.setActualPay(20);
        orderDTO.setPaymentType(1);
        orderDTO.setPostFee(10);
        orderDTO.setBuyerMessage("hahha");
        orderDTO.setReceiver("austin");
        orderDTO.setReceiverAddress("吉林" );
        orderDTO.setReceiverMobile("13726278887");
        orderDTO.setReceiverZip("123456");
        orderDTO.setUserId(userInfo.getId());

        List<OrderDetailDTO> orderDetailDTOList = new ArrayList<>();

        OrderDetailDTO orderDetailDTO1 = new OrderDetailDTO();
        orderDetailDTO1.setNum(2);
        orderDetailDTO1.setGoodsId(3);
        orderDetailDTOList.add(orderDetailDTO1);

        OrderDetailDTO orderDetailDTO2 = new OrderDetailDTO();
        orderDetailDTO2.setNum(1);
        orderDetailDTO2.setGoodsId(4);
        orderDetailDTOList.add(orderDetailDTO2);

        OrderDetailDTO orderDetailDTO3 = new OrderDetailDTO();
        orderDetailDTO3.setNum(1);
        orderDetailDTO3.setGoodsId(2);
        orderDetailDTOList.add(orderDetailDTO3);

        boolean flag = orderServiceImpl.createOrder(orderDTO,orderDetailDTOList);
        System.out.println(flag);
        return "homePage";
    }



    @RequestMapping("/queryAllUserOrderByUserId")
    public String queryAllUserOrderByUserId(Model model, HttpSession session) {
        UserInfo userInfo=(UserInfo) session.getAttribute("userInfo");
        //PageHelper.startPage(1,2);
        List<Order> list = orderServiceImpl.queryAllUserOrderByUserId(userInfo.getId());
        //PageInfo<Order> page = new PageInfo<>(list);
        model.addAttribute("list",list);
        return "userOrderManage";
    }

    @RequestMapping("/queryAllUserOrderDetail/{orderId}")
    public String queryAllUserOrderDetail(@PathVariable long orderId,Model model, HttpSession session) {
        UserInfo userInfo=(UserInfo) session.getAttribute("userInfo");
        //PageHelper.startPage(1,2);
        Order order = orderServiceImpl.queryAllUserOrderDetail(orderId);
        //PageInfo<Order> page = new PageInfo<>(list);
        System.out.println(order.toString());
        System.out.println(order.getOrderStatus().toString());
        for(OrderDetail o:order.getOrderDetails()){
            System.out.println(o.toString());
        }
        model.addAttribute("order",order);
        return "orderDetail";
    }

    @RequestMapping(value = "/queryUserOrderByStatus/{url}/{status}",method = RequestMethod.GET)
    public String queryUserOrderByStatus(@PathVariable int status,@PathVariable String url,Model model, HttpSession session) {
        UserInfo userInfo=(UserInfo) session.getAttribute("userInfo");
        List<Order> list = orderServiceImpl.queryUserOrderByStatus(userInfo.getId(),status);
        //PageHelper.startPage(1,2);
        //PageInfo<Order> page = new PageInfo<>(list);
        if(status == 2){
            List<Order> list2 = orderServiceImpl.queryUserOrderByStatus(userInfo.getId(),7);
            for(Order order:list2){
                list.add(order);
            }
        }
        model.addAttribute("list",list);
        return url;
    }

    @RequestMapping(value = "/deleteUserOrder/{orderId}",method = RequestMethod.GET)
    public String deleteUserOrder(@PathVariable long orderId,Model model,HttpSession session){
        UserInfo userInfo=(UserInfo) session.getAttribute("userInfo");
        boolean flag = orderServiceImpl.deleteUserOrder(orderId);
        String url = queryAllUserOrderByUserId(model,session);
        return url;
    }

    @RequestMapping(value = "/modifyUserOrderStatus/{url}/{status}/{orderId}",method = RequestMethod.GET)
    public String modifyUserOrderStatus(@PathVariable long orderId,@PathVariable int status,@PathVariable String url,Model model, HttpSession session){
        UserInfo userInfo=(UserInfo) session.getAttribute("userInfo");
        boolean flag = orderServiceImpl.modifyUserOrderStatus(orderId,status);
        if(url.equals("userOrderManage")){
            queryAllUserOrderByUserId(model,session);
        }else{
            queryUserOrderByStatus(status,url,model,session);
        }
        return url;
    }


    @RequestMapping(value = "/modifyUserOrderBybackpay/{url}/{status}/{backpay}/{orderId}",method = RequestMethod.GET)
    public String modifyUserOrderBybackpay(@PathVariable int status,@PathVariable long orderId,@PathVariable int backpay,@PathVariable String url,Model model, HttpSession session){
        UserInfo userInfo=(UserInfo) session.getAttribute("userInfo");
        boolean flag = orderServiceImpl.modifyUserOrderBybackpay(orderId,backpay);

        if(backpay == 3 || backpay == 8){
            boolean flag2 = orderServiceImpl.modifyUserOrderStatus(orderId,5);
        }
        if(url.equals("userOrderManage")){
            queryAllUserOrderByUserId(model,session);
        }else{
            queryUserOrderByStatus(status,url,model,session);
        }
        return url;
    }

    @RequestMapping("/queryAllUserOrderDetail")
    public String queryAllUserOrderDetail(Model model, HttpSession session) {
        UserInfo userInfo=(UserInfo) session.getAttribute("userInfo");
        //PageHelper.startPage(1,2);
        List<Order> list = orderServiceImpl.queryAllUserOrderByUserId(userInfo.getId());
        //PageInfo<Order> page = new PageInfo<>(list);
        model.addAttribute("list",list);
        return "userOrderManage";
    }



    /*************************************商家****************************************************/
    @RequestMapping("/queryAllManagerOrderByUserId")
    public String queryAllManagerOrderByUserId(Model model, HttpSession session) {
        UserInfo userInfo=(UserInfo) session.getAttribute("userInfo");
        //PageHelper.startPage(1,2);
        List<Order> list = orderServiceImpl.queryAllManagerOrderByUserId(userInfo.getId());
        //PageInfo<Order> page = new PageInfo<>(list);
        model.addAttribute("list",list);
        return "ManagerOrderManage";
    }

    @RequestMapping(value = "/queryManagerOrderByStatus/{url}/{status}",method = RequestMethod.GET)
    public String queryManagerOrderByStatus(@PathVariable int status,@PathVariable String url,Model model, HttpSession session) {
        UserInfo userInfo=(UserInfo) session.getAttribute("userInfo");
        List<Order> list = orderServiceImpl.queryManagerOrderByStatus(userInfo.getId(),status);
        //PageHelper.startPage(1,2);
        //PageInfo<Order> page = new PageInfo<>(list);
        if(status == 2){
            List<Order> list2 = orderServiceImpl.queryManagerOrderByStatus(userInfo.getId(),7);
            for(Order order:list2){
                list.add(order);
            }
        }
        model.addAttribute("list",list);
        return url;
    }

    @RequestMapping(value = "/modifyManagerOrderStatus/{url}/{status}/{orderId}",method = RequestMethod.GET)
    public String modifyManagerOrderStatus(@PathVariable long orderId,@PathVariable int status,@PathVariable String url,Model model, HttpSession session){
        UserInfo userInfo=(UserInfo) session.getAttribute("userInfo");
        boolean flag = orderServiceImpl.modifyUserOrderStatus(orderId,status);
        if(url.equals("ManagerOrderManage")){
            queryAllManagerOrderByUserId(model,session);
        }else{
            queryManagerOrderByStatus(status,url,model,session);
        }
        return url;
    }


    @RequestMapping(value = "/modifyManagerOrderBybackpay/{url}/{status}/{backpay}/{orderId}",method = RequestMethod.GET)
    public String modifyManagerOrderBybackpay(@PathVariable int status,@PathVariable long orderId,@PathVariable int backpay,@PathVariable String url,Model model, HttpSession session){
        UserInfo userInfo=(UserInfo) session.getAttribute("userInfo");
        boolean flag = orderServiceImpl.modifyUserOrderBybackpay(orderId,backpay);
        if(backpay == 3 || backpay == 8){
            boolean flag2 = orderServiceImpl.modifyUserOrderStatus(orderId,5);
        }
        if(url.equals("ManagerOrderManage")){
            queryAllManagerOrderByUserId(model,session);
        }else{
            queryManagerOrderByStatus(status,url,model,session);
        }
        return url;
    }


    @RequestMapping(value = "/deleteManagerOrder/{orderId}",method = RequestMethod.GET)
    public String deleteManagerOrder(@PathVariable long orderId,Model model,HttpSession session){
        UserInfo userInfo=(UserInfo) session.getAttribute("userInfo");
        boolean flag = orderServiceImpl.deleteUserOrder(orderId);
        String url = queryAllManagerOrderByUserId(model,session);
        return url;
    }


}
