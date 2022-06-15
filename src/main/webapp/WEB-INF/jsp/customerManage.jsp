<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022/5/14
  Time: 下午 12:48
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
    <title>會員管理</title>
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
        <div style="top:0;left: 0;" class="col-11">
            <form action="customerManage">
                <div class="search">
                    <label>
                        <input type="search" name="customerKeyword" placeholder="搜尋">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </label>
                </div>
            </form>
            <div >
                <table class="table table-striped table-bordered table-secondary align-middle table-hover"
                       id="customerTable">
                    <thead>
                    <tr>
                        <td>UserID</td>
                        <td>電子郵件(帳號)</td>
                        <td>密碼</td>
                        <td>姓名</td>
                        <td>電話</td>
                        <td>生日</td>
                        <td>國家</td>
                        <td>性別</td>
                        <%--                    <td>住址</td>--%>
                        <%--                    <td>信用卡</td>--%>
                        <td>查看</td>
                        <td>刪除</td>
                    </tr>
                    </thead>
                    <c:forEach var="oneCustomer" items="${customerList}">
                        <tbody>
                        <tr>
                            <td>${oneCustomer.userId}</td>
                            <td>${oneCustomer.email}</td>
                            <td>${oneCustomer.password}</td>
                            <td>${oneCustomer.userName}</td>
                            <td>${oneCustomer.phone}</td>
                            <td>${oneCustomer.birthday}</td>
                            <td>${oneCustomer.nationality}</td>
                            <td>${oneCustomer.gender}</td>
                                <%--                        <td>${oneCustomer.address}</td>--%>
                                <%--                        <td>${oneCustomer.creditCard}</td>--%>
                            <td><a href="${contextRoot}/editCustomer?userId=${oneCustomer.userId}">查看</a></td>
                            <td><a onclick="return confirm('確認刪除')"
                                   href="${contextRoot}/deleteCustomer?userId=${oneCustomer.userId}">刪除</a></td>
                        </tr>
                        </tbody>
                    </c:forEach>
                </table>
                <div class="row justify-content-end">
                    <div class="col-12">
                        <c:forEach var="pageNumber" begin="1" end="${page.totalPages}">
                            <c:choose>

                                <c:when test="${page.number != pageNumber-1 }">
                                    <a class="pageNumber"
                                       href="${contextRoot}/customerManage?p=${pageNumber}&customerKeyword=${customerKeyword}"><c:out
                                            value="${pageNumber}"></c:out></a>
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
