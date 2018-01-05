<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="mytag" %>
<%
    String basePath = request.getContextPath();
%>
<html>
<head>
    <title>新增用户</title>
</head>
<body>
<form id="createForm">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">新增用户</h4>
    </div>
    <div class="modal-body">
        <div class="form-group">
            <label for="loginName">登录名称</label>
            <input type="text" class="form-control" id="loginName" name="loginName" maxlength="18"
                   value="${user.loginName}">
        </div>
        <div class="form-group">
            <label for="userName">用户名称</label>
            <input type="text" class="form-control" id="userName" name="userName" maxlength="32"
                   value="${user.userName}"/>
        </div>
        <div class="form-group">
            <label for="passWord">用户密码</label>
            <input type="passWord" class="form-control" id="passWord" name="passWord"
                   value="${user.passWord}" placeholder="请输入6位数以上密码"/>
        </div>
        <div class="form-group">
            <label>用户状态</label>
            <mytag:select styleClass="form-control" dictName="USER_STATUS" id="status"
                          name="status" value="1"></mytag:select>
        </div>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="submit" class="btn btn-primary">提交</button>
    </div>
</form>
<script>
    //字母数字
    jQuery.validator.addMethod("chrnum", function (value, element) {
        var chrnum = /^([a-zA-Z0-9]+)$/;
        return this.optional(element) || (chrnum.test(value));
    }, "只能输入数字和字母(字符A-Z, a-z, 0-9)");
    //表单验证
    $("#createForm").validate({
        rules: {
            loginName: {
                required: true,
                chrnum: true,
                remote: {
                    type: "post",
                    url: '<%=basePath%>/user/AJAX_isLoginNameExist',
                    data: {
                        loginName: function () {
                            return $("#loginName").val();
                        }
                    },
                    dataType: "html",
                    dataFilter: function (data, type) {
                        if (data > 0)
                            return false;
                        else
                            return true;
                    }
                }
            },
            userName: {
                required: true
            },
            status: {
                required: true
            },
            passWord: {
                required: true,
                minlength: "6"
            },
            status: {
                required: true
            }
        },
        messages: {
            loginName: {
                required: "请输入登录名称！",
                chrnum: "只能输入数字和字母(字符A-Z, a-z, 0-9)",
                remote: "登录名称已存在！"
            },
            userName: {
                required: "请输入用户名称！"
            },
            status: {
                required: "请选择用户状态！"
            },
            passWord: {
                required: "请输入用户密码！",
                minlength: "密码必须大于6位"
            },
            status: {
                required: "请选择状态！"
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
            $('#page').load('<%=basePath%>/user/save', $(form).serializeArray(), function () {
                $('#myModal').modal('hide');
            });
        }
    });
</script>
</body>
</html>
