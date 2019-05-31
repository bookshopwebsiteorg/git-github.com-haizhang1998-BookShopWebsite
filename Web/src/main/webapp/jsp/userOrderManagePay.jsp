<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" type="text/css" href="css/userOrderManage.css"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>用户订单待付款界面</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/html5shiv@3.7.3/dist/html5shiv.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/respond.js@1.4.2/dest/respond.min.js"></script>

    <script src="../static/js/vue.js"></script>
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
            height: 170px;
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
            <div class="collapse navbar-collapse " id="bs-example-navbar-collapse-1">
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
                                <li><a href="/order/queryAllManagerOrderByUserId">货物管理</a></li>
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

<section class="logo-text">
    <div class="clearfix">
        <span>订单界面</span>
        <a href="${pageContext.request.contextPath}/goods/homepage" style="margin-left: 100px;font-size: 30px;vertical-align: center">首页</a>
    </div>
</section>

<div class="content">
    <div class="container">
        <div class="content-header">
            <a href="/order/queryAllUserOrderByUserId">所有订单</a><span >|</span>
            <a href="/order/queryUserOrderByStatus/userOrderManagePay/1">待付款</a><span>|</span>
            <a href="/order/queryUserOrderByStatus/userOrderManageSend/2">待发货</a><span >|</span>
            <a href="/order/queryUserOrderByStatus/userOrderManageReceive/3">待收货</a><span >|</span>
            <a href="/order/queryUserOrderByStatus/userOrderManageEvaluate/4">待评价</a>
        </div>
        <hr>
    </div>
</div>


<div class="container">
    <div class="row">
        <div class="headerOfCartDivSon col-md-4 text-center">商品详情</div>
        <div class="headerOfCartDivSon col-md-1 text-center">单价</div>
        <div class="headerOfCartDivSon col-md-1 text-center">数量</div>
        <div class="headerOfCartDivSon col-md-2 text-center">商品操作</div>
        <div class="headerOfCartDivSon col-md-1 text-center">实付款</div>
        <div class="headerOfCartDivSon col-md-2 text-center">交易状态</div>
        <div class="headerOfCartDivSon col-md-1 text-center">交易操作</div>
    </div>
</div>

