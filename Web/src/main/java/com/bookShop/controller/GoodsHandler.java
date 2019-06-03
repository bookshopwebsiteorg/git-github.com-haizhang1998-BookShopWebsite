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
import java.util.ArrayList;
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
    @Resource
    EnshrineService enshrineServiceImpl;
    @Resource
    OrderService orderServiceImpl;
    @Resource
    UserService userServiceImpl;

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

    /**
     * 添加收藏
     * @param goodsId
     * @param id
     * @param model
     * @return
     */


    /**
     * 删除收藏
     * @param session
     * @param goodsId
     * @param model
     * @return
     */
    @RequestMapping("/deleteEnshrineGoods/{goodsId}")
    public String deleteEnshrineGoods(HttpSession session,@PathVariable int goodsId ,Model model){
        UserInfo userInfo = (UserInfo) session.getAttribute("userInfo");
        int userId=userInfo.getId();
        enshrineServiceImpl.removeEnshrineGood(userId,goodsId);

        List<EnshrineItem> enshrineItemList=enshrineServiceImpl.getAllEnshrineGood(userId);
        model.addAttribute("enshrineItemList",enshrineItemList);
        model.addAttribute("enshrine_state", "删除收藏成功");
        return "enshrineInterface";
    }


    /**
     * （我的收藏夹点击事件）查询收藏，获取所有收藏货物
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


    /**
     * 点击评价订单
     * @param session
     * @param order_id
     * @param model
     * @return
     */
    @RequestMapping("/makeComment/{order_id}")
    public String makeComment(HttpSession session,@PathVariable String order_id,Model model){
        UserInfo userInfo = (UserInfo) session.getAttribute("userInfo");
        int userId=userInfo.getId();


        long orderIdLong=new Long(order_id);
        Order order=orderServiceImpl.queryAllUserOrderDetail(orderIdLong);

        //orderServiceImpl.queryGoodIdHaveNotRateByOrderId(orderIdLong);

        /*List<Integer> goodsIdList=new ArrayList<>();
        for (int i=0;i<order.getOrderDetails().size();i++){
            int goodsId = order.getOrderDetails().get(i).getGoodsId();
            goodsIdList.add(goodsId);
            //System.out.println(goodsId);
        }
        //System.out.println(goodsIdList.get(0));
        //System.out.println(goodsIdList.get(1));
        model.addAttribute("goodsIdList",goodsIdList);*/

        model.addAttribute("order",order);
        return "comment";
    }


    @RequestMapping(value="/addComment/{remark}&{grade}&{goodsId}")
    public String addComment(HttpSession session,@PathVariable String remark, @PathVariable String grade,@PathVariable String goodsId,Model model){
        UserInfo userInfo = (UserInfo) session.getAttribute("userInfo");
        int userId=userInfo.getId();
        long orderId=orderServiceImpl.queryOrderIdByGoodsId(Integer.parseInt(goodsId));
        GoodsInfo goodsInfo=new GoodsInfo();
        goodsInfo.setGoodsId(Integer.parseInt(goodsId));
        CommentItem item=new CommentItem();
        item.setImageLogo(goodServiceImpl.queryGoodsByGoodsInfo(goodsInfo).getImgDir());
        item.setNikeName(userServiceImpl.queryUserInfoById(userId).getNikeName());
        item.setTime(new Date());
        item.setId(userId);
        item.setGoodsId(Integer.parseInt(goodsId));
        item.setCommentDetail(remark);
        item.setScore(Integer.parseInt(grade));
        item.setOrderId(orderId);
        commentServiceImpl.sendCommentItem(item);
        model.addAttribute("state","提交成功");

        //一个订单中没有评价的goodsId
        List<String> goodsIdNoRateList=orderServiceImpl.queryGoodIdHaveNotRateByOrderId(orderServiceImpl.queryOrderIdByGoodsId(Integer.parseInt(goodsId)));

        if(goodsIdNoRateList.size()==0){
            orderServiceImpl.modifyUserOrderStatus(orderId,6);
            return "aaa";    //订单全部商品评论完跳转的页面
        }else{
            List<OrderDetail> orderDetails=new ArrayList<>();
            for(int i=0;i<goodsIdNoRateList.size();i++)
            {
                orderDetails.add(orderServiceImpl.queryOrderDetailByGoodsId(Integer.parseInt(goodsIdNoRateList.get(i))));
            }
            model.addAttribute("orderDetails",orderDetails);
            return "commentContinue";
        }
        //System.out.println(remark+"+"+grade+"+"+goodsId);
    }

}
