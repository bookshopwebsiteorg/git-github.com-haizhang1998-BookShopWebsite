package com.bookShop.mapper;

import com.haizhang.entitiyList.PersonalCart;
import com.haizhang.entity.*;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.jdbc.SQL;

import java.util.Date;
import java.sql.SQLException;
import java.util.List;

/**
 * @author Austin
 * @date 2019/5/18
 */
public interface OrderMapper {

    /************************************用户**************************************/
    //根据用户id查询用户订单
    public List<Order> queryAllUserOrderByUserId(@Param("userId") int userId);

    //根据订单id查询用户订单详情
    public Order queryAllUserOrderDetail(@Param("orderId") long orderId);

    //根据订单状态status查询用户订单
    public List<Order> queryUserOrderByStatus(@Param("userId") int userId,@Param("status") int status);

    //根据订单id删除用户订单
    public boolean deleteUserOrder(@Param("orderId") long orderId);

    //修改用户订单状态status
    public boolean modifyUserOrderStatus(@Param("orderId") long orderId,@Param("status") int status);

    //修改用户退款/退货状态
    public boolean modifyUserOrderBybackpay(@Param("orderId") long orderId,@Param("backpay") int backpay);

    //创建订单
    public boolean insertOrder(Order order);

    //插入订单详情
    public boolean insertOrderDetail(OrderDetail orderDetail);

    //插入订单状态
    public boolean insertOrderStatus(OrderStatus orderStatus);

    //付款方式
    public boolean updatePaymentType(@Param("orderId") long orderId,@Param("paymentType") int paymentType);

    //查询最新提交等待付款的订单
    public Order TheNewOrderBypay();


    /************************************商家********************************************/

    //根据用户id查询商家订单
    public List<Order> queryAllManagerOrderByUserId(@Param("merchantId") int merchantId);

    //根据订单状态查询用户订单
    public List<Order> queryManagerOrderByStatus(@Param("merchantId") int merchantId,@Param("status") int status);

    //更新付款时间
    public boolean updatePaymentTime(@Param("paymentTime") Date paymentTime,@Param("orderId") long orderId);

    //更新发货时间
    public boolean updateConsignTime(@Param("consignTime") Date consignTime,@Param("orderId") long orderId);

    //更新交易完成时间
    public boolean updateEndTime(@Param("endTime") Date endTime,@Param("orderId") long orderId);

    //更新交易关闭时间
    public boolean updateCloseTime(@Param("closeTime") Date closeTime,@Param("orderId") long orderId);

    //更新评价时间
    public boolean updateCommentTime(@Param("commentTime") Date commentTime,@Param("orderId") long orderId);




    /**************************************************************************************/

    /*JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ*/
    //根据orderId查询取到没有被评论的商品goodsId
    public List<String> queryGoodIdHaveNotRateByOrderId(@Param("orderId")long orderId);

    //根据goodsId查询取到该所属的orderId
    public long queryOrderIdByGoodsId(@Param("goodsId") int goodsId);

    //通过goodsId查询货物，返回orderDetail
    public OrderDetail queryOrderDetailByGoodsId(@Param("goodsId") int goodsId,@Param("orderId")long orderId);


}
