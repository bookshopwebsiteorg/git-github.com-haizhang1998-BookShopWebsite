<%--
  Created by IntelliJ IDEA.
  User: 咯还长
  Date: 2018/12/3
  Time: 15:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet">
<!-- jQuery -->
<script src="http://code.jquery.com/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>我的足迹</title>
</head>
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

<style type="text/css">
    #tabpaneSection{
        background:#e7e7e7;
        margin-top: 50px;
        height: 100px;
        padding: 20px;

    }
    #footprintDiv{
        margin-left: 100px;
        height: 100px;
        margin-right: 100px;
        margin-top: 10px;
    }
    .timeDiv{
        font-size: 20px;
        padding: 5px;
        padding-left: 20px;
        font-weight: bold;
        border: 1px solid #e7e7e7;
        background:#e7e7e7;
        color:black;
    }
    #itemListDiv-ul{
        list-style: none;
    }
    #itemListDiv-ul li{
        float: left;
        margin-left: 20px;
    }

</style>
<body>
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
                            </ul>
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
                            <li><a href="/order/queryAllUserOrderByUserId">我的订单</a></li>
                        </ul>
                    </li>
                </ul>
                <ul class="nav navbar-nav" style="margin-left: 500px">
                    <li><a href="#"><span>购物车<span class="badge" style="margin-left: 5px">0</span></span></a></li>
                    <li><a href="/user/revise">个人中心</a></li>
                    <li><a href="/goods/homepage">返回首界面</a> </li>
                    <li><a href="/user/logout">注销</a></li>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>
</section>
<section id="tabpaneSection">
    <div class="container">
        <div class="row">
            <div class="col-md-2">
                <h1 style="color:black;line-height:20px;font-weight:bold;margin-left: -50px">浏览记录</h1>
            </div>
        </div>
    </div>
</section>

<section id="footprintDiv">
    <c:if test="${allFootPrint.size()<=0}">
        <p style="font-size: 30px; font-weight: bolder ;margin-top: 200px;" class="text-center text-muted">暂时没有浏览记录喔</p>
    </c:if>
    <c:forEach var="footprintMapEntry" items="${allFootPrint}">
        <div class="timeDiv">${footprintMapEntry.key}</div>
        <div style="padding: 10px;margin-top: 10px;border: 1px solid #e7e7e7" class="text-center">
            <div class="row">
                <c:forEach var="item" items="${footprintMapEntry.value}"  >
                    <div class="col-md-3" style="border: 1px solid #e7e7e7">
<%--                        <a style="text-decoration:none" href="/goods/buy/${item.goodsId}}">--%>
                            <img class="itemImage" style="width: 240px;height: 240px" src=${item.imgDir}>
                            <p  style="font-size: 20px;font-weight: bold;height: 25px;overflow: hidden;color:black;">
                                    ${item.goodsName}
                            </p>
<%--                        </a>--%>
                        <a style="padding: 10px;width: 100px;font-size: 18px;font-weight:bold;" class="btn btn-default" href="/goods/buy/${item.goodsId}">购买</a>
                        <a style="padding: 10px;width: 100px;font-size: 18px;font-weight:bold;" class="btn btn-primary btn-md" href="/goods/delFootPrint/${item.goodsId}">删除</a>
                    </div>
                </c:forEach>
            </div>
        </div>
    </c:forEach>
</section>

</body>
</html>
