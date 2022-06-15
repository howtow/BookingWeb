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
	
<!-- <meta name="viewport" content="width=device-width, initial-scale=1.0"> -->
<link rel="icon" href="#" type="image/png">
<title>Formosa Booking</title>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!-- Bootstrap CSS -->

<link rel="stylesheet" href="${contextRoot}/css/bootstrap.min.css">


<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<link rel="stylesheet"
	href="${contextRoot}/vendors/owl-carousel/owl.carousel.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.0/css/nice-select.min.css">
<!-- main css -->
<link rel="stylesheet" href="${contextRoot}/css/style.css">
<link rel="stylesheet" href="${contextRoot}/css/responsive.css">
<script src="https://kit.fontawesome.com/ca70cd7f9d.js"
	crossorigin="anonymous"></script>
<!-- jquery-ui -->
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	
<!-- 地圖Hover -->
<link rel="stylesheet" href="src/augurio-taiwan.css"/>
<script src="//cdnjs.cloudflare.com/ajax/libs/babel-polyfill/7.6.0/polyfill.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/vue/2.6.10/vue.js"></script>
<script src="//d3js.org/d3.v3.min.js"></script>

<!-- 地圖+收藏清單 css -->
<link rel="stylesheet" href="${contextRoot}/css/Index_map_favorite.css"> 
 
<!-- 測試 -->


</head>


