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
<title>現在就下訂</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css">
<!-- css -->
<link rel="stylesheet" href="${contextRoot}/css/bookingPage.css">	

</head>
<body>
	<c:if test="${sessionScope.loginCustomer == null}">
		<div style="display: flex; justify-content: center; margin: 20px;"><h3>請重新登入訂房</h3></div>
	</c:if>
	<c:if test="${sessionScope.loginCustomer != null}">
		<!-- 進程 -->
		<div class="toFlex" style="display: flex; justify-content: center; margin: 20px; font-weight: bold;">
			<div>
				<span style="display: flex; align-items: center;">	
					<span style="background-color: rgb(59, 152, 234); border-radius: 50%; padding: 5px; display: flex; align-items: center; justify-content: center; width: 30px; height: 30px; color: white;"><i class="fa-solid fa-check"></i></span>
					<span style="margin: 0px 5px;">您的選項</span>
					<span style="margin: 0px 5px; width: 200px;"><hr></span>
				</span>
			</div>
			<div>
				<span style="display: flex; align-items: center;">
					<span style="background-color: rgb(59, 152, 234); border-radius: 50%; padding: 5px; display: flex; align-items: center; justify-content: center; width: 30px; height: 30px; color: white;"><i class="fa-solid fa-2"></i></span>
					<span style="margin: 0px 5px;">您的資料</span>
					<span style="margin: 0px 5px; width: 200px;"><hr></span>
				</span>
			</div>
			<div>
				<span style="display: flex; align-items: center;">
					<span style="background-color: rgb(52, 52, 52); border-radius: 50%; padding: 5px; display: flex; align-items: center; justify-content: center; width: 30px; height: 30px; color: white;"><i class="fa-solid fa-3"></i></span>
					<span style="margin: 0px 5px;">最後一步</span>
				</span>
			</div>
		</div>
		
		<!-- 訂單body -->
		<div class="toFlex" style="display: flex; justify-content: center; margin-right: 200px;">
			<!-- 左 -->
			<div style="width: 300px; margin: 10px;">
				<!-- 訂房資訊 -->
				<div class="block" style="padding: 10px; margin: 5px;">
					<div><h5>您的訂房資訊</h5></div>
					<hr style="margin: 5px 0px;">
					<div style="display:flex;">
						<div style="flex: 50%;">
							<div><i class="fa-regular fa-calendar-check"></i>入住時間</div>
							<div>${loginDate}</div>
							<div>(${loginWeek})</div>
							<div>16:00 - 21:00</div>
						</div>
						<div style="flex: 50%;">
							<div><i class="fa-solid fa-calendar-check"></i>退房時間</div>
							<div>${logoutDate}</div>
							<div>(${logoutWeek})</div>
							<div>07:00 - 12:00</div>
						</div>
					</div>
					<div>
						<div>總共入住:</div>
						<div>${between}<b>晚</b></div>
					</div>
					<hr>
					<div>
						<div><i class="fa-solid fa-bed"></i>已選擇</div>
						<c:forEach begin="0" end="${fn:length(roomlist)-1}" var="i" step="1">
							<div>
								<span>${numlist[i]}</span>
								<span>X</span>
								<span>${roomlist[i].roomName}</span>
							</div>
						</c:forEach>
					</div>
				</div>
				<!-- 房價明細 -->
				<div class="block" style="padding: 10px; margin: 20px 5px;">
					<div><h5>房價明細</h5></div>
					<hr style="margin: 5px 0px;">
					<div>
						<div class="toFlex">
							<span style="flex: 60%;">房間</span>
							<fmt:formatNumber type="number" maxFractionDigits="0" var="discountPrice">${totalPrice*0.85*0.95*between}</fmt:formatNumber>
							<span style="flex: 30%;">TWD${discountPrice}</span>
						</div>
						<div class="toFlex">
							<span style="flex: 60%;">5%加值稅</span>
							<fmt:formatNumber type="number" maxFractionDigits="0" var="discountPrice">${totalPrice*0.05*0.95*between}</fmt:formatNumber>
							<span style="flex: 30%;">TWD${discountPrice}</span>
						</div>
						<div class="toFlex">
							<span style="flex: 60%;">10%住宿方服務費</span>
							<fmt:formatNumber type="number" maxFractionDigits="0" var="discountPrice">${totalPrice*0.1*0.95*between}</fmt:formatNumber>
							<span style="flex: 30%;">TWD${discountPrice}</span>
						</div>
					</div>
					<hr>
					<div class="toFlex">
						<span style="flex: 60%;">最終價格(Total):</span>
						<fmt:formatNumber type="number" maxFractionDigits="0" var="discountPrice">${totalPrice*0.95*between}</fmt:formatNumber>
						<span style="flex: 30%;">TWD${discountPrice}</span>
					</div>
				</div>
			</div>
			<!-- 右 -->
			<div style=" margin: 10px 0px;">
				<!-- 飯店資訊 -->
				<div class="block" style="padding: 10px; margin: 5px; margin-bottom: 20px; width: 800px;">
					<div class="toFlex">
						<c:set var="imgArr" value="${fn:split(hotel.pics , ',')}"/>
						<div style="display: flex; justify-content: center; align-items: center; border-radius: 5px; margin: 10px;"><img src="${imgArr[0]}" style="width: 200px;"></div>
						<div style="margin: 10px; display: flex; flex-direction: column; justify-content: space-between;">
							<div>
								<div><h3>${hotel.hotelName}</h3></div>
								<div><i class="fa-solid fa-location-dot"></i>${hotel.add}</div>
							</div>
							<div>
								<div style="margin: 5px 0px;">
									<span style="background-color:rgb(22, 22, 88) ; font-size: 20px; height: 35px; width: 35px;padding-left: 2px; padding: 5px; border-radius: 5px 5px 5px 0px; color: white;">${hotel.averageRating}</span>
									<span>
										<c:choose>
											<c:when test="${hotel.averageRating >= 9.5}">
												<span style="font-size: 20px;">傑出</span>
											</c:when>
											<c:when test="${hotel.averageRating >= 9.0}">
												<span style="font-size: 20px;">好極了</span>
											</c:when>
											<c:when test="${hotel.averageRating >= 8.0}">
												<span style="font-size: 20px;">很好</span>
											</c:when>
											<c:when test="${hotel.averageRating >= 7.0}">
												<span style="font-size: 20px;">好</span>
											</c:when>
											<c:otherwise>
												<span style="font-size: 20px;">好</span>
											</c:otherwise>
										</c:choose>
									</span>
								</div>
								<div>共${fn:length(hotel.comment)}則評論</div>
							</div>
						</div>
					</div>
				</div>
				<!-- 訂單表格 -->
				<div>
					<!-- <form action="bookForm" enctype=multipart/form-data method="post"> -->
						<!-- 個人資料 -->
						<div class="block" style="padding: 20px; margin: 5px; margin-bottom: 20px; width: 800px;">
							<h3><i class="fa-solid fa-pen-nib"></i>輸入個人資料</h3>
							<div style="font-size: 12px; color: gray;">快好了!標有<b style="color:red;">*</b>的欄位為必填</div>
							<hr style="margin: 5px 0px;">
							<div>
								<div class="lineheight">
									<div><b>此趟是否為商務出差?</b></div>
									<div>
										<span><input type="radio" name="business" class="business" value="y">是</span>
										<span><input type="radio" name="business" class="business" value="n" checked>否</span>
									</div>
								</div>
								<div class="lineheight">
									<div id="nameNote"><p style="margin-bottom: 0px; color: black; font-size: 16px;font-weight: bolder"><b>姓名<b style="color:red;">*</b></b></p></div> 
									<div><span id="checkName" style="display: flex; align-items: center;"><input id="cusName" type="text" placeholder="${sessionScope.loginCustomer.userName}" value="${sessionScope.loginCustomer.userName}" name="customerName"></span></div>
								</div>
								<div class="lineheight">
									<div style="margin-bottom: 0px;"><b>電子信箱<b style="color:red;">*</b></b></div>
									<div style="display: flex; align-items: center;">
										<div><span id="mailMsg" style="display: flex; align-items: center;"><input type="text" placeholder="${sessionScope.loginCustomer.email}" value="${sessionScope.loginCustomer.email}" name="customerName" id="mail"></span></div>
									</div>
									<div style="font-size: 10px; color:gray;">確認函將會發送至此信箱</div>
								</div>
								<div class="lineheight">
									<span style="margin-bottom: 0px;"><b>確認電子信箱<b style="color:red;">*</b></b></span>
									<span id="mailNote"></span>
									<div style="display: flex; align-items: center;">
										<div><span id="checkMailMsg" style="display: flex; align-items: center;"><input type="text" placeholder="確認電子信箱" name="customerName" id="checkMail"></span></div>
									</div>
								</div>
								<div class="lineheight">
									<div><b>您為誰預定呢?</b></div>
									<div><input type="radio" name="for" class="for" value="我就是主要住客" checked >我就是主要住客</div>
									<div><input type="radio" name="for" class="for" value="幫別人訂房">幫別人訂房</div>
								</div>
							</div>
						</div>
						<!-- 房間詳細 -->
						<c:forEach begin="0" end="${fn:length(roomlist)-1}" var="i" step="1">
							<div class="block" style="padding: 20px; margin: 5px; margin-bottom: 20px; width: 800px;">
								<div>
									<div><h3><i class="fa-solid fa-bed"></i>${roomlist[i].roomName}*${numlist[i]}間</h3></div>
									<hr style="margin: 5px 0px;">
									<div class="lineheight">
										<div><i class="fa-solid fa-utensils"></i>房價含早餐</div>
										<div style="font-size: 10px; color: gray;"><span>相關評分:</span><span>${fn:length(room.commentId)}則</span></div>
									</div>
									<div class="lineheight">
										<b><i class="fa-regular fa-circle-xmark"></i>不可退款!</b>
									</div>
									<div style="font-size: 16px;" class="lineheight"><i class="fa-solid fa-ban-smoking"></i>禁菸</div>
								</div>
								<div style="font-weight: bold; margin-top: 10px;"><i class="fa-solid fa-people-group"></i>最多人數:${roomlist[i].capaticy}名成年人(不含小朋友)</div>
								<div class="toFlex">
									<c:forEach items="${roomlist[i].tag}" var="tag">
										<div style="border: 1px solid rgb(87, 87, 87); margin:0px 5px 0px 0px; background-color: rgb(36, 79, 129); color:white; padding: 2px; font-size: 12px;"><b>${tag}</b></div>
									</c:forEach>
								</div>
							</div>
						</c:forEach>
						<div class="block" style="padding: 20px; margin: 5px; margin-bottom: 20px; width: 800px;">
							<div><h3><i class="fa-regular fa-comment-dots"></i>您還有什麼特別要求？</h3></div>
							<hr style="margin: 5px 0px;">
							<div>
								<div><b>住宿方無法保證達成您的特殊要求－但將盡力為您安排。訂單完成後，您依然可隨時提出特殊要求！</b></div>
								<div>
									<p><b>請使用英語或繁體中文填寫您的請求。</b>(選填)</p>
									<textarea name="annotation" style="width: 700px; height:100px;" id="annotation"></textarea>
								</div>
								<div><input type="checkbox" id="parking"/><label for="parking">我想要停車位<i class="fa-solid fa-car"></i></label></div>
							</div>
						</div>
						<div class="block" style="padding: 20px; margin: 5px; margin-bottom: 20px; width: 800px;">
							<div><h3><i class="fa-regular fa-clock"></i>您的抵達時間</h3></div>
							<hr style="margin: 5px 0px;">
							<div>
								<div>您可在 16:00－21:00 間入住</div>
								<div>
									<label for="arriveTimes">提供您預計的抵達時間<b style="color:red;">*</b></label> 
									<div>
										<select name="arriveTimes" id="arriveTimes">
											<option value disabled selected>請選擇</option>
											<option value="notSure">不確定</option>
											<option value="16:00－17:00">16:00－17:00</option>
											<option value="17:00－18:00">17:00－18:00</option>
											<option value="18:00－19:00">18:00－19:00</option>
											<option value="19:00－20:00">19:00－20:00</option>
											<option value="20:00－21:00">20:00－21:00</option>
										</select>
									</div>
									<div style="font-size: 10px; color: gray;">該時間為${hotel.town}時間</div>
								</div>
							</div>
						</div>
						<div class="block" style="padding: 20px; margin: 5px; margin-bottom: 20px; width: 800px;">
							<div><h3><i class="fa-solid fa-list"></i>住宿規定</h3></div>
							<hr style="margin: 5px 0px;">
							<div>
								<div>住宿方需要您同意以下住宿規定：</div>
								<div>
									<ul>
										<li style="color: black;">禁止吸菸</li>
										<li style="color: black;">23:00～06:00 必須放低音量</li>
										<li style="color: black;">禁止攜帶寵物入住</li>
									</ul>
								</div>
								<div>若繼續下一步，代表您同意住宿規定</div>
							</div>
						</div>
						<div style="text-align: right;">
							<button id="checkBtn"><b>下一步:最後資料確認</b></button>
						</div>
					<!-- </form> -->
				</div>
			</div>
		</div>
		<div>
			<dialog id="finalCheck" style="width: 600px; height: 750px;">
				<form method="post" action="ECPayServer" >
					<div id="checkInfo">
		
					</div>
					<div>
						<div><input type="checkbox" id="rule"/><label for="rule">我同意住宿規則</label></div>
						<hr>
						<span><a id="x">上一頁:繼續確認</a></span>
						<span><button id="o" class="o" disabled="disabled">確認:前往填寫信用卡資料</button></span>
					</div>
				</form>
			</dialog>
		</div>
	</c:if>
	
	<!-- footer star-->
	<jsp:include page="layout/footer.jsp" />
	<!-- footer end-->
	
	<!--收藏清單-->
	<!--收藏清單-->
	<script type="text/javascript">
		//密碼驗證提示
		$('#checkMail,#mail').blur(function(){
			let mail = document.getElementById('mail').value
			let checkMail = document.getElementById('checkMail').value
			if(mail == checkMail && checkMail!=""){
				$('#mailNote').html('<span style="color:green;">驗證成功</span>');
				$('#mail').css('border','3px solid green')
				$('#checkMail').css('border','3px solid green')
				
				$('.checkNote').remove()
				$('#mailMsg').append('<span class="checkNote" style="color:white; background-color:green; padding:5px; width:25px; height:32px; justify-content: center; align-items: center;"><i class="fa-solid fa-check"></i></span>')
				$('#checkMailMsg').append('<span class="checkNote" style="color:white; background-color:green; padding:5px; width:25px; height:32px; justify-content: center; align-items: center;"><i class="fa-solid fa-check"></i></span>')
			}else{
				$('#mailNote').html('<span style="color:red;">請重新填寫信箱</span>');
				$('#mail').css('border','3px solid red')
				$('#checkMail').css('border','3px solid red')
				
				$('.checkNote').remove()
				$('#mailMsg').append('<span class="checkNote" style="color:white; background-color:red; padding:5px; width:25px; height:32px; justify-content: center; align-items: center;"><i class="fa-solid fa-x"></i></span>')
				$('#checkMailMsg').append('<span class="checkNote" style="color:white; background-color:red; padding:5px; width:25px; height:32px; justify-content: center; align-items: center;"><i class="fa-solid fa-x"></i></span>')
	
			}
		})
	
		$(document).ready(function(){
			//名字驗證提示
			$('#checkName').append('<span class="checkName" style="color:white; background-color:green; padding:5px; width:25px; height:32px; justify-content: center; align-items: center;"><i class="fa-solid fa-check"></i></span>')
			$('#cusName').css('border','3px solid green')
			$('#cusName').blur(function(){
				let check = document.getElementById('cusName').value
				if(check == ""){
					$('.checkName').remove()
					$('#cusName').css('border','3px solid red')
					$('#checkName').append('<span class="checkName" style="color:white; background-color:red; padding:5px; width:25px; height:32px; justify-content: center; align-items: center;"><i class="fa-solid fa-x"></i></span>')
				}else{
					$('.checkName').remove()
					$('#checkName').append('<span class="checkName" style="color:white; background-color:green; padding:5px; width:25px; height:32px; justify-content: center; align-items: center;"><i class="fa-solid fa-check"></i></span>')
					$('#cusName').css('border','3px solid green')
				}
			})
	
			//抵達時間提示
			$('#arriveTimes').css('border','3px solid red')
			$('#arriveTimes').change(function(){
				$('#arriveTimes').css('border','3px solid green')
			})
		})
	
		//停車checkbox
		$('#parking').click(function(){
			let parking = document.getElementById('parking').checked
			if(parking == true){
				$('#annotation').html('我想要停車位,')
			}else{
				$('#annotation').html('')
			}
		})
	
		//送出前檢查是否有空格
		$('#checkBtn').click(function(){
			let name = document.getElementById('cusName').value
			let mail = document.getElementById('mail').value
			let checkMail = document.getElementById('checkMail').value
			let times = document.getElementById('arriveTimes').value
			let annotation = document.getElementById('annotation').value
			let business = document.querySelectorAll('.business')
			$.each(business,function(index,value){
				if(this.checked==true){
					business = this.value
				}
			})
			let user = document.querySelectorAll('.for')
			$.each(user,function(index,value){
				if(this.checked==true){
					user = this.value
				}
			})
			//分層才不會重複偵測到
			if(name==""){
				$('.checkName').remove()
				$('#cusName').css('border','3px solid red')
				$('#checkName').append('<span class="checkName" style="color:white; background-color:red; padding:5px; width:25px; height:32px; justify-content: center; align-items: center;"><i class="fa-solid fa-x"></i></span>')
				
				$('html,body').animate({
					scrollTop: $('#cusName').offset().top-110
					}, 100
				);
			}else{
				if(mail=="" || checkMail=="" || mail!=checkMail){
					$('#mailNote').html('<span style="color:red;">請重新填寫信箱</span>');
					$('#mail').css('border','3px solid red')
					$('#checkMail').css('border','3px solid red')
					
					$('.checkNote').remove()
					$('#mailMsg').append('<span class="checkNote" style="color:white; background-color:red; padding:5px; width:25px; height:32px; justify-content: center; align-items: center;"><i class="fa-solid fa-x"></i></span>')
					$('#checkMailMsg').append('<span class="checkNote" style="color:white; background-color:red; padding:5px; width:25px; height:32px; justify-content: center; align-items: center;"><i class="fa-solid fa-x"></i></span>')
					
					$('html,body').animate({
						scrollTop: $('#mail').offset().top-110
						}, 100
					);
				}else{
					if(times==""){
						$('html,body').animate({
							scrollTop: $('#arriveTimes').offset().top-110
							}, 100
						);
					}else{
						//確認該填的都有填再往下執行
						let info = '';
						info += '<c:set var="item" value=""/>'
						info += '<div><h3>最後確認</h3></div>'
						info +=	'<div><b>訂房人姓名:</b>'+name+'</div>'
						info +=	'<div><b>訂房人電子郵件:</b>'+mail+'</div>'				
						info += '<div><b>是否為商務出差:</b>'+business+'</div>'			
						info +=	'<div><b>使用者:</b>'+user+'</div>'				
						info +=	'<div><b>備註:</b>'+annotation+'</div>'				
						info += '<hr>'
						info +=	'<div><b>住宿日:${loginDate}(${loginWeek})</b></div>'					
						info +=	'<div><b>退房日:${logoutDate}(${logoutWeek})</b></div>'
						info +=	'<div><b>所選住宿:</b>${hotel.hotelName}</div>'					
						info +=	'<div><b>住宿地點:</b>${hotel.add}</div>'					
						info +=	'<div><b>選擇房間:</b>'
						info +=	'<c:forEach begin="0" end="${fn:length(roomlist)-1}" var="i" step="1">'
						info +=	'<div>'
						info +=	'<span>${numlist[i]}</span>'
						info +=	'<span>X</span>'
						info +=	'<span>${roomlist[i].roomName}</span>'
						info +=	'<c:set var="item" value="${item}${roomlist[i].roomName}X${numlist[i]}"/>'
						info +=	'<c:if test="${i != (fn:length(roomlist)-1)}">'
						info +=	'<c:set var="item" value="${item}#"/>'
						info +=	'</c:if>'
						info +=	'</div>'
						info +=	'</c:forEach></div>'	
						info +=	'<div><b>預計抵達時間:</b>'+times+'</div>'	
						info +=	'<fmt:formatNumber type="number" maxFractionDigits="0" var="discountPrice">${totalPrice*0.95*between}</fmt:formatNumber>'
						info +=	'<span style="flex: 30%;">總計價格:TWD${discountPrice}</span>'	
						info += '<hr>'
						info += '<div><h5>住宿規定</h5></div>'
						info += '<div>'
						info += '<div>住宿方需要您同意以下住宿規定：</div>'
						info += '<div>'
						info += '<ul>'
						info += '<li>禁止吸菸</li>'
						info += '<li>23:00～06:00 必須放低音量</li>'
						info += '<li>禁止攜帶寵物入住</li>'
						info += '</ul>'
						info +=	'<fmt:formatNumber type="number" maxFractionDigits="0" var="discountPrice">${totalPrice*0.95}</fmt:formatNumber>'
						info += '<input type="hidden" name="TotalAmount" value="${discountPrice}">'	
						info += '<input type="hidden" name="TradeDesc" value="FormosaBooking_${hotel.hotelName}">'
						info += '<input type="hidden" name="ItemName" value="${item}">'	
						info += '<input type="hidden" name="loginDate" value="${loginDate}">'	
						info += '<input type="hidden" name="logoutDate" value="${logoutDate}">'	
						info += '<input type="hidden" name="name" value="'+name+'">'	
						info += '<input type="hidden" name="mail" value="'+mail+'">'	
						info += '<input type="hidden" name="annotation" value="'+annotation+'">'	
						info += '<input type="hidden" name="arriveTimes" value="'+times+'">'	
						info += '<input type="hidden" name="num" value="${numlist}">'	
						info += '<input type="hidden" name="roomId" value="${roomIdList}">'	
						info += '<input type="hidden" name="hotelId" value="${hotel.hotelId}">'	
						info += '<input type="hidden" name="userId" value="${sessionScope.loginCustomer.userId}">'	
						info += '</div>'
						$('#checkInfo').html(info)
						//打開最終確認
						finalCheck.showModal();
						//關閉回上一頁
						$('#x').click(function(){
							finalCheck.close();
						})
					}
				}
			}
		})
		
		//同意住宿規則才能往下
		$('#rule').click(function(){
			let rule = document.getElementById('rule').checked
			console.log(rule);
			if(rule == true){
				document.getElementById('o').disabled=false
				$(document.querySelectorAll('.o')).attr("id","x")
			}else{
				$(document.querySelectorAll('.o')).attr("id","o")
				document.getElementById('o').disabled=true
			}
		})
	</script>
	
</body>
</html>