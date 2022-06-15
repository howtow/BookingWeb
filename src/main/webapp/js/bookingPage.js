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
				$('html,body').animate({
					scrollTop: $('#cusName').offset().top-110
					}, 100
				);
			}else{
				if(mail=="" || checkMail=="" || mail!=checkMail){
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