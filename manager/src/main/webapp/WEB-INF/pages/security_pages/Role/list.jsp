<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String basePath = request.getContextPath();
%>
<html>
<head>
    <title>角色查询</title>
</head>
<body>
<div class="row">
    <div class="col-lg-12">
        <div class="row">
            <div class="col-lg-12">
                <ol class="breadcrumb">
                    <li>角色管理</li>
                    <li class="active"><span>角色列表</span></li>
                </ol>
                <h1>Tables
                    <small>Secondary headline</small>
                </h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="main-box clearfix">
                    <header class="main-box-header clearfix">
                        <h2 class="pull-left">角色列表</h2>
                    </header>
                    <div class="main-box-body clearfix">
                        <div class="row main-box-body">
                            <form id="form">
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="row">
                                            <div class="from-group col-md-12">
                                                <label for="name">角色名称</label>
                                                <input type="text" class="form-control" id="name" name="name"
                                                       value="${roleQuery.name}">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="row">
                                            <div class="from-group col-md-12">
                                                <label for="remark">角色描述</label>
                                                <input type="text" class="form-control" id="remark"
                                                       name="remark" value="${roleQuery.remark}">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="filter-block pull-right">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fa fa-search fa-lg"></i>&nbsp;&nbsp;查询
                                    </button>
                                    <a data-toggle="modal" href="<%=basePath%>/role/create" data-target="#myModal"
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
                                        <a class="${page.getSort().getOrderFor('name')}"
                                           href="javascript:void(0);" onclick="sortSearch(this)" sort="name">
                                            <span>角色名称</span>
                                        </a>
                                    </th>
                                    <th class="text-center"><span>角色描述</span></th>
                                    <th>&nbsp;</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${page.getTotalElements() > 0}">
                                        <c:forEach items="${page.getContent()}" var="item">
                                            <tr>
                                                <td class="text-center">${item.name}</td>
                                                <td class="text-center">${item.remark}</td>
                                                <td style="width: 15%;">
                                                    <a data-toggle="modal" data-target="#myModal" class="table-link"
                                                       href="<%=basePath%>/role/edit?id=${item.id}">
                                                        <span class="fa-stack">
                                                            <i class="fa fa-square fa-stack-2x"></i>
                                                            <i class="fa fa-pencil fa-stack-1x fa-inverse"></i>
                                                        </span>
                                                    </a>
                                                    <a data-toggle="modal" data-target="#myModal" class="table-link"
                                                       href="<%=basePath%>/role/permit?id=${item.id}">
                                                        <span class="fa-stack">
                                                            <i class="fa fa-square fa-stack-2x"></i>
                                                            <i class="fa fa-cog fa-stack-1x fa-inverse"></i>
                                                        </span>
                                                    </a>
                                                    <a href="javascript:void(0);" class="table-link danger"
                                                       onclick="deleteClick('${item.name}', '<%=basePath%>/role/delete?id=${item.id}')">
                                                        <span class="fa-stack">
                                                            <i class="fa fa-square fa-stack-2x"></i>
                                                            <i class="fa fa-trash-o fa-stack-1x fa-inverse"></i>
                                                        </span>
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
    data.name = '${roleQuery.name}';
    data.remark = '${roleQuery.remark}';
    data.size = ${page.getSize()};
    data.page = ${page.getNumber()};
    // 排序数据
    var sortStr = '';
    var sorts = '${page.getSort()}'.split(',');
    $.each(sorts, function (i, field) {
        if (field !== '')
            sortStr = sortStr + '&sort=' + field.replace(': ', ',');
    });
    // 排序方法
    function sortSearch(e) {
        if (!$(e).attr('class')) {
            sortStr = sortStr + '&sort=' + $(e).attr('sort') + ',ASC';
        } else if ($(e).attr('class').indexOf('ASC') > 0) {
            sortStr = sortStr.replace($(e).attr('sort') + ',ASC', $(e).attr('sort') + ',DESC');
        } else if ($(e).attr('class').indexOf('DESC') > 0) {
            sortStr = sortStr.replace('&sort=' + $(e).attr('sort') + ',DESC', '');
        }
        $('#page').load('<%=basePath%>/role/list?' + sortStr, data)
    }
    // 查询表单提交
    $("#form").validate({
        submitHandler: function (form) {
            $.each($(form).serializeArray(), function (i, field) {
                data[field.name] = field.value;
            });
            data.page = 0;
            $('#page').load('<%=basePath%>/role/list?' + sortStr, data);
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
                $('#page').load('<%=basePath%>/role/list?' + sortStr, data)
            }
        }
    });
</script>
</body>
</html>
