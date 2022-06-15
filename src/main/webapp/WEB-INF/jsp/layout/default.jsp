<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<title>Formosa Booking</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="${contextRoot}/css/bootstrap.min.css">
<!-- 載入地圖用 -->
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.3.4/dist/leaflet.css" integrity="sha512-puBpdR0798OZvTTbP4A8Ix/l+A4dHDD0DGqYW6RQ+9jxkRFclaxxQb/SJAWZfWAkuyeQUytO7+7N4QKrDh+drA==" crossorigin=""/>
<!-- main css -->
<link rel="stylesheet" href="${contextRoot}/css/navBar.css">
<link rel="stylesheet" href="${contextRoot}/css/responsive.css">
<!-- 地圖+收藏清單 css -->
<link rel="stylesheet" href="${contextRoot}/css/map_favorite.css">

<!-- 測試 -->

</head>
<body>
	 <!--================Header Area =================-->
        <header class="header_area">
            <div class="container">
                <nav class="navbar navbar-expand-lg navbar-light">
                    <!-- Brand and toggle get grouped for better mobile display -->
                    <a class="navbar-brand logo_h" href="/booking/"><img src="${contextRoot}/image/logo.png" width="150px" alt=""></a>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <!-- Collect the nav links, forms, and other content for toggling -->
                    <div class="collapse navbar-collapse offset" id="navbarSupportedContent">
						<ul class="nav navbar-nav menu_nav ml-auto">
							<li class="nav-item"><a class="nav-link" href="${contextRoot}/">首頁</a></li>
							<li class="nav-item"><a class="nav-link" href="#">關於我們</a></li>
								<li class="nav-item"><a class="nav-link" href="contact.html">聯絡我們</a></li>
							<li class="nav-item"><a class="nav-link" href="searchEmptyHotel?userId=${sessionScope.loginCustomer.userId}">住宿</a></li>
							
							<!-- 當點擊按鈕時，觸發了”dropdown”這個事件，。 -->
<!-- 							<li class="nav-item submenu dropdown"> -->
<!-- 								子目錄dropdown -->
<!-- 								<a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" -->
<!-- 									aria-haspopup="true" aria-expanded="false">熱門活動</a> -->
<!-- 								<ul class="dropdown-menu"> -->
<!-- 									<li class="nav-item"><a class="nav-link" href="blog.html">項目一</a></li> -->
<!-- 									<li class="nav-item"><a class="nav-link" href="blog-single.html">項目二</a></li> -->
<!-- 								</ul> -->
<!-- 							</li> -->
	
							<c:choose>
						
							<c:when test="${loginCustomer != null}">
								
								<li class="nav-item active submenu dropdown">
								<a class="nav-link"
									href="#">${loginCustomer.userName}專區</a>
									<ul class="dropdown-menu">
									<li class="nav-item"><a class="nav-link" href="myAccountPage?userId=${loginCustomer.userId}">個人資訊</a></li>
									<li class="nav-item"><a class="nav-link" href="bookingList?userId=${loginCustomer.userId}">我的訂單</a></li>
									<li class="nav-item"><a class="nav-link" href="CommentList?userId=${loginCustomer.userId}">我的評論</a></li>
									</ul>
									
									</li>
								<li class="nav-item"><a id="favoritebtn" class="nav-link" style="cursor: pointer;"><i class="fa-solid fa-heart" style="margin-right: 3px;"></i>收藏</a></li>			
								<li class="nav-item"><a class="nav-link"
									href="${contextRoot}/customerlogout">登出</a></li>
							</c:when>
							<c:otherwise>
								<li class="nav-item"><a class="nav-link"
							href="${contextRoot}/customerlogin">會員登入</a></li>			
							</c:otherwise>
						</c:choose>
							
							
						</ul>
					</div> 
                </nav>
            </div>
        </header>
        <!--================Header Area =================-->
        
        <!--================Banner 文字訊息 Area =================-->
        <section class="bannerText_area blog_banner_two">
            <div class="overlay bg-parallax" data-stellar-ratio="0.8" data-stellar-vertical-offset="0" data-background=""></div>
            <div class="container">
                <div class="page-cover text-center">
                
                <c:if test="${loginCustomer != null}">
 
                    <h2 class="page-cover-tittle f_48">Welcome ${loginCustomer.userName} !</h2>
                
                </c:if>
                
                    
                </div>
            </div>
        </section>
	<!--================Header Area =================-->

	<!--================ dialog Area  =================-->
	<div>
		<dialog id="favoritehead">
			<div style="display: flex; justify-content: space-between; align-items: center;">
				<div><h3><i class="fa-solid fa-heart" style="margin-right: 5px; color: rgb(196, 48, 48);"></i>我的收藏</h3></div>
				<div id="close"><a id="closefavorite"><b><i class="fa-solid fa-rectangle-xmark closeicon" style="font-size: 30px; padding: 10px; cursor: pointer;"></i></b></a></div>
			</div>
			<div id="favoritebody">
				
			</div>
			<input type="hidden" value="${sessionScope.loginCustomer.userId}" id="userId"/>
		</dialog>
	</div>
	<dialog id="deletedialog">
		<div>移除中...</div>
	</dialog>
	
	<!-- Optional JavaScript -->
	<!-- jQuery先,再來 Popper.js, then Bootstrap JS -->

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	
	<script src="${contextRoot}/js/popper.js"></script>

	<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
	<!--ajachimp待處理-->
	<script src="${contextRoot}/js/mail-script.js"></script>
	
	<!-- 視差滾動（Parallax Scrolling）-->
	<script src="${contextRoot}/js/stellar.js"></script>
	
	<!--自定義-->
	<script src="${contextRoot}/js/navBar.js"></script>

	<!--收藏清單-->
	<script src="${contextRoot}/js/favorite.js"></script>
</body>
</html>