<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html>
<jsp:include page="layout/default.jsp" />

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!--=====Inconscout CSS-->
<link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">   
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href="https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css"rel="stylesheet">
<link rel="stylesheet" href="${contextRoot}/css/jquery-ui.min.css">
<link rel="stylesheet" href="${contextRoot}/css/responsive.css">
<link rel="stylesheet" href="${contextRoot}/css/navBar.css">
</head>

<style>


.info img{
	
	height:160px;
	width:160px;
	object-fit:cover;
	box-shadow:0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);

}


p {
	color:black;
	font-size:30px;
}

.formEdit{
	
	padding:10px;
	border-radius:10px;
	box-shadow:0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);

}

.form-space{
	margin:5px;
}

.formEdit h4{
	
	font-size:16px;
	
}

.setting{
  
  width:100%;
  position: relative;
  padding: 11px 16px;
  margin-top:2px;
  font-size: 16px;
  line-height: 1.5;
  color: #777777;
  background-color: #fff;
  border: 0;
  transition: 0.5s;
  overflow: hidden; \\ L
}

.setting input[type = "file"]{
  cursor: pointer;
  position: absolute;
  left: 0%;
  top: 0%;
  transform: scale(3);
  opacity: 0;
}

.setting:hover{
  background-color: #0a3453;
  color:#fff;
}
.setting:hover i{
	color:#fff;
}



</style>

<body>

	<c:if test="${loginCustomer == null}">
		<c:redirect url="customerlogin"></c:redirect>
	</c:if>

	<div class="container bootstrap snippet mt-5 mb-5">
		
		<form action="editSave" method="post" enctype="multipart/form-data" class="form">
			<div class="row">
						<div class="col-lg-3 p-3" id="info-form" style="border-radius:10px;box-shadow:0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
<!-- 							mt-3 mb-3 p-3 -->
							<div>
								<div class="text-center info">
									<div class="showAvatar">
										<c:if test="${cusInfomation.photo == null}">
											<div id="showAvatar">
											<img src="http://ssl.gstatic.com/accounts/ui/avatar_2x.png"
												class="rounded-circle z-depth-2 avatar" alt="100x100">
											</div>
										</c:if>
										<c:if test="${cusInfomation.photo != null}">
											<div id="showAvatar">
											<img src="${contextRoot}/downloadAvatar/${cusInfomation.userId}"class="rounded-circle shadow-4 avatar"
	  										 alt="Avatar">
	  										 </div>
										</c:if>
									</div>
									
									
<!-- 									<input type="file" class="text-center center-block file-upload " id="photo"> -->
									 
								</div>
									
								<p class="text-center"style="font-size:16px;font-weight:600;margin-top:20px">${cusInfomation.userName} 的個人資訊</p>
								<hr>
								
								<div class="panel panel-default">
									<div class="panel-heading" style="font-size:16px;font-weight:600;color:#777777">
										設定 <i class="fa fa-link fa-1x"></i>
									</div>
<!-- 									<div class="panel-body"> -->
<!-- 										<i class="fa fa-unlock-alt" aria-hidden="true"></i> -->
<!-- 										<a href="#" data-toggle="modal" data-target="#myModal" id="change-password">變更密碼</a> -->
<!-- 									</div> -->
									
									<button class="setting" type = "button"  data-toggle="modal" data-target="#myModal" id="change-password">
									       <i class="fa fa-unlock-alt" aria-hidden="true"></i> 變更密碼
									        
									 </button>
									<button type = "button" class = "setting" id="uploadAvatar">
									        <i class = "fa fa-upload" aria-hidden="true"></i> 變更頭貼
									        <input type="file"class="text-center center-block file-upload" multiple="multiple" accept="image/*, .jpeg, .png, .gif, .jpeg" id="photo">
									 </button>
								</div>

							
							</div>
						</div>
						
						<div class="form-space"></div>
