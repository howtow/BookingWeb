<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022/5/7
  Time: 下午 08:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<link href="${contextRoot}/css/sidebar.css" rel="stylesheet">
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/src/main/webapp/css/sidebar.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css"
          integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
</head>
<body>
<div class="container-all">

    <div class="container-left">
        <nav id="sidebar">

            <button type="button" id="collapse" class="collapse-btn">
                <i class="fa-solid fa-align-left"></i>
            </button>

            <ul class="list-unstyled">
                <h1>後台管理</h1>


                <li>
                    <a href="#">聯絡客服<i class="fa-solid fa-person-military-pointing"></i></a>
                </li>
                <li>
                    <a href="#sublist" data-toggle="collapse" id="dropdown">房間資訊<i class="fa-solid fa-bed"></i></a>
                    <ul id="sublist" class="list-unstyled collapse">
                        <li>
                            <a href="#">新增房間</a>
                        </li>
                    </ul>

                </li>
                <li>
                    <a href="#">旅館資訊<i class="fa-solid fa-hospital"></i></a>
                </li>
                <li>
                    <a href="#">評論資訊<i class="fa-solid fa-comment"></i></a>
                </li>
            </ul>

        </nav>
    </div>




    <!-- 右 -->
    <div class="container-right">
        <div class="row">
            <div class="col-10">
                <div class="container-fluid"></div>
                <h1>sdadasdas</h1>
            </div>

        </div>
    </div>



</div>
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
<script src="${contextRoot}/js/siderbar.js"></script>

</body>

</body>
</html>