<body>
	<%
	//避免jsp被瀏覽器cache
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

	response.setDateHeader("Expires", -1);
	%>
	<!--================Header 區 =================-->
	<header class="header_area">
		<div class="container">
			<!-- navbar導覽列bootstrap () 、 navbar-expand-xl|lg|md|sm 大小xl-->
			<nav class="navbar navbar-expand-lg navbar-light">
				<!-- 網站logo和導覽列在進行響應式時集中管理 -->
				<a class="navbar-brand logo_h" href="${contextRoot}/"><img
					src="${contextRoot}/image/logo.png" width="150px" alt=""></a>
				<!-- .navbar-brand 用於產品或專案名稱。 -->

				<!-- 網站標題或LOGO"(navbar-brand)及"響應按鈕"(navbar-toggle collapsed)，點擊觸發導覽列 id="navbarSupportedContent"-->
				<button class="navbar-toggler" type="button" data-toggle="collapse"
					data-target="#navbarSupportedContent"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<!-- 響應式網頁時的導覽列 end -->

				<!-- 導覽列links, forms, and other content for toggling -->
				<div class="collapse navbar-collapse offset"
					id="navbarSupportedContent">
					<ul class="nav navbar-nav menu_nav ml-auto">
						<li class="nav-item"><a class="nav-link"
							href="${contextRoot}/">首頁</a></li>
						<li class="nav-item"><a class="nav-link" href="#aboutUs">關於我們</a></li>
						<li class="nav-item"><a class="nav-link" href="#footer">聯絡我們</a></li>
						<li class="nav-item"><a class="nav-link"
							href="searchEmptyHotel?userId=${sessionScope.loginCustomer.userId}">住宿</a></li>

						<!-- 登入後導向首頁 並顯示會員以及登出按鈕 -->
						<c:choose>

							<c:when test="${loginCustomer != null}">

								<li class="nav-item active submenu dropdown"><a
									class="nav-link" href="#">${loginCustomer.userName}專區</a>
									<ul class="dropdown-menu">
										<li class="nav-item"><a class="nav-link"
											href="myAccountPage?userId=${loginCustomer.userId}">個人資訊</a></li>
										<li class="nav-item"><a class="nav-link"
											href="bookingList?userId=${loginCustomer.userId}">我的訂單</a></li>
										<li class="nav-item"><a class="nav-link"
											href="CommentList?userId=${loginCustomer.userId}">我的評論</a></li>
									</ul></li>
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
	<!--================Header 區 =================-->



	<!--================Banner 區 =================-->
	<section class="banner_area">
		<div class="booking_table d_flex align-items-center">
			<!--flex容器對齊-->
			<!--overlay 遮色片、bg-parallax視差效果-->
			>
			<div class="overlay bg-parallax" data-stellar-ratio="0.9"
				data-stellar-vertical-offset="0" data-background=""></div>
			<div class="container">
				<div class="banner_content text-center">
					<!-- <h6>尋找台灣住宿</h6> -->
					<h2>Travel with Us</h2>
					<p>超過19956間飯店、任君挑選</p>
					<a href="searchEmptyHotel?userId=${sessionScope.loginCustomer.userId}" class="btn theme_btn button_hover">Get Started</a>
				</div>
			</div>
		</div>
		<div class="hotel_booking_area position">
			<div class="container">
				<div class="hotel_booking_table">
					<div class="col-md-3">
						<h2>
							Book<br> Your Room
						</h2>
					</div>
					<div class="col-md-9">
						<div class="boking_table">
							<form action="searchEmptyHotel">

								<!-- 欄位一 -->
								<div class="row">
									<div class="col-md-6">
										<div class="book_tabel_item">
											<div class="form-group">
												<div class='input-group'>
													<input type="text" placeholder="你要去哪裡?" name="keyword"
														id="go_input" class="form-control wide" /> <span
														class="input-group-addon"> <i class="fa fa-car"
														aria-hidden="true"></i>
													</span>
												</div>
											</div>
										</div>
									</div>
									<div class="col-md-2 pl-md-0">
										<div class="book_tabel_item">
											<div class="form-group">
												<div class='input-group pl-0 pr-0'>
												
													<div class="form-outline">
														<input type="number" id="typeNumber" class="form-control" name="num" placeholder="人數" autocomplete="off"/>
													</div>
													
												</div>
											</div>
										</div>
									</div>


									<div class="col-md-4 pl-md-2">
										<div class="book_tabel_item">
											<div class="form-group ">
												<div class="form-check">
													<input type="checkbox" class="form-check-input" id="business" name="business">
													<label class="form-check-label" for="business">此為旅差行程</label></br>
													<span id="note" style="line-height: 10px;"></span>
												</div>
											</div>
										</div>
									</div>
								</div>

								<!-- 欄位一 -->
								<div class="row">

									<div class="col-md-4">
										<div class="book_tabel_item">
											<div class="form-group ">
												<div class='input-group date'>
													<input type='text' name="loginDate" class="form-control" id="datepicker1" 
														placeholder="入住日期" autocomplete="off" /> <span class="input-group-addon">
														<i class="fa-solid fa-calendar-days" aria-hidden="true"></i>
													</span>
												</div>
											</div>
										</div>
									</div>


									<div class="col-md-4 pl-0">
										<div class="book_tabel_item">
											<div class="form-group ">
												<div class='input-group date'>
													<input type='text' name="logoutDate" class="form-control" id="datepicker2" 
														placeholder="退房日期" autocomplete="off" /> <span class="input-group-addon">
														<i class="fa-solid fa-calendar-days"></i>
													</span>
												</div>
											</div>
										</div>
									</div>

									<div class="col-md-4">
										<div class="book_tabel_item">
											<button class="book_now_btn button_hover">Book Now</button>
										</div>
									</div>
									<input type="hidden" value="${sessionScope.loginCustomer.userId}" id="userId" name="userId"/>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--================Banner 區 =================-->

	

	<!--================ Accomodation Area 飯店房間 區  =================-->
	<section class="accomodation_area section_gap">
		<div class="container">
			<div class="section_title text-center" style="margin-bottom: 50px;">
				<h2 class="title_color">熱門飯店</h2>
				<h6 class="activity_subtitle_color">嚴選 TOP 4 熱門旅宿，更多熱門旅宿可更選擇</h6>
			</div>
			<div class="row mb_30" id="exhibit">
				<!-- 飯店一 -->

			</div>
		</div>
		<input type="hidden" value="${sessionScope.loginCustomer.userId}" id="userId"/>
	</section>
	<!--================ Accomodation Area  =================-->
	<!--================ 活動專區activity Area  =================-->
	<!--================ 活動專區activity Area  =================-->
	<!-- style.css .activity_area .bg-parallax 改 -->
    <section class="activity_area section_gap">
        <div class="overlay bg-parallax" data-stellar-ratio="0.8" data-stellar-vertical-offset="0" data-background="">
        </div>

            <div class="container">
                <div class="section_title text-center">
                    <h2 class="activity_title_color">熱門活動</h2>
                    <h6 class="activity_subtitle_color">台灣在地文化特色、習俗、熱門活動</h6>
                </div>
                <div class="row mb_30">
                    <!-- 活動一 -->
                    <div class="col-lg-3 col-sm-6">
                        <div class="activity_item text-center">
                            <div class="activity_img">
                                <img src="${contextRoot}/image/activity/activity1.jpg" alt="" style="width:280px;">
                                <a href="https://megaportfest.com/" class="btn theme_btn button_hover">更多內容</a>
                            </div>
                            <a href="#">
                                <h4 class="activity_h4">《2022&nbsp大港開唱》</h4>
                            </a>
                            <p style="color:#b2b2b2;">大港開唱（Megaport Festival）是高雄規模最大且以南台灣演出陣容為主之台灣獨立音樂節。</p>
                        </div>
                    </div>
                    <!-- 活動二 -->
                    <div class="col-lg-3 col-sm-6">
                        <div class="activity_item text-center">
                            <div class="activity_img">
                                <img src="${contextRoot}/image/activity/activity2.jpg" alt="" style="width:280px;">
                                <a href="https://kklivetw.kktix.cc/events/monet2021tpe" class="btn theme_btn button_hover">更多內容</a>
                            </div>
                            <a href="#">
                                <h4 class="activity_h4">《印象&nbsp莫內》</h4>
                            </a>
                            <p style="color:#b2b2b2;">「色彩是我永恆的迷戀、喜悅與折磨。」— 莫內. 被譽為「印象派之父」的莫內，終其一生實踐印象派美學。
                           </p>
                        </div>
                    </div>
                    <!-- 活動三 -->
                    <div class="col-lg-3 col-sm-6">
                        <div class="activity_item text-center">
                            <div class="activity_img">
                                <img src="${contextRoot}/image/activity/activity3.jpg"" alt="" style="width:280px;">
                                <a href="https://balloontaiwan.taitung.gov.tw/zh-tw" class="btn theme_btn button_hover">更多內容</a>
                            </div>
                            <a href="#">
                                <h4 class="activity_h4">《臺灣國際熱氣球嘉年華》</h4>
                            </a>
                            <p style="color:#b2b2b2;">2022臺灣國際熱氣球嘉年華
							《熱氣球為你加油》全國記者會</p>
                        </div>
                    </div>
                    <!-- 活動四 -->
                    <div class="col-lg-3 col-sm-6">
                        <div class="activity_item text-center">
                            <div class="activity_img">
                                <img src="${contextRoot}/image/activity/activity4.jpg" alt="" style="width:280px;">
                                <a href="https://www.pts.org.tw/memorymasterchi/" class="btn theme_btn button_hover">更多內容</a>
                            </div>
                            <a href="#">
                                <h4 class="activity_h4">《永遠的齊柏林紀念音樂會》</h4>
                            </a>
                            <p style="color:#b2b2b2;">一生不墬凌雲志，只留青天在人間
							台灣空拍攝影家齊柏林，自期以神的眼睛，記錄台灣的美麗與哀愁！</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>	



	<!--================ 活動專區activity Area  =================-->
	<!--================ map專區 map Area  =================-->
	<section class="activity_area section_gap" style="display: flex; justify-content: center; align-items: center; height: 600px;background-color:#04091E;">
	<!-- 地圖Hover -->
		<div class="mapcontainer mt-6" id="app">
	        <div style="flex:1; display: flex; flex-direction: column; justify-content: space-around; align-items: center;">
	        	<h2 style="flex: 3; color: white; font-weight: bold; display: flex; align-items: center;">你想去哪裡?</h2>
	        	<p style="margin:-10px;flex: 3; color: white; font-weight: normal; display: flex; align-items: center;font-size:14px">探訪這座美麗的島嶼，旅行者的秘境，細品台灣人文風貌</p>
	        	<div style="flex: 1; display: flex; justify-content: flex-end; width: 100%;">
	        		<div class="island" style="cursor: pointer;"><i class="fa-solid fa-sailboat" style="padding: 5px;"></i><span>離島</span></div> 
				</div>
				<div id="hid" style="flex: 3; display: flex; flex-direction: column; align-items:flex-end; width: 100%; ">
					<div class="hid"><a style="color: rgb(255, 255, 255);" href="http://localhost:8081/booking/searchEmptyHotel?keyword=金門">金門縣</a></div>
					<div class="hid"><a style="color: rgb(255, 255, 255);" href="http://localhost:8081/booking/searchEmptyHotel?keyword=澎湖">澎湖縣</a></div>
					<div class="hid"><a style="color: rgb(255, 255, 255);" href="http://localhost:8081/booking/searchEmptyHotel?keyword=連江">連江縣</a></div>
				</div>
	        </div>
	        <div class="taiwan-map" ref="map" style="flex: 0.5">
	            <div id="map">
	            	<svg id="svg" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid meet"></svg>
	          	</div>
	       	</div>
        	<div class="shop-list" style="flex: 1; margin-right: 100px;">
          		<h3>{{ h1 }}</h3>
          		<h3>{{ h2 }}</h3>
        	</div>
      	</div>

	</section>
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
	
	<!--================ Facilities Area  =================-->

	<!--================ About US Area  =================-->
	<section class="about_history_area section_gap" id="aboutUs">
		<div class="container">
			<div class="row">
				<div class="col-md-6 d_flex align-items-center">
					<div class="about_content ">
						<h2 class="title title_color">
							關於我們<br>Mission & Vision
						</h2>
						<p>專注於台灣在地文化、住宿，讓我們提供熱門景點及住宿優惠等熱門資訊，伴隨你一起享受旅行帶來的樂趣與驚喜吧!</p>
						<a href="searchEmptyHotel?userId=${sessionScope.loginCustomer.userId}" class="button_hover theme_btn_two">一起去旅行</a>
					</div>
				</div>
				<div class="col-md-6">
					<img class="img-fluid" src="${contextRoot}/image/aboutUs/aboutUs.jpg"
						alt="img">
				</div>
			</div>
		</div>
	</section>
	<!--================ About US Area  =================-->


	<!--================ start footer Area  =================-->
	<footer class="footer-area section_gap" id="footer">
		<div class="container">
			<div class="row">
				<div class="col-lg-3 col-md-6 col-sm-6">
					<div class="single-footer-widget">
						<h6 class="footer_title">Contact Us</h6>
						<div class="row">
							<div class="col-10">
								<ul class="list_style">
									<li>電話: (+886)xxx-xxxxxx</li>
									<li>地址: 台南市O區O路O號O樓</li>
									<li>Email: Formosa@gmail.com</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 col-sm-6">
					<div class="single-footer-widget">
						<h6 class="footer_title">訂閱電子報</h6>
						<p>歡迎訂閱電子報獲得更多優惠訊息</p>
						<div id="mc_embed_signup">
							<form target="_blank"
								action="https://spondonit.us12.list-manage.com/subscribe/post?u=1462626880ade1ac87bd9c93a&amp;id=92a4423d01"
								method="get" class="subscribe_form relative">
								<div class="input-group d-flex flex-row">
									<input name="EMAIL" placeholder="Email Address"
										onfocus="this.placeholder = ''"
										onblur="this.placeholder = 'Email Address '" required=""
										type="email">
									<button class="btn sub-btn">
										<i class="fa-solid fa-paper-plane"></i>
									</button>

								</div>
								<div class="mt-10 info"></div>
							</form>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 col-sm-6">
					<div class="single-footer-widget">
						<h6 class="footer_title">
							<a href="adminLoginForm"> 登入後台 </a>
						</h6>

						<!-- <div class="col-4">
                                    <ul class="list_style">
                                        <li><a href="#">Team</a></li>
                                        <li><a href="#">Pricing</a></li>
                                        <li><a href="#">Blog</a></li>
                                        <li><a href="#">Contact</a></li>
                                    </ul>
                                </div> -->

					</div>
				</div>
			</div>


			<div class="border_line"></div>
			<div
				class="row footer-bottom d-flex justify-content-between align-items-center">
				<p class="col-lg-8 col-sm-12 footer-text m-0">

					Copyright &copy;
					<script>
						document.write(new Date().getFullYear());
					</script>
					All rights reserved | <span>FormosaBooking</span>

				</p>
			</div>
		</div>
	</footer>
	<!--================ End footer Area  =================-->


	<!-- Optional JavaScript -->
	<!-- jQuery先,再來 Popper.js, then Bootstrap JS -->

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

	<script src="${contextRoot}/js/popper.js"></script>

	<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
	<!--圖片輪播-->
	<script src="${contextRoot}/vendors/owl-carousel/owl.carousel.min.js"></script>
	<!--ajachimp待處理-->
	<script src="${contextRoot}/js/jquery.ajaxchimp.min.js"></script>
	<script src="${contextRoot}/js/mail-script.js"></script>
	<!--日期選單-->

	<!--下拉選單-->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js"></script>

	<!-- 視差滾動（Parallax Scrolling）-->
	<script src="${contextRoot}/js/stellar.js"></script>
	<!--燈箱效果-->
	<script src="${contextRoot}/vendors/lightbox/simpleLightbox.min.js"></script>
	<!--自定義-->
	<script src="${contextRoot}/js/custom.js"></script>
	<!-- jquery-ui  autocomplete 用 -->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

	<!-- 首頁的Datepicker -->
	<script src="${contextRoot}/js/indexDatePicker.js"></script>
		
	<!-- 載入首頁飯店資訊 -->
	<script src="${contextRoot}/js/indexHotelInfo.js"></script>	
		
	<!-- 首頁收藏 -->
	<script src="${contextRoot}/js/indexFavorite.js"></script>	
	
	<!-- 有關地圖 -->
	<script>
		const TaiwanMap = new Vue({
			el: '#app',
			data: {
				h1: '選擇區域',
				h2: 'Choose Your Destination'
			},
			methods: {
			    async getTaiwanMap() {
			      	const width = (this.$refs.map.offsetWidth).toFixed(),
			            height = (this.$refs.map.offsetHeight).toFixed();
	
			      	// 判斷螢幕寬度，給不同放大值
			      	let mercatorScale, w = window.screen.width;
			      	mercatorScale = 6500;
	
			      	// d3：svg path 產生器
			      	var path = await d3.geo.path().projection(
			        // !important 座標變換函式
			        d3.geo
			          .mercator()
			          .center([121,24])
			          .scale(mercatorScale)
			          .translate([width/2, height/2.5])
			    	);
			    	// 讓d3抓svg，並寫入寬高
			    	var svg = await d3.select('#svg')
			        	.attr('width', width)
			          	.attr('height', height)
			          	.attr('viewBox', `0 0 ${width} ${height}`);
			      
			      	// 讓d3抓GeoJSON檔，並寫入path的路徑
			      	var url = 'src/taiwan.geojson';
			      	await d3.json(url, (error, geometry) => {
			        if (error) throw error;
			        	svg
			          	.selectAll('path')
			         	.data(geometry.features)
			          	.enter().append('path')
			          	.attr('d', path)
			          	.attr({
			            	// 設定id，為了click時加class用
			           	 	id: (d) => 'city' + d.properties.COUNTYCODE
			          	})
			          	.on('mouseenter', d => {
			            	this.h1 = d.properties.COUNTYNAME; // 換中文名
			            	this.h2 = d.properties.COUNTYENG; // 換英文名
			            	// 有 .active 存在，就移除 .active
			            	if(document.querySelector('.active')) {
			              		document.querySelector('.active').classList.remove('active');
			            	}
			            // 被點擊的縣市加上 .active
			            document.getElementById('city' + d.properties.COUNTYCODE).classList.add('active');
			          })
			          
			          .on('click', d => {
			            	window.location.href="http://localhost:8081/booking/searchEmptyHotel?keyword="+d.properties.COUNTYNAME
			          })
			      });
			      return svg;
				},
			},
			mounted() {
			    this.getTaiwanMap();
			}
		})
		
		$('.hid').css('display','none')
		
		$('.island').mouseenter(function(){
			$(document.getElementsByClassName('hid')).css('display','block')
			$(document.getElementsByClassName('hid')).attr('class','visiable')
		})
		$('.island').mouseleave(function(){
			// $('.visiable').mouseenter(function(){
			// 	$('.visiable').mouseleave(function(){
			// 		setTimeout(function(){
			// 			$(document.getElementsByClassName('visiable')).attr('class','hid')
			// 		},1000);
			// 	})
			// })
			setTimeout(function(){
				$(document.getElementsByClassName('visiable')).attr('class','hid')
				setTimeout(() => {
					$('.hid').css('display','none')				
				}, 500);
			},3000);
			
			clearTimeout();
			
		})
	</script>
</body>

</html>