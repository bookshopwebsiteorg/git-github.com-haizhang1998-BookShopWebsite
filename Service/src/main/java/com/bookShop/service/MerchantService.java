package com.bookShop.service;

import com.haizhang.entity.MerchantShop;

import java.util.List;

public interface MerchantService {
    //注册商家
    public boolean regMerchant(int userId, String addr, String shopLogo, String shopName);
    //得到商铺信息
    public List<MerchantShop> getShopInfoByName(String ShopName) ;
    //得到商铺信息by userId
    public MerchantShop getShopInfoByMerchantId(int userId);
    //得到所有的商铺
    public List<MerchantShop> getAllShop();


    //发货
    public boolean sendGood(int goodsId, int userId, int merchantId, int payFlag);

    //查询所有订单
    //public List<OrderItem> getAllUserOrder(int merchantId);

    //查询热销量前x的店铺
    public List<MerchantShop>getRankShop(int number);

    //更新店铺信息
    public boolean updateShopInfo(MerchantShop merchantShop);

}
