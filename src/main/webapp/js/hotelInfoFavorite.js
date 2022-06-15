$(document).on('click','.addfavorite',function(){
	$(this).attr('class','fa-solid fa-heart removefavorite')
	let hotelId = this.id;
	let userId = document.getElementById('userId').value
	$.ajax({
		url:"http://localhost:8081/booking/addfavorite",
		contentType:"application/x-www-form-urlencoded; charset=UTF-8",
		dataType:"json",
		method:"get",
		data:{
			"hotelId":hotelId,
			"userId":userId
		},
		success:function(resault){
			if(resault){
				console.log("新增成功");
			}else{
				console.log("出錯了");
			}
		},
		error:function(err){
			console.log(err);
		}
	})
})

$(document).on('click','.removefavorite',function(){
	$(this).attr('class','fa-solid fa-heart addfavorite')
	let hotelId = this.id;
	let userId = document.getElementById('userId').value
	$.ajax({
		url:"http://localhost:8081/booking/removefavorite",
		contentType:"application/x-www-form-urlencoded; charset=UTF-8",
		dataType:"json",
		method:"get",
		data:{
			"hotelId":hotelId,
			"userId":userId
		},
		success:function(resault){
			if(resault){
				console.log("刪除成功");
			}else{
				console.log("出錯了");
			}
		},
		error:function(err){
			console.log(err);
		}
	})
})