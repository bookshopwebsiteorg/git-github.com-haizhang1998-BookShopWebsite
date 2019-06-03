<%--
  Created by IntelliJ IDEA.
  User: 咯还长
  Date: 2018/11/5
  Time: 23:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="addr" value="baobei.jsp" scope="page"/>
<script type="text/javascript" src="js/jquery-3.2.1.js"></script>
<link rel="stylesheet" type="text/css" href="css/shoppingInterface.css">

<html>
<head>
    <title>商品选购界面</title>

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

        var address="baobei.jsp"
        function goSearch(){
            if($("#searchGoodsText").val()=="请输入要搜索的商品名字") {
                location.href ="#";
            }
            else{
                var goodsName=$("#searchGoodsText").val();
                location.href = address+"?goodsName="+goodsName;
            }
        }



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
                <c:when test="${sessionScope.userInfo==null}">
                window.location.href="index.jsp";
                </c:when>
                <c:otherwise>
                window.location.href="affair.do?action=getEnshrineGoods&userId=${sessionScope.userInfo.id}";
                </c:otherwise>
                </c:choose>
            });

            $("#itemListDiv .outsideDiv").mousemove(function () {
               $(this).css("border","1px solid #f40");
            })
            $("#itemListDiv .outsideDiv").mouseout(function () {
                $(this).css("border","1px solid #ededed");
            })
            $("#lookupLogo-ul").mouseover(function () {
                  $("#lookupLogoDiv").css("overflow","visible");
             });
            $("#lookupLogo-ul").mouseout(function () {
                $("#lookupLogoDiv").css("overflow","hidden")
            });

            $("#searchGoodsText").focus(function () {
                if($("#searchGoodsText").val()=="请输入要搜索的商品名字"){
                    $("#searchGoodsText").val("");
                }
            });


            $("#searchGoodsText").blur(function () {
                if($(this).val()==""){
                    $(this).val("请输入要搜索的商品名字");
                    $(this).css("color","darkgray");
                }
            });

        });

    </script>
</head>





<body>
<!-- 导航栏div -->
<div id="wrapper-top">
<div id="nav" >
<ul >
    <c:choose>

        <c:when test="${sessionScope.userInfo!=null}">
            <li  class="li1">欢迎,${userInfo.name}</li>
        </c:when>

        <c:otherwise>
            <li class="li1"> <a href="index.jsp" style="color: red">亲，请先登录</a></li>
        </c:otherwise>

    </c:choose>

    <li class="li1"> <a href="#" >个人中心</a></li>
    <li class="li1" ><a href="#" >消息 </a></li>
    <c:if test="${sessionScope.userInfo!=null}">
        <li class="li2" ><a href="logout.jsp" style="color: red;font-weight: bold">点我注销</a></li>
    </c:if>


    <li class="li2"><a href="Cart.do?action=getCart" style="float: left"><p style="float:left;display:inline-block;color: #ff4400;"><span>购物车&nbsp;${sessionScope.myCart.allGoodsCount}</span></p></a></li>
    <li class="li2"> <a id="enshrine">收藏夹</a> </li>
    <li class="li2"><a id="myFootPrint">我的足迹</a></li>
    <li class="li2"> <a href="openShop.jsp">我要开店</a></li>
    <li class="li2"><a href="affair.do?action=updateHotAndNew">返回首页</a></li>
    <li class="li2"><a href="/order/queryAllUserOrderByUserId"> 我的订单</a>
    <li class="li2"><a href="merchantManage.jsp">卖家管理</a>

</ul>
</div>
</div>

<!--中间部分-->
<div id="wrapper-middle">
    <div id="search-div">
        <a href="Cart.do&action=getCart" >
        <img src="images/cart_image.jpg" class="imageLogo" >
        <p style="float:left;margin-left:-5px;display:inline-block;line-height: 80px; vertical-align:10%; font-size:24px; color: #ff4400;font-weight: bold" ><span>购物车</span></p>
        </a>


        <div id="lookupDivWrapper">
        <div id="lookupLogoDiv">
            <ul id="lookupLogo-ul">
                <li name="baobei"><a href="#" style="color: #6c6c6c">宝贝</a></li>
                <li  name="dianpu"><a href="#" style="color: #6c6c6c">店铺</a></li>
            </ul>
        </div>


     <input type="text" placeholder="请输入关键字" style="color: darkgrey" size="60" id="searchGoodsText" maxlength="100"/>
            <input type="button" value="搜索" style="cursor: pointer;" onclick="goSearch()" id="searchBtn"/>

        </div>
    </div>

</div>
<div id="lastWrapper">
<div id="tabDiv">
    <ul>
        <li><a href="shoppingInterface.jsp" style="color: white;">所有宝贝</a></li>
    </ul>
</div>

    <div id="itemListDiv">

        <c:forEach var="goods" items="${sessionScope.allGoods}">
        <a href="affair.do?goodsId=${goods.key}&action=getGoodById">
        <div class="outsideDiv">
            <div class="itemInnerDiv">
                <img src="${goods.value.imgDir}" class="itemImage" />
                <div class="itemMoneyDiv">
                    <p style="display: inline-block;width:80px;color: #ff4400;font-size: 16px;margin-top:4px;margin-left:6px;font-weight: bold"><span>￥${goods.value.price}</span></p>

                    <p style="display: inline-block;width:80px;color: darkgrey;font-size: 14px;margin-left:9px;"><span>
                       <c:forEach var="map" items="${sessionScope.allSaledInfo}">
                           <c:if test="${map.key==goods.key }">
                               <c:catch var="error">
                               ${map.value.saledNumber}
                               </c:catch>
                               <c:if test="${error!=null}">${error}</c:if>
                           </c:if>
                       </c:forEach>
                        人付款

                    </span></p>

                </div>
                <div class="itemDetailDiv">
                    <p style=" overflow: hidden;text-align: center;font-size: 13px;height:55px; width: 180px;display:inline-block;color:#6c6c6c; font-size: 18px">
                       ${goods.value.goodsName}
                    </p>
                </div>
                <div class="itemAddressDiv">
                    <p style="display: inline-block;color:darkgrey;font-size: 14px;float: right;margin-right: 10px;">${goods.value.addr}</p>
                    <p style="display: inline-block;color:darkgrey;font-size: 14px;float: right;margin-right: 10px;float:left;">商家地址：</p>
                </div>
            </div>

        </div>
        </a>
        </c:forEach>
    </div>

</div>
</body>
</html>
