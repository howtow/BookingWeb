let roomimg = document.querySelectorAll(".roomimg")
let close2 = document.querySelector("#closeImg");
$.each(roomimg,function(index,value){
	value.addEventListener("click", function(){
        let roomId = $(this).attr('id')
        $.ajax({
            url:"http://localhost:8081/booking/getRoomimg",
            contentType:"application/x-www-form-urlencoded; charset=UTF-8",
            dataType:"json",
            method:"get",
            data:{
                "roomId":roomId
            },
            success:function(resault){
                $.each(resault,function(index,value){
                    $('#showRoomimg').append('<span class="imgs"><img style="margin: 5px; height:200px;"" src="http://localhost:8081/booking/downloadRoomImage?imgid='+value.roomImgId+'"></span>')
                })
            },
            error:function(err){
                console.log(err);
            }
        })
		roomimgDialog.showModal();
	})
})
close2.addEventListener("click", function(){
    $('.imgs').remove();
	roomimgDialog.close();
})