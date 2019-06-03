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
<link rel="stylesheet" type="text/css" href="css/enshrineInterface.css">
<script src="js/jquery-3.2.1.js"></script>
<script src="js/enshrineInterface.js"></script>
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
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">商家管理<span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                    <li><a href="#">店铺管理</a></li>
                                    <li><a href="/order/getManagerOrder">货物管理</a></li>
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
                                <li><a href="#">我的足迹</a></li>
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

    </body>
</html>
