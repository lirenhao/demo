<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String basePath = request.getContextPath();
%>
<html>
<body>
<div class="row">
    <div class="col-lg-12">
        <div class="row">
            <div class="col-lg-12">
                <ol class="breadcrumb">
                    <li>权限管理</li>
                    <li class="active"><span>机构管理</span></li>
                </ol>
                <h1>Nestable List</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="main-box clearfix">
                    <header class="main-box-header clearfix">
                        <h2>机构树</h2>
                    </header>
                    <div class="main-box-body clearfix">
                        <div id="nestable-menu">
                            <div class="icon-box">
                                <a href="javascript:void(0);" class="btn pull-left" onclick="orgExpandAll()">
                                    <i class="fa fa-minus-square-o"></i>
                                </a>
                                <a href="javascript:void(0);" class="btn pull-left" onclick="orgCollapseAll()">
                                    <i class="fa fa-plus-square-o"></i>
                                </a>
                            </div>
                        </div>
                        <div class="nestable-lists">
                            <div class="dd" id="orgTree">
                                <ol class="dd-list dd-nodrag">
                                    <li class="dd-item" data-orgId="${org.orgId}">
                                        <div class="dd-handle">
                                            ${org.orgId}[${org.name}]
                                            <div class="dd-nodrag nested-links">
                                                <a data-toggle="modal" data-target="#myModal" class="nested-link"
                                                   href="<%=basePath%>/org/show?id=${org.orgId}">
                                                    <i class="fa fa-search"></i>
                                                </a>
                                                <a data-toggle="modal" data-target="#myModal" class="nested-link"
                                                   href="<%=basePath%>/org/create?type=org&pid=${org.orgId}">
                                                    <i class="fa fa-plus"></i>
                                                </a>
                                            </div>
                                        </div>
                                        <c:if test="${not empty org.children}">
                                            <c:set var="orgList" value="${org.children}" scope="request"/>
                                            <jsp:include page="tree.jsp"/>
                                        </c:if>
                                    </li>
                                </ol>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $('#orgTree').nestable({handleClass: 'dd-list'});

    function orgExpandAll() {
        $('#orgTree').nestable('expandAll');
    }

    function orgCollapseAll() {
        $('#orgTree').nestable('collapseAll');
    }
</script>

</body>
</html>