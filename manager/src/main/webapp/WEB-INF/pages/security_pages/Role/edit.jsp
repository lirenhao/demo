<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getContextPath();
%>
<html>
<head>
    <title>角色编辑</title>
</head>
<body>
<form id="editForm">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">角色编辑</h4>
    </div>
    <div class="modal-body">
        <input type="hidden" name="id" value="${role.id}" readonly>
        <div class="form-group">
            <label for="name">角色名称</label>
            <input type="text" class="form-control" id="name" name="name" value="${role.name}">
        </div>
        <div class="form-group">
            <label for="remark">角色描述</label>
            <textarea class="form-control" id="remark" name="remark" rows="3" value="${role.remark}">${role.remark}</textarea>
        </div>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="submit" class="btn btn-primary">提交</button>
    </div>
</form>
<script>
    // 表单验证
    $("#editForm").validate({
        rules: {
            name: {
                required: true
            },
            remark: {
                required: true
            }
        },
        messages: {
            // 自定义错误提示信息
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
            $('#page').load('<%=basePath%>/role/update', $(form).serializeArray(), function () {
                $('#myModal').modal('hide');
            });
        }
    });
</script>
</body>
</html>
