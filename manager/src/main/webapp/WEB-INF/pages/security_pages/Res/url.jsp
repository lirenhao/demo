<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String basePath = request.getContextPath();
%>
<ol class="dd-list">
    <c:forEach items="${urlList}" var="url">
        <li class="dd-item" data-id="${url.id}">
            <div class="dd-handle">
                    ${url.name}
                <div class="dd-nodrag nested-links">
                    <a data-toggle="modal" data-target="#myModal" class="nested-link"
                       href="<%=basePath%>/res/edit?id=${url.id}">
                        <i class="fa fa-pencil"></i>
                    </a>
                    <a data-toggle="modal" data-target="#myModal" class="nested-link"
                       href="<%=basePath%>/res/create?type=url&pid=${url.id}">
                        <i class="fa fa-plus"></i>
                    </a>
                    <c:if test="${empty url.children}">
                        <a href="javascript:void(0);" class="nested-link"
                           onclick="deleteClick('${url.name}', '<%=basePath%>/res/delete?id=${url.id}')">
                            <i class="fa fa-trash-o"></i>
                        </a>
                    </c:if>
                </div>
            </div>
            <c:if test="${not empty url.children}">
                <c:set var="urlList" value="${url.children}" scope="request"/>
                <jsp:include page="url.jsp"/>
            </c:if>
        </li>
    </c:forEach>
</ol>
