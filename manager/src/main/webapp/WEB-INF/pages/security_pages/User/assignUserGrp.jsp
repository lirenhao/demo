<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String basePath = request.getContextPath();
%>
<html>
<head>
	<title>用户分配用户分组</title>
</head>
<body>
<form id="form">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		<h4 class="modal-title">用户分配用户分组</h4>
	</div>
	<div class="modal-body">
		<div class="form-group">
			<label for="user_list_create_loginName">用户登录名:</label>
			<input type="text" class="form-control" id="user_list_create_loginName" name="loginName"
				   value="${user.loginName}" readonly>
			<input type="hidden" class="form-control" id="user_list_create_userId" name="userId"
				   value="${user.userId}" readonly>
		</div>
		<div class="form-group">
			<label for="user_list_create_orgName">机构:</label>
			<input type="text" class="form-control" id="user_list_create_orgName" name="orgName"
				   value="${user.org.name}" readonly>
			</input>
		</div>
		<div class="form-group">
			<label for="user_list_create_userGrpName">用户分组:
			</label>
			<select id="user_list_create_userGrpName"
					name="userGrpId">
				<option value="">--请选择--</option>
				<c:forEach items="${userGrpList}" var="orgItem">
					<option value="${orgItem.userGrpId}"
							<c:if test="${orgItem.userGrpId eq user.userGrp.userGrpId}">selected</c:if>>
							${orgItem.name}
					</option>
				</c:forEach>
			</select>
			<span style="color: red">若仍无用户分组,请新增该机构下用户分组</span>
		</div>

		</div>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		<button type="submit" class="btn btn-primary">提交</button>
	</div>
</form>
<script>
    // 表单验证

    $("#form").validate({
        rules: {
            userGrpId: {
                required: true
            }
        },
        messages: {
            userGrpId: {
                required: "请选择用户分组！"
            }
        },
        errorElement: 'span',
        errorClass: 'help-block',
        errorPlacement: function (error, element) {
            error.appendTo(element.closest('.form-group'));
        },
        highlight: function (element) {
            $(element).closest('.form-group').removeClass('has-success').addClass('has-error');
        },
        unhighlight: function (element) {
            $(element).closest('.form-group').removeClass('has-error');
        },
        success: function (label) {
            label.closest('.form-group').removeClass('has-error').addClass('has-success');
        },
        submitHandler: function (form) {
            $('#page').load('<%=basePath%>/user/saveUserGrp', $(form).serializeArray(), function () {
                $('#myModal').modal('hide');
            });
        }
    });
</script>
</body>
</html>
