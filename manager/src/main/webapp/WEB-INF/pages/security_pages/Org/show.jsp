<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.yada.security.model.Org" %>
<%
	String basePath = request.getContextPath();
%>
<html>
<head>
	<title>查看机构</title>
</head>
<body>
<form id="form">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		<h4 class="modal-title" align="center">查看机构</h4>
	</div>
	<div class="modal-body">
		<table class="table table-bordered">
			<tbody>
			<tr>
				<td style="display:none"></td>
				<td style="width: 25%">机构名称:</td>
				<td style="width: 25%">${org.name}</td>
				<td style="width: 25%">上级机构:</td>
				<td style="width: 25%">${org.org.name}-${org.org.orgId}</td>
			</tr>
			<tr>
				<td style="display:none"></td>
				<td>机构号:</td>
				<td>${org.orgId}</td>
				<td>区域代码:</td>
				<td>${org.zoneCode}</td>
			</tr>
			<tr>
				<td style="display:none"></td>
				<td>省行机构号:</td>
				<td>${org.acqBankNo}</td>
				<td>网点机构号:</td>
				<td>${org.acqOrgId}</td>
			</tr>
			<tr>
				<td style="display:none"></td>
				<td>EACQ省行机构号:</td>
				<td>${org.bankNo}</td>
				<td>EACQ网点机构号:</td>
				<td>${org.eacqOrgId}</td>
			</tr>
			<tr>
				<td style="display:none"></td>
				<td>联系人:</td>
				<td>${org.contact}</td>
				<td>联系电话:</td>
				<td>${org.tel}</td>
			</tr>
			<tr>
				<td style="display:none"></td>
				<td>传真号码:</td>
				<td>${org.fax}</td>
				<td>机构地址:</td>
				<td>${org.addr}</td>
			</tr>
			</tbody>
		</table>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	</div>
</form>
</body>
</html>
