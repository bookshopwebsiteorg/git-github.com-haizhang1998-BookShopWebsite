<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>用户订单界面</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/html5shiv@3.7.3/dist/html5shiv.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/respond.js@1.4.2/dest/respond.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/webbase.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/pages-seckillOrder.css" />
    <script src="../static/js/vue.js"></script>
    <style>
        .row {
            height: 40px;
            line-height: 40px;
        }
        .logo-text{
            height: 120px;
            width: 100%;
            display: inline-block;
            margin-top: 50px;
            padding-left: 50px;
            background-color: gray;
            font-size: 60px;
            color: black;
            line-height: 120px;
        }
        .headerOfCartDivSon{
            margin-top: 10px;
            background-color: #cccccc;
        }

        .content-header {
            display: block;
            bottom: -2px;
            height: 40px;
            line-height: 40px;
            margin-top: 10px;
            font-size: 30px;
        }
        .content-header a {
            font-size: 20px;
            font-weight: bold;
            color: black;
            padding-left: 20px;
        }

        .content-header span {
            padding-left: 20px;
        }

        .content hr{
            width: 100%;
            color: #dddddd;
        }
        .headerOfCartDivSon{
            text-align: center;
            height: 50px;
            float: left;
            display:inline-block;
            line-height: 50px;

        }
        .goodsImg{
            width: 80px;
            height: 80px;

        }
        .goodsItemLi{
            height: 100px;
            line-height: 100px;
        }

        #nav-head{
            background-color: black;
        }
    </style>
</head>
<body>
<%--导航栏--%>
<section id="navbarSection">
    <nav id="nav-head" class="navbar navbar-inverse navbar-fixed-top">
        <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>

            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse " id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">

                    <li>
                        <c:choose>
                        <c:when test="${sessionScope.userInfo==null}">
                        <a href="/user/login">
                    <li>亲，请登录</li>
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

                    <c:if test="${sessionScope.requestRecordShop==null}">
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
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>
</section>

<section class="logo-text" >
    <div class="clearfix">
        <span>支付界面</span>
        <a href="${pageContext.request.contextPath}/goods/homepage" style="margin-left: 100px;font-size: 30px;vertical-align: center">首页</a>
    </div>
</section>

<div class="container" style="margin-top: 20px">
    <div class="row" >
        <div >
            <span class="glyphicon glyphicon-ok-circle" aria-hidden="true" style="font-size: 25px;color: #1ba157;"></span>
            <span style="font-size: 18px;color: red;margin-left: 10px">订单提交成功！请及时付款！</span>
            <span style="font-size: 18px;margin-left: 20px">订单号:${order.orderId}</span>
        </div>
    </div>
</div>

<div class="container"  >
    <div class="row">
        <div class="headerOfCartDivSon col-md-4 text-center">商品图片</div>
        <div class="headerOfCartDivSon col-md-4 text-center">商品名称</div>
        <div class="headerOfCartDivSon col-md-2 text-center">单价</div>
        <div class="headerOfCartDivSon col-md-2 text-center">数量</div>
    </div>
</div>


    <c:forEach var="detail" items="${order.orderDetails}">
        <div class="container" style="border: 1px solid black" >
            <div class="row">
                <div style="border: 1px solid black;">
                    <div class="goodsItemLi col-md-4 text-center" style="margin-top: 10px">
                        <img src="${detail.image}" class="goodsImg" alt="图片加载中.....">
                    </div>
                    <div class="goodsItemLi col-md-4 text-center">
                            ${detail.goodsName}
                    </div>
                    <div class="goodsItemLi col-md-2 text-center">
                        ￥${detail.price}
                    </div>
                    <div class="goodsItemLi col-md-2 text-center">
                            ${detail.num}
                    </div>
                </div>

            </div>
        </div>
    </c:forEach>


<div class="container">
    <div class="row" style="background-color: #F1F1F1;height: 160px;margin-top: 30px">
        <div class="order-price">
            <p style="font-size: 18px">商品总金额：￥${order.actualPay-order.postFee}</p>
            <p style="font-size: 18px">运费金额：￥${order.postFee}</p>
            <h4 class="red">实际支付：￥${order.actualPay}</h4>
        </div>
    </div>
</div>

<div class="row" style="margin-left: 1200px;margin-top: 30px">
    <div class="dropdown">
        <button class="btn btn-danger btn-lg dropdown-toggle" type="button" id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
            支&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;付
            <span class="caret"></span>
        </button>
        <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
            <li class="text-center"><a href="/order/updatePaymentType/${order.orderId}/1" class="btn btn-primary btn-sm active" role="button">微信支付</a></li>
            <li class="text-center"><a href="/order/updatePaymentType/${order.orderId}/2" class="btn btn-primary btn-sm active" role="button">支付宝支付</a></li>
            <li class="text-center"><a href="/order/updatePaymentType/${order.orderId}/3" class="btn btn-primary btn-sm active" role="button">银行卡支付</a></li>
        </ul>
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
<script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
</body>
</html>