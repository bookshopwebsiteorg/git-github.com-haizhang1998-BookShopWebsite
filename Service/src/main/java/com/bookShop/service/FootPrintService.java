package com.bookShop.service;

import com.haizhang.entity.FootPrintItem;

import java.util.Date;
import java.util.List;
import java.util.Map;

public interface FootPrintService {

    //得到所有足迹
    public Map<String,List<FootPrintItem>> getAllFootPrint(int userId);

    /**
     *
     * @param userId
     * @param goodsId
     * @param goodsName
     * @param imgDir
     * @param time 时间
     * @return 1代表足迹在同一时间内存在，2代表失败，0代表不存在且添加成功
     */
    //添加足迹
    public boolean addFootPrint( int goodsId,int userId, String goodsName, String imgDir, Date time);

    //删除足迹
    public boolean delFootPrint(int userId, int goodsId);
}
