<%--suppress ALL --%>
<%--suppress ALL --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String basePath = request.getContextPath();
%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="row">
    <div class="col-lg-12">
        <div class="row">
            <div class="col-lg-12">
                <ol class="breadcrumb">
                    <li>字典管理</li>
                    <li class="active"><span>资源管理</span></li>
                </ol>
                <h1>Tables
                    <small>Secondary headline</small>
                </h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-6">
                <div class="main-box clearfix">
                    <header class="main-box-header clearfix">
                        <h2 class="pull-left">菜单资源</h2>
                        <div class="icon-box pull-right">
                            <a href="javascript:void(0);" onclick="saveSort()" class="btn pull-left">
                                <i class="fa fa-save"></i>
                            </a>
                            <a data-toggle="modal" data-target="#myModal" class="btn pull-left"
                               href="<%=basePath%>/res/create?type=menu">
                                <i class="fa fa-plus"></i>
                            </a>
                        </div>
                    </header>
                    <div class="main-box-body clearfix">
                        <div id="menuNestable" class="dd" style="width:100%;">
                            <jsp:include page="menu.jsp"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="main-box clearfix">
                    <header class="main-box-header clearfix">
                        <h2 class="pull-left">URL资源</h2>
                        <div class="icon-box pull-right">
                            <a href="#" class="btn pull-left">
                                <i class="fa fa-save"></i>
                            </a>
                            <a data-toggle="modal" data-target="#myModal" class="btn pull-left"
                               href="<%=basePath%>/res/create?type=url">
                                <i class="fa fa-plus"></i>
                            </a>
                        </div>
                    </header>
                    <div class="main-box-body clearfix">
                        <div id="urlNestable" class="dd" style="width:100%;">
                            <jsp:include page="url.jsp"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $('#menuNestable').nestable();
    $('#urlNestable').nestable();

    function saveSort() {
        var menu = $('#menuNestable').nestable('serialize');
        for (var i = 0; i < menu.length; i++) {
            menu[i].orderId = i;
            if (menu[i].children) {
                console.log(menu[i])
                for (var j = 0; j < menu[i].children.length; j++) {
                    menu[i].children[j].orderId = j;
                }
            }
        }
        var url = $('#urlNestable').nestable('serialize');
        for (var i = 0; i < url.length; i++) {
            url[i].orderId = i;
            if (url[i].children) {
                for (var j = 0; j < url[i].children.length; j++) {
                    url[i].children[j].orderId = j;
                }
            }
        }
        var data = {
            menu: JSON.stringify(menu),
            url: JSON.stringify(url)
        };
        $('#page').load('<%=basePath%>/res/sort', data);
    }
</script>
</body>
</html>
