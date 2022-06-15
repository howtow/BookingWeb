<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022/5/14
  Time: 下午 05:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="contextRoot" value="${pageContext.request.contextPath}"/>
<link href="${contextRoot}/css/adminPage.css" rel="stylesheet">
<jsp:include page="adminPage.jsp"/>
<html>
<head>
    <title>更新會員資料</title>
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css"
          integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    <link rel="stylesheet" href="${contextRoot}/css/formtest.css">
<%--    <style>--%>
<%--        label {--%>
<%--            font-family: 微軟正黑體, serif;--%>
<%--            color: #005cbf;--%>
<%--            letter-spacing: 2px;--%>
<%--        }--%>
<%--        body {--%>
<%--            background-color: #005cbf;--%>
<%--        }--%>
<%--        .form-control{--%>
<%--            padding:5px 15px; border:2px black solid;--%>
<%--            cursor:pointer;--%>
<%--            -webkit-border-radius: 5px;--%>
<%--            border-radius: 5px;--%>
<%--        }--%>
<%--    </style>--%>
</head>
<body>
<div class="container" style="display: flex;">
	<div style="flex:1;"></div>
    <div class="row" style="flex:25;">
        <div class="col-11" style="left: 37%;">
        <h1 class="info">會員資料</h1>
        </div>
    </div>
</div>

<div class="container" style="display: flex;">
	<div style="flex:1;"></div>
    <div class="row" style="flex:25;">
        <div class="col-1" style="z-index: -1">
        </div>
        <div style="top:0;left: 0;" class="col-5 mt-3">

            <form:form action="${contextRoot}/postEditCustomer" modelAttribute="customerBean" method="get">
                <%--                沒加id欄位編輯會變成新增--%>
            <div class="form-group">
                <label for="customerId">ID</label>
                <form:input type="text" class="form-control" id="customerId" aria-describedby="emailHelp" path="userId"
                            cssStyle="width: 300px" readonly="true"/>
            </div>

            <div class="form-group">
                <label for="customerEmail">電子信箱</label>
                <form:errors path="email" cssStyle="color: red"/>
                <form:input type="email" class="form-control" id="customerEmail" aria-describedby="emailHelp"
                            path="email" cssStyle="width: 300px" readonly="true"/>
            </div>
            <div class="form-group">
                <label for="customerPassword">密碼</label>
                <form:input type="text" class="form-control" id="customerPassword" path="password"
                            cssStyle="width: 300px" readonly="true"/>
            </div>
            <div class="form-group">
                <label for="customerName">姓名</label>
                <form:errors path="userName" cssStyle="color: red"/>
                <form:input type="text" class="form-control" id="customerName" aria-describedby="emailHelp"
                            path="userName" cssStyle="width: 300px" readonly="true"/>
            </div>
            <div class="form-group">
                <label for="customerPhone">電話</label>
                <form:input type="text" class="form-control" id="customerPhone" aria-describedby="emailHelp"
                            path="phone" cssStyle="width: 300px" readonly="true"/>
            </div>
            <div class="form-group">
                <form:input type="hidden" class="form-control" id="customerBirthday" path="birthday" pattern="yyyy-MM-dd"
                            cssStyle="width: 300px" readonly="true"/>
            </div>
        </div>
        <div style="top:0;left: 0;" class="col-5 mt-3">
            <div class="form-group">
                <label for="customerPhone">國家</label>
                <form:input type="text" class="form-control" id="customerPhone" path="nationality"
                            cssStyle="width: 300px" readonly="true"/>
            </div>
            <div class="form-group">
                <label>性別</label>
                    <%--                    <form:input type="text" class="form-control" id="customerPhone"  path="gender" cssStyle="width: 300px"/>--%>
                <form:input type="text" class="form-control" id="customerAddress" path="gender"
                            cssStyle="width: 500px" readonly="true"/>
            </div>
            <div class="form-group">
                <label for="customerAddress">地址</label>
                <form:input type="text" class="form-control" id="customerAddress" path="address"
                            cssStyle="width: 500px" readonly="true"/>
            </div>
            <div class="form-group">
                <label for="customerCreditCard">信用卡號</label>
                <form:input type="text" class="form-control" id="customerCreditCard" path="creditCard"
                            cssStyle="width: 300px" pattern="[0-9]{13,16}" readonly="true"/>
            </div>
            <div class="form-group">
                <form:input type="hidden" class="form-control" id="customerState" path="state" cssStyle="width: 300px"/>
            </div>
            <div class="form-group">
                <form:input type="hidden" class="form-control" id="customerState" path="enabled" cssStyle="width: 300px"/>
            </div>
            <div class="form-group">
                <form:input type="hidden" class="form-control" id="customerState" path="salt" cssStyle="width: 300px"/>
            </div>
            <div class="form-group">
                <form:input type="hidden" class="form-control" id="customerState" path="verificationCode" cssStyle="width: 300px"/>
            </div>

            </div>
        <div class="container">
            <div class="row justify-content-end">
                <div class="col-4">
                    <input type="submit" value="返回" id="btn">
                </div>
                <div class="col-4"></div>
            </div>
            </div>

            </form:form>
        </div>
    </div>



<%--<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"--%>
<%--        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"--%>
<%--        crossorigin="anonymous"></script>--%>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
        integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js"
        integrity="sha384-VHvPCCyXqtD5DqJeNxl2dtTyhF78xXNXdkwX1CZeRusQfRKp+tA7hAShOK/B/fQ2"
        crossorigin="anonymous"></script>

</body>
</html>
