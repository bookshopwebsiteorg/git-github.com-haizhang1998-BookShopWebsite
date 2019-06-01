<html lang="en">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!--<script src="js/homePage.js"></script>-->
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet">
<!-- jQuery -->
<script src="http://code.jquery.com/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<script src="/lib/jquery.raty.js"></script>
<head>
    <title>商品详细信息</title>
    <link rel="stylesheet" type="text/css" href="css/goodsInterface_css.css">
</head>
<style>
    #moneyDiv{
        height:60px;
        width: 510px;

        float: left;
        margin-top:10px
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
    .logoStyle{
        margin-top:30px;
        border-bottom: 1px solid black;
        height: 47px;
        margin-left: 60px;
        width: 1165px;
    }

    ul{

        list-style: none;
    }
    #commentSection>div>ul>li，#secondSection>div>ul>li{
        display: inline-block;
        float:left;
    }
    #commentSection>div>ul>li>a,#secondSection>div>ul>li>a{
        background: black;
        margin-left: -58px;
        color: white;
        font-size: 24px;
        padding: 15px;
    }

    #goodsDetailSection{
        margin-top: 60px;
    }

    #commentSection{
        margin-top: 60px;
    }

    #addGoodBtn{
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
        background: #f40;
    }
    .textarea1{
        padding-top: 20px;
        padding-left:40px;
        font-size:20px;
        background: white;
        color: #6c6c6c;
    }

    a {
        text-decoration: none;


    }
    a:hover {
        text-decoration: none;
        color:antiquewhite;
    }
    a:active{
        text-decoration: none;
        color:antiquewhite;
    }
    a:visited{
        text-decoration: none;
        color:antiquewhite;
    }
    a:link{
        text-decoration: none;
        color:antiquewhite;
    }
    .hightLightFont{
        color: #6c6c6c;
        font-size:16px;
    }
    .normalFont{
        margin-left: 10px;
        color:#f40;
        font-size:23px;
    }
    #add,#sub{
        cursor: pointer;
    }

</style>

<script>
    $(function() {
        $.fn.raty.defaults.path = '/lib/img';
        $("[class^=function-demo]").raty({
            number: 5, //多少个星星设置
            targetType: 'hint', //类型选择，number是数字值，hint，是设置的数组值
            path: '/lib/img',

            cancelOff: 'cancel-off.png',
            cancelOn: 'cancel-on.png',
            readOnly: true,
            size: 24,
            starHalf: 'star-half.png',
            starOff: 'star-off.png',
            starOn: 'star-on.png',
            cancel: false,
            targetKeep: true,

            // targetText: '请选择评分',
            score: function() {
                return $(this).attr('data-score');
            },
            // click: function(score, evt) {
            //     alert('ID: ' + $(this).attr('id') + "\nscore: " + score + "\nevent: " + evt.type);
            //
            // }
        });
        $("#sub").click(function () {
            if(parseInt($("#goodsNumber").val())>0){
                $("#goodsNumber").val(parseInt($("#goodsNumber").val())-1);
            }
        });
        $("#add").click(function () {
            var num=$("#goodsNumber").val();
            if(parseInt(num)>=0&&parseInt(num)<parseInt(${goodsInfo.remainNumber})){
                $("#goodsNumber").val(parseInt(num)+1);
            }
        });
        $("#addGoodBtn").click(function () {
            var num=$("#goodsNumber").val();
            if(parseInt(num)>parseInt(${goodsInfo.remainNumber})){
                alert("超出库存范围！如有需求请联系商家！");
                return ;
            }
            if(parseInt(num)==0){
                alert("请选择数量");
                return;
            }
        });

        var userId=parseInt(${sessionScope.userInfo.id});
        var merchantId=parseInt(${goodsInfo.possesserId});
        if(userId!=merchantId){
            $("#delComment").addClass("disable","disabled");
        }


    });
</script>
<body>
<!-- 导航栏div -->
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

<section id="searchSection">
    <div class="container" >
        <div class="row">
            <img src="/images/logo.jpg" width="64px" height="64px" class="pull-left"><span class="searchFont col-md-2" style="margin-top: 40px">海淘商城</span>
            <div >
                <form class="form-horizontal">
                    <div class="form-group" style="display: inline-block;margin-left: 150px;">
                        <input type="text" class="form-control" style="width: 390px" placeholder="搜一搜，更多好书等你看">
                    </div>
                    <button type="submit"class="btn btn-default" style="width:100px;display: inline-block;margin-left: 10px;margin-top: -2px">Submit</button>
                </form>
            </div>

        </div>

    </div>
</section>

<section id="secondSection" class="logoStyle">
    <div class="container-fluid">
        <ul>
            <li><a href="#">宝贝信息</a></li>
        </ul>
    </div>
</section>

