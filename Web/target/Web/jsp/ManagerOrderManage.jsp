<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" type="text/css" href="css/userOrderManage.css"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>商家货物管理界面</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/html5shiv@3.7.3/dist/html5shiv.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/respond.js@1.4.2/dest/respond.min.js"></script>

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
            background-color: black;
            font-size: 60px;
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
            height: 180px;
            width: 100%;
        }
        #nav-head{
            background-color: #d4d4d4;
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

                    <c:if test="${sessionScope.requestRecordShop==null}">
                        <li><a onclick="openShop()">我要开店</a></li>
                    </c:if>

                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">信息管理<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="#">收藏夹</a></li>
                            <li><a href="#">反馈信息<span class="badge"></span> </a> </li>
                            <li><a href="#">我的足迹</a></li>
                            <li><a href="/order/allOrder">我的订单</a></li>
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

<section class="logo-text">
    <div class="clearfix">
        <span>货物管理</span>
        <a href="../goods/homepage" style="margin-left: 100px;font-size: 30px;vertical-align: center">首页</a>
    </div>
</section>

<div class="content">
    <div class="container">
        <div class="content-header">
            <a href="/order/getManagerOrder">所有订单</a><span >|</span>
            <a href="/order/getManagerReadyOrder?sendFlag=0&&payFlag=1&&backFlag=0&&orderFlag=0">发货管理</a><span >|</span>
            <a href="/order/getManagerReturnMoney?backFlag=1&&orderFlag=0">退货退款</a><span >|</span>
            <a href="/order/getManagerByPayFlag?payFlag=0&&orderFlag=0">待付款</a><span>|</span>
            <a href="/order/getManagerReadyOrder?sendFlag=1&&payFlag=1&&backFlag=0&&orderFlag=0">待收货</a>
        </div>
        <hr>

        <div class="content-middle">
            <div class="row">
                <div class="headerOfCartDivSon col-md-3 text-center" style="padding-left: 30px">商品详情</div>
                <div class="headerOfCartDivSon col-md-1 text-center" style="padding-left: 50px">单价</div>
                <div class="headerOfCartDivSon col-md-1 text-center" style="padding-left: 45px">数量</div>
                <div class="headerOfCartDivSon col-md-2 text-center" style="padding-left: 45px">商品状态</div>
                <div class="headerOfCartDivSon col-md-1 text-center" style="padding-left: 40px">实付款</div>
                <div class="headerOfCartDivSon col-md-2 text-center" style="padding-left: 50px">交易状态</div>
                <div class="headerOfCartDivSon col-md-2 text-center" style="padding-left: 40px">交易操作</div>
            </div>
            <br><br>
            <c:forEach var="Item" items="${orderItem}">
                <div class="goodAll">
                    <div class="container">
                        <div class="row" style="margin-top:-10px;">
                            <div class="container" style="background-color: #a6e1ec;margin-left: -15px;height: 40px">
                                <div class="row">
                                    <div class="goodDetail-shang">
                                        <div class="col-md-5 text-left">
                                            <span style="padding-left: 40px;padding-top: -10px">创建时间:${Item.createTime}</span>
                                            <span style="margin-left: 30px">订单号:${Item.orderId}</span>
                                        </div>
                                        <div class="col-md-3 text-left">
                                                用户ID:${Item.id}
                                        </div>
                                        <div class="col-md-2 text-center">
                                            <a href="" class="glyphicon glyphicon-user" style="padding:10px">联系买家</a>
                                        </div>
                                        <div class="col-md-2 text-center">
                                            <c:choose>
                                                <c:when test="${Item.orderFlag!=0}">
                                                    <a href="/order/deleteManagerOrder?orderId=${Item.orderId}" class="glyphicon glyphicon-trash" style="padding:10px">删除订单</a>
                                                </c:when>
                                            </c:choose>

                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="container">
                                <div class="row">
                                    <div class="goodDetail-xia" style="margin-top: 10px;">
                                        <div class="goodsItemLi col-md-3 text-center">
                                            <img src="${Item.imgDir}" class="goodsImg" alt="图片加载中.....">
                                            <span style="margin-left:30px">${Item.goodsName}</span>
                                        </div>
                                        <div class="goodsItemLi col-md-1 text-center">
                                            ￥${Item.price}
                                        </div>
                                        <div class="goodsItemLi col-md-1 text-center">
                                                ${Item.sumOfGoods}
                                        </div>
                                        <div class="goodsItemLi col-md-2 text-center">
                                            <c:choose>
                                                <c:when test="${Item.backFlag==2&&Item.orderFlag==2}">同意退款/退货申请</c:when>
                                                <c:when test="${Item.backFlag==3&&Item.orderFlag==0}">不同意退款/退货申请</c:when>
                                                <c:when test="${Item.backFlag==1&&Item.orderFlag==0}">买家退款/退货申请中</c:when>
                                                <c:when test="${Item.sendFlag==0&&Item.orderFlag==0}">未发货</c:when>
                                                <c:when test="${Item.sendFlag==1&&Item.orderFlag==0}">已发货</c:when>
                                                <c:when test="${Item.sendFlag==2&&Item.orderFlag==1}">已收货</c:when>
                                            </c:choose>
                                        </div>
                                        <div class="goodsItemLi col-md-1 text-center">
                                            ￥${Item.price*Item.sumOfGoods}
                                        </div>
                                        <div class="goodsItemLi col-md-2 text-center">
                                            <c:choose>
                                                <c:when test="${Item.orderFlag==1}">交易成功</c:when>
                                                <c:when test="${Item.orderFlag==2}">交易取消</c:when>
                                                <c:when test="${Item.payFlag==0&&Item.orderFlag==0}">未付款</c:when>
                                                <c:when test="${Item.payFlag==1&&Item.orderFlag==0}">已付款</c:when>
                                            </c:choose>
                                        </div>
                                        <div class="goodsItemLi col-md-2 text-center">
                                            <c:choose>
                                                <c:when test="${Item.orderFlag==0}">
                                                    <div  class="row">
                                                        <a href="/order/modifyManagerOrderFlag?orderId=${Item.orderId}&&orderFlag=2"  class="btn btn-primary btn-sm active" role="button">取消订单</a>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div  class="row">
                                                        <a href="/order/modifyManagerOrderFlag?orderId=${Item.orderId}&&orderFlag=2" class="btn btn-primary btn-sm disabled" role="button">取消订单</a>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                            <c:choose>
                                                <c:when test="${Item.orderFlag==0 && Item.payFlag==1&& Item.sendFlag==0}">
                                                    <div class="row">
                                                        <a href="/order/modifyManagerSendFlag?orderId=${Item.orderId}&&sendFlag=1" class="btn btn-primary btn-sm active" role="button">发货</a>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="row">
                                                        <a href="/order/modifyManagerSendFlag?orderId=${Item.orderId}&&sendFlag=1" class="btn btn-primary btn-sm disabled" role="button">发货</a>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                            <c:choose>
                                                <c:when test="${Item.orderFlag==0 && Item.backFlag==1}">
                                                    <div class="row">
                                                        <div class="dropdown">
                                                            <button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                                                退货/退款
                                                                <span class="caret"></span>
                                                            </button>
                                                            <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                                                                <li class="text-center"><a href="/order/agreeOrder?orderId=${Item.orderId}&&backFlag=2&&orderFlag=2" class="btn-sm active">同意</a></li>
                                                                <li class="text-center"><a href="/order/agreeOrder?orderId=${Item.orderId}&&backFlag=3&&orderFlag=0" class="btn-sm active">拒绝</a></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="row">
                                                        <div class="dropdown">
                                                            <button class="btn btn-primary dropdown-toggle disabled" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                                                退货/退款
                                                                <span class="caret"></span>
                                                            </button>
                                                            <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                                                                <li class="text-center"><a href="/order/modifybackFlag/${Item.orderId}" class="btn-sm disabled">同意</a></li>
                                                                <li class="text-center"><a href="/order/modifybackFlag/${Item.orderId}" class="btn-sm disabled">拒绝</a></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<nav aria-label="Page navigation" class="text-center">
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
</nav>

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