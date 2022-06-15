<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<jsp:include page="layout/default.jsp" />
<head>
<meta charset="UTF-8">
<title>我的訂單</title>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
</head>
<link rel="stylesheet" href="${contextRoot}/css/bootstrap.min.css">

<link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">   
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="https://cdn.datatables.net/1.11.3/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.2.9/css/responsive.bootstrap4.min.css">
<link href="https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css"rel="stylesheet">
<link rel="stylesheet" href="${contextRoot}/css/jquery-ui.min.css">
<link rel="stylesheet" href="${contextRoot}/css/myOrderInfoStyle.css">
 
<!------ Include the above in your HEAD tag ---------->
<style>

/* 排序 */
#descSort i{

 font-size:20px

}
#ascSort i{
	
 font-size:20px

}
/* 排序end */

.date-select div{
 
 color: #aaa;
}

.status-check{
 color: #aaa;
}

.user-sideBar div{

	background-color:red; size:10px

}
.user-sideBar #user-photo{

	height:100px;
	width:auto;

}

.table-sidebar {
 border-radius:10px;
 background-color:#fff;
 box-shadow:0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);

}

.right-datatable {

 padding:10px;
 width:100%;
 height:100%;
 border-radius:10px;
 box-shadow:0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);

}


#carouselExampleIndicators {
	border:transparent;
	border-radius:10px;
	overflow:hidden;
	box-shadow:0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	height:350px;
	width:1120px;
	background-color:#fff;
}

#detailModal table td {
	font-size:16px;
	font-weight:500;
}

</style>


<body>
	<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.setDateHeader("Expires", -1);
	%>

<!-- 先註解 -->
<!-- 	<div class="container mr-0"> -->
<!-- 		<div class="d-flex flex-row-reverse"> -->
<!-- 			<div class="p-2"> -->
<%-- 				<a href="sortDesc?userId=${loginCustomer.userId}" id="descSort">依降冪排序 --%>
<!-- 					<i class="uil uil-sort-amount-down"  aria-hidden="true"></i> -->
<!-- 				</a> -->
<!-- 			</div> -->
<!-- 			<div class="p-2"> -->
<%-- 				<a href="sortAsc?userId=${loginCustomer.userId}" id="ascSort">依升冪排序 --%>
<!-- 					<i class="uil uil-sort-amount-up"  aria-hidden="true"></i> -->
<!-- 				</a> -->
<!-- 			</div>		 -->

<!-- 			<form action="dateSelect" class="date-select"> -->
<!-- 				<div class="p-2 mr-3"> -->
<!-- 					搜尋訂單: 起始日<input type="date" name="start_date" value="日期"> -->
<!-- 					結束日 <input type="date" name="end_date" value="日期">  -->
					
<!-- 					<button id="dateSearch" type="submit"><i class="fa fa-search" aria-hidden="true"></i></button> -->
<!-- 				</div> -->
<!-- 			</form> -->
			
<!-- 			<div class="p-2 status-check"> -->
<!-- 				<label for="status">訂單狀態:</label> -->
<!-- 				<select id="booking-status" name="status"> -->
<!-- 					<option selected="selected">請選擇</option> -->
<!-- 					<option value="3">全部</option> -->
<!-- 					<option value="1">已確認</option> -->
<!-- 					<option value="2">未確認</option> -->
<!-- 				</select> -->
<!-- 			</div>	 -->
			
<!-- 		</div> -->
<!-- 	</div> -->



	<div class="container">
	  <div class="row mt-4">
		
<!-- 		<div class="col-2 table-sidebar"> -->
<!-- 			<div class="align-items-start m-2 user-sideBar"> -->
			
