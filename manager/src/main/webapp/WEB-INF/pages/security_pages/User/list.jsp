<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="mytag"%>
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
                        <h2 class="pull-left">查询</h2>
                    </header>
                    <div class="main-box-body clearfix">
                        <div class="row main-box-body">
                            <form id="form">
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="row">
                                            <div class="from-group col-md-12">
                                                <label for="user_list_search_orgName">机&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;构:</label>
                                                <select path="s_lowerOrgId" id="user_list_search_orgName" name="orgId"
                                                        onchange="addUserGrpOption(this.value);">
                                                    <option value="">--请选择--</option>
                                                    <c:forEach items="${orgList}" var="orgItem">
                                                        <option value="${orgItem.orgId}"
                                                                <c:if test="${orgItem.orgId eq query.orgId}">selected</c:if>>
                                                                ${orgItem.name}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="row">
                                            <div class="from-group col-md-12">
                                                <label for="user_list_search_userGrpName">用户分组:
                                                </label>
                                                <select path="s_lowerOrgId" id="user_list_search_userGrpName"
                                                        name="userGrpId">
                                                    <option value="">--请选择--</option>
                                                    <%--<c:forEach items="userGrpList" var="userGrpItem">--%>
                                                    <%--<option value="${userGrpItem.userGrpId}">${userGrpItem.userGrpName}</option>--%>
                                                    <%--</c:forEach>--%>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="row">
                                            <div class="from-group col-md-12">
                                                <label for="user_list_search_userLoginName">用户登录名:
                                                </label>
                                                <input type="text" id="user_list_search_userLoginName" name="loginName"
                                                       value="${query.loginName}">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="row">
                                            <div class="from-group col-md-12">
                                                <%--<label for="user_list_search_status">状态:--%>
                                                <%--</label>--%>
                                                <%--<select path="s_lowerOrgId" id="user_list_search_status" name="status">--%>
                                                    <%--<option value="">--请选择--</option>--%>
                                                    <%--<c:if test="${query ne null&&query.status ne null}">--%>
                                                        <%--<option value="0"--%>
                                                                <%--<c:if test="${'0' eq query.status}">selected</c:if> >--%>
                                                            <%--停用--%>
                                                        <%--</option>--%>
                                                        <%--<option value="1"--%>
                                                                <%--<c:if test="${'1' eq query.status}">selected</c:if>>--%>
                                                            <%--启用--%>
                                                        <%--</option>--%>
                                                    <%--</c:if>--%>
                                                    <%--<c:if test="${query eq null||query.status eq null}">--%>
                                                        <%--<option value="0">--%>
                                                            <%--停用--%>
                                                        <%--</option>--%>
                                                        <%--<option value="1">--%>
                                                            <%--启用--%>
                                                        <%--</option>--%>
                                                    <%--</c:if>--%>
                                                <%--</select>--%>
                                                    <label >状&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;态:</label>
                                                    <mytag:select dictName="D_USER_STATUS" name="status" id="user_list_search_status"></mytag:select>
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
                                        <span>机构</span>
                                    </th>
                                    <th class="text-center">
                                        <span>用户分组</span>
                                    </th>
                                    </th>
                                    <th class="text-center">
                                        <span>用户登录名</span>
                                    </th>
                                    <th class="text-center">
                                        <span>最后登录IP</span>
                                    </th>
                                    <th class="text-center">
                                        <span>状&nbsp;&nbsp;态</span>
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
                                                <td class="text-center">${item.org.name}</td>
                                                <td class="text-center">${item.userGrp.name}</td>
                                                <td class="text-center">${item.loginName}</td>
                                                <td class="text-center">${item.lastLoginIpAddr}</td>
                                                <td class="text-center">
                                                    <mytag:write dictName="D_USER_STATUS" value="${item.status}"></mytag:write>
                                                    <%--<c:if test="${'0' eq item.status}">停用</c:if>--%>
                                                    <%--<c:if test="${'1' eq item.status}">启用</c:if>--%>
                                                </td>
                                                <td style="width: 20%;">
                                                    <a data-toggle="modal"
                                                       href="<%=basePath%>/user/show?userId=${item.userId}"
                                                       data-target="#myModal" class="table-link">
                                                                查看
                                                    </a>
                                                    <c:if test="${item.status eq '0'}">
                                                        <a class="table-link"
                                                           href="javascript:void(0);"
                                                           onclick="deleteClick('您确定要开启${item.loginName}吗？', '<%=basePath%>/user/openUser?userId=${item.userId}')">
                                                                    开启用户
                                                        </a>
                                                    </c:if>
                                                    <c:if test="${item.status eq '1'}">
                                                        <a class="table-link danger"
                                                           href="javascript:void(0);"
                                                           onclick="deleteClick('您确定要关闭${item.loginName}吗？', '<%=basePath%>/user/closeUser?userId=${item.userId}')">
                                                                    关闭用户
                                                        </a>
                                                    </c:if>
                                                    <a class="table-link"
                                                       href="javascript:void(0);"
                                                       onclick="deleteClick('您确定要重置${item.loginName}的密码吗？,重置密码后密码为：“111111”。', '<%=basePath%>/user/resetUserPwd?userId=${item.userId}')">
                                                            重置密码
                                                    </a>
                                                    <a data-toggle="modal"
                                                       href="<%=basePath%>/user/editUserForOrg?userId=${item.userId}"
                                                       data-target="#myModal" class="table-link">
                                                            重分机构
                                                    </a>
                                                    <a data-toggle="modal"
                                                       href="<%=basePath%>/user/assignUserGrp?userId=${item.userId}"
                                                       data-target="#myModal" class="table-link">
                                                            分配分组
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
    data.orgId = '${query.orgId}';
    data.userGrpId = '${query.userGrpId}';
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
    //初始化用户分组
    if(${not empty query.userGrpId || query.userGrpId ne ""}){
        console.log(${query.userGrpId});
        addUserGrpOption("${query.orgId}");
    }

    //根据选择的orgId联动查询用户分组
    function addUserGrpOption(checkOrgId) {
        var userGrpId = '${query.userGrpId}';
        console.log(checkOrgId);
        if (checkOrgId != null && checkOrgId != "") {
            $.ajax({
                url: '<%=basePath%>/user/AJAX_findGrpByOrg',
                type: "post",
                data: {"orgId": checkOrgId},
                dataType: "json",
                success: function (data) {
                    var options = $("#user_list_search_userGrpName");
                    options.empty();
                    options.append("<option value=''>--请选择--</option>")
                    for (var i = 0; i < data.length; i++) {
                        var a=data[i].userGrpId;
                        var option=null;
                        if (a == userGrpId) {
                            option='<option selected value="'+a+'">'+data[i].name+'</option>';
                        } else {
                            option='<option value="'+a+'">'+data[i].name+'</option>';
                        }
                        console.log(option);
                        options.append(option);
                    }
                }
            })
        }
    }

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
