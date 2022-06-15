<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<jsp:include page="layout/default.jsp" />
<head>
<meta charset="UTF-8">
<title>搜尋結果</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css">
<!-- css -->
<link rel="stylesheet" href="${contextRoot}/css/hotelPage.css">

</head>
<body>
	<br>
	<div style="display: flex; justify-content: center;">
		<div id="allTag" style="width: 250px; margin-right: 20px; padding: 5px; ">
			<!-- 搜尋列 -->
			<div class="searchingblock">
				<div>
					<form action="searchEmptyHotel" style="padding: 20px;">
						<div style="border-bottom: 1px solid rgb(196, 196, 196); margin-bottom: 12px;"><h5>搜尋</h5></div>
						<div>
							<label for="keyword" class="inputlabel">目的地:</label>
							<input type="text" class="searchinginput" value="${keyword}" placeholder="${keyword}" name="keyword" style=" width: 100%;">
						</div>
						<div>
							<div>
								<label for="loginday" class="inputlabel">入住日:</label><br>
								<input type="date" class="searchinginput" name="loginDate" id="logindate" placeholder="${loginDate}" value="${loginDate}" style="width:100%;">
							</div>
							<div>
								<label for="logoutday" class="inputlabel">退房日:</label><br>
								<input type="date" class="searchinginput" name="logoutDate" id="logoutdate" placeholder="${logoutDate}" value="${logoutDate}" style="width:100%;">                            
							</div>
							
							<div>
								<label for="num" class="inputlabel">人數:</label><br>
								<input type="number" class="searchinginput"  min="0" max="10" step="1" name=num value="${num}"/>
							</div>
							<div>
								<div style="line-height: 10px;">
									<c:if test="${business != 'on'}">
										<input type="checkbox" class="searchinginput" name="business" id="business">
									</c:if>
									<c:if test="${business == 'on'}">
										<input type="checkbox" class="searchinginput" name="business" id="business" checked="checked">
									</c:if>
									<label for="business" class="inputlabel" style="margin-top: 10px;">此為差旅行程</label>
								</div>
								<!-- 點擊提醒 -->
								<div id="note"><br id="show"></div>
								<div>
									<span><button type="submit" class="submit" style="width:100%; height: 50px;">搜尋</button></span>
								</div>
							</div>
						</div>    
						<input type="hidden" value="${sessionScope.loginCustomer.userId}" id="userId" name="userId"/>
					</form>
				</div>
			</div>
			<div  class="tagblock">
				<div style="border-bottom: 1px solid rgb(196, 196, 196);"><h5>透過以下標籤搜尋：</h5></div>
				<div style="margin-top: 16px;">
					<div><input type="checkbox" class="tag" id="tag1" value="餐廳"><label for="tag1"><span>餐廳</span></label></div>
					<div><input type="checkbox" class="tag" id="tag2" value="酒吧"><label for="tag2"><span>酒吧</span></label></div>
					<div><input type="checkbox" class="tag" id="tag3" value="商店"><label for="tag3"><span>商店</span></label></div>
					<div><input type="checkbox" class="tag" id="tag4" value="宴會廳"><label for="tag4"><span>宴會廳</span></label></div>
					<div><input type="checkbox" class="tag" id="tag5" value="咖啡廳"><label for="tag5"><span>咖啡廳</span></label></div>
					<div><input type="checkbox" class="tag" id="tag6" value="無線網路"><label for="tag6"><span>無線網路</span></label></div>
					<div><input type="checkbox" class="tag" id="tag7" value="停車場"><label for="tag7"><span>停車場</span></label></div>
					<div><input type="checkbox" class="tag" id="tag8" value="游泳池"><label for="tag8"><span>游泳池</span></label></div>
					<div><input type="checkbox" class="tag" id="tag9" value="健身房"><label for="tag9"><span>健身房</span></label></div>
					<div><input type="checkbox" class="tag" id="tag10" value="兒童遊樂設施"><label for="tag10"><span>兒童遊樂設施</span></label></div>
					<div><input type="checkbox" class="tag" id="tag11" value="室內遊樂設施"><label for="tag11"><span>室內遊樂設施</span></label></div>
					<div><input type="checkbox" class="tag" id="tag12" value="體驗活動"><label for="tag12"><span>體驗活動</span></label></div>
					<div><input type="checkbox" class="tag" id="tag13" value="自行車友善旅宿"><label for="tag13"><span>自行車友善旅宿</span></label></div>
					<div><input type="checkbox" class="tag" id="tag14" value="iTaiwan"><label for="tag14"><span>iTaiwan</span></label></div>
					<div><input type="checkbox" class="tag" id="tag15" value="溫泉設施"><label for="tag15"><span>溫泉設施</span></label></div>
					<div><input type="checkbox" class="tag" id="tag16" value="國民旅遊卡"><label for="tag16"><span>國民旅遊卡</span></label></div>
					<div><input type="checkbox" class="tag" id="tag17" value="接送服務"><label for="tag17"><span>接送服務</span></label></div>
					<div><input type="checkbox" class="tag" id="tag18" value="導覽解說"><label for="tag18"><span>導覽解說</span></label></div>
					<div><input type="checkbox" class="tag" id="tag19" value="會議場所"><label for="tag19"><span>會議場所</span></label></div>
					<div><input type="checkbox" class="tag" id="tag20" value="商務旅遊中心"><label for="tag20"><span>商務旅遊中心</span></label></div>
					<div><input type="checkbox" class="tag" id="tag21" value="有線網路"><label for="tag21"><span>有線網路</span></label></div>
					<div><input type="checkbox" class="tag" id="tag22" value="上網電腦"><label for="tag22"><span>上網電腦</span></label></div>
					<div><input type="checkbox" class="tag" id="tag23" value="郵電服務"><label for="tag23"><span>郵電服務</span></label></div>
					<div><input type="checkbox" class="tag" id="tag24" value="自行車租借"><label for="tag24"><span>自行車租借</span></label></div>
					<div><input type="checkbox" class="tag" id="tag25" value="洗衣服務"><label for="tag25"><span>洗衣服務</span></label></div>
					<div><input type="checkbox" class="tag" id="tag26" value="自助洗衣"><label for="tag26"><span>自助洗衣</span></label></div>
					<div><input type="checkbox" class="tag" id="tag27" value="高齡房"><label for="tag27"><span>高齡房</span></label></div>
					<div><input type="checkbox" class="tag" id="tag28" value="無障礙"><label for="tag28"><span>無障礙</span></label></div>
					<div><input type="checkbox" class="tag" id="tag29" value="貴重物品保管專櫃"><label for="tag29"><span>貴重物品保管專櫃</span></label></div>
					<div><input type="checkbox" class="tag" id="tag30" value="行動支付"><label for="tag30"><span>行動支付</span></label></div>
				</div>
			</div>
		</div>
		<div id="rightside">
			<div style="font-size: 20px; margin-bottom: 20px;">
				<c:if test='${keyword!=""}'>
					<span><b>${keyword}:找到</b></span>
				</c:if>
				<c:if test='${keyword==""}'>
					<span><b>台灣:找到</b></span>
				</c:if>
				<b><span id="count2">
					<span id="count1">${hotelPage.totalElements}</span>
				</span></b>
				<span><b>間住宿</b></span>
			</div>
			<c:if test="${hotelPage.totalElements == 0}">
				<div style="color:red;"><b>暫無相關住宿,請重新查詢</b></div>
			</c:if>
			
			<c:if test="${hotelPage.totalElements > 0}">
				<div style="display: flex;">
					<button id="orderByScoreDESC" class="orderbtn">評分由高至低</button>
					<button id="orderByScoreASC" class="orderbtn">評分由低至高</button>
					<button id="orderByPriceDESC" class="orderbtn">價格由高至低</button>
					<button id="orderByPriceASC" class="orderbtn">價格由低至高</button>
				</div>
				<!-- 	page結果 -->
				<div id="searchResults2">
					<div id="searchResults" style="width: 800px;">
						<c:if test="${!empty hotelPage}">
							<c:forEach items="${hotelPage.content}" var="hotel">
								<c:set var="imgArr" value="${fn:split(hotel.pics , ',')}"/>
								<div style="display: flex;" class="hotelblock">
									<div class="hotelimgf">
										<c:forEach begin="0" end="0" items="${imgArr}" var="img">
											<a href="hotelDetail?keyword=${keyword}&id=${hotel.hotelId}&loginDate=${loginDate}&logoutDate=${logoutDate}&num=${num}&business=${business}&userId=${sessionScope.loginCustomer.userId}"><img src="${img}" class="hotelimgb"></a>
										</c:forEach>
									</div>
									<div class="hotelinfof">
										<div class="hotelinfob">
											<div style="flex: 4.5;">
												<div><a class="atext" href="hotelDetail?keyword=${keyword}&id=${hotel.hotelId}&loginDate=${loginDate}&logoutDate=${logoutDate}&num=${num}&business=${business}&userId=${sessionScope.loginCustomer.userId}"><span><h4>${hotel.hotelName}</h4></span></a></div>			
												<div>
													<a href="${contextRoot}/">
														<span>首頁</span>
													</a>
													<i class="fa-solid fa-angle-right"></i>
													<a href="searchEmptyHotel?keyword=&loginDate=${loginDate}&logoutDate=${logoutDate}&num=${num}&business=${business}&userId=${sessionScope.loginCustomer.userId}">
														<span>台灣</span>
													</a>
													<i class="fa-solid fa-angle-right"></i>
													<a href="searchEmptyHotel?keyword=${hotel.region}&loginDate=${loginDate}&logoutDate=${logoutDate}&num=${num}&business=${business}&userId=${sessionScope.loginCustomer.userId}" id="region1">
														<span>${hotel.region}</span>
													</a>
													<i class="fa-solid fa-angle-right"></i>
													<a href="searchEmptyHotel?keyword=${hotel.town}&loginDate=${loginDate}&logoutDate=${logoutDate}&num=${num}&business=${business}&userId=${sessionScope.loginCustomer.userId}" id="town1">
														<span>${hotel.town}</span>
													</a>
												</div>	
											</div>
											<!-- 我的最愛 -->
											<div style="flex: 4.5; display: flex;align-items: flex-start; justify-content: flex-end; background-color: white;width: 240px;">
											<c:if test="${sessionScope.loginCustomer != null}">
													<button  style="border:0px; background-color: white;">
														<c:if test="${(fn:contains(user.favorite,hotel.hotelId)) == false}">
															<i class="fa-solid fa-heart addfavorite" id="${hotel.hotelId}"></i>
														</c:if>
														<c:if test="${fn:contains(user.favorite,hotel.hotelId)}">
															<i class="fa-solid fa-heart removefavorite" id="${hotel.hotelId}"></i>
														</c:if>
													</button>
												</c:if>
											</div>			

											<div class="hotelrating" style="flex: 0.6;">
												<a href="hotelDetail?keyword=${keyword}&id=${hotel.hotelId}&loginDate=${loginDate}&logoutDate=${logoutDate}&num=${num}&business=${business}&userId=${sessionScope.loginCustomer.userId}"><span>${hotel.averageRating}</span></a>
											</div>				
										</div>
										<div class="hotelinfob">
											<div class="hoteldescrib">${hotel.description}</div>
											<div class="hoteldetail">
												<div style="font-size: 12px; color:gray;">最低價格<div style="color:#444444;"><h5>TWD${hotel.lowestPrice}起/晚</h5></div></div>
												<div><a href="hotelDetail?keyword=${keyword}&id=${hotel.hotelId}&loginDate=${loginDate}&logoutDate=${logoutDate}&num=${num}&business=${business}&userId=${sessionScope.loginCustomer.userId}"><button class="submit" style="padding:10px;">查看客房供應情況</button></a></div>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
							<!-- 以下換頁鈕 -->
							<div class="btnf">
								<!-- 左切 -->
								<div>
									<c:if test="${hotelPage.number!=0}">
										<button type="button" class="pageBtn" value="${hotelPage.number}"><b>＜</b></button>
									</c:if>
									<c:if test="${hotelPage.number==0}">
										<button type="button" class="pageBtn clickedbtn" value="${hotelPage.number}" disabled="disabled"><b>＜</b></button> 
									</c:if>
								</div>
								<div>
									<!-- 頁數小於5 -->
									<c:if test="${hotelPage.totalPages<=5}">
										<c:forEach var="pageNumber" begin="1" end="${hotelPage.totalPages}">
											<c:choose>
												<c:when  test="${hotelPage.number != pageNumber-1 }">
													<button type="button" class="pageBtn" value="${pageNumber}">${pageNumber}</button>
												</c:when>
													
												<c:otherwise>
													<button type="button" class="pageBtn clickedbtn" disabled="disabled">${pageNumber}</button> 
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</c:if>
									<!-- 頁數大於5 -->
									<c:if test="${hotelPage.totalPages>5}">
										<c:choose>
											<c:when test="${hotelPage.number==0 || hotelPage.number==1}">
												<c:forEach var="pageNumber" begin="1" end="${hotelPage.number+5}" step="1">
													<c:choose>
														<c:when  test="${hotelPage.number != pageNumber-1 }">
															<button type="button" class="pageBtn" value="${pageNumber}">${pageNumber}</button>
														</c:when>
														<c:otherwise>
															<button type="button" class="pageBtn clickedbtn" disabled="disabled">${pageNumber}</button> 
														</c:otherwise>
													</c:choose>
												</c:forEach>
												<span><b>...</b></span>
												<button type="button" class="pageBtn" value="${hotelPage.totalPages}">${hotelPage.totalPages}</button>
											</c:when>							
											<c:when test="${hotelPage.number==hotelPage.totalPages || hotelPage.number==hotelPage.totalPages-1}">
												<button type="button" class="pageBtn" value="1">1</button> 
												<span><b>...</b></span>
												<c:forEach var="pageNumber" begin="${hotelPage.totalPages-4}" end="${hotelPage.totalPages}" step="1">
													<c:choose>
														<c:when  test="${hotelPage.number != pageNumber-1 }">
															<button type="button" class="pageBtn" value="${pageNumber}">${pageNumber}</button>
														</c:when>
														<c:otherwise>
															<button type="button" class="pageBtn clickedbtn" disabled="disabled">${pageNumber}</button> 
														</c:otherwise>
													</c:choose>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<button type="button" class="pageBtn" value="1">1</button> 
												<span><b>...</b></span>
												<c:forEach var="pageNumber" begin="${hotelPage.number-1}" end="${hotelPage.number+3}" step="1">
													<c:choose>
														<c:when  test="${hotelPage.number != pageNumber-1 }">
															<button type="button" class="pageBtn" value="${pageNumber}">${pageNumber}</button> 
														</c:when>
														<c:otherwise>
															<button type="button" class="pageBtn clickedbtn" disabled="disabled">${pageNumber}</button> 
														</c:otherwise>
													</c:choose>
												</c:forEach>
												<span><b>...</b></span>		
												<button type="button" class="pageBtn" value="${hotelPage.totalPages}">${hotelPage.totalPages}</button>				
											</c:otherwise>	
										</c:choose>
									</c:if>
								</div>
								<!-- 右切 -->
								<div>
									<c:if test="${hotelPage.number!=hotelPage.totalPages}">
										<button type="button" class="pageBtn" value="${hotelPage.number+2}"><b>＞</b></button>
									</c:if>
									<c:if test="${hotelPage.number==hotelPage.totalPages}">
										<button type="button" class="pageBtn clickedbtn" value="${hotelPage.number}" disabled="disabled"><b>＞</b></button> 
									</c:if>
								</div>
							</div>
								
							<c:if test="${!empty keyword}">
								<input type="hidden" value="${keyword}" id="keyword"/>
							</c:if>
							<c:if test="${empty keyword}">
								<input type="hidden" value="" id="keyword"/>
							</c:if>
							<input type="hidden" value="${sessionScope.loginCustomer.userId}" id="userId"/>
							<input type="hidden" value="${loginDate}" id="loginDate"/>
							<input type="hidden" value="${logoutDate}" id="logoutDate"/>
							<input type="hidden" value="${num}" id="num"/>
							<input type="hidden" value="${order}" id="order"/>
							<input type="hidden" value="${orderby}" id="orderby"/>
							<input type="hidden" value="${business}" id="forbusiness"/>
						</c:if>
					</div>
				</div>
			</c:if>
		</div>
	</div>
	<div>
		<dialog id="searching">
			<div>搜尋中...</div>
		</dialog>
	</div>
	
<!-- footer star-->
<jsp:include page="layout/footer.jsp" />
<!-- footer end-->

	<!-- 關於搜尋/排序按鈕 -->
	<script src="${contextRoot}/js/hotelPage.js"></script>

	<!-- 日期控制 -->
	<script src="${contextRoot}/js/hotelPageDateController.js"></script>

	<!-- 我的最愛 -->
	<script src="${contextRoot}/js/hotelPageFavorite.js"></script>
</body>
</html>