<!-- 				<div class="mb-2 align-self-start" id="user-photo"> -->
<!-- 				</div> -->
<!-- 	            <div class="col mb-2 align-self-start" ><h5>我的訂單</h5> -->
<!-- 	            </div> -->
<!-- 	            <div class="col mb-2 align-self-start" >1 -->
<!-- 	            </div> -->
<!-- 	            <div class="col mb-2 align-self-start ">2 -->
<!-- 	            </div> -->
<!-- 	            <div class="col mb-2 align-self-start" >3 -->
<!-- 	            </div> -->
<!-- 	            <div class="col mb-2 align-self-start"  >4 -->
<!-- 	            </div> -->
<!-- 	            <div class="col align-self-start"  >5 -->
<!-- 	            </div> -->
<!-- 			</div> -->
<!-- 		</div> -->
		
	    <div class="col-12">
	      <div class="fresh-table right-datatable">
			<table id="table_id"  class="table table-striped table-bordered dt-responsive nowrap pt-2" style=";border-radius:5px;width:100%;">
			<thead>
				<tr>
					<th data-field="bookingId">No.</th>
					<th data-field="state">狀態</th>
					<th data-field="bookingTimes">訂單時間</th>
					<th data-field="dateOfStay">天數</th>
					<th data-field="bookingName">訂購人</th>
					<th data-field="annotation">備註</th>
					<th data-field="detail">詳細</th>
					<th data-field="comment">選項</th>
					
					
				</tr>
			</thead>

			<tbody>
				<c:forEach var="booking" items="${bookingList}">
					<tr>
						<td id="id">${booking.bookingId}</td>
						<td id="state">${booking.state}</td>
						<td id="times">${booking.bookingTimes}</td>
						<td id="days">${booking.dateOfStay}</td>
						<td id="name">${booking.bookingName}</td>
						<td id="annotation">${booking.annotation}</td>
						<td >
							<a class="detail" href="" data-toggle="modal" data-target="#detailModal" id="detail-modal">詳細訂單</a>
							<input type="hidden" id="bkId-detail" value="${booking.bookingId}">
							<input type="hidden" id="bkname-detail" value="${booking.bookingName}">
							<input type="hidden" id="bkdays-detail" value="${booking.dateOfStay}">
							<input type="hidden" id="bktimes-detail" value="${booking.bookingTimes}">
						</td>
						

					<c:if test="${booking.state =='已確認'}">
						
						<c:if test="${booking.comment.comment == null}">
						<td><a class="comment" data-toggle="modal" data-toggle="tooltip"  data-target="#commentAreaModal" id="commentBtn">
								<i class="fa fa-pencil"aria-hidden="true"></i>
							</a>
							<input type="hidden" id="bkId" value="${booking.bookingId}">
							<input type="hidden" id="bkuserId" value="${sessionScope.loginCustomer.userId}">
						</td>		
			
						</c:if>
						<c:if test="${booking.comment.comment != null}">
							<td></td>
						</c:if>
					</c:if>	    	
					
					<c:if test="${booking.state !='已確認'}">
							<td><a class="cancel" data-toggle="modal" data-target="#delete-comfirm" id="deleteBtn">

								<input type="hidden" id="delete-bkId" value="${booking.bookingId}">
							<i class="fa fa-trash" aria-hidden="true"></i>
							</a></td>
					</c:if>
		
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
	    </div>
	    
	    
	    <div class="col-12 pl-0 ml-2 mt-4 mb-4">
	     	<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
			  <ol class="carousel-indicators">
			    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
			    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
			    <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
			    <li data-target="#carouselExampleIndicators" data-slide-to="3"></li>
			    <li data-target="#carouselExampleIndicators" data-slide-to="4"></li>
			  </ol>
			  <div class="carousel-inner">
			    <div class="carousel-item active">
			      <img class="d-block " src="${contextRoot}/image/carousal/car1.jpg" alt="First slide" style="">
<!-- 				      <div class="carousel-caption d-none d-md-block"> -->
<!-- 					    <h5>First slide</h5> -->
<!-- 					    <p>casimag</p> -->
<!-- 					  </div> -->
			    </div>
			    <div class="carousel-item">
			      <img class="d-block " src="${contextRoot}/image/carousal/car2.jpg" alt="Second slide" style="object-fit: cover;">
<!-- 			      <div class="carousel-caption d-none d-md-block"> -->
<!-- 				    <h5>Second slide</h5> -->
<!-- 				    <p>casimag</p> -->
<!-- 				  </div> -->
			    </div>
			    <div class="carousel-item">
			      <img class="d-block " src="${contextRoot}/image/carousal/car3.jpg" alt="Third slide" style="object-fit: cover;">
<!-- 			      <div class="carousel-caption d-none d-md-block"> -->
<!-- 				    <h5>Third slide</h5> -->
<!-- 				    <p>casimag</p> -->
<!-- 				  </div> -->
			    </div>
			    <div class="carousel-item">
			      <img class="d-block " src="${contextRoot}/image/carousal/car4.jpg" alt="fourth slide" style="object-fit: cover;">
