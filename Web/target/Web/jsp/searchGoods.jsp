<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>搜索结果</title>
</head>

<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

<script src="js/jquery-3.2.1.js"></script>
<link rel="stylesheet"  type="text/css" href="css/searchGoods.css">


<body>
<style>
    body{
        background:#EBEBEB;
    }
    .row {
        height: 40px;
        line-height: 40px;
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

    #searchSection>div>div>img{
        width:80px;
        height:80px;
        margin-top: 10px;
        margin-left: 10px;

    }
    #searchSection>div>div>div{
        display: inline-block;
        width: 700px;
        margin-top: 30px;
        margin-left: 160px
    }
    #categorySection>div>ul>li>a{
        color:black;
        font-size: 18px;
        font-weight: bold;
    }

</style>
<script>
    $(document).ready(function(){
        $("form").submit(function () {
            var s=document.getElementById("searchgoods");

            if(s.value==""){
                alert("输入信息不能为空！");
                return false;
            }else if(s.value==" "){
                alert("请输入有效信息！");
                return false;
            }
            return true;
        })
    })
</script>
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
                    <li><a href="/goods/homepage">回到首页</a></li>
                    <li><a href="#"><span>购物车<span class="badge" style="margin-left: 5px">0</span></span></a></li>
                    <li><a href="/user/revise">个人中心</a></li>
                    <li><a href="/user/logout">注销</a></li>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>
</section>
<section id="searchSection" style="margin-top: 60px">
    <div class="container">
        <div class="row">
            <img src="/images/logo.jpg" class="pull-left"><span class="searchFont col-md-2" style="margin-top: 40px">海淘商城</span>
            <div >
                <form class="form-horizontal" action="/goods/searchGoods" method="post">
                    <div class="form-group" style="display: inline-block;margin-left: 150px;">
                        <input type="text" class="form-control" style="width: 390px" placeholder="Search" name="searchgoods" id="searchgoods">
                    </div>
                    <button type="submit"class="btn btn-default" style="width:100px;display: inline-block;margin-left: 10px;margin-top: -2px">搜索</button>
                </form>
            </div>

        </div>

    </div>
</section>

<div class="content" style="margin-top: 20px">
    <div align="center" style="background-color:darkgrey;height: 50px;width: 80%;font-size: 30px;color: black;margin-left: 140px">
        图书
    </div>
    <div class="container" style="margin-top: 15px">
        <c:if test="${goodsInfo.size()<=0}">
            <p style="font-size: 15px;margin-top: 20px;text-align: center">无符合条件的商品</p>
        </c:if>
        <c:forEach varStatus="index" var="book" items="${goodsInfo}">
            <div class="col-sm-4 col-md-3">
                <div class="thumbnail">
                    <img src="${book.imgDir}" style="width: 134px;height: 180px" class="tab_img">
                    <div class="caption">
                        <div style='width:200px; height:100px; text-overflow:ellipsis;overflow:hidden;'>
                            <h4 class="tab_content">${book.detail}</h4>
                        </div>
                        <p><span style="color: #f40;" class="text-center">价格${book.price}</span></p>
                        <p><a href="/goods/enshrine/${book.goodsId}" class="btn btn-primary" role="button">收藏</a>
                            <a href="/goods/buy/${book.goodsId}" class="btn btn-default" role="button">购买</a>
                        </p>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<div class="content">
    <div align="center" style="background-color:darkgrey;height: 50px;width: 80%;font-size: 30px;color: black;margin-left: 140px">
        店铺
    </div>
    <div class="container" style="margin-top: 20px">
        <c:if test="${merchantShop.size()<=0}">
            <p style="font-size: 15px;margin-top: 20px;text-align: center">无符合条件的店铺</p>
        </c:if>
        <c:forEach varStatus="index" var="shop" items="${merchantShop}">
            <div class="col-sm-4 col-md-3">
                <div class="thumbnail">
                    <img src="${shop.shopLogo}" style="width: 134px;height: 180px" class="tab_img">
                    <div class="caption">
                            <h4 class="tab_content" align="center">${shop.shopName}</h4>
                            <p align="right"> <a href=" " class="btn btn-default" role="button" >查看</a></p>
                    </div>
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