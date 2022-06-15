<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022/5/8
  Time: 上午 12:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<link href="${contextRoot}/css/backlogin.css" rel="stylesheet">
<html>
<head>
    <title>後台登入</title>
</head>
<body>
<div class="login-wrap">
    <div class="login-html">
        <input id="tab-1" type="radio" name="tab" class="sign-in" checked><label for="tab-1" class="tab">Sign In</label>
        <input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab"></label>
        <div class="login-form">
            <div class="sign-in-htm">
                <form  action="test" method="post">
                <div class="group">
                    <label for="user" class="label">使用者帳號</label>
                    <input id="user" type="text" class="input" name="adminEmail" required>
                </div>
                <div class="group">
                    <label for="pass" class="label">使用者密碼</label>
                    <input id="pass" type="password" class="input" data-type="password" name="password" required>
                    <p style="color: red">${loginError}</p>
                </div>

                <div class="group">
                    <!-- <input id="check" type="checkbox" class="check" checked>
                    <label for="check"><span class="icon"></span> Keep me Signed in</label> -->
                </div>
                <div class="group">
                        <input type="submit" class="button" value="登入">
                </div>
                </form>
                <div class="hr"></div>
                <div class="foot-lnk">
                    <a href="#forgot">Forgot Password?</a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
