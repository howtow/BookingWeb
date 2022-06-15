<%--
  Created by IntelliJ IDEA.
  User: iii
  Date: 2022/5/24
  Time: 上午 11:41
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
    <title>評論管理</title>
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
        <div class="col-11" style="top:0px;left: 0">
            <form action="commentManage" >
                <div class="search" >
                    <label >
                        <input type="search" name="commentKeyword" placeholder="搜尋">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </label>
                </div>
            </form>
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-secondary align-middle table-hover">
                    <thead>
                    <tr>
                        <td>評論Id</td>
                        <td>評論</td>
                        <td>評分</td>
                        <td>客戶名字</td>
                        <td>房間名字</td>
                        <td>旅館名字</td>
                        <td>刪除</td>
                    </tr>
                    </thead>
                    <c:forEach var="oneComment" items="${commentList}">
                        <tbody>
                        <tr>
                            <td>${oneComment.commentId}</td>
                            <td>${oneComment.comment}</td>
                            <td>${oneComment.rating}</td>
                            <td>${oneComment.customer.userName}</td>
                            <td>${oneComment.room.roomName}</td>
                            <td>${oneComment.hotel.hotelName}</td>
                            <td><a onclick="return confirm('確認刪除')" href="${contextRoot}/deleteComment?commentId=${oneComment.commentId}">刪除</a></td>
                        </tr>
                        </tbody>

                    </c:forEach>
                </table>
                <div class="row justify-content-end">
                    <div class="col-12">
                        <c:forEach var="pageNumber" begin="1" end="${page.totalPages}">
                            <c:choose>

                                <c:when  test="${page.number != pageNumber-1 }">
                                    <a class="pageNumber" href="${contextRoot}/commentManage?p=${pageNumber}&commentKeyword=${commentKeyword}"><c:out value="${pageNumber}"></c:out></a>
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













<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
        integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js"
        integrity="sha384-VHvPCCyXqtD5DqJeNxl2dtTyhF78xXNXdkwX1CZeRusQfRKp+tA7hAShOK/B/fQ2"
        crossorigin="anonymous"></script>

</body>
</html>
