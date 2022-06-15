$(document).ready(function(){
            //整理分數
            var averageRating = document.getElementById('averageRating').value
            if(averageRating>=9.5){
                $('.rate').append('<span style="font-size: 20px; margin-right:5px;">傑出</span>')
            }else if(averageRating>=9.0){
                $('.rate').append('<span style="font-size: 20px; margin-right:5px;">好極了</span>')
            }else if(averageRating>=8.0){
                $('.rate').append('<span style="font-size: 20px; margin-right:5px;">很好</span>')
            }else if(averageRating>=7.0){
                $('.rate').append('<span style="font-size: 20px; margin-right:5px;">好</span>')
            }else{
                $('.rate').append('<span style="font-size: 20px; margin-right:5px;">評分</span>')
            }
            
            //按鈕icon控制
            let closeicon = document.querySelectorAll('.closeicon');
            $.each(closeicon,function(index,value){
                value.addEventListener("mouseenter",function(){
                    $(this).attr("class","fa-regular fa-rectangle-xmark")
                    $(this).attr("id","closeicon2")
                })
            })
            $(document).on('mouseleave','#closeicon2',function(){
                $(this).attr("class","fa-solid fa-rectangle-xmark closeicon")
                $(this).attr("id","")
            })
            
            //勾選出差顯示提示
            var checkBusiness = document.querySelectorAll(".business");
            $.each(checkBusiness,function(index,value){
            	value.addEventListener("click", function(){
            		if(value.checked==true){
            			checkBusiness[0].checked=true
            			checkBusiness[1].checked=true
	                    $('.note').html('<span class="show" style="font-size: 10px; color:red;">(優先搜尋附早餐/停車/網路)</span>')
	                }else{
	                	checkBusiness[0].checked=false
            			checkBusiness[1].checked=false
	                    $('.note').html('<span class="show"><br></span>')
	                }
    			})
            })

            //標籤顯示整理
            var showtags = '';
            var tags = document.getElementById('serviceinfo').value.split(',');
            showtags += '<div>'
            $.each(tags,function(index,value){
                if(value != ''){
                    showtags += ('<span style="background-color: #0071c2; color: #ffffff; padding:3px; margin-right:2px; border-radius: 3px;">'+value+'</span>')
                }
            })
            showtags += '</div>'
            $('#tag').append(showtags)

            //點擊時螢幕滑動
            $('#goDescription').click(function(){
                $('html,body').animate({
                    scrollTop: $('#description').offset().top-100},
                    100
                );
            })
            $('#goRoom').click(function(){
                $('html,body').animate({
                    scrollTop: $('#roomList').offset().top-100},
                    100
                );
            })
            $('#goComment').click(function(){
                $('html,body').animate({
                    scrollTop: $('#comment').offset().top-100},
                    100
                );
            })
            $('#goNotice').click(function(){
                $('html,body').animate({
                    scrollTop: $('#notice').offset().top-100},
                    100
                );
            })

            //統計訂房資料
            $('.selectNum').change(function(){
                $('#totalCount').remove()
            	let num = 0;
                let price = 0;
                let select = document.querySelectorAll(".selectNum");
                let roomPrice = document.querySelectorAll(".roomPrice");
                let between = document.getElementById('between').value
                $.each(select,function(index,value){
                    num += parseInt(value.value)//房間數
                    price += parseInt(value.value) * parseInt(roomPrice[index].value) * parseInt(between)//房間數*房價*天數
                })
                if(num!=0){
                    let returnRs = '<div id="totalCount">'                
                    returnRs += '<div style="font-size: 10px;">'+num+'間客房價格為:</div>'
                    returnRs += '<div><span style="text-decoration: line-through; font-size: 10px; color: red; ">TWD'+price+'</span><span>TWD'+(price*0.95)+'</span></div>'
                    returnRs += '<div style="font-size: 10px; color:gray;">含稅費與其他費用</div>'
                    returnRs += '</div>'
                    $('#selectInfo').append(returnRs);
                	$('#bookingNote').remove();
                	document.getElementById('bookingBtn').disabled=false
                    document.getElementById('bookingBtn').style.backgroundColor='';
                    document.getElementById('bookingBtn').className='submit';
                    
                }else{
                    $('#bookingMessage').append('<div style="color:red; font-size:12px;" id="bookingNote">您須至少預定一項</div>');
                	document.getElementById('bookingBtn').disabled=true
                	document.getElementById('bookingBtn').style.backgroundColor='rgba(116, 116, 116, 0.788)';
                }
            })
        })