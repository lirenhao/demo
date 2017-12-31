<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String basePath = request.getContextPath();
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title></title>
    <jsp:include page="../base_pages/commons/base-css.jsp"/>
</head>
<body id="login-page" class="theme-whbl" style="">
<div class="container">
    <div class="row">
        <div class="col-xs-12">
            <div id="login-box">
                <div id="login-box-holder">
                    <div class="row">
                        <div class="col-xs-12">
                            <header id="login-header">
                                <div id="login-logo">
                                    <img src="<%=basePath%>/img/logo.png" alt="">
                                </div>
                            </header>
                            <div id="login-box-inner">
                                <form role="form" action="<%=basePath%>/login/validate" method="post"
                                      onsubmit="return validate()">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-user"></i></span>
                                        <input class="form-control" type="text" placeholder="登录名" name="loginName">
                                    </div>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-key"></i></span>
                                        <input type="password" class="form-control" placeholder="密码" name="pwd" id="password">
                                    </div>
                                    <div id="remember-me-wrapper">
                                        <div class="row">
                                            <input type='text' name='randomcode' size='4' maxlength="4"
                                                   style="width: 100px;background-color: rgb(250, 255, 189)"/>
                                            <img type="image" src="<%=basePath%>/login/getAuthCode" id="codeImage" onclick="location.reload('<%=basePath%>/login/getAuthCode')"
                                                 title="图片看不清？点击重新得到验证码" style="cursor:pointer;"/>
                                            <span id="mess" style="color: red">${returnMessage }</span>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <button type="submit" class="btn btn-success col-xs-12">登 &nbsp; &nbsp; 录</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="login-box-footer">
                    <div class="row">
                        <div class="col-xs-12">
                            <%--Do not have an account?--%>
                            <%--<a href="registration.html">--%>
                                <%--Register now--%>
                            <%--</a>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../base_pages/commons/base-js.jsp"/>
<script>
    function validate() {
        var name = $("input[name='loginName']").val();
        var pwd = $("#password").val();
        if (name == '') {
            $("#mess").text("请输入用户名!");
            return false;
        }
        if (pwd == '') {
            $("#mess").text("请输入密码!");
            return false;
        }
    }
</script>

</body>
</html>
