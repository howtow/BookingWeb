<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<meta charset="UTF-8">
<meta http-equiv="refresh" content="3;url=${contextRoot}/myAccountPage">
<title>Insert title here</title>
</head>
<body>
	${sessionScope.loginCustomer.userName} 更新完成 !
</body>
</html>