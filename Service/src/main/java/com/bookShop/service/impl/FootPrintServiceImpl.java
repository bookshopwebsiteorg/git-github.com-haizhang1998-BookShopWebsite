package com.bookShop.service.impl;
import com.bookShop.mapper.FootPrintMapper;
import com.bookShop.service.FootPrintService;
import com.haizhang.entity.FootPrintItem;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class FootPrintServiceImpl implements FootPrintService{
    @Resource
    FootPrintMapper footPrintMapper;

    @Override
    public Map<String,List<FootPrintItem>> getAllFootPrint(int userId){
        List<FootPrintItem> footPrintItems=footPrintMapper.getAllFootPrint(userId);
        Map<String,List<FootPrintItem>>treeMap=new TreeMap<>(new SortByTimeStr());
        SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
        //便利并获取item的时间
        for(FootPrintItem footPrintItem:footPrintItems){
              //将时间转为字符串
                String d=simpleDateFormat.format(footPrintItem.getTime());
                if(treeMap.containsKey(d)){
                    List<FootPrintItem> items=treeMap.get(d);
                    items.add(footPrintItem);
                    treeMap.put(d,items);
                }else{
                    List<FootPrintItem> items=new ArrayList<>();
                    items.add(footPrintItem);
                    treeMap.put(d,items);
                }

        }
       return treeMap;
    }

    //实现比较器
    private class SortByTimeStr implements Comparator<String> //使用泛型
    {
        @Override
        public int compare(String o1, String o2) {
            //将字符串格式的日期转为date对象
            SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
            Date date1=null;
            Date date2=null;
            try {
                date1=simpleDateFormat.parse(o1);
                date2=simpleDateFormat.parse(o2);
            } catch (ParseException e) {
                e.printStackTrace();
            }
            return date1.after(date2)?-1:(date1.before(date2)?1:0);
        }
    }


    @Override
    public boolean addFootPrint(int goodsId, int userId,String goodsName, String imgDir, Date time){
        return footPrintMapper.addFootPrint(goodsId,userId,goodsName,imgDir, time);
    }

    @Override
    public boolean delFootPrint(int userId,int goodsId){
        return footPrintMapper.delFootPrint(userId, goodsId);
    }

}
