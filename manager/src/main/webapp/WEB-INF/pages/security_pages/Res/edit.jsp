<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getContextPath();
%>
<html>
<head>
    <title>编辑资源</title>
</head>
<body>
<form id="form">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">资源编辑</h4>
    </div>
    <div class="modal-body">
        <input type="hidden" name="menuResId" value="${res.menuResId}">
        <div class="form-group">
            <label for="menuName">资源名称</label>
            <input type="text" class="form-control" id="menuName" name="menuName" value="${res.menuName}">
        </div>
        <div class="form-group">
            <label for="actionName">资源动作</label>
            <input type="text" class="form-control" id="actionName" name="actionName" value="${res.actionName}">
        </div>
        <div class="form-group">
            <label for="icon">资源图标</label>
            <input type="text" class="form-control" id="icon" name="icon" value="${res.icon}">
        </div>
        <div class="form-group">
            <label for="dsc">资源描述</label>
            <textarea class="form-control" id="dsc" name="dsc" value="${res.dsc}" rows="3">${res.dsc}</textarea>
        </div>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="submit" class="btn btn-primary">提交</button>
    </div>
</form>
<script>
    // 表单验证
    $.validator.addMethod(
        'checkAction',
        function (value, element) {
            var checkAction = /^(\/).*(\/).*$/g;
            return this.optional(element) || (checkAction.test(value));
        },
        '请输入合法的Action名称');
    $("#form").validate({
        rules: {
            menuName: {
                required: true
            },
            actionName: {
                checkAction: true
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
            $('#page').load('<%=basePath%>/res/update', $(form).serializeArray(), function () {
                $('#myModal').modal('hide');
            });
        }
    });
</script>
</body>
</html>
