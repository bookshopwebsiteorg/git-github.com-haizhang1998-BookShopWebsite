package com.bookShop.mapper;
import com.haizhang.entity.EnshrineItem;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface EnshrineMapper {

    //获取收藏夹所有货物
    public List<EnshrineItem> getAllEnshrineGood(@Param("userId") int userId);

    //删除收藏夹的指定商品
    public boolean removeEnshrineGood(@Param("userId") int userId, @Param("goodsId") int goodsId);

    //添加商品进收藏夹
    //public boolean addEnshrineGood(int userId, int goodsId,int decreaseFlag,int validFlag);
    public boolean addEnshrineGood(@Param("userId") int userId, @Param("goodsId") int goodsId);

    //修改收藏商品的Valid状态 （下架货物时直接为1，不许传参数，状态不可逆）
    public boolean updateValidStatus(@Param("goodsId") int goodsId);

    /**
     *修改商品的降价状态
     * @param enshrineItem
     * @return
     */
    public boolean updatePriceFlagStatus(EnshrineItem enshrineItem);

    //通过货物的id，将该货物的价钱和名称更新进表
    public boolean addupdateNameAndPriceById(@Param("goodsId") int goodsId, @Param("price") double price, @Param("goodsName") String goodsName);

    //查询是否重复收藏
    public int queryIsHaveId(@Param("goodsId") int goodsId, @Param("userId") int userId);

    //根据用户id 全部删除收藏
    public boolean deleteAllEnshrine(@Param("userId")int userId);
}
