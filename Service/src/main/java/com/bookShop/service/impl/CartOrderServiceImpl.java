package com.bookShop.service.impl;

import com.bookShop.exception.GoodsInfoInValidException;
import com.bookShop.mapper.CartOrderMapper;
import com.bookShop.service.CartOrderService;
import com.haizhang.entity.CartItem;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class CartOrderServiceImpl implements CartOrderService {
    @Resource
    CartOrderMapper cartOrderMapper;

    //添加商品到购物车
    //public boolean addCart(@Param("goodsId")int goodsId, @Param("userId") int userId, @Param("imgDir")String imgDir, @Param("goodsName") String goodsName, @Param("price")double price, @Param("sumOfGoods")int sumOfGoods);
    //删除商品
    //public  boolean deleteGoods(@Param("goodsId")int goodsId,@Param("userId") int userId);
    //得到所有购物车中的商品信息(包括商品总量)
    //public List<CartItem> getAllCart(@Param("userId") int userId);
    //更新商品的数量
    //public boolean updateItemNumber(@Param("goodsId")int goodsId,@Param("userId") int userId,@Param("sumOfGoods")int sumOfGoods);



    @Override
    public  boolean addCart(int goodsId,int userId,String imgDir,String goodsName,double price,int sumOfGoods,double totalPrice){
        return cartOrderMapper.addCart(goodsId,userId,imgDir,goodsName,price,sumOfGoods,totalPrice);
    }

    @Override
    //删除商品
    public  boolean deleteGoods(int goodsId,int userId){
        return  cartOrderMapper.deleteGoods(goodsId,userId);
    }

    @Override
    //得到所有购物车中的商品信息(包括商品总量)
    public List<CartItem> getAllCart(int userId)
    {
        return cartOrderMapper.getAllCart(userId);
    }

    @Override
    //更新商品的数量
    public boolean updateItemNumber(int goodsId,int userId,int sumOfGoods,double totalPrice){
        if(sumOfGoods<0)throw new GoodsInfoInValidException("商品数量必须大于0！");
        return cartOrderMapper.updateItemNumber(goodsId,userId,sumOfGoods,totalPrice);
    }

    @Override
    //获取根据商品id和用户id购物车项信息
    public CartItem queryCartItem(int userId, int goodsId){
        return cartOrderMapper.queryCartItem(userId,goodsId);
    };
}
