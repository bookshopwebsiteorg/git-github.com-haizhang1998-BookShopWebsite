package com.bookShop.service.impl;

import com.bookShop.mapper.MerchantShopMapper;
import com.bookShop.service.MerchantShopService;
import com.haizhang.entity.MerchantShop;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class MerchantShopServiceImpl implements MerchantShopService {
    @Resource
    MerchantShopMapper merchantShopMapper;

    @Override
  public List<MerchantShop> getShopByName(String shopName){
        return merchantShopMapper.getShopByName(shopName);
    }
}
