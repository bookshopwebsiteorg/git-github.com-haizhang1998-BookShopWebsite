package com.bookShop.service.impl;

import com.bookShop.exception.GoodsInfoInValidException;
import com.bookShop.exception.GoodsNotFoundException;
import com.bookShop.mapper.GoodsMapper;
import com.bookShop.service.GoodService;
import com.haizhang.entity.GoodsInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

@Service
public class GoodServiceImpl implements GoodService {

    @Resource
    GoodsMapper goodsMapper;

    /**
     * 查询所有货物
     * @return 返回 goodsId  ===>  GoodsInfo
     */
    @Override
    public HashMap<Integer, GoodsInfo> getAllGoods() {
        return goodsMapper.getAllGoods();
    }

    /**
     * 根据指定goodsId
     * 或者goodsName
     * 得到指定货物的全部信息
     * @param goodsInfo
     * @return
     */
    @Override
    public GoodsInfo queryGoodsByGoodsInfo(GoodsInfo goodsInfo)  {
       GoodsInfo goods=goodsMapper.queryGoodsByGoodsInfo(goodsInfo);
       if(goods==null)throw new GoodsNotFoundException("未找到指定货物");
       return goods;
    }

    @Override
    public List<GoodsInfo> getAllNewGood() {
        return goodsMapper.getAllNewGood();
    }

    //模糊查询货物
    @Override
    public List<GoodsInfo>  queryGoodsInVague(String goodsName) {
        return goodsMapper.queryGoodsInVague(goodsName);
    }


    /**
     * 得到商铺所有商品
     * @param merchantId 商家id即userId
     * @return 商家持有的商品列表
     */
    @Override
    public List<GoodsInfo> queryShopGoods(int merchantId) {
        return goodsMapper.queryShopGoods(merchantId);
    }

    /**
     * @return 得到好书推荐列表
     */
    @Override
    public List<GoodsInfo> queryExcellentBook() {
        return goodsMapper.queryExcellentBook();
    }

    @Override
    public List<GoodsInfo> queryBookByEachType() {
        Map<String, ArrayList<GoodsInfo>> bookCategory=new HashMap<>();
        GoodsInfo goodsInfo=new GoodsInfo();
        List<GoodsInfo>goodsInfos=goodsMapper.queryGoodsByCategorySample();
        return goodsInfos;

    }

    /**
     * 上架货物
     * @param goodsInfo 货物信息
     * @return
     */
    @Override
    public boolean upGoods(GoodsInfo goodsInfo) {
        //判断合理性
        if(goodsInfo.getPrice()<0||goodsInfo.getRemainNumber()<=0)
           throw new GoodsInfoInValidException("货物信息不合法！");
        //设置上架时间
        goodsInfo.setUpTime(new Date());
        return goodsMapper.upGoods(goodsInfo);
    }


    /**
     * 下架货物
     * @param goodsId 货物编号
     * @param userId 用户编号
     * @return
     */
    @Override
    public boolean downGoods(int goodsId, int userId) {
        return goodsMapper.downGoods(goodsId,userId);
    }

    /**
     * 更新货物价格
     * @param goodsId 货物编号
     * @param price 货物价格
     * @return
     */
    @Override
    public boolean updateGoodsPrice(int goodsId, double price) {
        if(price<0)throw new GoodsInfoInValidException("价格必须大于0！");
        return goodsMapper.updateGoodsPrice(goodsId,price);
    }

}
