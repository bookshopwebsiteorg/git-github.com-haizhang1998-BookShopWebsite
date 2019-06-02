package com.bookShop.service.impl;

import com.bookShop.mapper.EnshrineMapper;
import com.bookShop.mapper.GoodsMapper;
import com.bookShop.service.EnshrineService;
import com.haizhang.entity.EnshrineItem;
import com.haizhang.entity.GoodsInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class EnshrineServiceImpl implements EnshrineService {
    @Resource
    EnshrineMapper enshrineMapper;
    @Resource
    GoodsMapper goodsMapper;

    @Override
    public List<EnshrineItem> getAllEnshrineGood(int userId){
       /* EnshrineList enshrineList=new EnshrineList();
        List<EnshrineItem>deacreaseList=new ArrayList<>();
        List<EnshrineItem> enshrineItemList=enshrineMapper.getAllEnshrineGood(userId);
        for(EnshrineItem enshrineItem: enshrineItemList){
            if(enshrineItem.getValidFlag()==1){

            }
        }*/





        return enshrineMapper.getAllEnshrineGood(userId);
    }

    @Override
    public boolean removeEnshrineGood(int userId, int goodsId) {

        return enshrineMapper.removeEnshrineGood(userId, goodsId);
    }

    @Override
    public boolean addEnshrineGood(int userId, int goodsId) {

        /*
        if(enshrineMapper.addEnshrineGood(userId, goodsId)==true){
            //enshrineMapper.addEnshrineGood(userId, goodsId);

            GoodsInfo goodsInfo = new GoodsInfo();
            goodsInfo = goodsMapper.queryGoodsById(goodsId);
            double price = goodsInfo.getPrice();
            String name = goodsInfo.getGoodsName();
            enshrineMapper.addupdateNameAndPriceById(goodsId, price, name);
            return true;
        }else{
            return false;
        }*/

        return enshrineMapper.addEnshrineGood(userId,goodsId);
    }

    @Override
    public boolean updateValidStatus(int goodsId) {
        return enshrineMapper.updateValidStatus(goodsId);
    }



    @Override
    public boolean updatePriceFlagStatus(double newPrice,double oldPrice,int goodsId) {
        EnshrineItem enshrineItem=new EnshrineItem();
        double changePrice=newPrice-oldPrice;
        int updatePriceFlag=(changePrice>0?1:(changePrice<0?-1:0));
        enshrineItem.setChangePrice(Math.abs(changePrice));
        enshrineItem.setGoodsId(goodsId);
        enshrineItem.setUpdatePriceFlag(updatePriceFlag);
        System.err.println(updatePriceFlag);
        return enshrineMapper.updatePriceFlagStatus(enshrineItem);
    }

    /**
     * 根据goodsId更新商品名称和单价
     * @param goodsId
     * @return
     */
    @Override
    public boolean addupdateNameAndPriceById(int goodsId) {
        GoodsInfo goodsInfo = new GoodsInfo();
        goodsInfo = goodsMapper.queryGoodsById(goodsId);
        double gprice = goodsInfo.getPrice();
        String gname = goodsInfo.getGoodsName();
        return enshrineMapper.addupdateNameAndPriceById(goodsId, gprice, gname);
    }

    /**
     * 查询是否重复收藏
     * @param goodsId
     * @param userId
     * @return int (0位没收藏)(非0为已收藏)
     */
    @Override
    public int queryIsHaveId(int goodsId, int userId) {
        return enshrineMapper.queryIsHaveId(goodsId,userId);
    }
}
