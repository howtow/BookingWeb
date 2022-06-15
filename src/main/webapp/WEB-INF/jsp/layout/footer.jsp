<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!-- Bootstrap CSS -->

<link rel="stylesheet" href="${contextRoot}/css/bootstrap.min.css">


<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- main css -->

<link rel="stylesheet" href="${contextRoot}/css/footerStyle.css">
<link rel="stylesheet" href="${contextRoot}/css/responsive.css">
<script src="https://kit.fontawesome.com/ca70cd7f9d.js"
	crossorigin="anonymous"></script>
<!-- jquery-ui -->
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
</head>


<body>
    
    
    <footer class="footer-area section_gap">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="single-footer-widget">
                        <h6 class="footer_title">Contact Us</h6>
                        <div class="row">
                            <div class="col-10">
                                <ul class="list_style">
                                    <li>電話: (+886)xxx-xxxxxx</li>
                                    <li>地址: 台南市O區O路O號O樓</li>
                                    <li>Email: Formosa@gmail.com</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="single-footer-widget">
                        <h6 class="footer_title">訂閱電子報</h6>
                        <p>歡迎訂閱電子報獲得更多優惠訊息</p>
                        <div id="mc_embed_signup">
                            <form target="_blank"
                                action=""
                                method="get" class="subscribe_form relative">
                                <div class="input-group d-flex flex-row">
                                    <input name="EMAIL" placeholder="Email Address" onfocus="this.placeholder = ''"
                                        onblur="this.placeholder = 'Email Address '" required="" type="email">
                                    <button class="btn sub-btn">
										<i class="fa-solid fa-paper-plane"></i>
									</button>
                                </div>
                                <div class="mt-10 info"></div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="border_line"></div>
            <div class="row footer-bottom d-flex justify-content-between align-items-center">
                <p class="col-lg-8 col-sm-12 footer-text m-0">

                    Copyright &copy;
                    <script>document.write(new Date().getFullYear());</script> All rights reserved | <span>Formosa
                        Booking</span>
                </p>
               
            </div>
        </div>
    </footer>
    <!--================ End footer Area  =================-->


   
    <!-- jQuery先,再來 Popper.js, then Bootstrap JS -->
  
 
    <!--日期選單-->
    <script src="vendors/bootstrap-datepicker/bootstrap-datetimepicker.min.js"></script>
    <!--下拉選單-->
    <script src="vendors/nice-select/js/jquery.nice-select.js"></script>


</body>
</html>