package com.bookShop.service;

import com.haizhang.entity.MerchantShop;

import java.util.List;

public interface MerchantShopService {
    //实现店铺名模糊查询
   public List<MerchantShop> getShopByName(String shopName);
}