<!-- 			      <div class="carousel-caption d-none d-md-block"> -->
<!-- 				    <h5>Third slide</h5> -->
<!-- 				    <p>casimag</p> -->
<!-- 				  </div> -->
			    </div>
			    <div class="carousel-item">
			      <img class="d-block " src="${contextRoot}/image/carousal/car6.jpg" alt="fifth slide" style="object-fit: cover;">
<!-- 			      <div class="carousel-caption d-none d-md-block"> -->
<!-- 				    <h5>Third slide</h5> -->
<!-- 				    <p>casimag</p> -->
<!-- 				  </div> -->
			    </div>
			  </div>
			  <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev" >
			    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
			    <span class="sr-only">Previous</span>
			  </a>
			  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next" >
			    <span class="carousel-control-next-icon" aria-hidden="true"></span>
			    <span class="sr-only">Next</span>
			  </a>
			</div>
	    </div>
	  </div>
	</div>
	
	
	<!-- Modal 詳細訂單-->

		<!-- Button trigger modal -->

	
	<!-- Modal -->
	<div class="modal fade" id="detailModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class=" modal-dialog modal-dialog-scrollable">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel"><i class="fa fa-envelope-o" aria-hidden="true"></i>&nbsp詳細訂單</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <div class="form-group">
           		<table class="col-form-label" id="bkInfo" style="width:100%;padding:20px" cellpadding="10px"; cellspacing="1px">
				  
				  <tr>
				    <th>旅宿名稱:</th>
				    <td><span class="info ml-4" id="detail-hotelName">1</span></td>
				  </tr>
				  
				  <tr>
				    <th>聯絡旅宿:</th>
				    <td><span class="info ml-4" id="detail-hotelTel">2</span></td>
				  </tr>
				  
				  <tr>
				    <th>訂單時間:</th>
				    <td><span class="info ml-4" id="detail-times">3</span></td>
				  </tr>
				  <tr>
				  
				    <th>訂購人:</th>
				    <td><span class="info ml-4" id="detail-name">4</span>&nbsp 先生/小姐</td>
				  </tr>
				  <tr>
				    <th>天數:</th>
				    <td><span class="info ml-4" id="detail-days">5</span>&nbsp 晚</td>
				  </tr>
				  <tr>
				    <th>飯店地址:</th>
				    <td><span class="info ml-4" id="detail-address">6</span></td>
				  </tr>
				  <tr>
				    <th>訂單價格:</th>
				    <td><span class="info ml-4" id="detail-lowPrice">7</span>&nbsp 元</td>
				  </tr>
				</table>
		    </div>  
	      </div>
	      <div class="modal-footer">
 			<button type="button" class="btn btn-warning" data-dismiss="modal">關閉</button>	        
	      </div>
	    </div>
	  </div>
	</div>
		
	
	<!-- Modal -->
	

<!-- Modal 評論視窗 -->
<!-- Modal -->
 <form action="${contextRoot}/addComment" method="post">
<div class="modal fade" id="commentAreaModal" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-scrollable">
    <div class="modal-content">
     
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel"><i class="fa fa-pencil-square-o" aria-hidden="true"></i> 填寫評論</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
    
            <div class="form-group">
            	<label for="message-text" class="col-form-label" ><i class="fa fa-commenting-o" aria-hidden="true"></i> 評論內容 :</label>
            	<textarea  rows="6" cols="50" class="form-control" id="comment" placeholder="請輸入不超過50字" 
            	 maxlength="50" name="comment" id="comment"></textarea>
            </div>
            	
            <div class="form-group">
            	<div class="slidecontainer">
			     <label for="message-text" class="col-form-label" >評分:</label>
			      <input class="slider" type="range" min="0" max="10.0" value="5.0" step="0.1"
			       id="myRange" name="myRange">
			      <p>您的評分: <span id="demo"></span></p>
			    </div>
            </div>
            
            <div class="form-group">
            	 <input type="hidden" name="bookingId" id="bookingId">
            </div>	
            <div class="form-group">
            	<input type="hidden" name="userId" id="userId">
            </div>	
            <div class="form-group">
            	 <input type="hidden" name="hotelId" id="hotelId">
            </div>	
            <div class="form-group">
            	 <input type="hidden" name="roomId" id="roomId">
            </div>	
          </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-outline-warning" data-dismiss="modal">取消</button>
	        <button type="submit" class="btn btn-warning">送出</button>
	      </div>
	  </div>
	</div>
  </div>
