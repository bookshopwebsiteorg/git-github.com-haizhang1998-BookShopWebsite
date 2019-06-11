package com.bookShop.mapper;
import com.haizhang.entity.FootPrintItem;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface FootPrintMapper {
    //得到所有足迹
    public List<FootPrintItem> getAllFootPrint(@Param("userId") int userId);
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
    public boolean addFootPrint(@Param("goodsId") int goodsId,@Param("userId") int userId,@Param("goodsName")String goodsName,@Param("imgDir")String imgDir, @Param("time") Date time);

    //删除足迹
    public boolean delFootPrint(@Param("userId") int userId,@Param("goodsId") int goodsId);

    //查询某一项浏览记录是否已存在
    public FootPrintItem queryFootPrint(@Param("userId")int userId,@Param("goodsId")int goodsId);

    //更新商品的浏览时间
    public boolean updateFootPrint(@Param("userId")int userId,@Param("goodsId")int goodsId,@Param("time") Date time);


}
