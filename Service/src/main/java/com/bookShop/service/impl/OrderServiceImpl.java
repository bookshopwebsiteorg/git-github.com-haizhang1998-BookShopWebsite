package com.bookShop.service.impl;

import com.bookShop.mapper.OrderMapper;
import com.bookShop.service.OrderService;
import com.haizhang.entity.Order;
import com.haizhang.entity.OrderDetail;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigInteger;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: JJ
 * Date: 2019/5/29
 * Time: 23:50
 * Description: No Description
 */
@Service
public class OrderServiceImpl implements OrderService {

    @Resource
    OrderMapper orderMapper;

    @Override
    public Order queryAllUserOrderDetail(long order_id) {

        return orderMapper.queryAllUserOrderDetail(order_id);
    }

    @Override
    public List<OrderDetail> queryOrerDetailByOrderId(long order_id) {
        return orderMapper.queryOrerDetailByOrderId(order_id);
    }

    @Override
    public boolean changeBuyerRate(long orderId) {
        return orderMapper.changeBuyerRate(orderId);
    }

    @Override
    public List<String> queryGoodIdHaveNotRateByOrderId(long orderId) {
        return orderMapper.queryGoodIdHaveNotRateByOrderId(orderId);
    }

    @Override
    public long queryOrderIdByGoodsId(int goodsId) {
        return orderMapper.queryOrderIdByGoodsId(goodsId);
    }

    @Override
    public OrderDetail queryOrderDetailByGoodsId(int goodsId) {
        return orderMapper.queryOrderDetailByGoodsId(goodsId);
    }

    //修改用户订单状态
    public boolean modifyUserOrderStatus(long orderId,int status){
        return  orderMapper.modifyUserOrderStatus(orderId,status);
    }
}
