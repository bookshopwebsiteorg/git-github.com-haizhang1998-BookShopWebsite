package com.bookShop.mapper;

import com.haizhang.entitiyList.PersonalCart;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.jdbc.SQL;
import com.haizhang.entity.Order;
import com.haizhang.entity.OrderDetail;
import com.haizhang.entity.OrderItem;
import com.haizhang.entity.OrderStatus;

import java.math.BigInteger;
import java.util.Date;
import java.sql.SQLException;
import java.util.List;

/**
 * @author Austin
 * @date 2019/5/18
 */
public interface OrderMapper {

    //madeByJJ
    //通过查询order_id查询有多少个OrderDetail(goodsId)，查询表为tb_order_detail
    public List<OrderDetail> queryOrerDetailByOrderId(@Param("order_id") long order_id);

    //查询用户订单详情
    public Order queryAllUserOrderDetail(@Param("orderId") long orderId);

    //修改是否评价状态
    public boolean changeBuyerRate(@Param("orderId")long orderId);

    //根据orderId查询取到没有被评论的商品goodsId
    public List<String> queryGoodIdHaveNotRateByOrderId(@Param("orderId")long orderId);

    //根据goodsId查询取到该所属的orderId
    public long queryOrderIdByGoodsId(@Param("goodsId") int goodsId);

    //通过goodsId查询货物，返回orderDetail
    public OrderDetail queryOrderDetailByGoodsId(@Param("goodsId") int goodsId);

    //修改用户订单状态
    public boolean modifyUserOrderStatus(@Param("orderId") long orderId,@Param("status") int status);
}
