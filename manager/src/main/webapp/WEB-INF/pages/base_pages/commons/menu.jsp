<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String basePath = request.getContextPath();
%>
<div id="nav-col">
    <section id="col-left" class="col-left-nano">
        <div id="col-left-inner" class="col-left-nano-content">
            <div id="user-left-box" class="clearfix hidden-sm hidden-xs dropdown profile2-dropdown">
                <img alt="" src="<%=basePath%>/img/samples/user.jpg"/>
                <div class="user-box">
                    <span class="name"
                          style="overflow: hidden;text-overflow: ellipsis;white-space:nowrap;width: 92px;display: inline-block">
                        ${user.userName}
                    </span>
                    <span class="status">
                        <i class="fa fa-circle"></i>Online
                    </span>
                </div>
            </div>
            <div class="collapse navbar-collapse navbar-ex1-collapse" id="sidebar-nav">
                <ul class="nav nav-pills nav-stacked" id="menuList">
                    <li class="nav-header nav-header-first hidden-sm hidden-xs">
                        Navigation
                    </li>
                    <c:forEach items="${menus}" var="menu">
                        <li id="menuItem">
                            <a href="#" class="dropdown-toggle">
                                <%--<i class="fa fa-desktop"></i>--%>
                                    <i class="${menu.icon}"></i>
                                <span>${menu.name}</span>
                                <i class="fa fa-angle-right drop-icon"></i>
                            </a>
                            <ul class="submenu">
                                <c:forEach items="${menu.children}" var="submenu">
                                    <li style="cursor: hand">
                                        <a onclick="menuClick(this);$('#page').load('<%=basePath%>${submenu.action}');">
                                                ${submenu.name}
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </section>
    <div id="nav-col-submenu"></div>
</div>
<script>
    /**
     * 点击菜单后样式处理
     */
    function menuClick(e) {
        $('#menuList').find('.active').removeClass('active');
        $(e).closest('#menuItem').addClass('active');
        $(e).addClass('active');
    }
</script>