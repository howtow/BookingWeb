<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<meta charset="UTF-8">

<title>Formosa Booking</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="${contextRoot}/css/bootstrap.min.css">
<!-- main css -->
<link rel="stylesheet" href="${contextRoot}/css/checkMailStyle.css">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

</head>


<body>

	<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	
	response.setDateHeader("Expires", -1);
	%>

   <div class="container-fluid">
        <div class="row col-lg-12">
            <div class="bubbles">
                <span style="--i:11;"></span>
                <span style="--i:12;"></span>
                <span style="--i:22;"></span>
                <span style="--i:15;"></span>
                <span style="--i:16;"></span>
                <span style="--i:5;"></span>
                <span style="--i:29;"></span>
                <span style="--i:10;"></span>
                <span style="--i:18;"></span>
                <span style="--i:23;"></span>
                <span style="--i:25;"></span>
                <span style="--i:17;"></span>
                <span style="--i:14;"></span>
                <span style="--i:19;"></span>
                <span style="--i:20;"></span>
                <span style="--i:13;"></span>
                <span style="--i:26;"></span>
                <span style="--i:10;"></span>
                <span style="--i:27;"></span>
                <span style="--i:29;"></span>
                <span style="--i:30;"></span>
                <span style="--i:32;"></span>
                <span style="--i:28;"></span>
                <span style="--i:11;"></span>
                <span style="--i:22;"></span>
                <span style="--i:21;"></span>
                <span style="--i:14;"></span>
                <span style="--i:13;"></span>
                <span style="--i:33;"></span>
                <span style="--i:23;"></span>
                <span style="--i:36;"></span>
                <span style="--i:32;"></span>
                <span style="--i:11;"></span>
                <span style="--i:22;"></span>
                <span style="--i:23;"></span>
                <span style="--i:37;"></span>
                <span style="--i:19;"></span>
                <span style="--i:12;"></span>
                <span style="--i:13;"></span>
                <span style="--i:21;"></span>
                <span style="--i:26;"></span>
                <span style="--i:28;"></span>
                <span style="--i:13;"></span>
                <span style="--i:11;"></span>
                <span style="--i:21;"></span>
                <span style="--i:18;"></span>
                <span style="--i:23;"></span>
                <span style="--i:12;"></span>
                <span style="--i:39;"></span>
            </div>
        </div>
        </div>
        
	           <div class="center">
            <form action="upadateEdit" method="post">
                <div class="form">
                    <div class="brand">
                        <a href="${contextRoot}/"><img src="${contextRoot}/image/logo.png" alt=""></a>
                    </div>
                    <!-- ${contextRoot}/image/ -->
                    <div class="form-element">
    
                        <input type="password" id="password-field" class="input-control"
                            placeholder="New Password" name="password" pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"
                            title="至少八個字符，至少含一個字母和一個數字" value="" required>
    
                        <div class="toggle-password">
                            <!-- <i class="fa fa-eye"></i> -->
                            <i class="fa fa-eye showHideIcon"></i>
                        </div>
                        <div class="password-policies">
                            <div class="policy-number">
                                8-16 英數字
                            </div>
                            <div class="policy-english">
                                包含一個英文字母
                            </div>
                            <div class="policy-integer">
                                包含一個數字
                            </div>
                        </div>
    
                        <input type="password" id="check-password-field" placeholder="Comfirm New Password" name="password2"
                            pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$" value="">
                       <span id="message"> </span>
    
                    </div>
                    <div class="button1">
                    	<button type="submit" class=" btn btn-outline-light">確認</button>
                    	 <input type="hidden" name="code" value="${customerInfo.verificationCode}">
                       
                    </div>
                </div>
            </form>
        </div>

            <!-- ------------------js------------------- -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="${contextRoot}/js/popper.js"></script>
		<script src="${contextRoot}/js/bootstrap.min.js"></script>
		 <script>

            $(function () {
                $(".showHideIcon").click(function (event) {
                    $(this).toggleClass("fa-eye-slash");
                    var x = $(".input-control").attr("type");//getting attribute in variable

                    if (x != "password") {
                        $(".input-control").attr("type", "password");
                    } else
                        $(".input-control").attr("type", "text");

                })
            })
            
            
            $('#password-field, #check-password-field').on('keyup', function() {
			if ($('#password-field').val() == $('#check-password-field').val()) {
				$('#message').html('確認密碼相符').css({
					'color' : '#4fc3dc',
					'font-size' : '10px'
				});
			} else
				$('#message').html('確認密碼不相符').css({
					'color' : '#ff2d75',
					'font-size' : '10px'
				});
		});

            // $(function(){
            //     $("#password-field").focus(function(event){
            //         $(this).addclass("active");
            //     })
            // })

            // $(function(){
            //     $("#password-field").blur(function(event){
            //         $(this).removeClass("active");
            //     })
            // })
             function _id(name) {
                return document.getElementById(name);
            }
            function _class(name) {
                return document.getElementsByClassName(name);
            }


            _id("password-field").addEventListener("focus", function () {
                _class("password-policies")[0].classList.add("active");
            });
            _id("password-field").addEventListener("blur", function () {
                _class("password-policies")[0].classList.remove("active");
            });
            
            _id("password-field").addEventListener("keyup", function () {
                let password = _id("password-field").value;
                let regex_number="{8,16}"

               if((/^(?=.*\d).{8,16}$/).test(password)) {
                    _class("policy-number")[0].classList.add("active");
                }else{
                    _class("policy-number")[0].classList.remove("active");
                }
                if(/[a-zA-Z]/.test(password)) {
                    _class("policy-english")[0].classList.add("active");
                }else{
                    _class("policy-english")[0].classList.remove("active");
                }
                
                if(/[0-9]/.test(password)) {
                    _class("policy-integer")[0].classList.add("active");
                }else{
                    _class("policy-integer")[0].classList.remove("active");
                }
            });
            
            
          //避免上一頁返回
            function preventBack() { 
                window.history.forward();  
            } 
              
            setTimeout("preventBack()", 0); 
              
            window.onunload = function () { null }; 
            

        </script>

</body>
</html>