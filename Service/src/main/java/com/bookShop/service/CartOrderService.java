package com.bookShop.service;

import com.haizhang.entitiyList.PersonalCart;
import com.haizhang.entity.CartItem;
import org.apache.ibatis.annotations.Param;

import java.sql.SQLException;
import java.util.List;

public interface CartOrderService {
    //添加商品到购物车
    public boolean addCart(@Param("goodsId") int goodsId, @Param("userId") int userId, @Param("imgDir") String imgDir, @Param("goodsName") String goodsName, @Param("price") double price, @Param("sumOfGoods") int sumOfGoods, @Param("totalPrice") double totalPrice);

    //删除商品
    public  boolean deleteGoods(@Param("goodsId") int goodsId, @Param("userId") int userId);

    //得到所有购物车中的商品信息(包括商品总量)
    public List<CartItem> getAllCart(@Param("userId") int userId);

    //更新商品的数量
    public boolean updateItemNumber(@Param("goodsId") int goodsId, @Param("userId") int userId, @Param("sumOfGoods") int sumOfGoods, @Param("totalPrice") double totalPrice);

    //获取根据商品id和用户id购物车项信息
    public CartItem queryCartItem(@Param("userId") int userId, @Param("goodsId") int goodsId);
}
