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
        <h4 class="modal-title">用户分配角色</h4>
    </div>
    <div class="modal-body">
        <div class="form-group">
            <label for="user_name">用户名称:</label>
            <input type="text" class="form-control" id="user_name" name="userName"
                   value="${user.userName}" readonly>
            <input type="hidden" class="form-control" id="id" name="id" value="${user.id}">
        </div>
        <div class="form-group">
            <label>角色列表：</label>
            <c:forEach items="${roleList}" var="item">
                <div class="checkbox-nice">
                    <input type="checkbox" id="${item.id}" value="${item.id}" name="roles"
                            <c:forEach items="${user.roles}" var="role">
                                <c:if test="${role.id==item.id}">checked</c:if>
                            </c:forEach>
                    />
                    <label for="${item.id}">
                            ${item.name}
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
        submitHandler: function (form) {
            $('#page').load('<%=basePath%>/user/saveRoles', $(form).serializeArray(), function () {
                $('#myModal').modal('hide');
            });
        }
    });
</script>
</body>
</html>
