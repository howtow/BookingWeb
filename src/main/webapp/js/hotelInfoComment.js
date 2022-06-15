function appendCommentString(result){
            let returnRS = '';
            $('#commentList').remove();
            $('#pageBtn').remove();
            returnRS += '<div id="commentList">'
            $.each(result.content,function(index,comment){
                returnRS += '<div style="display:flex; border-top:1px solid rgb(189, 189, 189); padding: 10px;">'
                returnRS += '<div style="padding: 20px 0px; flex: 3;">'                
                returnRS += '<div style="display: flex; align-items: center;">'
                returnRS += '<div style="border-radius: 100%; overflow: hidden; width: 50px; height: 50px; display: flex; align-items: center;"><img style="width: 50px;" src="http://localhost:8081/booking/downloadAvatar/'+comment.customer.userId+'"></div>'
                returnRS += '<div style="margin-left: 10px;">'
                returnRS += '<div style="display: flex; align-items: center;">'
                returnRS += '<i class="fa-regular fa-user" style="color: rgb(29, 79, 149); margin-top: 5px;"></i>'
                returnRS += '<div style="margin-left: 5px;">'+comment.customer.userName+'</div>'
                returnRS += '</div>'
                returnRS += '<div style="display: flex; align-items: center;">'   
                returnRS += '<i class="fa-solid fa-earth-americas" style="color: rgb(29, 79, 149);"></i>'  
                returnRS += '<div style="margin-left: 5px;">'+comment.customer.nationality+'</div></div>'  
                returnRS += '</div>'  
                returnRS += '</div>'  
                returnRS += '<div style="display: flex; align-items: center; color: #575757;">'
                returnRS += '<i class="fa-solid fa-bed"></i>'
                returnRS += '<div style="margin-left: 10px;">'+comment.room.roomName+'</div>'
                returnRS += '</div>'
                returnRS += '<div style="display: flex; align-items: center; color: #585858;">'
                var day = comment.booking.dateOfStay.split(',');
                returnRS += '<i class="fa-regular fa-calendar-check"></i>'
                returnRS += '<div style="margin-left: 16px;">'+day.length+'晚-'+day[0]+'</div>'  
                returnRS += '</div>'                     
                returnRS += '</div>'
                returnRS += '<div style="border-left: 1px solid rgb(209, 209, 209); padding: 20px; width: 100%; flex: 7;">'
                returnRS += '<div style="display: flex; justify-content: space-between;">'  
                let date = new Date(comment.commentTime)
                let formatdate = date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate()
                returnRS += '<span>評論時間'+formatdate+'</span>'
                returnRS += '<span style="color:white; background-color:rgb(22, 22, 88) ; font-size: 20px; height: 35px; width: 35px;padding: 5px; border-radius: 5px 5px 5px 0px; display: flex; align-items: center; ">'+comment.rating+'</span>'
                returnRS += '</div>'
                returnRS += '<div>'+comment.comment+'</div>'
                returnRS += '</div>'
                returnRS += '</div>'
            })
            return returnRS;
        }

		//點擊載入Page
		$(document).ready(function(){
			$('.showComment').click(function(){
                let hotelId = document.getElementById('hotelId').value;
                let page = 1;
                $.ajax({
                    url:"http://localhost:8081/booking/getCommentPage",
					contentType:"application/x-www-form-urlencoded; charset=UTF-8",
					dataType:"json",
					method:"get",
					data:{
						"hotelId":hotelId,
                        "page":page
                    },
                    success:function(result){
                        let returnRS = appendCommentString(result);
                        returnRS += '<input type="hidden" value="desc" id="order">'
                        returnRS += '<input type="hidden" value="rating" id="orderBy" />'
                        returnRS += '</div>'
                        //換頁按鈕
                        let pageBtn = '';
                        pageBtn += '<div id="pageBtn">'
                        for(let i=1; i<=result.totalPages;i++){
                            if(result.number != i-1){
                                pageBtn += '<button type="button" class="pageBtn" value="'+i+'">'+i+'</button>'
                            }else{
                                pageBtn += '<button type="button" disabled="disabled">'+i+'</button>'
                            }
                        }
                        pageBtn += '</div>'
                        $('#commentBody').append(returnRS);
                        $('#commentPage').append(pageBtn)
                    },
                    error:function(err){
                        console.log(err);
						alert('發生錯誤')
                    }
                })
            })
		})
		
		//點擊換頁鈕
		//直接綁標籤，不可用.ready或是onload不然ajax刷新會沒辦法附上事件
		$(document).on('click','.pageBtn',function(){
			let page = $(this).attr('value');
			let hotelId = document.getElementById('hotelId').value;
			let order = document.getElementById('order').value;
			let orderBy = document.getElementById('orderBy').value;
			$.ajax({
                url:"http://localhost:8081/booking/getCommentPage",
                contentType:"application/x-www-form-urlencoded; charset=UTF-8",
                dataType:"json",
                method:"get",
                data:{
                    "hotelId":hotelId,
                    "page":page,
                    "order":order,
                    "orderBy":orderBy
                },
                success:function(result){
                    let returnRS = appendCommentString(result);
                    returnRS += '<input type="hidden" value="desc" id="order">'
                    returnRS += '<input type="hidden" value="rating" id="orderBy" />'
                    returnRS += '</div>'
                    //換頁按鈕
                    let pageBtn = '';
                    pageBtn += '<div id="pageBtn">'
                    for(let i=1; i<=result.totalPages;i++){
                        if(result.number != i-1){
                            pageBtn += '<button type="button" class="pageBtn" value="'+i+'">'+i+'</button>'
                        }else{
                            pageBtn += '<button type="button" disabled="disabled">'+i+'</button>'
                        }
                    }
                    pageBtn += '</div>'
                    $('#commentBody').append(returnRS);
                    $('#commentPage').append(pageBtn)
                },
                error:function(err){
                    console.log(err);
                    alert('發生錯誤')
                }
            })
		})
		
		//評論點擊展開
        let btn1 = document.querySelectorAll(".showComment");
		let close1 = document.querySelector("#closeComment");
		$.each(btn1,function(index,value){
			value.addEventListener("click", function(){
				infoComment.showModal();
			})
		})
		close1.addEventListener("click", function(){
			infoComment.close();
		})
		
        //評論排序
        $(document).ready(function(){
            $('#orderSelect').change(function(){
                let page = 1;
                let hotelId = document.getElementById('hotelId').value;
                let order = '';
                let orderBy = '';
                let select = document.getElementById('orderSelect').value;
                if(select=='orderByRatingDesc'){
                    order = 'desc';
                    orderBy = 'rating';
                }
                if(select=='orderByRatingAsc'){
                    order = 'asc';
                    orderBy = 'rating';
                }
                if(select=='orderBytimeDesc'){
                    order = 'desc';
                    orderBy = 'commentTime';
                }
                if(select=='orderBytimeAsc'){
                    order = 'asc';
                    orderBy = 'commentTime';
                }
                $.ajax({
                    url:"http://localhost:8081/booking/getCommentPage",
                    contentType:"application/x-www-form-urlencoded; charset=UTF-8",
                    dataType:"json",
                    method:"get",
                    data:{
                        "hotelId":hotelId,
                        "page":page,
                        "order":order,
                        "orderBy":orderBy
                    },
                    success:function(result){
                        let returnRS = appendCommentString(result);
                        returnRS += '<input type="hidden" value="'+order+'" id="order">'
                        returnRS += '<input type="hidden" value="'+orderBy+'" id="orderBy" />'
                        returnRS += '</div>'
                        //換頁按鈕
                        let pageBtn = '';
                        pageBtn += '<div id="pageBtn">'
                        for(let i=1; i<=result.totalPages;i++){
                            if(result.number != i-1){
                                pageBtn += '<button type="button" class="pageBtn" value="'+i+'">'+i+'</button>'
                            }else{
                                pageBtn += '<button type="button" disabled="disabled">'+i+'</button>'
                            }
                        }
                        pageBtn += '</div>'
                        $('#commentBody').append(returnRS);
                        $('#commentPage').append(pageBtn)
                    },
                    error:function(err){
                        console.log(err);
                        alert('發生錯誤')
                    }
                })
            })
        })