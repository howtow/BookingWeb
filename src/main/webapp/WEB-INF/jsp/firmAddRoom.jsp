<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022/5/22
  Time: 下午 04:06
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
    <title>新增房間資料</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css"
          integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    <link rel="stylesheet" href="${contextRoot}/css/formtest.css">

</head>
<body>
<div class="container-fluid header ">
    <div class="row">
        <h1 class="info">旅館資料</h1>
    </div>
</div>
<div class="container">
    <div class="row" style="display: flex; justify-content: center;">
        <div class="col-1" style="z-index: -1">
        </div>
        <form action="firmAddRoom" method="POST" enctype="multipart/form-data">
        <div style="top:0;left: 0;" class="col-10 mt-3">
            <h1>Room+照片新增</h1><h3>${message}</h3>
                <%--                沒加id欄位編輯會變成新增--%>
            <div class="form-group">
<%--                <label>房間ID</label>--%>
                <input type="hidden" class="form-control"  name="roomId" required/>
            </div>
            <div class="form-group">
                <label>房間名字</label>
                <input type="text" class="form-control" name="roomName" required/>
            </div>
            <div class="form-group">
                <label>價格</label>
                <input type="text" class="form-control" name="price" required/>
            </div>
            <div class="form-group">
                    <label>標籤</label>
                    <input type="text" class="form-control" name="allTags" required/>
                </div>
            <div class="form-group">
                <label>人數限制</label>
                <input type="number" class="form-control" name="upperLimit" required />
            </div>
            <div class="form-group">
                <label>描述</label>
                <input type="text" class="form-control" name="description" />
            </div>
        </div>
            <div class="container">
                <div class="row">
                    <div class="col-11">
                        <div class="form-group">
                        <label>照片上傳</label>
                        <input type="file" name="pic" multiple="multiple" accept="image/*, .jpeg, .png, .gif, .jpeg" id="uploadImg"/>
                    </div>
                        <div id="showImg"></div>
                        <div class="form-group">
                            <label>照片描述</label>
                            <input type="text" class="form-control" name="imgDescription" />
                        </div>
                    </div>
                </div>
            </div>

        <div class="container">
            <div class="row justify-content-end">
                <div class="col-4">
                    <input type="submit"  value="送出" id="btn">
                </div>
                <div class="col-4"></div>
            </div>
        </div>
        </form>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function(){
        // $('#submit').click(function(){
        //     //tag整理成陣列傳回
        //     let col = document.getElementsByClassName('tag')
        //     let tags = ""
        //     $.each(col,function(index,value){
        //         if(col[index].checked==true){
        //             tags += value.value
        //         }else{
        //             tags += ""
        //         }
        //         if (index+1!=col.length) {
        //             tags += ","
        //         }
        //     })
        //     $('#tags').append('<input type="hidden" name="allTags1" value="'+tags+'" />')
        //     console.log(tags);
        // })

        $('#uploadImg').change(function(){
            $('#piclist').remove()
            var file = document.getElementById('uploadImg').files
            var showImg = ''
            $.each(file,function(index,value){
                showImg += '<td id="piclist"><img src="'+URL.createObjectURL(value)+'" style="height:250px;width: 250px;border-radius: 10px;">&nbsp;&nbsp</td>'
            })
            $('#showImg').append(showImg)
        })
    })
</script>

</body>
</html>
