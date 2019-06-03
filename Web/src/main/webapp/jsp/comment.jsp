<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 71479
  Date: 2019/5/29
  Time: 21:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>评价商品</title>
   <%-- <!-- default styles -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-star-rating/4.0.6/css/star-rating.min.css" media="all" rel="stylesheet" type="text/css" />

    <!-- optionally if you need to use a theme, then include the theme CSS file as mentioned below -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-star-rating/4.0.6/themes/krajee-svg/theme.css" media="all" rel="stylesheet" type="text/css" />

    <!-- important mandatory libraries -->
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-star-rating/4.0.6/js/star-rating.min.js" type="text/javascript"></script>

    <!-- optionally if you need to use a theme, then include the theme JS file as mentioned below -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-star-rating/4.0.6/themes/krajee-svg/theme.js"></script>

    <!-- optionally if you need translation for your language then include locale file as mentioned below -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-star-rating/4.0.6/js/locales/<lang>.js"></script>--%>
</head>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet">
<!-- jQuery -->
<script src="http://code.jquery.com/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

<link rel="stylesheet" type="text/css" href="css/enshrineInterface.css">
<script src="js/jquery-3.2.1.js"></script>
<script src="js/enshrineInterface.js"></script>


<%--<script>
$("#ratingId").rating({min:0, max:5, step:1, size:'lg'});
</script>--%>

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
                            <li><a href="/goods/queryAllEnshrineGoods" target="_blank">收藏夹</a></li>
                            <li><a href="#">反馈信息<span class="badge"></span> </a> </li>
                            <li><a href="#">我的足迹</a></li>
                            <li><a href="/order/queryAllUserOrderByUserId">我的订单</a></li>
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
    <span>评价订单商品</span>
</div>
</section>
<br>
<br>
<div class="content">
<div class="container">
    <div class="row">
        <div class="headerOfCartDivSon col-md-4 text-center">订单商品</div>
        <div class="headerOfCartDivSon col-md-3 text-center">评论商品</div>
        <div class="headerOfCartDivSon col-md-3 text-center">评分商品</div>
        <div class="headerOfCartDivSon col-md-2 text-center">操作</div>
    </div>
</div>
</div>
<div class="content">
    <div class="container">
        <br>

        <c:forEach varStatus="index" var="orderDetails" items="${order.orderDetails}">
                <div class="row">
                    <div class="thumbnail col-md-12">
                        <div class="col-md-2 text-center"> <a href="#" class="thumbnail"><img src="${orderDetails.image}" style="width: 134px;height: 180px" alt="图片" class="tab_img"/></a></div>
                        <div class="col-md-2">
                            <br><br><br>
                            <strong>${orderDetails.goodsName}</strong><br><br>
                            <em><%--<span style="color: #000000;" class="text-center">商品单价：</span><br>--%><span style="color: #f40;" class="text-center">${orderDetails.price}</span></em></div>
                        <div class="col-md-3 text-center"><br>
                            <span style="color: #000000;" class="text-center">写下您的评价吧~</span>
                            <br><br>
                            <textarea class="form-control" id="remark_${orderDetails.goodsId}" rows="4"></textarea></div>
                        <div class="col-md-3 text-center">
                            <br><br>
                            <span style="color: #000000;" class="text-center">请选择您的评分</span>
                            <br><br>
                            <div class="btn-group" id="grade_${orderDetails.goodsId}" data-toggle="buttons">
                            <label class="btn btn-default ">
                                <input type="radio" name="options" id="option1" autocomplete="off" value="1">1
                            </label>
                            <label class="btn btn-default">
                                <input type="radio" name="options" id="option2" autocomplete="off" value="2">2
                            </label>
                            <label class="btn btn-default">
                                <input type="radio" name="options" id="option3" autocomplete="off" value="3">3
                            </label>
                            <label class="btn btn-default">
                                <input type="radio" name="options" id="option4" autocomplete="off" value="4">4
                            </label>
                            <label class="btn btn-default" >
                                <input type="radio" name="options" id="option5" autocomplete="off" value="5">5
                            </label>
                            </div>
                        </div>
                        <div class="col-md-2 text-center">
                            <br><br><br>
                            <button id="submitButton_${orderDetails.goodsId}" class="btn btn-primary" type="submit" onclick="addComment(${orderDetails.goodsId})">提交评价</button></div>
                    </div>
                </div>
        </c:forEach>
    </div>
</div>

<script>


   function addComment(goodsId){
       var remark=$('#remark_'+goodsId).val();
       var grade=$('#grade_'+goodsId+' input:radio:checked').val();

       if(grade==null||remark==''||remark.length<3||remark==null){
           alert("请先确保评论和评分已填写完成（评论不可少于3个字符）");
       }else {


           window.location.href="/goods/addComment/"+remark+"&"+ grade+"&"+goodsId;


       }
   }
</script>








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
