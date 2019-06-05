package com.bookShop.mapper;
import com.haizhang.entity.GoodsInfo;
import org.apache.ibatis.annotations.MapKey;
import org.apache.ibatis.annotations.Param;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public interface GoodsMapper {
    //获取所有货物信息，HashMap，键值对===  货物编号====货物信息
    @MapKey("goodsId")
    public HashMap<Integer, GoodsInfo> getAllGoods();

    //根据指定的Id号得到指定货物的全部信息
    public GoodsInfo queryGoodsByGoodsInfo(GoodsInfo goodsInfo);

    //得到所有新上架的商品
    public List<GoodsInfo> getAllNewGood();

    //实现商品名的模糊查询(vague是模糊的意思)
    public List<GoodsInfo> queryGoodsInVague(@Param("goodsName") String goodsName);

     //得到商铺所有商品
    public List<GoodsInfo> queryShopGoods(@Param("merchantId") int merchantId);

    //得到好书推荐列表
    public List<GoodsInfo> queryExcellentBook();

    //得到每种类型的3个随机样本
    public List<GoodsInfo> queryGoodsByCategorySample();

    //获取货物靠id
    public GoodsInfo queryGoodsById(int id);

    //上架货物
    public boolean upGoods(GoodsInfo goodsInfo);

    //下架货物
    public boolean downGoods(@Param("goodsId") int goodsId,@Param("userId") int userId);

    //更新货物金额
    public boolean updateGoodsPrice(@Param("goodsId") int goodsId,@Param("price")double price);

}
