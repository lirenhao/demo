<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <title>Cube - Bootstrap Admin Template</title>
    <jsp:include page="base-css.jsp"/>
</head>

<body class="fixed-header fixed-leftmenu fixed-footer theme-turquoise">
<%-- 弹出框 --%>
<div class="modal fade" id="myModal" aria-labelledby="myModalLabel" aria-hidden="true" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content"></div>
    </div>
</div>
<div id="theme-wrapper">
    <jsp:include page="header.jsp"/>
    <div id="page-wrapper" class="container">
        <div class="row">
            <jsp:include page="menu.jsp"/>
            <div id="content-wrapper">
                <div class="row" id="page">
                    <h2>首页</h2>
                </div>
            </div>
            <jsp:include page="footer.jsp"/>
        </div>
    </div>
</div>
<jsp:include page="base-js.jsp"/>
</body>

</html>