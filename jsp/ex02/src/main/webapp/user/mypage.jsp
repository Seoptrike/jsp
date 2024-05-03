<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="row justify-content-center">
	<div class="col-8 col-md-6 col-lg-4">
		<h1>마이페이지</h1>
		<div class="card">
			<div class="card-body">
				<div class='mb-3'>이름 : ${user.uname}( ${user.uid} ) 
				</div>
				<div class='mb-3'>
					주소 : ${user.address1} ${user.address2}  
				</div>
				<div class='mb-3'>
					전화 : ${user.phone}  
				</div>
				<div>
					가입일 : <fmt:formatDate value= "${user.jdate}" pattern= "yyyy년MM월dd일 HH:mm:ss"/>
				</div>
				<div>
					수정일 : <fmt:formatDate value= "${user.udate}" pattern= "yyyy년MM월dd일 HH:mm:ss"/>
				</div>
				<div class="text-center my-3">
					<span><button id=btnPass class= "btn btn-danger w-20">비밀번호 변경</button></span>
					<span><button id=btnInfo class= "btn btn-warning w-30">정보수정</button></span>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="modal_info.jsp"/>
	<jsp:include page="modal_pass.jsp"/>
</div>

<script>
	$("#btnInfo").on("click",function(){
		$("#modalInfo").modal("show");
	});
	$("#btnPass").on("click",function(){
		$("#modalPass").modal("show");
	});
</script>