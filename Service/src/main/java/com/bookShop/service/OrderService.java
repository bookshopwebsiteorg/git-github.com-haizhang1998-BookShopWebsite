package com.bookShop.service;

import com.haizhang.DTO.OrderDTO;
import com.haizhang.DTO.OrderDetailDTO;
import com.haizhang.entity.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author Austin
 * @date 2019/5/4
 */
public interface OrderService {

    /****************************用户********************************/
    //查询用户订单
    public List<Order> queryAllUserOrderByUserId(int userId);

    //查询用户订单详情
    public Order queryAllUserOrderDetail(long orderId);

    //根据订单状态查询用户订单
    public List<Order> queryUserOrderByStatus(int userId,int status);

    //删除用户订单
    public boolean deleteUserOrder(long orderId);

    //修改用户订单状态
    public boolean modifyUserOrderStatus(long orderId,int status);

    //修改用户退款/退货状态
    public boolean modifyUserOrderBybackpay(long orderId,int status);

    //创建订单
    public boolean createOrder(OrderDTO orderDTO, List<OrderDetailDTO> orderDetailDTOList);

    //付款方式
    public boolean updatePaymentType(@Param("orderId") long orderId,@Param("paymentType") int paymentType);


    //查询最新提交等待付款的订单
    public Order TheNewOrderBypay();

    /********************************商家********************************************/

    //查询商家订单
    public List<Order> queryAllManagerOrderByUserId(int merchantId);

    //根据订单状态查询用户订单
    public List<Order> queryManagerOrderByStatus(int merchantId,int status);

    //更新付款时间
    public boolean updatePaymentTime(long orderId);

    //更新发货时间
    public boolean updateConsignTime(long orderId);

    //更新交易完成时间
    public boolean updateEndTime(long orderId);

    //更新交易关闭时间
    public boolean updateCloseTime(long orderId);

    //更新评价时间
    public boolean updateCommentTime(long orderId);





    /********************************************************************************/

    /*JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ*/

    //根据orderId查询取到没有被评论的商品goodsId
    public List<String> queryGoodIdHaveNotRateByOrderId(long orderId);

    //根据goodsId查询取到该orderId  problem?
    public long queryOrderIdByGoodsId(int goodsId);

    //通过goodsId查询货物，返回orderDetail
    public OrderDetail queryOrderDetailByGoodsId(int goodsId,long orderId);


}
