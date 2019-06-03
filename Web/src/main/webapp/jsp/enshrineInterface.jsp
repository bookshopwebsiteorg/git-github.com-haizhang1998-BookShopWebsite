<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 咯还长
  Date: 2018/12/3
  Time: 15:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的收藏</title>
</head>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet">
<!-- jQuery -->
<script src="http://code.jquery.com/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

<link rel="stylesheet" type="text/css" href="css/enshrineInterface.css">
<script src="js/jquery-3.2.1.js"></script>
<script src="js/enshrineInterface.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->

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
        $("#enshrine").click(function () {
            <c:choose>
            <c:when  test="${sessionScope.userInfo==null}">
            window.location.href="index.jsp";
            </c:when>
            <c:otherwise>
            window.location.href="affair.do?action=getEnshrineGoods&userId=${sessionScope.userInfo.id}";
            </c:otherwise>
            </c:choose>
        });
    });

</script>
    <body>
    <style>
        .row {
            height: 40px;
            line-height: 40px;
        }
        .logo-text{
            height: 100px;
            width: 100%;
            display: inline-block;
            margin-top: 20px;
            padding-left: 80px;
            background-color: black;
            font-size: 40px;
            color: white;
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
        .goodDetail-shang{



        }
        .goodDetail-xia{
            height: 80px;
        }
        .goodAll{
            margin-bottom: 40px;
            border: 1px solid;
            height: 170px;
            width: 100%;
        }
        #nav-head{
            background-color: #000000;
        }
    </style>
    <%--收藏提示--%>
    <c:if test="${enshrine_state!=null}">
        <script>alert("${enshrine_state}")</script>
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
                    <ul class="nav navbar-nav" style="margin-left: 20px">

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
                                <li><a href="/goods/queryAllEnshrineGoods">收藏夹</a></li>
                                <li><a href="#">反馈信息<span class="badge"></span> </a> </li>
                                <li><a href="#">我的足迹</a></li>

                                <li><a href="/order/queryAllUserOrderByUserId">我的订单</a></li>

                                <li><a href="#">我的订单</a></li>

                            </ul>
                        </li>
                    </ul>

                    <ul class="nav navbar-nav navbar-right" style="margin-right: 30px" >
                        <li><a href="#"><span>购物车<span class="badge" style="margin-left: 5px">0</span></span></a></li>
                        <li><a href="/user/revise">个人中心</a></li>
                        <li><a href="/user/logout">注销</a></li>
                    </ul>
                </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
        </nav>
    </section>

    <section class="logo-text">
        <div class="clearfix">
            <span>我的收藏</span>
        </div>
    </section>

    <div class="content">
            <div class="container">
            <div class="content-header">
                <span >|</span>
                <a href="/goods/queryAllEnshrineGoods">图书收藏</a><span >|</span>
                <a href="/goods/makeComment/992320901993336213">test，定值跳向评论表</a><span >|</span>
            </div>
            <hr>
                <br>

                <c:forEach varStatus="index" var="book" items="${enshrineItemList}">
                    <c:if test="${book.validFlag==0}">
                        <div class="col-sm-4 col-md-3">
                            <div class="thumbnail">
                                <img src="${book.imgDir}" style="width: 134px;height: 180px" alt="图片" class="tab_img">
                                <div class="caption">
                                    <h4 class="tab_content">${book.goodsName}</h4>
                                    <p><span style="color: #f40;" class="text-center">价格${book.price}</span></p>
                                    <p><a href="/goods/deleteEnshrineGoods/${book.goodsId}" class="btn btn-primary" role="button">删除收藏</a>
                                        <a href="/goods/buy/${book.goodsId}" class="btn btn-default" role="button" >购买</a>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${book.validFlag!=0}">
                        <div class="col-sm-4 col-md-3">
                            <div class="thumbnail">
                                <img src="${book.imgDir}" style="width: 134px;height: 180px" alt="图片" class="tab_img">
                                <div class="caption">
                                    <h4 class="tab_content">${book.goodsName} <b style="color: red">(已下架)</b></h4>
                                    <p><span style="color: #f40;" class="text-center">价格${book.price}</span></p>
                                    <p><a href="/goods/deleteEnshrineGoods/${book.goodsId}" class="btn btn-primary" role="button">删除收藏</a>
                                        <a href="/goods/buy/${book.goodsId}" class="btn btn-default" role="button" disabled="disabled" >购买</a>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </div>





    <%-- 分页功能--%>
    <<%--nav aria-label="Page navigation" class="text-center">
        <ul class="pagination">
            <li>
                <a href="#" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                </a>
            </li>
            <li><a href="#">1</a></li>
            <li><a href="#">2</a></li>
            <li><a href="#">3</a></li>
            <li><a href="#">4</a></li>
            <li><a href="#">5</a></li>
            <li>
                <a href="#" aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                </a>
            </li>
        </ul>
    </nav>--%>

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
