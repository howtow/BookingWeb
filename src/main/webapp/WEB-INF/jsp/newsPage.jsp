<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022/6/5
  Time: 上午 01:45
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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css"
          integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <link rel="stylesheet" href="${contextRoot}/css/manage.css">
    <title>Title</title>

    <style>
        .cardBox{
            position: relative;
            width: 100%;
            padding: 20px;
            display:grid;
            grid-template-columns: repeat(3,1fr);
            grid-gap: 20px;
        }

        .cardBox .card{
            position: relative;
            background-color: #fff3cd;
            display: flex;
            padding: 20px;
            justify-content: space-between;
            cursor: pointer;
        }
        .cardBox .card .numbers{
            position: relative;
            font-size: 2em;
            font-weight: 500;
        }
        #bookingSum{
            font-size: 24px;
        }
        .cardBox .card .cardName{
            color: #999;
        }
        .cardBox .card .iconBox{
            position: absolute;
            left:240px;
            font-size: 2.5em;
            color: #5249FA;
        }
    </style>
</head>
<body>
<div class="container" style="display: flex;">
    <div style="flex: 1;"></div>
    <div class="row" style="flex: 25;">
        <div class="col-1" style="z-index: -1">
        </div>
        <div style="top:0;left: 0;" class="col-11">
            <div class="cardBox">
                <div class="card">
                    <div>
                        <div class="numbers" id="member"></div>
                        <div class="cardName">會員數</div>
                    </div>
                    <div class="iconBox">
                        <i class="fa-solid fa-person"></i>
                    </div>
                </div>
                    <div class="card">
                        <div>
                            <div class="numbers" id="hotel"></div>
                            <div class="cardName">旅館數</div>
                        </div>
                        <div class="iconBox">
                            <i class="fa-solid fa-hotel"></i>
                        </div>
                    </div>
                        <div class="card">
                            <div>
                                <div class="numbers" id="room"></div>
                                <div class="cardName">房間數</div>
                            </div>
                            <div class="iconBox">
                                <i class="fa-solid fa-bed"></i>
                            </div>
                        </div>
                        <div class="card">
                            <div>
                                <div class="numbers" id="comment"></div>
                                <div class="cardName">評論數</div>
                            </div>
                            <div class="iconBox">
                                <i class="fa-solid fa-comment"></i>
                            </div>
                        </div>
                        <div class="card">
                            <div>
                                <div class="numbers" id="bookingSum"></div>
                                <div class="cardName">訂單總金額</div>
                            </div>
                            <div class="iconBox">
                                <i class="fa-solid fa-clipboard-list"></i>
                            </div>
                        </div>


                    </div>
            <h2 style="justify-content: center">最近訂單</h2>
            <div class="table-responsive">
                <%--            <input type="text" value="搜尋欄位">--%>
                <table class="table table-striped table-bordered table-primary" id="bookingTable">
                    <thead>
                    <tr>
                        <td>訂單Id</td>
<%--                        <td>狀態</td>--%>
                        <td>訂單時間</td>
                        <td>入住幾天</td>
                        <td>訂單名字</td>
                        <td>電子郵件</td>
                        <td>信用卡</td>
                        <td>備註</td>
                        <td>入住時間</td>
<%--                        <td>飯店名字</td>--%>
                    </tr>
                    </thead>

                </table>
            </div>
                </div>
            </div>
        </div>



    <script>
        $(document).ready(function () {
            $.ajax({
                url: "http://localhost:8081/booking/api/customerSum",
                contentType: 'application/json; charset=UTF-8',
                dataType: 'json',
                method: 'GET',
                success: function (data) {
                    console.log(data)
                    let customerSum = '';
                    $.each(data, function () {
                        customerSum +=   data.customer  ;
                    })
                    $('#member').append(customerSum);
                },
                error: function (err) {
                    console.log(err);
                    alert('ajax發生錯誤')
                }

            })
            $.ajax({
                url: "http://localhost:8081/booking/api/hotelSum",
                contentType: 'application/json; charset=UTF-8',
                dataType: 'json',
                method: 'GET',
                success: function (data) {
                    console.log(data)
                    let hotelSum= '';
                    $.each(data, function () {
                        hotelSum +=   data.hotel  ;
                    })
                    $('#hotel').append(hotelSum);
                },
                error: function (err) {
                    console.log(err);
                    alert('ajax發生錯誤')
                }

            })
            $.ajax({
                url: "http://localhost:8081/booking/api/bookingSum",
                contentType: 'application/json; charset=UTF-8',
                dataType: 'json',
                method: 'GET',
                success: function (data) {
                    console.log(data)
                    let bookingSum= '';
                    $.each(data, function () {
                        bookingSum +=   data.booking+'&nbsp;&nbsp;&nbsp;&nbsp; TWD'  ;
                    })
                    $('#bookingSum').append(bookingSum);
                },
                error: function (err) {
                    console.log(err);
                    alert('ajax發生錯誤')
                }

            })
            $.ajax({
                url: "http://localhost:8081/booking/api/roomSum",
                contentType: 'application/json; charset=UTF-8',
                dataType: 'json',
                method: 'GET',
                success: function (data) {
                    console.log(data)
                    let roomSum= '';
                    $.each(data, function () {
                        roomSum +=   data.room  ;
                    })
                    $('#room').append(roomSum);
                },
                error: function (err) {
                    console.log(err);
                    alert('ajax發生錯誤')
                }

            })
            $.ajax({
                url: "http://localhost:8081/booking/api/commentSum",
                contentType: 'application/json; charset=UTF-8',
                dataType: 'json',
                method: 'GET',
                success: function (data) {
                    console.log(data)
                    let commentSum= '';
                    $.each(data, function () {
                        commentSum +=   data.comment ;
                    })
                    $('#comment').append(commentSum);
                },
                error: function (err) {
                    console.log(err);
                    alert('ajax發生錯誤')
                }

            })
            $.ajax({
                url: "http://localhost:8081/booking/api/booking",
                contentType: 'application/json; charset=UTF-8',
                dataType: 'json',
                method: 'GET',
                success: function (data) {
                    let booking_data = '';
                    $.each(data, function (key, value) {
                        booking_data += '<tr>';
                        booking_data += '<td>' + value.bookingId + '</td>';
                        // hotel_data += '<td>' + value.State + '</td>';
                        booking_data += '<td>' + value.bookingTimes + '</td>';
                        booking_data += '<td>' + value.dateOfStay + '</td>';
                        booking_data += '<td>' + value.bookingName + '</td>';
                        booking_data += '<td>' + value.email + '</td>';
                        booking_data += '<td>' + value.creditCard + '</td>';
                        booking_data += '<td>' + value.annotation+ '</td>';
                        booking_data += '<td>' + value.arriveTimes+ '</td>';
                        booking_data += '</tr>';
                    })
                    console.log(booking_data)
                    $('#bookingTable').append(booking_data);
                }

            })
        })
    </script>

</body>
</html>
