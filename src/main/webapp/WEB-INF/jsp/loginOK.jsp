<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<meta charset="UTF-8">
<meta http-equiv="refresh" content="2;url=${contextRoot}/">

<title>登入成功</title>
</head>
<body>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.setDateHeader("Expires", -1);
	%>
<h1>登入成功</h1>

<h3>${sessionScope.loginCustomer.userName} 歡迎 !</h3>

<a href="myAccountPage">我的帳戶</a>
<!-- response.setHeader("refresh","2;URL=myAccountPage.jsp") ; -->


</body>
</html>