<!-- 						m-3 p-3 -->
						<div class="col-lg-8 formEdit">
							<div class="tab-content">
								<div class="tab-pane active" id="home">
									<div class="form-group row">
										<div class="col-6">
											<label for="first_name">
												<h4>電子郵件</h4>
											</label><input type="email" class="form-control" name="email"
												id="Email" placeholder="you@email.com" title="請輸入電子郵件"
												value="${cusInfomation.email}" autocomplete="off" >
										</div>
										<div class="col-6">
											<label for="email">
												<h4>姓名</h4>
											</label> <input type="text" class="form-control" name="userName"
												id="userName" placeholder="姓名" title="請輸入姓名"
												value="${cusInfomation.userName}" autocomplete="off" >
										</div>
									</div>
		

									<div class="form-group row">
		
										<div class="col-6">
											<label for="phone">
												<h4>電話</h4>
											</label> <input type="text" class="form-control" name="phone"
												id="phone" placeholder="電話" title="請輸入電話號碼"
												value="${cusInfomation.phone}" autocomplete="off" >
										</div>
										<div class="col-6">
											<label for="birthday">
												<h4>生日</h4>
											</label> <input type="text" class="form-control" id="datepicker"
												placeholder="生日" name="birthday" title="請輸入生日"
												value="${cusInfomation.birthday}" autocomplete="off" >
		
										</div>
									</div>
		
		
									<div class="form-group row">
		
										<div class="col-6">
											<label for="nationality">
												<h4>國籍</h4>
											</label> <input type="text" class="form-control" id="nationality"
												name="nationality" placeholder="國籍" title="請輸入國籍"
												value="${cusInfomation.nationality}" autocomplete="off" >
										</div>
										<div class="col-6">
											<label for="gender">
												<h4>性別</h4>
											</label> <input type="text" class="form-control" name="gender"
												id="gender" placeholder="性別" title="請輸入性別"
												value="${cusInfomation.gender}" autocomplete="off" >
										</div>
									</div>
		
		
									<div class="form-group row">
		
										<div class="col-6">
											<label for="address">
												<h4>地址</h4>
											</label> <input type="text" class="form-control" name="address"
												id="address" placeholder="地址" title="請輸入性別"
												value="${cusInfomation.address}" autocomplete="off" >
										</div>
										<div class="col-6">
											<label for="state">
												<h4>城市</h4>
											</label> <input type="text" class="form-control" name="state"
												id="state" placeholder="城市" title="請輸入城市"
												value="${cusInfomation.state}" autocomplete="off" >
										</div>
									</div>
		
		
									<div class="form-group row">
		
										<div class="col-6">
											<label for="creditCard">
												<h4>信用卡帳號</h4>
											</label> <input type="text" class="form-control" name="creditCard"
												id="creditCard" placeholder="----/----/----/----" title="請輸入城市"
												value="${cusInfomation.creditCard}" autocomplete="off" >
										</div>
										<div class="col-6">
											<input type="hidden" class="form-control" name="userId"
												value="${cusInfomation.userId}">
										</div>
									</div>
									
									<div class="d-flex flex-row-reverse">
										<div class="p-2">
												<button class="savebtn btn btn-lg btn btn-warning"
													type="submit">
													<i class='bx bx-save'></i> Save
												</button>
										</div>
										
										<div class="p-2">
												<button class="resetBtn btn btn-lg btn btn-light" type="reset">
													<i class='bx bx-reset'></i> Reset
												</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
				<!--form end-->
		
				
				</div>
				<!--container end-->
<!-- 						      The Modal -->
					      <div class="modal fade" id="myModal">
					        <div class="modal-dialog modal-dialog-centered">
					          <div class="modal-content">
					          
					          <form>
<!-- 					            Modal Header -->
					            <div class="modal-header">
					              <h4 class="modal-title">確認會員</h4>
					              <button type="button" class="close" data-dismiss="modal">&times;</button>
					            </div>
					            
