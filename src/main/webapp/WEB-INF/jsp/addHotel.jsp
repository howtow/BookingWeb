<%--
  Created by IntelliJ IDEA.
  User: iii
  Date: 2022/5/18
  Time: 下午 02:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="contextRoot" value="${pageContext.request.contextPath}"/>
<jsp:include page="adminPage.jsp"/>
<html>
<head>
    <title>新增旅館</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css"
          integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    <link rel="stylesheet" href="${contextRoot}/css/formtest.css">
    </style>
</head>
<body>
<div class="container">
    <div class="row" class="row" style="display: flex; justify-content: center;">
        <div class="col-11" style="left: 37%;">
            <h1 class="info">新增旅館</h1>
        </div>
    </div>
</div>
<div class="container">
    <div class="row" class="row" style="display: flex; justify-content: center;">
        <div class="col-1" style="z-index: -1">
        </div>
        <div style="top:0;left: 0;" class="col-5 mt-3">
            <form:form action="${contextRoot}/addHotel" modelAttribute="addHotelBean" method="POST" >
                <%--                沒加id欄位編輯會變成新增--%>
                <div class="form-group">
<%--                    <label>旅館ID</label>--%>
                    <form:input type="hidden" class="form-control" path="hotelId" cssStyle="width: 300px" readonly="true" />
                </div>
                <div class="form-group">
                    <label>旅館名字</label>
                    <form:input type="text" class="form-control" path="hotelName" cssStyle="width: 300px" required="required" />
                </div>
                <div class="form-group">
                    <label>描述</label>
                    <form:input type="textarea" class="form-control" path="description" cssStyle="width: 300px;height: 100px" required="required" />
                </div>
                <div class="form-group">
                    <label>地址</label>
                    <form:input type="text" class="form-control" path="add" cssStyle="width: 300px" required="required" />
                </div>
                <div class="form-group">
                    <label>地區</label>
                    <form:input type="text" class="form-control" path="region" cssStyle="width: 300px" required="required"/>
                </div>
                <div class="form-group">
                    <label>鄉鎮</label>
                    <form:input type="text" class="form-control" path="town" cssStyle="width: 300px" required="required"/>
                </div>
                <div class="form-group">
                    <label>電話</label>
                    <form:input type="text" class="form-control" path="tel" cssStyle="width: 300px" required="required"/>
                </div>
        </div>
        <div style="top:0;left: 0;" class="col-5 mt-3">
            <div class="form-group">
                <label>服務</label>
                <form:input type="text" class="form-control" path="serviceinfo" cssStyle="width: 300px" />
            </div>
            <div class="form-group">
                <label>停車位</label>
                <form:input type="text" class="form-control" path="parkinginfo" cssStyle="width: 300px"/>
            </div>
            <div class="form-group">
                <label>圖片</label>
                <form:input type="text" class="form-control" path="pics" cssStyle="width: 300px"/>
            </div>
            <div class="form-group">
                <label>圖片描述</label>
                <form:input type="text" class="form-control" path="picDIscribe" cssStyle="width: 300px" required="required"/>
            </div>
            <div class="form-group">
                <label>房間數</label>
                <form:input type="number" class="form-control" path="totalNumberofRooms" cssStyle="width: 300px" required="required"/>
            </div>
            <div class="form-group">
                <label>最低價格</label>
                <form:input type="text" class="form-control" path="lowestPrice" cssStyle="width: 300px" required="required"/>
            </div>
            <div class="form-group">
                <label>最高價</label>
                <form:input type="text" class="form-control" path="ceilingPrice" cssStyle="width: 300px" required="required"/>
            </div>
        </div>
        <div class="container">
            <div class="row justify-content-end">
                <div class="col-4">
                    <input type="submit" value="送出" id="btn">
                </div>
                <div class="col-4"></div>
            </div>
        </div>
        </form:form>
    </div>
</div>

</body>
</html>
