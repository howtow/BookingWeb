//載入首頁飯店資訊
	$(document).ready(function() {
		let userId = document.getElementById('userId').value
		$.ajax({
			url:'http://localhost:8081/booking/exhibit',
			contentType:"application/x-www-form-urlencoded",
			dataType:'json',
			method:'get',
			success:function(resault){
				var hotel = ''
				$.each(resault,function(index,value){
					var imgArr = value.pics.split(',')
					hotel += '<div class="col-lg-3 col-sm-6">'
					hotel += '<div class="accomodation_item text-center">'
					hotel += '<div class="hotel_img">'
					hotel += '<img src="'+imgArr[0]+'" alt="" class="indexHotelImg" style="height: 352px;">'
					hotel += '<a href="hotelDetail?id='+value.hotelId+'&userId='+userId+'" class="btn theme_btn button_hover">馬上預訂</a>'
					hotel += '</div>'
					hotel += '<a href="hotelDetail?id='+value.hotelId+'&userId='+userId+'">'
					hotel += '<h4 class="sec_h4">'+value.hotelName+'</h4>'
					hotel += '</a>'
					hotel += '<h6>'+value.region+value.town+'</h6>'
					hotel += '<h5>'
					hotel += '$'+value.lowestPrice+'<small>/晚起</small>'
					hotel += '</h5>'
					hotel += '</div>'
					hotel += '</div>'
				})
				$('#exhibit').append(hotel)
			},
			error:function(err){
				console.log(err);
				alert('發生錯誤')
			}
		})

		//勾選出差顯示提示
		$('#business').click(function() {
			var check = document.getElementById('business');
			if (check.checked == true) {
				$('#note').append('<span id="show" style="font-size: 10px; color:#F3C300;">(優先搜尋附早餐/停車/網路)</span>')
			} else{
				$('#show').remove()
			}
		})
	})

	//載入input列表
	$(document).ready(function() {
		var locationList = [];
		$.ajax({
			url : "http://localhost:8081/booking/locationList",
			contentType : "application/x-www-form-urlencoded",
			dataType : 'json',
			method : 'get',
			success : function(resault) {
				$('#go_input').autocomplete({
					source : resault
				})
			},
			error : function(err) {
				console.log(err);
				alert('發生錯誤')
			}
		})
	})