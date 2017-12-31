<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String basePath = request.getContextPath();
%>
<html>
<head>
	<title>用户分组管理</title>
</head>
<body>
<div class="row">
	<div class="col-lg-12">
		<div class="row">
			<div class="col-lg-12">
				<ol class="breadcrumb">
					<li>当前位置:<span>权限管理</span></li>
					<li class="active"><span>用户分组管理</span></li>
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
												<label for="userGrp_list_search_orgName">机构:</label>
												<select path="s_lowerOrgId" id="userGrp_list_search_orgName" name="orgId">
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
												<label for="userGrp_list_search_userGrpName">用户分组名称:
												</label>
												<input type="text" id="userGrp_list_search_userGrpName" name="name"
													   value="${query.name}">
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="filter-block pull-right">
										<button type="submit" class="btn btn-primary">
											<i class="fa fa-search fa-lg"></i>&nbsp;&nbsp;查询
										</button>
										<a data-toggle="modal" href="<%=basePath%>/userGrp/insert" data-target="#myModal"
										   class="btn btn-primary">
											<i class="fa fa-plus-circle fa-lg"></i>&nbsp;&nbsp;新增
										</a>
									</div>
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
										<span>用户分组名称</span>
									</th>
									</th>
									<th class="text-center">
										<span>继承标志</span>
									</th>
									<th class="text-center">
										<span>操作</span>
									</th>
								</tr>
								</thead>
								<tbody>
								<c:choose>
									<c:when test="${page.getNumberOfElements() > 0}">
										<c:forEach items="${userGrpList}" var="item">
											<tr>
												<td class="text-center">${item.orgName}</td>
												<td class="text-center">${item.userGrpName}</td>
												<td class="text-center">
													<c:if test="${'0' eq item.ihtFlag}">可继承</c:if>
													<c:if test="${'1' eq item.ihtFlag}">不可继承</c:if>
												</td>
												<td style="width: 15%;">
													<a data-toggle="modal"
													   href="<%=basePath%>/userGrp/role?userGrpId=${item.userGrpId}"
													   data-target="#myModal" class="table-link">
                                                            分配角色
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
            $('#page').load('<%=basePath%>/userGrp/list?', data);
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
                $('#page').load('<%=basePath%>/userGrp/list?' + sortStr, data)
            }
        }
    });
</script>
</body>
</html>
