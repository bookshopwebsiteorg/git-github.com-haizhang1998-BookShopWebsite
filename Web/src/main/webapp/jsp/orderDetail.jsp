<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=9; IE=8; IE=7; IE=EDGE">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
    <title>订单详情</title>

    <link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/js/bootstrap.min.js" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/webbase.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/pages-seckillOrder.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/userOrderManage.css"/>

    <style>
        .goodsItemLi{
            height: 120px;
            line-height: 120px;
        }
    </style>
</head>

<body>

<!--页面顶部白条条，由js动态加载-->
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<div class="nav-bottom"></div>
<script type="text/javascript">$(".nav-bottom").load("top.html");</script>


<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#service").hover(function(){
		$(".service").show();
	},function(){
		$(".service").hide();
	});
	$("#shopcar").hover(function(){
		$("#shopcarlist").show();
	},function(){
		$("#shopcarlist").hide();
	});

})
</script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.easing.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/sui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.placeholder.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/nav.js"></script>
</body>




<%--导航栏--%>
<section id="navbarSection">
    <nav id="nav-head" class="navbar navbar-inverse navbar-fixed-top">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>

            </div>

            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">

                    <li>
                        <c:choose>
                        <c:when test="${sessionScope.userInfo==null}">
                        <a href="/user/login">
                    <li >亲，请登录</li>
                    <span class="sr-only">(current)</span></a>
                    </c:when>
                    <c:otherwise>
                        <a href="/user/revise">
                            <li>欢迎，${sessionScope.userInfo.nikeName}</li>
                            <span class="sr-only">(current)</span></a>
                    </c:otherwise>
                    </c:choose>
                    </li>
                    <li><a href="#">消息<span class="badge">${sessionScope.tmpmsgNumber}</span></a></li>

                    <c:if test="${sessionScope.userInfo.merchantFlag==0}">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">商家管理<span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="/merchant/shop/${sessionScope.userInfo.id}">店铺管理</a></li>
                                <li><a href="/order/queryAllManagerOrderByUserId">货物管理</a></li>
                            </ul>
                        </li>
                    </c:if>

                    <c:if test="${sessionScope.requestRecordShop==null && sessionScope.userInfo.merchantFlag!=0}">
                        <li><a onclick="openShop()">我要开店</a></li>
                    </c:if>

                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">信息管理<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="/goods/queryAllEnshrineGoods">收藏夹</a></li>
                            <li><a href="#">反馈信息<span class="badge"></span> </a> </li>
                            <li><a href="/goods/myfootprint">我的足迹</a></li>
                            <li><a href="/order/queryAllUserOrderByUserId">我的订单</a></li>
                        </ul>
                    </li>
                </ul>

                <ul class="nav navbar-nav" style="margin-left: 500px">
                    <li><a href="#"><span>购物车<span class="badge" style="margin-left: 5px">0</span></span></a></li>
                    <li><a href="/user/revise">个人中心</a></li>
                    <li><a href="/user/logout">注销</a></li>
                </ul>
            </div>
        </div>
    </nav>
