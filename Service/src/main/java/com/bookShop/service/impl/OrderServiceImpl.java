package com.bookShop.service.impl;

import com.bookShop.mapper.OrderMapper;
import com.bookShop.service.OrderService;
import com.bookShop.utils.IdWorker;
import com.haizhang.DTO.OrderDTO;
import com.haizhang.DTO.OrderDetailDTO;
import com.haizhang.entity.*;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * @author Austin
 * @date 2019/5/4
 */

@Service
public class OrderServiceImpl implements OrderService {

    @Resource
    OrderMapper OrderMapper;
    //@Autowired
    //private IdWorker idWorker;


    /****************************** 用户*****************************/
    public List<Order> queryAllUserOrderByUserId(int userId){
        return OrderMapper.queryAllUserOrderByUserId(userId);
    }

    //根据订单状态查询用户订单
    public List<Order> queryUserOrderByStatus(int userId,int status){
        return OrderMapper.queryUserOrderByStatus(userId,status);
    }

    //查询用户订单详情
    public Order queryAllUserOrderDetail(long orderId){
        return OrderMapper.queryAllUserOrderDetail(orderId);
    }


    //删除用户订单
    public boolean deleteUserOrder(long orderId){
        return OrderMapper.deleteUserOrder(orderId);
    }

    //修改用户订单状态
    public boolean modifyUserOrderStatus(long orderId,int status){
        if(status==2){
            OrderMapper.updatePaymentTime(new Date(),orderId);
        }
        else if(status==3){
            OrderMapper.updateConsignTime(new Date(),orderId);
        }
        else if(status==4){
            OrderMapper.updateEndTime(new Date(),orderId);
        }
        else if(status==5){
            OrderMapper.updateCloseTime(new Date(),orderId);
        }
        else if(status==6){
            OrderMapper.updateCommentTime(new Date(),orderId);
        }
        return OrderMapper.modifyUserOrderStatus(orderId,status);
    }

    //修改用户退款/退货状态
    public boolean modifyUserOrderBybackpay(long orderId,int status){
        return OrderMapper.modifyUserOrderBybackpay(orderId,status);
    }

    //创建订单
    public boolean createOrder(OrderDTO orderDTO, List<OrderDetailDTO> orderDetailDTOList){
        boolean flag = false; //创建订单成功标记
        Order order = new Order();//创建订单
        IdWorker idWorker = new IdWorker();
        long orderId = idWorker.nextId();  //生成订单编号
        order.setOrderId(orderId);
        order.setPaymentType(orderDTO.getPaymentType());
        order.setActualPay(orderDTO.getActualPay());
        order.setPostFee(orderDTO.getPostFee());
        order.setBuyerMessage(orderDTO.getBuyerMessage());

        //用户信息
        order.setUserId(orderDTO.getUserId());

        //收货人信息
        order.setReceiver(orderDTO.getReceiver());
        order.setReceiverAddress(orderDTO.getReceiverAddress());
        order.setReceiverMobile(orderDTO.getReceiverMobile());
        order.setReceiverZip(orderDTO.getReceiverZip());
        System.out.println(order.toString());
        boolean flag1 = OrderMapper.insertOrder(order);

        //订单详情信息
        boolean flag2 = false;
        for(OrderDetailDTO orderDetailDTO:orderDetailDTOList){
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setOrderId(orderId);
            orderDetail.setGoodsId(orderDetailDTO.getGoodsId());
            orderDetail.setNum(orderDetailDTO.getNum());
            flag2 = OrderMapper.insertOrderDetail(orderDetail);
        }

        //订单状态信息
        OrderStatus orderStatus = new OrderStatus();
        orderStatus.setOrderId(orderId);
        orderStatus.setCreateTime(new Date());
        orderStatus.setStatus(1);
        boolean flag3 = OrderMapper.insertOrderStatus(orderStatus);
        System.out.println(flag3);


        if(flag1&&flag2&&flag3){
            flag=true;
        }
        return flag;
    }



    /*******************************商家***************************************/

    //查询商家订单
    public List<Order> queryAllManagerOrderByUserId(int merchantId){
        return OrderMapper.queryAllManagerOrderByUserId(merchantId);
    }

    //根据订单状态查询用户订单
    public List<Order> queryManagerOrderByStatus(int merchantId, int status){
        return OrderMapper.queryManagerOrderByStatus(merchantId,status);
    }

    //更新付款时间
    public boolean updatePaymentTime(long orderId){
        return OrderMapper.updatePaymentTime(new Date(),orderId);
    }

    //更新发货时间
    public boolean updateConsignTime(long orderId){
        return OrderMapper.updateConsignTime(new Date(),orderId);
    }

    //更新交易完成时间
    public boolean updateEndTime(long orderId){
        return OrderMapper.updateEndTime(new Date(),orderId);
    }

    //更新交易关闭时间
    public boolean updateCloseTime(long orderId){
        return OrderMapper.updateCloseTime(new Date(),orderId);
    }

    //更新评价时间
    public boolean updateCommentTime(long orderId){
        return OrderMapper.updateCommentTime(new Date(),orderId);
    }





    /************************************************************************/
    /*JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ*/

    @Override
    public List<String> queryGoodIdHaveNotRateByOrderId(long orderId) {
        return OrderMapper.queryGoodIdHaveNotRateByOrderId(orderId);
    }

    @Override
    public long queryOrderIdByGoodsId(int goodsId) {
        return OrderMapper.queryOrderIdByGoodsId(goodsId);
    }

    @Override
    public OrderDetail queryOrderDetailByGoodsId(int goodsId) {
        return OrderMapper.queryOrderDetailByGoodsId(goodsId);
    }
}