<!-- 					            Modal body -->
					            <div class="modal-body">
					             <label for="recipient-name" class="col-form-label">請輸入您的註冊密碼(並點擊空白處):</label>
	            				<input type="password" class="form-control" id="originPwd" name="password">
	            				<input type="hidden" class="form-control" name="userId" id="checkCusId" value="${cusInfomation.userId}">
	            				<span id="checkpwd"></span>
	            				
					            </div>
	            				
	            			
					            
<!-- 					            Modal footer -->
					            <div class="modal-footer" id="footer1">
					              <button type="button" class="btn btn-light" data-dismiss="modal">取消</button>
					            
					            </div>
					            </form>
					          </div>
					        </div>
					      </div>
					      
					      <form action="" id="upadtePwd">
					      <div class="modal fade" id="myModal2">
					        <div class="modal-dialog modal-dialog-centered">
					          <div class="modal-content">
					          
<!-- 					            Modal Header -->
					            <div class="modal-header">
					              <h4 class="modal-title">變更密碼</h4>
					              <button type="button" class="close" data-dismiss="modal">&times;</button>
					            </div>
					            
<!-- 					            Modal body -->
					            <div class="modal-body" id="body2">
					            
					              <label for="recipient-name" class="col-form-label">請輸入新密碼:</label>
	            				<input type="password" class="form-control" id="cusPwd" name="password">
	            				
	            				<label for="recipient-name" class="col-form-label">確認新密碼:</label>
	            				<input type="password" class="form-control" id="cusPwd-comfirm" name="password2">
	            				<input type="hidden" class="form-control" name="userId" id="checkCusId" value="${cusInfomation.userId}">
	            				<span id="confirm_message"></span>
					            </div>
					            				            
<!-- 					            Modal footer -->
					            <div class="modal-footer" id="footer2">
					              <button type="button" class="btn btn-light" data-dismiss="modal" id="cancelBtn">取消</button>
	        						<button type="button" class="btn btn-warning"  id="updataBtn" data-dismiss="modal" disabled="disabled">送出</button>
					            </div>
					            
					          </div>
					        </div>
					      </div>	      
					 </form>
					 
					 
<!-- footer star-->
<jsp:include page="layout/footer.jsp" />
<!-- footer end-->
						
	<!--/row-->	
	
	<!-- script -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