</section>


    <!--header-->
    <div id="account" style="margin-top: 60px">
        <div class="py-container">
            <div class="yui3-g home">
                <!--左侧列表-->
                <div class="yui3-u-1-6 list">

                    <div class="person-info">
                        <div class="person-photo"><img src="${pageContext.request.contextPath}/images/userLogo/photo.png" alt="" style="width:50px;height: 50px"></div>
                        <div class="person-account">
                            <span class="name">${userInfo.username}</span>
                            <span class="safe">账户安全</span>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                     <div class="list-items">
                        <dl>
							<dt><i>·</i> 订单中心</dt>
							<dd ><a href="/order/queryAllUserOrderByUserId">我的订单</a></dd>
							<dd><a href="/order/queryUserOrderByStatus/userOrderManagePay/1" >待付款</a></dd>
							<dd><a href="/order/queryUserOrderByStatus/userOrderManageSend/2" >待发货</a></dd>
							<dd><a href="/order/queryUserOrderByStatus/userOrderManageReceive/3" >待收货</a></dd>
							<dd><a href="/order/queryUserOrderByStatus/userOrderManageEvaluate/4" >待评价</a></dd>
						</dl>
						<dl>
							<dt><i>·</i> 我的中心</dt>
							<dd><a href="/goods/queryAllEnshrineGoods">我的收藏</a></dd>
							<dd><a href="/goods/myfootprint">我的足迹</a></dd>
						</dl>
						<dl>
							<dt><i>·</i> 设置</dt>
							<dd><a href="/user/revise">个人中心</a></dd>
						</dl>
                    </div>
                </div>
                <!--右侧主内容-->
                <div class="yui3-u-5-6">
                    <div class="body">
                        <div class="order-detail">
                            <h4>订单详情</h4>
                            <div class="order-state">
                                <p>当前订单状态：
                                    <span class="red">
                                        <c:choose>
                                            <c:when test="${order.orderStatus.status==1}">未付款</c:when>
                                            <c:when test="${order.orderStatus.status==2||order.orderStatus.status==7}">已付款</c:when>
                                            <c:when test="${order.orderStatus.status==3}">已发货</c:when>
                                            <c:when test="${order.orderStatus.status==4}">交易成功</c:when>
                                            <c:when test="${order.orderStatus.status==5}">交易取消</c:when>
                                            <c:when test="${order.orderStatus.status==6}">已评价</c:when>
                                        </c:choose>
                                    </span>
                                </p>
                            </div>
                        </div>
                        <div class="order-info">
                            <h5>订单信息</h5>
                            <p>订单编号：${order.receiverAddress}</p>
                            <p>创建时间：${order.orderStatus.createTime}</p>
                            <p>付款时间：${order.orderStatus.paymentTime}</p>
                            <p>发货时间：${order.orderStatus.consignTime}</p>
                            <c:choose>
                                <c:when test="${order.orderStatus.status==4}">
                                    <p>交易完成时间：${order.orderStatus.endTime}</p>
                                </c:when>
                                <c:when test="${order.orderStatus.status==5}">
                                    <p>交易关闭时间：${order.orderStatus.closeTime}</p>
                                </c:when>
                            </c:choose>
                            <c:choose>
                                <c:when test="${order.orderStatus.status!=5}">
                                    <p>评论时间：${order.orderStatus.commentTime}</p>
                                </c:when>
                            </c:choose>
                            <p>收货地址：${order.receiverAddress}</p>
                            <p>收货人姓名：${order.receiver}</p>
                            <p>收货人电话：${order.receiverMobile}</p>
                            <p>邮政编码：${order.receiverZip}</p>
                            <p>收货地址：${order.receiverAddress}</p>
                            <p>支付方式：
                                <c:choose>
                                    <c:when test="${order.paymentType==1}">微信支付</c:when>
                                    <c:when test="${order.paymentType==2}">支付宝支付</c:when>
                                    <c:when test="${order.paymentType==3}">银行卡支付</c:when>
                                    <c:when test="${order.paymentType==4}">货到付款</c:when>
                                </c:choose>
                            </p>
                            <p>买家留言：${order.buyerMessage}</p>
                        </div>

                        <div class="container">
                            <div class="row" style="margin-top: 20px">
                                <div class="container">
                                    <div class="row" style="height: 40px;line-height: 40px;<c:choose><c:when test="${order.orderStatus.status==5||order.orderStatus.status==6}">background-color: #cccccc;</c:when><c:otherwise>background-color: #a6e1ec;</c:otherwise></c:choose>;width: 933.33px">
                                        <div class="col-md-5 text-center">商品</div>
                                        <div class="col-md-2 text-right">价格</div>
                                        <div class="col-md-2 text-right">数量</div>
                                        <div class="col-md-2 text-right">状态</div>
                                    </div>
                                </div>
                                <c:forEach var="Item" items="${order.orderDetails}">
                                    <div class="container" >
                                        <div class="row" style="border: 1px solid black;width: 933.33px">
                                            <div class="col-md-2 goodsItemLi text-center"><img src="${Item.image}" style="height: 80px;width: 80px;margin-top: 18px"/></div>
                                            <div class="col-md-3 goodsItemLi text-center">${Item.goodsName}</div>
                                            <div class="col-md-2 goodsItemLi text-right" style="margin-left: 6px">¥${Item.price}</div>
                                            <div class="col-md-2 goodsItemLi text-right" style="margin-left:-10px">${Item.num}</div>
                                            <div class="col-md-2 goodsItemLi text-right" style="margin-left: 20px">
                                                <c:choose>
                                                    <c:when test="${order.orderStatus.status==1}">等待付款</c:when>
                                                    <c:when test="${order.orderStatus.status==2 || order.orderStatus.status==7}">买家已付款</c:when>
                                                    <c:when test="${order.orderStatus.status==3}">等待签收</c:when>
                                                    <c:when test="${order.orderStatus.status==4}">交易成功</c:when>
                                                    <c:when test="${order.orderStatus.status==5}">交易取消</c:when>
                                                    <c:when test="${order.orderStatus.status==6}">已评价</c:when>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                                <div class="container">
                                    <div class="row" style="background-color: #F1F1F1;width: 933.33px">
                                        <div class="order-price">
                                            <p>商品总金额：￥${order.actualPay-order.postFee}</p>
                                            <p>运费金额：￥${order.postFee}</p>
                                            <h4 class="red">实际支付：￥${order.actualPay}</h4>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>


                    </div>
                </div>
            </div>
        </div>
    </div>

<section id="FooterSection">
    <div class="page-header" style="background: black;color:white;padding-top: 1px">
        <h2 class="text-center" >友情提示</h2>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-md-2"></div>
            <div class="col-md-1 text-center">
                <h5 style="font-weight: bold">购物指南</h5>
                购物流程
                发票制度
                账户管理
                会员优惠
            </div>
            <div class="col-md-1 text-center">
                <h5 style="font-weight: bold"> 支付方式</h5>
                货到付款
                网上支付
                花呗支付
            </div>
            <div class="col-md-2 text-center">
                <h5 style="font-weight: bold"> 订单服务</h5>
                <h5>配送服务查询</h5>
                <h5> 订单状态说明</h5>
                <h5>自助取消订单</h5>
                <h5> 自助修改订单</h5>
            </div>
            <div class="col-md-1 text-center">
                <h5 style="font-weight: bold"> 配送方式</h5>
                <h5>当日递</h5>
                <h5> 次日递</h5>
                <h5>订单自提</h5>
                <h5>验货与签收</h5>
            </div>
            <div class="col-md-2 text-center">
                <h5 style="font-weight: bold">退换货</h5>
                <h5> 退换货服务查询</h5>
                <h5> 自助申请退换货</h5>
                <h5> 退换货进度查询</h5>
                <h5>退款方式和时间</h5>
            </div>
            <div class="col-md-1 text-center">
                <h5 style="font-weight: bold">商家服务</h5>
                商家中心
                运营服务
                加入尾品汇
            </div>
            <div class="col-md-2"></div>
        </div>
    </div>
</section>

</html>