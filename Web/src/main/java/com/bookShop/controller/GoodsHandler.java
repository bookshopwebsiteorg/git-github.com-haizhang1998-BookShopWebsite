package com.bookShop.controller;

import com.bookShop.service.*;
import com.haizhang.entity.*;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
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
    @Resource
    CommentService commentServiceImpl;
    @Resource
    EnshrineService enshrineServiceImpl;


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


    @RequestMapping("/enshrine/{goodsId}&{id}")
    public String enshrine(@PathVariable int goodsId, @PathVariable int id, Model model){
        /*UserInfo userInfo = (UserInfo) session.getAttribute("userInfo");*/

        if(enshrineServiceImpl.queryIsHaveId(goodsId,id)==0) {
            enshrineServiceImpl.addEnshrineGood(id, goodsId);
            enshrineServiceImpl.addupdateNameAndPriceById(goodsId);
            model.addAttribute("enshrine_state", "收藏成功");
            //model.addAttribute("enshrine_state","收藏成功"+goodsId);
            return "homePage";
        }else {
            model.addAttribute("enshrine_state", "已经收藏过了");
            return "homePage";
        }

    }


    @RequestMapping("/deleteEnshrineGoods/{goodsId}")
    public String deleteEnshrineGoods(HttpSession session,@PathVariable int goodsId ,Model model){
        UserInfo userInfo = (UserInfo) session.getAttribute("userInfo");
        int userId=userInfo.getId();
        enshrineServiceImpl.removeEnshrineGood(userId,goodsId);

        List<EnshrineItem> enshrineItemList=enshrineServiceImpl.getAllEnshrineGood(userId);
        model.addAttribute("enshrineItemList",enshrineItemList);
        return "enshrineInterface";
    }


    /**
     * （我的收藏夹点击事件）获取所有收藏货物
     * @return
     */
    @RequestMapping("/queryAllEnshrineGoods")
    public String queryAllEnshrineGoods(HttpSession session, Model model){
        UserInfo userInfo = (UserInfo) session.getAttribute("userInfo");
        int userId=userInfo.getId();
        List<EnshrineItem> enshrineItemList=enshrineServiceImpl.getAllEnshrineGood(userId);
        model.addAttribute("enshrineItemList",enshrineItemList);
        return "enshrineInterface";
    }



    /*@RequestMapping("/isEnshrine")
    public boolean isEnshrine(@PathVariable int goodsId,HttpSession session, Model model){

        UserInfo userInfo = (UserInfo) session.getAttribute("userInfo");
        int userId=userInfo.getId();

        int num=enshrineServiceImpl.queryIsHaveId(goodsId,userId);
        if(num==0){
            return false;
        }else{
            return true;
        }

    }*/



    /**
     *购买书籍打开书本的详细界面
     * @param goodsId
     * @param model
     * @return
     */
    @RequestMapping(value = "/buy/{goodsId}",method = RequestMethod.GET)
    public String GoodsDetailForm(@PathVariable int goodsId,Model model){
        //根据goodsId和goodsName寻找指定书本
        GoodsInfo goodsInfo=new GoodsInfo();
        goodsInfo.setGoodsId(goodsId);
        model.addAttribute("goodsInfo",  goodServiceImpl.queryGoodsByGoodsInfo(goodsInfo));
        //寻找该书本的全部评价列表
        List<CommentItem> commentItemLists=commentServiceImpl.getAllCommentOfGood(goodsId);
        model.addAttribute("commentLists",commentItemLists);
        //获取该书本的销量情况
        SaledInfo saledInfo=saledGoodsServiceImpl.getSaledNumberById(goodsId);
        model.addAttribute("saledInfo",saledInfo);
        //转到商品详细界面
        return "goodsInterface";
    }

    /**
     *
     * @param goodsId
     * @param model
     * @return
     */
    @RequestMapping("/searchGoods/{goodsId}")
    public String searchGoods(@PathVariable int goodsId,Model model){
        System.err.println("search:"+goodsId);
        return "homePage";
    }

}
