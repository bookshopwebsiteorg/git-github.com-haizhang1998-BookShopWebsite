package com.bookShop.controller;
import com.bookShop.service.*;
import com.haizhang.entity.CommentItem;
import com.haizhang.entity.GoodsInfo;
import com.haizhang.entity.MerchantShop;
import com.haizhang.entity.SaledInfo;
import com.haizhang.entity.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Date;
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
    FootPrintService footPrintServiceImpl;
    @Resource
    MerchantShopService merchantShopServiceImpl;



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

    /**
     *购买书籍打开书本的详细界面
     * @param goodsId
     * @param model
     * @return
     */
    @RequestMapping(value = "/buy/{goodsId}",method = RequestMethod.GET)
    public String GoodsDetailForm(@PathVariable int goodsId,Model model, Date time, HttpSession session){
        //根据goodsId和goodsName寻找指定书本
        GoodsInfo goodsInfo=new GoodsInfo();
        goodsInfo.setGoodsId(goodsId);
        goodsInfo=goodServiceImpl.queryGoodsByGoodsInfo(goodsInfo);
        model.addAttribute("goodsInfo",  goodsInfo);
        //寻找该书本的全部评价列表
        List<CommentItem> commentItemLists=commentServiceImpl.getAllCommentOfGood(goodsId);
        model.addAttribute("commentLists",commentItemLists);
        //获取该书本的销量情况
        SaledInfo saledInfo=saledGoodsServiceImpl.getSaledNumberById(goodsId);
        model.addAttribute("saledInfo",saledInfo);

        //添加足迹
        UserInfo userInfo=(UserInfo) session.getAttribute("userInfo");
        System.out.println("用户"+userInfo);
        System.out.println("商品"+goodsInfo);
        //boolean addFootPrint=footPrintServiceImpl.addFootPrint(goodsId,userInfo.getId(),goodsInfo.getGoodsName(),goodsInfo.getImgDir(),time);
        boolean addFootPrint=footPrintServiceImpl.addFootPrint(goodsId,userInfo.getId(),goodsInfo.getGoodsName(),goodsInfo.getImgDir(),new Date((new java.util.Date().getTime())));
        model.addAttribute("addFootPrint",addFootPrint);

        //转到商品详细界面
        return "goodsInterface";
    }

    /**
     *
     * @param
     * @param model
     * @return
     */
    @RequestMapping(value ="/searchGoods/{goodsName}",method = RequestMethod.GET)
    public String searchGoods(@PathVariable String goodsName, Model model){
        System.out.println("search:"+goodsName);
        return "homePage";
    }

    /**
     * 获取所有足迹
     * @param model
     * @param session
     * @return
     */
    @RequestMapping(value = {"/myfootprint"})
    public String myFootPrint(Model model, HttpSession session){
        UserInfo userInfo=(UserInfo) session.getAttribute("userInfo");
        System.out.println(userInfo);
        Map<String,List<FootPrintItem>> allFootPrint=footPrintServiceImpl.getAllFootPrint(userInfo.getId());
        model.addAttribute("allFootPrint",allFootPrint);
        return "myFootPrint";
    }

    /**
     * 删除足迹
     * @param goodsId
     * @param model
     * @param session
     * @return
     */
    @RequestMapping("/delFootPrint/{goodsId}")
    public String delFootPrint(@PathVariable int goodsId, Model model, HttpSession session) {
        UserInfo userInfo = (UserInfo) session.getAttribute("userInfo");
        System.out.println("用户"+userInfo);
        GoodsInfo goodsInfo = new GoodsInfo();
        goodsInfo.setGoodsId(goodsId);
        boolean delFootPrint = footPrintServiceImpl.delFootPrint(userInfo.getId(), goodsId);
        if (delFootPrint == true) {
            Map<String,List<FootPrintItem>>allFootPrint = footPrintServiceImpl.getAllFootPrint(userInfo.getId());
            model.addAttribute("allFootPrint", allFootPrint);
        }
        return "myFootPrint";
    }

    /**
     * 模糊查询商家/货物
     * @param request
     * @param model
     * @param session
     * @return
     */
    @RequestMapping(value="/searchGoods",method = RequestMethod.POST)
    public String searchGoods(HttpServletRequest request,Model model,HttpSession session){
        String search=request.getParameter("searchgoods");
        System.out.println(search);
        //模糊查询货物
        List<GoodsInfo> goodsInfo=goodServiceImpl.queryGoodsInVague(search);
        model.addAttribute("goodsInfo",goodsInfo);
        //模糊查询商家
        List<MerchantShop> merchantShop=merchantShopServiceImpl.getShopByName(search);
        model.addAttribute("merchantShop",merchantShop);
        return "searchGoods";
    }
}
