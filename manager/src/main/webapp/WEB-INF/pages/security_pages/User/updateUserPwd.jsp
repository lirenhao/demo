<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String basePath = request.getContextPath();
%>
<html>
<head>
	<title>修改密码</title>
</head>
<body>
<form id="updateUserPwdForm">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		<h4 class="modal-title">修改密码</h4>
	</div>
	<div class="modal-body">
		<div class="form-group">
			<label for="user_edit_loginName">用户登录名:</label>
			<input type="text" class="form-control" id="user_edit_loginName" name="loginName"
				   value="${user.loginName}" readonly/>
			<input name="id" type="hidden" value="${user.id}" readonly/>
		</div>
		<div class="form-group">
			<label for="user_edit_oldPwd">用户登录原密码:</label>
			<input type="passWord" class="form-control" id="user_edit_oldPwd" name="oldPwd"/>
			<span style="color: red" >*</span><span style="color: red">请输入6位数以上密码</span>
		</div>
		<div class="form-group">
			<label for="user_edit_newPwd">用户登录新密码:</label>
			<input type="passWord" class="form-control" id="user_edit_newPwd" name="newPwd"/>
			<span style="color: red" >*</span><span style="color: red">请输入6位数以上密码</span>
		</div>
		<div class="form-group">
			<label for="user_edit_retPwd">确认登录新密码:</label>
			<input type="passWord" class="form-control" id="user_edit_retPwd" name="retPwd"/>
			<span style="color: red">*</span><span style="color: red">请输入6位数以上密码</span>
		</div>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		<button type="submit" class="btn btn-primary">提交</button>
	</div>
</form>
<script>
    $("#updateUserPwdForm").validate({
        rules: {
            oldPwd: {
                required: true
            },
            newPwd: {
                required: true,
                minlength: 6
            },
            retPwd: {
                required: true,
                equalTo:"#user_edit_newPwd"
            }
        },
        messages: {
            oldPwd: {
                required: "请输入原密码！"
            },
            newPwd: {
                required: "请输入新密码！",
                minlength: " "
            },
            retPwd: {
                required: "请输入确认密码！",
                equalTo:"与新密码不一致"
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
            <%--$('#page').load('<%=basePath%>/user/saveUserPwd', $(form).serializeArray(), function (data) {--%>
                <%--$('#myModal').modal('hide');--%>
                <%--alertClick(data.msg);--%>
            <%--});--%>
            $.ajax({
                type: 'post',
                url:'<%=basePath%>/user/saveUserPwd',
                dataType: "text",
                data: $(form).serializeArray(),
                success: function (data) {
					if("密码修改成功！"==data){
                        $('#myModal').modal('hide');
					    alertClick(data);
					}else {
//                        $('#myModal').modal('hide');
					    alertClick(data);
					}
                }

            });
        }
    });
</script>
</body>
</html>