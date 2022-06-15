<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022/5/11
  Time: 下午 05:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="contextRoot" value="${pageContext.request.contextPath}"/>
<link href="${contextRoot}/css/adminPage.css" rel="stylesheet">
<jsp:include page="adminPage.jsp"/>
<html>
<head>
    <title>旅館管理</title>
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
            <form action="hotelManage" >
                <div class="search" >
                <label >
                <input type="search" name="hotelKeyword" placeholder="搜尋旅館名或地址" class="mt-2">
                    <i class="fa-solid fa-magnifying-glass mt-2"></i>
                </label>
                </div>
            </form>
            <div>
                <button class="justify-content-end mt-2" id="addHotel"><a href="${contextRoot}/addhotel">新增旅館</a></button>
            </div>
            <div class="table-responsive">
                <%--            <input type="text" value="搜尋欄位">--%>
                <table class="table table-striped table-bordered table-secondary align-middle table-hover mt-2" id="hotelTable">
                    <thead>
                    <tr>
                        <th>id</th>
                        <th>旅館</th>
                        <%--                    <th>描述</th>--%>
                        <th>地址</th>
                        <th>電話</th>
                        <th>服務</th>
                        <th>房間數</th>
                        <th>最低價格</th>
                        <th>最高價</th>
                        <th>編輯</th>
                        <th>刪除</th>
                    </tr>
                    </thead>
                    <c:forEach var="oneHotel" items="${hotelList}">
                        <tbody>
                        <tr>
                            <td>${oneHotel.hotelId}</td>
                            <td>${oneHotel.hotelName}</td>
                                <%--                        <td>${onehotel.description}</td>--%>
                            <td>${oneHotel.add}</td>
                            <td>${oneHotel.tel}</td>
                            <td>${oneHotel.serviceinfo}</td>
                            <td>${oneHotel.totalNumberofRooms}</td>
                            <td>${oneHotel.lowestPrice}</td>
                            <td>${oneHotel.ceilingPrice}</td>
                            <td><a href="${contextRoot}/editHotel?hotelId=${oneHotel.hotelId}">編輯</a></td>
                            <td><a onclick="return confirm('確認刪除')"
                                   href="${contextRoot}/deleteHotel?hotelId=${oneHotel.hotelId}">刪除</a></td>
                        </tr>
                        </tbody>
                    </c:forEach>

                </table>
            </div>
        </div>
    </div>
</div>
<div class="container" style="display: flex;">
	<div style="flex:1;"></div>
    <div class="row justify-content-end" style="flex:25;">
        <div class="col-11 align-self-end">
            <c:forEach var="pageNumber" begin="1" end="${page.totalPages}">
                <c:choose>

                    <c:when test="${page.number != pageNumber-1 }">
                        <a class="pageNumber" href="${contextRoot}/hotelManage?p=${pageNumber}&hotelKeyword=${hotelKeyword}"><c:out value="${pageNumber}"></c:out></a>
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


<%--<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"--%>
<%--        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"--%>
<%--        crossorigin="anonymous"></script>--%>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
        integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js"
        integrity="sha384-VHvPCCyXqtD5DqJeNxl2dtTyhF78xXNXdkwX1CZeRusQfRKp+tA7hAShOK/B/fQ2"
        crossorigin="anonymous"></script>
<%--<script src="${contextRoot}/js/hotelManage.js"></script>--%>
<%--<script>--%>
<%--    $(document).ready(function () {--%>

<%--        $.ajax({--%>
<%--            url: "http://localhost:8080/Booking/hotelManage1",--%>
<%--            contentType: 'application/json; charset=UTF-8',--%>
<%--            dataType: 'json',--%>
<%--            method: 'GET',--%>
<%--            success: function (data) {--%>
<%--                let hotel_data = '';--%>
<%--                $.each(data, function (key, value) {--%>
<%--                    hotel_data += '<tr>';--%>
<%--                    hotel_data += '<td>' + value.hotelId + '</td>';--%>
<%--                    hotel_data += '<td>' + value.hotelName + '</td>';--%>
<%--                    // hotel_data += '<td>' + value.description + '</td>';--%>
<%--                    hotel_data += '<td>' + value.add + '</td>';--%>
<%--                    hotel_data += '<td>' + value.tel + '</td>';--%>
<%--                    hotel_data += '<td>' + value.serviceinfo + '</td>';--%>
<%--                    hotel_data += '<td>' + value.totalNumberofRooms + '</td>';--%>
<%--                    hotel_data += '<td>' + value.lowestPrice + '</td>';--%>
<%--                    hotel_data += '<td>' + value.ceilingPrice + '</td>';--%>
<%--                    hotel_data += '<td>' + `<a href="${contextRoot}/editHotel">` + '編輯' + '</a>' + '</td>';--%>
<%--                    hotel_data += '<td>' + '<a href="${contextRoot}/deleteHotel" onclick="return confirm("確認刪除嗎?")">' + '刪除' + '</a>' + '</td>';--%>
<%--                    hotel_data += '</tr>';--%>
<%--                })--%>
<%--                $('#hotelTable').append(hotel_data);--%>
<%--            }--%>

<%--        })--%>
<%--    })--%>
<%--</script>--%>

</body>
</html>
