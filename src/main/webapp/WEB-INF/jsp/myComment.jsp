<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<jsp:include page="layout/default.jsp" />
<head>
<meta charset="UTF-8">
<title>我的評論</title>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
</head>
<!-- Style -->
<link rel="stylesheet" href="${contextRoot}/css/bootstrap.min.css">

<link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">   
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="https://cdn.datatables.net/1.11.3/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.2.9/css/responsive.bootstrap4.min.css">
<!-- <link href="https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css"rel="stylesheet"> -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"rel="stylesheet">

<link rel="stylesheet" href="${contextRoot}/css/jquery-ui.min.css">
<link rel="stylesheet" href="${contextRoot}/css/myOrderInfoStyle.css">
 
<!------ Include the above in your HEAD tag ---------->
<style>

.tableComment{

height:100vh;

}


</style>
<body>
	<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.setDateHeader("Expires", -1);
	%>

	<!-- 	<div class="container mr-0"> -->
	<!-- 		<div class="d-flex flex-row-reverse"> -->

	<!-- 			<div class="p-2"> -->
	<%-- 				<a href="sortCommentByDesc?userId=${loginCustomer.userId}" style="color:#aaa;text-decoration:none;"onmouseover="this.style.color='orange';" onmouseout="this.style.color='#aaa';" >依降冪排序 <i class="fa fa-sort-amount-desc" aria-hidden="true"></i></a> --%>
	<!-- 			</div> -->

	<!-- 		</div> -->
	<!-- 	</div> -->

	<div class="container tableComment">
		<div class="row">

			<div class="col-2"></div>

			<div class="col-8 mt-5 mb-5">
				<table id="table_id"
					class="table table-striped table-bordered dt-responsive nowrap "
					style="border-radius: 5px; width: 100%;">
					<thead>
						<tr>
							<th data-field="bookingId">訂單號碼</th>
							<th data-field="comment">評論內容</th>
<!-- 							<th data-field="editComment">修改</th> -->
<!-- 							<th data-field="delComment">刪除</th> -->
						</tr>
					</thead>

					<tbody>
						<c:forEach var="cm" items="${CommentList}">
							<tr>
								<td id="bookingId">${cm.bookingId}</td>
								<td id="comment">${cm.comment}</td>
<%-- 								<td><a href="editComment?commentId=${cm.commentId}" ></i></a></td> --%>
<%-- 								<td><a href="editComment?commentId=${cm.commentId}"><i class="fa fa-pencil"aria-hidden="true"></i></a></td> --%>
<%-- 								<td><a href="delComment?commentId=${cm.commentId}"><i class="fa fa-trash" aria-hidden="true"></i></a></td> --%>
<!-- 								<td> -->
<!-- 									<a href="#" class="cancel" data-toggle="modal" data-target="#delete-comfirm" id="deleteBtn"><i class="fa fa-trash" aria-hidden="true"></i></a> -->
<%-- 									<input type="hidden" value="${cm.bookingId}" id="delete-bkId"> --%>
<!-- 								</td> -->
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="col-2"></div>
		</div>
	</div>
	
	
		<!-- Modal 刪除確認 --> 
	<div class="modal fade" id="delete-comfirm" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	 <form action="deleComment">
	      <div class="modal-header">
	        <h5 class="modal-title" id="staticBackdropLabel">刪除評論</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	     
	      <div class="modal-body">
	        <span>確認刪除本筆評論?</span>
	        <input type="text" id="modal-deleteBkId" value="" name="bookingId">
	        <input type="text" id="modal-deleteUserId" value="" name="userId">
	      </div>
	      </form>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
	        <button type="submit" class="btn btn-primary" data-dismiss="modal">確認</button>
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
		
	$('.cancel').click(function(){
		 let bookingId=$(this).parent().find('#delete-bkId').val()
		 let userId = '${sessionScope.loginCustomer.userId}';
		
		 alert(bookingId);
		 alert(userId);
		 $('#delete-comfirm #modal-deleteBkId').val(bookingId)
		 $('#delete-comfirm #modal-deleteUserId').val(userId)
	})
	
	
	$('#table_id').DataTable(
			{

		// 參數設定[註1]
		'lengthMenu' : [ 3, 5 ],
		'pageLength' : '5',
		'responsive' : true, //預設為undefined
		 'searching': false,
		//設定欄位元素定義區塊
		language : {
		url : 'https://cdn.datatables.net/plug-ins/1.11.3/i18n/zh_Hant.json'
			}
	});
	
})
</script>
	

</body>
</html>