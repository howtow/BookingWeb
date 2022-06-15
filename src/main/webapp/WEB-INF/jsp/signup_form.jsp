<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Up</title>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<link rel="stylesheet" type="text/css"
	href="${contextRoot}/css/bootstrap.min.css" />
<!--=====Inconscout CSS-->
<link rel="stylesheet"
	href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
<!--=====CSS=====-->
<link rel="stylesheet" href="${contextRoot}/css/registeration.css">

<link rel="stylesheet" href="${contextRoot}/css/jquery-ui.min.css">

<!-- <link rel="stylesheet" -->
<!-- 	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css"> -->

<style type="text/css">

#sending{
	width:200px; 
	height:60px;
    border-radius: 10px;
    border: none;
    color: rgb(171, 169, 151);
	text-align: center;
	margin: auto;
    font-weight: 900;
    font-size: 16px;
	}

dialog div{
    color:#4fc3dc;
  }
</style>

</head>
<body>
	<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.setDateHeader("Expires", -1);
	%>
	<!-- ======Login Form ====== -->
	<div class="container">
		<div class="forms">
			<div class="form login">
				<span class="title">會員登入</span>
				<!-- 登入表單 start -->
				<form action="signIn" method="post">
					<div class="input-field ">
						<input type="text" placeholder="請輸入電子郵件" name="email" required>
						<i class="uil uil-envelope icon"></i>
					</div>
					<div class="input-field">
						<input type="password" class="password" placeholder="請輸入密碼"
							name="password" required> <i class="uil uil-lock icon"></i>
						<i class="uil uil-eye-slash showHideIcon"></i>
					</div>

					<div class="checkbox-text">
						<div class="checkbox-content">
							<input type="checkbox" id="logCheck"> <label
								for="logCheck" class="text">記住我</label>
						</div>
						<a href="#" class="text" data-toggle="modal" data-target="#exampleModal" data-whatever="@getbootstrap">忘記密碼?</a>
					</div>

					<div class="loginError">
						<c:choose>
							<c:when test="${loginError != null}">

								<p class="text-danger">${loginError}</p>
							</c:when>
							<c:when test="${logoutMessage != null}">

								<p class="text-danger">${logoutMessage}</p>
							</c:when>
							<c:when test="${signUpError != null}">
								<c:forEach var="error" items="${signUpError}">
									<p class="text-danger">${error}</p>
								</c:forEach>
							</c:when>
							<c:when test="${updateSuccee != null}">
								
									<p class="text-success">${updateSuccee}</p>
								
							</c:when>
							<c:when test="${sendMessage != null}">
								
									<p class="text-danger">${sendMessage}</p>
								
							</c:when>
							<c:when test="${mailCheckMessage != null}">
								
									<p class="text-success">${mailCheckMessage}</p>
								
							</c:when>
						</c:choose>

					</div>

					<div class="input-field loginBtn">
						<input type="submit" value="登入">
					</div>

				</form>
				<!-- 表單 end -->

				<div class="login-signup">
					<span class="text">尚未成為會員? <a href="#"
						class="text signup-text">註冊</a>
					</span>
				</div>
				<div class="d-flex justify-content-center mt-2">
					<span class="text"> <a href="${contextRoot}/">回到首頁</a></span>
				</div>

			</div>
			<!-- ======Login Form end====== -->


			<!-- ======registeration Form ====== -->
			<div class="form signup">
				<span class="title">加入會員</span>
				<!-- 表單 start -->
				<form action="process_register" method="post">

					<div class="row">
						<div class="col-7 input-field">
							<input type="text" placeholder="姓名" name="userName"
								pattern="^[\u4E00-\u9FA5A-Za-z\s]+(·[\u4E00-\u9FA5A-Za-z]+)*$"
								title="請輸入中文或英文姓名" autocomplete="off" required> <i class="uil uil-user"></i>
						</div>
						<div class="col-4 input-field">
							<input type="text" placeholder="性別" name="gender" required>
							<i class="uil uil-heart"></i>
						</div>
					</div>
					
					<div class="row">
						<div class="col-11 input-field">
							<input type="text" placeholder="電子郵件" name="email" size="25" id="mail" 
									maxlength="100" pattern="^[_a-z0-9-]+([.][_a-z0-9-]+)*@[a-z0-9-]+([.][a-z0-9-]+)*$" 
									title="請符合正確Email格式" autocomplete="off" required> 
							<i class="uil uil-envelope"></i> 
						</div>
							<span class="col-5" id="mailMessage"></span>
					</div>
					

					<div class="row">
						<div class="col-5 input-field">
							<input type="password" class="password" id="password"
								placeholder="密碼" name="password"
								pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"
								title="至少八個字符，至少含一個字母和一個數字" required> <i
								class="uil uil-lock"></i>
						</div>
						<div class="col-6 input-field">
							<input type="password" class="confirm_password"
								id="confirm_password" placeholder="確認密碼" name="password2"
								pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"
								title="至少八個字符，至少含一個字母和一個數字" required> <i
								class="uil uil-lock"></i> <i
								class="uil uil-eye-slash showHideIcon"></i>
						</div>
						<span class="col-5" id="message"></span>
					</div>
					
					<div class="row">
						<div class="col-5 input-field">
							<input type="text" placeholder="電話" name="phone" autocomplete="off" required>
							<i class="uil uil-phone"></i>
						</div>

						<div class="col-6 input-field">
							<input type="text" id="datepicker" placeholder="生日"
								name="birthday" autocomplete="off" required> <i class="uil uil-calender"></i>
						</div>

						<!-- 						<div class="col-6 input-field"> -->
						<!-- 							<input id="date" type="date" name="birthday" required> -->
						<!-- 							<i class="uil uil-gift"></i> -->
						<!-- 						</div> -->


					</div>

					<div class="row">
						<div class="col-5 input-field">
							<input type="text" placeholder="國籍" name="nationality" required>
							<i class="uil uil-map"></i>
						</div>
						<div class="col-6 input-field">
							<input type="text" placeholder="城市" name="state" required>
							<i class="uil uil-location-pin-alt"></i>
						</div>
					</div>

					<div class="row">
						<div class="col-11 input-field">
							<input type="text" placeholder="地址" name="address" required>
							<i class="uil uil-location-pin-alt"></i>
						</div>
					</div>

					<div class="row">
						<div class="col-11 input-field">
							<input type="text" placeholder="信用卡帳號" name="creditCard" autocomplete="off" required>
							<i class="uil uil-credit-card"></i>
						</div>
					</div>



					<div class="row">
						<div class=" col-11 input-field loginBtn">
							<input type="submit" value="註冊" id="registBtn" disabled="disabled" >
						</div>
					</div>
				</form>
				<!-- 表單 start -->

				<div class=" login-signup">
					<span class="text"> <a href="${contextRoot}/" class="col-4">回到首頁</a>
						<a href="#" class="col-5 text login-link ">會員登入</a>
					</span>
				</div>
			</div>
			<!-- ======registeration Form end ====== -->
		</div>
	</div>
	
	<!-- 忘記密碼表單 -->

	<form action="findPwd" method="post">
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">忘記密碼 ?</h5>
	        
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <form>
	          <div class="form-group">
	            <label for="recipient-name" class="col-form-label"><i class="uil uil-envelope emailmodal"></i>&nbsp請輸入您的Email後點擊空白處&nbsp:</label>
	            <input type="text" class="form-control" id="cusEmail" name="email" autocomplete="off">
	          </div>
	          
	   
 			<div>
	          	<span id="checkMail"></span>
	          </div>

	         
	        </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-light" data-dismiss="modal">取消</button>
	        <button type="submit" class="btn btn-warning" id="forgotpwdBtn" disabled="disabled">確認</button>
	      </div>
	    </div>
	  </div>
	</div>
	</form>
	
	<div>
	 <dialog id="sending">
			<div>寄出驗證信件...</div>
		</dialog>
	</div>
	
