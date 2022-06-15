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
<jsp:include page="adminPage.jsp"/>
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
<div class="container">
    <div class="row" class="row" style="display: flex; justify-content: center;">
        <div class="col-11" style="left: 37%;">
            <h1 class="info">新增房間</h1>
        </div>
    </div>
</div>
<div class="container">
    <div class="row" class="row" style="display: flex; justify-content: center;">
        <div class="col-1" style="z-index: -1">
        </div>
        <form action="addRoom" method="POST" enctype="multipart/form-data">
        <div style="top:0;left: 0;" class="col-10 mt-3">
            <h1>Room+照片新增</h1><h3>${message}</h3>
                <div class="form-group">
                    <label>所屬旅館ID</label>
                    <input type="number" class="form-control" name="hotelId" required/>
                </div>
                <%--                沒加id欄位編輯會變成新增--%>
            <div class="form-group">
<%--                <label>房間ID</label>--%>
                <input type="hidden" class="form-control"  name="roomId" />
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
                <div id="tags">
                    <input type="checkbox" class="tag" value="免費盥洗用品" />免費盥洗用品
                    <input type="checkbox" class="tag" value="毛巾" />毛巾
                    <input type="checkbox" class="tag" value="淋浴間" />淋浴間
                    <input type="checkbox" class="tag" value="拖鞋" />拖鞋
                    <input type="checkbox" class="tag" value="沖洗座" />沖洗座<br />
                    <input type="checkbox" class="tag" value="吹風機" />吹風機
                    <input type="checkbox" class="tag" value="廁所" />廁所
                    <input type="checkbox" class="tag" value="衛生紙" />衛生紙
                    <input type="checkbox" class="tag" value="高樓層(有電梯)" />高樓層(有電梯)
                    <input type="checkbox" class="tag" value="書桌" />書桌<br />
                    <input type="checkbox" class="tag" value="床單" />床單
                    <input type="checkbox" class="tag" value="休息區" />休息區
                    <input type="checkbox" class="tag" value="衣櫃或衣櫥" />衣櫃或衣櫥
                    <input type="checkbox" class="tag" value="電視" />電視
                    <input type="checkbox" class="tag" value="桌遊/拼圖" />桌遊/拼圖<br />
                    <input type="checkbox" class="tag" value="衛星頻道" />衛星頻道
                    <input type="checkbox" class="tag" value="茶/咖啡沖泡設備" />茶/咖啡沖泡設備
                    <input type="checkbox" class="tag" value="平面電視" />平面電視
                    <input type="checkbox" class="tag" value="空調" />空調
                    <input type="checkbox" class="tag" value="有線頻道" />有線頻道<br />
                    <input type="checkbox" class="tag" value="硬木或實木地板" />硬木或實木地板
                    <input type="checkbox" class="tag" value="遊戲機" />遊戲機
                    <input type="checkbox" class="tag" value="陽台" />陽台
                    <input type="checkbox" class="tag" value="電風扇" />電風扇
                    <input type="checkbox" class="tag" value="戶外休息區" />戶外休息區<br />
                    <input type="checkbox" class="tag" value="床邊插座" />床邊插座
                    <input type="checkbox" class="tag" value="冰箱" />冰箱
                    <input type="checkbox" class="tag" value="電熱水壺" />電熱水壺
                    <input type="checkbox" class="tag" value="吊衣架" />吊衣架
                    <input type="checkbox" class="tag" value="禁菸" />禁菸<br />
                    <input type="checkbox" class="tag" value="免費Wifi" />免費Wifi
                    <input type="checkbox" class="tag" value="可免費停車" />可免費停車
                </div>
            </div>
            <div class="form-group">
                <label>人數限制</label>
                <input type="number" class="form-control" name="upperLimit" required/>
            </div>
            <div class="form-group">
                <label>描述</label>
                <input type="text" class="form-control" name="description" required/>
            </div>
        </div>
            <div class="container">
                <div class="row">
                    <div class="col-11">
                        <div class="form-group">
                        <label>照片上傳</label>
                        <input type="file" class="form-control" name="pic" multiple="multiple" accept="image/*, .jpeg, .png, .gif, .jpeg" id="uploadImg"/>
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
                    <input type="submit"  id="submit" value="送出">
                </div>
                <div class="col-4"></div>
            </div>
        </div>
        </form>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function(){
        $('#submit').click(function(){
            //tag整理成陣列傳回
            let col = document.getElementsByClassName('tag')
            let tags = ""
            $.each(col,function(index,value){
                if(col[index].checked==true){
                    tags += value.value
                }else{
                    tags += ""
                }
                if (index+1!=col.length) {
                    tags += ","
                }
            })
            $('#tags').append('<input type="hidden" name="allTags" value="'+tags+'" />')
            console.log(tags);
        })

        $('#uploadImg').change(function(){
            $('#piclist').remove()
            var file = document.getElementById('uploadImg').files
            var showImg = ''
            $.each(file,function(index,value){
                showImg += '<span id="piclist"><img src="'+URL.createObjectURL(value)+'" style="height:300px;"></span>'
            })
            $('#showImg').append(showImg)
        })
    })
</script>

</body>
</html>