<!--     <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script> 000000000000000000000-->
	<script src="${contextRoot}/js/jquery-ui.min.js"></script>
	<script src="https://kit.fontawesome.com/ca70cd7f9d.js" crossorigin="anonymous"></script>
	
	
	<script type="text/javascript">
	

		
	$(document).ready(function() {
			
			//確認會員修改密碼
			
				$('#originPwd').on('blur',function(){
					let pwd =this.value;
					let id = $('#checkCusId').val();
					
					$.ajax({
						url:"${contextRoot}/checkPwd",
						contentType:"application/x-www-form-urlencoded; charset=UTF-8",
						dataType:"json",
		                method:"post",
						data:{
							"password":pwd,
							"userId":id
						},
						 success:function(result){
							 if(result==true){
			                        $('#pwdmsg').remove()
			                        $('#nextBtn').remove()
			                        $('#checkpwd').append('<span id="pwdmsg">請點擊確認，並完成步驟</span>').css({'color':'green','font-size':'10px'})                    
			                        $('#footer1').append('<button type="button" id="nextBtn" class="btn btn-warning" data-dismiss="modal" data-toggle="modal" data-target="#myModal2">下一步</button>')
			                        
			                    }else{
			                        $('#pwdmsg').remove() 
			                         $('#nextBtn').remove()
			                        $('#checkpwd').append('<span id="pwdmsg">密碼錯誤，請再次輸入舊密碼</span>').css({'color':'red','font-size':'10px'})
			                        
			                    }
		                },
		                error:function(err){
		                    console.log(err);
							alert('發生錯誤')
		                }
					})
				})
				
				

					
			
				$('#cusPwd-comfirm').keyup(function(){
		            let password = document.getElementById('cusPwd').value
		            let check = document.getElementById('cusPwd-comfirm').value
		            if(password == check){
		                document.getElementById('updataBtn').disabled=false
		                $('#showMsg').remove()
		                $('#confirm_message').append('<span id="showMsg">密碼確認完成</span>').css({'color':'green','font-size':'10px'}) 
		            }else{
		                document.getElementById('updataBtn').disabled=true
		                $('#showMsg').remove()
		                $('#confirm_message').append('<span id="showMsg">密碼確認錯誤</span>').css({'color':'red','font-size':'10px'}) 
		            }
		        })
		        
		        
		        $('#change-password').click(function(){
					
					$('#pwdmsg').remove();
					$('#nextBtn').remove();
					$('#complete').remove();
					$('#showMsg').remove();
					$('#originPwd').val('');
					$('#cusPwd').val('');
					$('#cusPwd-comfirm').val('');

				})
			
				//UpdatePassword
				$('#updataBtn').click(function() {
					let pwd = $('#cusPwd').val();
					let id = $('#checkCusId').val();
					
					
					$.ajax({
						url:"${contextRoot}/updatePwd",
						contentType:"application/x-www-form-urlencoded; charset=UTF-8",
						dataType:"json",
		                method:"post",
		                data:{
		                	"password":pwd,
		                	"userId":id
		                },
		                success:function(){

		                	 setTimeout(function(){alert('修改成功')},1000);
							
		                },
		                error:function(err){
		                	console.log(err);
							alert('錯誤')
		                }
					})
					
				});
			
				

				//避免上一頁返回
		        function preventBack() { 
		            window.history.forward();  
		        } 
		          
		        setTimeout("preventBack()", 0); 
		          
		        window.onunload = function () { null }; 
		        
		       
		      //生日日期欄位
		        $("#datepicker").datepicker({ 
		        	dateFormat: 'yy-mm-dd', 
		        	
		        	//可使用下拉式選單 - 月份
		            changeMonth : true,
		            //可使用下拉式選單 - 年份
		            changeYear : true,
		            //設定 下拉式選單月份 在 年份的後面
		            showMonthAfterYear : true,
		        	yearRange : "1980:2030",
		        	showAnim : "fade",
		        	showOptions : {
		        	        direction : "up",
		        	        opacity : 0.1
		        	      },
		        	      //設定日期框展開動畫的時間,default ： mormal
		        	      //可設定:slow、normal、fast、''空值代表立刻、數字代表毫秒
		        	      duration:"1000"

		        });
		      
		      
		      //照片上傳時再附上name
		      $("#photo").change(function(){
				  document.getElementById('photo').name="profilephoto"
			  })
			  
			  //單純解決bootstrap4 modal的bug
			  $('.modal').on('shown.bs.modal', function (e) {
		  		$("body").addClass("modal-open")
			  });
		      
		      //上傳圖片
// 		      $('#uploadAvatar').change(function(){
// 		    	  alert('上傳成功')
// 		    	  $('.avatar').remove()
// 		    	  $('#showAvatar').remove()
		    	 
		    	  
// 		    	  var myFile = $('#photo').prop('files');
// 		    	  alert('aaaa')
// 		    	 console.log(myFile)
// 		          var showAvatar = ''
// 		        	  showAvatar +='<img id="showAvatar" src="'+URL.creatObjectURL(myFile)+'"class="rounded-circle shadow-4 avatar" alt="Avatar">'
// 		          $('.showAvatar').append(showAvatar)
// 		      })
		      
		      $('#uploadAvatar').change(function(){
		          $('.avatar').remove()
		    	  $('#showAvatar').remove()
		            var file = document.getElementById('photo').files
		            console.log(file)
		            var showImg = ''
		            $.each(file,function(index,value){
		                showImg += '<img id="showAvatar" src="'+URL.createObjectURL(value)+'" class="rounded-circle shadow-4 avatar" alt="Avatar">'
		            })
		            $('.showAvatar').append(showImg)
		        })


		});
	
	
	  
	</script>


</body>
</html>