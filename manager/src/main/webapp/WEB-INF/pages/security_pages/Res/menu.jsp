<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String basePath = request.getContextPath();
%>
<ol class="dd-list">
    <c:forEach items="${menuList}" var="menu">
        <li class="dd-item" data-menuResId="${menu.menuResId}">
            <div class="dd-handle">
                    ${menu.menuName}
                <div class="dd-nodrag nested-links">
                    <a data-toggle="modal" data-target="#myModal" class="nested-link"
                       href="<%=basePath%>/res/edit?id=${menu.menuResId}">
                        <i class="fa fa-pencil"></i>
                    </a>
                    <a data-toggle="modal" data-target="#myModal" class="nested-link"
                       href="<%=basePath%>/res/create?type=menu&pid=${menu.menuResId}">
                        <i class="fa fa-plus"></i>
                    </a>
                    <c:if test="${empty menu.children}">
                        <a href="javascript:void(0);" class="nested-link"
                           onclick="deleteClick('${menu.menuName}', '<%=basePath%>/res/delete?id=${menu.menuResId}')">
                            <i class="fa fa-trash-o"></i>
                        </a>
                    </c:if>
                </div>
            </div>
            <c:if test="${not empty menu.children}">
                <c:set var="menuList" value="${menu.children}" scope="request"/>
                <jsp:include page="menu.jsp"/>
            </c:if>
        </li>
    </c:forEach>
</ol>
