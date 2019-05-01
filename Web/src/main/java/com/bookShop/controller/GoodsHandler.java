package com.bookShop.controller;

import com.bookShop.service.GoodService;
import com.bookShop.service.MerchantService;
import com.bookShop.service.SaledGoodsService;
import com.haizhang.entity.GoodsInfo;
import com.haizhang.entity.MerchantShop;
import com.haizhang.entity.SaledInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/goods")
public class GoodsHandler {
    @Resource
    GoodService goodServiceImpl;
    @Resource
    SaledGoodsService saledGoodsServiceImpl;
    @Resource
    MerchantService merchantServiceImpl;


    public GoodsHandler(){}
    public GoodsHandler(GoodService goodService){
    }
    public GoodsHandler(SaledGoodsService saledGoodsService){
    }


    @ModelAttribute
    public void queryBookInfo(HttpServletRequest request, Model model){
        String path[]={"homepage","enshrine"};
        for(int i=0,len=path.length;i<len;i++){
        if(request.getServletPath().contains(path[i])) {
                //获取新上架的列表
                List<GoodsInfo> newGoodsList = goodServiceImpl.getAllNewGood();
                //获取hotGoods的列表
                List<SaledInfo> hotGoodsList = saledGoodsServiceImpl.getHotGoods();
                //获取好书
                List<GoodsInfo> excellentGoodsList = goodServiceImpl.queryExcellentBook();
                //获取销量前10的店铺
                List<MerchantShop> merchantShopsList = merchantServiceImpl.getRankShop(10);
                //获取销量
                List<GoodsInfo> booksCatagory = goodServiceImpl.queryBookByEachType();

                model.addAttribute("newGoodsList", newGoodsList);
                model.addAttribute("hotGoodsList", hotGoodsList);
                model.addAttribute("excellentGoodsList", excellentGoodsList);
                model.addAttribute("merchantShopsList", merchantShopsList);
                model.addAttribute("booksCatagory", booksCatagory);
            }
        }
    }

    /**
     * 登录成功后会跳转到首页，这里处理绑定数据
     * @return
     */
    @RequestMapping("/homepage")
    public String getHomePage(){
            //返回homePage
        return "homePage";
    }


    @RequestMapping("/enshrine/{goodsId}")
    public String enshrine(@PathVariable int goodsId,Model model){
        model.addAttribute("enshrine_state","收藏成功"+goodsId);
        return "homePage";
    }

    @RequestMapping("/buy/{goodsId}")
    public String purchaseGoods(@PathVariable int goodsId,Model model){
        System.err.println("buy:"+goodsId);
        return "homePage";
    }

    @RequestMapping("/searchGoods/{goodsId}")
    public String searchGoods(@PathVariable int goodsId,Model model){
        System.err.println("search:"+goodsId);
        return "homePage";
    }



}