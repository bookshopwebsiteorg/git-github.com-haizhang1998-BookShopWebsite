<%--
  Created by IntelliJ IDEA.
  User: 咯还长
  Date: 2018/12/10
  Time: 14:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>购书网首页</title>
    <!--<script src="js/homePage.js"></script>-->
    <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery -->
    <script src="http://code.jquery.com/jquery.js"></script>
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

</head>
<script>
    function goSearch(){
        var address="/goods/searchGoods/"
        if($("#searchGoodsText").val() == Search) {
            location.href ="#";
        }
        else{
            var search=$("#searchGoodsText").val();
            location.href = address+search;
        }
        //window.location.href="/goods/searchGoods";
    }

    function  openShop() {

        window.location.href="/user/registShop";
        
    }

</script>

<style>

    body{
        background:#EBEBEB;
    }

    #searchSection{
        margin-top: 60px;

        height: 100px;
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

    #carouselSection{

        margin-top: 10px;
    }
    .searchFont{
        font-size: 24px;
        margin-left: 20px;
        line-height: 20px;
        font-weight: bolder;


    }

    #categorySection{
        margin-top: 20px;
        margin-left: 30px;
    }
    #categorySection>div>ul>li>a{
        color:black;
        font-size: 18px;
        font-weight: bold;
    }

    .tab_content{
        overflow: hidden;
        text-overflow: ellipsis;
        display:-webkit-box;
        -webkit-box-orient:vertical;
        -webkit-line-clamp:3;
        height:58px;
    }
    .tab_img{
        height: 100px;
    }

    #BookContentSection>div>div>div>h3{
        margin-left: 30px;
    }
    #RecommendSection{

    }
    #RecommendSection>div>div>div>h3{
        margin-left: 30px;
        color:#836FFF;

    }
    a:hover{
        text-decoration: none;
    }

</style>
<body>
<%--收藏成功--%>
<c:if test="${enshrine_state!=null}">
    <script>alert("${enshrine_state}")</script>
</c:if>
<%--申请店铺成功--%>
<c:if test="${requestScope.msg!=null}">
    <script>alert("申请店铺发送成功!请即使查阅反馈信息喔！");</script>
</c:if>

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
                    <c:if test="${sessionScope.userInfo!=null}">
                        <li><a href="/chat/chatPage">消息<span class="badge">${sessionScope.tmpmsgNumber}</span></a></li>
                    </c:if>
                    <c:if test="${sessionScope.userInfo.merchantFlag==0}">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">商家管理<span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="/merchant/shop/${sessionScope.userInfo.id}">店铺管理</a></li>
                                <li><a href="/order/queryAllManagerOrderByUserId">货物管理</a></li>
                                <li><a href="/order/test">创建订单</a></li>
                            </ul>
                        </li>
                    </c:if>

                    <c:if test="${sessionScope.requestRecordShop==null && sessionScope.userInfo.merchantFlag!=0}">
                        <li><a onclick="openShop()">我要开店</a></li>
                    </c:if>

                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">信息管理<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="/goods/queryAllEnshrineGoods" target="_blank">收藏夹</a></li>
                            <li><a href="#">反馈信息<span class="badge"></span> </a> </li>
                            <li><a href="/goods/myfootprint">我的足迹</a></li>
                            <li><a href="/order/queryAllUserOrderByUserId">我的订单</a></li>
                        </ul>
                    </li>
                </ul>
                <ul class="nav navbar-nav" style="margin-left: 500px">
                    <li><a href="/goods/cart"><span>购物车<span class="badge" style="margin-left: 5px">0</span></span></a></li>
                    <li><a href="/user/revise">个人中心</a></li>
                    <li><a href="/goods/homepage">返回首界面</a> </li>
                    <li><a href="/user/logout">注销</a></li>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>
</section>

<section id="searchSection">
    <div class="container" >
        <div class="row">
            <img src="/images/logo.jpg" class="pull-left"><span class="searchFont col-md-2" style="margin-top: 40px">海淘商城</span>

                <form class="form-horizontal" style="margin-top: 30px" action="/goods/searchGoods/2">
                    <div class="form-group" style="display: inline-block;margin-left: 150px;">
                        <input type="text" id="searchGoodsText" class="form-control" style="width: 390px" placeholder="Search">
                    </div>
                    <input type="button" class="btn btn-default" style="width:100px;display: inline-block;margin-left: 10px;margin-top: -2px" value="Submit">
                </form>
            </div>

        </div>
    </div>
</section>

<c:if test="${state!=null}">
    <script>alert("订单提交成功!")</script>
</c:if>


