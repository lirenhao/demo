<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String basePath = request.getContextPath();
%>
<html>
<head>
    <title>用户维护</title>
</head>
<body>
<form id="form">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">用户分组分配角色</h4>
    </div>
    <div class="modal-body">
        <div class="form-group">
            <label for="userGrp_list_role_name">用户分组名称:</label>
            <input type="text" class="form-control" id="userGrp_list_role_name" name="name"
                   value="${userGrp.name}" disabled>
            <input type="hidden" class="form-control" id="userGrp_list_role_userGrpId" name="userGrpId"
                   value="${userGrp.userGrpId}" readonly>
        </div>
        <div class="form-group">
            <label>角色列表：</label>
            <c:forEach items="${roleList}" var="item1">
                <div class="checkbox-nice">
                    <input type="checkbox" id="${item1.id}" value="${item1.id}" name="roles"
                    <c:forEach items="${userGrp.roles}" var="item2">
                           <c:if test="${item2.id==item1.id}">checked</c:if>
                    </c:forEach>
                    />
                    <label for="${item1.id}">
                            ${item1.name}
                    </label>
                </div>
            </c:forEach>
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
                required: ""
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
            $('#page').load('<%=basePath%>/userGrp/saveRoles', $(form).serializeArray(), function () {
                $('#myModal').modal('hide');
            });
        }
    });
</script>
</body>
</html>
