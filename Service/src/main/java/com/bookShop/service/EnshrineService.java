package com.bookShop.service;

import com.haizhang.entitiyList.EnshrineList;
import com.haizhang.entity.EnshrineItem;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface EnshrineService {
    //获取收藏夹所有货物
    public List<EnshrineItem> getAllEnshrineGood(int userId);

    //删除收藏夹的指定商品
    public boolean removeEnshrineGood(int userId, int goodsId);

    //添加收藏夹的商品
    public boolean addEnshrineGood(int userId, int goodsId);

    //修改收藏商品的Valid状态 （下架货物时直接为1，不许传参数，状态不可逆）
    public boolean updateValidStatus( int goodsId);

    /**
     *修改商品的降价状态
     * @return
     */
    public boolean updatePriceFlagStatus(double newPrice,double oldPrice,int goodsId);

    //通过货物的id，将该货物的价钱和名称更新进表
    public boolean addupdateNameAndPriceById(int goodsId);

    //通过goodsId和userId查询重复收藏
    public int queryIsHaveId(int goodsId,int userId);



    }
