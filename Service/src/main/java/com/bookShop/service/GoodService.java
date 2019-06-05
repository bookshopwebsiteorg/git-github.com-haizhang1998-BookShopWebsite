package com.bookShop.service;

import com.haizhang.entity.GoodsInfo;
import org.apache.ibatis.annotations.MapKey;
import org.apache.ibatis.annotations.Param;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface GoodService {
    //获取所有货物信息，HashMap，键值对===  货物编号====货物信息

    public HashMap<Integer, GoodsInfo> getAllGoods();

    //根据指定goodsId或者goodsName查询货物
    public GoodsInfo queryGoodsByGoodsInfo(GoodsInfo goodsInfo);

    //得到所有新上架的商品
    public List<GoodsInfo> getAllNewGood();

    //实现商品名、商品类型、地址的模糊查询
    public List<GoodsInfo>  queryGoodsInVague(String goodsName);
    //得到商铺所有商品
    public List<GoodsInfo> queryShopGoods(int merchantId);

    //得到好书推荐列表
    public List<GoodsInfo> queryExcellentBook();

    //获取每种书籍的3个样本
    public List<GoodsInfo> queryBookByEachType();

    //上架货物
    public boolean upGoods(GoodsInfo goodsInfo);

    //下架货物
    public boolean downGoods(int goodsId, int userId);


    //更新货物金额
    public boolean updateGoodsPrice( int goodsId,double price);


}