<section id="carouselSection" >
    <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
        <!-- Indicators -->
        <ol class="carousel-indicators">
            <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
            <li data-target="#carousel-example-generic" data-slide-to="1"></li>
            <li data-target="#carousel-example-generic" data-slide-to="2"></li>
        </ol>

        <!-- Wrapper for slides -->
        <div class="carousel-inner"  role="listbox" style="height: 450px">
            <div class="item active">
                <img src="/images/carouselPic/carousel1.jpg" style="width:100%;height: 450px" alt="java开发实训教程">
                <div class="carousel-caption">
                    123123
                </div>
            </div>
            <div class="item">
                <img src="/images/carouselPic/carousel2.jpg"  width="100%" alt="python2.jpg">

            </div>
            <div class="item">
                <img src="/images/carouselPic/carousel3.jpg"  width="100%" alt="python3.jpg">

            </div>
            <div class="item">
                <img src="/images/carouselPic/carousel4.jpg"   width="100%" alt="python4.jpg">
            </div>
        </div>

        <!-- Controls -->
        <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span >
            <span class="sr-only">Previous</span>
        </a>
        <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
</section>

<section id="categorySection">
    <div>
        <!-- Nav tabs -->
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" class="active"><a href="#children" aria-controls="children" role="tab" data-toggle="tab">儿童书籍</a></li>
            <li role="presentation"><a href="#history" aria-controls="history" role="tab" data-toggle="tab">军事历史</a></li>
            <li role="presentation"><a href="#health" aria-controls="health" role="tab" data-toggle="tab">家庭养生</a></li>
            <li role="presentation"><a href="#literature" aria-controls="literature" role="tab" data-toggle="tab">文学</a></li>
            <li role="presentation"><a href="#it" aria-controls="it" role="tab" data-toggle="tab">科学技术</a></li>
            <li role="presentation"><a href="#novel" aria-controls="novel" role="tab" data-toggle="tab">小说</a></li>
            <li role="presentation"><a href="#art" aria-controls="art" role="tab" data-toggle="tab">美术</a></li>
        </ul>


        <!-- Tab panes -->
        <div class="tab-content">
            <div role="tabpanel" class="tab-pane active" id="children">
                <div class="row" style="margin-top:30px">
                    <c:forEach varStatus="index" var="book" items="${booksCatagory}">
                    <c:if test="${book.type=='儿童书籍'}">
                            <div class="col-sm-4 col-md-3">
                                <div class="thumbnail">
                                    <img src="${book.imgDir}" style="width: 134px;height: 180px" alt="儿童1" class="tab_img">
                                    <div class="caption">
                                        <h4 class="tab_content">${book.detail}</h4>
                                        <p><span style="color: #f40;" class="text-center">价格${book.price}</span></p>
                                        <p><a href="/goods/enshrine/${book.goodsId}&${sessionScope.userInfo.id}" class="btn btn-primary" role="button"><i class="glyphicon glyphicon-heart-empty"></i>收藏</a>
                                           <a href="/goods/buy/${book.goodsId}" class="btn btn-default" role="button">购买</a>
                                        </p>
                                    </div>
                                </div>
                            </div>
                    </c:if>
                    </c:forEach>
                </div>
            </div>


            <div role="tabpanel" class="tab-pane" id="history">
                <div class="row" style="margin-top:30px">
                    <c:forEach varStatus="index" var="book" items="${booksCatagory}">
                        <c:if test="${book.type=='军事历史'}">
                            <div class="col-sm-4 col-md-3">
                                <div class="thumbnail">
                                    <img src="${book.imgDir}" style="width: 134px;height: 180px" alt="儿童1" class="tab_img">
                                    <div class="caption">
                                        <h4 class="tab_content">${book.detail}</h4>
                                        <p><span style="color: #f40;" class="text-center">价格${book.price}</span></p>
                                        <p><a href="/goods/enshrine/${book.goodsId}&${sessionScope.userInfo.id}" class="btn btn-primary" role="button"><i class="glyphicon glyphicon-heart-empty"></i>收藏</a>
                                            <a href="/goods/buy/${book.goodsId}" class="btn btn-default" role="button">购买</a>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
            <div role="tabpanel" class="tab-pane" id="health">
                <div class="row" style="margin-top:30px">
                    <c:forEach varStatus="index" var="book" items="${booksCatagory}">
                        <c:if test="${book.type=='家庭养生'}">
                            <div class="col-sm-4 col-md-3">
                                <div class="thumbnail">
                                    <img src="${book.imgDir}" style="width: 134px;height: 180px" alt="儿童1" class="tab_img">
                                    <div class="caption">
                                        <h4 class="tab_content">${book.detail}</h4>
                                        <p><span style="color: #f40;" class="text-center">价格${book.price}</span></p>
                                        <p><a href="/goods/enshrine/${book.goodsId}&${sessionScope.userInfo.id}" class="btn btn-primary" role="button"><i class="glyphicon glyphicon-heart-empty"></i>收藏</a>
                                            <a href="/goods/buy/${book.goodsId}" class="btn btn-default" role="button">购买</a>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
            <div role="tabpanel" class="tab-pane" id="literature">
                <div class="row" style="margin-top:30px">
                    <c:forEach varStatus="index" var="book" items="${booksCatagory}">
                         <c:if test="${book.type=='文学'}">
                            <div class="col-sm-4 col-md-3">
                                <div class="thumbnail">
                                    <img src="${book.imgDir}" style="width: 134px;height: 180px" alt="儿童1" class="tab_img">
                                    <div class="caption">
                                        <h4 class="tab_content">${book.detail}</h4>
                                        <p><span style="color: #f40;" class="text-center">价格${book.price}</span></p>
                                        <p><a href="/goods/enshrine/${book.goodsId}&${sessionScope.userInfo.id}" class="btn btn-primary" role="button"><i class="glyphicon glyphicon-heart-empty"></i>收藏</a>
                                            <a href="/goods/buy/${book.goodsId}" class="btn btn-default" role="button">购买</a>
                                        </p>
                                    </div>
                                </div>
                            </div>
                         </c:if>
                    </c:forEach>
                </div>
            </div>
            <div role="tabpanel" class="tab-pane" id="it">
                <div class="row" style="margin-top:30px">
                    <c:forEach varStatus="index" var="book" items="${booksCatagory}">
                        <c:if test="${book.type=='科学技术'}">
                            <div class="col-sm-4 col-md-3">
                                <div class="thumbnail">
                                    <img src="${book.imgDir}" style="width: 134px;height: 180px" alt="儿童1" class="tab_img">
                                    <div class="caption">
                                        <h4 class="tab_content">${book.detail}</h4>
                                        <p><span style="color: #f40;" class="text-center">价格${book.price}</span></p>
                                        <p><a href="/goods/enshrine/${book.goodsId}&${sessionScope.userInfo.id}" class="btn btn-primary" role="button"><i class="glyphicon glyphicon-heart-empty"></i>收藏</a>
                                            <a href="/goods/buy/${book.goodsId}" class="btn btn-default" role="button">购买</a>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                     </c:forEach>
                </div>
            </div>
            <div role="tabpanel" class="tab-pane" id="novel">
                <div class="row" style="margin-top:30px">
                     <c:forEach varStatus="index" var="book" items="${booksCatagory}">
                        <c:if test="${book.type=='小说'}">
                            <div class="col-sm-4 col-md-3">
                                <div class="thumbnail">
                                    <img src="${book.imgDir}" style="width: 134px;height: 180px" alt="儿童1" class="tab_img">
                                    <div class="caption">
                                        <h4 class="tab_content">${book.detail}</h4>
                                        <p><span style="color: #f40;" class="text-center">价格${book.price}</span></p>
                                        <p><a href="/goods/enshrine/${book.goodsId}&${sessionScope.userInfo.id}" class="btn btn-primary" role="button"><i class="glyphicon glyphicon-heart-empty"></i>收藏</a>
                                            <a href="/goods/buy/${book.goodsId}" class="btn btn-default" role="button">购买</a>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
            <div role="tabpanel" class="tab-pane" id="art">
                <div class="row" style="margin-top:30px">
                    <c:forEach varStatus="index" var="book" items="${booksCatagory}">
                        <c:if test="${book.type=='艺术设计'}">
                            <div class="col-sm-4 col-md-3">
                                <div class="thumbnail">
                                    <img src="${book.imgDir}" style="width: 134px;height: 180px" alt="儿童1" class="tab_img">
                                    <div class="caption">
                                        <h4 class="tab_content">${book.detail}</h4>
                                        <p><span style="color: #f40;" class="text-center">价格${book.price}</span></p>
                                        <p><a href="/goods/enshrine/${book.goodsId}&${sessionScope.userInfo.id}" class="btn btn-primary" role="button"><i class="glyphicon glyphicon-heart-empty"></i>收藏</a>
                                            <a href="/goods/buy/${book.goodsId}" class="btn btn-default" role="button">购买</a>
                                        </p>
                                    </div>
                                </div>
                            </div>
                         </c:if>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</section>

