<%--
  Created by IntelliJ IDEA.
  User: 咯还长
  Date: 2019/5/12
  Time: 17:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<!--<script src="js/homePage.js"></script>-->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet">
<!-- jQuery -->
<script src="http://code.jquery.com/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<script src="/static/js/jquery.form.js"></script>
<html>

<head>
    <meta charset="UTF-8">
    <title>卖家管理界面</title>
</head>
<style type="text/css">
    .tabpan-ul{
        margin-left: 500px;
        display: inline-block;
        list-style: none;
        margin-top: 50px;

    }
    .tabpan-ul .tabpan-li{
        float: left;
    }
    .tabpan-li a{
        padding:20px;
        text-decoration: none;
        font-size: 22px;
    }


    .activeA{
        background:black;
        color:white;
    }

    .disActiveA {
        background: #e7e7e7;
        color:black;
    }
</style>
<script>
    $(document).ready(function () {
            $("#a1").click(function () {
                if($(this).attr("class")==="disActiveA"){
                    $("#a2").attr("class","disActiveA");
                    $("#a3").attr("class","disActiveA");
                    $(this).attr("class","activeA");
                }

            });

            $("#a2").click(function () {
                if($(this).attr("class")==="disActiveA"){
                    $("#a1").attr("class","disActiveA");
                    $("#a3").attr("class","disActiveA");
                    $(this).attr("class","activeA");
                }
            });
            $("#a3").click(function () {
                if($(this).attr("class")==="disActiveA"){
                    $("#a1").attr("class","disActiveA");
                    $("#a2").attr("class","disActiveA");
                    $(this).attr("class","activeA");
                }
            });
        }
    );

    //修改价格
    function revisePrice(i){
        $("#goodsName").val(optionJson[i].goodsName);
        $("#goodsId").val(optionJson[i].goodsId);
        $("#primitivePrice").val(optionJson[i].price);
        $("#reviseGoodsModel").modal();
    }

    //提交修改后的价格
    function submitRevisePrice(){
        var price=$("#price").val();
        if(parseInt(price)>0){
            $.ajax({
                url:"/merchant/updateGoodsPrice",
                type:"POST",
                data:{
                    goodsId:$("#goodsId").val(),
                    price:price,
                    oldPrice:$("#primitivePrice").val()
                },
                dataType:"json"
            }).done(function(data){
                alert(data.msg);
                qeuryGoods();
            });

        }else{
            alert("价格必须大于0")
        }
        return false;
    }
        //检查店铺信息
        function oncheck() {
        var shopName=document.getElementById("shopName");
        var addr=document.getElementById("addr");
            if(shopName.value.length<=0){
                alert("店铺名字不得为空!");
                return false;
            }

        if(addr.value.length<=0){
            alert("店铺地址不得为空!");
            return false;
        }

        return true;
    }



    //提交店铺更新
    function subimtBtn() {
       if(oncheck()){
        $("#subForm").ajaxSubmit({
            type: "POST",
            url: "/merchant/updateShopInfo",
            data:{
                merchantId:${sessionScope.userInfo.id}
            },

            dataType: "json",
            success:function (data) {
                alert(data.msg);
                if(data.shopName!="") {
                    $("#shopName").val(data.shopName);
                }
                if(data.addr!="") {
                    $("#addr").val(data.addr);
                }
                if(data.shopLogo!="") {
                    $("#imgId").attr("src",data.shopLogo);
                }
                for(var key in data) {

                    if(key === "shopNameError"){
                        $("#shopNameError").html(data[key]);
                    }
                    if(key === "addrError"){
                        $("#addrError").html(data[key]);
                    }
                }
            }
        });
       }
        return false;
    }

    optionJson=[];
    //获取所有货物列表
    function qeuryGoods(){

        $.ajax({
            url:"/merchant/queryAllGoods",
            type:"POST",
            data:{
                merchantId:${sessionScope.userInfo.id}
            },
            dataType:"json"
        }).done(function(data){
            optionJson=data;
            var str="";
                for(var i=0;i<optionJson.length;i++){
                   str+="<div class=\"col-sm-4 col-md-3\">\n" +
                       "                    <div class=\"thumbnail\">\n" +
                       "                        <img src=\""+optionJson[i].imgDir+"\" style=\"width: 134px;height: 180px\" alt=\"商品土坯an\" class=\"tab_img\">\n" +
                       "                        <div class=\"caption\">\n" +
                       "                            <h4 class=\"tab_content text-center\" style='font-size: 18px;height:20px;overflow: hidden'>"+optionJson[i].goodsName+"</h4>\n" +
                       "                            <p><span style=\"color:#f40;overflow:hidden;font-size: 18px;margin-left: 90px;height: 20px;\">￥"+optionJson[i].price+"</span></p>\n" +
                       "                            <p class='text-center'><a href=\"#\" onclick=\"revisePrice("+i+")\" class=\"btn btn-primary\" role=\"button\">调整价位</a>\n" +
                       "                                <a onclick=\"downGoods("+i+")\" class=\"btn  btn-success\"  role=\"button\">下架货物</a>\n" +
                       "                            </p>\n" +
                       "                        </div>\n" +
                       "                    </div>\n" +
                       "                </div>"
                }
                document.getElementById("goodsList").innerHTML=str;

            }
        );
    }

    function checkUpGoods() {
        var up_img=document.getElementById("up_img")
        var up_goodsName=document.getElementById("up_goodsName");
        var up_price=document.getElementById("up_price");
        var up_addr=document.getElementById("up_addr");
        var up_detail=document.getElementById("up_detail");
        var up_remainNumber=document.getElementById("up_remainNumber");
        var up_type=document.getElementById("up_type");
        if(up_detail.value=="" || up_detail.value.trim()==null || up_detail.value.length<10){
            alert("商品描述信息不得为空,且至少10个字！");
            return false;
        }
        if(up_img.value==""){
            alert("请选择一张商品图片！");
            return false;
        }
        if(up_goodsName.value=="" || up_goodsName.value.trim()==null){
            alert("商品名称不得为空！");
            return false;
        }
        if(up_type.value=="" || up_type.value.trim()==null){
            alert("请选择商品类型！");
            return false;
        }
        if(up_addr.value=="" || up_addr.value.trim()==null){
            alert("卖家发货地址不得为空！");
            return false;
        }
        if(parseInt(up_price.value)<=0){
            alert("货物价格要大于0！");
            return false;
        }
        if(parseInt(up_remainNumber.value)<=0){
            alert("货物库存要大于0！");
            return false;
        }
        return true;
    }

    //上架货物
    function upGoods(){
        if(checkUpGoods()){
            $("#upGoodsForm").ajaxSubmit({
                    type: "POST",
                    url: "/merchant/upGoods",
                    data:{
                        possesserId:${sessionScope.userInfo.id}
                    },

                    dataType: "json",
                    success:function (data) {
                        alert(data.msg);
                    }
            });
        }
        return false;
    }

    //下架货物
    function downGoods(i) {
        if(confirm("你确定要下架书名为:"+optionJson[i].goodsName+"的书籍吗")){
            $.ajax({
                type: "POST",
                url: "/merchant/downGoods",
                data:{
                    possesserId:${sessionScope.userInfo.id},
                    goodsId:optionJson[i].goodsId
                },

                dataType: "json",
                success:function (data) {
                    alert(data.msg);
                    qeuryGoods();
                }
            });

        }
        return false;
    }


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
                        <li>
                            <a href="#">店铺管理</a>
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
                            <li><a href="#">我的订单</a></li>
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

