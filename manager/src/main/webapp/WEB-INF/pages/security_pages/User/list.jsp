<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="mytag" %>
<%
    String basePath = request.getContextPath();
%>
<html>
<head>
    <title>用户管理</title>
</head>
<body>
<div class="row">
    <div class="col-lg-12">
        <div class="row">
            <div class="col-lg-12">
                <ol class="breadcrumb">
                    <li>当前位置:<span>权限管理</span></li>
                    <li class="active"><span>用户管理</span></li>
                </ol>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="main-box clearfix">
                    <header class="main-box-header clearfix">
                        <h2 class="pull-left">用户列表</h2>
                    </header>
                    <div class="main-box-body clearfix">
                        <div class="row main-box-body">
                            <form id="form">
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="row">
                                            <div class="from-group col-md-12">
                                                <label for="loginName">登录名称</label>
                                                <input type="text" class="form-control" id="loginName" name="loginName"
                                                       value="${query.loginName}">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="row">
                                            <div class="from-group col-md-12">
                                                <label>用户状态</label>
                                                <mytag:select styleClass="form-control" dictName="USER_STATUS" name="status"
                                                              id="user_status"></mytag:select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="filter-block pull-right">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fa fa-search fa-lg"></i>&nbsp;&nbsp;查询
                                    </button>
                                    <a data-toggle="modal" href="<%=basePath%>/user/insert" data-target="#myModal"
                                       class="btn btn-primary">
                                        <i class="fa fa-plus-circle fa-lg"></i>&nbsp;&nbsp;新增
                                    </a>
                                </div>
                            </form>
                        </div>
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th class="text-center">
                                        <span>登录名称</span>
                                    </th>
                                    <th class="text-center">
                                        <span>用户名称</span>
                                    </th>
                                    <th class="text-center">
                                        <span>用户状态</span>
                                    </th>
                                    <th class="text-center">
                                        <span>创建日期</span>
                                    </th>
                                    <th class="text-center" style="width: 35%">
                                        <span>操作</span>
                                    </th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${page.getNumberOfElements() > 0}">
                                        <c:forEach items="${page.getContent()}" var="item">
                                            <tr>
                                                <td class="text-center">${item.loginName}</td>
                                                <td class="text-center">${item.userName}</td>
                                                <td class="text-center">
                                                    <mytag:write dictName="USER_STATUS"
                                                                 value="${item.status}"></mytag:write>
                                                </td>
                                                <td class="text-center">${item.createDate}</td>
                                                <td class="text-center">
                                                    <c:if test="${item.status eq '0'}">
                                                        <a class="table-link"
                                                           href="javascript:void(0);"
                                                           onclick="deleteClick('您确定要开启${item.loginName}吗？', '<%=basePath%>/user/openUser?id=${item.id}')">
                                                            开启用户
                                                        </a>
                                                    </c:if>
                                                    <c:if test="${item.status eq '1'}">
                                                        <a class="table-link danger"
                                                           href="javascript:void(0);"
                                                           onclick="deleteClick('您确定要关闭${item.loginName}吗？', '<%=basePath%>/user/closeUser?id=${item.id}')">
                                                            关闭用户
                                                        </a>
                                                    </c:if>
                                                    <a data-toggle="modal"
                                                       href="<%=basePath%>/user/role?id=${item.id}"
                                                       data-target="#myModal" class="table-link">
                                                        分配角色
                                                    </a>
                                                    <a class="table-link"
                                                       href="javascript:void(0);"
                                                       onclick="deleteClick('您确定要重置${item.loginName}的密码吗？,重置密码后密码为：“111111”。', '<%=basePath%>/user/resetUserPwd?userId=${item.id}')">
                                                        重置密码
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td>没有数据</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                            </table>
                        </div>
                        <div class="row pull-right">
                            <div id="pageText"></div>
                            <div id="paging" class="pagination"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    // 查询数据
    var data = {};
    data.loginName = '${query.loginName}';
    data.status = '${query.status}';
    data.size = ${page.getSize()};
    data.page = ${page.getNumber()};
    // 排序数据
    var sortStr = '';
    var sorts = '${page.getSort()}'.split(',');
    $.each(sorts, function (i, field) {
        if (field !== '')
            sortStr = sortStr + '&sort=' + field.replace(': ', ',');
    });
    // 查询表单提交
    $("#form").validate({
        submitHandler: function (form) {
            $.each($(form).serializeArray(), function (i, field) {
                data[field.name] = field.value;
            });
            data.page = 0;
            $('#page').load('<%=basePath%>/user/list?', data);
        }
    });
    // 分页控件
    $('#paging').jqPaginator({
        totalCounts: ${page.getTotalElements()},
        currentPage: ${page.getNumber()} +1,
        pageSize: ${page.getSize()},
        visiblePages: 5, // 最多展示几个分页数
        first: '<li><a href="javascript:void(0);">«</a></li>',
        prev: '<li><a href="javascript:void(0);">‹</a></li>',
        next: '<li><a href="javascript:void(0);">›</a></li>',
        last: '<li><a href="javascript:void(0);">»</a></li>',
        page: '<li><a href="javascript:void(0);">{{page}}</a></li>',
        onPageChange: function (num, type) {
            $('#pageText').html('当前第' + num + '页，' + '总共' + ${page.getTotalPages()} +'页');
            if (type === 'change') {
                data.page = num - 1;
                $('#page').load('<%=basePath%>/user/list?' + sortStr, data)
            }
        }
    });
</script>
</body>
</html>
