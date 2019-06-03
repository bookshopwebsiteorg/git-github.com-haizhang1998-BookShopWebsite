<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>我的足迹</title>
</head>

<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

<script src="js/jquery-3.2.1.js"></script>
<link rel="stylesheet"  type="text/css" href="css/myFootPrint.css">

<script>
    $(document).ready(function () {

        $("#myFootPrint").click(function () {
            <c:choose>
            <c:when test="${sessionScope.userInfo==null}">
            window.location.href="index.jsp";
            </c:when>
            <c:otherwise>
            window.location.href="affair.do?action=getAllFootPrint&userId=${sessionScope.userInfo.id}";
            </c:otherwise>
            </c:choose>
        });
    });
</script>
    <body>
    <style>
        body{
            background:#EBEBEB;
        }
        .row {
            height: 40px;
            line-height: 40px;
        }
        .logo-text{
            height: 80px;
            width: 100%;
            display: inline-block;
            margin-top: 50px;
            padding-left: 50px;
            background-color: #EBEBEB;
            font-size: 40px;
            color: black;
            line-height: 120px;
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

        .goods-date .line {
            position: absolute;
            top: 23px;
            width: 211px;
            left: -16px;
            height: 1px;
            line-height: 1px;
            background: #ccc;
        }
        .goods-date {
            position: relative;
            height: 45px;
            line-height: 45px;
            color: #666;
        }
        .date {
            position: relative;
            top: 3px;
            right: 16px;
            padding-left: 16px;
            z-index: 2;
            zoom: 1;
            padding-right: 16px;
            line-height: 17px;
            background-color: #f7f7f7;
            color: #333;
        }
        .goods-date .date .date-lite {
            font-size: 30px;
            font-weight: 700;
        }


    </style>
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
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
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
                        <li><a href="#">消息<span class="badge">0</span></a></li>

                        <c:if test="${sessionScope.userInfo.merchantFlag==0}">
                            <li>
                                <a href="/merchant/shop/${sessionScope.userInfo.id}">店铺管理</a>
                            </li>
                        </c:if>

                        <c:if test="${sessionScope.requestRecordShop==null && sessionScope.userInfo.merchantFlag!=0}">
                            <li><a onclick="openShop()">我要开店</a></li>
                        </c:if>

                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">信息管理<span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="#">收藏夹</a></li>
                                <li><a href="#">反馈信息<span class="badge"></span> </a> </li>
                                <li><a href="/goods/myfootprint">我的足迹</a></li>
                                <li><a href="#">我的订单</a></li>
                            </ul>
                        </li>
                    </ul>

                    <ul class="nav navbar-nav" style="margin-left: 500px">
                        <li><a href="#">购物首页</a></li>
                        <li><a href="#"><span>购物车<span class="badge" style="margin-left: 5px">0</span></span></a></li>
                        <li><a href="/user/revise">个人中心</a></li>
                        <li><a href="/user/logout">注销</a></li>
                    </ul>
                </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
        </nav>
    </section>

    <section class="logo-text">
            <span>浏览记录</span>
    </section>

    <div class="content">
        <div class="container">
            <br>
        <!--    <div class="goods-date">
                        <span class="date JDate">
                            <i class="date-lite">05</i>
                            ,
                            <i class="date-lite">27</i>
                        </span>
                <s class="line"></s>
            </div>-->
                <c:forEach varStatus="index" var="book" items="${allFootPrint}">
                    <div class="col-sm-4 col-md-3">
                       <div class="thumbnail">
                            <a href="/goods/buy/${book.goodsId}">
                            <img src="${book.imgDir}" style="width: 200px;height: 200px" class="tab_img">
                            <div class="caption">
                                <h4 class="tab_content" align="center">${book.goodsName}</h4>
                            </div>
                            </a>
                            <p align="right">
                                <a href="/goods/delFootPrint/${book.goodsId}" class="btn btn-default" role="button">
                                    <span class="glyphicon glyphicon-trash"></span> 删除
                                </a>
                            </p>
                        </div>
                    </div>
                </c:forEach>
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
</body>
</html>
