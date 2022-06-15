<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022/5/9
  Time: 下午 11:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="contextRoot" value="${pageContext.request.contextPath}"/>
<link href="${contextRoot}/css/adminPage.css" rel="stylesheet">
<html>
<head>
    <title>登錄頁面</title>
    <link href='https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css"
          integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
</head>
<body>

<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setDateHeader("Expires", -1);
%>
<div class="sidebar">
    <div class="logo_content">
        <a href="${contextRoot}/newsPage"><img src="${contextRoot}/image/logo.png"/></a>
        <!-- <i class='bx bx-menu' id="btn"></i> -->
    </div>
    <ul class="nav-list">
        <!-- 搜尋和Icon (目前應該還用不到，留好看的)-->
<%--        <li>--%>
<%--            <i class='bx bx-search'></i>--%>
<%--            <input type="text" placeholder="Search">--%>
<%--        </li>--%>
        <!-- 會員管理和Icon-->
        <li>
            <a href="${contextRoot}/customerManage">
                <i class='bx bx-user'></i>
                <span class="links_name">會員管理</span>
            </a>
        </li>
        <!-- 旅館管理和Icon-->
        <li>
            <a href="${contextRoot}/hotelManage">
                <i class='bx bx-home-heart'></i>
                <span class="links_name hotel123456">旅館管理</span>
            </a>
        </li>
        <!-- 房間管理和Icon-->
        <li>
            <a href="${contextRoot}/roomManage" >
                <i class='bx bxs-hotel'></i>
                <span class="links_name">房間管理</span>
            </a>
<%--            子連結--%>
<%--            <ul id="sublist" class="list-unstyled collapse">--%>
<%--                <li>--%>
<%--                    <a href="#">新增房間</a>--%>
<%--                </li>--%>
<%--                <li>--%>
<%--                    <a href="#">房間列表</a>--%>
<%--                </li>--%>
<%--            </ul>--%>
        </li>
        <!-- 評論管理和Icon-->
        <li>
            <a href="${contextRoot}/commentManage">
                <i class='bx bxs-comment-detail'></i>
                <span class="links_name">評論管理</span>
            </a>
        </li>
        <!-- 訂單管理-->
        <li>
            <a href="${contextRoot}/bookingManage">
                <i class='bx bxs-comment-detail'></i>
                <span class="links_name">訂單管理</span>
            </a>
        </li>
        <!-- 設定和Icon (目前應該還用不到)-->
<%--        <li>--%>
<%--            <a href="#">--%>
<%--                <i class='bx bx-cog'></i>--%>
<%--                <span class="links_name">Setting</span>--%>
<%--            </a>--%>
<%--        </li>--%>
    </ul>

    <!-- ======側導覽列 結束===== -->

    <!-- ======管理員資訊 開始===== -->
    <div class="profile_content">
        <div class="profile">
            <div class="profile_details">
                <!-- 管理員頭像在這改!! -->
                <img src="image/profile.jpg" alt="">
                <div class="name_job">
                    <div class="name">${sessionScope.loginAdmin.adminName}</div>
                    <div class="job">管理員</div>
                </div>
            </div>
            <a href="${contextRoot}/adminLogout"><i class="fa-solid fa-arrow-right-from-bracket" id="log-out"></i></a>
        </div>
    </div>
    <!-- ======管理員資訊 結束===== -->
</div>


<div class="home_content">
    <div class="text" id="homeBackground"></div>
</div>


<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
        integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js"
        integrity="sha384-VHvPCCyXqtD5DqJeNxl2dtTyhF78xXNXdkwX1CZeRusQfRKp+tA7hAShOK/B/fQ2"
        crossorigin="anonymous"></script>
<script type="text/javascript">
    //避免上一頁返回
    // function preventBack() {
    //     window.history.forward();
    // }
    //
    // setTimeout("preventBack()", 0);
    //
    // window.onunload = function () { null };


</script>
</body>
</html>
