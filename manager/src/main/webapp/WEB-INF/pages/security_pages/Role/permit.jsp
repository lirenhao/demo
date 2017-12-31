<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getContextPath();
%>
<html>
<head>
    <title>角色授权</title>
</head>
<body>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title">角色授权</h4>
</div>
<div class="modal-body">
    <ul class="nav nav-tabs">
        <li class="active">
            <a href="#menuTab" data-toggle="tab">菜单</a>
        </li>
        <li>
            <a href="#urlTab" data-toggle="tab">URL</a>
        </li>
    </ul>
    <div class="tab-content">
        <div class="tab-pane fade in active" id="menuTab">
            <div id="menuTree"></div>
        </div>
        <div class="tab-pane fade" id="urlTab">
            <div id="urlTree"></div>
        </div>
    </div>
</div>
<div class="modal-footer">
    <a href="#" id='test' data-title="权限" data-emptytext="选择授权" data-type="checklist" data-value="1"
       data-source="{1: 'User', 2: 'Admin'}"></a>
    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
    <button type="button" class="btn btn-primary" onclick="savePermit()">提交</button>
</div>
<script>
    var menuTree = $('#menuTree').tree({
        primaryKey: 'id',
        childrenField: 'children',
        dataSource: ${menuTree},
        selectionType: 'single',
        uiLibrary: 'bootstrap',
        border: true,
        icons: {
            expand: '<i class="glyphicon glyphicon-plus"/>',
            collapse: '<i class="glyphicon glyphicon-minus"/>'
        }
    });
    menuTree.on('select', function () {
        return false;
    });
    menuTree.expandAll();

    var urlTree = $('#urlTree').tree({
        primaryKey: 'id',
        childrenField: 'children',
        dataSource: ${urlTree},
        selectionType: 'single',
        uiLibrary: 'bootstrap',
        border: true,
        icons: {
            expand: '<i class="glyphicon glyphicon-plus"/>',
            collapse: '<i class="glyphicon glyphicon-minus"/>'
        }
    });
    urlTree.on('select', function () {
        return false;
    });

    $('a[name="permitId"]').editable({
        display: function (value, sourceData) {
            var html = [],
                checked = $.fn.editableutils.itemsByValue(value, sourceData);
            if (checked.length) {
                $.each(checked, function (i, v) {
                    var text = $.fn.editableutils.escape(v.text);
                    html.push(text);
                });
                $(this).html(html.join(','));
            } else {
                $(this).empty();
            }
        }
    });

    var data = {id: ${id}};
    function savePermit() {
        data.ids = "";
        $.each($('a[name="permitId"]'), function (i, item) {
            $.each($(item).editable('getValue')[undefined], function (i, v) {
                if (v != "")
                    data.ids = data.ids + v + ",";
            })
        });
        $('#page').load('<%=basePath%>/role/permitSave', data, function () {
            $('#myModal').modal('hide');
        });
    }
</script>
</body>
</html>