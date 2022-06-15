<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022/5/17
  Time: 下午 10:50
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
    <title>房間管理</title>
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
        <div  style="top:0;left: 0;" class="col-11">
            <form action="roomManage" >
                <div class="search" >
                    <label >
                        <input type="search" name="roomKeyword" placeholder="搜尋">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </label>
                </div>
            </form>
            <div>
                <button class="justify-content-end" id="addRoom"><a href="${contextRoot}/addRoom">新增房間</a></button>
            </div>
            <table  class="table table-striped table-bordered table-secondary align-middle table-hover" id="roomTable">
                <thead>
                <tr>
                    <td>roomID</td>
                    <td>房間名稱</td>
                    <td>價錢</td>
                    <td>Tag</td>
                    <td>人數限制</td>
                    <td>描述</td>
                    <td>旅館Id</td>
                    <td>編輯</td>
                    <td>刪除</td>
                </tr>
                </thead>
                <c:forEach var="oneRoom" items="${roomList}">
                    <tbody>
                    <tr>
                        <td>${oneRoom.roomId}</td>
                        <td>${oneRoom.roomName}</td>
                        <td>${oneRoom.price}</td>
                        <td>${oneRoom.tag}</td>
                        <td>${oneRoom.upperLimit}</td>
                        <td>${oneRoom.description}</td>
                        <td>${oneRoom.hotelId}</td>
                        <td><a href="${contextRoot}/editRoom?roomId=${oneRoom.roomId}">編輯</a></td>
                        <td><a onclick="return confirm('確認刪除')" href="${contextRoot}/deleteRoom?roomId=${oneRoom.roomId}">刪除</a></td>
                    </tr>
                    </tbody>
                </c:forEach>
            </table>
            <div class="row justify-content-end">
                <div class="col-12">
                    <c:forEach var="pageNumber" begin="1" end="${page.totalPages}" >
                        <c:choose>

                            <c:when  test="${page.number != pageNumber-1 }">
                                <a class="pageNumber" href="${contextRoot}/roomManage?p=${pageNumber}&roomKeyword=${roomKeyword}"><c:out value="${pageNumber}"></c:out></a>
                            </c:when>


                            <c:otherwise>
                                <a class="pageNumber"> <c:out value="${pageNumber}"></c:out></a>
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



<%--<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"--%>
<%--        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"--%>
<%--        crossorigin="anonymous"></script>--%>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
        integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js"
        integrity="sha384-VHvPCCyXqtD5DqJeNxl2dtTyhF78xXNXdkwX1CZeRusQfRKp+tA7hAShOK/B/fQ2"
        crossorigin="anonymous"></script>

<%--<script>--%>
<%--    $(document).ready(function (){--%>
<%--        ${'.addRoom'}.onmouseenter(function (){--%>
<%--            $(this).css("background-color","#233");--%>
<%--            $(this).css("color","#fff");--%>
<%--        });--%>
<%--        ${'.addRoom'}.onmouseleave(function (){--%>
<%--            $(this).css("background-color","#233");--%>
<%--            $(this).css("color","#fff");--%>
<%--    })--%>

<%--</script>--%>
</body>
</html>