</form>

<!-- Modal 刪除確認 -->
<div class="modal fade" id="delete-comfirm" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">刪除訂單</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <span>確認刪除本筆訂單?</span>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
        <button type="button" class="btn btn-primary" data-dismiss="modal" id="delete-complete">確認</button>
      </div>
    </div>
  </div>
</div>

<!-- footer star-->
<jsp:include page="layout/footer.jsp" />
<!-- footer end-->
	<!-- Javascript -->



<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.js"></script>
<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="https://cdn.datatables.net/1.11.3/js/dataTables.bootstrap4.min.js"></script>
<script src="${contextRoot}/js/jquery-ui.min.js"></script>
<script src="https://kit.fontawesome.com/ca70cd7f9d.js" crossorigin="anonymous"></script>
<script src="https://cdn.datatables.net/responsive/2.2.9/js/dataTables.responsive.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.2.9/js/responsive.bootstrap4.min.js"></script>

<script type="text/javascript">




$(document).ready(function(){
	
	var userId = '${sessionScope.loginCustomer.userId}';
	//Range slider
	var slider = document.getElementById("myRange");
	var output = document.getElementById("demo");
	output.innerHTML = slider.value;

	slider.oninput = function() {
  	output.innerHTML = this.value;
  	
	}
	

	
	 $('#delete-complete').click(function(){
		 let bookingId=$('table #delete-bkId').parent().find('#delete-bkId').val();
		 let userId = '${sessionScope.loginCustomer.userId}';
		 
// 		 alert(userId) 
// 		 alert(bookingId) 
		 
		 $.ajax({
			url:"${contextRoot}/delBooking",
			contentType:"application/json; charset-utf8;",
            method:"get",
            dataType:"text",
            data:{
             	"bookingId":bookingId,
             	"userId":userId
             },
             success:function(success){
				
 				$('#deleteBtn').closest('tr').remove();
//             	 alert('成功刪除');
            	 
             },
             error:function(err){
            	 alert(xhr.status);
             	console.log(err);
					alert('錯誤')
             }
			})
			
		});

	 
	 
	//給評論
	 $('table .comment').on('click',function(){
		 let id=$(this).parent().find('#bkId').val();  //拿訂單Id
		 
		 $.ajax({
			type:'GET',
			url:'${contextRoot}/find/' + id,
			contentType:"application/x-www-form-urlencoded; charset=UTF-8",
            success:function(booking){
            	
            	$('#commentAreaModal #bookingId').val(booking.bookingId);
            	$('#commentAreaModal #userId').val(booking.userId);
            	$('#commentAreaModal #hotelId').val(booking.hotelId);
            	$('#commentAreaModal #roomId').val(booking.roomId);
            	$('#commentAreaModal #comment').val('');
            	$('#commentAreaModal #bookDate').html('訂單日期: '+ booking.bookingTimes);
            	
            },
            error:function(err){
            	console.log(err);
				alert('錯誤')
            }
	 	})
	 	 
	});
	
	
	
	//達詳細訂單
	
		$('table #detail-modal').on('click',function(){
		 let bookingId=$(this).parent().find('#bkId-detail').val();
		 let name=$(this).parent().find('#bkname-detail').val();  //拿人數Id
		 let days=$(this).parent().find('#bkdays-detail').val();  //拿天數Id
		 let times=$(this).parent().find('#bktimes-detail').val();  //拿時間Id
		 days = days.split(',').length-1
// 		 alert(bookingId);
			console.log(days)
		 $.ajax({
			method:'GET',
			url:'${contextRoot}/findOrderDetail',
			contentType:"application/x-www-form-urlencoded; charset=UTF-8",
			data:{
				"bookingId":bookingId,
			},
            success:function(room){
            	console.log(room);
            	
            	let hotelId = room.hotelId;
            	let price = room.price;
            	let roomName = room.roomName;
            	//第二層Ajax
            	
            	$.ajax({
					method:'GET',
					url:'${contextRoot}/findOrderDetailByHotelId',
					contentType:"application/x-www-form-urlencoded; charset=UTF-8",
					data:{
						"hotelId":hotelId,
					},
		            success:function(hotel){
		            	console.log(hotel);
		            	
		             	$('#detailModal #detail-hotelName').html(hotel.hotelName);
		             	$('#detailModal #detail-address').html(hotel.add);
		             	$('#detailModal #detail-tel').html(hotel.Tel);
		             	$('#detailModal #detail-times').html(times);
		             	$('#detailModal #detail-days').html(days);
		             	$('#detailModal #detail-name').html(name);
		             	$('#detailModal #detail-lowPrice').html(price*days);
		             	$('#detailModal #detail-hotelTel').html(hotel.tel);

		            },
		            error:function(err){
		            	console.log(err);
						alert('錯誤')
		            }
			 	})

            },
            error:function(err){
            	console.log(err);
				alert('錯誤')
            }
	 	})
		
		
	})
	 
	
// 	 $('#booking-status').on('change', function() {
// 		 let status = $(this).val();
// 		 let userId = '${sessionScope.loginCustomer.userId}';
		
// 		 alert(userId);
// 		 alert(status);
		 
		 
// 		 $.ajax({
// 				url:"${contextRoot}/bookingCheck",
// 				contentType:"application/x-www-form-urlencoded; charset=UTF-8",
// 				dataType:"json",
//             	method:"get",
// 				data:{
// 					"userId":userId,
// 					"status":status,
// 				},
// 				success:function(bookingList){
// 						alert('正確') //待處理
//             	},
//              	error:function(err){
//                  	console.log(err);
// 					alert('錯誤')
//              	}
// 			})
		 

// 		});
	 
	 
	
	
	 $( "#table_id" ).DataTable({
			
	  		// 參數設定[註1]
	  		"lengthMenu": [3, 5, 10],
	  		 "pageLength":'5',
	  		// 'responsive': true, //預設為undefined
	  		 //設定欄位元素定義區塊
	  		"columnDefs":[ 
	  			{
					targets:[0],
					responsivePriority: 0,
	  	         	'createdCell': function (td, cell, cellData, rowData, rowIndex, colIndex) { //操作dom元素
	  	        	$(td).css({'font-size':'14px', 'width':'1%'}) //可寫其他設定
		  	         }
	  				
	  			},
	  			{
					targets:[1],
					responsivePriority: 1,
	  	         	'createdCell': function (td, cell, cellData, rowData, rowIndex, colIndex) { //操作dom元素
	  	        	$(td).css({'color':'blue','font-size':'14px', 'width':'1%'}) //可寫其他設定
		  	         }
	  			},
	  			{
					targets:[2],
					responsivePriority: 2,
	  	         	'createdCell': function (td, cell, cellData, rowData, rowIndex, colIndex) { //操作dom元素
	  	        	$(td).css({'font-size':'14px', 'width':'1%'}) //可寫其他設定
		  	         }
	  			},
	  			{
					targets:[3],
					responsivePriority: 3,
	  	         	'createdCell': function (td, cell, cellData, rowData, rowIndex, colIndex) { //操作dom元素
	  	        	$(td).css({'font-size':'14px', 'width':'1%'}) //可寫其他設定
		  	         }
	  			},
	  			{
					targets:[4],
					responsivePriority: 4,
	  	         	'createdCell': function (td, cell, cellData, rowData, rowIndex, colIndex) { //操作dom元素
	  	        	$(td).css({'font-size':'14px', 'width':'1%'}) //可寫其他設定
		  	         }
	  			},
	  			{
					targets:[5],
					responsivePriority: 6,
	  	         	'createdCell': function (td, cell, cellData, rowData, rowIndex, colIndex) { //操作dom元素
	  	        	$(td).css({'font-size':'14px', 'width':'1%'}) //可寫其他設定
		  	         }
	  			},
	  			{
					targets:[6],
	  	         	'createdCell': function (td, cell, cellData, rowData, rowIndex, colIndex) { //操作dom元素
	  	        	$(td).css({'font-size':'14px', 'width':'1%'}) //可寫其他設定
		  	         }
	  			
	  			},
	  			{
					targets:[7],
					responsivePriority: 0,
	  	         	'createdCell': function (td, cell, cellData, rowData, rowIndex, colIndex) { //操作dom元素
	  	        	$(td).css({'font-size':'18px', 'width':'1%'}) //可寫其他設定
		  	         }
	  			}

	  			
	  	    ],

	  		language: {
	  			url:'https://cdn.datatables.net/plug-ins/1.11.3/i18n/zh_Hant.json'
	  		}
	  		
	  	});
	
})

</script>	

	

</body>
</html>