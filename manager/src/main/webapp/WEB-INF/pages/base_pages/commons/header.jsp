<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getContextPath();
%>
<header class="navbar" id="header-navbar">
    <div class="container">
        <a href="javascript:void(0);" target="iframePage" id="logo" class="navbar-brand">
            <img src="<%=basePath%>/img/logo.png" alt="" class="normal-logo logo-white"/>
            <img src="<%=basePath%>/img/logo-black.png" alt="" class="normal-logo logo-black"/>
            <img src="<%=basePath%>/img/logo-small.png" alt="" class="small-logo hidden-xs hidden-sm hidden"/>
        </a>
        <div class="clearfix">
            <button class="navbar-toggle" data-target=".navbar-ex1-collapse" data-toggle="collapse" type="button">
                <span class="sr-only">Toggle navigation</span>
                <span class="fa fa-bars"></span>
            </button>
            <div class="nav-no-collapse navbar-left pull-left hidden-sm hidden-xs">
                <ul class="nav navbar-nav pull-left">
                    <li>
                        <a class="btn" id="make-small-nav">
                            <i class="fa fa-bars"></i>
                        </a>
                    </li>
                </ul>
            </div>
            <div class="nav-no-collapse pull-right" id="header-nav">
                <ul class="nav navbar-nav pull-right">
                    <li class="dropdown profile-dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <img src="<%=basePath%>/img/samples/user.jpg" alt=""/>
                            <span class="hidden-xs">${user.loginName}</span>
                            <b class="caret"></b>
                        </a>
                        <ul class="dropdown-menu">
                            <li>
                                <a class="table-link" data-target="#myModal" data-toggle="modal"
                                   href="<%=basePath%>/user/updateUserPwd?userId=${user.userId}">
                                    <i class="fa fa-lock"></i>修改密码</a>
                            </li>
                            <li>
                                <a href="javascript:void(0);"
                                   onclick="logoutClick('您确定要退出登录吗？', '<%=basePath%>/login/logout')">
                                    <i class="fa fa-power-off"></i>退出登录</a>
                            </li>
                        </ul>
                    </li>
                    <%--<li class="hidden-xxs">--%>
                        <%--<a class="btn">--%>
                            <%--<i class="fa fa-power-off"></i>--%>
                        <%--</a>--%>
                    <%--</li>--%>
                </ul>
            </div>
        </div>
    </div>
</header>