<!-- script -->
	<script src="${contextRoot}/js/registeration.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="${contextRoot}/js/jquery-ui.min.js"></script>
	<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>

	<script type="text/javascript">
	
	$(document).ready(function(){
		
	 $("#datepicker").datepicker({ 
		 
		 dateFormat: 'yy/mm/dd',
		//可使用下拉式選單 - 月份
	     changeMonth : true,
	     //可使用下拉式選單 - 年份
	     changeYear : true,
	     //設定 下拉式選單月份 在 年份的後面
	     showMonthAfterYear : true,
	    
	     yearRange : "1980:2030",
	     showAnim : "fade",
	     
 
	 
	 });

	 
	 
	 $('#confirm_password').on('keyup', function() {
			if ($('#password').val() == $('#confirm_password').val()) {
				$('#message').html('密碼符合').css({
					'color' : 'green',
					'font-size' : '10px'
				});
			} else
				$('#message').html('密碼不符合').css({
					'color' : 'red',
					'font-size' : '10px'
				});
		});
		
	 
	 
		//註冊信箱確認重複
	
			$('#mail').on('blur', function(){
				let mail = this.value
				$.ajax({
					url:"http://localhost:8081/booking/checkMail",
					contentType:"application/x-www-form-urlencoded; charset=UTF-8",
					dataType:"json",
	                method:"post",
					data:{
						"mail":mail
					},
					 success:function(result){
						 if(result==true){
		                        $('#mailnote').remove()
		                        $('#mailMessage').append('<span id="mailnote">信箱可以使用</span>').css({'color':'green','font-size':'10px'})                    
		                        document.getElementById('registBtn').disabled=false
		                    }else{
		                        $('#mailnote').remove() 
		                        $('#mailMessage').append('<span id="mailnote">此信箱已被註冊使用</span>').css({'color':'red','font-size':'10px'})
		                        document.getElementById('registBtn').disabled=true
		                    }
	                },
	                error:function(err){
	                    console.log(err);
						alert('發生錯誤')
	                }
				})
			})
		
			
		//忘記密碼 信箱確認
	
			$('#cusEmail').on('blur', function(){
				let mail = this.value
				$.ajax({
					url:"http://localhost:8081/booking/checkMail",
					contentType:"application/x-www-form-urlencoded; charset=UTF-8",
					dataType:"json",
	                method:"post",
					data:{
						"mail":mail
					},
					 success:function(result){
						 if(result!=true){
		                        $('#mailmsg').remove()
		                        $('#checkMail').append('<span id="mailmsg">請按確認完成步驟</span>').css({'color':'green','font-size':'10px'})                    
		                        document.getElementById('forgotpwdBtn').disabled=false
		                    }else{
		                        $('#mailmsg').remove() 
		                        $('#checkMail').append('<span id="mailmsg">請輸入註冊信箱</span>').css({'color':'red','font-size':'10px'})
		                        document.getElementById('forgotpwdBtn').disabled=true
		                    }
	                },
	                error:function(err){
	                    console.log(err);
						alert('發生錯誤')
	                }
				})
			})
	
			
			$('#registBtn').on('click', function(){
				sending.showModal();
				setTimeout('sending.close();',5500);
			})
			
			
			
		})
		
	</script>


</body>
</html>