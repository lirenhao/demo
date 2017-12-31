<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String basePath = request.getContextPath();
%>
<html>
<head>
    <title>新增机构</title>
</head>
<body>
<form id="form">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">新增机构</h4>
    </div>
    <div class="modal-body">
        <div class="row">
            <div class="form-group">
                <label for="org_list_create_pOrgName">上级机构:</label>
                <input type="text" class="form-control" id="org_list_create_pOrgName"
                       value="${pOrg.name}-${pOrg.orgId}" readonly>
                <input type="hidden" class="form-control" id="org_list_create_pOrgId" name="pid" value="${pOrg.orgId}"
                       readonly>
            </div>
        </div>
        <div class="row">
            <div class="form-group">
                <label for="org_list_create_name">机构名称:</label>
                <input type="text" class="form-control" id="org_list_create_name" name="name" maxlength="16"
                       value="${org.name}">
                <span style="color: red">*</span>
            </div>
        </div>
        <div class="row">
            <div class="form-group">
                <label for="org_list_create_org">机构号:</label>
                <input type="text" class="form-control" id="org_list_create_org" name="orgId"
                       value="${org.orgId}">
                <span style="color: red">*</span>
            </div>
        </div>
        <div class="row">
            <div class="form-group">
                <label for="org_list_create_zoneCode">区域代码:</label>
                <input type="text" class="form-control" id="org_list_create_zoneCode" name="zoneCode"
                       value="${org.zoneCode}">
            </div>
            <div class="form-group">
                <label for="org_list_create_acqBankNo">省行机构号:</label>
                <input type="text" class="form-control" id="org_list_create_acqBankNo" name="acqBankNo"
                       value="${org.acqBankNo}">
            </div>
        </div>
        <div class="row">
            <div class="form-group">
                <label for="org_list_create_acqOrgId">网点机构号:</label>
                <input type="text" class="form-control" id="org_list_create_acqOrgId" name="acqOrgId"
                       value="${org.acqOrgId}">
            </div>
            <div class="form-group">
                <label for="org_list_create_bankNo">EACQ省行机构号:</label>
                <input type="text" class="form-control" id="org_list_create_bankNo" name="bankNo"
                       value="${org.bankNo}">
            </div>
        </div>
        <div class="row">
            <div class="form-group">
                <label for="org_list_create_eacqOrgId">EACQ网点机构号:</label>
                <input type="text" class="form-control" id="org_list_create_eacqOrgId" name="eacqOrgId"
                       value="${org.eacqOrgId}">
            </div>
            <div class="form-group">
                <label for="org_list_create_contact">联系人:</label>
                <input type="text" class="form-control" id="org_list_create_contact" name="contact"
                       value="${org.contact}">
            </div>
        </div>
        <div class="row">
            <div class="form-group">
                <label for="org_list_create_tel">联系电话:</label>
                <input type="text" class="form-control" id="org_list_create_tel" name="tel"
                       value="${org.tel}">
            </div>
            <div class="form-group">
                <label for="org_list_create_fax">传真号码:</label>
                <input type="text" class="form-control" id="org_list_create_fax" name="fax"
                       value="${org.fax}">
            </div>

        </div>
        <div class="row">
            <div class="form-group">
                <label for="org_list_create_addr">机构地址:</label>
                <input type="text" class="form-control" id="org_list_create_addr" name="addr"
                       value="${org.addr}">
            </div>
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
                required: true,
                digits: true,
                remote: {
                    type: "post",
                    url: "<%=basePath%>/org/AJAX_isOrgIdExist",
                    data: {
                        orgId: function () {
                            return $("#org_list_create_org").val();
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
            name: {
                required: true
            }
        },
        messages: {
            orgId: {
                required: "请输入机构号！",
                digits: "请输入整数！",
                remote: "机构号已存在！"
            },
            name: {
                required: "请输入机构名称！"
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
            $('#page').load('<%=basePath%>/org/save', $(form).serializeArray(), function () {
                $('#myModal').modal('hide');
            });
        }
    });
</script>
</body>
</html>
