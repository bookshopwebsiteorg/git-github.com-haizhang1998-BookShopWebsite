<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet">
<!-- jQuery -->
<script src="http://code.jquery.com/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<head>
    <meta charset="UTF-8">
    <title>聊天界面</title>
</head>
<script type="text/javascript">
    // 正在聊天的人的名字
    var talkingNikename;
    // 正在聊天的人的id
    var talkingUserId;
    // 正在聊天人的头像
    var talkingImageLogo;

    $(function(){
        $("#clearBtn").click(function () {
            $("#chatMsg").val("");
        });
        if('WebSocket' in window){
            //连接服务器i
            var path="ws://"+window.location.host+"/ws";
            websocket = new WebSocket(path);
        }
        //下面有几个回调函数，自动调用
        //打开socket
        websocket.onopen = function (event) {
            //握手成功，会自动调用该函数,同时更新上线和离线列表
            console.log("hand suc:",event);
        };
        //监听消息;用来获取服务端传的消息
        websocket.onmessage = function (event) {
            var v=JSON.parse(event.data);
            //初始化时判断所交流的卖家是否在线
            if(v.msgType === 2){
                talkingNikename="\"${singleFriend.friendInfo.nikeName}\"";
                talkingImageLogo="\"${singleFriend.friendInfo.imageLogo}\"";
                talkingUserId=${singleFriend.friendInfo.id}
            }

            if(v.msgType === 0){
                //普通的信息
                appendMsgFromFriend(v);
            }
        };
        //监听Sokcet关闭(不管是客户端还是服务端关闭，都会触发此时间)
        websocket.onclose = function (event) {
            console.log("socketClose",event);
        };
        //监听异常
        websocket.onerror = function (event) {
            console.log("发生错误",event);
        };

        //关闭sokcet(客户端主动关闭socket)
        function closeWebsocket() {
            if(websocket != null){
                websocket.close();
                websocket=null;
            }
        }
    });




    //v是message的json对象
    function appendMsgFromFriend(v) {
        var text=v.text;
        var str="<div class=\"media\" style=\"margin-top: 10px;margin-left: 10px\">\n" +
            "                <div class=\"media-left\">\n" +
            "                <a href=\"#\">\n" +
            "                   <img class=\"media-object\" style=\"width: 30px;height: 30px;\" src="+talkingImageLogo+" >\n" +
            "                </a>\n" +
            "                </div>\n" +
            "                <div class=\"media-body\">\n" +
            "                <h6 class=\"media-heading text-muted\">"+talkingNikename+"</h6>\n" +
            "                <p style=\"font-size: 20px\">"+text+"</p>\n" +
            "                </div>\n" +
            "                </div>";
        $("#msgBox").append(str);
    }



    //发送消息
    function  sendMsg() {
        //检测是否已经连接到服务器
        if(websocket == null){
            alert("连接已被断开，请重新登入!");
            return;
        }
        var m = document.getElementById("chatMsg").value;
        if (m === "") {
            alert("请输入信息！");
            return;
        }
        var data={};
        //Json格式,键值对
        data["from"]=${sessionScope.userInfo.id};
        //发送给谁(id) -1代表全体好友
        data["to"]=parseInt(talkingUserId);
        //文本内容
        data["text"]=m;
        //发送人的昵称
        data["fromName"]="\"${sessionScope.userInfo.nikeName}\"";
        //发送消息
        websocket.send(JSON.stringify(data));
        //添加自己发送的内容
        var str="    <div class=\"media\" style=\"margin-top:10px;margin-right:10px;\">\n" +
            "                    <div class=\"media-body\">\n" +
            "                        <h6 style=\"float: right\" class=\"media-heading text-muted\">${sessionScope.userInfo.nikeName}</h6>\n"+
            "                        <p  style=\"float:right;font-size: 20px;margin-top: 5px\" >"+m+"</p>\n" +
            "                    </div>\n" +
            "                    <div class=\"media-right\">\n" +
            "                        <a href=\"#\">\n" +
            "                            <img class=\"media-object\" style=\"width: 30px;height: 30px;\" src=\"${sessionScope.userInfo.imageLogo}\">\n" +
            "                        </a>\n" +
            "                    </div>\n" +
            "                </div>";
        $("#msgBox").append(str);
        //清空输入区域
        $("#chatMsg").val("");
    }

</script>
<style>
    body{
        background:white;
    }
    a{
        color:#6c6c6c;
    }

</style>
<body>
<section id="navbarSection">
    <nav class="navbar navbar-inverse navbar-fixed-top">
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

                    <li><a href="#">
                    <li>亲，请登录</li>
                    <span class="sr-only">(current)</span></a>
                    </li>

                    <li><a href="#" style="color:white">消息</a></li>
                    <li><a href="#">店铺管理</a></li>
                    <li><a href="#">我要开店</a></li>

                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">信息管理<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="#">收藏夹</a></li>
                            <li><a href="#">我的足迹</a></li>
                            <li><a href="#">我的订单</a></li>

                        </ul>
                    </li>
                </ul>

                <ul class="nav navbar-nav" style="margin-left: 500px">
                    <li><a href="#"><span>购物车<span class="badge" style="margin-left: 5px">0</span></span></a></li>
                    <li><a href="/jsp/information.jsp">个人中心</a></li>
                    <li><a href="#">注销</a></li>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>

</section>

<div id="chatSection" style="margin-top: 70px;margin-bottom: 50px">
    <div class="container">
        <div class="row"  style="padding: 10px ;padding-left: 80px;border: 1px solid #e7e7e7" >
            <div class="media" style="margin-top: 10px">
                <div class="media-left">
                    <a href="#">
                        <img class="media-object" style="width: 50px;height: 50px;" src="${singleFriend.friendInfo.imageLogo}">
                    </a>
                </div>
                <div class="media-body">
                    <h4 class="media-heading text-muted">${singleFriend.friendInfo.nikeName}</h4>
                    <p style="font-size: 18px">${singleFriend.friendInfo.addr}</p>
                </div>
            </div>
        </div>

        <div class="row">
            <div id="msgBox" style="height: 600px;margin-top: 10px;border: 1px solid #e7e7e7;overflow-y: auto" >
            </div>
        </div>

        <div class="row">
            <div id="editBox">
                <textarea id="chatMsg" style="margin-top: 10px;color:black;font-size: 17px;border: 1px solid #e7e7e7;padding: 10px" autofocus="autofocus" cols="147" rows="6" placeholder="在此处输入消息"></textarea>
                <div>
                    <button type="button" class= "btn btn-success btn-md text-center col-md-offset-9"  id="clearBtn" style="width: 100px">清空消息</button>
                    <button type="button" class="btn btn-primary btn-md text-center" onclick="sendMsg()" style="width: 100px">发送消息</button>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
