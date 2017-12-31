</body>
</html>
<%@ page language="java" pageEncoding="GBK" contentType="text/html;charset=GBK"%>
<%
  String basePath = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<title>访问越权</title>
  <jsp:include page="../base_pages/commons/base-css.jsp"/>
<style type="text/css">
<!--
.f14 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 14px;
	font-style: normal;
	line-height: 30px;
	font-weight: normal;
	color: #000000;
}
-->
</style>
</head>
<body>
<p>&nbsp;</p>
<p>&nbsp;</p>
<table width="60%" border="0" align="center" cellpadding="10"
	cellspacing="0">
  <tr>
    <td bgcolor="BEE9FD"><table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td bgcolor="#FFFFFF"><table width="100%" border="0" cellpadding="15" cellspacing="1">
          <tr>
            <td width="20%" bgcolor="E0F4FF"><div align="center"><img src="<%=basePath%>/img/baocuo12.gif"></div></td>
            <td width="80%" bgcolor="E0F4FF"><strong>您没有权限访问该功能。<a href="javascript:history.go(-1)">返回</a></strong></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
<p>&nbsp;</p>
<p></p>
<jsp:include page="../base_pages/commons/base-js.jsp"/>
</body>
</html>
