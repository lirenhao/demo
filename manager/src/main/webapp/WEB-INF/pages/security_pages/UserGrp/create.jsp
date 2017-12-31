<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="mytag"%>
<%
    String basePath = request.getContextPath();
%>
<html>
<head>
    <title>新增用户分组</title>
</head>
<body>
<form id="form">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">新增用户分组</h4>
    </div>
    <div class="modal-body">
        <div class="form-group">
            <label for="userGrp_list_create_orgName">机构:</label>
            <select id="userGrp_list_create_orgName" name="orgId">
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
            <label for="userGrp_list_create_name">用户分组名称:</label>
            <input type="text" class="form-control" id="userGrp_list_create_name" name="name" maxlength="32"
                   value="${userGrp.name}">
            <span style="color: red">*</span>
        </div>
        <div class="form-group">
            <%--<label for="userGrp_list_create_ihtFlag">状态:--%>
            <%--</label>--%>
            <%--<select id="userGrp_list_create_ihtFlag" name="ihtFlag">--%>
                <%--<option value="">--请选择--</option>--%>
                <%--<option value="0"--%>
                        <%--<c:if test="${'0' eq userGrp.ihtFlag}">selected</c:if> >--%>
                    <%--可以继承--%>
                <%--</option>--%>
                <%--<option value="1" <c:if test="${'1' eq userGrp.ihtFlag}">selected</c:if>>--%>
                    <%--不可继承--%>
                <%--</option>--%>
            <%--</select>--%>
                <label >状态:</label>
                <mytag:select dictName="D_IHT_FLAG" name="ihtFlag" id="userGrp_list_create_ihtFlag" ></mytag:select>
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
    // 表单验证

    $("#form").validate({
        rules: {
            orgId: {
                required: true
            },
            name: {
                required: true
            },
            ihtFlag: {
                required: true
            }
        },
        messages: {
            orgId: {
                required: "请选择机构！"
            },
            name: {
                required: "请输入分组名称！"
            },
            ihtFlag: {
                required: "请选择继承标志！"
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
            $('#page').load('<%=basePath%>/userGrp/save', $(form).serializeArray(), function () {
                $('#myModal').modal('hide');
            });
        }
    });
</script>
</body>
</html>
