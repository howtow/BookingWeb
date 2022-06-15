<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<jsp:include page="layout/default.jsp" />
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css">
<link href="${contextRoot}/css/bootstrap.min.css" rel="stylesheet">
<!-- 輪播 -->
<link href="${contextRoot}/css/slick-theme.css" rel="stylesheet">
<link href="${contextRoot}/css/slick.css" rel="stylesheet">

<!-- css -->
<link rel="stylesheet" href="${contextRoot}/css/hotelInfo.css">

</head>
<body>
	<br>
	<div style="display: flex; justify-content: center;">
		<!-- 上方路徑 -->
		<div style="width: 1050px;">
			<a href="/booking"> <span>首頁</span>
			</a> <i class="fa-solid fa-angle-right"></i> <a href="selectAllHotel">
				<span>台灣(所有住宿)</span>
			</a> <i class="fa-solid fa-angle-right"></i> <a
				href="searchEmptyHotel?keyword=${hotel.region}&loginDate=${loginDate}&logoutDate=${logoutDate}&num=${num}&business=${business}&userId=${sessionScope.loginCustomer.userId}"
				id="region1"> <span>${hotel.region}</span>
			</a> <i class="fa-solid fa-angle-right"></i> <a
				href="searchEmptyHotel?keyword=${hotel.town}&loginDate=${loginDate}&logoutDate=${logoutDate}&num=${num}&business=${business}&userId=${sessionScope.loginCustomer.userId}"
				id="town1"> <span>${hotel.town}</span>
			</a> <i class="fa-solid fa-angle-right"></i> <span> <span>${hotel.hotelName}</span>
			</span>
		</div>
	</div>
	<br>
	<div style="display: flex; justify-content: center; margin: 0 auto;">
		<div>
			<!-- 飯店資訊 -->
			<div>
				<div style="display: flex; justify-content: center;">
					<div style="display: flex; width: 1050px;">
						<!-- 搜尋列 -->
						<div style="width: 250px; padding: 5px; height: 620px;"
							class="searchingblock">
							<div>
								<form action="searchEmptyHotel"
									style="height: 415px; padding: 20px;">
									<div
										style="border-bottom: 1px solid rgb(196, 196, 196); margin-bottom: 12px;">
										<h5>搜尋</h5>
									</div>
									<div>
										<label for="keyword" class="inputlabel">目的地:</label> <input
											type="text" class="searchinginput" value="${keyword}"
											placeholder="${keyword}" name="keyword" style="width: 100%;">
									</div>
									<div>
										<div>
											<label for="loginday" class="inputlabel">入住日:</label><br>
											<input type="date" class="searchinginput logindate"
												name="loginDate" id="logindate" placeholder="${loginDate}"
												value="${loginDate}" style="width: 100%;">
										</div>
										<div>
											<label for="logoutday" class="inputlabel">退房日:</label><br>
											<input type="date" class="searchinginput logoutdate"
												name="logoutDate" id="logoutdate"
												placeholder="${logoutDate}" value="${logoutDate}"
												style="width: 100%;">
										</div>

										<div>
											<label for="num" class="inputlabel">人數:</label><br> <input
												type="number" class="searchinginput" min="0" max="10"
												step="1" name=num value="${num}" />
										</div>
										<div>
											<div style="line-height: 10px; margin-top: 5px;">
												<c:if test="${business != 'on'}">
													<input type="checkbox" class="searchinginput business"
														name="business">
												</c:if>
												<c:if test="${business == 'on'}">
													<input type="checkbox" class="searchinginput business"
														name="business" checked="checked">
												</c:if>
												<label for="business" class="inputlabel"
													style="margin-top: 10px;">此為差旅行程</label>
											</div>
											<!-- 點擊提醒 -->
											<div class="note">
												<br class="show">
											</div>
											<hr>
											<div style="margin-top: 15px;">
												<span><button type="submit" class="submit"
														style="width: 100%; height: 50px;">搜尋</button></span>
											</div>
										</div>
									</div>
									<input type="hidden"
										value="${sessionScope.loginCustomer.userId}" id="userId"
										name="userId" />
								</form>
							</div>
							<!-- 放OpenStreetMap地圖 -->
							<div style="margin-top: 10px;">
								<div style="height: 150px; z-index: 1" id="map"></div>
								<div style="font-size: 6px;">地圖資訊由© OpenStreetMap提供</div>
							</div>
						</div>

						<!-- 區塊轉跳+照片陳列+評論 -->
						<div>
							<!-- 區塊轉跳 -->
							<div>
								<ul id="ul">
									<li class="block" id="goDescription"><a
										style="text-decoration: none;">資訊&房價</a></li>
									<li class="block" id="goRoom"><a
										style="text-decoration: none;">查看客房</a></li>
									<li class="block" id="goNotice"><a
										style="text-decoration: none;">訂房須知</a></li>
									<li class="block" id="goComment"><a
										style="text-decoration: none;">房客評價</a></li>
								</ul>
							</div>

							<!-- 房名+評論+地址 -->
							<div class="searchingblock"
								style="margin-left: 40px; padding: 20px 20px 10px 20px;">
								<div>
									<div id="title" style="display: flex; align-items: center;">
										<span style="flex: 4.5;"><h3>${hotel.hotelName}</h3></span>

										<!-- 我的最愛 -->
										<div
											style="flex: 4.5; display: flex; align-items: flex-start; justify-content: flex-end; background-color: white; width: 240px;">
											<c:if test="${sessionScope.loginCustomer != null}">
												<button style="border: 0px; background-color: white;">
													<c:if
														test="${(fn:contains(user.favorite,hotel.hotelId)) == false}">
														<i class="fa-solid fa-heart addfavorite"
															id="${hotel.hotelId}"></i>
													</c:if>
													<c:if test="${fn:contains(user.favorite,hotel.hotelId)}">
														<i class="fa-solid fa-heart removefavorite"
															id="${hotel.hotelId}"></i>
													</c:if>
												</button>
												<input type="hidden"
													value="${sessionScope.loginCustomer.userId}" id="userId" />
											</c:if>
										</div>

										<div style="display: flex; flex: 1.8;">
											<div>
												<div class="rate"></div>
												<div style="font-size: 10px;">
													<a class="showComment" style="text-decoration: none;">${commentSize}則評論</a>
												</div>
											</div>
											<div style="margin-top: 10px">
												<span
													style="background-color: rgb(22, 22, 88); font-size: 20px; height: 35px; width: 35px; padding-left: 2px; padding: 5px; border-radius: 5px 5px 5px 0px;"><a
													class="showComment"
													style="text-decoration: none; color: #ffffff;">${hotel.averageRating}</a></span>
											</div>
										</div>
									</div>
									<span id="show"><a><i
											class="fa-solid fa-location-dot"></i>${hotel.add}--點擊顯示大地圖</a></span><br>
								</div>
								<!-- 照片陳列 -->
								<div style="display: flex;">
									<span style="width: 450px; height: 450px; overflow: hidden;"><img
										id="img1" src="${pics[0]}"></span> <span>
										<div style="width: 250px; height: 225px; overflow: hidden;">
											<img id="img2" src="${pics[1]}">
										</div>
										<div style="width: 250px; height: 225px; overflow: hidden;">
											<img id="img3" src="${pics[2]}">
										</div>
									</span>
								</div>
							</div>
						</div>
					</div>
				</div>
				<br>
				<!-- 飯店描述+OpenStreetMap -->
				<div style="display: flex; justify-content: center;">
					<div class="searchingblock" id="description"
						style="width: 1030px; display: flex; justify-content: space-between; margin-right: 20px; padding: 20px;">
						<div
							style="display: flex; flex-direction: column; justify-content: space-between; width: 700px;">
							<div>${hotel.description}</div>
							<div>
								<br>
								<div>熱門標籤:</div>
								<div id="tag"></div>
								<input type="hidden" value="${hotel.serviceinfo}"
									id="serviceinfo">
							</div>
						</div>
						<div style="width: 260px;">
							<div style="height: 100px; text-align: right;">
								廣告/折扣資訊: <br>xxxxxxxxxxxxxxxxxxxx <br>xxxxxxxxxxxxxxxxxxxx
								<br>xxxxxxxxxxxxxxxxxxxx
							</div>
							<div
								style="padding: 10px; background-color: rgba(179, 199, 255, 0.384);">
								<div style="color: green;">
									<b>※提供的資訊很可靠</b>
								</div>
								<div style="font-size: 10px;">住客認為此住宿的簡介與相片符合實際情況。</div>
							</div>
						</div>
					</div>
				</div>

				<div style="display: flex; justify-content: center;">
					<!-- 查詢空房 -->
					<div class="searchingblock"
						style="width: 1030px; margin: 10px 20px 0px 0px; border-color: rgba(255, 208, 0, 0.74); background-color: rgba(255, 208, 0, 0.74);">
						<form action="searchEmptyHotel"
							style="background-color: rgba(255, 208, 0, 0.897); padding: 20px;">
							<div>
								<h4>空房情況</h4>
							</div>
							<hr style="margin-top: 0px;">
							<div">
								<div>
									<b><p
											style="font-size: 16px; color: #000000; font-weight: normal;">您預計什麼時候入住?</p></b>
								</div>
								<div>
									<b><p
											style="line-height: 5px; font-size: 16px; color: #000000;">輸入日期查看空房</p></b>
								</div>
								<div id="emptyRoom" style="display: flex;">
									<span
										style="margin-right: 10px; margin-top: 15px; display: flex; flex: 1.5;">
										<span><b><p
													style="font-size: 16px; color: #000000; font-weight: normal;">入住日期:</p></b></span>
										<span><input type="date" style="width: 150px;"
											name="loginDate" class="logindate searchinginput"
											placeholder="${loginDate}" value="${loginDate}"></span>
									</span> <span style="margin-top: 15px; display: flex; flex: 1.5;">
										<span><b><p
													style="font-size: 16px; color: #000000; font-weight: normal;">退房日期:</p></b></span>
										<span><input type="date" style="width: 150px;"
											name="logoutDate" class="logoutdate searchinginput"
											placeholder="${logoutDate}" value="${logoutDate}"> </span>
									</span> <span style="flex: 0.7; margin-top: 15px;"> <c:if
											test="${business != 'on'}">
											<input type="checkbox" name="business"
												class="business searchinginput">
										</c:if> <c:if test="${business == 'on'}">
											<input type="checkbox" name="business"
												class="business searchinginput" checked="checked">
										</c:if> <label for="business" class="inputlabel">此為差旅行程</label>
									</span> <span class="note" style="flex: 1; margin-top: 15px;"><span
										class="show"><br></span></span> <span
										style="display: flex; flex: 1; height: 45px;"> <input
										type="submit" class="submit" value="查看客房供應情況"
										style="height: 100%; width: 100%;">
									</span>
								</div>
							</div>
							<input type="hidden" value="${num}" name="num" /> <input
								type="hidden" value="${keyword}" name="keyword" /> <input
								type="hidden" value="${sessionScope.loginCustomer.userId}"
								id="userId" name="userId" />
						</form>
					</div>
				</div>
				<!-- 房間資訊+訂房按鈕 -->
				<div id="roomList"
					style="margin-top: 20px; border: 1px solid rgb(136, 136, 255); width: 1030px; margin: 20px 20px 20px 0px; border-radius: 3px; box-shadow: 0 0 8px #979797; background-color: #fff;">
					<form action="showBooking" method="post" id="bookingfrom"
						enctype="multipart/form-data">
						<div id="room_left">
							<table>
								<thead id="leftNav">
									<tr
										style="height: 30px; background-color: #004cb8; color: #ffffff; font-size: 14px;">
										<th style="width: 400px; padding: 6px 8px;">房型</th>
										<th
											style="width: 100px; text-align: center; padding: 6px 8px;">適合人數</th>
										<c:if test="${between==1 || between==0}">
											<th
												style="width: 120px; text-align: center; padding: 6px 8px;">今日價格</th>
										</c:if>
										<c:if test="${between>1}">
											<th
												style="width: 120px; text-align: center; padding: 6px 8px;">${between}晚價格</th>
										</c:if>
										<th
											style="width: 100px; text-align: center; padding: 6px 8px;">預訂須知</th>
										<th
											style="width: 100px; text-align: center; padding: 6px 8px;">選擇數量</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${roomList}" var="room">
										<tr>
											<td style="padding: 8px;">
												<div>
													<a class="roomimg" id="${room.roomId}">${room.roomName}</a>
												</div>
												<div
													style="overflow-wrap: normal; display: flex; flex-wrap: wrap;">
													<c:set var="taglist" value="${fn:split(room.tag,',')}" />
													<c:forEach items="${taglist}" var="tag">
														<div
															style="border: 0.5px solid #9dbed6; background-color: #d2ecff; color: #000000; padding: 3px; margin: 1px; border-radius: 3px; font-size: 8px;">
															<i class="fa-solid fa-check"></i>${tag}</div>
													</c:forEach>
												</div>
											</td>
											<!-- 建議人數 -->
											<td style="padding: 6px 8px;">
												<div style="text-align: center;">
													<span><i class="fa-solid fa-person"></i></span> <span>X</span>
													<span>${room.capaticy}</span>
												</div>
											</td>

											<td style="padding: 6px 8px;"><c:set var="discountPrice"
													value="" /> <c:if test="${between==1 || between==0}">
													<c:set var="discountPrice" value="${(room.price)*0.95}" />
												</c:if> <c:if test="${between>1}">
													<c:set var="discountPrice"
														value="${(room.price)*0.95*between}" />
												</c:if> <fmt:formatNumber type="number" maxFractionDigits="0"
													var="discountPrice">${discountPrice}</fmt:formatNumber> <c:if
													test="${between==1 || between==0}">
													<div
														style="text-decoration: line-through; font-size: 10px; color: red;">TWD:${room.price}</div>
												</c:if> <c:if test="${between>1}">
													<div
														style="text-decoration: line-through; font-size: 10px; color: red;">TWD:${room.price*between}</div>
												</c:if>
												<div>TWD:${discountPrice}</div>
												<div style="color: gray; font-size: 8px;">含稅費/其他費用</div></td>
											<td style="padding: 6px 8px;">
												<div>
													<ul style="font-size: 8px; padding-left: 20px;">
														<li
															style="font-size: 8px; color: #000000; font-weight: normal;">可部份退款</li>
														<li
															style="font-size: 8px; color: #000000; font-weight: normal;">預先付款</li>
														<li
															style="font-size: 8px; color: #000000; font-weight: normal;">預訂享折扣</li>
														<c:if test="${loginDate != ''}">
															<li
																style="font-size: 8px; color: #000000; font-weight: normal;">剩餘${room.remain}間房</li>
														</c:if>
													</ul>
												</div>
											</td>
											<!-- 如果未選時間就不顯示房間數量 -->
											<c:if test="${loginDate != ''}">
												<td style="padding: 6px 8px;"><c:set var="count"
														value="${0}" /> <select name="selectNum" class="selectNum"
													style="padding-left: 10px; width: 100%;">
														<c:forEach begin="0" end="${room.remain}">
															<c:set var="totalPrice" value="" />
															<c:if test="${between==1 || between==0}">
																<c:set var="totalPrice" value="${room.price*count*0.95}" />
															</c:if>
															<c:if test="${between>1}">
																<c:set var="totalPrice"
																	value="${room.price*count*0.95*between}" />
															</c:if>
															<fmt:formatNumber type="number" maxFractionDigits="0"
																var="totalPrice">${totalPrice}</fmt:formatNumber>
															<option value="${count}">${count}
																($${totalPrice})</option>
															<c:set var="count" value="${count+1}" />
														</c:forEach>
												</select></td>
											</c:if>
											<c:if test="${loginDate == ''}">
												<td>
													<div style="font-size: 14px; text-align: center;">請先選擇住宿日期</div>
												</td>
											</c:if>
										</tr>
										<input type="hidden" value="${room.price}" class="roomPrice"
											name="roomPrice" />
										<input type="hidden" value="${room.roomId}" name="roomId" />
									</c:forEach>
									<!-- 以下不用重複找的隱藏資訊放在foreach外 form內 -->
									<input type="hidden" name="between" value="${between}"
										id="between">
									<input type="hidden" name="loginDate" value="${loginDate}">
									<input type="hidden" name="logoutDate" value="${logoutDate}">
								</tbody>
							</table>
						</div>
						<div id="room_right">
							<div
								style="width: 220px; background-color: #004cb8; height: 34px;"
								id="bookingtitle"></div>
							<br> <br>
							<div style="width: 200px; margin: 0 auto;">

								<c:choose>
									<c:when test="${loginCustomer != null}">
										<div id="selectInfo"></div>
										<div id="bookingMessage">
											<div style="color: red; font-size: 12px;" id="bookingNote">您須至少預定一項</div>
										</div>
										<div>
											<button type="submit" disabled
												style="color: white; background-color: rgba(116, 116, 116, 0.788); text-align: center; width: 100%; padding: 8px 0px;"
												id="bookingBtn">現在就預定</button>
										</div>
									</c:when>
									<c:otherwise>
										<div style="color: red; font-size: 12px;">請先登入會員</div>
										<div>
											<button type="submit" disabled
												style="color: white; background-color: rgba(116, 116, 116, 0.788); text-align: center; width: 100%; padding: 8px 0px;">現在就預定</button>
										</div>
									</c:otherwise>
								</c:choose>

								<div>
									<ul style="font-size: 10px;">
										<li
											style="font-size: 10px; color: #000000; font-weight: normal;">立即確認</li>
										<li
											style="font-size: 10px; color: #000000; font-weight: normal;">需先登入會員</li>
										<li
											style="font-size: 10px; color: #000000; font-weight: normal;">不收取額外手續費</li>
									</ul>
								</div>
							</div>
						</div>
					</form>
				</div>

				<!-- nav滾動 -->
				<!-- <script>
                    var leftNav = document.getElementById('leftNav');
                    var nav = leftNav.offsetTop
                    console.log(nav);
                    $(window).scroll(function(){
                        if(window.screenY >= nav){
                            document.getElementById('leftNav').style.visibility = 'hidden';
                        }else{
            
                        }
                    })
                </script> -->
				<div style="display: flex;">
					<div
						style="height: 200px; padding: 20px; display: flex; align-items: center; margin: 20px 0px 10px 0px; background-color: rgb(255, 255, 255); border-radius: 3px; box-shadow: 0 0 8px #979797;">
						<span
							style="font-size: 30px; display: flex; align-items: center; padding-right: 20px;"><i
							class="fa-regular fa-clock"></i></span>
						<div>
							<span><h3>把握優惠價格，就趁現在</h3></span>
							<div>
								<h3>擔心漲價？立即確保訂房資格。</h3>
							</div>
						</div>
						<div>
							<img
								src="https://cdn.travelpulse.com/images/99999999-9999-9999-9999-999999999999/3a1cc8d1-06e2-55b4-d366-5c39c804fe42/630x355.jpg"
								style="height: 150px; border-radius: 3px;">
						</div>
					</div>
				</div>
				<div
					style="display: flex; justify-content: flex-start; margin-right: 20px;">
					<div
						style="padding: 20px; height: 200px; margin-top: 20px; display: flex; align-items: center; justify-content: flex-end; background-color: rgb(255, 255, 255); border-radius: 3px; box-shadow: 0 0 8px #979797;">
						<div style="margin-right: 20px;">
							<img
								src="https://www.yatravel.tw/wp-content/uploads/2020/05/DJI_0110-1.jpg"
								style="height: 150px; border-radius: 3px;">
						</div>
						<div
							style="display: flex; flex-direction: column; justify-content: space-around; height: 150px;">
							<div>
								<h2>一定要住這裡的 4 大理由</h2>
							</div>
							<div>
								<div style="font-size: 20px; margin-bottom: 20px;">
									<span
										style="margin-right: 10px; padding: 5px; border: 1px solid rgb(0, 89, 255); background-color: rgb(183, 222, 250); border-radius: 3px;"><i
										class="fa-solid fa-wallet" style="padding-right: 5px;"></i>超殺優惠價！低價保證,不收取預訂手續費</span>
									<span
										style="margin-right: 10px; padding: 5px; border: 1px solid rgb(0, 89, 255); background-color: rgb(183, 222, 250); border-radius: 3px;"><i
										class="fa-solid fa-unlock" style="padding-right: 5px;"></i>安全的預訂</span>
								</div>
								<div style="font-size: 20px;">
									<span
										style="margin-right: 10px; padding: 5px; border: 1px solid rgb(0, 89, 255); background-color: rgb(183, 222, 250); border-radius: 3px;"><i
										class="fa-solid fa-clipboard-list" style="padding-right: 5px;"></i>你的訂單你做主</span>
									<span
										style="margin-right: 10px; padding: 5px; border: 1px solid rgb(0, 89, 255); background-color: rgb(183, 222, 250); border-radius: 3px;"><i
										class="fa-solid fa-children" style="padding-right: 5px;"></i>住宿的地點以及提供的設施非常適合情侶</span>
								</div>
							</div>
						</div>
					</div>
				</div>


				<!-- 訂房須知 -->
				<div
					style="display: flex; justify-content: flex-start; margin-right: 20px;"
					id="notice">
					<div class="searchingblock"
						style="margin-top: 30px; width: 1030px;">
						<div style="padding: 20px;">
							<h4>訂房須知</h4>
						</div>
						<hr style="margin: 0px;">
						<!-- 內容 -->
						<div style="padding: 20px; background-color: #f0f9ff;">
							<div
								style="margin-bottom: 20px; background-color: #a8cee2; border: 0.5px solid #87a1b8; border-radius: 3px; padding: 5px; width: 350px;">住客在入住時須出示有相片的身分證明及信用卡</div>

							<div style="display: flex; margin: 5px 0px;">
								<span><i class="fa-regular fa-clock"></i><span
									style="margin: 0px 8px;">入住時間</span></span> <span
									style="margin-left: 50px;"> <span class="timebar">
										<span
										style="padding: 1px 30px; background-color: rgb(36, 151, 36); margin-left: 30px;"></span>
								</span> <span display:flex;> <span style="margin-left: 140px;">15:00~22:00</span>
								</span>
								</span>
							</div>

							<div style="display: flex; margin: 10px 0px;">
								<span><i class="fa-regular fa-clock"></i><span
									style="margin: 0px 8px;">退房時間</span></span> <span
									style="margin-left: 50px;"> <span class="timebar">
										<span
										style="padding: 1px 30px; background-color: rgb(36, 151, 36); margin-left: -100px;"></span>
								</span> <span display:flex;> <span style="margin-left: 10px;">15:00~22:00</span>
								</span>
								</span>
							</div>
							<div
								style="display: flex; margin: 10px 0px; align-items: center;">
								<i class="fa-solid fa-circle-exclamation"></i>
								<div style="margin: 0px 8px;">
									<div>預訂取消/</div>
									<div>預付政策</div>
								</div>
								<div style="margin-left: 43px;">
									取消和預付款政策根據各種住宿類型而有所不同。 選擇時請先確認每個選項適用的<a>訂房限制</a>。
								</div>
							</div>
							<div style="display: flex; margin: 20px 0px;">
								<div style="display: flex; align-items: center;">
									<i class="fa-solid fa-child"></i>
									<div style="margin: 0px 8px;">孩童加床選項</div>
								</div>
								<div style="margin-left: 20px;">
									<div>孩童政策</div>
									<div>嬰兒床與加床政策</div>
									<div>依現場溝通為主</div>
								</div>
							</div>
							<div
								style="display: flex; margin: 20px 0px; align-items: center;">
								<i class="fa-solid fa-user"></i>
								<div style="margin: 0px 8px;">年齡限制</div>
								<div style="margin-left: 50px;">須年滿 18 歲才能辦理入住</div>
							</div>
							<div
								style="display: flex; margin: 20px 0px; align-items: center;">
								<i class="fa-regular fa-credit-card"></i>
								<div style="margin: 0px 4px;">付款方式</div>
								<div style="margin-left: 54px;">信用卡付款</div>
							</div>
							<div
								style="display: flex; margin: 20px 0px; align-items: center;">
								<i class="fa-solid fa-ban-smoking"></i>
								<div style="margin: 0px 6px;">禁菸政策</div>
								<div style="margin-left: 52px;">全館禁止吸菸</div>
							</div>
							<div
								style="display: flex; margin: 20px 0px; align-items: center;">
								<i class="fa-solid fa-paw"></i>
								<div style="margin: 0px 6px;">寵物</div>
								<div style="margin-left: 84px;">依館內規定</div>
							</div>
						</div>
					</div>
				</div>

				<!-- 評論評語 -->
				<div style="margin-top: 20px; margin-right: 20px;" id="comment"
					class="searchingblock">
					<div style="width: 1030px; padding: 20px;">
						<div>
							<h2>住客評語</h2>
						</div>
						<hr style="margin: 0px 0px 10px 0px;">
						<div style="display: flex;">
							<span style="margin-top: 10px"> <a class="showComment"
								style="text-decoration: none; color: #ffffff;"> <span
									style="background-color: rgb(22, 22, 88); font-size: 20px; height: 35px; width: 35px; padding-left: 2px; padding: 5px; border-radius: 5px 5px 5px 0px;">${hotel.averageRating}</span>
							</a>
							</span> <span>
								<div class="rate" style="margin-left: 5px"></div>
								<div style="font-size: 10px; margin-left: 5px">
									<a class="showComment" style="text-decoration: none;">${commentSize}則評論</a>
								</div>
							</span>
						</div>
						<br>
						<!-- 評論輪播 -->
						<div class="container" style="padding: 0px;">
							<div class="carousel">
								<div style="display: flex;" class="comment_carousel">
									<c:forEach items="${hotel.comment}" var="comment">
										<div
											style="border: 1px solid rgb(209, 209, 209); margin: 5px; padding: 20px;">
											<div>
												<div class="photo_name_country_all">
													<div class="photo_name_country" style="display: flex;">
														<div class="photo_div">
															<div class="photo"
																style="border-radius: 100%; overflow: hidden; width: 50px; height: 50px; display: flex; align-items: center;">
																<img
																	src="${contextRoot}/downloadAvatar/${comment.customer.userId}"
																	style="width: 50px;">
															</div>
														</div>
														<div class="name_country" style="margin-bottom: 10px;">
															<div>
																<i class="fa-regular fa-user"
																	style="color: rgb(29, 79, 149); margin-top: 5px; padding: 4px;"></i>
																<span class="name">${comment.customer.userName}</span>
															</div>
															<div class="country_photo">
																<i class="fa-solid fa-earth-americas"
																	style="color: rgb(29, 79, 149); padding: 3px;"></i>
																<div class="country_name">${comment.customer.nationality}</div>
															</div>
														</div>
													</div>
												</div>
												<div class="comment_text">
													<p>
														<span
															style="font-size: 16px; color: #000000; font-weight: normal;">${comment.comment}</span>
													</p>
												</div>
											</div>
										</div>
									</c:forEach>
								</div>
							</div>
							<div>
								<button class="showComment commentsubmit">查看所有評論</button>
							</div>
						</div>
					</div>
				</div>

				<!-- 住宿問答 -->
				<div></div>

				<!-- 住宿周邊OpenStreetMap -->
				<div></div>

				<!-- 設施與服務(所有標籤)+訂房須知 -->
				<div></div>

				<!-- 隱藏資訊 -->
				<div>
					<input type="hidden" value="${hotel.hotelId}" id="hotelId">
					<input type="hidden" value="${hotel.hotelName}" id="name">
					<input type="hidden" value="${hotel.px}" id="px"> <input
						type="hidden" value="${hotel.py}" id="py"> <input
						type="hidden" value="${hotel.averageRating}" id="averageRating">
				</div>
			</div>

			<!-- 彈出視窗 -->
			<!-- 大地圖 -->
			<div>
				<dialog id="infoModal" style="padding:0px;">
				<div id="close" style="background-color: #005592;">
					<a id="closebtn"><b><i
							class="fa-solid fa-rectangle-xmark closeicon"
							style="font-size: 30px; padding: 10px; color: #ffffff;"></i></b></a>
				</div>
				<div id="bigMap"></div>
				<div
					style="font-size: 6px; background-color: #005592; padding: 5px; color: #ffffff;">--地圖資訊由©
					OpenStreetMap提供</div>
				</dialog>
			</div>

			<!-- 所有評論 -->
			<div>
				<dialog id="infoComment">
				<div id="close">
					<a id="closeComment"
						style="position: fixed; right: 35px; top: 25px;"><b><i
							class="fa-solid fa-rectangle-xmark closeicon"
							style="font-size: 30px; padding: 10px;"></i></b></a>
				</div>
				<div id="commentTitle">
					<span
						style="color: white; background-color: rgb(22, 22, 88); font-size: 20px; height: 35px; width: 35px; padding-left: 2px; padding: 5px; border-radius: 5px 5px 5px 0px;">${hotel.averageRating}</span><span
						class="rate"></span> <span style="font-size: 10px">${commentSize}則評論</span>
				</div>
				<hr>
				<div style="margin-bottom: 10px;">
					<span style="display: flex; align-items: center; color: #003961;"><h5>
							<i class="fa-solid fa-comment-dots"></i>住客評語
						</h5></span> <span
						style="margin: 5px 0px; display: flex; align-items: center;">
						<span style="font-size: 12px;">排序依據:</span> <select id=orderSelect
						style="border: 2px solid #005592; padding: 2px 0px; border-radius: 5px; margin: 5px;">
							<option value="orderByRatingDesc">評分高至低</option>
							<option value="orderByRatingAsc">評分低至高</option>
							<option value="orderBytimeDesc">時間新至舊</option>
							<option value="orderBytimeAsc">時間舊至新</option>
					</select>
					</span>
				</div>
				<div id="commentBody">
					<div id="commentList">
						<c:forEach items="${hotel.comment}" var="comment">
							<div
								style="display: flex; border-top: 1px solid rgb(189, 189, 189); padding: 10px;">
								<div style="padding: 20px 0px; flex: 3;">
									<div style="display: flex; align-items: center;">
										<div
											style="border-radius: 100%; overflow: hidden; width: 50px; height: 50px; display: flex; align-items: center;">
											<img style="width: 50px;"
												src="${contextRoot}/downloadAvatar/${comment.customer.userId}">
										</div>
										<div style="margin-left: 10px;">
											<div style="display: flex; align-items: center;">
												<i class="fa-regular fa-user"
													style="color: rgb(60, 60, 202); margin-top: 5px;"></i>
												<div style="margin-left: 5px;">${comment.customer.userName}</div>
											</div>
											<div style="display: flex; align-items: center;">
												<i class="fa-solid fa-earth-americas"
													style="color: rgb(60, 60, 202);"></i>
												<div style="margin-left: 5px;">${comment.customer.nationality}</div>
											</div>
										</div>
									</div>
									<div
										style="display: flex; align-items: center; color: #575757;">
										<i class="fa-solid fa-bed"></i>
										<div style="margin-left: 10px;">${comment.room.roomName}</div>
									</div>
									<c:set var="day"
										value="${fn:split(comment.booking.dateOfStay , ',')}" />
									<div
										style="display: flex; align-items: center; color: #585858;">
										<i class="fa-regular fa-calendar-check"></i>
										<div style="margin-left: 16px;">${fn:length(day)}晚-${day[0]}</div>
									</div>
								</div>
								<div
									style="border-left: 1px solid rgb(209, 209, 209); padding: 20px; width: 100%; flex: 7;">
									<div style="display: flex; justify-content: space-between;">
										<span>評論時間<fmt:formatDate pattern="yyyy-MM-dd"
												value="${comment.commentTime}" /></span> <span
											style="color: white; background-color: rgb(22, 22, 88); font-size: 20px; height: 35px; width: 35px; padding: 5px; border-radius: 5px 5px 5px 0px; display: flex; align-items: center;">${comment.rating}</span>
									</div>
									<div>${comment.comment}</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
				<div id="commentPage" style="bottom: 10%;"></div>
				</dialog>
			</div>
			<div>
				<dialog id="roomimgDialog" style="padding: 0px; width: 1000px;">
				<div id="close" style="background-color: #005592;">
					<a id="closeImg"><b><i
							class="fa-solid fa-rectangle-xmark closeicon"
							style="font-size: 30px; padding: 10px; color: #ffffff;"></i></b></a>
				</div>
				<div id="showRoomimg"></div>
				<div
					style="background-color: #005592; font-size: 10px; padding: 5px; color: #ffffff;">--圖片僅供參考</div>
				</dialog>
			</div>
		</div>
	</div>
	<!-- 背景 -->
	<!-- <div class="backgroundImg">
        <video autoplay muted loop src="https://storage.coverr.co/videos/25Jm9HYoH8J1lGYxgO9cnreD6hE01lv7r?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcHBJZCI6Ijg3NjdFMzIzRjlGQzEzN0E4QTAyIiwiaWF0IjoxNjU0NDk5MDgyfQ.x-omlXwr0wQswexBsiv6jaT_6MCf9zyrPCsQsjI0-gI"></video>
    </div> -->
	<!-- footer star-->
	<jsp:include page="layout/footer.jsp" />
	<!-- footer end-->
	<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
	<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
	<script src="${contextRoot}/js/slick.min.js"></script>
	<!-- 輪播 -->
	<script src="${contextRoot}/js/commentroll.js"></script>

	<!--     工具 -->
	<script src="${contextRoot}/js/hotelInfoUtil.js"></script>

	<!-- 關於評論 -->
	<script src="${contextRoot}/js/hotelInfoComment.js"></script>

	展房間圖片
	<script src="${contextRoot}/js/roomImg.js"></script>
	地圖
	<script src="https://unpkg.com/leaflet@1.3.4/dist/leaflet.js"
		integrity="sha512-nMMmRyTVoLYqjP9hrbed9S+FzjZHW5gY1TWCHA5ckwXZBadntCNs8kEqAWdrb9O7rxbCaA4lKTIWjDXZxflOcA=="
		crossorigin=""></script>
	<script src="${contextRoot}/js/mapjs.js"></script>

	日期控制
	<script src="${contextRoot}/js/datecontroller.js"></script>

	我的最愛
	<script src="${contextRoot}/js/hotelInfoFavorite.js"></script>

</body>
</html>