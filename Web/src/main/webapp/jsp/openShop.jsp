<%--
  Created by IntelliJ IDEA.
  User: 咯还长
  Date: 2018/11/12
  Time: 22:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script src="js/jquery-3.2.1.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<!--<script src="js/homePage.js"></script>-->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet">
<!-- jQuery -->
<script src="http://code.jquery.com/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

<html>
<head>
    <title>店铺信息填写</title>

    <style>
        *{
            padding:0;
            margin:0;
        }

        a{
            text-decoration: none;
            color: #6c6c6c;
            cursor: pointer;
        }


        .btn{
            width: 300px;
            height: 42px;
            border-radius: 3px;
            margin-top: 20px;
            border: 0;
            color: #fff;
            display: inline-block;
            overflow: hidden;
            cursor: pointer;
            zoom: 1;
            font-size: 20px;
            font-weight: bold;
            background: #f40;
            margin-left: 100px;
        }

        #wrapper-middle{
            border:1px;
            padding-top:50px;
            padding-left:350px;
            margin-bottom: 100px;

        }

        .importent {
            height:40px;
            width:120px;
            font-size:20px;
            line-height: 40px;
            text-align: left;
        }

              .attribute{
            height:40px;
            width:400px;
            font-size:20px;
            line-height: 40px;
        }

        #top-tag{
            margin-top:55px;
            width: 100%;
            height: 80px;
            background-color: #ff4400;
        }

        .tag{
            font-size:35px;
            margin-left: 85px;
            display: inline-block;
            margin-top: 10px;
            color: white;
        }

        .shopImg{
            width:150px;
            height: 150px;
            border: 1px dotted #e5e5e5;
            display: inline-block;
        }

        #tb>tr{
            margin-top: 20px;
        }
    </style>

    <script type="text/javascript" language="JavaScript">

        function onchangImg() {
            var a=$("#file-id").val();
            alert(a);
            $("#img-id").attr("src",a);
        }

        function submitInfo() {

            var shopname=document.getElementById("reg_shopname");
            var addr=document.getElementById("addr");
            if (shopname.value==""||addr.value==""){
                alert("请完善所有的信息!")
                return false;
            }

return true;

        }

    </script>

</head>
<body background-color>
<!-- 导航栏div -->
<section id="navbarSection">
    <nav id="nav-head" class="navbar navbar-default navbar-fixed-top">
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
                    <li><a href="#">店铺管理</a></li>
                    <li><a href="#">我要开店</a></li>

                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">信息管理<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="#">收藏夹</a></li>
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

<div id="top-tag">
    <label class="tag">图书商城商家注册</label>
</div>

<div id="wrapper-middle">
 <sf:form action="/user/registShop" commandName="requestRecordShop" method="post" enctype="multipart/form-data">
        <table id="tb" bgcolor="#fffaf0" cellspacing="8" border="0" style="text-align:left">
            <tr>
                <td><p class="importent">店铺名:</p></td>
                <td><sf:input type="text" id="reg_shopname" path="shopName" class="attribute" size="15"/></td>
            </tr>
            <tr>
                <td><p class="importent">发货地址:</p></td>
                <td><sf:input type="text" id="addr" path="addr" class="attribute" maxlength="99" size="11" /></td>
            </tr>

            <tr>
                <td><p class="importent" >店铺图标:</p></td>
                <td><input id="file-id" type="file"  name=" profilePicture" class="attribute" size="11" value="选择图片"></td>
            </tr>
            <tr>
                <td><p class="importent"></p></td>
                <td><img class="shopImg" src="/images/shopImage/defaultShopImag.jpg" id="img-id"/></td>
            </tr>

            <tr>
                <td><p class="importent">申请描述:</p></td>
                <td><sf:textarea type="text" id="detail" cols="105" rows="6" cssStyle="margin-top: 20px;height: 120px;padding: 10px;" path="detail" class="attribute" placeholder="请输入5到100字之间的描述申请信息" maxlength="100" size="11" /></td>
               <td><sf:errors path="detail" cssStyle="color:red"></sf:errors></td>
            </tr>
        </table>
     <input type="submit" name="btn_reg" class="btn" value="完成注册" /></td>
 </sf:form>

</div>
</body>
</html>
