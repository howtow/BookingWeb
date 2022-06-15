//用來整理標籤
let url = "http://localhost:8081/booking/"
		function countTag(col){
			tags = ""
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
			return tags;
		}

		$(document).ready(function(){
			//先設好所有需要的變數
			let userId = document.getElementById('userId').value
			document.getElementById('orderByScoreDESC').disabled=true
			let keyword = document.getElementById('keyword').value
			let loginDate = document.getElementById('loginDate').value
			let logoutDate = document.getElementById('logoutDate').value
			let num = document.getElementById('num').value
			let business = document.getElementById('forbusiness').value
			let col = ""
			let order = ""
			let orderby = ""
			let tags = ""
			//送ajax請求的函式
			function sendAjaxSearch(){
				// 搜尋時開啟等待視窗
				searching.showModal();
				setTimeout('searching.close();',500);
				if(userId!=""){
					$.ajax({
						url:"http://localhost:8081/booking/findcus",
						contentType:"application/x-www-form-urlencoded; charset=UTF-8",
						dataType:"json",
						method:"post",
						data:{
							"userId":userId
						},
						success:function(user){
							$.ajax({
								url:"http://localhost:8081/booking/searchEmptyHotelJ",
								contentType:"application/x-www-form-urlencoded; charset=UTF-8",
								dataType:"json",
								method:"post",
								data:{
									"order":order,
									"orderby":orderby,
									"keyword":keyword,
									"tag":tags,
									"loginDate":loginDate,
									"logoutDate":logoutDate,
									"num":num,
									"business":business
								},
								success:function(result){
									let returnRS = ''
									$('#searchResults').remove();
									$('#count1').remove();
									returnRS += '<div id="searchResults" style="width: 800px;">'
									$.each(result.content,function(index,hotel){
										let imgArr = hotel.pics.split(',')
										returnRS += '<div style="display: flex; " class="hotelblock"><div class="hotelimgf">'
										returnRS += '<a href="hotelDetail?keyword='+keyword+'&id='+hotel.hotelId+'&loginDate='+loginDate+'&logoutDate='+logoutDate+'&num='+num+'&business='+business+'&userId='+userId+'"><img src="'+imgArr[0]+'" class="hotelimgb"></a>'
										returnRS += '</div><div class="hotelinfof"><div class="hotelinfob"><div style="flex: 4.5;">'
										returnRS += '<div><a class="atext" href="hotelDetail?keyword='+keyword+'&id='+hotel.hotelId+'&loginDate='+loginDate+'&logoutDate='+logoutDate+'&num='+num+'&business='+business+'&userId='+userId+'"><span><h4>'+hotel.hotelName+'</h4></span></a></div>'
										returnRS += '<div><a href="http://localhost:8081/booking/"><span>首頁</span></a>'
										returnRS += '<i class="fa-solid fa-angle-right"></i>'
										returnRS += '<a href="searchEmptyHotel?keyword=&loginDate='+loginDate+'&logoutDate='+logoutDate+'&num='+num+'&business='+business+'&userId=${sessionScope.loginCustomer.userId}"><span>台灣</span></a>'
										returnRS += '<i class="fa-solid fa-angle-right"></i>'
										returnRS += '<a href="searchEmptyHotel?keyword='+hotel.region+'&loginDate='+loginDate+'&logoutDate='+logoutDate+'&num='+num+'&business='+business+'&userId=${sessionScope.loginCustomer.userId}"><span>'+hotel.region+'</span></a>'
										returnRS += '<i class="fa-solid fa-angle-right"></i>'
										returnRS += '<a href="searchEmptyHotel?keyword='+hotel.town+'&loginDate='+loginDate+'&logoutDate='+logoutDate+'&num='+num+'&business='+business+'&userId=${sessionScope.loginCustomer.userId}"><span>'+hotel.town+'</span></a>'
										returnRS += '</div></div>'
										returnRS += '<div style="flex: 4.5; display: flex;align-items: flex-start; justify-content: flex-end; background-color: white;width: 240px;">'
										returnRS += '<c:if test="${sessionScope.loginCustomer != null}">'
										returnRS += '<button  style="border:0px; background-color: white;">'
										if(user.favorite!=null){											
											if(!user.favorite.includes(hotel.hotelId)){
												returnRS += '<i class="fa-solid fa-heart addfavorite" id="'+hotel.hotelId+'"></i>'
											}else{
												returnRS += '<i class="fa-solid fa-heart removefavorite" id="'+hotel.hotelId+'"></i>'
											}
										}else{
											returnRS += '<i class="fa-solid fa-heart addfavorite" id="'+hotel.hotelId+'"></i>'
										}
										returnRS += '</button>'
										returnRS += '</c:if>'
										returnRS += '</div>'
										returnRS += '<div class="hotelrating" style="flex: 0.6;">'
										returnRS += '<a href="hotelDetail?keyword='+keyword+'&id='+hotel.hotelId+'&loginDate='+loginDate+'&logoutDate='+logoutDate+'&num='+num+'&business='+business+'&userId='+userId+'"><span>'+hotel.averageRating+'</span></a>'
										returnRS += '</div></div><div class="hotelinfob">'
										returnRS += '<div class="hoteldescrib">'+hotel.description+'</div>'
										returnRS += '<div class="hoteldetail">'
										returnRS += '<div style="font-size: 12px; color:gray;">最低價格<div style="color:#444444;"><h5>TWD'+hotel.lowestPrice+'起/晚</h5></div></div>'
										returnRS += '<div><a href="hotelDetail?keyword='+keyword+'&id='+hotel.hotelId+'&loginDate='+loginDate+'&logoutDate='+logoutDate+'&num='+num+'&business='+business+'&userId='+userId+'"><button class="submit" style="padding:10px;">查看客房供應情況></button></a></div>'
										returnRS += '</div></div></div></div>'
									})
									returnRS += '<div class="btnf">'
									returnRS += '<div>'
									if(result.number != 0){					
										returnRS += '<button type="button" class="pageBtn" value="'+result.number+'"><b>＜</b></button>'						
									}else{
										returnRS += '<button type="button" class="pageBtn clickedbtn" value="'+result.number+'" disabled="disabled"><b>＜</b></button>' 
									}
									returnRS += '</div>'
									returnRS += '<div>'
									if(result.totalPages<=5){
										for(let i=1; i<=result.totalPages;i++){
											if(result.number != i-1){
												returnRS += '<button type="button" class="pageBtn" value="'+i+'">'+i+'</button>'
											}else{
												returnRS += '<button type="button" class="pageBtn clickedbtn" disabled="disabled">'+i+'</button>'
											}
										}
									}else{
										if(result.number==0 || result.number==1 || result.number==2){
											for(let pageNumber=1 ; pageNumber<=5 ; pageNumber++){
												if(result.number != pageNumber-1){
													returnRS += '<button type="button" class="pageBtn" value="'+pageNumber+'">'+pageNumber+'</button>'
												}else{
													returnRS += '<button type="button" class="pageBtn clickedbtn" disabled="disabled">'+pageNumber+'</button>'
												}
											}
											returnRS += '<span><b>...</b></span>'						
											returnRS += '<button type="button" class="pageBtn" value="'+result.totalPages+'">'+result.totalPages+'</button>'	
										}else if(result.number==result.totalPages-1 || result.number==result.totalPages-2 || result.number==result.totalPages-3){
											returnRS += '<button type="button" class="pageBtn" value="1">1</button>'	
											returnRS += '<span><b>...</b></span>'
											for(let pageNumber=result.totalPages-4 ; pageNumber<=result.totalPages ; pageNumber++){
												if(result.number != pageNumber-1){
													returnRS += '<button type="button" class="pageBtn" value="'+pageNumber+'">'+pageNumber+'</button>'
												}else{
													returnRS += '<button type="button" class="pageBtn clickedbtn" disabled="disabled">'+pageNumber+'</button>'
												}
											}
										}else{
											returnRS += '<button type="button" class="pageBtn" value="1">1</button>'	
											returnRS += '<span><b>...</b></span>'
											for(let pageNumber=result.number-1 ; pageNumber<=result.number+3 ; pageNumber++){
												if(result.number != pageNumber-1){
													returnRS += '<button type="button" class="pageBtn" value="'+pageNumber+'">'+pageNumber+'</button>'
												}else{
													returnRS += '<button type="button" class="pageBtn clickedbtn" disabled="disabled">'+pageNumber+'</button>'
												}
											}
											returnRS += '<span><b>...</b></span>'						
											returnRS += '<button type="button" class="pageBtn" value="'+result.totalPages+'">'+result.totalPages+'</button>'						
										}
									}
									returnRS += '</div>'
									returnRS += '<div>'
									if(result.number != result.totalPages-1){
										returnRS += '<button type="button" class="pageBtn" value="'+(result.number+2)+'"><b>＞</b></button>'					
									}else{
										returnRS += '<button type="button" class="pageBtn clickedbtn" value="'+result.number+'" disabled="disabled"><b>＞</b></button>' 
									}
									returnRS += '</div>'
									returnRS += '</div>'
									returnRS += '<input type="hidden" value="'+userId+'" id="userId"/>'
									returnRS += '<input type="hidden" value="'+keyword+'" id="keyword"/>'
									returnRS += '<input type="hidden" value="'+order+'" id="order"/>'
									returnRS += '<input type="hidden" value="'+orderby+'" id="orderby"/>'
									returnRS += '<input type="hidden" value="'+loginDate+'" id="loginDate"/>'
									returnRS += '<input type="hidden" value="'+logoutDate+'" id="logoutDate"/>'
									returnRS += '<input type="hidden" value="'+num+'" id="num"/>'
									returnRS += '<input type="hidden" value="'+business+'" id="forbusiness"/>'
									returnRS += '</div>'
									$('#searchResults2').append(returnRS)
									$('#count2').append('<span id="count1">'+result.totalElements+'</span>')
								},
								error:function(err){
									console.log(err);
									alert('hotel發生錯誤')
								}
							})
						},
						error:function(err){
							console.log(err);
							alert('user發生錯誤')
						}
					})
				}else{	
					$.ajax({
						url:"http://localhost:8081/booking/searchEmptyHotelJ",
						contentType:"application/x-www-form-urlencoded; charset=UTF-8",
						dataType:"json",
						method:"post",
						data:{
							"order":order,
							"orderby":orderby,
							"keyword":keyword,
							"tag":tags,
							"loginDate":loginDate,
							"logoutDate":logoutDate,
							"num":num,
							"business":business
						},
						success:function(result){
							let returnRS = ''
							$('#searchResults').remove();
							$('#count1').remove();
							returnRS += '<div id="searchResults" style="width: 800px;">'
							$.each(result.content,function(index,hotel){
								let imgArr = hotel.pics.split(',')
								returnRS += '<div style="display: flex; " class="hotelblock"><div class="hotelimgf">'
								returnRS += '<a href="hotelDetail?keyword='+keyword+'&id='+hotel.hotelId+'&loginDate='+loginDate+'&logoutDate='+logoutDate+'&num='+num+'&business='+business+'&userId='+userId+'"><img src="'+imgArr[0]+'" class="hotelimgb"></a>'
								returnRS += '</div><div class="hotelinfof"><div class="hotelinfob"><div style="flex: 4.5;">'
								returnRS += '<div><a class="atext" href="hotelDetail?keyword='+keyword+'&id='+hotel.hotelId+'&loginDate='+loginDate+'&logoutDate='+logoutDate+'&num='+num+'&business='+business+'&userId='+userId+'"><span><h4>'+hotel.hotelName+'</h4></span></a></div>'
								returnRS += '<div><a href="http://localhost:8081/booking/"><span>首頁</span></a>'
								returnRS += '<i class="fa-solid fa-angle-right"></i>'
								returnRS += '<a href="searchEmptyHotel?keyword=&loginDate='+loginDate+'&logoutDate='+logoutDate+'&num='+num+'&business='+business+'&userId=${sessionScope.loginCustomer.userId}"><span>台灣</span></a>'
								returnRS += '<i class="fa-solid fa-angle-right"></i>'
								returnRS += '<a href="searchEmptyHotel?keyword='+hotel.region+'&loginDate='+loginDate+'&logoutDate='+logoutDate+'&num='+num+'&business='+business+'&userId=${sessionScope.loginCustomer.userId}"><span>'+hotel.region+'</span></a>'
								returnRS += '<i class="fa-solid fa-angle-right"></i>'
								returnRS += '<a href="searchEmptyHotel?keyword='+hotel.town+'&loginDate='+loginDate+'&logoutDate='+logoutDate+'&num='+num+'&business='+business+'&userId=${sessionScope.loginCustomer.userId}"><span>'+hotel.town+'</span></a>'
								returnRS += '</div></div>'
								returnRS += '<div style="flex: 4.5; display: flex;align-items: flex-start; justify-content: flex-end; background-color: white;width: 240px;">'
								returnRS += '</div>'
								returnRS += '<div class="hotelrating" style="flex: 0.6;">'
								returnRS += '<a href="hotelDetail?keyword='+keyword+'&id='+hotel.hotelId+'&loginDate='+loginDate+'&logoutDate='+logoutDate+'&num='+num+'&business='+business+'&userId='+userId+'"><span>'+hotel.averageRating+'</span></a>'
								returnRS += '</div></div><div class="hotelinfob">'
								returnRS += '<div class="hoteldescrib">'+hotel.description+'</div>'
								returnRS += '<div class="hoteldetail">'
								returnRS += '<div style="font-size: 12px; color:gray;">最低價格<div style="color:#444444;"><h5>TWD'+hotel.lowestPrice+'起/晚</h5></div></div>'
								returnRS += '<div><a href="hotelDetail?keyword='+keyword+'&id='+hotel.hotelId+'&loginDate='+loginDate+'&logoutDate='+logoutDate+'&num='+num+'&business='+business+'&userId='+userId+'"><button class="submit" style="padding:10px;">查看客房供應情況></button></a></div>'
								returnRS += '</div></div></div></div>'
							})
							returnRS += '<div class="btnf">'
							returnRS += '<div>'
							if(result.number != 0){					
								returnRS += '<button type="button" class="pageBtn" value="'+result.number+'"><b>＜</b></button>'						
							}else{
								returnRS += '<button type="button" class="pageBtn clickedbtn" value="'+result.number+'" disabled="disabled"><b>＜</b></button>' 
							}
							returnRS += '</div>'
							returnRS += '<div>'
							if(result.totalPages<=5){
								for(let i=1; i<=result.totalPages;i++){
									if(result.number != i-1){
										returnRS += '<button type="button" class="pageBtn" value="'+i+'">'+i+'</button>'
									}else{
										returnRS += '<button type="button" class="pageBtn clickedbtn" disabled="disabled">'+i+'</button>'
									}
								}
							}else{
								if(result.number==0 || result.number==1 || result.number==2){
									for(let pageNumber=1 ; pageNumber<=5 ; pageNumber++){
										if(result.number != pageNumber-1){
											returnRS += '<button type="button" class="pageBtn" value="'+pageNumber+'">'+pageNumber+'</button>'
										}else{
											returnRS += '<button type="button" class="pageBtn clickedbtn" disabled="disabled">'+pageNumber+'</button>'
										}
									}
									returnRS += '<span><b>...</b></span>'						
									returnRS += '<button type="button" class="pageBtn" value="'+result.totalPages+'">'+result.totalPages+'</button>'	
								}else if(result.number==result.totalPages-1 || result.number==result.totalPages-2 || result.number==result.totalPages-3){
									returnRS += '<button type="button" class="pageBtn" value="1">1</button>'	
									returnRS += '<span><b>...</b></span>'
									for(let pageNumber=result.totalPages-4 ; pageNumber<=result.totalPages ; pageNumber++){
										if(result.number != pageNumber-1){
											returnRS += '<button type="button" class="pageBtn" value="'+pageNumber+'">'+pageNumber+'</button>'
										}else{
											returnRS += '<button type="button" class="pageBtn clickedbtn" disabled="disabled">'+pageNumber+'</button>'
										}
									}
								}else{
									returnRS += '<button type="button" class="pageBtn" value="1">1</button>'	
									returnRS += '<span><b>...</b></span>'
									for(let pageNumber=result.number-1 ; pageNumber<=result.number+3 ; pageNumber++){
										if(result.number != pageNumber-1){
											returnRS += '<button type="button" class="pageBtn" value="'+pageNumber+'">'+pageNumber+'</button>'
										}else{
											returnRS += '<button type="button" class="pageBtn clickedbtn" disabled="disabled">'+pageNumber+'</button>'
										}
									}
									returnRS += '<span><b>...</b></span>'						
									returnRS += '<button type="button" class="pageBtn" value="'+result.totalPages+'">'+result.totalPages+'</button>'						
								}
							}
							returnRS += '</div>'
							returnRS += '<div>'
							if(result.number != result.totalPages-1){
								returnRS += '<button type="button" class="pageBtn" value="'+(result.number+2)+'"><b>＞</b></button>'					
							}else{
								returnRS += '<button type="button" class="pageBtn clickedbtn" value="'+result.number+'" disabled="disabled"><b>＞</b></button>' 
							}
							returnRS += '</div>'
							returnRS += '</div>'
							returnRS += '<input type="hidden" value="'+userId+'" id="userId"/>'
							returnRS += '<input type="hidden" value="'+keyword+'" id="keyword"/>'
							returnRS += '<input type="hidden" value="'+order+'" id="order"/>'
							returnRS += '<input type="hidden" value="'+orderby+'" id="orderby"/>'
							returnRS += '<input type="hidden" value="'+loginDate+'" id="loginDate"/>'
							returnRS += '<input type="hidden" value="'+logoutDate+'" id="logoutDate"/>'
							returnRS += '<input type="hidden" value="'+num+'" id="num"/>'
							returnRS += '<input type="hidden" value="'+business+'" id="forbusiness"/>'
							returnRS += '</div>'
							$('#searchResults2').append(returnRS)
							$('#count2').append('<span id="count1">'+result.totalElements+'</span>')
						},
						error:function(err){
							console.log(err);
							alert('hotel發生錯誤')
						}
					})
				}
			}
			
			//排序:評分高至低
			$('#orderByScoreDESC').click(function(){
				document.getElementById('orderByScoreDESC').disabled=true
				document.getElementById('orderByScoreASC').disabled=false
				document.getElementById('orderByPriceDESC').disabled=false
				document.getElementById('orderByPriceASC').disabled=false
				col = document.getElementsByClassName('tag')
				order = "desc"
				orderby = "averageRating"
				tags = countTag(col)
				sendAjaxSearch()
			})
 			
			//排序:評分低至高
			$('#orderByScoreASC').click(function(){
				document.getElementById('orderByScoreDESC').disabled=false
				document.getElementById('orderByScoreASC').disabled=true
				document.getElementById('orderByPriceDESC').disabled=false
				document.getElementById('orderByPriceASC').disabled=false
				col = document.getElementsByClassName('tag')
				order = "asc"
				orderby = "averageRating"
				tags = countTag(col)
				sendAjaxSearch()
			})

			//排序:價格高至低
			$('#orderByPriceDESC').click(function(){
				document.getElementById('orderByScoreDESC').disabled=false
				document.getElementById('orderByScoreASC').disabled=false
				document.getElementById('orderByPriceDESC').disabled=true
				document.getElementById('orderByPriceASC').disabled=false
				col = document.getElementsByClassName('tag')
				order = "desc"
				orderby = "lowestPrice"
				tags = countTag(col)
				sendAjaxSearch()
			})
		
			//排序:價格低至高
			$('#orderByPriceASC').click(function(){
				document.getElementById('orderByScoreDESC').disabled=false
				document.getElementById('orderByScoreASC').disabled=false
				document.getElementById('orderByPriceDESC').disabled=false
				document.getElementById('orderByPriceASC').disabled=true
				col = document.getElementsByClassName('tag')
				order = "asc"
				orderby = "lowestPrice"
				tags = countTag(col)
				sendAjaxSearch()
			})

			//關於標籤檢索	
			$('.tag').click(function(){
				col = document.getElementsByClassName('tag')
				order = document.getElementById('order').value
				orderby = document.getElementById('orderby').value
				tags = countTag(col)
				//回頂端
				$("html,body").animate({
					scrollTop: 200,},
					100
				);
				sendAjaxSearch()
			})
		
			//勾選出差顯示提示
			$('#business').click(function(){
				var check = document.getElementById('business');
				if(check.checked==true){
					$('#show').remove()
					$('#note').append('<span id="show" style="font-size: 10px; color:red;">(優先搜尋附早餐/停車/網路)</span>')
				}else{
					$('#show').remove()
					$('#note').append('<br id="show">')
				}
			})
		})

		//關於轉頁
		//直接綁標籤，不可用.ready或是onload不然ajax刷新會沒辦法附上事件
		$(document).on('click','.pageBtn',function(){
			//回頂端
			$("html,body").animate({
				scrollTop: 200,},
				100
			);
			// 搜尋時開啟等待視窗
			searching.showModal();
			setTimeout('searching.close();',500);
			let userId = document.getElementById('userId').value
			let keyword = document.getElementById('keyword').value
			let col = document.getElementsByClassName('tag')
			let order = document.getElementById('order').value
			let orderby = document.getElementById('orderby').value
			let loginDate = document.getElementById('loginDate').value
			let logoutDate = document.getElementById('logoutDate').value
			let num = document.getElementById('num').value
			let business = document.getElementById('forbusiness').value
			let page = $(this).attr('value')
			let tags = countTag(col)
			
			if(userId!=""){
				$.ajax({
					url:"http://localhost:8081/booking/findcus",
					contentType:"application/x-www-form-urlencoded; charset=UTF-8",
					dataType:"json",
					method:"post",
					data:{
						"userId":userId
					},
					success:function(user){
						$.ajax({
							url:"http://localhost:8081/booking/searchEmptyHotelJ",
							contentType:"application/x-www-form-urlencoded; charset=UTF-8",
							dataType:"json",
							method:"post",
							data:{
								"page":page,
								"order":order,
								"orderby":orderby,
								"keyword":keyword,
								"tag":tags,
								"loginDate":loginDate,
								"logoutDate":logoutDate,
								"num":num,
								"business":business,
								"userId":userId
							},
							success:function(result){
								let returnRS = ''
								$('#searchResults').remove();
								$('#count1').remove();
								returnRS += '<div id="searchResults" style="width: 800px;">'
								$.each(result.content,function(index,hotel){
									let imgArr = hotel.pics.split(',')
									returnRS += '<div style="display: flex; " class="hotelblock"><div class="hotelimgf">'
									returnRS += '<a href="hotelDetail?keyword='+keyword+'&id='+hotel.hotelId+'&loginDate='+loginDate+'&logoutDate='+logoutDate+'&num='+num+'&business='+business+'&userId='+userId+'"><img src="'+imgArr[0]+'" class="hotelimgb"></a>'
									returnRS += '</div><div class="hotelinfof"><div class="hotelinfob"><div style="flex: 4.5;">'
									returnRS += '<div><a class="atext" href="hotelDetail?keyword='+keyword+'&id='+hotel.hotelId+'&loginDate='+loginDate+'&logoutDate='+logoutDate+'&num='+num+'&business='+business+'&userId='+userId+'"><span><h4>'+hotel.hotelName+'</h4></span></a></div>'
									returnRS += '<div><a href="http://localhost:8081/booking/"><span>首頁</span></a>'
									returnRS += '<i class="fa-solid fa-angle-right"></i>'
									returnRS += '<a href="searchEmptyHotel?keyword=&loginDate='+loginDate+'&logoutDate='+logoutDate+'&num='+num+'&business='+business+'&userId=${sessionScope.loginCustomer.userId}"><span>台灣</span></a>'
									returnRS += '<i class="fa-solid fa-angle-right"></i>'
									returnRS += '<a href="searchEmptyHotel?keyword='+hotel.region+'&loginDate='+loginDate+'&logoutDate='+logoutDate+'&num='+num+'&business='+business+'&userId=${sessionScope.loginCustomer.userId}"><span>'+hotel.region+'</span></a>'
									returnRS += '<i class="fa-solid fa-angle-right"></i>'
									returnRS += '<a href="searchEmptyHotel?keyword='+hotel.town+'&loginDate='+loginDate+'&logoutDate='+logoutDate+'&num='+num+'&business='+business+'&userId=${sessionScope.loginCustomer.userId}"><span>'+hotel.town+'</span></a>'
									returnRS += '</div></div>'
									returnRS += '<div style="flex: 4.5; display: flex;align-items: flex-start; justify-content: flex-end; background-color: white;width: 240px;">'
									returnRS += '<c:if test="${sessionScope.loginCustomer != null}">'
									returnRS += '<button  style="border:0px; background-color: white;">'
									if(user.favorite!=null){											
										if(!user.favorite.includes(hotel.hotelId)){
											returnRS += '<i class="fa-solid fa-heart addfavorite" id="'+hotel.hotelId+'"></i>'
										}else{
											returnRS += '<i class="fa-solid fa-heart removefavorite" id="'+hotel.hotelId+'"></i>'
										}
									}else{
										returnRS += '<i class="fa-solid fa-heart addfavorite" id="'+hotel.hotelId+'"></i>'
									}
									returnRS += '</button>'
									returnRS += '</c:if>'
									returnRS += '</div>'
									returnRS += '<div class="hotelrating" style="flex: 0.6;">'
									returnRS += '<a href="hotelDetail?keyword='+keyword+'&id='+hotel.hotelId+'&loginDate='+loginDate+'&logoutDate='+logoutDate+'&num='+num+'&business='+business+'&userId='+userId+'"><span>'+hotel.averageRating+'</span></a>'
									returnRS += '</div></div><div class="hotelinfob">'
									returnRS += '<div class="hoteldescrib">'+hotel.description+'</div>'
									returnRS += '<div class="hoteldetail">'
									returnRS += '<div style="font-size: 12px; color:gray;">最低價格<div style="color:#444444;"><h5>TWD'+hotel.lowestPrice+'起/晚</h5></div></div>'
									returnRS += '<div><a href="hotelDetail?keyword='+keyword+'&id='+hotel.hotelId+'&loginDate='+loginDate+'&logoutDate='+logoutDate+'&num='+num+'&business='+business+'&userId='+userId+'"><button class="submit" style="padding:10px;">查看客房供應情況></button></a></div>'
									returnRS += '</div></div></div></div>'
								})
								returnRS += '<div class="btnf">'
								returnRS += '<div>'
								if(result.number != 0){					
									returnRS += '<button type="button" class="pageBtn" value="'+result.number+'"><b>＜</b></button>'						
								}else{
									returnRS += '<button type="button" class="pageBtn clickedbtn" value="'+result.number+'" disabled="disabled"><b>＜</b></button>' 
								}
								returnRS += '</div>'
								returnRS += '<div>'
								if(result.totalPages<=5){
									for(let i=1; i<=result.totalPages;i++){
										if(result.number != i-1){
											returnRS += '<button type="button" class="pageBtn" value="'+i+'">'+i+'</button>'
										}else{
											returnRS += '<button type="button" class="pageBtn clickedbtn" disabled="disabled">'+i+'</button>'
										}
									}
								}else{
									if(result.number==0 || result.number==1 || result.number==2){
										for(let pageNumber=1 ; pageNumber<=5 ; pageNumber++){
											if(result.number != pageNumber-1){
												returnRS += '<button type="button" class="pageBtn" value="'+pageNumber+'">'+pageNumber+'</button>'
											}else{
												returnRS += '<button type="button" class="pageBtn clickedbtn" disabled="disabled">'+pageNumber+'</button>'
											}
										}
										returnRS += '<span><b>...</b></span>'						
										returnRS += '<button type="button" class="pageBtn" value="'+result.totalPages+'">'+result.totalPages+'</button>'	
									}else if(result.number==result.totalPages-1 || result.number==result.totalPages-2 || result.number==result.totalPages-3){
										returnRS += '<button type="button" class="pageBtn" value="1">1</button>'	
										returnRS += '<span><b>...</b></span>'
										for(let pageNumber=result.totalPages-4 ; pageNumber<=result.totalPages ; pageNumber++){
											if(result.number != pageNumber-1){
												returnRS += '<button type="button" class="pageBtn" value="'+pageNumber+'">'+pageNumber+'</button>'
											}else{
												returnRS += '<button type="button" class="pageBtn clickedbtn" disabled="disabled">'+pageNumber+'</button>'
											}
										}
									}else{
										returnRS += '<button type="button" class="pageBtn" value="1">1</button>'	
										returnRS += '<span><b>...</b></span>'
										for(let pageNumber=result.number-1 ; pageNumber<=result.number+3 ; pageNumber++){
											if(result.number != pageNumber-1){
												returnRS += '<button type="button" class="pageBtn" value="'+pageNumber+'">'+pageNumber+'</button>'
											}else{
												returnRS += '<button type="button" class="pageBtn clickedbtn" disabled="disabled">'+pageNumber+'</button>'
											}
										}
										returnRS += '<span><b>...</b></span>'						
										returnRS += '<button type="button" class="pageBtn" value="'+result.totalPages+'">'+result.totalPages+'</button>'						
									}
								}
								returnRS += '</div>'
								returnRS += '<div>'
								if(result.number != result.totalPages-1){
									returnRS += '<button type="button" class="pageBtn" value="'+(result.number+2)+'"><b>＞</b></button>'					
								}else{
									returnRS += '<button type="button" class="pageBtn clickedbtn" value="'+result.number+'" disabled="disabled"><b>＞</b></button>' 
								}
								returnRS += '</div>'
								returnRS += '</div>'
								returnRS += '<input type="hidden" value="'+userId+'" id="userId"/>'
								returnRS += '<input type="hidden" value="'+keyword+'" id="keyword"/>'
								returnRS += '<input type="hidden" value="'+order+'" id="order"/>'
								returnRS += '<input type="hidden" value="'+orderby+'" id="orderby"/>'
								returnRS += '<input type="hidden" value="'+loginDate+'" id="loginDate"/>'
								returnRS += '<input type="hidden" value="'+logoutDate+'" id="logoutDate"/>'
								returnRS += '<input type="hidden" value="'+num+'" id="num"/>'
								returnRS += '<input type="hidden" value="'+business+'" id="forbusiness"/>'
								returnRS += '</div>'
								$('#searchResults2').append(returnRS)
								$('#count2').append('<span id="count1">'+result.totalElements+'</span>')
							},
							error:function(err){
								console.log(err);
								alert('發生錯誤')
							}
						})
					},
					error:function(err){
						console.log(err);
						alert('user發生錯誤')
					}
				})
			}else{
				$.ajax({
					url:"http://localhost:8081/booking/searchEmptyHotelJ",
					contentType:"application/x-www-form-urlencoded; charset=UTF-8",
					dataType:"json",
					method:"post",
					data:{
						"page":page,
						"order":order,
						"orderby":orderby,
						"keyword":keyword,
						"tag":tags,
						"loginDate":loginDate,
						"logoutDate":logoutDate,
						"num":num,
						"business":business,
						"userId":userId
					},
					success:function(result){
						let returnRS = ''
						$('#searchResults').remove();
						$('#count1').remove();
						returnRS += '<div id="searchResults" style="width: 800px;">'
						$.each(result.content,function(index,hotel){
							let imgArr = hotel.pics.split(',')
							returnRS += '<div style="display: flex; " class="hotelblock"><div class="hotelimgf">'
							returnRS += '<a href="hotelDetail?keyword='+keyword+'&id='+hotel.hotelId+'&loginDate='+loginDate+'&logoutDate='+logoutDate+'&num='+num+'&business='+business+'&userId='+userId+'"><img src="'+imgArr[0]+'" class="hotelimgb"></a>'
							returnRS += '</div><div class="hotelinfof"><div class="hotelinfob"><div style="flex: 4.5;">'
							returnRS += '<div><a class="atext" href="hotelDetail?keyword='+keyword+'&id='+hotel.hotelId+'&loginDate='+loginDate+'&logoutDate='+logoutDate+'&num='+num+'&business='+business+'&userId='+userId+'"><span><h4>'+hotel.hotelName+'</h4></span></a></div>'
							returnRS += '<div><a href="http://localhost:8081/booking/"><span>首頁</span></a>'
							returnRS += '<i class="fa-solid fa-angle-right"></i>'
							returnRS += '<a href="searchEmptyHotel?keyword=&loginDate='+loginDate+'&logoutDate='+logoutDate+'&num='+num+'&business='+business+'&userId=${sessionScope.loginCustomer.userId}"><span>台灣</span></a>'
							returnRS += '<i class="fa-solid fa-angle-right"></i>'
							returnRS += '<a href="searchEmptyHotel?keyword='+hotel.region+'&loginDate='+loginDate+'&logoutDate='+logoutDate+'&num='+num+'&business='+business+'&userId=${sessionScope.loginCustomer.userId}"><span>'+hotel.region+'</span></a>'
							returnRS += '<i class="fa-solid fa-angle-right"></i>'
							returnRS += '<a href="searchEmptyHotel?keyword='+hotel.town+'&loginDate='+loginDate+'&logoutDate='+logoutDate+'&num='+num+'&business='+business+'&userId=${sessionScope.loginCustomer.userId}"><span>'+hotel.town+'</span></a>'
							returnRS += '</div></div>'
							returnRS += '<div style="flex: 4.5; display: flex;align-items: flex-start; justify-content: flex-end; background-color: white;width: 240px;">'
							
							returnRS += '</div>'
							returnRS += '<div class="hotelrating" style="flex: 0.6;">'
							returnRS += '<a href="hotelDetail?keyword='+keyword+'&id='+hotel.hotelId+'&loginDate='+loginDate+'&logoutDate='+logoutDate+'&num='+num+'&business='+business+'&userId='+userId+'"><span>'+hotel.averageRating+'</span></a>'
							returnRS += '</div></div><div class="hotelinfob">'
							returnRS += '<div class="hoteldescrib">'+hotel.description+'</div>'
							returnRS += '<div class="hoteldetail">'
							returnRS += '<div style="font-size: 12px; color:gray;">最低價格<div style="color:#444444;"><h5>TWD'+hotel.lowestPrice+'起/晚</h5></div></div>'
							returnRS += '<div><a href="hotelDetail?keyword='+keyword+'&id='+hotel.hotelId+'&loginDate='+loginDate+'&logoutDate='+logoutDate+'&num='+num+'&business='+business+'&userId='+userId+'"><button class="submit" style="padding:10px;">查看客房供應情況></button></a></div>'
							returnRS += '</div></div></div></div>'
						})
						returnRS += '<div class="btnf">'
						returnRS += '<div>'
						if(result.number != 0){					
							returnRS += '<button type="button" class="pageBtn" value="'+result.number+'"><b>＜</b></button>'						
						}else{
							returnRS += '<button type="button" class="pageBtn clickedbtn" value="'+result.number+'" disabled="disabled"><b>＜</b></button>' 
						}
						returnRS += '</div>'
						returnRS += '<div>'
						if(result.totalPages<=5){
							for(let i=1; i<=result.totalPages;i++){
								if(result.number != i-1){
									returnRS += '<button type="button" class="pageBtn" value="'+i+'">'+i+'</button>'
								}else{
									returnRS += '<button type="button" class="pageBtn clickedbtn" disabled="disabled">'+i+'</button>'
								}
							}
						}else{
							if(result.number==0 || result.number==1 || result.number==2){
								for(let pageNumber=1 ; pageNumber<=5 ; pageNumber++){
									if(result.number != pageNumber-1){
										returnRS += '<button type="button" class="pageBtn" value="'+pageNumber+'">'+pageNumber+'</button>'
									}else{
										returnRS += '<button type="button" class="pageBtn clickedbtn" disabled="disabled">'+pageNumber+'</button>'
									}
								}
								returnRS += '<span><b>...</b></span>'						
								returnRS += '<button type="button" class="pageBtn" value="'+result.totalPages+'">'+result.totalPages+'</button>'	
							}else if(result.number==result.totalPages-1 || result.number==result.totalPages-2 || result.number==result.totalPages-3){
								returnRS += '<button type="button" class="pageBtn" value="1">1</button>'	
								returnRS += '<span><b>...</b></span>'
								for(let pageNumber=result.totalPages-4 ; pageNumber<=result.totalPages ; pageNumber++){
									if(result.number != pageNumber-1){
										returnRS += '<button type="button" class="pageBtn" value="'+pageNumber+'">'+pageNumber+'</button>'
									}else{
										returnRS += '<button type="button" class="pageBtn clickedbtn" disabled="disabled">'+pageNumber+'</button>'
									}
								}
							}else{
								returnRS += '<button type="button" class="pageBtn" value="1">1</button>'	
								returnRS += '<span><b>...</b></span>'
								for(let pageNumber=result.number-1 ; pageNumber<=result.number+3 ; pageNumber++){
									if(result.number != pageNumber-1){
										returnRS += '<button type="button" class="pageBtn" value="'+pageNumber+'">'+pageNumber+'</button>'
									}else{
										returnRS += '<button type="button" class="pageBtn clickedbtn" disabled="disabled">'+pageNumber+'</button>'
									}
								}
								returnRS += '<span><b>...</b></span>'						
								returnRS += '<button type="button" class="pageBtn" value="'+result.totalPages+'">'+result.totalPages+'</button>'						
							}
						}
						returnRS += '</div>'
						returnRS += '<div>'
						if(result.number != result.totalPages-1){
							returnRS += '<button type="button" class="pageBtn" value="'+(result.number+2)+'"><b>＞</b></button>'					
						}else{
							returnRS += '<button type="button" class="pageBtn clickedbtn" value="'+result.number+'" disabled="disabled"><b>＞</b></button>' 
						}
						returnRS += '</div>'
						returnRS += '</div>'
						returnRS += '<input type="hidden" value="'+userId+'" id="userId"/>'
						returnRS += '<input type="hidden" value="'+keyword+'" id="keyword"/>'
						returnRS += '<input type="hidden" value="'+order+'" id="order"/>'
						returnRS += '<input type="hidden" value="'+orderby+'" id="orderby"/>'
						returnRS += '<input type="hidden" value="'+loginDate+'" id="loginDate"/>'
						returnRS += '<input type="hidden" value="'+logoutDate+'" id="logoutDate"/>'
						returnRS += '<input type="hidden" value="'+num+'" id="num"/>'
						returnRS += '<input type="hidden" value="'+business+'" id="forbusiness"/>'
						returnRS += '</div>'
						$('#searchResults2').append(returnRS)
						$('#count2').append('<span id="count1">'+result.totalElements+'</span>')
					},
					error:function(err){
						console.log(err);
						alert('發生錯誤')
					}
				})
			}
		})