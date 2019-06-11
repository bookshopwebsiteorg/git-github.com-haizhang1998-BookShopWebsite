<%@ page import="com.haizhang.DTO.OrderDetailDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
    <title>结算画面</title>
</head>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<script src="../static/js/jquery-3.2.1.js"></script>

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

        function oncheck(){

            var n= document.getElementById("name");
            var p=document.getElementById("phone");
            var a=document.getElementById("addr");
            if(n.value==""||p.value==""||a.value==""){
                alert("配送信息不能为空！");
                return false;
            }
            return true;
        }

</script>
<style>
*{
padding:0;
margin:0;
}
#nav{

overflow: auto;
zoom:1;
margin:0 auto;
width: 1100px;
}
#wrapper-top{

width:100%;
background: #f5f5f5;

}
#nav ul {
float: left;
background: #f5f5f5;
width:1000px;
list-style: none;
height:30px;

}
.li1{
font: 13px 微软雅黑 ;
float: left;
text-align: center;

}

.li2{
font: 13px 微软雅黑 ;
float:right;
text-align: center;


}
.headerOfCartDivSon{

    height: 50px;
    width:120px;
    float: left;
    display:inline-block;


}

.headerOfCartFont{
    color: #6c6c6c;
    font-size:14px;
    display:inline-block;
    margin-top:14px;

}
a{
text-decoration: none;
cursor: pointer;
}

#nav ul li a:hover{
display:inline-block;
color:#ff4400;
background: white;
}


li:after{
content:"";
display: inline-block;
margin-right: 25px;
}
#nav li{
color:#6c6c6c;
padding-top:4px;
cursor: pointer;

}
.btn{
    width: 300px;
    height: 42px;
    border-radius: 3px;
    border: 0;
    color: #fff;
    display: inline-block;
    overflow: hidden;
    cursor: pointer;
    zoom: 1;
    font-size: 20px;
    font-weight: bold;
    background: #6c6c6c;

}

a{
    color: #6c6c6c;
}

#lookupLogo-ul li{
    margin-left:4px;
    width: 50px;
    height: 31px;
    background: #f5f5f5;
    padding-left:13px;

}

input{
    outline:none;
}
#tabDiv{
    height:43px;
    float: left;
    width:1050px;
    margin-left:75px;
    border-bottom: 2px solid lightskyblue;
}

#tabDiv ul{
    float: left;
    list-style: none;
}

#tabDiv li{
    width:104px;
    height:38px;
    background: lightskyblue;
    color: white;
    font-size: 18px;
    padding-left:20px;
    padding-right:-10px;
    padding-top:5px;
    border-radius: 2%;
    display: inline-block;

}


body{
    background:#EBEBEB;
}
.row {
    height: 40px;
    line-height: 40px;
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

input[type="number"]{
    width: 50px;
}
</style>
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
                            <li><a href="#">我的足迹</a></li>
                            <li><a href="/order/queryAllUserOrderByUserId">我的订单</a></li>
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
<!--
    <div style="float: left;height: 200px;width: 900px;overflow: auto;margin-left:200px">

        <c:out value="订单提交成，请等待商家发货"></c:out>

        <c:if test="${sessionScope.payOperate=='立即缴费'}">
       <h1 style="display: inline-block">成功缴费：<p style="display: inline-block;margin-left:150px;color: #ff4400"><span>${param.payMoney}元</span></p></h1>
        </c:if>

     <input style="display:block;margin-top: 30px" onclick="window.location.href='shoppingInterface.jsp'" class="btn"  type="button" id="clickBack" value="点我继续购物">
    </div>-->
<!--中间部分-->
<div id="ItemDiv" style="margin-top: 80px;margin-left: 450px;font-size: 25px;">
    <form action="/goods/commitOrder" method="get">
        <input type="hidden" name="allPrice" value="${allPrice}">
        <input type="hidden" name="orderlist" value="${orderlist}">
        <ul class="ItemLi" style="margin-top: 20px;margin-left: 20px;">所需支付：<span>${allPrice}</span>(已含运费6元)
        </ul>
        <%--<ul class="ItemLi" style="margin-top: 20px;margin-left: 20px;">支付方式:--%>
<%--        <select name="paymentType" style="margin-left:-35px" onchange="this.parentNode.nextSibling.value=this.value">              --%>
<%--                <option value="1">微信支付</option>--%>
                <%--<option value="2">支付宝付款</option>--%>
                <%--<option value="3">银行卡付款</option>   --%>
<%--        </select>--%>
        <%--</ul>--%>
    <ul class="ItemLi" style="margin-left: 20px;margin-top:20px">请填写以下配送信息：
    </ul>
        <ul class="ItemLi" style="margin-left: 20px;margin-top:20px">收件人姓名:
            <input type = "text" value="${userInfo.name}" name="name" id="name">
        </ul>
        <ul class="ItemLi" style="margin-left: 20px;margin-top:20px">联系电话&nbsp;&nbsp;&nbsp;&nbsp;:
            <input type = "text" value="${userInfo.phone}" name="phone" id="phone">
        </ul>
        <ul class="ItemLi" style="margin-left: 20px;margin-top:20px">配送地址&nbsp;&nbsp;&nbsp;&nbsp;:
            <input type = "text" value="${userInfo.addr}" name="addr" id="addr">
        </ul>
        <ul class="ItemLi" style="margin-left: 20px;margin-top:20px">邮政编号&nbsp;&nbsp;&nbsp;&nbsp;:
            <input type = "text" name="zip">
        </ul>
        <ul class="ItemLi" style="margin-left: 20px;margin-top:20px">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注&nbsp;&nbsp;&nbsp;&nbsp;:
            <input type = "text"  name="remark" >
        </ul>
        <ul class="ItemLi" style="margin-left: 20px;margin-top:20px">
            <input type="submit" id="payBtn"  value="提交订单" class="btn" style="margin-top: 30px;">
        </ul>
    </form>
</div>

<!--底部-->
<section id="FooterSection" style="margin-top: 140px">
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
