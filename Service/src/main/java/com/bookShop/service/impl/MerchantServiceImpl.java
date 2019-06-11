package com.bookShop.service.impl;

import com.bookShop.mapper.MerchantMapper;
import com.bookShop.service.MerchantService;
import com.haizhang.entity.MerchantShop;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
@Service("merchantServiceImpl")
public class MerchantServiceImpl implements MerchantService {

    @Resource
    MerchantMapper merchantMapper;

    @Override
    public boolean regMerchant(int userId, String addr, String shopLogo, String shopName) {
        return false;
    }

    @Override
    public List<MerchantShop> getShopInfoByName(String ShopName) {
        return merchantMapper.getShopInfoByName(ShopName);
    }

    @Override
    public MerchantShop getShopInfoByMerchantId(int userId) {
        return merchantMapper.getShopInfoByMerchantId(userId);
    }

    @Override
    public List<MerchantShop> getAllShop() {
        return merchantMapper.getAllShop();
    }


    @Override
    public boolean sendGood(int goodsId, int userId, int merchantId, int payFlag) {
        return false;
    }



    /*public List<OrderItem> getAllUserOrder(int merchantId) {
        return null;
    }*/

    @Override
    public List<MerchantShop> getRankShop(int number) {
        return number<=0?null:merchantMapper.getRankShop(number);
    }

    @Override
    public boolean updateShopInfo(MerchantShop merchantShop) {
        return merchantMapper.updateShopInfo(merchantShop);
    }
}