<section  style="margin-top: 30px;background: #e7e7e7; height: 100px">
    <h1 style="color: black;font-weight: bold;padding:20px;line-height: 20px;display: inline-block;float: left;margin-top: 20px" >卖家管理界面</h1>
    <ul class="tabpan-ul" role="tablist" >
        <li  role="presentation" class="active tabpan-li"><a href="#shopInfo" id="a1" class="activeA" aria-controls="home" role="tab" data-toggle="tab">店铺信息</a></li>
        <li role="presentation" onclick="qeuryGoods()" class="tabpan-li"><a href="#goodsInfo"   id="a2"  class="disActiveA" aria-controls="profile" role="tab" data-toggle="tab">货物信息</a></li>
        <li role="presentation" class="tabpan-li"><a href="#upgoods"  id="a3"  class="disActiveA" aria-controls="profile" role="tab" data-toggle="tab">上架货物</a></li>
    </ul>
</section>

<!--具体操作-->
<section style="margin-top: 20px;margin-left: -23px;margin-bottom: 200px;" class="container-fluid">
    <div class="tab-content" style="margin-left: 40px;margin-top: 20px">
        <!--修改信息-->
        <div role="tabpanel" class="tab-pane fade in active" id="shopInfo" style="padding-left: 150px">
           <sf:form method="post"   commandName="merchantShop" enctype="multipart/form-data" name="updateShopForm" id="subForm">
                <div class="row">
                    <span style="color:#3B3B3B;font-size: 22px; font-weight: bold;margin-right: 20px">店铺名称:</span>
                    <sf:input type="text" id="shopName" maxlength="120" size="50" path="shopName" style="height: 40px;padding:20px;font-size: 21px"/>
                    <span name="shopNameError" id="shopNameError" style="color: red"></span>
                </div>
                <div class="row" style="margin-top: 20px">
                    <span style="color:#3B3B3B;font-size: 22px; margin-right: 20px; font-weight: bold" >店铺头像:</span>
                    <img id="imgId" src="${merchantShop.shopLogo}" width="100px" height="100px">
                    <input type="file" value="更换头像" name="picture" id="picture"  style="display:inline-block;" class="btn-primary">
                </div>
                <div class="row" style="margin-top: 20px">
                    <span style="color:#3B3B3B;font-size: 22px;margin-right: 20px; font-weight: bold">店铺地址:</span>
                    <sf:input type="text" path="addr"  id="addr"  maxlength="120" size="50"  style="height: 40px;padding:20px;font-size: 21px" />
                    <span name="addrError" id="addrError" style="color: red"></span>
                </div>
                <div class="row" style="margin-top: 20px">
                    <button  class="btn btn-success btn-lg col-md-5 col-md-offset-2"  onclick="subimtBtn()">提交</button>
                </div>
           </sf:form>

        </div>

