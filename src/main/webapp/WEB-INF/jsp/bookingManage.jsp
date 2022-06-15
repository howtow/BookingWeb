<%--
  Created by IntelliJ IDEA.
  User: iii
  Date: 2022/5/16
  Time: 下午 01:41
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
    <title>訂單管理</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css"
          integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <link rel="stylesheet" href="${contextRoot}/css/manage.css">
</head>
<body>
<div class="container" style="display: flex;">
	<div style="flex:1;"></div>
    <div class="row" style="flex:25;">
        <div class="col-1" style="z-index: -1">
        </div>
        <div class="col-11" style="top:0px;left: 0px">
            <form action="bookingManage" >
                <div class="search" >
                    <label >
                        <input type="search" name="bookingKeyword" placeholder="搜尋">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </label>
                </div>
            </form>
            <div  style="width: 1020px;">
                <table class="table table-striped table-bordered table-secondary align-middle table-hover">
                    <thead>
                    <tr>
                        <td>訂單Id</td>
                        <td>狀態</td>
                        <td>訂單時間</td>
                        <td>入住幾天</td>
                        <td>訂單名字</td>
                        <td>電子郵件</td>
<%--                        <td>信用卡</td>--%>
<%--                        <td>備註</td>--%>
                        <td>入住時間</td>
                        <td>飯店名字</td>
<%--                        <td>客戶ID</td>--%>
<%--                        <td>飯店ID</td>--%>
<%--                        <td>飯店ID</td>--%>
                        <td>查看</td>
                        <td>刪除</td>
                    </tr>
                    </thead>
                    <c:forEach var="oneBooking" items="${bookingList}">
                        <tbody>
                        <tr>
                            <td>${oneBooking.bookingId}</td>
                            <td>${oneBooking.state}</td>
                            <td>${oneBooking.bookingTimes}</td>
                            <td>${oneBooking.dateOfStay}</td>
                            <td>${oneBooking.bookingName}</td>
                            <td>${oneBooking.email}</td>
<%--                            <td>${oneBooking.creditCard}</td>--%>
<%--                            <td>${oneBooking.annotation}</td>--%>
                            <td>${oneBooking.arriveTimes}</td>
                            <td>${oneBooking.hotelName}</td>
<%--                            <td>${oneBooking.userId}</td>--%>
<%--                            <td>${oneBooking.hotelId}</td>--%>
<%--                            <td>${oneBooking.roomId}</td>--%>
                            <td><a href="${contextRoot}/editBooking?bookingId=${oneBooking.bookingId}">查看</a></td>
                            <td><a onclick="return confirm('確認刪除')" href="${contextRoot}/deleteBooking?bookingId=${oneBooking.bookingId}">刪除</a></td>
                        </tr>
                        </tbody>

                    </c:forEach>
                </table>
                <div class="row justify-content-end">
                    <div class="col-12">
                        <c:forEach var="pageNumber" begin="1" end="${page.totalPages}">
                            <c:choose>

                                <c:when  test="${page.number != pageNumber-1 }">
                                    <a class="pageNumber" href="${contextRoot}/bookingManage?p=${pageNumber}"><c:out value="${pageNumber}"></c:out></a>
                                </c:when>


                                <c:otherwise>
                                    <a class="pageNumber"><c:out value="${pageNumber}"></c:out></a>
                                </c:otherwise>

                            </c:choose>
                            <c:if test="${pageNumber != page.totalPages}">

                            </c:if>

                        </c:forEach>
            </div>
        </div>
    </div>
</div>

</div>
    </div>
</body>
</html>
