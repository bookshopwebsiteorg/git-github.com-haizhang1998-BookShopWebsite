package com.bookShop.mapper;
import com.haizhang.entitiyList.PersonalCart;
import com.haizhang.entity.CartItem;
import org.apache.ibatis.annotations.Param;

import java.sql.SQLException;
import java.util.List;

public interface CartOrderMapper {
    //购买货物
    public int buyGoods(@Param("cartItems") List<CartItem> cartItems);
    //添加商品到购物车
    public  boolean addCart(int userId, int goodsId, int selectNumber);
    //删除商品
    public  boolean deleteGoods(int userId, int goodsId);
    //得到所有购物车中的商品信息(包括商品总量)
    public PersonalCart getAllOrder(int userId) throws SQLException;
    //更新商品的数量
    public PersonalCart updateItemNumber(PersonalCart cart, int goodsId, int userId, int selectNumber);
    //用户查询订单状态；
    //public List<OrderItem> getAllSubmitOrders(int userId) throws SQLException;

    //用户添加订单；(当用户点击了付款后执行)
    //public boolean addUserOrders(PersonalCart cart, OrderItem orderItem) throws SQLException;

    //确认收货
    public boolean acceptGood(int userId, int goodsId, int payFlag);

    //得到该账户的所有订单
    //public List<OrderItem> getUserOrders(int userId) throws SQLException;

    }
