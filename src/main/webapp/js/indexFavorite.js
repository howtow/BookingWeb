document.querySelector("#favoritebtn").addEventListener("click", function(){
			let userId = document.getElementById('userId').value
			$.ajax({
				url:"http://localhost:8081/booking/myFavorite",
				contentType:"application/x-www-form-urlencoded; charset=UTF-8",
				dataType:"json",
				method:"get",
				data:{
					"userId":userId
				},
				success:function(hotellist){
					if(hotellist!=""){
						let rt = ''; 
						rt += '<div><hr style="margin:0px"></div>'
						rt += '<div>'
						$.each(hotellist,function(index,hotel){
							let imgArr = hotel.pics.split(',')
							rt += '<div class="hotelblock" style="display: flex; height:200px; overflow:hidden;">'
							rt += '<div style="flex: 1; display: flex; align-items: center; overflow:hidden;">'
							rt += '<a href="hotelDetail?id='+hotel.hotelId+'&userId='+userId+'"><img src="'+imgArr[0]+'" style="width: 100%;"></a>'
							rt += '</div>'
							rt += '<div style="flex: 2; padding:16px 0px 16px 16px; overflow:hidden; display:flex; flex-direction: column;">'
							rt += '<div style="display: flex; justify-content: space-between; flex:1;">'
							rt += '<div>'
							rt += '<div>'
							rt += '<a href="hotelDetail?id='+hotel.hotelId+'&userId='+userId+'"><span><h5>'+hotel.hotelName+'</h5></span></a>'
							rt += '</div>'
							rt += '<div>'
							rt += '<span style="font-weight: bold; border-bottom:0.5px solid gray; font-size:12px;">'+hotel.add+'</span>'
							rt += '</div>'
							rt += '</div>'
							rt += '<div class="hotelrating">'
							rt += '<a href="hotelDetail?id='+hotel.hotelId+'&userId='+userId+'"><span>'+hotel.averageRating+'</span></a>'
							rt += '</div>'
							rt += '</div>'
							rt += '<div class="hotelinfob" style=" flex:1;">'
							rt += '<div class="hoteldescrib" style="padding-right: 10px;">'+hotel.description+'</div>'
							rt += '<div style="display: flex; align-items: center; justify-content: flex-end; background-color: white;">'
							rt += '<button style="border:0px; background-color: white;">'
							rt += '<i class="fa-solid fa-heart removeandrefresh" id='+hotel.hotelId+'></i>'
							rt += '</button>'
							rt += '</div>'
							rt += '</div>'
							rt += '</div>'
							rt += '</div>'
						})
						rt += '</div>'
						$('#favoritebody').html(rt)
					}else{
						$('#favoritebody').html('<div><hr style="margin:0px"></div><div><b><h4 style="color:red; margin:30px">暫無收藏</h4></b></div>')
					}
				},
				error:function(err){
					console.log(err);
					alert('發生錯誤')
                }
			})
			favoritehead.showModal();
		})
		
		document.querySelector("#closefavorite").addEventListener("click", function(){
			favoritehead.close();
		})

		$(document).on('click','.removeandrefresh',function(){
			let hotelId = this.id;
			let userId = document.getElementById('userId').value
			console.log(1111);
			$.ajax({
				url:"http://localhost:8081/booking/removeandrefresh",
				contentType:"application/x-www-form-urlencoded; charset=UTF-8",
				dataType:"json",
				method:"get",
				data:{
					"hotelId":hotelId,
					"userId":userId
				},
				success:function(hotellist){
					//刪除時開啟等待視窗
					deletedialog.showModal();
					setTimeout('deletedialog.close()',500);
					if(hotellist!=""){
						let rt = ''; 
						rt += '<div><hr style="margin:0px"></div>'
						rt += '<div>'
						$.each(hotellist,function(index,hotel){
							let imgArr = hotel.pics.split(',')
							rt += '<div class="hotelblock" style="display: flex; height:200px; overflow:hidden;">'
							rt += '<div style="flex: 1; display: flex; align-items: center; overflow:hidden;">'
							rt += '<a href="hotelDetail?id='+hotel.hotelId+'&userId='+userId+'"><img src="'+imgArr[0]+'" style="width: 100%;"></a>'
							rt += '</div>'
							rt += '<div style="flex: 2; padding:16px 0px 16px 16px; overflow:hidden; display:flex; flex-direction: column;">'
							rt += '<div style="display: flex; justify-content: space-between; flex:1;">'
							rt += '<div>'
							rt += '<div>'
							rt += '<a href="hotelDetail?id='+hotel.hotelId+'&userId='+userId+'"><span><h4>'+hotel.hotelName+'</h4></span></a>'
							rt += '</div>'
							rt += '<div>'
							rt += '<span style="font-weight: bold; border-bottom:0.5px solid gray;">'+hotel.add+'</span>'
							rt += '</div>'
							rt += '</div>'
							rt += '<div class="hotelrating">'
							rt += '<a href="hotelDetail?id='+hotel.hotelId+'&userId='+userId+'"><span>'+hotel.averageRating+'</span></a>'
							rt += '</div>'
							rt += '</div>'
							rt += '<div class="hotelinfob" style=" flex:1;">'
							rt += '<div class="hoteldescrib" style="padding-right: 10px;">'+hotel.description+'</div>'
							rt += '<div style="display: flex; align-items: center; justify-content: flex-end; background-color: white;">'
							rt += '<button style="border:0px; background-color: white;">'
							rt += '<i class="fa-solid fa-heart removeandrefresh" id='+hotel.hotelId+'></i>'
							rt += '</button>'
							rt += '</div>'
							rt += '</div>'
							rt += '</div>'
							rt += '</div>'
						})
						rt += '</div>'
						$('#favoritebody').html(rt)
					}else{
						$('#favoritebody').html('<div><hr style="margin:0px"></div><div><b><h4 style="color:red; margin:30px">暫無收藏</h4></b></div>')
					}
				},
				error:function(err){
					console.log(err);
				}
			})
		})