<section id="BookContentSection">
    <div class="container-fluid">
        <div class="row">

            <div class="col-md-9" >
                <div class="page-header">
                    <h2 style="margin-left: 30px">新书上架<a href="#" style="font-size: 18px;margin-top:10px;" class="pull-right">获取更多<span class="badge">></span></a></h2>
                </div>
                        <div class="row" style="margin-top:30px">
                            <c:forEach varStatus="index" var="book" items="${newGoodsList}">
                                <div class="col-sm-4 col-md-3">
                                    <div class="thumbnail">
                                        <img src="${book.imgDir}" style="height: 180px;width: 134px" alt="${book.goodsName}" class="tab_img">
                                        <div class="caption">
                                            <h4 class="tab_content">${book.detail}</h4>
                                            <p><span style="color: #f40;" class="text-center">价格${book.price}</span></p>
                                            <p><a href="/goods/enshrine/${book.goodsId}&${sessionScope.userInfo.id}" class="btn btn-primary" role="button"><i class="glyphicon glyphicon-heart-empty"></i>收藏</a>
                                                <a href="/goods/buy/${book.goodsId}" class="btn btn-default" role="button">购买</a>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
            </div>

            <div class="col-md-3">


                <div class="panel panel-default"style="margin-top: 110px">
                    <!-- Default panel contents -->
                    <div class="panel-heading">热销排行</div>
                    <!-- List group -->
                    <ul class="list-group">
                        <li class="list-group-item"><a href="/goods/searchGoods/${hotGoodsList[0].goodsId}">${hotGoodsList[0].goodsInfo.goodsName}</a><span class="badge" style="background: red">1</span></li>
                        <li class="list-group-item"><a href="/goods/searchGoods/${hotGoodsList[1].goodsId}">${hotGoodsList[1].goodsInfo.goodsName}</a><span class="badge" style="background: yellow">2</span></li>
                        <li class="list-group-item"><a href="/goods/searchGoods/${hotGoodsList[2].goodsId}">${hotGoodsList[2].goodsInfo.goodsName}</a><span class="badge" style="background: lawngreen">3</span></li>
                        <c:forEach var="book" items="${hotGoodsList}" begin="3" varStatus="index">
                            <li class="list-group-item"><a href="/goods/searchGoods/${book.goodsId}">${book.goodsInfo.goodsName}</a><span class="badge">${index.index+1}</span></li>
                        </c:forEach>
                    </ul>
                </div>

            </div>
        </div>
    </div>
