package com.bookShop.service;

import com.haizhang.entity.Order;
import com.haizhang.entity.OrderDetail;
import org.apache.ibatis.annotations.Param;

import java.math.BigInteger;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: JJ
 * Date: 2019/5/29
 * Time: 23:50
 * Description: No Description
 */
public interface OrderService {


    //通过查询order_id查询有多少个OrderDetail(goodsId)，查询表为tb_order_detail
    public Order queryAllUserOrderDetail(long order_id);

    public List<OrderDetail> queryOrerDetailByOrderId(long order_id);

    //修改是否评价状态
    public boolean changeBuyerRate(long orderId);

    //根据orderId查询取到没有被评论的商品goodsId
    public List<String> queryGoodIdHaveNotRateByOrderId(long orderId);

    //根据goodsId查询取到该orderId
    public long queryOrderIdByGoodsId(int goodsId);

    //通过goodsId查询货物，返回orderDetail
    public OrderDetail queryOrderDetailByGoodsId(int goodsId);

    //修改用户订单状态
    public boolean modifyUserOrderStatus(long orderId,int status);

}
