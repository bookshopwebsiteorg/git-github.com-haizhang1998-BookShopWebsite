<%--
  Created by IntelliJ IDEA.
  User: 71479
  Date: 2019/6/1
  Time: 23:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<br><br>
<hr>
<p style="font-size: 20px">成功提交，该订单所有商品已完成评价，</p>
<a href="/order/queryAllUserOrderByUserId" ><p style="font-size: 25px">三秒后将跳转至订单页面，如未跳转请点击这里。。。</p></a>
<hr>
<%--<%
    response.sendRedirect("/order/queryAllUserOrderByUserId");
%>--%>
<script>
window.setTimeout("window.location='/order/queryAllUserOrderByUserId'",3200);
</script>

</body>
</html>
