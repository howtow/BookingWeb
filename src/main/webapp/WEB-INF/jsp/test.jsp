<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Up</title>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<link rel="stylesheet" type="text/css" href="${contextRoot}/css/bootstrap.min.css" />
<!--=====Inconscout CSS-->
<link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
<!--=====CSS=====-->
<link rel="stylesheet" href="${contextRoot}/css/registeration.css">

</head>
<body>
	<!-- ======Login Form ====== -->
	<div class="container">
		<div class="forms">
			<div class="form login">
				<span class="title">會員登入</span>
				<!-- 表單 start -->
				<form action="#" method=post>
					<div class="input-field ">
						<input type="text" placeholder="請輸入電子郵件" required> <i
							class="uil uil-envelope icon"></i>
					</div>
					<div class="input-field">
						<input type="password" class="password" placeholder="請輸入密碼"
							required> <i class="uil uil-lock icon"></i> <i
							class="uil uil-eye-slash showHideIcon"></i>
					</div>

					<div class="checkbox-text">
						<div class="checkbox-content">
							<input type="checkbox" id="logCheck"> <label
								for="logCheck" class="text">記住我</label>
						</div>

						<a href="#" class="text">忘記密碼?</a>
					</div>

					<div class="input-field loginBtn">
						<input type="button" value="登入">
					</div>

				</form>
				<!-- 表單 end -->

				<div class="login-signup">
					<span class="text">尚未成為會員? <a href="#"
						class="text signup-text">註冊</a>
					</span>
				</div>
			</div>
			<!-- ======Login Form end====== -->


			<!-- ======registeration Form ====== -->
			<div class="form signup">
				<span class="title">加入會員</span>
				<!-- 表單 start -->
				<form action="#">
					<div class="row">
						<div class="col-11 input-field">
							<input type="text" placeholder="電子郵件" required> <i
								class="uil uil-envelope"></i>
						</div>
					</div>

					<div class="row">
						<div class="col-7 input-field">
							<input type="text" placeholder="姓名" required> <i
								class="uil uil-user"></i>
						</div>
						<div class="col-4 input-field">
							<input type="text" placeholder="性別" required> <i
								class="uil uil-lock"></i>
						</div>

					</div>

					<div class="row">
						<div class="col-5 input-field">
							<input type="password" class="password" placeholder="密碼" required>
							<i class="uil uil-lock"></i>
						</div>
						<div class="col-6 input-field">
							<input type="password" class="password" placeholder="確認密碼"
								required> <i class="uil uil-lock"></i> <i
								class="uil uil-eye-slash showHideIcon"></i>
						</div>
					</div>



					<div class="row">
						<div class="col-5 input-field">
							<input type="text" placeholder="電話" required> <i
								class="uil uil-phone"></i>
						</div>
						<div class="col-6 input-field">
							<input type="text" id="datepicker" placeholder="生日" required>
							<i class="uil uil-calender"></i>
						</div>

					</div>

					<div class="row">
						<div class="col-5 input-field">
							<input type="text" placeholder="國籍" required> <i
								class="uil uil-map"></i>
						</div>
						<div class="col-6 input-field">
							<input type="text" placeholder="城市" required> <i
								class="uil uil-location-pin-alt"></i>
						</div>
					</div>

					<div class="row">
						<div class="col-11 input-field">
							<input type="text" placeholder="地址" required> <i
								class="uil uil-location-pin-alt"></i>
						</div>
					</div>

					<div class="row">
						<div class="col-11 input-field">
							<input type="text" placeholder="信用卡帳號" required> <i
								class="uil uil-credit-card"></i>
						</div>
					</div>
					<div class="row">
						<div class=" col-11 input-field loginBtn">
							<input type="button" value="註冊">
						</div>
					</div>
				</form>
				<!-- 表單 start -->

				<div class=" login-signup">
					<span class="text"> <a href="index.html" class="col-4">回到首頁</a>
						<a href="#" class="col-5 text login-link ">會員登入</a>
					</span>
				</div>
			</div>
			<!-- ======registeration Form end ====== -->
		</div>
	</div>
	<script src="${contextRoot}/js/registeration.js"></script>

	<script src="${contextRoot}/js/jquery.min.js"></script>
	<script src="${contextRoot}/js/bootstrap.min.js"></script>
</body>
</html>