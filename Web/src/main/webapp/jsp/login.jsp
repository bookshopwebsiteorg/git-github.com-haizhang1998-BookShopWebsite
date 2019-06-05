<%--
  Created by IntelliJ IDEA.
  User: 咯还长
  Date: 2019/3/30
  Time: 17:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="用户名" uri="http://www.springframework.org/tags/form" %>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet">
<!-- jQuery -->
<script src="http://code.jquery.com/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

<link rel="stylesheet" type="text/css" href="../static/css/login.css">

<head>
    <title>登录界面</title>
</head>
<style>

    body{
        background: floralwhite;
        padding-left:5px;
        padding-top:5px;
        font-family: 微软雅黑;
    }
    .input1{
        width: 240px;
        font-size: 14px;
        line-height: 18px;
        height: 30px;
        padding-left:5px;
        border: 1px solid #ddd;
    }

    #loginDiv{
        position: absolute;
        margin:0 auto ;
        left: 40%;
        top:25%;
    }

    #mentionP{
        margin:30px auto;
        background: cornsilk;
        font-size:16px;
        height:20px;
        padding: 3px 5px;
        width:860px;
        color: darkgrey;
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
    }
    #mentionP:hover{
        width:1100px;
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
        background: #f40;
    }

    span.error{
        color:red;
    }
</style>

<script language="JavaScript">

    function oncheck(){

        var u= document.getElementById("username");
        var p=document.getElementById("password");
        if(u.value=="手机/邮箱/会员名"||p.value==""){
            alert("账号名及密码不能为空！");
            return false;
        }
        return true;
    }


</script>
<body>
<%--<c:if test="${param.js!=null}">--%>
<%--    <script>alert("注销成功！");</script>--%>
<%--</c:if>--%>
<p id="mentionP"> 为确保您账户的安全及正常使用，依《网络安全法》相关要求，6月1日起会员账户需绑定手机。如您还未绑定，请尽快完成，感谢您的理解及支持！</p>
<div id="loginDiv">

    <c:if test="${freeze_state!=null}">
        <script>alert("账户已冻结，若需解冻请与管理员联系!")</script>
    </c:if>

    <c:if test="${reg_state!=null}">
        <script>alert("注册成功!请登录")</script>
    </c:if>
    <c:if test="${logout_state!=null}">
        <script>alert("注销成功！")</script>
    </c:if>

    <h1 style="color: black">会员登录界面</h1>
    <!--如果登录失败，则打印失败信息-->

    <c:if test="${state!=null}">
        <p style="color: red"><em style="font-size: 18px;font-style: normal">
                ${state}
        </em></p>
    </c:if>




    <sf:form action="/user/login" method="post" commandName="userInfo" onsubmit="return oncheck()">

<%--        <sf:errors path="*" element="div" cssClass="error-font"></sf:errors>--%>
        <table border="0" style="text-align:center">
            <tr>
                <td>用户名:</td>
                <td><sf:input type="text"  class="input1" path="username" name="username" placeholder="手机/邮箱/会员名"   size="15"/></td>
            </tr>
            <tr>
                <td>密码:</td>
                <td><sf:input type="password" class="input1" path="password" size="15" name="password" /></td>
            </tr>
            <tr>

                <td colspan="2" align="right"><input type="checkbox" name="autoLogin" value="autoLogin"/>自动登陆</td>
            </tr>

            <tr>
                <td colspan="2" align="center"><input type="submit" name="btn_longin"  class="btn" value="登录"/>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center"><input type="button" class="btn" onclick="window.location.href='/user/regist'" name="btn_reg" value="注册用户" />
                </td>
            </tr>

        </table>

    </sf:form>
</div>

</body>
</html>
