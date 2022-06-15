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

</head>


<body>
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
        
         
            <div class="jumbotron bg-info text-white text-center ">
                <h1 class="display-5">Oops! ${pageTitle} 請確認是否已完成驗證或重新申請</h1>
                <h1 class="display-5"> It Seen Gmail Verification Failed </h1>
                <p class="lead">
                    Please Confirm If Verification Has Been Completed Or Reapply
                </p>
                
					<br/>
               <a href="${contextRoot}/" class="btn btn-outline-light">Go Back</a>

               </div>
           </div> 

            <!-- ------------------js------------------- -->
        <script src="${contextRoot}/js/popper.js"></script>
		<script src="${contextRoot}/js/bootstrap.min.js"></script>

</body>
</html>