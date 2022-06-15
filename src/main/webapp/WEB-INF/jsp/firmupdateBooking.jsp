<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022/5/17
  Time: 下午 09:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="contextRoot" value="${pageContext.request.contextPath}"/>
<jsp:include page="firmPage.jsp"/>
<html>
<head>
    <title>更新訂單</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css"
          integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    <link rel="stylesheet" href="${contextRoot}/css/formtest.css">
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-11" style="left: 37%;">
            <h1 class="info">訂單資料</h1>
        </div>
    </div>
</div>

<div class="container" style="display: flex;">
	<div style="flex:1;"></div>
    <div class="row" style="flex:25;">
        <div class="col-1" style="z-index: -1">
        </div>
        <div style="top:0;left: 0;" class="col-5 mt-3">
            <form:form action="${contextRoot}/editPostBooking1" modelAttribute="bookingBean" method="POST">
                <%--                沒加id欄位編輯會變成新增--%>
            <div class="form-group">
                <label>ID</label>
                <form:input type="text" class="form-control" id="customerId" aria-describedby="emailHelp"
                            path="bookingId" cssStyle="width: 300px" readonly="true"/>
            </div>
            <div class="form-group">
                <label>客戶ID</label>
                <form:input type="text" class="form-control" id="customerCreditCard" path="userId"
                            cssStyle="width: 300px" readonly="true"/>
            </div>
            <div class="form-group">
                <label>飯店ID</label>
                <form:input type="text" class="form-control" id="customerCreditCard" path="hotelId"
                            cssStyle="width: 300px" readonly="true"/>
            </div>
            <div class="form-group">
                <label>房間ID</label>
                <form:input type="text" class="form-control" id="customerCreditCard" path="roomId"
                            cssStyle="width: 300px" readonly="true"/>
            </div>
            <form:errors path="email"/>
            <div class="form-group">
                <label>狀態</label>
                <form:input type="text" class="form-control" id="customerEmail" aria-describedby="emailHelp"
                            path="state" cssStyle="width: 300px" readonly="true"/>
            </div>
            <div class="form-group">
                <label>訂單時間</label>
                <form:input type="text" class="form-control" id="customerPassword" path="bookingTimes" readonly="true"
                            cssStyle="width: 300px" />
            </div>
            <div class="form-group">
                <label>入住幾天</label>
                <form:input type="number" class="form-control" id="customerName" aria-describedby="emailHelp"
                            path="dateOfStay" cssStyle="width: 300px" readonly="true"/>
            </div>
        </div>
        <div style="top:0;left: 0;" class="col-5 mt-3">
            <div class="form-group">
                <label>訂單名字</label>
                <form:input type="text" class="form-control" id="customerBirthday" path="bookingName"
                            cssStyle="width: 300px" readonly="true"/>
            </div>
            <div class="form-group">
                <label>電子郵件</label>
                <form:input type="email" class="form-control" id="customerPhone" path="email" cssStyle="width: 300px" readonly="true"/>
            </div>
            <div class="form-group">
                <label>信用卡</label>
                <form:input type="text" class="form-control" id="customerPhone" path="creditCard"
                            cssStyle="width: 300px" pattern="[0-9]{13,16}" readonly="true"/>
            </div>
            <div class="form-group">
                <label>備註</label>
                <form:input type="text" class="form-control" id="customerAddress" path="annotation"
                            cssStyle="width: 500px" readonly="true"/>
            </div>
            <div class="form-group">
                <label>入住時間</label>
                <form:input type="text" class="form-control" id="customerCreditCard" path="arriveTimes"
                            cssStyle="width: 300px" readonly="true"/>
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


</body>
</html>
