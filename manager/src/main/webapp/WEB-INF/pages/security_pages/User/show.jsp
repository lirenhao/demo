<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.yada.security.model.User" %>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="mytag"%>
<%
    String basePath = request.getContextPath();
%>
<html>
<head>
    <title>查看用户</title>
</head>
<body>
<form id="form">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">查看用户</h4>
    </div>
    <div class="modal-body">
        <table class="table table-bordered">
            <tbody>
            <tr>
                <td style="display:none"></td>
                <td style="width: 25%"><%=User.ALIAS_LOGIN_NAME%>:</td>
                <td style="width: 25%">${model.loginName}</td>

                <td style="width: 25%"><%=User.ALIAS_STATUS%>:</td>
                <td style="width: 25%">
                    <mytag:write dictName="D_USER_STATUS" value="${model.status}"></mytag:write>
                    <%--<c:if test="${model.status eq '0'}">停用</c:if>--%>
                    <%--<c:if test="${model.status eq '1'}">启用</c:if>--%>
                </td>

            </tr>
            <tr>
                <td style="display:none"></td>
                <td ><%=User.ALIAS_ORG_ID%>:</td>
                <td>${model.org.name}</td>

                <td ><%=User.ALIAS_USER_GRP_ID%>:</td>
                <td>${model.userGrp.name}</td>
            </tr>
            <tr>
                <td style="display:none"></td>
                <td ><%=User.ALIAS_LAST_LOGIN_IP_ADDR%>:</td>
                <td>${model.lastLoginIpAddr}</td>

                <td ><%=User.ALIAS_LAST_LOGIN_DATE_TIME%>:</td>
                <td>${model.lastLoginDateTime}</td>
            </tr>
            <tr>
                <td style="display:none"></td>
                <td ><%=User.ALIAS_LAST_LOGOUT_DATE_TIME%>:</td>
                <td>${model.lastLogoutDateTime}</td>

                <td ><%=User.ALIAS_LOGIN_CNT%>:</td>
                <td>${model.loginCnt}</td>
            </tr>
            <tr>
                <td style="display:none"></td>
                <td ><%=User.ALIAS_LAST_CHG_PWD_DATE_TIME%>:</td>
                <td>${model.lastChgPwdDateTime}</td>

                <td ><%=User.ALIAS_CREATE_DATE_TIME%>:</td>
                <td>${model.createDate}</td>
            </tr>
            <tr>
                <td style="display:none"></td>
                <td ><%=User.ALIAS_CREATE_USER_ID%>:</td>
                <td>${createUser.loginName}</td>

                <td ><%=User.ALIAS_LOGIN_FAILED_CNT%>:</td>
                <td>${model.loginFailedCnt}</td>
            </tr>
            <tr>
                <td style="display:none"></td>
                <td ><%=User.ALIAS_LAST_LOGIN_FAILED_DATE_TIME%>:</td>
                <td>${model.lastLoginFailedDateTime}</td>
            </tr>
            </tbody>
        </table>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
    </div>
</form>
</body>
</html>
