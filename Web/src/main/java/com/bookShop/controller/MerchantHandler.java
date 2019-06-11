package com.bookShop.controller;

import com.alibaba.druid.sql.visitor.functions.Bin;
import com.bookShop.mapper.GoodsMapper;
import com.bookShop.service.EnshrineService;
import com.bookShop.service.GoodService;
import com.bookShop.service.MerchantService;
import com.bookShop.service.SaledGoodsService;
import com.bookShop.utils.CommonUtil;
import com.haizhang.ValidateGroup.UpdatePriceGroup;
import com.haizhang.entity.GoodsInfo;
import com.haizhang.entity.MerchantShop;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/merchant")
public class MerchantHandler {
    @Resource
    GoodService goodService;
    @Resource
    MerchantService merchantService;
    @Resource
    EnshrineService enshrineService;
    @Resource
    SaledGoodsService saledGoodsService;

    public MerchantHandler(GoodService goodService) {
        this.goodService=goodService;
    }

    /**
     * 与卖家联系
     * @param merchantId
     * @return
     */
    @RequestMapping("/chat/{merchantId}")
    public String chatWithMerchant(@PathVariable int merchantId){
        System.out.println(merchantId);
        return "chatting";
    }

    /**
     * 进入商家店铺
     * @param merchantId
     * @return
     */
    @RequestMapping("/shop/{merchantId}")
    public String enterMerchantShop(@PathVariable int merchantId, Model model){
        //获取用户店铺的信息
        model.addAttribute("merchantShop",merchantService.getShopInfoByMerchantId(merchantId));
        return "MerchantShop";
    }

    /**
     * 获取店铺所有货物
     * @param merchantId
     * @return
     */
    @RequestMapping(value = "/queryAllGoods",produces ="application/json;charset=utf-8")
    @ResponseBody
    public List<GoodsInfo> queryAllGoodsInShop(int merchantId){
        //接受json数据
        List<GoodsInfo> goodsInfos= goodService.queryShopGoods(merchantId);
        return goodsInfos;
    }

    /**
     * 更新价格
     * @param goodsInfo
     * @return
     */
    @RequestMapping(value = "/updateGoodsPrice",produces ="application/json;charset=utf-8")
    @ResponseBody
    public String updateGoodsPrice(@RequestParam("oldPrice") double oldPrice,@Validated(UpdatePriceGroup.class) GoodsInfo goodsInfo, BindingResult bindingResult){
        if(bindingResult.hasErrors()){
            return  "{\"msg\":\""+bindingResult.getFieldError().getDefaultMessage()+"\"}";
        }

        boolean flag=goodService.updateGoodsPrice(goodsInfo.getGoodsId(),goodsInfo.getPrice());
        //更新收藏货物价格
        enshrineService.updatePriceFlagStatus(goodsInfo.getPrice(),oldPrice,goodsInfo.getGoodsId());
        return flag? "{\"msg\":\"更新成功\"}": "{\"msg\":\"更新失败,请重试！\"}";
    }


    /**
     * 跟新店铺信息
     * @param merchantShop
     * @param bindingResult
     * @return
     */
    @RequestMapping(value = "/updateShopInfo",produces ="application/json;charset=utf-8")
    @ResponseBody
    public Map<String,String> updateShopInfo(HttpServletRequest request, @RequestParam(value="picture",required = false) MultipartFile picture, @Valid MerchantShop merchantShop, BindingResult bindingResult) throws IOException {
        Map<String,String> data=new HashMap<String, String>();
        System.err.println(merchantShop);
        if(bindingResult.hasErrors()){
            for(FieldError error:bindingResult.getFieldErrors()){
                data.put(error.getField()+"Error",error.getDefaultMessage());
                System.err.println(error.getField()+"Error"+":"+error.getDefaultMessage());
            }
            return data;
          }

          boolean flag=false;
            try {
                if(!picture.isEmpty()){
                    //查询之前店铺图片地址，以便删除
                    merchantShop=CommonUtil.getInstance().updateShopImage(merchantShop,picture, merchantService.getShopInfoByMerchantId(merchantShop.getMerchantId()).getShopLogo());
                    merchantService.updateShopInfo(merchantShop);
                }
            }catch (NullPointerException exp){
            }
            //添加更新后的数据

            data.put("msg","更新成功！");
            data.put("shopName",merchantShop.getShopName());
            data.put("addr",merchantShop.getAddr());
            data.put("shopLogo",merchantShop.getShopLogo());
            return data;
    }


    /**
     * 下架货物
     * @param goodsInfo 货物信息
     * @return
     * @throws IOException
     */
    @RequestMapping(value ="/downGoods",produces ="application/json;charset=utf-8")
    @ResponseBody
    public String downGoods(GoodsInfo goodsInfo) throws IOException {
       //仓库下架货物
       boolean flag=goodService.downGoods(goodsInfo.getGoodsId(),goodsInfo.getPossesserId());
       //修改收藏列表
           enshrineService.updateValidStatus(goodsInfo.getGoodsId());

       return flag?"{\"msg\":\"下架成功!\"}":"{\"msg\":\"下架是失败!请检查是否该货物已被下架！\"}";
    }


    /**
     * 上架货物
     */
    @RequestMapping(value ="/upGoods",produces ="application/json;charset=utf-8")
    @ResponseBody
    public Map<String,String> upGoods(MultipartFile img, @Valid GoodsInfo goodsInfo, BindingResult bindingResult) throws IOException {
        Map<String,String> data=new HashMap<>();
        if(bindingResult.hasErrors()){
            for(FieldError error:bindingResult.getFieldErrors()){
                data.put(error.getField()+"Error",error.getDefaultMessage());
            }
            data.put("msg","上架失败！请检查你的上架货物信息！");
            return data;
        }

        GoodsInfo goodsInfo1=CommonUtil.getInstance().upGoodsImage(goodsInfo,img);
        boolean flag=goodService.upGoods(goodsInfo1);
        if(flag) {
            //初始化销售记录
            saledGoodsService.addSaledGoodsRecord(goodsInfo.getGoodsId(),goodsInfo.getPossesserId());
            data.put("msg","上架成功！");
        }
        else  data.put("msg","上传失败！请检查网络连接！");
        return data;
    }

}
