<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022/5/9
  Time: 下午 11:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>--%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<link href="${contextRoot}/css/adminLogin.css" rel="stylesheet">
<html>
<head>
    <title>後台登入</title>
    <!-- <link rel="stylesheet" href="css/bootstrap.css"> -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    <!--=====Inconscout CSS-->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <!--=====CSS=====-->
    <link rel="stylesheet" href="//apps.bdimg.com/libs/jqueryui/1.10.4/css/jquery-ui.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.0/jquery-ui.min.js"
            integrity="sha256-hlKLmzaRlE8SCJC1Kw8zoUbU8BxA+8kR3gseuKfMjxA=" crossorigin="anonymous"></script>

    <script>

        $(function () {
            $("#datepicker").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '1950:2022',
            });
        });
    </script>
</head>
<body>
<!-- ======Login Form ====== -->
<div class="container">
    <div class="forms">
        <div class="form login">
            <span class="title">管理員登入</span>
            <form action="adminPost" method="post">
                <div class="input-field ">
                    <input type="text" placeholder="帳號" name="adminEmail" required>
                    <i class="uil uil-envelope icon"></i>
                </div>
                <div class="input-field">
                    <input type="password" class="password" placeholder="密碼" name="password" required>
                    <i class="uil uil-lock icon"></i>
                    <i class="uil uil-eye-slash showHideIcon"></i>
                </div>

                <div class="checkbox-text">
                    <div class="checkbox-content">
                        <input type="checkbox" id="logCheck">
                        <label for="logCheck" class="text">記住我</label>
                        <p style="color: red">${loginError}</p>
                    </div>

                    <a href="#" class="text">忘記密碼?</a>
                </div>

                <div class="input-field loginBtn">
                    <input type="submit" value="登入" >
                </div>

            </form>
            <div class=" login-signup">
                    <span class="text">
                        <a href="${contextRoot}" class="col-4">回到首頁</a>
                    </span>
            </div>
        </div>
    </div>
</div>
<script src="${contextRoot}/js/adminLogin.js"></script>
<link href="${contextRoot}/css/adminLogin.css" rel="stylesheet">

</body>
</html>