<c:forEach var="Item" items="${list}">
    <div class="container" style="margin-top: 20px">
        <div class="row" >
            <div class="container" style="<c:choose><c:when test="${Item.orderStatus.status==6||Item.orderStatus.status==5}">background-color: #cccccc;</c:when><c:otherwise>background-color: #a6e1ec;</c:otherwise></c:choose>height: 40px">
                <div class="row">
                    <div class="col-md-6 text-left">
                        <span style="padding-left: 40px;padding-top: -10px">创建时间 : ${Item.orderStatus.createTime}</span>
                        <span style="margin-left: 30px">订单号 : ${Item.orderId}</span>
                    </div>
                    <div class="col-md-2 text-center">
                            ${Item.orderDetails.get(0).shopName}
                    </div>
                    <div class="col-md-2 text-center">
                        <a href="/merchant/chat/${Item.orderDetails.get(0).merchantId}" class="glyphicon glyphicon-user" style="padding:10px">联系卖家</a>
                    </div>
                    <div class="col-md-2 text-center">
                        <c:choose>
                            <c:when test="${Item.orderStatus.status >= 4 && Item.orderStatus.status<=6}">
                                <a href="/order/deleteUserOrder/${Item.orderId}" class="glyphicon glyphicon-trash" style="padding:10px">删除订单</a>
                            </c:when>
                        </c:choose>
                    </div>
                </div>
            </div>

            <c:forEach items="${Item.orderDetails}" var="detail">
                <div class="container" style="border: 1px solid black;">
                    <div class="row">
                        <div class="goodsItemLi col-md-2 text-center" style="margin-top: 10px">
                            <img src="${detail.image}" class="goodsImg" alt="图片加载中.....">
                        </div>
                        <div class="goodsItemLi col-md-2">
                                ${detail.goodsName}
                        </div>
                        <div class="goodsItemLi col-md-1 text-center">
                            ￥${detail.price}
                        </div>
                        <div class="goodsItemLi col-md-1 text-center">
                                ${detail.num}
                        </div>
                        <div class="goodsItemLi col-md-2 text-center">
                            <div class="row">
                                <c:choose>
                                    <c:when test="${Item.orderStatus.status==1||Item.orderStatus.status==2||Item.orderStatus.status==3}">投诉卖家</c:when>
                                    <c:when test="${Item.orderStatus.status==4||Item.orderStatus.status==6}">申请售后</c:when>
                                    <c:when test="${Item.orderStatus.status==7}">已提醒卖家发货</c:when>
                                </c:choose>
                            </div>
                            <div class="row">
                                <c:choose>
                                    <c:when test="${Item.orderStatus.backpay==1}">退款申请中</c:when>
                                    <c:when test="${Item.orderStatus.backpay==2}">退货申请中</c:when>
                                    <c:when test="${Item.orderStatus.backpay==3}">退款成功</c:when>
                                    <c:when test="${Item.orderStatus.backpay==4}">不同意退款申请</c:when>
                                    <c:when test="${Item.orderStatus.backpay==5}">
                                        同意退货申请<br>
                                        <a href="/order/modifyUserOrderBybackpay/userOrderManagePay/1/7/${detail.orderId}">填写退货信息</a>
                                    </c:when>
                                    <c:when test="${Item.orderStatus.backpay==6}">不同意退货申请</c:when>
                                    <c:when test="${Item.orderStatus.backpay==7}">等待卖家退货审核</c:when>
                                    <c:when test="${Item.orderStatus.backpay==8}">退货成功</c:when>
                                    <c:when test="${Item.orderStatus.backpay==9}">退货失败(卖家寄回,等待签收)</c:when>
                                </c:choose>
                            </div>
                        </div>
                        <div class="goodsItemLi col-md-1 text-center">
                            <div class="row">
                                ￥${Item.actualPay}
                            </div>
                            <div class="row">
                                (含运费:￥${Item.postFee})
                            </div>
                        </div>
                        <div class="goodsItemLi col-md-2 text-center">
                            <div class="row">
                                <c:choose>
                                    <c:when test="${Item.orderStatus.status==1}">等待付款</c:when>
                                    <c:when test="${Item.orderStatus.status==2 ||Item.orderStatus.status==7}">买家已付款</c:when>
                                    <c:when test="${Item.orderStatus.status==3}">等待签收</c:when>
                                    <c:when test="${Item.orderStatus.status==4}">交易成功</c:when>
                                    <c:when test="${Item.orderStatus.status==5}">交易取消</c:when>
                                    <c:when test="${Item.orderStatus.status==6}">已评价</c:when>
                                </c:choose>
                            </div>
                            <div class="row">
                                <a href="/order/queryAllUserOrderDetail/${Item.orderId}">订单详情</a>
                            </div>
                        </div>
                        <div class="goodsItemLi col-md-1 text-center" style="margin-top: 7px;">
                            <c:choose>
                                <c:when test="${Item.orderStatus.status==1}">
                                    <div class="row">
                                        <a href="/order/modifyUserOrderStatus/userOrderManagePay/2/${detail.orderId}" class="btn btn-danger btn-sm active" role="button">立即付款</a>
                                    </div>
                                    <div class="row">
                                        <a href="/order/modifyUserOrderStatus/userOrderManagePay/5/${detail.orderId}" class="btn btn-primary btn-sm active" role="button">取消订单</a>
                                    </div>
                                </c:when>
                                <c:when test="${Item.orderStatus.status==2 ||Item.orderStatus.status==7}">
                                    <div class="row">
                                        <c:choose>
                                            <c:when test="${Item.orderStatus.status==7}">
                                                <a href="/order/modifyUserOrderStatus/userOrderManagePay/7/${detail.orderId}" class="btn btn-primary btn-sm disabled" role="button">提醒发货</a>

                                            </c:when>
                                            <c:otherwise>
                                                <a href="/order/modifyUserOrderStatus/userOrderManagePay/7/${detail.orderId}" class="btn btn-primary btn-sm active" role="button">提醒发货</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <c:choose>
                                        <c:when test="${Item.orderStatus.backpay==0||Item.orderStatus.backpay==4||Item.orderStatus.backpay==6}">
                                            <div class="row">
                                                <div class="dropdown">
                                                    <button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                                        退货/退款
                                                        <span class="caret"></span>
                                                    </button>
                                                    <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                                                        <li class="text-center"><a href="/order/modifyUserOrderBybackpay/userOrderManagePay/1/1/${detail.orderId}">仅退款(未收到货)</a></li>
                                                        <li class="text-center"><a href="/order/modifyUserOrderBybackpay/userOrderManagePay/1/2/${detail.orderId}">退货退款(已收到货)</a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </c:when>
                                    </c:choose>
                                </c:when>
                                <c:when test="${Item.orderStatus.status==3}">
                                    <c:choose>
                                        <c:when test="">

                                        </c:when>
                                        <c:otherwise>

                                        </c:otherwise>
                                    </c:choose>
                                    <div class="row">
                                        <a href="/order/modifyUserOrderStatus/userOrderManagePay/4/${detail.orderId}" class="btn btn-primary btn-sm active" role="button">确认收货</a>
                                    </div>
                                    <c:choose>
                                        <c:when test="${Item.orderStatus.backpay==0||Item.orderStatus.backpay==4||Item.orderStatus.backpay==6}">
                                            <div class="row">
                                                <div class="dropdown">
                                                    <button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenu3" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                                        退货/退款
                                                        <span class="caret"></span>
                                                    </button>
                                                    <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                                                        <li class="text-center"><a href="/order/modifyUserOrderBybackpay/userOrderManagePay/1/1/${detail.orderId}">仅退款(未收到货)</a></li>
                                                        <li class="text-center"><a href="/order/modifyUserOrderBybackpay/userOrderManagePay/1/2/${detail.orderId}">退货退款(已收到货)</a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </c:when>
                                    </c:choose>
                                </c:when>
                                <c:when test="${Item.orderStatus.status==4}">
                                    <div class="row">
                                        <a href="" class="btn btn-primary btn-sm active" role="button">评价</a>
                                    </div>
                                </c:when>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

