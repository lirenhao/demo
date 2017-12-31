<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="mytag"%>
<%
    String basePath = request.getContextPath();
%>
<html>
<head>
    <title>新增用户</title>
    <script>
        //联动查询
        function addUserCreateUserGrpOption(checkOrgId) {
            if (checkOrgId != null && checkOrgId != "") {
                $.ajax({
                    url: '<%=basePath%>/user/AJAX_findGrpByOrg',
                    type: "post",
                    data: {"orgId": checkOrgId},
                    dataType: "json",
                    success: function (data) {
                        var options = $("#user_list_create_userGrpName");
                        options.empty();
                        options.append("<option value=''>--请选择--</option>")
                        for (var i = 0; i < data.length; i++) {
                            var a = data[i].userGrpId;
                            var option = null;
                            option = '<option value="' + a + '">' + data[i].name + '</option>';
                            options.append(option);
                        }
                    }
                })
            }
        }
    </script>
</head>
<body>
<form id="form">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">新增用户</h4>
    </div>
    <div class="modal-body">
        <div class="form-group">
            <label for="user_list_create_orgName">机&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;构:</label>
            <select id="user_list_create_orgName" name="orgId"
                    onchange="addUserCreateUserGrpOption(this.value);">
                <option value="">--请选择--</option>
                <c:forEach items="${orgList}" var="orgItem">
                    <option value="${orgItem.orgId}">
                            ${orgItem.name}
                    </option>
                </c:forEach>
            </select>
            <span style="color: red">*</span>
        </div>
        <div class="form-group">
            <label for="user_list_create_userGrpName">用户分组:
            </label>
            <select id="user_list_create_userGrpName"
                    name="userGrpId">
                <option value="">--请选择--</option>
                <%--<c:forEach items="userGrpList" var="userGrpItem">--%>
                <%--<option value="${userGrpItem.userGrpId}">${userGrpItem.userGrpName}</option>--%>
                <%--</c:forEach>--%>
            </select>
            <span style="color: red">*</span>
        </div>
        <div class="form-group">
            <label for="user_list_create_loginName">用户登录名:</label>
            <input type="text" class="form-control" id="user_list_create_loginName" name="loginName" maxlength="18"
                   value="${user.loginName}">
            <span style="color: red">*</span>
        </div>
        <div class="form-group">
            <label for="user_list_create_userName">用&nbsp;户&nbsp;名:</label>
            <input type="text" class="form-control" id="user_list_create_userName" name="userName" maxlength="32"
                   value="${user.userName}"/>
            <span style="color: red">*</span>
        </div>
        <div class="form-group">
            <label for="user_list_create_pwd">用户密码:</label>
            <input type="passWord" class="form-control" id="user_list_create_pwd" name="passWord" value="${user.passWord}"/>
            <span style="color: red">请输入6位数以上密码</span>
        </div>
        <div class="form-group">
            <label >状态:
            </label>
            <%--<label for="user_list_create_status">状态:--%>
            <%--</label>--%>
            <%--<select id="user_list_create_status" name="status">--%>
                <%--<option value="">--请选择--</option>--%>
                <%--<option value="0"--%>
                        <%--<c:if test="${'0' eq user.status}">selected</c:if> >--%>
                    <%--停用--%>
                <%--</option>--%>
                <%--<option value="1" <c:if test="${'1' eq user.status}">selected</c:if>>--%>
                    <%--启用--%>
                <%--</option>--%>
            <%--</select>--%>
            <mytag:select dictName="D_USER_STATUS" name="status" id="user_list_create_status" value="1"></mytag:select>
            <span style="color: red">*</span>
        </div>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="reset" class="btn btn-primary">重置</button>
        <button type="submit" class="btn btn-primary">提交</button>
    </div>
</form>
<script>
    //字母数字
    jQuery.validator.addMethod("chrnum", function(value, element) {
        var chrnum = /^([a-zA-Z0-9]+)$/;
        return this.optional(element) || (chrnum.test(value));
    }, "只能输入数字和字母(字符A-Z, a-z, 0-9)");
    //表单验证
    $("#form").validate({
        rules: {
            userGrpId: {
                required: true
            },
            loginName: {
                required: true,
                chrnum:true,
                remote: {
                    type: "post",
                    url: '<%=basePath%>/user/AJAX_isLoginNameExist',
                    data: {
                        loginName: function () {
                            return $("#user_list_create_loginName").val();
                        }
                    },
                    dataType: "html",
                    dataFilter: function (data, type) {
//                        console.log("data="+data);
                        if (data >0)
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
            status:{
                required: true
            }
        },
        messages: {
            userGrpId: {
                required: "请选择用户分组！"
            },
            loginName: {
                required: "请输入登录名！",
                chrnum:"只能输入数字和字母(字符A-Z, a-z, 0-9)",
                remote: "登录名已存在！"
            },
            userName: {
                required: "请输入用户名！"
            },
            status: {
                required: "请选择用户状态！"
            },
            passWord: {
                required: "请输入密码！",
                minlength: " "
            },
            status:{
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
