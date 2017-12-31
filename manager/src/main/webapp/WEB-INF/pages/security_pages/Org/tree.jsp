<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String basePath = request.getContextPath();
%>
<ol class="dd-list">
    <c:forEach items="${orgList}" var="org">
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
                    <c:if test="${empty org.children}">
                        <a href="javascript:void(0);" class="nested-link"
                           onclick="deleteClick('你确认要删除 ${org.name} 吗？', '<%=basePath%>/org/delete?id=${org.orgId}')">
                            <i class="fa fa-trash-o"></i>
                        </a>
                    </c:if>
                </div>
            </div>
            <c:if test="${not empty org.children}">
                <c:set var="orgList" value="${org.children}" scope="request"/>
                <jsp:include page="tree.jsp"/>
            </c:if>
        </li>
    </c:forEach>
</ol>