</c:forEach>





<%--分页插件--%>
<%--<nav aria-label="Page navigation" class="text-center">--%>
<%--<ul class="pagination">--%>
<%--<li>--%>
<%--<a--%>
<%--<c:if test="${pageInfo.pageNum != pageInfo.firstPage}">href="/order/queryPage/${pageInfo.pageNum - 1 }/userOrderManage"</c:if>--%>
<%--<c:if test="${pageInfo.pageNum == pageInfo.firstPage}"> href="javascript:void(0)" class="disabled"</c:if>--%>
<%--aria-label="Previous">--%>
<%--<span aria-hidden="true">&laquo;</span>--%>
<%--</a>--%>

<%--</li>--%>
<%--<c:forEach begin="1" end="${pageInfo.pages}" varStatus="status">--%>
<%--<li>--%>
<%--<a href="/order/queryPage/${status.count}/userOrderManage"--%>
<%--<c:if test="${status.count == pageInfo.pageNum}">--%>
<%--class="select"--%>
<%--</c:if>>--%>
<%--${status.count}--%>
<%--</a>--%>
<%--</li>--%>

<%--</c:forEach>--%>

<%--<li>--%>
<%--<a--%>
<%--<c:if test="${pageInfo.pageNum == pageInfo.lastPage}">class="disabled" href="javascript:void(0)"</c:if>--%>
<%--<c:if test="${pageInfo.pageNum != pageInfo.lastPage}">href="/order/queryPage/${pageInfo.pageNum + 1 }/userOrderManage"</c:if>--%>
<%--aria-label="Next">--%>
<%--<span aria-hidden="true">&raquo;</span>--%>
<%--</a>--%>
<%--</li>--%>
<%--</ul>--%>
<%--</nav>--%>

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