</section>

<img src="/images/image1.jpg" width="100%" height="240">
<section id="RecommendSection">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-9" >
                <div class="page-header">
                    <h2 style="margin-left: 30px">好书推荐<a href="#" style="font-size: 18px;margin-top:10px;" class="pull-right">获取更多<span class="badge">></span></a></h2>
                </div>
                <!--<h3>好书推荐</h3>-->
                <!--<hr style="margin-left: 30px;margin-top:-10px;border-color: black;width: 96%">-->
                <div class="row" style="margin-top:30px">
                     <c:forEach varStatus="index" var="book" items="${excellentGoodsList}">
                            <div class="col-sm-4 col-md-3">
                                <div class="thumbnail">
                                    <img src="${book.imgDir}" style="width: 134px;height: 180px" alt="儿童1" class="tab_img">
                                    <div class="caption">
                                        <h4 class="tab_content">${book.detail}</h4>
                                        <p><span style="color: #f40;" class="text-center">价格${book.price}</span></p>
                                        <p><a href="/goods/enshrine/${book.goodsId}&${sessionScope.userInfo.id}" class="btn btn-primary" role="button"><i class="glyphicon glyphicon-heart-empty"></i>收藏</a>
                                            <a href="/goods/buy/${book.goodsId}" class="btn btn-default" role="button">购买</a>
                                        </p>
                                    </div>
                                </div>
                            </div>
                     </c:forEach>
                </div>
            </div>

            <div class="col-md-3">
                <div class="panel panel-default"style="margin-top: 70px">
                    <!-- Default panel contents -->
                    <div class="panel-heading"><a href="#" style="color: black">必逛店铺</a></div>
                    <!-- List group -->
                    <ul class="list-group">
                        <li class="list-group-item"><a href="/goods/searchGoods/${merchantShopsList[0].merchantId}">${merchantShopsList[0].shopName}</a><span class="badge" style="background: red">1</span></li>
                        <li class="list-group-item"><a href="/goods/searchGoods/${merchantShopsList[2].merchantId}">${merchantShopsList[1].shopName}</a><span class="badge" style="background: yellow">2</span></li>
                        <li class="list-group-item"><a href="/goods/searchGoods/${merchantShopsList[3].merchantId}">${merchantShopsList[2].shopName}</a><span class="badge" style="background: lawngreen">3</span></li>
                        <c:forEach var="shop" items="${merchantShopsList}" begin="3" varStatus="index">
                            <li class="list-group-item"><a href="/goods/searchGoods/${shop.merchantId}">${shop.shopName}</a><span class="badge">${index.index+1}</span></li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</section>


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