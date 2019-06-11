<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script type="text/javascript" src="../static/js/jquery-3.2.1.js"></script>

<html>
<head>
    <title>购物车界面</title>
</head>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<script src="../static/js/jquery-3.2.1.js"></script>

<body>
    <style>
        *{
            padding:0;
            margin:0;
        }

        #nav ul {
            float: left;
            background: #f5f5f5;
            width:1000px;
            list-style: none;
            height:30px;


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

        #nav li {
            padding-top:4px;
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
        #lastWrapper{
            height:1000px;
            width:85%;

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

        #headerOfCartDiv{
            height:55px;
            float: left;
            width:1100px;
            overflow: auto;
            margin-left:75px;
         ;

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

        #goodsItemDiv{
            margin-top: 20px;
            border: 1px solid lightskyblue;
            height:900px;
            float: left;
            width:1050px;
            margin-left:75px;

        }


        .goodsItemUl{
                    list-style: none;
                    float: left;
                    background: #ededed;
                    height:140px;
                    width:1050px;

                }
        .goodsItemLi{
            margin-left: 1px;
            height: 100px;
            float: left;
        }

        .btnALogo{
            background: #dddddd;

            height:25px;
            width: 19px;
            display: inline-block;
            float:left;

        }
        .btn{
            width: 84px;
            height: 42px;
            border-radius: 3px;
            border: 0;
            color: #fff;
            display: inline-block;
            overflow: hidden;
            cursor: pointer;
            zoom: 1;
            font-size: 16px;
            font-weight: bold;
            background: #f40;
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
                                <li><a href="/goods/myfootprint">我的足迹</a></li>
                                <li><a href="#">我的订单</a></li>
                            </ul>
                        </li>
                    </ul>

                    <ul class="nav navbar-nav" style="margin-left: 500px">
                        <li><a href="/goods/homepage">购物首页</a></li>
                        <li><a href="#"><span>购物车<span class="badge" style="margin-left: 5px">0</span></span></a></li>
                        <li><a href="/user/revise">个人中心</a></li>
                        <li><a href="/user/logout">注销</a></li>
                    </ul>
                </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
        </nav>
    </section>


    <c:if test="${state!=null}">
        <script>alert("订单提交失败!")</script>
    </c:if>


<!--中间部分-->
 <!-- 从这一部分开始改 -->
<div id="lastWrapper" style="margin-top: 80px">
    <div id="tabDiv">
        <ul>
            <li><a href="cart.jsp" style="color: white;">我的宝贝</a></li>
        </ul>
    </div>
    <div id="c">
        <div class="headerOfCartDivSon" style=" padding-left: 90px;width:350px"><input id="checkAll" class="itemCheckbox"  type="checkbox" value="checked"><p class="headerOfCartFont"><span>全选</span></p></div>
        <div class="headerOfCartDivSon" style="width: 230px"><p class="headerOfCartFont" ><span>商品信息</span></p></div>
        <div class="headerOfCartDivSon" style="width: 120px"><p class="headerOfCartFont"><span>单价</span></p></div>
        <div class="headerOfCartDivSon" style="width:120px"><p class="headerOfCartFont"><span>数量</span></p></div>
        <div class="headerOfCartDivSon" style="width:120px"><p class="headerOfCartFont"><span>金额</span></p></div>
        <div class="headerOfCartDivSon" style="width: 120px"><p class="headerOfCartFont"><span>操作</span></p></div>
    </div>


      <c:forEach var="cart" items="${getAllOrder}" >
    <form id="goodsItemDiv" action="/goods/ConfirmCart"  method="post">
    <ul class="goodsItemUl" id="goodsItemUl${cart.goodsId}">
          <div style="margin-top: 20px">
          <li class="goodsItemLi" style="width:45px;padding-left:15px" >
              <input type="checkbox" name="itemCheckBox" id="checkBox${cart.goodsId}" class="itemCheckbox" value=${cart.goodsId}>
          </li>

          <li class="goodsItemLi">
              <img src=${cart.imgDir} style="width:100px;height:100px" class="goodsImg"  alt="图片加载中.....">
          </li>
          <li class="goodsItemLi" style="margin-top: 20px">
              <a style="float: left;padding-left: 120px;width: 350px;height: 80px">${cart.goodsName}</a>
          </li>
          <li class="goodsItemLi" style="width: 76px;" id="single">
              <p style="color: black;font-weight:bold;margin-top:20px" >￥<span>${cart.price}</span></p>
          </li>
          <li class="goodsItemLi" style="height: 119px;width: 120px;">
              <div style="margin-left: 20px;margin-top:20px">
            <a href="/goods/UpdateDelCart/${cart.goodsId}&${cart.sumOfGoods}" class="btnALogo">&nbsp;-</a>
              <input style="text-align:center; width: 41px;height:25px;float: left" type="text" size="4" value=${cart.sumOfGoods}  name="updateNumber" id="numberText${cart.goodsId}"/>
            <a href="/goods/UpdateAddCart/${cart.goodsId}&${cart.sumOfGoods}" class="btnALogo" >&nbsp;+</a>
              </div>
          </li>
          <li class="goodsItemLi" style="width:105px;margin-left:40px" id="all">
              <p style="color: #ff4400;display: inline-block;margin-top:20px">￥<span>${cart.totalPrice}</span></p>
          </li>
             <!-- <li class="goodsItemLi" style="width:50px;margin-left: 20px;margin-top:20px">
                  <input type="submit" value="修改">
              </li>-->
          <li class="goodsItemLi" style="width:50px;margin-left: 20px;margin-top:20px">
              <a href="/goods/delCart/${cart.goodsId}">删除</a>
          </li>

              </div>
      </ul>
      </c:forEach>

        <div style="float:right;margin-right:60px;margin-top:15px;height: 45px">
            <p style="font-weight: bold; font-size:16px;margin-right:30px;padding-top:10px;float:left;display:inline-block;color: #ff4400;">(不含运费)合计金额:
                <span id="allPrice">
                <c:out value="${CartItem.allPrice}" default="0"></c:out>
                    <input type="hidden" name="allPrice" value="${CartItem.allPrice}">
            </span>元</p>
            <input type="submit" id="payBtn"  value="立即结算" class="btn" style="float: right;margin-right: 50px ">
        </div>
    </form>

</div>


    <!--底部-->
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
</div>
</body>
<!--全选-->
<script type="text/javascript">
    $(document).ready(function(){
        $("#checkAll").change(function(){
            if($("#checkAll").is(":checked")){
                var allPrice = 0;
                $("#goodsItemDiv .goodsItemUl").each(function(index){
                    allPrice+=parseFloat($(this).find("#all").find("span").text());
                })
                $("#allPrice").text(allPrice);
                $(".itemCheckbox").each(function(){
                    $(this).prop("checked",true);
                })
            }else{
                $(".itemCheckbox").each(function(){
                $(this).prop("checked",false);
                })
                allPrice = 0;
                $("#allPrice").text(allPrice);
            }
        })

        $("input[name='itemCheckBox']").change(function (){
            var prices=0;
            $("input[name='itemCheckBox']:checked").each(function () {
                prices+=Number($(this).parent().parent().find("#all").find("span").text());
            })
            $("#allPrice").text(prices);
        })

      /*  $(".num").each(function(){
            $(this).change(function(){
                var price=($(this).parent().parent().parent().find("#single").find("span").text())*($(this).val());
                $(this).parent().parent().parent().find("#all").find("span").text(Number(price));
            })
        })*/

        // $('#goodsItemDiv').submit(function () {
        //     alert($(this).serialize());
        //     return false;
        // })



    })
    /*$(function(){
        $('.submit').click(function(){
            var arr=[];
            //根据name的值获得所有选中的checkbox，并遍历
            $("#form input:checkbox[name='itemCheckBox']:checked").each(function (i) {
                arr[i]=$(this).val();
            })
            console.log(arr)


        })
    })*/


</script>
</html>