<%--        货物列表--%>
        <div role="tabpanel" class="tab-pane fade" id="goodsInfo">
            <div class="row"  id="goodsList" style="margin-top:30px">
            </div>
        </div>
        <!--上架货物-->
        <div role="tabpanel" class="tab-pane fade" id="upgoods" style="margin-left: 200px">
           <form id="upGoodsForm">
                <div class="row" style="margin-top:15px">
                   <span style="color:#3B3B3B;font-size: 22px; font-weight: bold;margin-right: 20px">货物名称:</span>
                   <input type="text" maxlength="120" size="50" id="up_goodsName" name="goodsName" style="height: 40px;padding:20px;font-size: 21px" >
                </div>
                <div class="row" style="margin-top:15px">
                   <span style="color:#3B3B3B;font-size: 22px; font-weight: bold;margin-right: 20px">发货地址:</span>
                   <input type="text" maxlength="120" size="50" id="up_addr" name="addr" style="height: 40px;padding:20px;font-size: 21px" >
                </div>
                <div class="row" style="margin-top:15px">
                   <span style="color:#3B3B3B;font-size: 22px; font-weight: bold;margin-right: 20px">货物库存:</span>
                   <input type="text" maxlength="120" size="50" id="up_remainNumber" name="remainNumber" style="height: 40px;padding:20px;font-size: 21px" placeholder="货物库存必须大于0" >
                </div>
                <div class="row" style="margin-top:15px">
                   <span style="color:#3B3B3B;font-size: 22px; font-weight: bold;margin-right: 20px">货物价格:</span>
                   <input type="text" maxlength="120" size="50" id="up_price" name="price" style="height: 40px;padding:20px;font-size: 21px" >
                </div>
                <div class="row" style="margin-top:15px">
                   <span style="color:#3B3B3B;font-size: 22px; font-weight: bold;margin-right: 20px">货物详细描述:</span>
                   <input type="text" maxlength="120" size="50" id="up_detail" name="detail" style="height: 40px;padding:20px;font-size: 21px"  placeholder="请输入至少10个字的商品描述信息" >
                </div>

                <div class="row" style="margin-top:15px">
                   <span style="color:#3B3B3B;font-size: 22px;  font-weight: bold;margin-right: 20px">货物类型:</span>
                   <select style="font-size: 22px;padding: 10px;text-align:center;text-align-last:center;" id="up_type" name="type">
                       <option value="">-----</option>
                       <option value="科学技术">科学技术</option>
                       <option value="儿童">儿童</option>
                       <option value="小说">小说</option>
                       <option value="军事历史">军事历史</option>
                       <option value="家庭养生">家庭养生</option>
                       <option value="艺术设计">艺术设计</option>
                       <option value="文学">文学</option>
                   </select>
                </div>

                <div class="row" style="margin-top:15px">
                   <span style="color:#3B3B3B;font-size: 22px; font-weight: bold;margin-right: 20px">货物图片:</span>
                   <input name="img" type="file" id="up_img" style="display: inline-block">
                </div>
                <div class="row" style="margin-top:30px">
                    <button type="button" onclick="upGoods()" class="col-md-4 col-md-offset-2 btn btn-success btn-lg">上架货物</button>
                </div>
           </form>
        </div>
    </div>
</section>
<!--模态框定义-->
<div class="modal fade" id="reviseGoodsModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="reviseGoodsModelLabel">修改价格表单填写</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="goodsId">货物编号</label>
                    <input type="text" disabled="disabled" name="freeze_userId" id="goodsId" class="form-control">
                </div>

                <div class="form-group">
                    <label for="goodsName">货物名称</label>
                    <input type="text"  disabled="disabled"  name="username" id="goodsName" class="form-control">
                </div>
                <div class="form-group">
                    <label for="primitivePrice">原始价格</label>
                    <input type="text"   disabled="disabled" name="primitivePrice" id="primitivePrice" class="form-control">
                </div>
                <div class="form-group">
                    <label for="price">价格调整</label>
                    <input type="text" name="price" id="price" class="form-control">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><span class="" aria-hidden="true"></span>关闭</button>
                <button type="button" id="freeze_submit" class="btn btn-primary" data-dismiss="modal" onclick="submitRevisePrice()"><span class="" aria-hidden="true"></span>确认调整</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>