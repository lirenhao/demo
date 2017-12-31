<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String basePath = request.getContextPath();
%>
<html>
<head>
	<title>用户分配用户分组</title>
	<%--<script>--%>
        <%--//联动查询--%>
        <%--function editUserUserGrpOption(checkOrgId) {--%>
            <%--if (checkOrgId != null && checkOrgId != "") {--%>
                <%--$.ajax({--%>
                    <%--url: '<%=basePath%>/user/AJAX_findGrpByOrg',--%>
                    <%--type: "post",--%>
                    <%--data: {"orgId": checkOrgId},--%>
                    <%--dataType: "json",--%>
                    <%--success: function (data) {--%>
                        <%--var options = $("#user_list_create_userGrpName");--%>
                        <%--options.empty();--%>
                        <%--options.append("<option value=''>--请选择--</option>")--%>
                        <%--for (var i = 0; i < data.length; i++) {--%>
                            <%--var a = data[i].userGrpId;--%>
                            <%--var option = null;--%>
                            <%--option = '<option value="' + a + '">' + data[i].name + '</option>';--%>
                            <%--options.append(option);--%>
                        <%--}--%>
                    <%--}--%>
                <%--})--%>
            <%--}--%>
        <%--}--%>
	<%--</script>--%>
</head>
<body>
<form id="form">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		<h4 class="modal-title">用户分配用户分组</h4>
	</div>
	<div class="modal-body">
		<div class="form-group">
			<label for="user_list_edit_loginName">用户登录名:</label>
			<input type="text" class="form-control" id="user_list_edit_loginName" name="loginName"
				   value="${user.loginName}" readonly>
			<input type="hidden" class="form-control" id="user_list_edit_userId" name="userId"
				   value="${user.userId}" readonly>
		</div>
		<div class="form-group">
			<label for="user_list_edit_userName">用户名:</label>
			<input type="text" class="form-control" id="user_list_edit_userName" name="userName"
				   value="${user.userName}" readonly>
		</div>
		<div class="form-group">
			<label for="user_list_edit_orgName">机构:</label>
			<select path="s_lowerOrgId" id="user_list_edit_orgName" name="orgId"
					onchange="editUserUserGrpOption(this.value);">
				<option value="">--请选择--</option>
				<c:forEach items="${orgList}" var="orgItem">
					<option value="${orgItem.orgId}"
							<c:if test="${orgItem.orgId eq user.org.orgId}">selected</c:if>>
							${orgItem.name}
					</option>
				</c:forEach>
			</select>
		</div>
		<div class="form-group">
			<label for="user_list_edit_userGrpName">用户分组:
			</label>
			<select id="user_list_edit_userGrpName"
					name="userGrpId">
				<option value="">--请选择--</option>
			</select>
			<span style="color: red">*</span>
		</div>

	</div>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		<button type="submit" class="btn btn-primary">提交</button>
	</div>
</form>
<script>
	var checkUserGrpId=${user.userGrp.userGrpId};
    //初始化用户分组
//    console.log(data);
    if(${not empty checkUserGrpId || checkUserGrpId ne ""}){
//        console.log(checkUserGrpId);
        editUserUserGrpOption("${user.org.orgId}");
    }
    //联动查询
    function editUserUserGrpOption(checkOrgId) {
        if (checkOrgId != null && checkOrgId != "") {
            $.ajax({
                url: '<%=basePath%>/user/AJAX_findGrpByOrg',
                type: "post",
                data: {"orgId": checkOrgId},
                dataType: "json",
                success: function (data) {
                    var options = $("#user_list_edit_userGrpName");
                    options.empty();
                    options.append("<option value=''>--请选择--</option>")
                    for (var i = 0; i < data.length; i++) {
                        var a = data[i].userGrpId;
                        var option=null;
                        if (a == checkUserGrpId) {
                            option='<option selected value="'+a+'">'+data[i].name+'</option>';
                        } else {
                            option='<option value="'+a+'">'+data[i].name+'</option>';
                        }
                        options.append(option);
                    }
                }
            })
        }
    }

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