<section id="goodsDetailSection">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <div class="row">
                    <div class="col-sm-12 col-md-8 col-md-offset-2" >
                        <div class="thumbnail">
                            <img src="${goodsInfo.imgDir}" alt="图书图片">
                            <div class="caption">
                                <h3 class="text-center">${goodsInfo.goodsName}</h3>
                                <p class="text-center">声明:此书绝对正版，读者朋友们请放心购买！</p>
                                <p><a href="/goods/enshrine/${goodsInfo.goodsId}" class="btn btn-danger col-md-6" role="button">点击收藏</a>
                                    <a href="/chat/singleTalkAddFriend/${sessionScope.userInfo.id}/${goodsInfo.possesserId}" class="btn btn-primary  col-md-6"  role="button">联系卖家</a>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="row">
                    <p style="height: 23px; font-size:20px;color:#000;" ><span>书籍名称:${goodsInfo.goodsName}</span></p>
                </div>
                <div class="row">
                    <p style="color:red; font-size:14px;font-weight: normal;width: 510px;height:38px;overflow: hidden;"><span>描述信息:${goodsInfo.detail}</span></p>
                </div>
                <div class="row">
                    <span style="color: #6c6c6c;font-size: 16px;">商品价格：</span>
                    <span style=" font-weight: bold; font-size: 23px; color:#f40;">￥${goodsInfo.price}</span>
                </div>
                <div class="row" style="margin-top:10px">
                    <span class="col-md-4" style="margin-left: -16px; font-size: 16px; color: #6c6c6c;">请选择你所在区域:</span>
                    <div  class="col-md-2" style="margin-left: -40px;">
                        <select name="Addr" style="background:gold;border: none;height:25px">
                            <option value="广东">广东</option>
                            <option value="北京">北京</option>
                            <option value="上海">上海</option>
                            <option value="南京">南京</option>
                            <option value="重庆">重庆</option>
                            <option value="黑龙江">黑龙江</option>
                        </select>
                    </div>
                </div>
                <div class="row" style="margin-top: 10px;" >
                    <span style="font-size: 16px;color:#6c6c6c;">运费:</span>
                    <span style="font-size: 23px;color: red">￥6</span>
                </div>

                <div class="row" style="margin-top: 10px;">
                    <div class="col-md-4 text-center"  style="border: 1px dotted #6c6c6c" >
                        <span class="hightLightFont">销量:</span><span class="text-muted normalFont">${saledInfo.saledNumber}</span>
                    </div>
                    <div class="col-md-4 text-center"  style="border: 1px dotted #6c6c6c">
                        <span class="hightLightFont">库存:</span><span class="text-muted normalFont">${goodsInfo.remainNumber}</span>
                    </div>

                </div>

                <div class="row" style="margin-top: 15px;">
                    <span class="col-md-2" style="margin-left: -16px;margin-top:5px;display: inline-block;font-size: 15px;color: #6c6c6c">
                        购买数量:
                    </span>
                    <div class="input-group col-md-5" >
                        <span class="input-group-addon" id="sub">-</span>
                        <input type="text" value="0" id="goodsNumber" class="form-control" aria-label="Amount (to the nearest dollar)">
                        <span class="input-group-addon" id="add">+</span>
                    </div>
                </div>
                <div class="row" style="margin-top: 30px;">
                    <input type="button" id="addGoodBtn" value="加入购物车">
                </div>

                <div class="row"style="margin-top: 30px;">
                    <span  style="display: inline-block;float: left;margin-top:14px">卖家承诺:正品保障、下单即送、7日包退、诚信交易</span>
                    <p style="color: #6c6c6c;height: 30px;width: 500px;font-size:14px;background: lightgoldenrodyellow;float: left;margin-top:20px;padding-top:5px;padding-bottom:-1px;"><span>温馨提示：亲,请注意选清楚配送地址喔~</span></p>
                </div>
            </div>
        </div>
    </div>
</section>

<!--商品描述-->
<section id="goodsCommendSection"style="margin-top: 20px">
    <div class="container">
        <div class="jumbotron">
            <h3>书本简介</h3>
            <p>${goodsInfo.detail}</p>
            <p><a class="btn btn-primary btn-lg" href="" role="button">进店看看</a></p>
        </div>
    </div>
</section>

<section id="commentSection" class="logoStyle" style="border: 1px solid #e7e7e7">
    <div class="container-fluid">
        <ul>
            <li ><a href="#" style="background: #e7e7e7;color: black">用户评价
                    <span class="badge">
                        <c:out value="${commentLists.size()}"></c:out>
                    </span>
                </a>
            </li>
        </ul>
    </div>
</section>


<section id="commentDetailSection">
    <div class="container">
        <c:forEach var="commentItem" items="${commentLists}" varStatus="index">
            <div class="row" style="margin-top: 20px">
                <div class="row" style="margin-left: 10px">
                    <div class="media">
                        <div class="media-left">
                            <a href="#">
                                <img class="media-object" src="${commentItem.imageLogo}" alt="用户头像" width="64px" height="64px">
                            </a>
                        </div>
                        <div class="media-body">
                            <h4 class="media-heading">用户昵称:${commentItem.nikeName}</h4>
                            评论日期:
                            <fmt:formatDate value="${commentItem.time}" pattern="yyyy年MM月dd日HH点mm分ss秒"></fmt:formatDate>
                        </div>
                    </div>
                </div>
                <div class="row" style="margin-left: 10px">
                    <textarea class="col-md-11 textarea1" rows="5" disabled="disabled" >${commentItem.commentDetail}</textarea>
                </div>
                <div class="row" style="margin-left: 10px">
                    <span class="col-md-2 text-muted" style="font-weight: bold;font-size: 20px">用户评分：</span>
                    <div class="demo  col-md-4" style="margin-left: -90px">
                        <span class="function-demo${index.index} target-demo"   data-score="${commentItem.score}"></span><span id="function-hint${index.index}" class="hint" style="margin-left: 10px;"></span>
                    </div>
                        <input class="btn btn-primary col-md-2 col-md-offset-4" style="font-weight: bold;margin-top: 10px" id="delComment" value="删除">
                </div>
            </div>
        </c:forEach>
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
