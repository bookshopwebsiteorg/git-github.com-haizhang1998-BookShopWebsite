package com.bookShop.controller;
import com.bookShop.service.*;
import com.haizhang.DTO.OrderDTO;
import com.haizhang.DTO.OrderDetailDTO;
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
import java.util.*;

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
    @Resource
    CartOrderService cartorderServiceImpl;

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


    /**
     * 删除收藏
     * @param session
     * @param goodsId
     * @param model
     * @return
     */
    @RequestMapping("/deleteEnshrineGoods/{goodsId}")
    public String deleteEnshrineGoods(HttpSession session,@PathVariable int goodsId ,Model model){

        System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
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



    /**
     * 提交评论
     * @param session
     * @param remark
     * @param grade
     * @param goodsId
     * @param model
     * @return
     */

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

            //return "aaa";    //订单全部商品评论完跳转的页面

            return "finishCommentPage";    //订单全部商品评论完跳转的页面

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


    /**
     * 添加物品至购物车
     *
     * @param goodsId
     * @param session
     * @param model
     * @return
     */
    @RequestMapping(value = "/AddCart/{goodsId}", method = RequestMethod.POST)
    public String AddCart(@PathVariable int goodsId, HttpSession session, Model model, HttpServletRequest request) {
        String num = request.getParameter("goodsNumber");
        int sumOfGoods = Integer.parseInt(num);
        CartItem cartItem = new CartItem();
        cartItem.setSumOfGoods(sumOfGoods);
        System.out.println(sumOfGoods);
        UserInfo userInfo = (UserInfo) session.getAttribute("userInfo");
        GoodsInfo goodsInfo = new GoodsInfo();
        goodsInfo.setGoodsId(goodsId);
        goodsInfo = goodServiceImpl.queryGoodsByGoodsInfo(goodsInfo);
        model.addAttribute("goodInfo", goodsInfo);
        System.out.println(goodsInfo);
        boolean addCart = cartorderServiceImpl.addCart(goodsId, userInfo.getId(), goodsInfo.getImgDir(), goodsInfo.getGoodsName(), goodsInfo.getPrice(), sumOfGoods, sumOfGoods * goodsInfo.getPrice());
        model.addAttribute("addCart", addCart);
        return "homePage";
    }

    /**
     * 删除物品
     *
     * @param goodsId
     * @param session
     * @param model
     * @return
     */
    @RequestMapping("/delCart/{goodsId}")
    public String DeleteGoods(@PathVariable int goodsId, HttpSession session, Model model) {
        UserInfo userInfo = (UserInfo) session.getAttribute("userInfo");
        System.out.println(userInfo);
        GoodsInfo goodsInfo = new GoodsInfo();
        goodsInfo.setGoodsId(goodsId);
        goodsInfo = goodServiceImpl.queryGoodsByGoodsInfo(goodsInfo);
        model.addAttribute("goodInfo", goodsInfo);
        System.out.println(goodsInfo);
        boolean deleteGoods = cartorderServiceImpl.deleteGoods(goodsId, userInfo.getId());
        if (deleteGoods == true) {
            List<CartItem> getAllOrder = cartorderServiceImpl.getAllCart(userInfo.getId());
            //    List <CartItem> getAllPrice=cartorderServiceImpl.getAllPrice(userInfo.getId());
            model.addAttribute("getAllOrder", getAllOrder);
            // model.addAttribute("getAllPrice",getAllPrice);
        }
        return "cart";
    }

    /**
     * 获取购物车信息
     *
     * @param session
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cart")//购物车页面
    public String GetAllOrder(HttpSession session, Model model) throws Exception {
        UserInfo userInfo = (UserInfo) session.getAttribute("userInfo");
        List<CartItem> getAllOrder = cartorderServiceImpl.getAllCart(userInfo.getId());
        // List<CartItem> getAllPrice=cartorderServiceImpl.getAllPrice(userInfo.getId());
        model.addAttribute("getAllOrder", getAllOrder);
        //  model.addAttribute("getAllPrice",getAllPrice);
        System.out.println(getAllOrder);
        // System.out.println(getAllPrice);
        return "cart";
    }

    /**
     * 更新商品数量(添加数量）
     *
     * @param goodsId
     * @param sumOfGoods
     * @param session
     * @param model
     * @return
     */
    @RequestMapping(value = "/UpdateAddCart/{goodsId}&{sumOfGoods}", method = RequestMethod.GET)
    public String updateAddItemNumber(@PathVariable int goodsId, @PathVariable int sumOfGoods, HttpSession session, Model model) {
        CartItem cartItem = new CartItem();
        cartItem.setSumOfGoods(sumOfGoods);
        model.addAttribute("cartItem", cartItem);
        System.out.println(cartItem);
        UserInfo userInfo = (UserInfo) session.getAttribute("userInfo");
        GoodsInfo goodsInfo = new GoodsInfo();
        goodsInfo.setGoodsId(goodsId);
        goodsInfo = goodServiceImpl.queryGoodsByGoodsInfo(goodsInfo);
        model.addAttribute("goodsInfo", goodsInfo);
        System.out.println(goodsInfo);
        boolean updateItemNumber = cartorderServiceImpl.updateItemNumber(goodsId, userInfo.getId(), cartItem.getSumOfGoods() + 1, goodsInfo.getPrice() * (cartItem.getSumOfGoods() + 1));
        model.addAttribute("updateItemNumber", updateItemNumber);
        if (updateItemNumber == true) {
            List<CartItem> getAllOrder = cartorderServiceImpl.getAllCart(userInfo.getId());
            //   List<CartItem> getAllPrice=cartorderServiceImpl.getAllPrice(userInfo.getId());
            model.addAttribute("getAllOrder", getAllOrder);
            // model.addAttribute("getAllPrice",getAllPrice);
        }
        return "cart";
    }

    /**
     * 更新商品数量(减少数量）
     *
     * @param goodsId
     * @param sumOfGoods
     * @param session
     * @param model
     * @return
     */
    @RequestMapping(value = "/UpdateDelCart/{goodsId}&{sumOfGoods}", method = RequestMethod.GET)
    public String updateDelItemNumber(@PathVariable int goodsId, @PathVariable int sumOfGoods, HttpSession session, Model model) {
        CartItem cartItem = new CartItem();
        cartItem.setSumOfGoods(sumOfGoods);
        model.addAttribute("cartItem", cartItem);
        System.out.println(cartItem);
        UserInfo userInfo = (UserInfo) session.getAttribute("userInfo");
        GoodsInfo goodsInfo = new GoodsInfo();
        goodsInfo.setGoodsId(goodsId);
        goodsInfo = goodServiceImpl.queryGoodsByGoodsInfo(goodsInfo);
        model.addAttribute("goodsInfo", goodsInfo);
        System.out.println(goodsInfo);
        boolean updateItemNumber = cartorderServiceImpl.updateItemNumber(goodsId, userInfo.getId(), cartItem.getSumOfGoods() - 1, goodsInfo.getPrice() * (cartItem.getSumOfGoods() - 1));
        model.addAttribute("updateItemNumber", updateItemNumber);
        if (updateItemNumber == true) {
            List<CartItem> getAllOrder = cartorderServiceImpl.getAllCart(userInfo.getId());
            model.addAttribute("getAllOrder", getAllOrder);
        }
        return "cart";
    }

    /**
     * 结算
     * @param session
     * @param model
     * @param request
     * @return
     */
    @RequestMapping(value = "/ConfirmCart", method = RequestMethod.POST)
    public String ConfirmCart ( HttpSession session, Model model, HttpServletRequest request) {
        String ids[] = request.getParameterValues("itemCheckBox");
        UserInfo userInfo = (UserInfo) session.getAttribute("userInfo");
        double allPrice=6;
        for(String i:ids){
            System.out.println(i);
        }

        List<OrderDetailDTO> orderlist = new ArrayList<>();
        for (int i = 0; i < ids.length; i++) {
            System.out.println("商品"+ids[i]);
            int goodsId=Integer.parseInt(ids[i]);

            CartItem cartItem=new CartItem();
            cartItem.setGoodsId(goodsId);
            cartItem=cartorderServiceImpl.queryCartItem(userInfo.getId(),goodsId);
            model.addAttribute("cartItem",cartItem);
            System.out.println(cartItem);
            OrderDetailDTO orderDetailDTO = new OrderDetailDTO();
            orderDetailDTO.setNum(cartItem.getSumOfGoods());
            orderDetailDTO.setGoodsId(goodsId);
            orderlist.add(orderDetailDTO);
            System.out.println(orderDetailDTO.toString());

            allPrice=allPrice+cartItem.getSumOfGoods()*cartItem.getPrice();
            model.addAttribute("allPrice",allPrice);
            System.out.println("总价"+allPrice);
        }
        model.addAttribute("userInfo",userInfo);
        System.out.println(userInfo);
        session.setAttribute("orderlist",orderlist);
        //model.addAttribute("orderlist",orderlist);
        return "pay";
    }

    @RequestMapping(value = "/commitOrder", method = RequestMethod.GET)
    public String ConfirmOrder(HttpSession session,Model model,HttpServletRequest request){
        UserInfo userInfo = (UserInfo) session.getAttribute("userInfo");
        String url = "commitOrder";
        String reciver=request.getParameter("name");//获取收件人姓名
        String reciverMobile=request.getParameter("phone");//收件人电话
        String reciverAddress=request.getParameter("addr");//收件人地址
        String reciverZip=request.getParameter("zip");//收件人邮政编码
        String remark=request.getParameter("remark");//备注
        String allPrice = request.getParameter("allPrice");
        double actualPay = Double.valueOf(allPrice);
        System.out.println(actualPay);
        List<OrderDetailDTO> orderlist = (List<OrderDetailDTO>) session.getAttribute("orderlist");
        for(OrderDetailDTO o:orderlist){
            System.out.println(o);
        }
        System.out.println(reciver+" "+reciverAddress+""+reciverMobile+" "+reciverZip+" "+remark);
        OrderDTO orderDTO = new OrderDTO();
        orderDTO.setUserId(userInfo.getId());
        orderDTO.setReceiver(reciver);
        orderDTO.setReceiverZip(reciverZip);
        orderDTO.setReceiverMobile(reciverMobile);
        orderDTO.setReceiverAddress(reciverAddress);
        orderDTO.setBuyerMessage(remark);
        orderDTO.setActualPay(actualPay);
        orderDTO.setPostFee(6);

        System.out.println(orderDTO.toString());
        boolean flag = orderServiceImpl.createOrder(orderDTO,orderlist);
        if(flag == false){
            model.addAttribute("state","订单提交失败");
            url = "cart";
            List<CartItem> getAllOrder = cartorderServiceImpl.getAllCart(userInfo.getId());
            model.addAttribute("getAllOrder", getAllOrder);
        }else {
            model.addAttribute("state","订单提交成功");
            Order order = orderServiceImpl.TheNewOrderBypay();
            Order order2 = orderServiceImpl.queryAllUserOrderDetail(order.getOrderId());
            model.addAttribute("order",order2);
        }
        return "commitOrder";
    }

}
